import React from "react"
import ReactDOM from 'react-dom';
import PropTypes from "prop-types"
import SuggestOptionsBar from "./SuggestOptionsBar"

const END_POINT  = "/stations/suggests?";
const RGX_STREET = /(rua|av|avenida|street)\s+/i;
const RGX_CITY   = /(cidade|vila|municipio|city|village)\s+/i;
class SuggestBar extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      items: []
    }

    this.resetState = this.resetState.bind(this);
    this.focusTextInput = this.focusTextInput.bind(this);
    this.handleKeyUp = this.handleKeyUp.bind(this);

    // window.addEventListener("FoundStation", this.resetState, false);
    $(document).on( "FoundStation", this.resetState);
  }
  resetState(e) {
    this.setState({items: []});
  }
  focusTextInput() {
    this.textInput.focus();
  }
  getInput () {
      return ReactDOM.findDOMNode(this.textInput).value;
  }
  handleKeyUp() {
    var letters = /^[A-Za-z\s]+$/;
    if(this.getInput().match(letters)){
      var params = "q=" + this.getInput();
      if(this.getInput().match(RGX_STREET)){
        const firstLetterIndex = RGX_STREET.exec(this.getInput())[0].length
        params = "street=" + this.getInput().substr(firstLetterIndex);
      }else if(this.getInput().match(RGX_CITY)){
        const firstLetterIndex = RGX_CITY.exec(this.getInput())[0].length
        params = "city=" + this.getInput().substr(firstLetterIndex);
      }
      fetch(END_POINT + params)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({items: result});
        },
        (error) => {
          console.error(error);
        }
      )
    }
  }
  render () {
    return (
      <React.Fragment>
        <input
          id="suggest-bar"
          ref={(input) => { this.textInput = input; }}
          onKeyUp={this.handleKeyUp}/>
        <SuggestOptionsBar items={this.state.items}/>
      </React.Fragment>
    );
  }
}

export default SuggestBar

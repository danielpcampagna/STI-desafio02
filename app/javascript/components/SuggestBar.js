import React from "react"
import ReactDOM from 'react-dom';
import PropTypes from "prop-types"
class SuggestBar extends React.Component {
	constructor(props){
		super(props);
		this.focusTextInput = this.focusTextInput.bind(this);
		this.handleKeyPress = this.handleKeyPress.bind(this);
	}
	focusTextInput() {
    this.textInput.focus();
  }
	getInput () {
	    return ReactDOM.findDOMNode(this.textInput).value;
	}
	handleKeyPress() {
		var letters = /^[A-Za-z\s]+$/;
		if(this.getInput().match(letters)){
			fetch("stations/suggests")
      .then(res => res.json())
      .then(
      	(result) => {
      		alert
      	}
      	(error) => {
          this.setState({
            isLoaded: true,
            error
          });
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
      		onKeyPress={this.handleKeyPress}/>
      </React.Fragment>
    );
  }
}

export default SuggestBar

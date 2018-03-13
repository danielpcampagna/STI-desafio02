import React from "react"
import PropTypes from "prop-types"
class SuggestOptionItem extends React.Component {
	constructor(props){
		super(props);
		this.state = {
			street: this.props.data.street,
			city:   this.props.data.city,
			state:  this.props.data.state,
			href:   "stations/search?lat=" + this.props.data.lat + "&lon=" + this.props.data.lon
		}
    this.searchStation = this.searchStation.bind(this);
	}
  searchStation() {
    fetch(this.state.href)
    .then(res => res.json())
    .then(
      (result) => {
        //Dispatch an event
        var evt = new CustomEvent("FoundStation", result);
        window.dispatchEvent(evt);
      },
      (error) => {
        console.err(error);
      }
    )
  }
  render () {
    return (
      <React.Fragment>
      	<button onClick={this.searchStation}>
      		<strong>{this.state.street}</strong>
      		<p>{this.state.city} - {this.state.state}</p>
      	</button>
      </React.Fragment>
    );
  }
}

export default SuggestOptionItem

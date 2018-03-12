import React from "react"
import PropTypes from "prop-types"
class SuggestOptionItem extends React.Component {
	constructor(props){
		super(props);
		this.state = {
			street: this.props.data.street,
			city:   this.props.data.city,
			state:  this.props.data.state,
		}
	}
  render () {
    return (
      <React.Fragment>
      	<a href="">
      		<strong>{this.state.street}</strong>
      		<p>cidade: {this.state.city} - {this.state.state}</p>
      	</a>
      </React.Fragment>
    );
  }
}

export default SuggestOptionItem

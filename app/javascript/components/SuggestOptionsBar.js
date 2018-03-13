import React from "react"
import PropTypes from "prop-types"

import SuggestOptionItem from "./SuggestOptionItem"
class SuggestOptionsBar extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div>
          {this.props.items.map(function(i){
            if(i.street == undefined || i.street == null){
              return undefined
            }
            return <li><SuggestOptionItem data={i}/></li>
          })}
        </div>
      </React.Fragment>
    );
  }
}

export default SuggestOptionsBar

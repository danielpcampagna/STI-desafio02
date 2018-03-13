import React from "react"
import PropTypes from "prop-types"
class StationsTable extends React.Component {
	constructor(props){
		super(props);
		this.state = {
			stations: this.props.stations
		};

		this.selectStations = this.selectStations.bind(this);

		// window.addEventListener("FoundStation", this.selectStations, false);
		$(document).on( "FoundStation", this.selectStations);
	}

	selectStations(e,data){
		console.log(data);
		this.setState({stations: [data.station]});
	}

  render () {
    return (
      <React.Fragment>
      	<h1>Stations</h1>
		<table>
		  <thead>
		    <tr>
		      <th>Neighborhood</th>
		      <th>Station</th>
		      <th>Code</th>
		      <th>Address</th>
		      <th>Number</th>
		      <th>Latitude</th>
		      <th>Longitude</th>
		      <th colSpan="3"></th>
		    </tr>
		  </thead>

		  <tbody>
		    {this.state.stations.map(function(station){
		      return (<tr>
		      		        <td>{station.neighborhood}</td>
		      		        <td>{station.station}</td>
		      		        <td> {station.code} </td>
		      		        <td> {station.address} </td>
		      		        <td> {station.number} </td>
		      		        <td> {station.latitude} </td>
		      		        <td> {station.longitude} </td>
		      		        <td> <a href="stations/{stations.id}"> show </a> </td>
		      		        <td> <a href="stations/{stations.id}/edit"> edit </a> </td>
		      		      </tr>);
		    })}
		  </tbody>
		</table>
      </React.Fragment>
    );
  }
}

export default StationsTable

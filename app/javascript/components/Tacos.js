import React from "react"
import PropTypes from "prop-types"
class Tacos extends React.Component {
  render () {
    return (
      <div>
        <h1>Tacos!!</h1>
        <ul>
          {this.props.tacos.map(taco => (
            <li key={taco.id}>{`${taco.name} ${taco.description}`}</li>
          ))}
        </ul>
      </div>
    );
  }
}

Tacos.propTypes = {
  tacos: PropTypes.array
};
export default Tacos

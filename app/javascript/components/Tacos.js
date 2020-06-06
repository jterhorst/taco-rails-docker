import React from "react"
import PropTypes from "prop-types"

/**
 * Component for showing list of tacos.
 * 
 * @component
 * @example
 * const title = "Awesome Taco List"
 * const tacos = []
 * return (
 *   <Tacos title={title} tacos={tacos} />
 * )
 */
class Tacos extends React.Component {
  render () {
    return (
      <div>
        <h1>{this.props.title}</h1>
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
    title: PropTypes.string.isRequired,
    tacos: PropTypes.array.isRequired,
};

Tacos.defaultProps = {
    title: 'Tacos',
    tacos: [],
}

export default Tacos

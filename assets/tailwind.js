module.exports = {
  theme: {
    extend: {
      backgroundColor: theme => ({
        'primary': '#2b79c1',
        'primary-dark': '#266299',
        'secondary': '#ffed4a',
        'danger': '#e3342f',
      }),
      colors: {
        'primary': '#2b79c1',
        'primary-dark': '#155085',
        'transparent': 'transparent',
        'danger': '#e3342f',
      },
    }
  },
  variants: {
    borderWidth: ['responsive', 'hover', 'focus'],
    padding: ['responsive', 'hover', 'focus'],
    borderColor: ['responsive', 'hover', 'focus', 'active', 'group-hover']
  },
  plugins: []
}

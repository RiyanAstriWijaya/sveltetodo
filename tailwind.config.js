/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/**/*.{html,js,svelte,ts}',
    './node_modules/preline/preline.js',
  ],
  theme: {
    extend: {
      fontFamily: {
        Oswald: ['Oswald'],
        'Jersey 15': ['Jersey 15'],
        sans: ['Arial', 'sans-serif'],
        serif: ['Merriweather', 'serif'],
        mono: ['Roboto Mono', 'monospace'],
      },
    },
  },
  plugins: [
    require('preline/plugin'),
    require('@tailwindcss/forms'),
  ],
  darkMode: 'class'
}


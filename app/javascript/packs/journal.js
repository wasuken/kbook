import {
  Elm
} from '../Journal'

document.addEventListener('DOMContentLoaded', () => {
  const target = document.createElement('div')

  document.body.appendChild(target)
  Elm.Main.init({
    node: target
  })
})

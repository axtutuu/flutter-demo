import { useState } from 'react'

function CookieView () {
  const [cookie, setCookie] = useState('')

  const getCookie = () => {
    setCookie(document.cookie)
  }

  return (
    <div>
      <h1>CookieView</h1>
      <button onClick={getCookie}>Get Cookie</button>
      <div>{cookie}</div>
    </div>
  )
}

export default CookieView
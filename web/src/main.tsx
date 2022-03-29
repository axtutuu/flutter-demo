import React from 'react'
import ReactDOM from 'react-dom'
import './index.css'
import { BrowserRouter, Routes, Route } from "react-router-dom"
import App from './App'
import NFC from './views/nfc'
import Cookie from './views/cookie'

ReactDOM.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route index element={<App />} />
        <Route path="/nfc" element={<NFC />} />
        <Route path="/cookie" element={<Cookie />} />
      </Routes>
    </BrowserRouter>
  </React.StrictMode>,
  document.getElementById('root')
)

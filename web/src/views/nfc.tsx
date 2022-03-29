declare const flutterApp: any

function NFCView () {
    const readNFC = () => {
        console.info(flutterApp)
        flutterApp.postMessage('read')
    }

    const writeNFC = () => {
        flutterApp.postMessage('write')
    }
  
    return (
      <div>
        <h1>ReadNFC</h1>
        <button onClick={readNFC}>Get NFC</button>
        <button onClick={writeNFC}>write NFC</button>
      </div>
    )
  }
  
  export default NFCView
  
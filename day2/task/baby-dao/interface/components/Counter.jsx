import { useCanister } from "@connect2ic/react"
import React, { useEffect, useState } from "react"

const Counter = () => {
  /*
   * This how you use canisters throughout your app.
   */
  const [dao] = useCanister("dao")
  const [count, setCount] = useState()
  const [message, setMessage] = useState()
  const [newMessage, setNewMessage] = useState("")

  const refreshCounter = async () => {
    const freshCount = await dao.getValue()
    const backendMessage = await dao.getMessage()
    setCount(freshCount)
    setMessage(backendMessage)
  }

  const increment = async () => {
    await dao.increment()
    await refreshCounter()
  }

  const changeMessage = async () => {
    console.log("submited")
    await dao.changeMessage(newMessage)
    await refreshCounter()
  }

  const handleChange = (event) => {
    setNewMessage(event.target.value)
  }

  useEffect(() => {
    if (!dao) {
      return
    }
    refreshCounter()
  }, [dao])

  return (
    <div className="example">
      <p style={{ fontSize: "2.5em" }}>{count?.toString()}</p>
      <button className="connect-button" onClick={increment}>
        +
      </button>
      <input
        type="text"
        id="message"
        name="message"
        onChange={handleChange}
        value={newMessage}
      />
      <button onClick={changeMessage}>Submit</button>
      <p>{message && message}</p>
    </div>
  )
}

export { Counter }

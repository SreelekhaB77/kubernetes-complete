import React, { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("Loading...");

  useEffect(() => {
    // Replace this with your actual backend service name in Kubernetes
    fetch("/api/hello")
      .then((res) => res.text())
      .then((data) => setMessage(data))
      .catch(() => setMessage("Unable to connect to backend"));
  }, []);

  return (
    <div style={styles.container}>
      <h1 style={styles.header}>🚀 Three-Tier App</h1>
      <p style={styles.text}>Frontend (React) is running!</p>
      <p style={styles.text}>Backend says: {message}</p>
    </div>
  );
}

const styles = {
  container: {
    textAlign: "center",
    padding: "50px",
    fontFamily: "Arial, sans-serif",
  },
  header: {
    fontSize: "2em",
    color: "#333",
  },
  text: {
    fontSize: "1.2em",
    color: "#555",
  },
};

export default App;


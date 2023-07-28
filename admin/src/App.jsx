import './App.css'

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/sidebar';
import Admins from './components/Admins';
import PropertyList from './components/PropertyList';
import Login from './components/Login';
function App() {
  

  return (
    <>
  
     <Router>
        <Sidebar />
      <Routes>
      <Route exact path="/" element={<Login />} />
        <Route exact path="/admin" element={<Admins />} />
        
        {/* <Route exact path="/register" element={<Login />} /> */}
        <Route path="/property" element={<PropertyList />} />
      </Routes>
    </Router>
    </>
  )
}

export default App

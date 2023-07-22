import './App.css'

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/sidebar';
import Admins from './components/Admins';
import PropertyList from './components/PropertyList';
function App() {
  

  return (
    <>
  
     <Router>
        <Sidebar />
      <Routes>
        <Route exact path="/" element={<Admins />} />
        <Route path="/property" element={<PropertyList />} />
    
      </Routes>
    </Router>
    </>
  )
}

export default App

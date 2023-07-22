import React from 'react'
import { useState, useEffect } from 'react';
export default function PropertyList() {
    const [property, setProperty] = useState([])
    const [loading, setLoading] = useState(false);
    useEffect(() => {
        const getProperty = async() => { 
            setLoading(true);
            fetch("http://localhost:3000/getBooking").then((result) => {
                result.json().then((resp) => {
                    // console.warn(resp)
                    if (resp.status && Array.isArray(resp.user)) {
                        setProperty(resp.user);
                        setLoading(false);
                        
                         // Update the state with the correct users array
                    }
                })
            })
        }
        getProperty();
    }, []);
    console.log(property);
  return (
    <div>PropertyList</div>
  )
}

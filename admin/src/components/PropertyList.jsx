import React from 'react'
import { useState, useEffect } from 'react';

import { Link } from 'react-router-dom';
export default function Admins() {
    const [users, setUser] = useState([])
    const [data, setData] = useState([])
    const [loading, setLoading] = useState(false);
    useEffect(() => {
    const getUser = async () => {
        setLoading(true);
        //     const cookieValue = document.cookie
        // .split('; ')
        // .find(row => row.startsWith('authorization=yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGJhM2I1OTQ1MGNhODc5NzNiMWMzMzkiLCJlbWFpbCI6ImFAYS5hIiwibmFtZXMiOiJhIiwicGhvbmUiOjk4MTAzMzkwNjEsInJvbGUiOiJ0ZW5hbnQiLCJpYXQiOjE2OTAzNTA1OTgsImV4cCI6MTY5MDM1NDE5OH0.OlB5lze6YEXkafQ5hkhsrhtJgKHfalKkyAg9ng2JnJs'))
        // .split('=')[1]; 
            fetch("http://localhost:3000/property/getproperty",
            // { headers:{
            //     'Authorization': `Bearer ${cookieValue}`,
            // },}
            ).then((result) => {
               
                result.json().then((resp) => {
                    // console.warn(resp)
                    if (resp.status && Array.isArray(resp.property)) {
                        setData(resp.property);
                        setUser(resp.property);
                        setLoading(false); // Update the state with the correct users array
                    }
                })
            })
        }
        getUser();
    }, []);
    const Loading = () => {
        return (
            <>
                Loading...
            </>
        )
    }
    const filterProductes = (cat) => {
        const updatedList = data.filter((x) => x.propertyAddress === cat);
        setUser(updatedList);
    }
    const ShowUsers = () => {
        return (
            <>
                <div className="button d-flex justify-content-center mb-5 pb-5">
                    <button className="btn btn-outline-dark me-2" onClick={() => setUser(data)}>All</button>
                    <button className="btn btn-outline-dark me-2" onClick={() => filterProductes("Lalitpur")}>Lalitpur</button>
                    <button className="btn btn-outline-dark me 2" onClick={() => filterProductes("Baneshwor")}>Baneswor</button>
                </div>
                <div className="App">
                    <table className="table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">propertyAddress</th>
                                <th scope="col">propertyLocality</th>
                                <th scope="col">propertyRent</th>
                                <th scope="col">Owner</th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.map((item, index) =>
                                <tr key={index}>
                                    <th scope="row">{index}</th>
                                    <td>{item.propertyAddress}</td>
                                    <td>{item.propertyLocality}</td>
                                    <td>{item.propertyRent}</td>
                                    <td>{item.ownerName}</td>
                                </tr>
                            )}
                        </tbody>
                    </table >
                </div>
            </>
        )
    }
    console.log(users);
    return (
        <>
            <div>
                <div className="container my-5 py-2">
                    <div className="row">
                        <div className="col-12 mb-3">
                            <h1 className='display-7 fw-bolder text-start'>Property</h1>
                            
                        </div>
                    </div>
                    <div className="row justify-content-center">
                        {loading ? <Loading /> : <ShowUsers />}
                    </div>
                </div>
            </div>
        </>
    );
}

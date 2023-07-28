import React from 'react'
import { useState, useEffect } from 'react';

import { Link } from 'react-router-dom';
import Cookies from 'universal-cookie';
export default function Admins() {
    const [users, setUser] = useState([])
    const [data, setData] = useState([])
    const [loading, setLoading] = useState(false);
    useEffect(() => {
        const getUser = async () => {
            setLoading(true);
            const token = localStorage.getItem('user-token');
            console.log(token);
            if (token) {
                try {

                    const response = await fetch('http://localhost:3000/user/getuser', {
                        headers: {
                            Authorization: `${token}`,
                            Cookies: `${token}`
                        }
                    });


                    const result = await response.json();

                    if (response.ok && Array.isArray(result.user)) {
                        setData(result.user);
                        setUser(result.user);
                        setLoading(false); // Update the state with the correct users array
                    } else {

                        // Handle unsuccessful response or errors here
                        console.error('Failed to fetch user data:', result);
                    }
                } catch (error) {
                    // Handle fetch errors here
                    console.error('Fetch error:', error);
                }
            } else {
                // Handle case when token is missing (e.g., user is not authenticated)
                console.log('User is not authenticated');
                setLoading(false);
            }
        };

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
        const updatedList = data.filter((x) => x.role === cat);
        setUser(updatedList);
    }
    const ShowUsers = () => {
        return (
            <>
                <div className="button d-flex justify-content-center mb-5 pb-5">
                    <button className="btn btn-outline-dark me-2" onClick={() => setUser(data)}>All</button>
                    <button className="btn btn-outline-dark me-2" onClick={() => filterProductes("tenant")}>Tenants</button>
                    <button className="btn btn-outline-dark me 2" onClick={() => filterProductes("owner")}>Owner</button>
                </div>
                <div className="App">
                    <table className="table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Fullname</th>
                                <th scope="col">Email</th>
                                <th scope="col">Phone</th>
                                <th scope="col">Role</th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.map((item, index) =>
                                <tr key={index}>
                                    <th scope="row">{index}</th>
                                    <td>{item.names}</td>
                                    <td>{item.email}</td>
                                    <td>{item.phone}</td>
                                    <td>{item.role}</td>
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
                <div className="container my-5 py-5">
                    <div className="row">
                        <div className="col-12 mb-5">
                            <h1 className='display-6 fw-bolder text-center'>Users</h1>
                            <hr />
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

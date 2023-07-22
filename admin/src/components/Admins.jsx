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
            fetch("http://localhost:3000/getuser").then((result) => {
                result.json().then((resp) => {
                    // console.warn(resp)
                    if (resp.status && Array.isArray(resp.user)) {
                        setData(resp.user);
                        setUser(resp.user);
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

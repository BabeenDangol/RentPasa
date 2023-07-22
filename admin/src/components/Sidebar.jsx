import React from "react";
import { Link, NavLink } from "react-router-dom";
const Sidebar = () => {
    return (
        <div>
            <nav className="navbar navbar-expand-lg navbar-light bg-white py-3 shadow-sm">
                <div className="container">
                    <Link className="navbar-brand fw-bold fs-4" to="/">Admin Panel</Link>
                    <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>

                    <div className="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul className="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li className="nav-item active">
                                <Link className="nav-link fw-bold" aria-current="page" to="/">Admins <span className="sr-only">(current)</span></Link>
                            </li>
                            <li className="nav-item ">
                                <Link className="nav-link" aria-current="page" to="/property">property<span className="sr-only">(current)</span></Link>
                            </li>
                      
                        </ul>
                        <div className="buttons">
                            <Link to="" className="btn btn-outline-dark">
                            <i className="fa fa-sign-in me-2"></i> Login
                            </Link>
                            <Link to="" className="btn btn-outline-dark ms-2">
                            <i className="fa fa-user-plus me-2 "></i> Register
                            </Link>
                            <Link to="" className="btn btn-outline-dark ms-2">
                            <i className="fa fa-shopping-cart me-2"></i>Cart(0)
                            </Link>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    )
}
export default Sidebar;
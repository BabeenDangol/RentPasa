import React, { useState, useEffect } from 'react'
import './Login.css'
import { Link, NavLink, Navigate } from "react-router-dom";
import axios from 'axios';
import Cookies from "universal-cookie";
import { toast, ToastContainer } from 'react-toastify';
import { useNavigate } from "react-router-dom";
import jwt from "jwt-decode";

export default function Login() {
    const navigate = useNavigate()
    const cookie = new Cookies()
    const [email, setEmail ] = useState([""]);
    const [ password, setPassword ] = useState("");
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        phone:'',
        password: '',
      });
    useEffect(() => {
        if (localStorage.getItem('user-Info')) {
            navigate("/admin")
        }
    });
    const handleLogin = async (e) => {
        e.preventDefault();
        try {
          const response = await axios.post('http://localhost:3000/admin/adminlogin', {
            email,
            password,
          });
          const data = response.data;
          const token = data.token;
          console.log('token:',token);
          // Handle the API response based on your server's authentication logic
          console.log('Login successful:', data);
          localStorage.setItem('user-token', token);
          // Show a success toast message
          toast.success('Login successful! Redirecting to admin page...');
          // Navigate to the admin page after a brief delay
          setTimeout(() => {
            navigate('/admin');
          }, 1500);
        } catch (error) {
          console.error('Login failed:', error);
          // Handle the error (e.g., display an error message)
          // Show an error toast message
          toast.error('Login failed! Please check your credentials.');
        }
    };
      const handleChange = (e) => {
        setFormData({
          ...formData,
          [e.target.name]: e.target.value,
          [e.target.email]: e.target.value,
          [e.target.phone]: e.target.value,
          [e.target.password]: e.target.value,
        });
      };
      const handleSubmit = async (e) => {
        e.preventDefault();
        try {
          const response = await axios.post('http://localhost:3000/user/registration', formData);
          console.log('Registration successful:', response.data);
          // Handle successful registration (e.g., show a success message or redirect to a login page)
        } catch (error) {
          console.error('Registration failed:', error);
          // Handle registration errors (e.g., show an error message)
        }
      };
    return (
        <div>
            <div class="wrapper">
                <div class="card-switch">
                    <label class="switch">
                        <input type="checkbox" class="toggle" />
                        <span class="slider"></span>
                        <span class="card-side"></span>
                        <div class="flip-card__inner">
                            <div class="flip-card__front">
                                <div class="title">Log in</div>
                                {/* <form class="flip-card__form" onSubmit={login} > */}
                                    <input
                                     class="flip-card__input"
                                     name="email"
                                     placeholder="Email"
                                     type="email" 
                                     onChange={(e) => setEmail(e.target.value)} />
                                    <input 
                                    class="flip-card__input" 
                                    name="password"
                                    placeholder="Password" 
                                    type="password"
                                    onChange={(e) => setPassword(e.target.value)} />
                                    <button class="flip-card__btn" onClick={handleLogin}>Let`s go!</button>
                                {/* </form> */}
                            </div>
                            <div class="flip-card__back">
                                <div class="title">Sign up</div>
                                <form class="flip-card__form"onSubmit={handleSubmit}>
                                <input class="flip-card__input" type="text" placeholder='Name' name="name" value={formData.name} onChange={handleChange} />
                                    <input class="flip-card__input" name="email" placeholder="Email" type="email" value={formData.email} onChange={handleChange} />
                                    <input class="flip-card__input" name="phone" placeholder="Phone" type="Number" value={formData.phone} onChange={handleChange} />
                                    <input class="flip-card__input" name="password" placeholder="Password" type="password" value={formData.password} onChange={handleChange}/>
                                    <button class="flip-card__btn">Confirm!</button>
                                </form>
                            </div>
                        </div>
                    </label>
                </div>
            </div>
        </div>
    )
}

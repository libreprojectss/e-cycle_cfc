import { createContext, useState } from "react";
import axios from 'axios';
import { useEffect } from 'react';

export const AuthContext = createContext();

export const AuthContextProvider = ({ children }) => {

   const [user,setUser] = useState([]);
const getUser = () => {
    axios.get('').then((res)=>setUser(res.data)).catch((err)=>console.log(err))
}
useEffect(()=>getUser(),[]);
    return (
        <AuthContext.Provider value={{ user,getUser }}>
            {children}
        </AuthContext.Provider>
    );
}

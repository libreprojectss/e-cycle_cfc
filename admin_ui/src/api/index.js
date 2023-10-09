import axios from "axios";

const api = axios.create({
    baseURL:process.env.BASE_URL,
    headers:{
        Authorization:`Bearer ${process.env.API_KEY}`
    }
});

// define all api call from here

export const fetchPickupRequest =async () => api.get('/api/categories');


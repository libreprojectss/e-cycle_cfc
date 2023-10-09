import 'leaflet/dist/leaflet.css';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
// import markerIcon from '../assets/ewaste.png';
// import collecterIcon from '/collector.png';
import axios from 'axios'
import { useEffect, useState } from 'react';

function LeafletFunc() {
    // const [data, setData] = useState([])
    // const [amen, setamen] = useState()

    // const validity = () => {
    //     axios.get('http://192.168.1.114:8000/api/user/allproduct/')
    //         .then((resp) => {
    //             if (resp) {
    //                 console.log(resp)
    //                 setData(resp.data)
    //             }
    //             else {
    //                 console.log('Verification Failed')
    //             }
    //         }).catch((err) => {
    //             console.log(err.response.data.detail);
    //             console.log("Bye")
    //         }
    //         )
    // }
    // const amenity = () => {
    //     axios.get('http://192.168.1.114:8000/api/user/amenity/')
    //         .then((resp) => {
    //             if (resp) {
    //                 console.log('its amenity data')
    //                 // console.log(resp.data)
    //                 setamen(resp.data)
    //                 // console.log(setamen)
    //             }
    //             else {
    //                 console.log('Verification Failed')
    //             }
    //         }).catch((err) => {
    //             console.log("Bye")
    //         }
    //         )
    // }

    // useEffect(() => (validity()), [])
    // useEffect(() => (amenity()), [])


    // const customIcon = L.icon({
    //     iconUrl: markerIcon,
    //     iconSize: [30, 40],
    // });


    // const customIconAmen = L.icon({
    //     iconUrl: collecterIcon,
    //     iconSize: [50, 40],
    // });
    return (
        // <MapContainer
        //     center={[28.2096, 83.9856]}
        //     zoom={13}
        //     scrollWheelZoom={true}
        //     style={{ height: '800px', width: '1200px', border: '1px solid #ccc', borderRadius: '4px' }}
        // >
        //     <TileLayer
        //         attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        //         url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        //     />
        //     {data.map((marker, index) => (
        //         <Marker key={index} position={[marker.lat, marker.lon]} icon={customIcon}>
        //             <Popup>{marker.productname}</Popup>
        //         </Marker>
        //     ))}
        //     {amen?.length && amen.map((marker, index) => (
        //         // console.log(marker?.coordinates[0],marker?.coordinates[1])
        //         <Marker key={index} position={[marker?.coordinates[1], marker?.coordinates[0]]} icon={customIconAmen}>
        //             <Popup>{marker?.name ? marker?.name : "No name"}</Popup>
        //         </Marker>
        //     ))}


        // </MapContainer>
        <div>
            Hello from OSM MAP
        </div>
    );
}

export default LeafletFunc;
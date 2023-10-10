import "leaflet/dist/leaflet.css";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  useDisclosure,
  Box,
  Text,
  Flex,
} from "@chakra-ui/react";
import markerIcon from "../../assets/marker.png";
import { AiOutlineEye } from "react-icons/ai";
import React from "react";

export default function DetailModal({ data }) {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const finalRef = React.useRef(null);
  const customIcon = L.icon({
    iconUrl: markerIcon,
    iconSize: [30, 40],
  });
  return (
    <>
      <AiOutlineEye size={25} onClick={onOpen} style={{ cursor: "pointer" }} />
      <Modal
        finalFocusRef={finalRef}
        isOpen={isOpen}
        onClose={onClose}
        size={["xs", "sm", "md", "lg", "xl", "full"]}
      >
        <ModalOverlay />
        <ModalContent>
          <ModalHeader>Product Details</ModalHeader>
          <ModalCloseButton />
          <ModalBody
            as={Flex}
            justifyContent={"center"}
            flexDirection={"column"}
            placeItems={"center"}
          >
            <Box padding={4}>
              <MapContainer
                center={[27.7172, 85.324]}
                zoom={11}
                scrollWheelZoom={true}
                style={{
                  height: "60vh",
                  width: "40vw",
                  border: "1px solid #ccc",
                  borderRadius: "4px",
                }}
              >
                <TileLayer
                  attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                  url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                />
                {console.log(data)}
                <Marker
                  position={[data?.lat, data?.long]}
                  icon={customIcon}
                  style={{ height: "20px" }}
                >
                  <Popup>
                    {data.products.map((item, index) => (
                      <Box key={index}>
                      
                          <img
                            src={`${import.meta.env.VITE_BASE_URL}media/${item.image}`}
                            alt="image"
                            width={200}
                            height={200}
                          />
                        <Text fontSize="lg">{item.title}</Text>
                        <p>{item.description}</p>
                      </Box>
                    ))}
                  </Popup>
                </Marker>
              </MapContainer>
            </Box>
          </ModalBody>
        </ModalContent>
      </Modal>
    </>
  );
}

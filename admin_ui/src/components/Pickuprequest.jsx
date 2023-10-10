import React, { useEffect, useState } from "react";
import DetailModal from "./modal/Modal";
import {
  Card,
  Box,
  Spacer,
  CardBody,
  Text,
  Avatar,
  Wrap,
  WrapItem,
  Stack,
  Badge,
  Flex,
  
} from "@chakra-ui/react";
import { BsFillTrashFill } from "react-icons/bs";
import axios from "axios";

const Pickuprequest = () => {

  const [pickupRequest, setPickupRequest] = useState([]);
  const getPickup = () => {
    axios
      .get("http://127.0.0.1:8000/pickups/all/")
      .then((resp) => {
        console.log('response',resp)
        setPickupRequest(resp.data.data);
      })
      .catch((err) => {
        console.log("Bye");
      });
  };
  useEffect(() => getPickup(), []);
  return (
    <>
      <Box mt={8}>
        {pickupRequest.map((item,index) => (
          <Card mx={8} key={index}>
            <CardBody
              as={Flex}
              alignItems={"center"}
              justifyContent={"space-between"}
            >
              <Flex alignItems={"center"}>
                <Wrap mx={4}>
                  <WrapItem>
                    <Avatar
                      name="Dan Abrahmov"
                      src="https://bit.ly/dan-abramov"
                    />
                  </WrapItem>
                </Wrap>
                <Spacer />
                <Text >{item.products[0]?.title}</Text>
              </Flex>
              <Spacer />
              <Flex justifyContent={"center"} alignContent={"center"}>
                <Box mx={4}>
                  <Badge colorScheme="blue">pending</Badge>
                </Box>
                {
                  console.log('data',item)
                }
                <DetailModal data={item} />
                <Box
                  as={Flex}
                  justifyContent={"center"}
                  alignItems={"center"}
                  mx={2}
                >
                  <BsFillTrashFill
                    size={20}
                    color="red"
                    style={{ cursor: "pointer" }}
                  />
                </Box>
              </Flex>
            </CardBody>
          </Card>
        ))}
      </Box>
    </>
  );
};

export default Pickuprequest;

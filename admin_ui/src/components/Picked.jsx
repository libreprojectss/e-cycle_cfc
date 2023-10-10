import { React, useState, useEffect } from "react";
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
  Center,
} from "@chakra-ui/react";
import axios from "axios";

const Picked = () => {
  const [picked, setPicked] = useState([]);
  const getPickup = () => {
    axios
      .get("http://127.0.0.1:8000/pickups/completed/")
      .then((resp) => {
        console.log("response", resp);
        setPicked(resp.data.data);
      })
      .catch((err) => {
        console.log("Bye");
      });
  };
  useEffect(() => getPickup(), []);
  return (
    <Box mt={8}>
   
      {picked?.length > 0 ? (
        picked.map((item, index) => (
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
                  <Badge colorScheme="green">picked</Badge>
                </Box>
                <DetailModal data={item} />
              </Flex>
            </CardBody>
          </Card>
        ))
      ) : (
        <div>No data</div>
      )}
    </Box>
  );
};

export default Picked;

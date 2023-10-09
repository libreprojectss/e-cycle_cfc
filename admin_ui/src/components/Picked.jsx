import React from "react";
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

const Picked = () => {
  return (
    <Box mt={8}>
      <Card mx={8}>
        <CardBody
          as={Flex}
          alignItems={"center"}
          justifyContent={"space-between"}
        >
          <Flex alignItems={"center"}>
            <Wrap mx={4}>
              <WrapItem>
                <Avatar name="Dan Abrahmov" src="https://bit.ly/dan-abramov" />
              </WrapItem>
            </Wrap>
            <Spacer />
            <Text>Title</Text>
          </Flex>
          <Spacer />
          <Flex justifyContent={"center"} alignContent={"center"}>
            <Box mx={4}>
              <Badge colorScheme="green">picked</Badge>
            </Box>
            <DetailModal />
          </Flex>
        </CardBody>
      </Card>
    </Box>
  );
};

export default Picked;

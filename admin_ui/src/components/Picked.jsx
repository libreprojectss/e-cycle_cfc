import React from "react";
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

import { AiOutlineEye } from "react-icons/ai";

const Picked = () => {
  return (
    <Box mt={8}>
      <Card mx={8}>
        <CardBody as={Flex} alignItems={"center"} justifyContent={'space-between'}>
          <Flex alignItems={'center'}>
            <Wrap mx={4}>
              <WrapItem>
                <Avatar name="Dan Abrahmov" src="https://bit.ly/dan-abramov" />
              </WrapItem>
            </Wrap>
            <Spacer />
            <Text>Title</Text>
          </Flex>
          <Spacer />
          <Flex  justifyContent={"center"} alignContent={'center'}>
            <Box mx={4}>
            <Badge colorScheme="blue" >picked</Badge>
            </Box>

            <AiOutlineEye size={25}/>
          </Flex>
        </CardBody>
      </Card>
    </Box>
  );
};

export default Picked;

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
      <Card>
        <CardBody as={Flex} alignItems={"center"}>
          <Flex alignItems={'center'}>
            <Wrap>
              <WrapItem>
                <Avatar name="Dan Abrahmov" src="https://bit.ly/dan-abramov" />
              </WrapItem>
            </Wrap>
            <Spacer />
            <Text>Title</Text>
          </Flex>
          <Spacer />
          <Stack direction="row">
            <Badge colorScheme="blue">picked</Badge>
            <AiOutlineEye />
          </Stack>
        </CardBody>
      </Card>
    </Box>
  );
};

export default Picked;

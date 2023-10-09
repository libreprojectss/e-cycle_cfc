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
  Button
} from "@chakra-ui/react";
import { AiOutlineEye } from "react-icons/ai";
import React from "react";

export default function DetailModal() {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const finalRef = React.useRef(null);

  return (
    <>

        <AiOutlineEye size={25}  onClick={onOpen} style={{cursor:"pointer"}}/>
      <Modal finalFocusRef={finalRef} isOpen={isOpen} onClose={onClose} >
        <ModalOverlay />
        <ModalContent>
          <ModalHeader>Modal Title</ModalHeader>
          <ModalCloseButton />
          <ModalBody>
          Body goes here
          </ModalBody>

       
        </ModalContent>
      </Modal>
    </>
  );
}

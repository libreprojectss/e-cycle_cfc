import * as React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import { Box, Grid, GridItem } from "@chakra-ui/react";
import Sidebar from "./components/Sidebar";
import Picked from "./components/Picked";
import Pickupreqeust from "./components/Pickuprequest";
import Dashboard from "./components/Dashboard";
import LeafletFunc from "./components/Map/Leafletcontainer";
function App() {

  return (
    <>
      <Box width={"full"}>
        <Grid
          templateRows='repeat(2, 1fr)'
          templateColumns='repeat(5, 1fr)'
          gap={4}
        >
          <GridItem rowSpan={2} colSpan={1} >
            <Sidebar />
          </GridItem>
          <GridItem colSpan={4}>
            <Routes>
              <Route path="/" element={<LeafletFunc />} />
              {/* <Route path="/map" element={<Pickupreqeust />} /> */}
              <Route path="/pickuprequest" element={<Pickupreqeust />} />
              <Route path="/picked" element={<Picked />} />
            </Routes>
          </GridItem>
        </Grid>
      </Box>
    </>
  );
}

export default App;

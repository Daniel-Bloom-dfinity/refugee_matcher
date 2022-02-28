import * as React from "react";
import { render } from "react-dom";
import { ChakraProvider, Center, Box, Button, Link, SimpleGrid, Flex } from '@chakra-ui/react';

import Header from "./components/Header";

import "../assets/main.scss";

// const theme = extendTheme({
//   initialColorMode: 'light',
//   useSystemColorMode: false,
// });


// Included starter code for backend integration:
// import { refugee_matcher } from "../../declarations/refugee_matcher";
// async function doGreet() {
//   const greeting = await refugee_matcher.greet(name);
//   setMessage(greeting);
// }

const App = () => {
  const [name, setName] = React.useState('');
  const [message, setMessage] = React.useState('');

  return (
    <ChakraProvider>
      <Flex direction='column' height='100%'>
        <Box flex='1 0 auto'>
          <Header />
          <SimpleGrid mt="80px" columns={{sm: 1, md: 2}} spacing='80px'>
            <Box>
              <Center>
                <Button size="lg">I need shelter</Button>
              </Center>
            </Box>
            <Box>
              <Center>
                <Button size="lg">I can offer shelter</Button>
              </Center>
            </Box>
          </SimpleGrid>
          <Center margin="80px">
            <Box maxWidth="400px">
              Dedicated to connecting refugees with people willing to open their doors.
            </Box>
          </Center>
        </Box>
        <Center margin="80px" as='footer' flexShrink='0'>
          <Link padding='5px'>About</Link>
        </Center>
      </Flex>
    </ChakraProvider>
  );
};

render(<App />, document.getElementById("app"));


import * as React from "react";
import { render } from "react-dom";
import { ChakraProvider, extendTheme, Center, Box, Button, Link, Text, SimpleGrid, Flex, Heading, VStack } from '@chakra-ui/react';
import {IntlProvider, FormattedMessage} from 'react-intl';

import messages from "./i18n";
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

const DEFAULT_LANG = 'en';

const theme = extendTheme({
  fonts: {
    heading: 'Inter, sans-serif',
    body: 'Inter, sans-serif',
  },
});

const App = () => {
  const [lang, setLang] = React.useState(DEFAULT_LANG);

  return (
    <IntlProvider locale={lang} messages={messages[lang]} defaultLocale={DEFAULT_LANG}>
      <ChakraProvider theme={theme}>
        <Flex direction='column' height='100%' bg='gray.50'>
          <Box flex='1 0 auto'>
            <Header onLangChange={setLang} />
            <Center>
              <VStack mt='100'>
                <Heading fontSize='5xl'>Site of Refuge</Heading>
                <Text fontSize='lg' maxWidth='440px' textAlign='center'>
                  Dedicated to connecting refugees with people willing to open their doors.
                </Text>
                <SimpleGrid pt='32px' columns={{sm: 1, md: 2}} spacing='16px'>
                  <Box>
                    <Center>
                      <Button size="lg" bg='blue.700' color='white' _hover={{bg: 'blue.900'}} width='310px'>
                        <FormattedMessage
                          description="refugee signup button"
                          defaultMessage="I need shelter"
                        />
                      </Button>
                    </Center>
                  </Box>
                  <Box>
                    <Center>
                      <Button size="lg" width='310px'>
                        <FormattedMessage
                          description="host signup button"
                          defaultMessage="I can offer shelter"
                        />
                      </Button>
                    </Center>
                  </Box>
                </SimpleGrid>
              </VStack>
            </Center>
          </Box>
          <Center margin="80px" as='footer' flexShrink='0'>
            <Link padding='5px'>
              <FormattedMessage
                description="about link"
                defaultMessage="About"
              />
            </Link>
          </Center>
        </Flex>
      </ChakraProvider>
    </IntlProvider>
  );
};

render(<App />, document.getElementById("app"));


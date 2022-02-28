import * as React from "react";
import { render } from "react-dom";
import { ChakraProvider, Center, Box, Button, Link, SimpleGrid, Flex } from '@chakra-ui/react';
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

const App = () => {
  const [lang, setLang] = React.useState(DEFAULT_LANG);

  return (
    <IntlProvider locale={lang} messages={messages[lang]} defaultLocale={DEFAULT_LANG}>
      <ChakraProvider>
        <Flex direction='column' height='100%'>
          <Box flex='1 0 auto'>
            <Header onLangChange={setLang} />
            <SimpleGrid mt="80px" columns={{sm: 1, md: 2}} spacing='80px'>
              <Box>
                <Center>
                  <Button size="lg">
                    <FormattedMessage
                      description="refugee signup button"
                      defaultMessage="I need shelter"
                    />
                  </Button>
                </Center>
              </Box>
              <Box>
                <Center>
                  <Button size="lg">
                    <FormattedMessage
                      description="host signup button"
                      defaultMessage="I can offer shelter"
                    />
                  </Button>
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


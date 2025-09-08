import { useBackend } from '../backend';
import { Box, DmIcon, Flex, Icon } from '../components';
import { Window } from '../layouts';


type ItemStashData = {
  logged_in: boolean;
  contents: StoredItems[];
};

type StoredItems = {
  icon: string;
  icon_state: string;
  image: string;
  name: string;
};

export const ItemStash = () => {
  const { data } = useBackend<ItemStashData>();
  const { act } = useBackend();
  const { contents } = data;
  return (
    <Window theme="generi" width={650} height={500}>
      <Window.Content>
        <Flex width="100%" className="ItemStash_Debug">
          {data.logged_in ? (
            <Flex className="ItemStash_Debug">
              <Flex wrap width="455px" className="ItemStash_Debug">

                  {contents.map((item, index) => (
                    <Cell
                      name={item.name}
                      key={index}
                      icon={item.icon}
                      icon_state={item.icon_state}
                      index={index}
                    />
                    ))
                  }

              </Flex>
              <Box
                width="190px"
                className="ItemStash_Logout"
                onClick={() => act('Logout')}
              >
                Logout
                {data.logged_in}
              </Box>

            </Flex>
            ) : (
              <Box
                className="ItemStash_Login"
                onClick={() => act('Login')}
              >
                Login
              </Box>
            )
          }
        </Flex>
      </Window.Content>
    </Window>
  );
};

const Cell = (props) => {
  const { act } = useBackend<ItemStashData>();
  return (
    <Flex.Item className="ItemStash_FlexItem" width="80px" height="80px">
      <Box className="ItemStash_Box" position="relative">
        <Box className="ItemStash_Box">
          {props.icon && (
            <Box className="ItemStash_Box">
                <DmIcon
                  mb={-2}
                  icon={props.icon}
                  icon_state={props.icon_state}
                  fallback={<Icon mt={1} ml={1} name="spinner" spin fontSize="70px" />}
                  height="100%"
                  width="100%"
                  backgroundColor="red"
                  style={{
                    imageRendering: 'pixelated',
                  }}
                />
            </Box>
          )}
          <Box
            className="ItemStash_Slot"
            onClick={() => act('ItemClick', { SlotKey: props.index + 1 })}
          >
            {props.name}
          </Box>
        </Box>
      </Box>
    </Flex.Item>
  );
};

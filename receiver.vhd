library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receiver is
    Port (
             rx_in : in std_logic;
             clk : in std_logic;
             reset : in std_logic;
             rx_datafinal : buffer std_logic_vector(7 downto 0);
             rx_full : out std_logic;
             rows: out integer;
             cols: out integer
         );
end receiver;

architecture Behavioral of receiver is

    type state is (idle, start, si);
    signal rx_state : state := idle;
    signal i : integer := 0;
    signal num : integer := 0;
    signal temp_full : std_logic := '1';
    signal rx_data : std_logic_vector(7 downto 0);
    signal c : integer := 0;
    signal iii : integer := 0;
    signal col : integer := 5;
    signal row : integer := 5;
    signal intcnt : integer := 0;

begin

    rows <= row;
    cols <= col;

    process(clk, reset)
    begin
        if(reset = '1') then 
            rx_state <= idle; 
        elsif(clk = '1' and clk'event) then
            case rx_state is 
                when idle => 
                    if(rx_in = '0') then
                        rx_state <= start;
                        i <= 0;
                    else
                        rx_state <= idle;
                    end if;
                when start =>
                    i <= i+1;
                    if(rx_in = '1') then
                        rx_state <= idle;
                    else
                        if(i = 6) then 
                            num <= 0;
                            rx_state <= si;
                            i <= 0;
                            temp_full <= '0';
                        end if;
                    end if;
                when si =>
                    i <= i+1;
                    if(i = 15) then 
                        i <= 0;
                        rx_data <= rx_in & rx_data(7 downto 1);
                        if(num = 8) then
                            num <= 0;
                            rx_state <= idle;
                            if(rx_data = "00001001") then
                                rx_datafinal <= std_logic_vector(to_unsigned(c, 8));
                                temp_full <= '1';
                                if(intcnt = 0) then col <= c;
                                elsif(intcnt = 1) then row <= c;
                                end if;
                                intcnt <= intcnt + 1;
                                c <= 0;
                            else
                                c <= (c*10 + (to_integer(unsigned(rx_data)) - 48));
                            end if;
                        else 
                            num <= num + 1;
                        end if;
                    end if;
            end case;   
        end if;
        rx_full <= temp_full;
    end process;

end Behavioral;

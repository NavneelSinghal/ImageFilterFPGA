library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timing is
    Port ( 
    reset, rx_full, tx_empty, tx_start, clock : in std_logic;
    wen, ld_tx : out std_logic;
    wr_addr, rd_addr : buffer std_logic_vector(7 downto 0);
    row, col : in integer;
    memfull : out std_logic
);
end timing;

architecture Behavioral of timing is
    type state is (s1, s2, s3, s4, s5, s6, s7, s8);
    signal tim_state: state;
    signal wr_temp: integer := 0;
    signal rd_temp: integer := 0;
    signal memfulltemp : std_logic := '0';

begin
    process(clock,reset)
    begin
        if(reset = '1') then
            wr_temp <= 0;
            tim_state <= s1;
        elsif(clock = '1' and clock'event) then
            case tim_state is
                when s1 => 
                    tim_state <= s2;
                    wen <= '0';
                when s2 => 
                    if(tx_start = '1') then
                        rd_temp <= 0;
                        tim_state <= s5;
                    elsif(rx_full = '0') then
                        tim_state  <= s3;
                    end if;
                when s3 =>
                    if(rx_full = '1') then
                        if(wr_temp > (row*col)) then  
                            memfulltemp <= '1';
                        end if;
                        wen <= '1';
                        tim_state <= s4;
                        wr_temp <= wr_temp + 1;
                    end if;
                when s4 =>
                    tim_state <= s2;
                    wen <= '0';
                when s5 =>
                    if(rd_temp = wr_temp) then
                        tim_state <= s8;
                    else
                        ld_tx <= '1';    --- make it 1 afterwards
                        rd_temp <= rd_temp + 1;
                        tim_state <= s6;
                    end if;

                when s6 =>
                    tim_state <= s7;
                    ld_tx <='0';
                when s7 =>
                    if(tx_empty = '1') then 
                        if(rd_temp = wr_temp) then
                            tim_state <= s8;
                        else
                            ld_tx <= '1';
                            rd_temp <= rd_temp + 1;
                            tim_state <= s6;
                        end if;
                    end if;
                when s8 =>
                    if(tx_start = '0') then
                        wen <= '0';
                        tim_state <= s2;
                    end if;
            end case;
        end if;

        rd_addr <= std_logic_vector(to_unsigned(rd_temp, 8));
        wr_addr <= std_logic_vector(to_unsigned(wr_temp, 8));
        memfull <= memfulltemp;

    end process;

end Behavioral;

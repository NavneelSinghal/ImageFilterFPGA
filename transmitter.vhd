
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity transmitter is
    port(
            outdata: out std_logic;
            clk: in std_logic;
            reset: in std_logic;
            ld_tx : in std_logic;
            tx_empty: out std_logic;
            memoryout: in std_logic_vector(7 downto 0) 
        );
end transmitter;

architecture Behavioral of transmitter is
    type state_type is (idle, t1,t2,t3, si);
    signal tx_state : state_type;
    signal ret : std_logic_vector(7 downto 0);
    signal x : std_logic := '1';
    signal num, data, cnt, final, i : integer := 0;
    signal pow : integer := 100;
    signal cc, dd: std_logic := '0';

begin

    data <= to_integer(unsigned(memoryout));

    process(clk, reset)
    begin
        if(reset = '1') then
            tx_state <= idle;
        elsif(clk = '1' and clk'event) then 
            case tx_state is
                when t3 => tx_state <= t1;
                num <= data;
            when idle =>
                if(ld_tx = '1') then
                    pow <= 100;
                    cnt <= 0;
                    cc <= '0';
                    dd <= '0';
                    tx_state <= t3;
                    x <= '0';
                else 
                    outdata <= '1';
                end if;
            when t1 =>
                pow <= pow/10;
                cnt <= cnt + 1;
                final <= num/pow;
                num <= num mod pow;
                tx_state <= t2;
            when t2 =>
                if(final > 0 or cc = '1') then
                    cc <= '1';
                    tx_state <= si;
                    outdata <= '0';
                    ret <= std_logic_vector(to_unsigned(final + 48,8));
                else tx_state <= t1;
                end if;
            when si => 
                if(i < 8) then
                    outdata <= ret(i);
                    i <= i+1;
                else
                    i <= 0;
                    outdata <= '1';
                    if(cnt>=3 and dd = '1') then 
                        tx_state <= idle;
                        x <= '1';
                        cnt <= 0;
                        cc <= '0';
                        dd <= '0';
                        pow <= 100;
                    elsif(cnt>= 3 and dd ='0') then
                        tx_state <= si;
                        outdata <= '0';
                        dd <= '1';
                        ret<="00001001";
                    else
                        tx_state <= t1;
                    end if;
                end if;
        end case;
    end if;
end process;
tx_empty <= x;		

end Behavioral;

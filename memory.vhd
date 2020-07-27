library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    PORT (
             clka : IN STD_LOGIC;
             wea : IN STD_LOGIC;
             addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             clkb : IN STD_LOGIC;
             enb : IN STD_LOGIC;
             addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
             mem_full : IN STD_LOGIC;
             conv_full : OUT STD_LOGIC;
             sw : IN STD_LOGIC
         );
end memory;

architecture Behavioral of memory is

    type Memory_type is array (0 to 255) of std_logic_vector (7 downto 0);
    signal a : Memory_type;
    signal address : unsigned (7 downto 0);
    signal i : integer := 0;
    signal r, c : integer;
    signal res : integer;
    signal cvf : std_logic := '0';
    signal final : integer; 

begin
    c <= to_integer(unsigned(a(0)));
    r <= to_integer(unsigned(a(1)));
    final <=  (((to_integer(unsigned(a(i))) + 2*to_integer(unsigned(a(i + 1))) + to_integer(unsigned(a(i + 2))) + 2*to_integer(unsigned(a(i + c))) + 4*to_integer(unsigned(a(i + c + 1))) + 2*to_integer(unsigned(a(i + c + 2))) + to_integer(unsigned(a(i + 2*c))) + 2*to_integer(unsigned(a(i + 2*c + 1))) + to_integer(unsigned(a(i + 2*c + 2))))/16)) when sw <= '0' else
              (((-to_integer(unsigned(a(i)))-to_integer(unsigned(a(i + 1)))-to_integer(unsigned(a(i + 2))) - to_integer(unsigned(a(i + c))) +17*to_integer(unsigned(a(i + c + 1))) - to_integer(unsigned(a(i + c + 2))) - to_integer(unsigned(a(i + 2*c))) - to_integer(unsigned(a(i + 2*c + 1))) - to_integer(unsigned(a(i + 2*c + 2))))/9));

    process (clkb)
    begin
        if rising_edge(clkb) then
            if (enb = '1') then
                i <= to_integer(unsigned(addrb)); 
            end if;
    --        if(sw = '0') then final <=  (((to_integer(unsigned(a(i))) + 2*to_integer(unsigned(a(i + 1))) + to_integer(unsigned(a(i + 2))) + 2*to_integer(unsigned(a(i + c))) + 4*to_integer(unsigned(a(i + c + 1))) + 2*to_integer(unsigned(a(i + c + 2))) + to_integer(unsigned(a(i + 2*c))) + 2*to_integer(unsigned(a(i + 2*c + 1))) + to_integer(unsigned(a(i + 2*c + 2))))));
    --        else final <= (((-to_integer(unsigned(a(i)))-to_integer(unsigned(a(i + 1)))-to_integer(unsigned(a(i + 2))) - to_integer(unsigned(a(i + c))) +17*to_integer(unsigned(a(i + c + 1))) - to_integer(unsigned(a(i + c + 2))) - to_integer(unsigned(a(i + 2*c))) - to_integer(unsigned(a(i + 2*c + 1))) - to_integer(unsigned(a(i + 2*c + 2))))));
    --        end if;
        end if;
    end process;

    process (clka)
    begin
        if rising_edge(clka) then	
            if (wea = '1') then
                a (to_integer(unsigned(addra))) <= dina (7 downto 0);	
            end if;
        end if;
    end process;
    doutb <= std_logic_vector(to_unsigned(final, 8)) when sw = '0' else 
             std_logic_vector(to_unsigned(0, 8)) when final < 0 else
             std_logic_vector(to_unsigned(255, 8)) when final > 255 else
             std_logic_vector(to_unsigned(final, 8));
end Behavioral;

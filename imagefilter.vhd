library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity imagefilter is
    Port ( 
    clk, data : in std_logic;
    outdata : out std_logic;
    txoutled : buffer std_logic_vector(7 downto 0);
    btnreset : in std_logic;
    btnstart : in std_logic;
    memfull : out std_logic;
    sw : in std_logic
);
end imagefilter;

architecture Behavioral of imagefilter is

    signal clkx16, clk96 : std_logic := '0'; 
    signal cntclkx16, cnt96 : integer := 0;
    signal rx_full : std_logic := '1';
    signal tx_empty : std_logic := '1';
    signal memoryout : std_logic_vector(7 downto 0);
    signal wen, enb : std_logic := '1';
    signal rd_addr, wr_addr : std_logic_vector(7 downto 0);
    signal ld_tx : std_logic :='0';
    signal startdebounced : std_logic := '0';      ---debounced start button
    signal reset : std_logic := '0';               ---debounced reset button
    signal r, c : integer;
    signal outled : std_logic_vector(7 downto 0);
    signal ld_tx1 : std_logic;
    signal conv_full : std_logic;
    signal mfull : std_logic := '0';

begin

    process(clk96)
    begin
        startdebounced <= btnstart;
        reset <= btnreset;
    end process;


    process (clk)            --------clock generation for 16*9600
    begin 
        if(clk = '1' and clk'event) then
            cntclkx16 <= cntclkx16 + 1;
            if(cntclkx16 = 325) then 
                cntclkx16 <= 0;
                clkx16 <= not clkx16;
            end if;
        end if;
    end process;

    process (clk)            ---------clock generation for 9600
    begin 
        if(clk = '1' and clk'event) then
            cnt96 <= cnt96 + 1;
            if(cnt96 = 5207) then 
                cnt96 <= 0;
                clk96 <= not clk96;
            end if;
        end if;
    end process;

    Memory: entity WORK.memory(Behavioral)
    port map(clk96, wen, wr_addr, outled, clk96, enb, rd_addr, memoryout, mfull, conv_full, sw);

    Timing: entity WORK.timing(Behavioral)
    port map(reset, rx_full, tx_empty, startdebounced, clk96, wen, ld_tx, wr_addr, rd_addr, r, c, mfull);

    Receiver: entity WORK.receiver(Behavioral)
    port map(data, clkx16, reset, outled, rx_full, r, c);

    Transmitter: entity WORK.transmitter(Behavioral)
    port map(outdata, clk96, reset, ld_tx, tx_empty, memoryout);

    txoutled <= memoryout; 
    memfull <= mfull;

end Behavioral;

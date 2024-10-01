library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram32x4 is
	port (
		address : IN STD_LOGIC_VECTOR (4 downto 0) := "00000";
		clock : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (3 downto 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIc_VECTOR (3 downto 0)
	);
end entity ram32x4;

architecture Behaviour of ram32x4 is

type mem is array(0 to 31) of STD_LOGIC_VECTOR (3 downto 0);
signal mem_array : mem;

begin

process (clock)
begin
	if (rising_edge(clock)) then 
		if (wren = '1') then
			mem_array (to_integer(unsigned(address))) <= data;
		end if;
	end if;
end process;

q <= mem_array (to_integer(unsigned(address)));

end architecture;
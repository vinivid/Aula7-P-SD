library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part1 is 
	port (
		Address : IN STD_LOGIC_VECTOR (4 downto 0);
		Clock : IN STD_LOGIC;
		DataIn : IN STD_LOGIC_VECTOR (3 downto 0);
		Write : IN STD_LOGIC;
		DataOut : OUT STD_LOGIC_VECTOR (3 downto 0)
	);

end entity part1;

ARCHITECTURE Behaviour of part1 IS
	component ram32x4 is
		port (
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
	end component;

BEGIN
	main_ram : ram32x4 
	port map (
		address => Address,
		clock => Clock,
		data => DataIn,
		wren => Write,
		q => DataOut
	);

END ARCHITECTURE;


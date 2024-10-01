library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tst_ram is 
	port (
		address : IN STD_LOGIC_VECTOR (4 downto 0);
		clk : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (3 downto 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (3 downto 0)
	);

end entity tst_ram;

ARCHITECTURE Behaviour of tst_ram IS
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
		address => address,
		clock => clk,
		data => data,
		wren => wren,
		q => q
	);

END ARCHITECTURE;


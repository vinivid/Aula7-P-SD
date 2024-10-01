library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem_tst is 
	port (
		address : IN STD_LOGIC_VECTOR (4 downto 0);
		clk : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (3 downto 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (6 downto 0)
		
	);

end entity mem_tst;

ARCHITECTURE Behaviour of mem_tst IS
	component ram32x4 is
		port (
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
	end component;
	
	component display_7seg is
	port (
		input_disp : in STD_LOGIC_VECTOR (3 downto 0);
      out_disp : out STD_LOGIC_VECTOR (6 downto 0)
	);
	
	end component;
	
	signal middle_q : STD_LOGIC_VECTOR (3 downto 0);

BEGIN
	main_ram : ram32x4 
	port map (
		address => address,
		clock => clk,
		data => data,
		wren => wren,
		q => middle_q
	);
	
	main_disp : display_7seg
	port map (
		input_disp => middle_q,
		out_disp => q
	);

END ARCHITECTURE;


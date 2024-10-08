library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rollcounter is
    generic (
        modulo : INTEGER := 4;
        max : INTEGER := 4;
        min : INTEGER := 0
    );
    port (
        clk : in STD_LOGIC;
        enable : in STD_LOGIC;
        reset : in STD_LOGIC;
        counter : buffer INTEGER range min to max := min;
        rollout : OUT STD_LOGIC
    );
end entity;

architecture Behaviour of rollcounter is
begin
    process (clk, reset)
    begin
        if (reset =  '1') then
            rollout <= '0';
            counter <= min;
        elsif (rising_edge(clk)) then
            if (enable = '1') then
                if (counter = modulo) then 
                    rollout <= '1';
                    counter <= min;
                else 
                    rollout <= '0';
                    counter <= counter + 1;
                end if;
            else
                rollout <= '0';
                counter <= counter;
        end if;
    end if;
    end process; 
end architecture;

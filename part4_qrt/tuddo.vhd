library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tuddo is
    port (
        clk: IN STD_LOGIC;
        data : IN STD_LOGIC_VECTOR(3 downto 0);
        rwaddres : IN STD_LOGIC_VECTOR(4 downto 0);
        reset : IN STD_LOGIC;
        wren: IN STD_LOGIC;
        out_disp_data : OUT STD_LOGIC_VECTOR(6 downto 0);
        out_disp_addres_1 : OUT STD_LOGIC_VECTOR(6 downto 0);
        out_disp_addres_2 : OUT STD_LOGIC_VECTOR(6 downto 0);
        out_disp_write_1 : OUT STD_LOGIC_VECTOR(6 downto 0);
        out_disp_write_2 : OUT STD_LOGIC_VECTOR(6 downto 0)

    );
end entity tuddo;

architecture Behaviour of tuddo is
    component counter is
        generic (
            modulo : INTEGER := 4;
            max : INTEGER := 4;
            min : INTEGER := 0
        );
        port (
            clk : in STD_LOGIC;
            enable : in STD_LOGIC;
            reset : in STD_LOGIC;
            counter : buffer INTEGER range min to max := min
        );
    end component;

    component display_7seg is
        port (
            input_disp : in STD_LOGIC_VECTOR (3 downto 0);
            out_disp : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    component ram32x4 is
        port
        (
            clock		: IN STD_LOGIC  := '1';
            data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            rdaddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            wraddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            wren		: IN STD_LOGIC  := '0';
            q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    
    end component;

    component rollcounter is
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
    end component;

    signal middle : STD_LOGIC;
    signal mi_count : INTEGER range 0 to 60000000;
    signal addres_out : INTEGER range 0 to 50;
    signal adressing : STD_LOGIC_VECTOR(4 downto 0);
    signal out_mem : STD_LOGIC_VECTOR(3 downto 0);
    signal adres_right : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal adres_left : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal wr_add_right : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal wr_add_left : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
begin

    f_sec: rollcounter
     generic map(
        modulo => 55000000,
        max => 60000000,
        min => 0
    )
     port map(
        clk => clk,
        enable => '1',
        reset => reset,
        counter => mi_count,
        rollout => middle
    );

    four: counter
     generic map(
        modulo => 31,
        max => 50,
        min => 0
    )
     port map(
        clk =>  middle,
        enable => '1',
        reset => reset,
        counter => addres_out
    );

    adressing <= std_logic_vector( to_unsigned( addres_out, adressing'length));

    ramm: ram32x4
     port map(
        clock => clk,
        data => data,
        rdaddress => adressing,
        wraddress => rwaddres,
        wren => wren,
        q => out_mem
    );
    
    data_read: display_7seg
     port map(
        input_disp => out_mem,
        out_disp => out_disp_data
    );
    
    adres_right <= adressing(3 downto 0);
    adres_left(0) <= adressing(4);

    otdispad1: display_7seg
     port map(
        input_disp => adres_right,
        out_disp => out_disp_addres_1
    );

    otdispad2: display_7seg
     port map(
        input_disp => adres_left,
        out_disp => out_disp_addres_2
    );
    
    wr_add_right <= rwaddres (3 downto 0);
    wr_add_left(0) <= rwaddres(4);

    write1: display_7seg
     port map(
        input_disp => wr_add_left,
        out_disp => out_disp_write_1
    );

    write2: display_7seg
     port map(
        input_disp => wr_add_left,
        out_disp => out_disp_write_2
    );


end architecture Behaviour;
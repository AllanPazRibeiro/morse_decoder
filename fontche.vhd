    ----------------------------------------------------------------------------------
    -- Company: FTEC
    -- Engineer: Allan Ribeiro
    -- 
    -- Create Date: 24.09.2018 21:38:21
    -- Design Name: 
    -- Module Name: morse_decoder - Behavioral
    -- Project Name: Trabalho codigo morse
    -- Target Devices: Nuscei
    -- Tool Versions: Good question
    -- Description: 
    -- A badass morse decodificator, hope this give a good note since I will use this project
    -- in my Nvidia`s interview :D
    -- 
    -- Revision:
    -- Revision 0.01 - File Created
    -- Additional Comments:
    -- 
    ----------------------------------------------------------------------------------
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
    
    entity morse_decoder is
        Port ( reset: in std_logic; -- reset input 
               counter: out std_logic_vector(1 downto 0); -- output 2-bit counter
               detector_out: out std_logic; -- output of the VHDL sequence detector
               clk: in std_logic; -- clock input
              );
    end morse_decoder;
    
    architecture Behavioral of morse_decoder is
 
    signal two_bit: std_logic_vector(1 downto 0);
    type init_state is (trace, dot, np, nc);
    signal current_state, next_state: init_state;
    
    begin
    -- up counter
    counter_process:process(clk,reset)
    begin
    if(rising_edge(clk)) then
        if(reset='1') then
             counter <= b"0";
        else
            counter <= counter + b"1";
        end if;
        two_bit <= counter;
     end if;
    end process;
    
    define_which_init_type_is:process(current_state,two_bit)
    begin
     case(current_state) is
        when dot =>
            if(two_bit='11') then
                next_state <= dot;
            else
                next_state <= trace;
            else
                next_state <= nc;
            else
                next_state <= np;
            end if;
     when trace =>
            if(two_bit='00') then
                 next_state <= trace;
            else
                 next_state <= dot;
            else
                 next_state <= nc;
            else
                 next_state <= np;
            end if;
     when np =>
            if(two_bit='01') then
                 next_state <= np;
            else
                 next_state <= trace;
            else
                 next_state <= nc;
            else
                 next_state <= dot;
            end if;
     when nc =>
            if(two_bit='01') then
                 next_state <= nc;
            else
                 next_state <= trace;
            else
                 next_state <= np;
            else
                 next_state <= dot;
            end if;
     end case;
    end process;
    
    process(next_state)
    begin
    
    end process
    end Behavioral;


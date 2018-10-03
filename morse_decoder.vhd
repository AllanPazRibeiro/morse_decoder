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

entity Morse is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           entrada : in STD_LOGIC;
           saida : out STD_LOGIC_VECTOR (7 downto 0));
end Morse;

architecture Behavioral of Morse is

TYPE State_type IS (RECEIVING, DECODING); 
SIGNAL current_state : State_Type;    
SIGNAL next_state : State_Type; 

SIGNAL input_reg: std_logic_vector(1 downto 0);
SIGNAL data_reg: std_logic_vector(3 downto 0);
SIGNAL input_counter: natural range 0 to 2 := 0;
SIGNAL data_counter: natural range 0 to 4 := 0;
SIGNAL NP: std_logic; -- Nova palavra
SIGNAL NC: std_logic; -- Novo caracter
SIGNAL NPonto: std_logic; -- Nova simbolo
SIGNAL NTraco: std_logic; -- Nova simbolo

BEGIN

DATA_PROCESSOR : process(clock, reset) 
BEGIN
    IF (reset = '1') THEN
        input_counter <= 0;
        input_reg <= "00";
    ELSIF (rising_edge(clock)) THEN
        input_reg <= input_reg(0) & entrada;
        input_counter <= 1;
        IF input_counter = 2 THEN
            input_counter <= 1;
        ELSE
            input_counter <= input_counter + 1;
        END IF;
    END IF;      
END PROCESS;
    
FSM: process(clock, reset)
BEGIN
     IF (reset = '1') THEN 
        current_state <= RECEIVING;   
     ELSIF (rising_edge(clock)) THEN
        current_state <= next_state;
     END IF;
END PROCESS;
    
STATES: process(current_state, reset, NPonto, NTraco, NC, NP)
BEGIN
    IF reset = '1' THEN 
    data_counter <= 0;
    data_reg <= x"0";
    ELSE
        CASE current_state IS 
            WHEN RECEIVING =>
                IF NPonto = '1' THEN
                    data_counter <= data_counter + 1;
                    data_reg <= data_reg(2 downto 0) & '1';
                ELSIF NTraco = '1' THEN
                    data_counter <= data_counter + 1;
                    data_reg <= data_reg(2 downto 0) & '0';    
                ELSIF NC = '1' OR NP = '1' THEN
                    next_state <= DECODING;
                END IF;    
                    
            WHEN DECODING =>
                data_counter <= 0;
                next_state <= RECEIVING;
            WHEN OTHERS =>
        END CASE;
    END IF;
END PROCESS;
    
NPonto <= '1' WHEN input_counter = 2 AND input_reg = "11" ELSE '0';
NTraco <= '1' WHEN input_counter = 2 AND input_reg = "00" ELSE '0';
NC <= '1' WHEN input_counter = 2 AND input_reg = "10" ELSE '0';
NP <= '1' WHEN input_counter = 2 AND input_reg = "01" ELSE '0';


DECODER: process(NP, NC) 
BEGIN
     IF (reset = '1') THEN
        saida <= x"00";
     ELSE
        IF (NP = '1') THEN
           saida <= x"20"; -- espaco
        ELSIF (NC = '1') THEN
           IF (data_counter = 1) THEN
                CASE data_reg(0) IS
                    WHEN '0' =>
                     saida <= x"54"; -- T
                    WHEN '1' =>
                     saida <= x"45"; -- E
                    WHEN OTHERS =>
                END CASE;
            ELSIF (data_counter = 2) THEN
                CASE data_reg(1 downto 0) IS
                    WHEN "00" =>
                         saida <= x"4D"; -- M
                    WHEN "01" => 
                         saida <= x"4E"; -- N
                    WHEN "10" => 
                         saida <= x"41"; -- A
                    WHEN "11" => 
                         saida <= x"49"; -- I
                    WHEN OTHERS =>
                END CASE;
            ELSIF (data_counter = 3) THEN
                CASE data_reg(2 downto 0) IS
                    WHEN "000" =>
                         saida <= x"4F"; -- O
                    WHEN "001" => 
                         saida <= x"47"; -- G
                    WHEN "010" => 
                         saida <= x"4B"; -- K
                    WHEN "011" => 
                         saida <= x"44"; -- D
                    WHEN "100" => 
                         saida <= x"57"; -- W
                    WHEN "101" => 
                         saida <= x"52"; -- R
                    WHEN "110" => 
                         saida <= x"55"; -- U
                    WHEN "111" => 
                         saida <= x"53"; -- S
                    WHEN OTHERS =>
                END CASE;
              ELSIF (data_counter = 4) THEN
                 CASE data_reg IS
                    WHEN "0010" => 
                         saida <= x"51"; -- Q
                    WHEN "0011" => 
                         saida <= x"5A"; -- Z
                    WHEN "0100" => 
                         saida <= x"59"; -- Y
                    WHEN "0101" => 
                         saida <= x"43"; -- C
                    WHEN "0110" => 
                         saida <= x"58"; -- X
                    WHEN "0111" => 
                         saida <= x"42"; -- B
                    WHEN "1000" =>
                         saida <= x"4A"; -- J
                    WHEN "1001" => 
                         saida <= x"50"; -- P
                    WHEN "1011" => 
                         saida <= x"4C"; -- L
                    WHEN "1101" => 
                         saida <= x"46"; -- F
                    WHEN "1110" => 
                         saida <= x"56"; -- V
                    WHEN "1111" => 
                         saida <= x"48"; -- H 
                    WHEN OTHERS =>
                        saida <= x"FF"; -- INVALID 
                END CASE;
            END IF;
        END IF;
     END IF;
         
END PROCESS;

END Behavioral;



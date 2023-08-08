LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Decoder is 
port(S : in std_logic_vector( 1 downto 0);
notDEC : out std_logic_vector(2 downto 0)
);
end Decoder;

architecture architectural of Decoder is 
signal DEC : std_logic_vector(2 downto 0);

begin

DEC(0)<=not S(1) and not S(0);
DEC(1)<=not S(1) and S(0);
DEC(2)<=S(1) and not S(0);

notDEC(0)<=not DEC(0);
notDEC(1)<=not DEC(1);
notDEC(2)<=not DEC(2);
end architectural;
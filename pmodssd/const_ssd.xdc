# Pin assignments for 7-segment display (Pmod SSD) on Pmod JB and Pmod JC
set_property PACKAGE_PIN H18 [get_ports {seg[0]}]  # Segment A
set_property PACKAGE_PIN G18 [get_ports {seg[1]}]  # Segment B
set_property PACKAGE_PIN F18 [get_ports {seg[2]}]  # Segment C
set_property PACKAGE_PIN E18 [get_ports {seg[3]}]  # Segment D
set_property PACKAGE_PIN D18 [get_ports {seg[4]}]  # Segment E
set_property PACKAGE_PIN C18 [get_ports {seg[5]}]  # Segment F
set_property PACKAGE_PIN B18 [get_ports {seg[6]}]  # Segment G

# Pin assignments for 4-bit digit input (switches SW0-SW3)
set_property PACKAGE_PIN P17 [get_ports {sw[0]}]
set_property PACKAGE_PIN N17 [get_ports {sw[1]}]
set_property PACKAGE_PIN P16 [get_ports {sw[2]}]
set_property PACKAGE_PIN N16 [get_ports {sw[3]}]
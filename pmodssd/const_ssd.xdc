# Pin assignments for 7-segment display (Pmod SSD) on Pmod JB and Pmod JC
# First 7-segment display
set_property PACKAGE_PIN H18 [get_ports {seg1[0]}]  # Segment A (Display 1)
set_property PACKAGE_PIN G18 [get_ports {seg1[1]}]  # Segment B (Display 1)
set_property PACKAGE_PIN F18 [get_ports {seg1[2]}]  # Segment C (Display 1)
set_property PACKAGE_PIN E18 [get_ports {seg1[3]}]  # Segment D (Display 1)
set_property PACKAGE_PIN D18 [get_ports {seg1[4]}]  # Segment E (Display 1)
set_property PACKAGE_PIN C18 [get_ports {seg1[5]}]  # Segment F (Display 1)
set_property PACKAGE_PIN B18 [get_ports {seg1[6]}]  # Segment G (Display 1)

# Second 7-segment display
set_property PACKAGE_PIN H17 [get_ports {seg2[0]}]  # Segment A (Display 2)
set_property PACKAGE_PIN G17 [get_ports {seg2[1]}]  # Segment B (Display 2)
set_property PACKAGE_PIN F17 [get_ports {seg2[2]}]  # Segment C (Display 2)
set_property PACKAGE_PIN E17 [get_ports {seg2[3]}]  # Segment D (Display 2)
set_property PACKAGE_PIN D17 [get_ports {seg2[4]}]  # Segment E (Display 2)
set_property PACKAGE_PIN C17 [get_ports {seg2[5]}]  # Segment F (Display 2)
set_property PACKAGE_PIN B17 [get_ports {seg2[6]}]  # Segment G (Display 2)

# Pin assignments for 4-bit digit input (switches SW0-SW3)
set_property PACKAGE_PIN P17 [get_ports {sw[0]}]
set_property PACKAGE_PIN N17 [get_ports {sw[1]}]
set_property PACKAGE_PIN P16 [get_ports {sw[2]}]
set_property PACKAGE_PIN N16 [get_ports {sw[3]}]
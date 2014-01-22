"""NI-DAQmx base parsing of ports and lines """

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

import re

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

def parseports(lines):
    """
    Match strings of the form:

    Dev#/port#[:#][/line#[:#]]

    where the [...] are optional. This returns a list of the matched ports.
    """
    ports_array = []

    p = re.compile('^Dev(?P<d>\d+)/port(?P<p1>\d+)(:(?P<p2>\d+))?(/line(?P<l>\d+(:\d+)?))?$')
    for line in lines.split(','):
        m = p.match(line)
        if m:
            d, p1, p2, l = map(lambda g: m.group(g), ['d', 'p1', 'p2', 'l'])
            if p2:
                ports = range(int(p1), int(p2)+1)
            else:
                ports = [p1]
            if l:
                ports_array.extend(['Dev%s/port%s/line%s' % (d, port, l) for port in ports])
            else:
                ports_array.extend(['Dev%s/port%s' % (d, port) for port in ports])
    return ports_array

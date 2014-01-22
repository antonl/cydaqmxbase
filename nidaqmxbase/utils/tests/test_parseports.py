from nidaqmxbase.utils.parseports import parseports

def test_parseports():
    assert parseports('Dev0/port1') == ['Dev0/port1']
    assert parseports('Dev0/port1/line4') == ['Dev0/port1/line4']

def test_parseports_expand():
    assert parseports('Dev0/port1:2') == ['Dev0/port1', 'Dev0/port2']
    assert parseports('Dev0/port1:3') == ['Dev0/port1', 'Dev0/port2', 'Dev0/port3']
    assert parseports('Dev0/port1:2/line4:5') == ['Dev0/port1/line4:5', 'Dev0/port2/line4:5']

def test_parseports_comma():
    assert parseports('Dev0/port1,Dev0/port2') == ['Dev0/port1', 'Dev0/port2']
    assert parseports('Dev0/port1/line4,Dev0/port2') == ['Dev0/port1/line4', 'Dev0/port2']

def test_parseports_expand_comma():
    assert parseports('Dev0/port1:2,Dev1/port1:2') == ['Dev0/port1', 'Dev0/port2', 'Dev1/port1', 'Dev1/port2']
    assert parseports('Dev0/port1:2/line4,Dev1/port1') == ['Dev0/port1/line4', 'Dev0/port2/line4', 'Dev1/port1']

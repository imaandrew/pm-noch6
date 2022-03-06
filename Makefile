CC := cc
CFLAGS := -O3
ARMIPS := armips
CRC := ./crc

all: crc us jp

clean:
	$(RM) crc us/no_ch6-us.z64 us/no_ch6-jp.z64

crc: crc.c
	$(CC) $(CFLAGS) -o $@ $^

us: crc
	$(ARMIPS) -root $@ no_ch6.asm
	$(CRC) $@/no_ch6-us.z64

jp: crc
	$(ARMIPS) -root $@ no_ch6.asm
	$(CRC) $@/no_ch6-jp.z64

.PHONY: clean all us jp

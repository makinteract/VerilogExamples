#include <SPI.h>

const int CS_Pin = 10;
void setup()
{
  Serial.begin(9600);
  SPI.begin();
  pinMode(CS_Pin, OUTPUT); // The CS_Pin should remain in a high impedance state (INPUT) when it is not in use.
}

void loop()
{
  // SPI.transfer(0x97);
  // delay(500);

  // First Transaction at 1MHz and SPI mode 0
  for (int i = 0; i < 26; i++)
  {
    digitalWrite(CS_Pin, LOW);
    SPI.beginTransaction(SPISettings(100000, MSBFIRST, SPI_MODE0));
    uint8_t res = SPI.transfer('a' + i);
    Serial.println(res, DEC);
    SPI.endTransaction();
    digitalWrite(CS_Pin, HIGH);
    delay(300);
  }
}
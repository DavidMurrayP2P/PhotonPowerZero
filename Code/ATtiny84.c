#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/sleep.h>
#include <avr/wdt.h>


#define ADC_BATT_INPUT PB0    // Pin for the ADC input

#define PWR             PA7    // Pin for the LED
#define ACTIVE          PA6    // Pin for the LED
#define AP2161          PB0    // Pin when set low will trigger the Pi on
#define SHUTDOWN_PIN    PB2    // Trigger this pin to enable the Pi to gracefully shutdown

#define ALIVE_PIN_1     PA2
#define ALIVE_PIN_2     PA4

#define SHUTDOWN_PIN    PB2    // Trigger this pin to enable the Pi to gracefully shutdown

#define START_PIN       PA1
#define CLOCK_PIN       PA3
#define DATA_PIN        PA5

// Global variable using extern
uint8_t CLOCK_PIN_STATE;

void initADC()
{

   ADMUX =
            (0 << REFS1) |     // Sets ref. voltage to Vcc, bit 1   
            (0 << REFS0) |     // Sets ref. voltage to Vcc, bit 0
            (0 << MUX5)  |     // use ADC1 for input (PA1), MUX bit 5
            (0 << MUX4)  |     // use ADC1 for input (PA1), MUX bit 4
            (0 << MUX3)  |     // use ADC1 for input (PA1), MUX bit 3
            (0 << MUX2)  |     // use ADC1 for input (PA1), MUX bit 2
            (0 << MUX1)  |     // use ADC1 for input (PA1), MUX bit 1
            (0 << MUX0);       // use ADC1 for input (PA1), MUX bit 0

  ADCSRA = 
            (1 << ADEN)  |     // Enable ADC 
            (1 << ADPS2) |     // set prescaler to 16, bit 2 
            (0 << ADPS1) |     // set prescaler to 16, bit 1 
            (0 << ADPS0);      // set prescaler to 16, bit 0 
      
  ADCSRB = 
  //        (1 << ADLAR);      // left shift result (for 8-bit values)
            (0 << ADLAR);      // right shift result (for 10-bit values)
}

void Blink_LEDs() {
  for (int i=0;i<20;i++) {
    PORTA |= (1 << PWR);
    PORTA |= (1 << ACTIVE);
    _delay_ms(250);
    PORTA &= ~(1 << ACTIVE);
    PORTA &= ~(1 << PWR);        
    _delay_ms(250);
    }
}

bool start_pin_high() {
    if (PINA & (1 << START_PIN )) { //Has it been pulled high?
        return true;  // PA2 is high
        }
    else {
        return false; // PA2 is low
        }
    }
    
bool has_CLOCK_PIN_Changed() {
    // Read the current status of CLOCK_PIN
    uint8_t currentPinStatus = PINA & (1 << CLOCK_PIN);
  
    // Check if the pin status has changed from high to low or low to high
    if (currentPinStatus != CLOCK_PIN_STATE) {
        CLOCK_PIN_STATE = currentPinStatus;
        return true; // Pin status has changed
        } 
    else {
        return false; // Pin status is the same
        }
    }

void turn_on_pi() {
    PORTB &= ~(1 << AP2161);
    PORTA |= (1 << PWR);
    _delay_ms(100000); //100 seconds
    }

bool is_Pi_Power_On() {
    // Check if PA7 is set high and PB0 is set low
    if ((PINA & (1 << PWR)) && !(PINB & (1 << AP2161))) {
        return true;  // Conditions are met
        }
    else {
        return false; // Conditions are not met
        }
    }
   
bool is_Pi_Booted() {
    if (PINA & (1 << ALIVE_PIN_1 )) { //Has it been pulled high?
        return true;  // PA2 is high
        }
    else {
        return false; // PA2 is low
        }
    }

bool is_Pi_ready_for_data() {
    if (PINA & (1 << ALIVE_PIN_2 )) { //Has it been pulled high?
        return true; //PA4 is high
        }
    else {
        return false; //PA4 is low
        }
      
    }

void graceful_shutdown() {
    PORTB |= (1 << SHUTDOWN_PIN); // set high
    PORTA |= (1 << PWR);
    _delay_ms(500); 
    PORTB &= ~(1 << SHUTDOWN_PIN); // set low
    PORTA &= ~(1 << PWR);
    _delay_ms(500);
    PORTB |= (1 << SHUTDOWN_PIN); // set high
    PORTA |= (1 << PWR);
    _delay_ms(500); 
    PORTB &= ~(1 << SHUTDOWN_PIN); // set low
    PORTA &= ~(1 << PWR);
    _delay_ms(500);
    PORTB |= (1 << SHUTDOWN_PIN); // set high
    PORTA |= (1 << PWR);
    _delay_ms(500); 
    _delay_ms(10000);
    }


void turn_off_pi() {
    PORTB |= (1 << AP2161); // set high to switch off
    PORTA &= ~(1 << PWR); // set the LED to low
    PORTA &= ~(1 << ACTIVE); //set the state low
    // Calculate the number of sleep cycles for 1 hour (3600 seconds)
    for (int i=2; i>0; i--) { // So sleep for 2 hours
        _delay_ms(3500000); // 1 hour
        }
    }

void set_pins() {
    initADC();
    //Note DDRA or DDRB sets the pin status as an output and |= sets the default status as high
    DDRA |= (1 << PWR); //Set as an ouput Pin
    PORTA &= ~(1 << PWR); //set the state low
    DDRA |= (1 << ACTIVE);
    PORTA &= ~(1 << ACTIVE); //set the state low
    DDRB |= (1 << AP2161);
    PORTB |= (1 << AP2161); //set the state high
    DDRB |= (1 << SHUTDOWN_PIN);
    PORTB &= ~(1 << SHUTDOWN_PIN); //set the state low

    DDRA |= (1 << DATA_PIN); //Set as an ouput Pin
    DDRA |= (1 << CLOCK_PIN); //Set as an ouput Pin
    DDRA |= (1 << START_PIN); //Set as an ouput Pin
    

    DDRA &= ~(1 << ALIVE_PIN_1); //Set as an input Pin
    PORTA &= ~(1 << ALIVE_PIN_1); //Disable the internal pull-up resistor
    DDRA &= ~(1 << ALIVE_PIN_2); //Set as an input Pin
    PORTA &= ~(1 << ALIVE_PIN_2); //Disable the internal pull-up resistor
    

    CLOCK_PIN_STATE = (PINB & (1 << CLOCK_PIN)) >> CLOCK_PIN;
}

int get_voltage_from_adc() {
    uint16_t battery_voltage;
    ADCSRA |= (1 << ADSC);         // start ADC measurement
    
    while (ADCSRA & (1 << ADSC)); // wait till conversion complete 

    // Read ADC value
    uint16_t adcValue = ADC;

    // Apply suggested changes for better accuracy
    
    uint16_t sum = 0;
    uint8_t numReadings = 5; // Number of readings to average
    
    for (uint8_t i = 0; i < numReadings; i++) {
        ADCSRA |= (1 << ADSC);         // start ADC measurement
        while (ADCSRA & (1 << ADSC)); // wait till conversion complete 
        sum += ADC;
        }
        
    uint16_t average = sum / numReadings;

    // Scaling factor to scale 1024 into a no decimal place voltage and account for the voltage divider
    battery_voltage = average *0.586;
    return(battery_voltage); 
}

// Function to transmit a single bit to Raspberry Pi
void transmitBit(uint8_t bit) {
    // Set DATA_PIN according to the bit value
    if (bit) {
        PORTA |= (1 << DATA_PIN);
    } else {
        PORTA &= ~(1 << DATA_PIN);
    }
    
    // Toggle CLOCK_PIN to transmit the bit
    PORTA |= (1 << CLOCK_PIN);
    _delay_ms(50);
    PORTA &= ~(1 << CLOCK_PIN);
    _delay_ms(50);
}

// Function to transmit a 8-bit value to Raspberry Pi
void BitBang(uint8_t value) {
    // Transmit each bit (MSB first)
    // Toggle START_PIN to transmit the bytes
    PORTA |= (1 << CLOCK_PIN);
    _delay_ms(50);
    PORTA |= (1 << START_PIN);
    _delay_ms(50);
    PORTA &= ~(1 << START_PIN);
    _delay_ms(50);

    
    for (uint8_t i = 8; i > 0; i--) {
        uint8_t bit = (value >> i) & 0x01;
        transmitBit(bit);
    }
}

uint8_t BitShiftVoltage(uint16_t battery_voltage) {
    // Shift the voltage down by one place (divide by 2)
    uint16_t shifted_voltage = battery_voltage >> 1;
    
    // Ensure the value fits into a uint8_t
    uint8_t result;
    if (shifted_voltage > UINT8_MAX) {
        result = UINT8_MAX;  // If overflow, set to the maximum value of uint8_t
    } else {
        result = (uint8_t)shifted_voltage;
    }

    return result;
}

int main( void ) {

  set_pins();  
  uint16_t battery_voltage;
  uint8_t shifted_voltage;
  Blink_LEDs();
  
  while(1) {

    battery_voltage = get_voltage_from_adc();
    if (is_Pi_Power_On()) {
        if (is_Pi_Booted()) {
            if (is_Pi_ready_for_data()) {
                PORTA |= (1 << ACTIVE);
                shifted_voltage = BitShiftVoltage(battery_voltage);
                BitBang(shifted_voltage);
                _delay_ms(100);
                }
            else {
                PORTA &= ~(1 << ACTIVE); // set the LED to low
                }
            }
        else {
            graceful_shutdown();
            turn_off_pi(); 
            Blink_LEDs();
            }
        }
    else { // The Pi must be off
        if (battery_voltage > 375) {
            turn_on_pi();
            }
        else if (battery_voltage < 345) {
            graceful_shutdown();
            turn_off_pi();    
            } 
        else {
            //Do nothing
            }
        }
  }
}

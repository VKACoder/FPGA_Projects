module SevenSegment(
    input clkin,
    input reset,
    output reg [3:0] SegementSelect,
    output reg [7:0] SegementCode
    );
    reg [14:0] value;
    reg [7:0] BCD, ones, tens, hundreds, thousands, temp;
    wire clkout1, clkout2;
    
    ClkDiv clock1(clkin, 31'd 199999, clkout1); //Clock with period 4ms to change SegmentSelect reg.
    ClkDiv clock2(clkin, 31'd 799999, clkout2); //Clock with time period 16ms to up count
    
    always @ (posedge clkout1, negedge reset)
    begin
      if (!reset)
        begin
            SegementSelect <= 4'b 1111;
        end
        else
        begin
            if (SegementSelect[2:0] == 3'b 111)
                SegementSelect <= 4'b 1110;
            else
                SegementSelect <= (SegementSelect << 1) + 1'b 1; 
        end
    end
    
    //Up counter and Binary to unpacker BCD conversion
  always @ (posedge clkout2, negedge reset)
    begin
      if (value == 14'd 9999 || !reset)
            value <= 14'd 0;
        else
            value <= value + 1;
        thousands <= value / 1000;
        temp <= value % 1000;
        hundreds <= temp /100;
        temp <= temp % 100;
        tens <= temp /10;
        ones <= temp % 10;
    end
    
    always @ (SegementSelect)
    begin
        case (SegementSelect)
            4'b 1110:
                BCD <= ones;
            4'b 1101:
                BCD <= tens;
            4'b 1011:
                BCD <= hundreds;
            4'b 0111:
                BCD <= thousands;
            default:
                BCD <= 8'h FF;
        endcase
    end
    
    //BCD to Seven Segment Code conversion
    always @ (BCD)
    begin
        case (BCD)
            8'd 0:
                SegementCode <= 8'b 00000011;
            8'd 1:
                SegementCode <= 8'b 10011111;
            8'd 2:
                SegementCode <= 8'b 00100101;
            8'd 3:
                SegementCode <= 8'b 00001101;
            8'd 4:
                SegementCode <= 8'b 10011001;
            8'd 5:
                SegementCode <= 8'b 01001001;
            8'd 6:
                SegementCode <= 8'b 01000001;
            8'd 7:
                SegementCode <= 8'b 00011111;
            8'd 8:
                SegementCode <= 8'b 00000001;
            8'd 9:
                SegementCode <= 8'b 00001001;
            default:
                SegementCode <= 8'b 00000000;
        endcase
    end
endmodule

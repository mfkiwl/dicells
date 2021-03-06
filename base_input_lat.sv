/*
 * Copyright 2017 IBM Corporation
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Author: Andrew K Martin akmartin@us.ibm.com
 */
 
module base_input_lat#(parameter w=2, parameter d=1)
   (input clk,
    input 	   din,
    output [0:w-1] dout
    );

   generate
      if (w==1)
	begin
	   base_vlat#(.width(1)) is1_lat(.clk(clk),.reset(1'b0),.din(din),.q(dout));
	end
      else
	begin
	   wire [0:w-1]    s1_d;
	   base_vlat#(.width(w)) is1_lat(.clk(clk),.reset(1'b0),.din({din,s1_d[0:w-2]}),.q(s1_d));
	   base_delay#(.width(w),.n(d)) is2_lat(.clk(clk),.reset(1'b0),.i_d(s1_d),.o_d(dout));
	end
   endgenerate
endmodule // base_input_lat

				   


    


function packetizer_config(this_block)

  % Revision History:
  %
  %   28-Oct-2022  (20:44 hours):
  %     Original code was machine generated by Xilinx's System Generator after parsing
  %     /home/kiran/Desktop/gateware/hdl/packetizer.v
  %
  %

  this_block.setTopLevelLanguage('Verilog');

  this_block.setEntityName('packetizer');

  % System Generator has to assume that your entity  has a combinational feed through; 
  %   if it  doesn't, then comment out the following line:
  % this_block.tagAsCombinational;

  this_block.addSimulinkInport('arm');
  this_block.addSimulinkInport('ch_a_in');
  this_block.addSimulinkInport('ch_b_in');
  this_block.addSimulinkInport('rst');
  this_block.addSimulinkInport('sync_in');

  this_block.addSimulinkOutport('tx_data');
  this_block.addSimulinkOutport('tx_eof');
  this_block.addSimulinkOutport('tx_valid');

  tx_data_port = this_block.port('tx_data');
  tx_data_port.setType('UFix_64_0');
  tx_eof_port = this_block.port('tx_eof');
  tx_eof_port.setType('UFix_1_0');
  tx_eof_port.useHDLVector(false);
  tx_valid_port = this_block.port('tx_valid');
  tx_valid_port.setType('UFix_1_0');
  tx_valid_port.useHDLVector(false);

  % -----------------------------
  if (this_block.inputTypesKnown)
    % do input type checking, dynamic output type and generic setup in this code block.

    if (this_block.port('arm').width ~= 1);
      this_block.setError('Input data type for port "arm" must have width=1.');
    end

    this_block.port('arm').useHDLVector(false);

    if (this_block.port('ch_a_in').width ~= 16);
      this_block.setError('Input data type for port "ch_a_in" must have width=16.');
    end

    if (this_block.port('ch_b_in').width ~= 16);
      this_block.setError('Input data type for port "ch_b_in" must have width=16.');
    end

    if (this_block.port('rst').width ~= 1);
      this_block.setError('Input data type for port "rst" must have width=1.');
    end

    this_block.port('rst').useHDLVector(false);

    if (this_block.port('sync_in').width ~= 1);
      this_block.setError('Input data type for port "sync_in" must have width=1.');
    end

    this_block.port('sync_in').useHDLVector(false);

  end  % if(inputTypesKnown)
  % -----------------------------

  % -----------------------------
   if (this_block.inputRatesKnown)
     setup_as_single_rate(this_block,'clk','ce')
   end  % if(inputRatesKnown)
  % -----------------------------

    uniqueInputRates = unique(this_block.getInputRates);


  % Add addtional source files as needed.
  %  |-------------
  %  | Add files in the order in which they should be compiled.
  %  | If two files "a.vhd" and "b.vhd" contain the entities
  %  | entity_a and entity_b, and entity_a contains a
  %  | component of type entity_b, the correct sequence of
  %  | addFile() calls would be:
  %  |    this_block.addFile('b.vhd');
  %  |    this_block.addFile('a.vhd');
  %  |-------------

  %    this_block.addFile('');
  %    this_block.addFile('');
  this_block.addFile('hdl/unbuffered.v');
  this_block.addFile('hdl/fifo.v');
  this_block.addFile('hdl/packetizer.v');

return;


% ------------------------------------------------------------

function setup_as_single_rate(block,clkname,cename) 
  inputRates = block.inputRates; 
  uniqueInputRates = unique(inputRates); 
  if (length(uniqueInputRates)==1 & uniqueInputRates(1)==Inf) 
    block.addError('The inputs to this block cannot all be constant.'); 
    return; 
  end 
  if (uniqueInputRates(end) == Inf) 
     hasConstantInput = true; 
     uniqueInputRates = uniqueInputRates(1:end-1); 
  end 
  if (length(uniqueInputRates) ~= 1) 
    block.addError('The inputs to this block must run at a single rate.'); 
    return; 
  end 
  theInputRate = uniqueInputRates(1); 
  for i = 1:block.numSimulinkOutports 
     block.outport(i).setRate(theInputRate); 
  end 
  block.addClkCEPair(clkname,cename,theInputRate); 
  return; 

% ------------------------------------------------------------

function packetizer_config(this_block)
  this_block.setTopLevelLanguage('Verilog');
  this_block.setEntityName('packetizer');

  this_block.tagAsCombinational;

  this_block.addSimulinkInport('pol_a');
  this_block.addSimulinkInport('pol_b');
  this_block.addSimulinkInport('rst');
  this_block.addSimulinkInport('sync');

  this_block.addSimulinkOutport('tx_data');
  this_block.addSimulinkOutport('tx_eod');
  this_block.addSimulinkOutport('tx_valid');

  tx_data_port = this_block.port('tx_data');
  tx_data_port.setType('UFix_64_0');
  tx_eod_port = this_block.port('tx_eod');
  tx_eod_port.setType('Bool');
  tx_eod_port.useHDLVector(false);
  tx_valid_port = this_block.port('tx_valid');
  tx_valid_port.setType('Bool');
  tx_valid_port.useHDLVector(false);

  % -----------------------------
  if (this_block.inputTypesKnown)
    % do input type checking, dynamic output type and generic setup in this code block.
    if (this_block.port('pol_a').width ~= 16)
      this_block.setError('Input data type for port "pol_a" must have width=16.');
    end

    if (this_block.port('pol_b').width ~= 16)
      this_block.setError('Input data type for port "pol_b" must have width=16.');
    end

    if (this_block.port('rst').width ~= 1)
      this_block.setError('Input data type for port "rst" must have width=1.');
    end

    this_block.port('rst').useHDLVector(false);

    if (this_block.port('sync').width ~= 1)
      this_block.setError('Input data type for port "sync" must have width=1.');
    end

    this_block.port('sync').useHDLVector(false);

  end  % if(inputTypesKnown)
  % -----------------------------

  % -----------------------------
   if (this_block.inputRatesKnown)
     setup_as_single_rate(this_block,'clk','ce')
   end  % if(inputRatesKnown)
  % -----------------------------

    uniqueInputRates = unique(this_block.getInputRates);

  this_block.addFile('hdl/artifacts/fifo.v');
  this_block.addFile('hdl/artifacts/packetizer.v');

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


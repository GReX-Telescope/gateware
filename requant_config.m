function requant_config(this_block)
  this_block.setTopLevelLanguage('Verilog');
  this_block.setEntityName('requant');
  this_block.tagAsCombinational;

  this_block.addSimulinkInport('gain');
  this_block.addSimulinkInport('pol_a_in');
  this_block.addSimulinkInport('pol_b_in');
  this_block.addSimulinkInport('rst');
  this_block.addSimulinkInport('sync_in');

  this_block.addSimulinkOutport('addr');
  this_block.addSimulinkOutport('pol_a_overflow');
  this_block.addSimulinkOutport('pol_b_overflow');
  this_block.addSimulinkOutport('pol_a_out');
  this_block.addSimulinkOutport('pol_b_out');
  this_block.addSimulinkOutport('sync_out');

  addr_port = this_block.port('addr');
  addr_port.setType('UFix_11_0');
  
  overflow_a_port = this_block.port('pol_a_overflow');
  overflow_a_port.setType('Bool');
  overflow_a_port.useHDLVector(false);
  
  overflow_b_port = this_block.port('pol_b_overflow');
  overflow_b_port.setType('Bool');
  overflow_b_port.useHDLVector(false);
  
  pol_a_out_port = this_block.port('pol_a_out');
  pol_a_out_port.setType('UFix_16_0');
  
  pol_b_out_port = this_block.port('pol_b_out');
  pol_b_out_port.setType('UFix_16_0');
  
  sync_out_port = this_block.port('sync_out');
  sync_out_port.setType('Bool');
  sync_out_port.useHDLVector(false);

  % -----------------------------
  if (this_block.inputTypesKnown)
    % do input type checking, dynamic output type and generic setup in this code block.

    if (this_block.port('gain').width ~= 11)
      this_block.setError('Input data type for port "gain" must have width=11.');
    end

    if (this_block.port('pol_a_in').width ~=36)
      this_block.setError('Input data type for port "pol_a_in" must have width=36.');
    end
    
    if (this_block.port('pol_b_in').width ~=36)
      this_block.setError('Input data type for port "pol_b_in" must have width=36.');
    end

    if (this_block.port('rst').width ~= 1)
      this_block.setError('Input data type for port "rst" must have width=1.');
    end

    this_block.port('rst').useHDLVector(false);

    if (this_block.port('sync_in').width ~= 1)
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
  this_block.addFile('hdl/artifacts/requant.v');

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


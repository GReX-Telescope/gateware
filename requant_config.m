function requant_config(this_block)
  this_block.setTopLevelLanguage('Verilog');

  this_block.setEntityName('requant');

  this_block.addSimulinkInport('rst');
  this_block.addSimulinkInport('data_in');
  this_block.addSimulinkInport('sync_in');
  this_block.addSimulinkInport('gain');

  this_block.addSimulinkOutport('data_out');
  this_block.addSimulinkOutport('sync_out');
  this_block.addSimulinkOutport('addr');
  this_block.addSimulinkOutport('ovfl');

  sync_out_port = this_block.port('sync_out');
  sync_out_port.setType('UFix_1_0');
  sync_out_port.useHDLVector(false);
  
  ovfl_port = this_block.port('ovfl');
  ovfl_port.setType('UFix_1_0');
  ovfl_port.useHDLVector(false);
  
  data_out_port = this_block.port('data_out');
  data_out_port.setType('UFix_16_0');
  
  addr_port = this_block.port('addr');
  addr_port.setType('UFix_11_0');

  % -----------------------------
  if (this_block.inputTypesKnown)
    % do input type checking, dynamic output type and generic setup in this code block.

    if (this_block.port('rst').width ~= 1)
      this_block.setError('Input data type for port "rst" must have width=1.');
    end
    this_block.port('rst').useHDLVector(false);
    
    if (this_block.port('data_in').width ~= 36)
      this_block.setError('Input data type for port "data_in" must have width=36.');
    end
    
    if (this_block.port('sync_in').width ~= 1)
      this_block.setError('Input data type for port "sync_in" must have width=1.');
    end
    this_block.port('sync_in').useHDLVector(false);
    
    if (this_block.port('gain').width ~= 11)
      this_block.setError('Input data type for port "gain" must have width=11.');
    end
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


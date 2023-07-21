function vacc_config(this_block)
  this_block.setTopLevelLanguage('Verilog');
  this_block.setEntityName('vacc');
  this_block.addSimulinkInport('rst');
  this_block.addSimulinkInport('data_in');
  this_block.addSimulinkInport('sync');
  this_block.addSimulinkInport('trig');
  this_block.addSimulinkOutport('data_out');
  this_block.addSimulinkOutport('we');
  this_block.addSimulinkOutport('addr');

  we_port = this_block.port('we');
  we_port.setType('UFix_1_0');
  we_port.useHDLVector(false);
  
  data_out_port = this_block.port('data_out');
  data_out_port.setType('UFix_64_0');
  
  addr_port = this_block.port('addr');
  addr_port.setType('UFix_11_0');

  % -----------------------------
  if (this_block.inputTypesKnown)
    % do input type checking, dynamic output type and generic setup in this code block.

    if (this_block.port('rst').width ~= 1);
      this_block.setError('Input data type for port "rst" must have width=1.');
    end

    this_block.port('rst').useHDLVector(false);
    
    if (this_block.port('data_in').width ~= 32);
        this_block.setError('Input data type for port "data_in" must have width=32.');
    end
    if (this_block.port('sync').width ~= 1);
      this_block.setError('Input data type for port "sync" must have width=1.');
    end

    this_block.port('sync').useHDLVector(false);

    if (this_block.port('trig').width ~= 1);
      this_block.setError('Input data type for port "trig" must have width=1.');
    end

    this_block.port('trig').useHDLVector(false);

  end  % if(inputTypesKnown)
  % -----------------------------

  % -----------------------------
   if (this_block.inputRatesKnown)
     setup_as_single_rate(this_block,'clk','ce')
   end  % if(inputRatesKnown)
  % -----------------------------

    uniqueInputRates = unique(this_block.getInputRates);

  % (!) Custimize the following generic settings as appropriate. If any settings depend
  %      on input types, make the settings in the "inputTypesKnown" code block.
  %      The addGeneric function takes  3 parameters, generic name, type and constant value.
  %      Supported types are boolean, real, integer and string.
  this_block.addGeneric('ACCUMULATIONS','integer','262144');
  this_block.addGeneric('VECTOR_WIDTH','integer','11');
  this_block.addGeneric('INPUT_WIDTH','integer','32');
  this_block.addGeneric('OUTPUT_WIDTH','integer','64');

  this_block.addFile('hdl/artifacts/dpram.v');
  this_block.addFile('hdl/artifacts/vacc.v');

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


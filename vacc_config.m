function vacc_config(this_block)
this_block.setTopLevelLanguage('Verilog');
this_block.setEntityName('vacc');

% Grab HDL parameters from simulink mask
blockName = this_block.blockName;
bb_mask = get_param(blockName,'Parent');
input_n = str2num(get_param(bb_mask,'input_n'));
addr_n = str2num(get_param(bb_mask,'addr_n'));
out_n = str2num(get_param(bb_mask,'out_n'));

% Declare input ports
this_block.addSimulinkInport('rst');
this_block.addSimulinkInport('acc_n');
this_block.addSimulinkInport('data_in');
this_block.addSimulinkInport('sync');
this_block.addSimulinkInport('trig');

% Declare output ports
this_block.addSimulinkOutport('data_out');
this_block.addSimulinkOutport('we');
this_block.addSimulinkOutport('addr');

% Check inputs, set outputs
if (this_block.inputTypesKnown)
    % Check inputs
    check_width(this_block, 'rst', 1);
    check_width(this_block, 'acc_n', 32);
    check_width(this_block, 'data_in', input_n);
    check_width(this_block, 'sync', 1);
    check_width(this_block, 'trig', 1);
    % Set outputs
    set_width(this_block, 'data_out', out_n);
    set_width(this_block, 'we', 1);
    set_width(this_block, 'addr', addr_n);
end

% Check rates
if (this_block.inputRatesKnown)
    setup_as_single_rate(this_block,'clk','ce')
end
uniqueInputRates = unique(this_block.getInputRates);

% Add generics
this_block.addGeneric('VECTOR_WIDTH','integer',num2str(addr_n));
this_block.addGeneric('INPUT_WIDTH','integer',num2str(input_n));
this_block.addGeneric('OUTPUT_WIDTH','integer',num2str(out_n));

% Add Files
this_block.addFile('hdl/artifacts/dpram.v');
this_block.addFile('hdl/artifacts/vacc.v');
return;

function check_width(block, name, width)
port = block.port(name);
portWidth = port.width;
if (portWidth ~= width)
    block.setError(sprintf('Input data type for port "%s" must have width=%d, it currently is %d', name, width, portWidth));
end
if (width == 1)
    port.useHDLVector(false);
end
return;

function set_width(block, name, width)
port = block.port(name);
port.setWidth(width);
if (width == 1)
    port.useHDLVector(false);
end
return;

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

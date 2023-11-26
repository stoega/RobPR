function make_inverse_single(varargin)
    if(nargin > 0)
        target = varargin{1};
    else
        disp('No target specified, making "all".');
        target = 'all';
    end
    switch target
        case 'all'
            make_inverse_single('mfun_model')
        case 'clean'
            w = warning(); % avoid MATLAB's warning the file to be deleted does not exist
            warning('off', 'all');
            warning(w);
        case 'mfun_model'
            w = warning();
            warning('off', 'all'); % avoid MATLAB's warning the file to be deleted does not exist
            delete('SimCodeGen_mfun_model.slx')
            warning(w);
            model_h = new_system('SimCodeGen_mfun_model');
            try
                add_block('simulink/Ports & Subsystems/Subsystem', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model');
                delete_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', 'In1/1', 'Out1/1');
                delete_block(['SimCodeGen_mfun_model/SimCodeGen_mfun_model', '/In1']);
                delete_block(['SimCodeGen_mfun_model/SimCodeGen_mfun_model', '/Out1']);
                add_block('simulink/Sources/In1', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_input_1');
                u_ph(1) = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_input_1', 'PortHandles');
                add_block('simulink/Sinks/Out1', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_output_1');
                y_ph(1) = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_output_1', 'PortHandles');
                mask_h = Simulink.Mask.create('SimCodeGen_mfun_model/SimCodeGen_mfun_model');
                set_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model', 'MaskDisplay',['port_label(''input'', 1, ''u'');', char(10), 'port_label(''output'', 1, ''x_ss'');', char(10)]);
                mask_h.addParameter('Name', 'SC_param_0', 'Prompt', 'params', 'Value', 'params');
                mask_h.addParameter('Name', 'SC_x1_ic', 'Prompt', 'SC_x1_ic', 'Value', 'x1_ic');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun');
                blockHandle.Script = ['function [SC_state_dot] = dyn_fun(SC_state, SC_input_0, SC_param_0)', char(10), '    SC_state_dot = zeros(4, 1);', char(10), '    SC_state_x_0 = SC_state(1:4);', char(10), '    SC_eval = zeros(4,1);', char(10), '    SC_eval(1) = SC_state_x_0(3);', char(10), '    SC_eval(2) = SC_state_x_0(4);', char(10), '    t1 = SC_param_0(2);', char(10), '    t2 = SC_state_x_0(2);', char(10), '    t3 = cos(t2);', char(10), '    t4 = t3 ^ 2;', char(10), '    t5 = SC_param_0(3);', char(10), '    t6 = SC_eval(1);', char(10), '    t7 = t6 ^ 2;', char(10), '    t8 = SC_param_0(6);', char(10), '    t9 = t8 * t7;', char(10), '    t11 = (t8 ^ 2);', char(10), '    t15 = SC_param_0(8);', char(10), '    t10 = SC_eval(2);', char(10), '    t19 = t10 ^ 2;', char(10), '    t24 = sin(t2);', char(10), '    t27 = SC_param_0(9);', char(10), '    t28 = t27 * SC_input_0(1);', char(10), '    t30 = (t5 ^ 2);', char(10), '    t33 = t24 ^ 2;', char(10), '    t36 = t27 ^ 2;', char(10), '    t37 = t36 * SC_param_0(10);', char(10), '    t40 = SC_param_0(5) ^ 2;', char(10), '    t41 = t40 * SC_param_0(1);', char(10), '    t42 = SC_param_0(7);', char(10), '    SC_eval(3) = (t1 * (t9 * t5 * t4 + (-(2 * t10 * t11 * t6) + t15 * t5) * t3 - t8 * t19 * t5) * t24 + t28) / (t33 * (t30 + t11) * t1 + t37 + t41 + t42);', char(10), '    t47 = t33 * t11 * t1;', char(10), '    t50 = t1 * t30;', char(10), '    SC_eval(4) = 0.1e1 / t8 / (-t1 * t30 * t4 + t37 + t41 + t42 + t47 + t50) * (-t3 * t5 * (t8 * (0.2e1 * t3 * t6 * t8 + t10 * t5) * t10 * t24 * t1 - t28) + t24 * (t3 * t9 + t15) * (t47 + t37 + t50 + t41 + t42));', char(10), '    SC_state_dot(1:4) = SC_eval(1:4);', char(10), 'end'];
                blockHandle.Inputs(end-0).Scope = 'Parameter';
                blockHandle.Inputs(end-0).Props.Array.Size = '[10]';
                blockHandle.Inputs(1).Props.Array.Size = '[4]';
                blockHandle.Inputs(2).Props.Array.Size = '[1]';
                blockHandle.Outputs(1).Props.Array.Size = '[4]';
                add_block('simulink/Continuous/Integrator', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/int_to_x', 'InitialCondition', '[SC_x1_ic]');
                int_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/int_to_x', 'PortHandles');
                dyn_fun_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun', 'PortHandles');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle.Script = ['function [SC_output_0] = y_fun(SC_state, SC_param_0)', char(10), '    SC_output_0 = zeros(4,1);', char(10), '    SC_state_x_0 = SC_state(1:4);', char(10), '    SC_output_0(1) = SC_state_x_0(1);', char(10), '    SC_output_0(2) = SC_state_x_0(2);', char(10), '    SC_output_0(3) = SC_state_x_0(3);', char(10), '    SC_output_0(4) = SC_state_x_0(4);', char(10), 'end'];
                blockHandle.Inputs(end-0).Props.Array.Size = '[10]';
                blockHandle.Inputs(end-0).Scope = 'Parameter';
                blockHandle.Inputs(1).Props.Array.Size = '[4]';
                blockHandle.Outputs(1).Props.Array.Size = '[4]';
                y_fun_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun', 'PortHandles');
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', u_ph(1).Outport(1), dyn_fun_ph.Inport(2));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', dyn_fun_ph.Outport(1), int_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', int_ph.Outport(1), y_fun_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', int_ph.Outport(1), dyn_fun_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', y_fun_ph.Outport(1), y_ph(1).Inport(1));
                if ~verLessThan('matlab','9.4')
                    model_ws_h = get_param('SimCodeGen_mfun_model','modelworkspace');
                    model_ws_h.assignin('params', zeros(10, 1));
                    model_ws_h.assignin('x1_ic', zeros(4, 1));
                    open_system('SimCodeGen_mfun_model/SimCodeGen_mfun_model', 'force');
                    Simulink.BlockDiagram.arrangeSystem('SimCodeGen_mfun_model/SimCodeGen_mfun_model');
                    clear(model_ws_h);
                    open_system('SimCodeGen_mfun_model', 'force');
                end
                save_system(model_h);
                close_system(model_h);
            catch
                close_system(model_h,0);
            end
        otherwise
            error(['Unknown target "', target, '".']);
    end
            
end

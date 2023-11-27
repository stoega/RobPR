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
                blockHandle.Script = ['function [SC_state_dot] = dyn_fun(SC_state, SC_input_0, SC_param_0)', char(10), '    SC_state_dot = zeros(4, 1);', char(10), '    SC_state_x_0 = SC_state(1:4);', char(10), '    SC_eval = zeros(4,1);', char(10), '    SC_eval(1) = SC_state_x_0(3);', char(10), '    SC_eval(2) = SC_state_x_0(4);', char(10), '    t1 = SC_state_x_0(2);', char(10), '    t2 = cos(t1);', char(10), '    t3 = t2 ^ 2;', char(10), '    t4 = SC_param_0(3);', char(10), '    t5 = SC_eval(1);', char(10), '    t6 = t5 ^ 2;', char(10), '    t7 = SC_param_0(6);', char(10), '    t8 = (t7 ^ 2);', char(10), '    t9 = SC_eval(2);', char(10), '    t11 = (t5 * t9);', char(10), '    t13 = (SC_param_0(4) ^ 2);', char(10), '    t18 = SC_param_0(8);', char(10), '    t23 = t9 ^ 2;', char(10), '    t26 = t13 + 12 * t8;', char(10), '    t31 = SC_param_0(2);', char(10), '    t32 = sin(t1);', char(10), '    t36 = SC_input_0(1);', char(10), '    t37 = SC_param_0(9);', char(10), '    t41 = t4 ^ 2;', char(10), '    t45 = t32 ^ 2;', char(10), '    t51 = SC_param_0(5) ^ 2;', char(10), '    t52 = t51 * SC_param_0(1);', char(10), '    t53 = t37 ^ 2;', char(10), '    t55 = SC_param_0(10) * t53;', char(10), '    t56 = SC_param_0(7);', char(10), '    t57 = (t52 + t55 + t56);', char(10), '    t60 = t41 * t31;', char(10), '    t61 = (t52 + t60 + t55 + t56);', char(10), '    SC_eval(3) = 0.1e1 / (0.12e2 * t45 * t31 * (t41 + t13 / 0.12e2 + t8) * t8 + (12 * t8 * t57) + (t61 * t13)) * (0.12e2 * t32 * t31 * t7 * (t8 * t6 * t4 * t3 + t2 * (-(t13 * t11) / 0.6e1 - (2 * t8 * t11) + t4 * t18) * t7 - t26 * t4 * t23 / 0.12e2) + (t26 * t37 * t36));', char(10), '    t65 = t8 * t31;', char(10), '    t70 = t8 * t3;', char(10), '    SC_eval(4) = 0.12e2 * t7 * (t45 * t32 * (t2 * t6 * t7 + t18) * t65 + (-0.2e1 * t4 * t31 * t5 * t9 * t70 + t2 * (t31 * (t6 - t23) * t41 + t57 * t6) * t7 + t61 * t18) * t32 + t4 * t37 * t2 * t36) / (t26 * t45 * t65 + (t26 * t61) - 0.12e2 * t60 * t70);', char(10), '    SC_state_dot(1:4) = SC_eval(1:4);', char(10), 'end'];
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

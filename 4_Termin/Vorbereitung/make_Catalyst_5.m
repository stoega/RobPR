function make_Catalyst_5(varargin)
    if(nargin > 0)
        target = varargin{1};
    else
        disp('No target specified, making "all".');
        target = 'all';
    end
    switch target
        case 'all'
            make_Catalyst_5('mfun_model')
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
                mask_h.addParameter('Name', 'SC_param_0', 'Prompt', 'params_CRS', 'Value', 'params_CRS');
                mask_h.addParameter('Name', 'SC_x1_ic', 'Prompt', 'SC_x1_ic', 'Value', 'x1_ic');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun');
                blockHandle.Script = ['function [SC_state_dot] = dyn_fun(SC_state, SC_input_0, SC_param_0)', char(10), '    SC_state_dot = zeros(6, 1);', char(10), '    SC_state_x_0 = SC_state(1:6);', char(10), '    SC_eval = zeros(6,1);', char(10), '    SC_eval(1) = SC_state_x_0(4);', char(10), '    SC_eval(2) = SC_state_x_0(5);', char(10), '    SC_eval(3) = SC_state_x_0(6);', char(10), '    t1 = SC_state_x_0(3);', char(10), '    t2 = cos(t1);', char(10), '    t3 = t2 ^ 2;', char(10), '    t4 = SC_param_0(3);', char(10), '    t6 = SC_param_0(5);', char(10), '    t7 = t6 ^ 2;', char(10), '    t9 = SC_param_0(6);', char(10), '    t10 = t9 * t4;', char(10), '    t11 = t2 * t6;', char(10), '    t12 = SC_state_x_0(2);', char(10), '    t13 = sin(t12);', char(10), '    t17 = t13 ^ 2;', char(10), '    t18 = t9 ^ 2;', char(10), '    t21 = SC_param_0(2);', char(10), '    t23 = SC_param_0(4);', char(10), '    t24 = t23 ^ 2;', char(10), '    t26 = SC_param_0(9);', char(10), '    t27 = cos(t12);', char(10), '    t28 = t27 ^ 2;', char(10), '    t30 = SC_param_0(12);', char(10), '    t31 = sin(t1);', char(10), '    t32 = t31 ^ 2;', char(10), '    t34 = SC_param_0(15);', char(10), '    t35 = t34 ^ 2;', char(10), '    t38 = SC_param_0(10);', char(10), '    t40 = SC_param_0(13);', char(10), '    t48 = t24 * t21;', char(10), '    t49 = t18 * t4;', char(10), '    t50 = t48 + t49 - t26 + t38;', char(10), '    t56 = t4 * t6;', char(10), '    t58 = t7 * t4;', char(10), '    t59 = t58 - t30 + t40;', char(10), '    t14 = SC_eval(1);', char(10), '    t15 = SC_eval(2);', char(10), '    t41 = SC_eval(3);', char(10), '    t53 = t18 * t4;', char(10), '    t55 = t24 * t21;', char(10), '    t60 = t7 * t4;', char(10), '    SC_eval(4) = 0.1e1 / (0.2e1 * t10 * t11 * t13 + t17 * t38 + t17 * t53 + t17 * t55 + t26 * t28 + t3 * t40 + t3 * t60 + t30 * t32 + t35 * SC_param_0(18) + SC_param_0(8)) * (t34 * SC_input_0(1) - 0.2e1 * ((t11 * t10 + t13 * t50) * t15 * t27 - t41 * (t13 * t56 * t9 + t2 * t59) * t31) * t14);', char(10), '    t68 = SC_param_0(17);', char(10), '    t69 = t68 ^ 2;', char(10), '    t70 = SC_param_0(20);', char(10), '    t71 = t70 * t69;', char(10), '    t72 = SC_param_0(14);', char(10), '    t74 = t1 + t12;', char(10), '    t75 = sin(t74);', char(10), '    t76 = t75 ^ 2;', char(10), '    t78 = t4 ^ 2;', char(10), '    t81 = SC_param_0(19);', char(10), '    t83 = SC_param_0(16);', char(10), '    t84 = t83 ^ 2;', char(10), '    t87 = t81 * t84;', char(10), '    t98 = SC_param_0(11);', char(10), '    t80 = t7 * t78;', char(10), '    t108 = t21 * t24 * t4 * t7 + t69 * t70 * t81 * t84 - t18 * t76 * t80 + t69 * t70 * t98 + t72 * t81 * t84 + t18 * t80 + t48 * t71 + t49 * t71 + t53 * t72 + t55 * t72 + t58 * t87 + t60 * t98 + t72 * t98;', char(10), '    t109 = 0.1e1 / t108;', char(10), '    t113 = t14 ^ 2;', char(10), '    t116 = cos(-t1 + t12);', char(10), '    t119 = t116 * t113 * t9 * t56 / 0.2e1;', char(10), '    t122 = sin(0.2e1 * t12);', char(10), '    t125 = t41 ^ 2;', char(10), '    t129 = cos(t74);', char(10), '    t133 = SC_param_0(1);', char(10), '    t138 = t83 * SC_input_0(2) + t119 + t122 * t50 * t113 / 0.2e1 + t129 * (t113 + 0.2e1 * t125) * t6 * t10 / 0.2e1 + t13 * (t21 * t23 + t10) * t133;', char(10), '    t140 = t75 * t56;', char(10), '    t141 = t109 * t9;', char(10), '    t146 = sin(0.2e1 * t1);', char(10), '    t149 = t15 ^ 2;', char(10), '    t158 = t68 * SC_input_0(3) - t119 - t146 * t59 * t113 / 0.2e1 - t6 * t4 * (-t129 * t9 * (t149 + t113 / 0.2e1) + t133 * t2);', char(10), '    SC_eval(5) = t138 * t109 * (t58 + t71 + t72) + t158 * t141 * t140;', char(10), '    SC_eval(6) = t138 * t141 * t140 + t158 * t109 * (t48 + t49 + t87 + t98);', char(10), '    SC_state_dot(1:6) = SC_eval(1:6);', char(10), 'end'];
                blockHandle.Inputs(end-0).Scope = 'Parameter';
                blockHandle.Inputs(end-0).Props.Array.Size = '[20]';
                blockHandle.Inputs(1).Props.Array.Size = '[6]';
                blockHandle.Inputs(2).Props.Array.Size = '[3]';
                blockHandle.Outputs(1).Props.Array.Size = '[6]';
                add_block('simulink/Continuous/Integrator', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/int_to_x', 'InitialCondition', '[SC_x1_ic]');
                int_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/int_to_x', 'PortHandles');
                dyn_fun_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/dyn_fun', 'PortHandles');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle.Script = ['function [SC_output_0] = y_fun(SC_state, SC_param_0)', char(10), '    SC_output_0 = zeros(6,1);', char(10), '    SC_state_x_0 = SC_state(1:6);', char(10), '    SC_output_0(1) = SC_state_x_0(1);', char(10), '    SC_output_0(2) = SC_state_x_0(2);', char(10), '    SC_output_0(3) = SC_state_x_0(3);', char(10), '    SC_output_0(4) = SC_state_x_0(4);', char(10), '    SC_output_0(5) = SC_state_x_0(5);', char(10), '    SC_output_0(6) = SC_state_x_0(6);', char(10), 'end'];
                blockHandle.Inputs(end-0).Props.Array.Size = '[20]';
                blockHandle.Inputs(end-0).Scope = 'Parameter';
                blockHandle.Inputs(1).Props.Array.Size = '[6]';
                blockHandle.Outputs(1).Props.Array.Size = '[6]';
                y_fun_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun', 'PortHandles');
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', u_ph(1).Outport(1), dyn_fun_ph.Inport(2));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', dyn_fun_ph.Outport(1), int_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', int_ph.Outport(1), y_fun_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', int_ph.Outport(1), dyn_fun_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', y_fun_ph.Outport(1), y_ph(1).Inport(1));
                if ~verLessThan('matlab','9.4')
                    model_ws_h = get_param('SimCodeGen_mfun_model','modelworkspace');
                    model_ws_h.assignin('params_CRS', zeros(20, 1));
                    model_ws_h.assignin('x1_ic', zeros(6, 1));
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

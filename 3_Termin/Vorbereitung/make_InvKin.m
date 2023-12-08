function make_InvKin(varargin)
    if(nargin > 0)
        target = varargin{1};
    else
        disp('No target specified, making "all".');
        target = 'all';
    end
    switch target
        case 'all'
            make_InvKin('mfun_model')
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
                add_block('simulink/Sources/In1', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_input_2');
                u_ph(2) = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_input_2', 'PortHandles');
                add_block('simulink/Sinks/Out1', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_output_1');
                y_ph(1) = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/SC_output_1', 'PortHandles');
                mask_h = Simulink.Mask.create('SimCodeGen_mfun_model/SimCodeGen_mfun_model');
                set_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model', 'MaskDisplay',['port_label(''input'', 1, ''r_E'');', char(10), 'port_label(''input'', 2, ''up'');', char(10), 'port_label(''output'', 1, ''q'');', char(10)]);
                mask_h.addParameter('Name', 'SC_param_0', 'Prompt', 'params', 'Value', 'params');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle.Script = ['function [SC_output_0] = y_fun(SC_input_0, SC_input_1, SC_param_0)', char(10), '    SC_output_0 = zeros(3,1);', char(10), '    t1 = SC_input_0(3);', char(10), '    t2 = SC_input_0(1);', char(10), '    SC_output_0(1) = atan2(t1, t2);', char(10), '    t4 = SC_input_0(2);', char(10), '    t5 = t2 ^ 2;', char(10), '    t6 = t1 ^ 2;', char(10), '    t8 = sqrt(t5 + t6);', char(10), '    t9 = atan2(t4, t8);', char(10), '    t10 = SC_param_0(2);', char(10), '    t11 = t4 ^ 2;', char(10), '    t13 = sqrt(t5 + t11 + t6);', char(10), '    t16 = SC_param_0(1);', char(10), '    t17 = t16 ^ 2;', char(10), '    t18 = t10 ^ 2;', char(10), '    t19 = -t5 - t11 - t6 + t17 + t18;', char(10), '    t20 = t19 ^ 2;', char(10), '    t26 = sqrt(0.4e1 - 0.1e1 / t18 / t17 * t20);', char(10), '    t29 = asin(t26 / t13 * t10 / 0.2e1);', char(10), '    t31 = (-1) ^ SC_input_1(1);', char(10), '    t32 = t31 * t29;', char(10), '    SC_output_0(2) = pi / 0.2e1 - t9 + t32;', char(10), '    t38 = acos(0.1e1 / t10 / t16 * t19 / 0.2e1);', char(10), '    SC_output_0(3) = t9 - t32 + t31 * (pi - t38);', char(10), 'end'];
                blockHandle.Inputs(end-0).Props.Array.Size = '[2]';
                blockHandle.Inputs(end-0).Scope = 'Parameter';
                blockHandle.Inputs(1).Props.Array.Size = '[3]';
                blockHandle.Inputs(2).Props.Array.Size = '[1]';
                blockHandle.Outputs(1).Props.Array.Size = '[3]';
                y_fun_ph = get_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun', 'PortHandles');
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', u_ph(1).Outport(1), y_fun_ph.Inport(1));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', u_ph(2).Outport(1), y_fun_ph.Inport(2));
                add_line('SimCodeGen_mfun_model/SimCodeGen_mfun_model', y_fun_ph.Outport(1), y_ph(1).Inport(1));
                if ~verLessThan('matlab','9.4')
                    model_ws_h = get_param('SimCodeGen_mfun_model','modelworkspace');
                    model_ws_h.assignin('params', zeros(2, 1));
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

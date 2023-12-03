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
                set_param('SimCodeGen_mfun_model/SimCodeGen_mfun_model', 'MaskDisplay',['port_label(''input'', 1, ''r_E'');', char(10), 'port_label(''input'', 2, ''down'');', char(10), 'port_label(''output'', 1, ''q'');', char(10)]);
                mask_h.addParameter('Name', 'SC_param_0', 'Prompt', 'params', 'Value', 'params');
                add_block('simulink/User-Defined Functions/MATLAB Function', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', 'Path', 'SimCodeGen_mfun_model/SimCodeGen_mfun_model/output_fun');
                blockHandle.Script = ['function [SC_output_0] = y_fun(SC_input_0, SC_input_1, SC_param_0)', char(10), '    SC_output_0 = zeros(3,1);', char(10), '    SC_output_0(1) = atan2(SC_input_0(3), SC_input_0(1));', char(10), '    if (SC_input_1(1) == 0)', char(10), '      s1 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) - asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '    else', char(10), '      s1 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) + asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '    end', char(10), '    SC_output_0(2) = s1;', char(10), '    if (SC_input_1(1) == 0)', char(10), '      if (SC_input_1(1) == 0)', char(10), '        s3 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) - asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '      else', char(10), '        s3 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) + asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '      end', char(10), '      s2 = -pi / 0.2e1 - s3 + acos((-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) / SC_param_0(1) / SC_param_0(2) / 0.2e1);', char(10), '    else', char(10), '      if (SC_input_1(1) == 0)', char(10), '        s4 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) - asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '      else', char(10), '        s4 = pi / 0.2e1 - atan2(SC_input_0(2), SC_input_0(1) / cos(atan2(SC_input_0(3), SC_input_0(1)))) + asin(SC_param_0(2) * (SC_input_0(1) ^ 2 + SC_input_0(2) ^ 2 + SC_input_0(3) ^ 2) ^ (-0.1e1 / 0.2e1) * sqrt(0.4e1 - (-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) ^ 2 / SC_param_0(1) ^ 2 / SC_param_0(2) ^ 2) / 0.2e1);', char(10), '      end', char(10), '      s2 = 0.3e1 / 0.2e1 * pi - s4 - acos((-SC_input_0(1) ^ 2 - SC_input_0(2) ^ 2 - SC_input_0(3) ^ 2 + SC_param_0(1) ^ 2 + SC_param_0(2) ^ 2) / SC_param_0(1) / SC_param_0(2) / 0.2e1);', char(10), '    end', char(10), '    SC_output_0(3) = s2;', char(10), 'end'];
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

function [ q , q_p , q_pp , t_end ] = Traj_TrapezVel( t_absolute , q0 , q1 , v_max , a_max )

	TRAJ_NO_LIM			= uint16(1);
	TRAJ_VEL_LIM		= uint16(2);

	delta_q = abs(q1-q0);
    
    if delta_q > 0

        vorz = sign(q1-q0);

        %------------------------------------------------------------------
        % T t_free bestimmen
        %------------------------------------------------------------------

        % Annahme: Geschwindikeitsgrenze nicht erreicht
		T = 0.1e1 / a_max * sqrt(a_max * delta_q);
        v = sqrt(a_max * delta_q);

        % Überprüfung, ob Geschwindigkeitsgrenze erreicht
        if v <= v_max
            % Geschwindikeitsgrenze nicht erreicht
			
			t_free = 0;
			traj_type = TRAJ_NO_LIM;

        else
            % Geschwindikeitsgrenze erreicht

			T = v_max / a_max;
			t_free = (a_max * delta_q - v_max ^ 2) / a_max / v_max;
			traj_type = TRAJ_VEL_LIM;

        end

        %------------------------------------------------------------------
        % aktuellen Zeitpunkt auswerten
        %------------------------------------------------------------------

		switch traj_type

            %--------------------------------------------------------------
            case TRAJ_VEL_LIM
            %--------------------------------------------------------------
                if t_absolute < 0
                    
                    result_vec = [ 0 0 0 ];
					
                elseif t_absolute < T
                    t = t_absolute;

					result_vec = [a_max * t ^ 2 / 0.2e1 a_max * t a_max];
					
                elseif t_absolute < T+t_free  
                    t = t_absolute - T;

					result_vec = [a_max * T ^ 2 / 0.2e1 + v_max * t v_max 0 ];
					
                elseif t_absolute < 2*T+t_free
                    t = t_absolute - (T+t_free);
                    
					result_vec = [-a_max * (-T ^ 2 + t ^ 2) / 0.2e1 + v_max * (t + t_free) -a_max * t + v_max -a_max ];
					
                else
                    result_vec = [ delta_q 0 0 ];   
                end


            %--------------------------------------------------------------
            otherwise % TRAJ_NO_LIM
            %--------------------------------------------------------------
				if t_absolute < 0
                    
                    result_vec = [ 0 0 0 ];
                    
                elseif t_absolute < T
                    t = t_absolute;

					result_vec = [a_max * t ^ 2 / 0.2e1 a_max * t a_max ];
					
                elseif t_absolute < 2*T 
                    t = t_absolute - T;
                    
					result_vec = [-a_max * (-T ^ 2 + t ^ 2) / 0.2e1 + a_max * T * t -a_max * (-T + t) -a_max ];
					
                else
                    result_vec = [ delta_q 0 0 ];   
			end
		end
		
		pos = result_vec(1);
		vel = result_vec(2);
		acc = result_vec(3);


        q      = q0 + vorz*pos;
        q_p    = vorz*vel;
        q_pp   = vorz*acc;

        t_end = 2*T+t_free;    

    else % q0 == q1
        q = q1;
        q_p = 0;
        q_pp = 0;

        t_end = 0;   
    end

end

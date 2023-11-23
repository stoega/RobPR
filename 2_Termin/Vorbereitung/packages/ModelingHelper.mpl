ModelingHelperPackage := module()
    option package;
    # modeling functions
    export Spin, Jacobi;
    # helper class
    export ModelingHelper := proc()
        description "robin ModelingHelper object factory";
        return module()
            option object;
            uses LinearAlgebra;
            local time_vars, subs_to_time, subs_from_time;
            local update_time_subs;
            local MakeTimeVar;
            # interface functions
            export add_time_var, diff_t;
            # init members
            time_vars := [];
            # member class implementations
            MakeTimeVar := proc(name_in, dim_in, der_in)
                description "MakeTimeVar object factory";
                return module()
                    option object;
                    export name, dim, der;
                    name := cat("", name_in);
                    dim := dim_in;
                    der := der_in;
                end module;
            end proc;
            # member function implementation
            diff_t := proc(expr)
                if type(expr, scalar) then
                    return subs(subs_from_time, diff(eval(subs(subs_to_time, expr)), t));
                else
                    return subs(subs_from_time, map(diff, eval(subs(subs_to_time, expr)), t));
                end if;
            end:
            add_time_var := proc(name, {dim::integer:=1}, {der::integer:=0})
                local var, der_list, i, k, l, vec;
                if type(name, string) or type(name, symbol) then
                    var := MakeTimeVar(name, dim, der);
                    time_vars := [time_vars[], var];
                    if var:-dim > 1 then
                        vec := Vector(var:-dim);
                        for l from 1 to var:-dim do
                            vec[l] := parse(cat(var:-name, l));
                        end do;
                    else
                        vec := parse(var:-name);
                    end if;
                elif type(name, Vector) then
                    if dim > 1 then
                        WARNING("a vector was specified as the first parameter, the dimension parameter is ignored.");
                    end if;
                    vec := Vector(numelems(name));
                    for i from 1 to numelems(name) do
                        var := MakeTimeVar(name[i], 1, der);
                        time_vars := [time_vars[], var];
                        vec[i] := parse(var:-name);
                    end do;
                else
                    error("the first parameter needs to be a symbol, a string or a vector of symbols or strings.");
                end if;
                der_list := [vec];
                update_time_subs();
                for k from 1 to var:-der do
                    der_list := [der_list[], diff_t(der_list[-1])];
                end do;
                return der_list[];
            end proc;
            update_time_subs := proc()
                local expr_str, expr_str_dot, i, j, k;
                subs_to_time := [];
                for i from 1 to numelems(time_vars) do
                    for j from 1 to time_vars[i]:-dim do
                        if time_vars[i]:-dim > 1 then
                            expr_str := parse(cat(time_vars[i]:-name, j));
                        else
                            expr_str := parse(time_vars[i]:-name);
                        end if;
                        subs_to_time := [subs_to_time[], parse(expr_str) = parse(expr_str)(t)];
                        for k from 1 to time_vars[i]:-der do
                            expr_str_dot := cat(expr_str, "_", StringTools[Repeat]("d", k), "ot");
                            subs_to_time := [subs_to_time[], parse(expr_str_dot) = diff(eval(eval(expr_str)(t)), t$k)];
                        end do;
                    end do;
                end do;
                subs_from_time := Equate(map(rhs, subs_to_time), map(lhs, subs_to_time));
            end proc;
        end module;
    end proc;
    Jacobi := proc(v_in, vars_in)
        local v, vars;
        v := v_in;
        vars := vars_in;
        if type(v, scalar) then
            v := <v>;
        end if;
        if type(v, Matrix) and ColumnDimension(v) = 1 then
            v := convert(v, Vector);
        end if;
        if type(vars, scalar) then
            vars := <vars>;
        end if;
        return VectorCalculus[Jacobian](v, convert(vars, list));
    end proc:
    Spin := proc(v::Vector)
        return <<0 | -v[3] | v[2]> , <v[3] | 0 | -v[1]> , <-v[2] | v[1] | 0>>;
    end proc;
end module;
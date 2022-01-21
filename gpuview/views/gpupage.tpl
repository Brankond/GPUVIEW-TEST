% from bottle import request
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPU Status Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
        rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" 
        rel="stylesheet" type="text/css"/>
</head>

<body>
    <div class="container-fluid">
        <nav class="navbar navbar-light bg-light">
            <div class="container-fluid">
                <a class = "navbar-brand h1" href = "#">LV GPU Dashboard</a>
            </div>
        </nav>

        % hostname = request.query.hostname
        % ip_raw =[url for url, name in host_ip.items() if name == hostname]
        % if ip_raw:
        %   ip = ip_raw[0].replace("http://","").replace("/","")
        % gpustat_all = list(filter(lambda host: host['hostname'] == hostname, gpustats))
        % gpustat = gpustat_all[0]
        <div class="container-fluid" id="GPUDashboardbody">
            <div class="row mt-3 mb-0">
                <h5>Server > {{gpustat.get('hostname','-')}} | {{ip}}</h5>
                % for gpu in gpustat.get('gpus','[]'):
                % mem = gpu.get('memory','-')/100
                <div class="col-6 gy-3">
                    <div class="card" style="background-color: rgb({{220*mem}},{{220*(1-mem)}},50)">
                        <div class="card-body">
                            <h6 class="card-title text-white">{{gpu.get('name','-')}}</h6>
                            <div class="card-footer text-white clearfix small z-1 bg-transparent">
                                <span class="float-left">
                                    <span class="text-nowrap">
                                    <i class="fa fa-thermometer-three-quarters" aria-hidden="true"></i>
                                    Temp. {{ gpu.get('temperature.gpu', '-') }}&#8451; 
                                    </span> |
                                    <span class="text-nowrap">
                                    <i class="fa fa-microchip" aria-hidden="true"></i>
                                    Mem. {{ gpu.get('memory', '-') }}% 
                                    </span> |
                                    <span class="text-nowrap">
                                    <i class="fa fa-cogs" aria-hidden="true"></i>
                                    Util. {{ gpu.get('utilization.gpu', '-') }}%
                                    </span> |
                                    <span class="text-nowrap">
                                    <i class="fa fa-users" aria-hidden="true"></i>
                                    {{ gpu.get('users', '-') }}
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                % end
            </div>
        </div>

        <div class="card mt-4">
                <div class="card-header">
                    <i class="fa fa-table"></i>
                    GPUs on {{gpustat.get('hostname','-')}}
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th scope="col">GPU</th>
                                    <th scope="col">Temp.</th>
                                    <th scope="col">Util.</th>
                                    <th scope="col">Memory Use/Cap</th>
                                    <th scope="col">Power Use/Cap</th>
                                    <th scope="col">User Processes</th>
                                </tr>
                            </thead>
                            <tbody>
                                % for gpu in gpustat.get('gpus', []):
                                <tr class="small" id={{ gpustat.get('hostname', '-') }}>
                                    <th scope="row"> {{ gpu.get('name', '-') }} </th>
                                    <td> {{ gpu.get('temperature.gpu', '-') }}&#8451; </td>
                                    <td> {{ gpu.get('utilization.gpu', '-') }}% </td>
                                    <td> {{ gpu.get('memory', '-') }}% ({{ gpu.get('memory.used', '') }}/{{ gpu.get('memory.total', '-') }}) </td>
                                    <td> {{ gpu.get('power.draw', '-') }} / {{ gpu.get('enforced.power.limit', '-') }} </td>
                                    <td> {{ gpu.get('user_processes', '-') }} </td>
                                </tr>
                                % end
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer small text-muted">{{ update_time }}</div>
        </div>

    </div>

</body>
</html>
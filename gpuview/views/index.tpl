
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>gpuview</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body>
    <div class="container-fluid">
        <nav class="navbar navbar-light bg-light">
            <div class="container-fluid">
                <a class = "navbar-brand h1" href = "#">LV GPU Dashboard</a>
            </div>
        </nav>

        <div class="container-fluid" id="dashboardbody">

             % for gpustat in gpustats:
            <div class="card mt-3 bg-secondary bg-opacity-10">
                <div class="card-body">
                    <div class = "card-title">
                        <a href='/gpupage?hostname={{gpustat.get('hostname','-')}}' class="text-decoration-none text-dark"><h5>Server >> {{gpustat.get('hostname','-')}}</h5></a>
                    </div>
                    <div class="row">
                        % for gpu in gpustat.get('gpus','[]'):
                        % memory = gpu.get('memory','-')/100
                        <div class="col-3 gy-3">
                            <div class="card text-white" style="background-color: rgb({{220*memory}},{{220*(1-memory)}},50)">
                                <div class="card-body">
                                    <h6 class="card-title">{{gpu.get('name','-')}}</h6>
                                    <p class="card-text">Mem. {{gpu.get('memory','-')}}%</p>
                                </div>
                            </div>
                        </div>
                        % end
                    </div>
                </div>
            </div>
            % end
            
        </div>
            
    </div>
      
</body>

</html>
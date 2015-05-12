@"
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>$moduleName Documentation</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		
		<link href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCore.min.css" rel="stylesheet" charset="utf-8">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCoreDefault.min.css" rel="stylesheet" charset="utf-8">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" charset="utf-8">
				
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		  .syntaxhighlighter {
		      overflow-y: hidden !important;
		      overflow-x: auto !important;
		  }
		  pre {
		      min-height: 30px;
		  }
		  .navbar-nav {
		      height: 100%;
		      overflow-y: auto;
		  }
		  .form-group {
		      padding-top: 12px;
		      padding-left: 12px;
		      padding-right: 12px;
		  }
		  .sidebar-nav .navbar-header {
		      float: none;
		  }
		  @media (min-width: 768px) {
		      .sidebar-nav .navbar .navbar-collapse {
		          padding: 0;
		          max-height: none;
		      }
		      .sidebar-nav .navbar ul {
		          float: none;
		      }
		      .sidebar-nav .navbar ul:not {
		          display: block;
		      }
		      .sidebar-nav .navbar li {
		          float: none;
		          display: block;
		      }
		      .sidebar-nav .navbar li a {
		          padding-top: 6px;
		          padding-bottom: 6px;
		      }
		      .navbar {
		          width: 300px;
		      }
		  }
		  @media (min-width: 992px) {
		      .navbar {
		          width: 300px;
		      }
		  }
		  @media (min-width: 1200px) {
		      .navbar {
		          width: 300px;
		      }
		  }
		</style>

	</head>
	<body>
    <div class="container-fluid">
		<div class="row">
        	<div class="col-md-12"><h1>$moduleName</h1></div>
        </div>    
		<div class="row">
          <div class="col-md-2">
            <div class="sidebar-nav">
              <div class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
                    <span class="sr-only">Toggle</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </button>
                  <span class="visible-xs navbar-brand">click menu to open</span>
                </div>
                <div class="navbar-collapse collapse sidebar-navbar-collapse">

			      <div class="form-group">
					<input class="form-control" id="searchinput" type="search" placeholder="Filter..." />
				  </div>

                  <ul class="nav navbar-nav list-group" id="searchList">
"@
$progress = 0
$commandsHelp | %  {
	Update-Progress $_.Name 'Navigation'
	$progress++
"					<li class=`"nav-menu list-group-item`"><a href=`"#$($_.Name)`">$($_.Name)</a></li>"
}
@'
                  </ul>
                </div><!--/.nav-collapse -->
              </div>
            </div>
          </div>
          <div class="col-md-8">
'@
$progress = 0
$commandsHelp | % {
	Update-Progress $_.Name 'Documentation'
	$progress++
@"
				<div id=`"$(FixString($_.Name))`" class="toggle_container">
					<div class="page-header">
						<h1>$(FixString($_.Name))</h1>
"@
	$syn = FixString($_.synopsis)
    if(!($syn).StartsWith($(FixString($_.Name)))){
@"
						<p class="lead">$syn</p>
						<p>$(FixString(($_.Description  | out-string).Trim()) $true)</p>
"@
	}
@"
					</div>
				    <div class=`"row`">
"@
	if (!($_.alias.Length -eq 0)) {
@"
						<div class=`"col-md-12`">
							<h3> Aliases </h3>
							<ul>
"@
	$_.alias | % {
@"
								<li>$($_.Name)</li>
"@
	}
@"
							</ul>
						</div>
"@
	}
	if (!($_.syntax | Out-String ).Trim().Contains('syntaxItem')) {
@"
						<div class=`"col-md-12`">
							<h3> Syntax </h3>
<pre class="brush: ps">$(FixString($_.syntax | out-string))</pre>
						</div>
"@
	}
    if($_.parameters){
@"
						<div class=`"col-md-12`">
							<h3> Parameters </h3>
							<table class="table table-striped table-bordered table-condensed">
								<thead>
									<tr>
										<th>Name</th>
										<th>Description</th>
										<th>Required?</th>
										<th>Pipeline Input</th>
										<th>Default Value</th>
									</tr>
								</thead>
								<tbody>
"@
        $_.parameters.parameter | % {
@"
									<tr>
										<td>-$(FixString($_.Name))</td>
										<td>$(FixString(($_.Description  | out-string).Trim()) $true)</td>
										<td>$(FixString($_.Required))</td>
										<td>$(FixString($_.PipelineInput))</td>
										<td>$(FixString($_.DefaultValue))</td>
									</tr>
"@
        }
@"
								</tbody>
							</table>
						</div>				
"@
    }
    $inputTypes = $(FixString($_.inputTypes  | out-string))
    if ($inputTypes.Length -gt 0 -and -not $inputTypes.Contains('inputType')) {
@"
						<div class=`"col-md-12`">
					        <h3> Input Type </h3>
					        <div>$inputTypes</div>
					    </div>
"@
	}
    $returnValues = $(FixString($_.returnValues  | out-string))
    if ($returnValues.Length -gt 0 -and -not $returnValues.StartsWith("returnValue")) {
@"
						<div class=`"col-md-12`">
							<h3> Return Values </h3>
							<div>$returnValues</div>
						</div>
"@
	}
    $notes = $(FixString($_.alertSet  | out-string))
    if ($notes.Trim().Length -gt 0) {
@"
						<div class=`"col-md-12`">
							<h3> Notes </h3>
							<div>$notes</div>
						</div>
"@
	}
	if(($_.examples | Out-String).Trim().Length -gt 0) {
@"
						<div class=`"col-md-12`">
							<h3> Examples </h3>
							<hr>
"@
		$_.examples.example | % {
@"
							<h4>$(FixString($_.title.Trim(('-',' '))))</h4>
<pre class="brush: ps">$(FixString($_.code | out-string ).Trim())</pre>
							<div>$(FixString($_.remarks | out-string ).Trim())</div>
"@
		}
@"
						</div>
"@
	}
	
	
	
		if(($_.relatedLinks | Out-String).Trim().Length -gt 0) {
@"
						<div class=`"col-md-12`">
							<h3> Links </h3>
"@
		$_.links | % {
@"
							<div class='$($_.cssClass)'><a href='$($_.link)' target=$($_.target)>$($_.name)</a></div>
"@
		}
@"
						</div>
"@
	}
	
	
	
	
	
	
@"
					</div>
				</div>
"@
}
@'
		</div>
	</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/js/bootstrap.min.js" charset="utf-8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shCore.min.js" charset="utf-8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushPowerShell.min.js" charset="utf-8"></script>
	<script src="lib/bootstrap-list-filter.min.js" charset="utf-8"></script>
	<script>
		$(document).ready(function() {
			$(".toggle_container").hide();
			var previousId;
		    if(location.hash) {
		        var id = location.hash.slice(1);    //Get rid of the # mark
		        var elementToShow = $("#" + id);    //Save local reference
		        if(elementToShow.length) {                   //Check if the element exists
		            elementToShow.slideToggle('fast');       //Show the element
		            elementToShow.addClass("check_list_selected");    //Add class to element (the link)
		        }
		        previousId = id;
		    }

			$('.nav-menu a, .psLink a').click(function() {
                $(".sidebar-navbar-collapse").collapse('hide');
				$('.toggle_container').hide();                 // Hide all
				var elem = $(this).prop("hash");
				$(elem).toggle('fast');   						// Show HREF/to/ID one
				history.pushState({}, '', $(this).attr("href"));
				window.scrollTo(0, 0);
				return false;
			});
			SyntaxHighlighter.defaults['toolbar'] = false;
			SyntaxHighlighter.defaults['gutter'] = false;
			SyntaxHighlighter.all();
			
			$('#searchList').btsListFilter('#searchinput', {itemChild: 'a', initial: false});
		});
	</script>
	</body>
</html>
'@
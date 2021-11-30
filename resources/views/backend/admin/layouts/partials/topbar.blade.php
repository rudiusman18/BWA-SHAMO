 <!-- Topbar -->
 <nav style="background-color:#38ABBE" class="navbar navbar-expand navbar-light topbar mb-4 static-top shadow">

     <!-- Sidebar Toggle (Topbar) -->
     <button style="background-color: #6C5ECF" id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
         <i style="color:white" class="fa fa-bars"></i>
     </button>

     <!-- Topbar Search -->
     <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
         <div class="input-group">
             <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                 aria-label="Search" aria-describedby="basic-addon2">
             <div class="input-group-append">
                 <form action="#" method="POST">
                     @csrf
                     <button style="background-color: #6C5ECF" class="btn btn-primary" type="submit">
                         <i class="fas fa-search fa-sm"></i>
                     </button>
                 </form>
             </div>
         </div>
     </form>

     <!-- Topbar Navbar -->
     <ul class="navbar-nav ml-auto">

         <!-- Nav Item - Search Dropdown (Visible Only XS) -->
         <li class="nav-item dropdown no-arrow d-sm-none">
             <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown"
                 aria-haspopup="true" aria-expanded="false">
                 <i class="fas fa-search fa-fw"></i>
             </a>
             <!-- Dropdown - Messages -->
             <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                 aria-labelledby="searchDropdown">
                 <form class="form-inline mr-auto w-100 navbar-search">
                     <div class="input-group">
                         <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                             aria-label="Search" aria-describedby="basic-addon2">
                         <div class="input-group-append">
                             <form action="#" method="post">
                                 @csrf
                                 <button style="background-color: #6C5ECF" class="btn btn-primary" type="submit">
                                     <i class="fas fa-search fa-sm"></i>
                                 </button>
                             </form>
                         </div>
                     </div>
                 </form>
             </div>
         </li>





         <!-- Nav Item - User Information -->
         <li class="nav-item dropdown no-arrow">
             <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                 aria-haspopup="true" aria-expanded="false">
                 <span class="mr-2 text-light d-lg-inline">{{ auth()->user()->name }}</span>
                 <i class="fa fa-user"></i>
             </a>
             <!-- Dropdown - User Information -->
             <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                 <a class="dropdown-item" href="#">
                     <i class="fas fa-cog fa-sm fa-fw mr-2 text-gray-400"></i>
                     Profile
                 </a>
                 <a class="dropdown-item" href="#">
                     <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                     Settings
                 </a>

                 <div class="dropdown-divider"></div>
                 <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                     <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                     Logout
                 </a>
             </div>
         </li>

     </ul>

 </nav>

 <!-- Logout Modal-->
 <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div style="background-color: #1F1D2B" class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                 <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">×</span>
                 </button>
             </div>
             <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
             <div class="modal-footer">
                 <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

                 <form action="/logout" method="POST">
                     @csrf
                     <button style="background-color: #6C5ECF" type="submit" class="btn btn-primary">Logout</button>
                 </form>

             </div>
         </div>
     </div>
 </div>
 <!-- End of Topbar -->

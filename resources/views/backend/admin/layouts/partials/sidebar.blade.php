  <!-- Sidebar -->
  <ul style="background-color:#1F1D2B" class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/dashboard">
          <div class="sidebar-brand-icon">
              <img src="/assets/Union.png" style="max-width:40px" alt="logo">
          </div>
          <div class="sidebar-brand-text mx-3">BWA-Shamo Admin</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item {{ Request::is('dashboard') ? 'active' : '' }}">
          <a class="nav-link" href="/dashboard">
              <i class="fas fa-fw fa-tachometer-alt"></i>
              <span>Dashboard</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
          Menu
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item {{ Request::is('dashboard/product*') ? 'active' : '' }}">
          <a class="nav-link" href="/dashboard/product">
              <i class="fas fa-fw fa-cog"></i>
              <span>Products</span>
          </a>

      </li>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item {{ Request::is('dashboard/category*') ? 'active' : '' }}">
          <a class="nav-link" href="/dashboard/category">
              <i class="fas fa-fw fa-cog"></i>
              <span>Category</span>
          </a>

      </li>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
          <a class="nav-link" href="/transaction">
              <i class="fas fa-fw fa-cog"></i>
              <span>Transaction</span>
          </a>

      </li>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
          <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>



  </ul>
  <!-- End of Sidebar -->

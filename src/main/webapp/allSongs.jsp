<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>One Music - All Songs</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="style.css">

</head>

<body>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="lds-ellipsis">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="/loadData" class="nav-brand"><img src="img/core-img/logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="/loadData">Home</a></li>
                                    <li><a href="/allArtist">Artists</a></li>
                                    <c:if test="${sessionScope.acc != null}">
                                        <li><a href="#">Your Playlists</a>
                                            <ul class="dropdown">
                                                <li><a href="/createPlaylistView">Create Playlist</a></li>
                                                <c:forEach items='${requestScope["playList"]}' var="i">
                                                    <li><a href="/userPlayListView?pid=${i.pid}">${i.pname}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:if>
                                    <li><a href="/allSongs">All Songs</a></li>
                                    <li><a href="#">Categories</a>
                                        <ul class="dropdown">
                                            <c:forEach items='${requestScope["categories"]}' var="i">
                                                <li><a href="/songByCategory?cid=${i.cid}">${i.cname}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                    <li><a href="contact.jsp">Contact</a></li>
                                    <c:if test="${sessionScope.acc.isadmin == 1}">
                                        <li><a href="/addSong">Add new Song</a></li>
                                    </c:if>
                                </ul>

                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <c:if test="${sessionScope.acc == null}">
                                        <div class="login-register-btn mr-50">
                                            <a href="login.jsp" id="loginBtn">Login </a>
                                        </div>

                                        <div class="login-register-btn mr-50">
                                            <a href="registration.jsp" id="registerBtn"> Register</a>
                                        </div>
                                    </c:if>

                                    <c:if test="${sessionScope.acc != null}">
                                        <div class="header__navbar-item header__navbar-user">
                                            <img src="${sessionScope.acc.uimg}" alt="" class="header__navbar-user-img">
                                            <div class="login-register-btn mr-50">
                                                <a href="/info?userAcc=${sessionScope.acc.uid}">${sessionScope.acc.uname}</a>
                                            </div>
                                            <div class="login-register-btn mr-50">
                                                <a href="/logout">Log Out</a>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <!-- Nav End -->

                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ##### Header Area End ##### -->

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>See what???s new</p>
            <h2>All Songs</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Events Area Start ##### -->
    <section class="events-area section-padding-100" style="padding-top: 50px;">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="contact-form-area">
                        <form action="/allSongs" method="get">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <input value="${likeName}" name="txt" type="text" class="form-control" placeholder="Search here">
                                    </div>
                                </div>
                                <div class="col-12 text-center">
                                    <button class="btn oneMusic-btn" type="submit" style="margin-bottom: 15px">Search <i class="fa fa-search"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <p style="color: #ee2525">${messError}</p>
                    <p style="color: #6fe334">${messSuccess}</p>
                <c:forEach items='${requestScope["listSongs"]}' var="song" begin="0" varStatus="loop">
                        <div class="single-song-area mb-30 d-flex flex-wrap align-items-end" style="z-index: ${6 - loop.count}">
                            <div class="song-thumbnail">
                                <img src="${song.simg}" alt="">
                            </div>
                            <div class="song-play-area">
                                <div class="song-name">
                                    <p>${loop.count}. ${song.sname}</p>
                                </div>
                                <div class="${sessionScope.acc.ispremium == 0 || sessionScope.acc == null ? "disabled" : ""}">
                                    <audio preload="auto" controls>
                                        <source src="${song.slink}">
                                    </audio>
                                </div>
                            </div>

                            <div class="contact-content" style="margin-top: 10px;">
                                <div class="contact-social-info" style="display:flex;align-items: center;">
                                    <c:if test="${sessionScope.acc.isadmin == 1}">
                                    <a href="/edit?sid=${song.sid}" data-toggle="tooltip" data-placement="top" title="Edit">
                                        <i class="fa fa-edit" aria-hidden="true"></i>
                                    </a>
                                    <a href="/delete?sid=${song.sid}" data-toggle="tooltip" data-placement="top" title="Delete" onclick="return confirm('Are you sure?')">
                                        <i class="fa fa-trash" aria-hidden="true"></i>
                                    </a>
                                    </c:if>
                                    <c:if test="${sessionScope.acc != null}">
                                        <span href="#" data-toggle="tooltip" data-placement="top" title="Add to playlist">
                                            <li class="header__navbar-item header__navbar-user">
                                                <i  class="fa fa-plus" aria-hidden="true"></i>
                                                <ul class="header__navbar-user-menu">
                                                    <c:forEach items='${requestScope["playList"]}' var="i">
                                                        <li class="header__navbar-user-item header__navbar-user-item--separate">
                                                        <a href="/userPlayListManagement?action=add&sid=${song.sid}&pid=${i.pid}">${i.pname}</a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </li>
                                        </span>
                                    </c:if>
                                </div>
                            </div>

                        </div>
                </c:forEach>
            </div>
            </div>
            <div class="oneMusic-pagination-area wow fadeInUp" data-wow-delay="300ms">
                <nav>
                    <ul class="pagination" style="margin-top: 70px">
                        <c:forEach begin="1" end="${endP}" var="i">

                            <li class="page-item ${pageTag == i?"active":""}"><a class="page-link" href="/allSongs?index=${i}&txt=${likeName}">${i}</a></li>

                        </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>
    </section>
    <!-- ##### Events Area End ##### -->

    <!-- ##### Newsletter & Testimonials Area Start ##### -->
    <section class="newsletter-testimonials-area">
        <div class="container">
            <div class="row">-

                <!-- Newsletter Area -->
                <div class="col-12 col-lg-6">
                    <div class="newsletter-area mb-100">
                        <div class="section-heading text-left mb-50">
                            <p>See what???s new</p>
                            <h2>Subscribe to newsletter</h2>
                        </div>
                        <div class="newsletter-form">
                            <form action="#">
                                <input type="search" name="search" id="newsletterSearch" placeholder="E-mail">
                                <button type="submit" class="btn oneMusic-btn">Subscribe <i class="fa fa-angle-double-right"></i></button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Testimonials Area -->
                <div class="col-12 col-lg-6">
                    <div class="testimonials-area mb-100 bg-img bg-overlay" style="background-image: url(img/bg-img/bg-3.jpg);">
                        <div class="section-heading white text-left mb-50">
                            <p>See what???s new</p>
                            <h2>Testimonial</h2>
                        </div>
                        <!-- Testimonial Slide -->
                        <div class="testimonials-slide owl-carousel">
                            <!-- Single Slide -->
                            <div class="single-slide">
                                <p>Nam tristique ex vel magna tincidunt, ut porta nisl finibus. Vivamus eu dolor eu quam varius rutrum. Fusce nec justo id sem aliquam fringilla nec non lacus. Suspendisse eget lobortis nisi, ac cursus odio. Vivamus nibh velit, rutrum.</p>
                                <div class="testimonial-info d-flex align-items-center">
                                    <div class="testimonial-thumb">
                                        <img src="img/bg-img/t1.jpg" alt="">
                                    </div>
                                    <p>William Smith, Customer</p>
                                </div>
                            </div>
                            <!-- Single Slide -->
                            <div class="single-slide">
                                <p>Nam tristique ex vel magna tincidunt, ut porta nisl finibus. Vivamus eu dolor eu quam varius rutrum. Fusce nec justo id sem aliquam fringilla nec non lacus. Suspendisse eget lobortis nisi, ac cursus odio. Vivamus nibh velit, rutrum.</p>
                                <div class="testimonial-info d-flex align-items-center">
                                    <div class="testimonial-thumb">
                                        <img src="img/bg-img/t1.jpg" alt="">
                                    </div>
                                    <p>Nazrul Islam, Developer</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <!-- ##### Newsletter & Testimonials Area End ##### -->

    <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-100 bg-img bg-overlay bg-fixed has-bg-img" style="background-image: url(img/bg-img/bg-2.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading white">
                        <p>See what???s new</p>
                        <h2>Get In Touch</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Contact Form Area -->
                    <div class="contact-form-area">
                        <form action="#" method="post">
                            <div class="row">
                                <div class="col-md-6 col-lg-4">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="name" placeholder="Name">
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4">
                                    <div class="form-group">
                                        <input type="email" class="form-control" id="email" placeholder="E-mail">
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="subject" placeholder="Subject">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <textarea name="message" class="form-control" id="message" cols="30" rows="10" placeholder="Message"></textarea>
                                    </div>
                                </div>
                                <div class="col-12 text-center">
                                    <button class="btn oneMusic-btn mt-30" type="submit">Send <i class="fa fa-angle-double-right"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Contact Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="#"><img src="img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></a></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Albums</a></li>
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area Start ##### -->

    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
</body>

</html>
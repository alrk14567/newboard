<%@page language="java" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!--태그라이브라는 애를 불러올 껀데 걔 이름이 c야-->
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

</head>
<body>
<div class="container-fluid">
    <div class="main h-100">
        <div class="row justify-content-center">
            <div class="col-8 text-center">
                <div class="row justify-content-start">
                    <div class="col-3">
                        <a class="btn btn-outline-success" href="/board/write">글 작성하기</a>
                    </div>
                </div>
                <table class="table table-striped">
                    <tr>
                        <th>글 번호</th>
                        <th colspan="3">제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                    <c:forEach items="${list}" var="l">
                        <tr onclick="javascript:location.href='/board/showOne/${l.id}'">
                            <td>${l.id}</td>
                            <td colspan="3">${l.title}</td>
                            <td>${l.nickname}</td>
                            <td><fmt:formatDate value="${l.entryDate}" pattern="yy/MM/dd HH:mm"/></td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="6" class="text-center">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <a class="page-link" href="/board/showAll/1"> << </a>
                                </li>
                                <c:if test="${curPage>5}">
                                    <li class="page-item">
                                        <a href="/board/showAll/${curpage-5}" class="page-link"> < </a>
                                    </li>
                                </c:if>
                                <c:if test="${curPage<=5}">
                                    <li class="page-item disabled">
                                        <a href="/board/showAll/${curPage -5}" class="page-link"> < </a>
                                    </li>
                                </c:if>
                                <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                    <c:choose>
                                        <c:when test="${page eq curPage}">
                                            <li class="page-item active">
                                                <span class="page-link">${page}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="/board/showAll/${page}">${page}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${curPage<maxPage-5}">
                                    <li class="page-item">
                                        <a class="page-link" href="/board/showAll/${curPage+5}"> > </a>
                                    </li>
                                </c:if>
                                <c:if test="${curPage>=maxPage-5}">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="/board/showAll/${curPage+5}"> > </a>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="/board/showAll/${maxPage}"> >> </a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <div class="row text-center justify-content-center">
                    <div class="col-6">
                        <form class="justify-content-center text-center" action="/board/showAll" method="post">
                            <div class="justify-content-center text-center">
                                <input type="text" name="inputContent">
                                <input type="submit" value="내용 검색">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
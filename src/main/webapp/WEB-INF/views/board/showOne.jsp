<%@page language="java" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<!--태그라이브라는 애를 불러올 껀데 걔 이름이 c야-->

<head>
    <title>${boardDTO.id}번 게시글</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

</head>
<body>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-6">
            <table class="table table-striped">
                <tr>
                    <th>회원 번호</th>
                    <td>${boardDTO.id}</td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>${boardDTO.title}</td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td>${boardDTO.nickname}</td>
                </tr>
                <tr>
                    <th>회원 등급</th>
                    <td><fmt:formatDate value="${boardDTO.entryDate}" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분"/></td>
                </tr>
                <tr>
                    <th>수정일</th>
                    <td><fmt:formatDate value="${boardDTO.modifyDate}" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분"/></td>
                </tr>
                <tr>
                    <th colspan="2" class="text-center">내용</th>
                </tr>
                <tr>
                    <td colspan="2" class="text-center">${boardDTO.content}</td>
                </tr>
                <c:if test="${boardDTO.writerId eq logIn.id}">
                    <tr class="text-center">
                        <td class="text-center" colspan="3">
                            <a class="btn btn-outline-success" href="/board/update/${boardDTO.id}">수정하기</a>
                            <button class="btn btn-outline-danger" onclick="deleteBoard(${boardDTO.id})">삭제하기</button>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <td colspan="3" class="text-center">
                        <a class="btn btn-outline-secondary" href="/board/showAll">목록</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    function deleteBoard(id) {
        Swal.fire({
            title: '정말로 삭제하시겠습니까?',
            showCancelButton: true,
            confirmButtonText: '삭제하기',
            cancelButtonText: '취소',
            icon: 'warning'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '삭제되었습니다.',
                    icon: 'check'
                }).then((result) => {
                    location.href = '/board/delete/' + id;
                })
            }
        })
    }

    let updateUse = false;

    function buttonClick(replyId, boardId) {
        updateUse = true;
        if (updateUse) {
            disableButton(replyId);
            let div = document.getElementById("div-" + replyId);
            let td = document.createElement("td");
            let form = document.getElementById("form-" + boardId);
            let input = document.createElement("input");
            let btnSubmit = document.createElement("input");
            form.setAttribute("action", "/reply/update/" + replyId);
            input.setAttribute("type", "text")
            input.setAttribute("name", "content")
            input.setAttribute("value", "샘플")

            btnSubmit.setAttribute("type", "submit");
            btnSubmit.setAttribute("value", "수정");
            btnSubmit.className = div.className;

            form.appendChild(input);
            form.appendChild(btnSubmit);
            $(td).attr('colspan', '7');

            td.appendChild(form);

            let tds = $('#tr-'+replyId).children();
            for(e of tds){
                $(e).hide();
            }

            $('#tr-' + replyId).append(td);
        }
    }

    function disableButton(id) {
        console.log(id);
        // 수정 div를 submit 버튼으로 변환
        // inputContent에 disabled attribute 삭제
        $('#form-' + id).removeAttr('disabled');
    }
</script>
</body>
</html>
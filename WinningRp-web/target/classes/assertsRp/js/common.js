/**
 * Created by 项鸿铭 on 2016/11/4.
 */
//加载信息
function loading(name, overlay) {
    $('body').append('<div id="overlay"></div><div id="preloader">' + name + '</div>');
    $("#overlay").show();
    if (overlay == 1) {
        $('#overlay').css('opacity', 0.1).fadeIn(function () {
            $('#preloader').fadeIn();
        });
        return false;
    }
    $('#preloader').fadeIn();
}
//隐藏加载信息
function unloading() {
    $("#overlay").hide();
    $('#preloader').fadeOut('fast', function () {
        $('#overlay').fadeOut();
    });
}

//加载信息
function loadMessage(msg) {
    if (msg == undefined) {
        loading('加载中...', 1);
    } else {
        loading(msg, 1);
    }
}
//隐藏加载信息
function hideMessage() {
    unloading();
}

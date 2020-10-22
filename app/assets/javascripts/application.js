// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-star-rating
//= require turbolinks

//= require nprogress
//= require nprogress-turbolinks

//= require_tree .

//= require tether
//TODO: rename to bootstrap for faster compilation
//= require bootstrap-sprockets

//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/layouts/topRight
//= require noty/themes/default
$ = jQuery;
$.noty.defaults.timeout = 5000;
$.noty.defaults.layout = 'topRight';


(function() {
    "use strict";
    if (window.location && window.location.hash) {
        if (window.location.hash === '#_=_') {
            window.location.hash = '';
            return;
        }
        var facebookFubarLoginHash = RegExp('_\=_', 'g');
        window.location.hash = window.location.hash.replace(facebookFubarLoginHash,     '');
    }
}());

var ready;
ready = function() {
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });

    $("#rating-form").submit(function (e) {
        if($("input:radio[name=rating]:checked").length) {
            $('#rating-submit').prop('disabled', true);
        } else {
            noty({text: "Please choose a rating!", type: 'error'});
            e.preventDefault();
        }
    });

    $('input[name=rating]').rating();

    fixFooter();
};

$(document).ready(ready);
$(document).on('page:load', ready);
$(window).resize(fixFooter);

function toggleSubCategories(parentId) {
    $("a[data-parent='" + parentId + "']").toggleClass("hiddenCategory");
    $("a[data-parent='" + parentId + "']").toggleClass("shownCategory");
}

function fixFooter() {
    $("#wrapper").height($("#page-content-wrapper").height() + 30);
}

function addToCart(id) {
    $("[data-product-id='" + id + "']").prop('disabled', true);
    $.post( "/cart", { id: id })
        .done(function( data ) {
            $("[data-product-id='" + id + "']").prop('disabled', false);
            noty({text: 'Successfully added item to your cart!', type: 'success'});
        })
        .fail(function( data ) {
            $("[data-product-id='" + id + "']").prop('disabled', false  );
            noty({text: 'Failed to add item to your cart!', type: 'error'});
        });
}

function incrementCart(id) {
    $("[data-add-id='" + id + "']").addClass('disabled');
    $.post( "/cart", { id: id })
        .done(function( data ) {
            var qty = $("[data-quantity-id='" + id + "']");
            qty.html(parseInt(qty.html()) + 1);

            var totalqty = $("#allItems");
            totalqty.html(parseInt(totalqty.html()) + 1);

            var totalcost = $("#totalCost");
            var cost = $("[data-price-id='" + id + "']");

            var regular = $('#regular-user').length > 0;
            var newprice = regular ? Number((parseFloat(totalcost.html()) + (parseFloat(cost.html()) * 0.95)).toFixed(2)) : Number((parseFloat(totalcost.html()) + parseFloat(cost.html())).toFixed(2));

            var discountprice = Number(newprice * 0.95).toFixed(2);
            if(newprice > 500) {
                $("#discount").removeClass('hidden');
                $("#totalCostModal").html(discountprice);
            } else {
                $("#totalCostModal").html(newprice);
            }

            $("#total-discount").html(discountprice);

            totalcost.html(newprice);

            $("[data-add-id='" + id + "']").removeClass('disabled');
            noty({text: 'Successfully added item to your cart!', type: 'success'});
        })
        .fail(function( data ) {
            $("[data-add-id='" + id + "']").removeClass('disabled');
            noty({text: 'Failed to add item to your cart!', type: 'error'});
        });
}

function decrementCart(id) {
    $("[data-remove-id='" + id + "']").addClass('disabled');

    $.ajax({
        url: "/cart/" + id,
        type: 'DELETE'
        })
        .done(function() {
            var qty = $("[data-quantity-id='" + id + "']");
            var html = parseInt(qty.html());

            var totalqty = $("#allItems");
            totalqty.html(parseInt(totalqty.html()) - 1);

            var totalcost = $("#totalCost");
            var cost = $("[data-price-id='" + id + "']");

            var regular = $('#regular-user').length > 0;

            var newprice = regular ? Number((parseFloat(totalcost.html()) - (parseFloat(cost.html()) * 0.95)).toFixed(2)) : Number((parseFloat(totalcost.html()) - parseFloat(cost.html())).toFixed(2));

            var discountprice = Number(newprice * 0.95).toFixed(2);
            if(newprice < 500) {
                $("#discount").addClass('hidden');
                $("#totalCostModal").html(newprice);
            } else {
                $("#totalCostModal").html(discountprice);
            }

            $("#total-discount").html(discountprice);

            totalcost.html(newprice);

            if(html == 1) {
                $("[data-row-id='" + id + "']").remove();
            } else {
                qty.html(html - 1);
            }

            $("[data-remove-id='" + id + "']").removeClass('disabled');
            noty({text: 'Successfully removed item from your cart!', type: 'success'});
        })
        .fail(function() {
            $("[data-remove-id='" + id + "']").removeClass('disabled');
            noty({text: 'Failed to remove item from your cart!', type: 'error'});
        });
}

function buyNowDialog() {
    $( "#dialog-confirm" ).dialog({
        dialogClass: "no-close",
        resizable: false,
        height:140,
        modal: true,
        draggable: false,
        buttons: {
            "Buy now": function() {
                $('#buy-button').prop('disabled', true);
                $( this ).dialog( "close" );

                $.post( "/cart/order")
                    .done(function( data ) {
                        $('#cart-table').remove();
                        $('#allItems').html('0');
                        $('#totalCost').html('0');
                        $('#buy-button').remove();
                        $('#enough-credits').remove();
                        $("#discount").addClass('hidden');

                        noty({text: 'Successful transaction!', type: 'success'});
                    })
                    .fail(function( data ) {
                        $('#buy-button').prop('disabled', false);
                        noty({text: "You might haven't got enough credits, or we don't have stock.", type: 'error'});
                    });
            },
            Cancel: function() {
                $( this ).dialog( "close" );
            }
        }
    });
}

function compare(category) {
    var div = $('div[data-category=' + category + ']');

    window.location.href = div.find('form').attr('action') + div.find('select[name=first]').val() + '/' + div.find('select[name=second]').val()
}

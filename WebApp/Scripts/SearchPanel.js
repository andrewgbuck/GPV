﻿//  Copyright 2012 Applied Geographics, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

var GPV = (function (gpv) {
  $(function () {
    var $body = $("body");
    var $map = $("#mapMain");
    var $container = $("#pnlSearch");
    var config = gpv.configuration;
    var appState = gpv.appState;
    var service = "Services/SearchPanel.ashx";
    var currentSearch;

    // =====  controls  =====
    
    var $cmdSearch = $("#cmdSearch").on("click", search);
    var $cmdReset = $("#cmdReset").on("click", reset);
    var $labSearchCount = $("#labSearchCount");
    var $cmdShowAllOnMap = $("#cmdShowAllOnMap").on("click", showOnMap);
    var $cmdShowOnMap = $("#cmdShowOnMap").on("click", showOnMap);
    var $ddlSearch = $("#ddlSearches").on("change", searchChanged);

    $(".Number,.NumberRange").numericInput();
    $(".Date,.DateRange").dateInput().datepicker({ showAnim: "slideDown", changeMonth: true, changeYear: true });

    var $grdSearch = $("#grdSearch").dataGrid({
      multiSelect: true,
      rowClass: "DataGridRow",
      alternateClass: "DataGridRowAlternate",
      selectedClass: "DataGridRowSelect",
      selectionChanged: resultGridChanged
    });

    var $input = $container.find(".SearchInputField .Input").on("keyup change", function (e) {
      var hasData = getFilledInputs().length > 0;
      $cmdSearch.toggleClass("Disabled", !hasData);
      $cmdReset.toggleClass("Disabled", !hasData);

      if (e.type == "keyup" && hasData && e.which == 13) {
        search();
      }
    });

    $container.find(".Autocomplete").each(function () {
      var $this = $(this);
      $this.autocomplete({
        serviceUrl: service,
        params: { m: "Autocomplete", criteria: $this.attr("data-id") },
        triggerSelectOnValidInput: false,
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No matching results'
      });
    });

    // =====  component events
    
    gpv.on("viewer", "mapTabChanged", fillSearches);

    // =====  private functions  =====

    function emptyResultGrid() {
      $grdSearch.dataGrid("empty");
      $cmdShowOnMap.addClass("Disabled");
      $cmdShowAllOnMap.addClass("Disabled");
    }

    function fillSearches() {
      var changed = gpv.loadOptions($ddlSearch, config.mapTab[appState.MapTab].search);

      if (changed) {
        searchChanged();
      }
    }

    function getFilledInputs() {
      return $container.find(".Search:visible").find(".SearchInputField .Input").map(function () {
        if ($(this).val()) {
          return this;
        }
      });
    }

    function reset() {
      if (!$cmdReset.hasClass("Disabled")) {
        $("#pnlSearchScroll").find("input:text").val('');
        $("#pnlSearchScroll").find("select")[0].selectedIndex = 0;
        $cmdSearch.toggleClass("Disabled");
        $cmdReset.toggleClass("Disabled");
        emptyResultGrid();
      }
    }

    function resultGridChanged(dblClick) {
      if (dblClick) {
        updateTargets($grdSearch.dataGrid("getSelection"));
      }
      else {
        $cmdShowOnMap.toggleClass("Disabled", $grdSearch.dataGrid("getSelection").length == 0);
      }
    }

    function search() {
      if (!$cmdSearch.hasClass("Disabled")) {
        emptyResultGrid();
        var criteria = {};

        getFilledInputs().each(function () {
          var $this = $(this);
          var id = $this.attr("data-id");

          if ($this.hasClass("DateRange") || $this.hasClass("NumberRange")) {
            if (!criteria.hasOwnProperty(id)) {
              criteria[id] = [null, null];
            }

            criteria[id][$this.hasClass("1") ? 0 : 1] = $this.val();
          }
          else {
            criteria[id] = $this.val();
          }
        });

        gpv.waitClock.start();

        gpv.post({
          url: service,
          data: {
            app: appState.Application,
            search: $container.find(".Search:visible").attr("data-search"),
            criteria: JSON.stringify(criteria)
          },
          success: function (result) {
            if (result) {
              $grdSearch.dataGrid("load", result);
              $labSearchCount.text((result.rows.length == 0 ? "None" : result.rows.length) + " found");
              $cmdShowAllOnMap.toggleClass("Disabled", result.rows.length == 0);
            }
          },
          complete: function () {
            gpv.waitClock.finish();
          }
        });
      }
    }

    function searchChanged() {
      var $search = $container.find(".Search").hide();
      currentSearch = null;
      var $opt = $ddlSearch.find("option:selected");

      if ($opt.length) {
        currentSearch = $opt.val();
        $search.filter("[data-search='" + currentSearch + "']").show();
      }

      emptyResultGrid();
    }

    function showOnMap() {
      var ids = $(this)[0].id == "cmdShowOnMap" ? $grdSearch.dataGrid("getSelection") : $grdSearch.dataGrid("getIds");
      updateTargets(ids);
    }

    function updateTargets(ids) {
      var layerID = config.search[currentSearch].layer.id;
      var targetIds = $.map(ids, function (id) { return id.m; }).join(",");
      var url = "application:action=0&selectionlayer=&selectionids=&scaleby=1.6&targetlayer=" + layerID + "&targetids=" + targetIds;

      if (ids.length == 1) {
        url += "&activemapid=" + ids[0].m;
        url += "&activedataid=" + (ids[0].hasOwnProperty("d") ? ids[0].d : ids[0].m);
      }

      gpv.selectionPanel.reinitialize(url);
      $("#tabSelection").trigger("click");
    }

    fillSearches();
  });

  return gpv;
})(GPV || {});

# Meal App
Browse & Prepare what meal you want.
<br />

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Launch](#launch)
* [Setup](#setup)
* [Example of use](#example-of-use)

<br />
<br />

## General info
1. You can adjust your settings in onBoarding/drawer(side-menu)
   * Switch between Arabic/English language
   * Switch between dark/light theme or you can take a them from you system
   * Choose your prefered colors
   * Filter meals as you want
2. Browse categories to show the meal you prefer
3. Browse your meal to show details
4. Add your meal to favorite

<br />

## Technologies
Project is created with:
* Dart as programming language
* Flutter as framework of Dart
* State Management using [Provider](https://pub.dev/packages/provider "Provider package")

<br />

## Launch
1. connect you real device / emulator (Android) / simulator (IOS)
1. open lib folder
2. run [main.dart](lib/main.dart)

<br />

## Setup
1. visit [Flutter](https://flutter.dev/docs/get-started/install "Flutter setup page")
2. choose your operating system
3. follow the instructions to install Flutter successfully
4. install [provider package](https://pub.dev/packages/provider/install "Provider package installation")
5. install [shared preferences package](https://pub.dev/packages/shared_preferences/install "Shared preferences package installation")
6. install [cached image package](https://pub.dev/packages/cached_network_image/install "Cached network image package installation")
7. install [colorpicker package](https://pub.dev/packages/flutter_colorpicker/install "Flutter color picker package installation")

<br />

## Example of use
<br />

<ul>
  <li>
    <h5>onBoarding</h5>
    <hr />
    <img src="assets/screenshots/onBoarding01.png" width="265" height="450"> <img src="assets/screenshots/onBoarding02.png" width="265" height="450"> <img src="assets/screenshots/onBoarding03.png" width="265" height="450">
  </li>
  <li>
    <h5>Categories</h5>
    <hr />
    <img src="assets/screenshots/home-categories.png" width="265" height="450">
  </li>
  <li>
    <h5>Favorite</h5>
    <hr />
    <table>
      <tr>
        <th>Empty favorite</th>
        <th>Add item to favorite</th>
        <th>Item in Favorite</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/empty-favorite.png" width="270" height="450"></td>
        <td><img src="assets/screenshots/add-item-favorite.png" width="270" height="450"></td>
        <td><img src="assets/screenshots/favorite-item.png" width="270" height="450"></td>
      </tr>
    </table>
  </li>
  <li>
    <h5>Settings</h5>
    <hr />
    <img src="assets/screenshots/side-menu.png" width="274" height="450">
  </li>
  <li>
    <h5>Meals & Meal details</h5>
    <hr />
    <table>
      <tr>
        <th>Downloading item image</th>
        <th>Item in category</th>
        <th>Item details</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/progress-image.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/item.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/item-details.png" width="274" height="450"></td>
      </tr>
    </table>
  </li>
  <li>
    <h5>Switching language</h5>
    <hr />
    <table>
      <tr>
        <th>English</th>
        <th>Arabic</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/en-lang.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/ar-lang.png" width="274" height="450"></td>
      </tr>
    </table>
  </li>
  <li>
    <h5>Adjust theme & colors</h5>
    <hr />
    <table>
      <tr>
        <th>Default theme</th>
        <th>Dark theme</th>
        <th>Change colors</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/theme-screen.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/dark-theme.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/change-color.png" width="274" height="450"></td>
      </tr>
    </table>
  </li>
  <li>
    <h5>Adjust filters</h5>
    <hr />
    <table>
      <tr>
        <th>Filters</th>
        <th>Add filter</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/filter-screen.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/add-filter.png" width="274" height="450"></td>
      </tr>
      <tr>
        <th>Filtered categorites</th>
        <th>Filterd items</th>
        <th>Unfiltered items</th>
      </tr>
      <tr>
        <td><img src="assets/screenshots/filtered-categories.png" width="274" height="450"> </td>
        <td><img src="assets/screenshots/items-with-filter.png" width="274" height="450"></td>
        <td><img src="assets/screenshots/items-without-filter.png" width="274" height="450"></td>
      </tr>
    </table>
  </li>
</ul>

<!--
* onBoarding
---
<img src="assets/screenshots/onBoarding01.png" width="274" height="450"> <img src="assets/screenshots/onBoarding02.png" width="274" height="450"> <img src="assets/screenshots/onBoarding03.png" width="274" height="450">
* Categories
---
<img src="assets/screenshots/home-categories.png" width="274" height="450">
---
* Favorite
---
| Empty favorite | Add item to favorite | Item in Favorite |
| -------------- | -------------------- | ---------------- |
| <img src="assets/screenshots/empty-favorite.png" width="274" height="450"> | <img src="assets/screenshots/add-item-favorite.png" width="274" height="450"> | <img src="assets/screenshots/favorite-item.png" width="274" height="450"> |
---
* Settings
---
<img src="assets/screenshots/side-menu.png" width="274" height="450">
---
* Meals & Meal details
---
| Downloading item image | Item in category | Item details |
| ---------------------- | ---------------- | ------------ |
| <img src="assets/screenshots/progress-image.png" width="274" height="450"> | <img src="assets/screenshots/item.png" width="274" height="450"> | <img src="assets/screenshots/item-details.png" width="274" height="450"> |
---
* Switching language
---
| English | Arabic |
| ------- | ------ |
| <img src="assets/screenshots/en-lang.png" width="274" height="450"> | <img src="assets/screenshots/ar-lang.png" width="274" height="450"> |
---
* Adjust theme & colors
---
| Default theme | Dark theme | Change colors |
| ------------- | ---------- | ------------- |
| <img src="assets/screenshots/theme-screen.png" width="274" height="450"> | <img src="assets/screenshots/dark-theme.png" width="274" height="450"> | <img src="assets/screenshots/change-color.png" width="274" height="450"> |
---
* Adjust filters
---
| Filters | Add filter |            |
| ------- | ---------- | ---------- |
| <img src="assets/screenshots/filter-screen.png" width="274" height="450"> | <img src="assets/screenshots/add-filter.png" width="274" height="450"> |
| Filtered categorites | Filterd items | Unfiltered items |
| <img src="assets/screenshots/filtered-categories.png" width="274" height="450"> | <img src="assets/screenshots/items-with-filter.png" width="274" height="450"> | <img src="assets/screenshots/items-without-filter.png" width="274" height="450"> |
-->
<!-- width=274 cause Github width is 824, and we have 3 images so 824/3 = 274.7 -->
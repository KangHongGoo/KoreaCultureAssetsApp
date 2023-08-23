# CultureAssetsApp
<br>

# 🖥 프로젝트 소개
<br>

우리나라 문화재인 국보, 보물의 위치와 정보를 제공하는 어플리케이션 입니다.
<br>
<br>
# ⏳ 개발 기간
<br>
- 23.06.01 ~ 23.08.23
<br>
<br>

# 💡 주요 기능

<br>

| 기능 | 내용 |
| --- | --- |
| 위치 서비스 | 단말기를 통해 현재 위치 정보 획득 |
| 지도 / 마커 | 문화재 위치를 마커로 뿌려서 지도를 통해 한눈에 위치 파악 |
| 문화재 정보 | 문화재의 보관 장소, 문화재 지정번호, 명칭, 정보 확인 |
| 모빌리티 서비스 | 사용자가 지도에 뿌려진 마커 중 하나를 선택 시 사용자의 위치와 선택된 마커 사이에 최적 경로를 탐색 후 지도에 표시 |
<br>
<br>

# 🛠 개발 환경
<br>

- IDE : Android Stuiod 2022.3.1.19
- Language : Dart(Flutter)
<br>
<br>

# 📗 Library to use
<br>

| Name | Version |
| --- | --- |
| http | 1.0.0 |
| get | 4.6.5 |
| google_maps_flutter | 2.3.0 |
| geolocator | 9.0.2 |
| xml2json | 5.3.1 |
| carousel_slider | 4.2.0 |
<br>
<br>

# 📷 Screenshots
<br>

**어플 메인 화면**



![image](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/daa6b534-74b7-46d7-a897-d30da413518e)  ![Untitled](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/7767d60f-f19b-4692-a108-098d413758ac)
<br>
처음 어플을 시작하면 위치 서비스에 대한 동의를 얻습니다.
위치 서비스를 통해 사용자 위치에 맞는 날씨를 제공합니다.
메인 화면 이미지 사진을 사용자가 탭 하면 해당 문화재의 자세한 정보를 표시하는 창을 띄웁니다.
<br>

**지도 (국보/보물) 화면**


![Untitled 1](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/d1da3db4-4ea1-4e1b-9cf4-22fee1db3e48)   ![Untitled 2](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/7e907b88-070a-4e96-b794-38ea3c1b9498)
<br>



우측 상단에 드롭다운 버튼을 이용해 지역을 선택합니다.
<br>
<br>

**문화재 정보 화면**


![Untitled 3](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/4ce13747-5d55-4a17-9506-95959c517966)   ![Untitled 4](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/0961093d-52c1-4fd7-9ccb-caaaede1c8e1)
<br>


마커를 탭 했을 때 나오는 인포윈도우를 또 다시 탭 하면 문화재의 자세한 정보를 표시하는 창을 띄웁니다.
<br>
<br>

**모빌리티 서비스 화면**



![Untitled 5](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/5090556c-9f88-49b1-81dd-b18049b053ec)

<br>
지도에서 마커를 탭 하면 단말기의 위치를 이용해 사용자 위치와 탭 한 마커 사이의 최적 경로를 표시합니다.

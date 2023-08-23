# CultureAssetsApp

# 🖥 프로젝트 소개



우리나라 문화재인 국보, 보물의 위치와 정보를 제공하는 어플리케이션 입니다.

# ⏳ 개발 기간



- 23.06.01 ~ 23.08.23

# 💡 주요 기능



| 기능 | 내용 |
| --- | --- |
| 위치 서비스 | 단말기를 통해 현재 위치 정보 획득 |
| 지도 / 마커 | 문화재 위치를 마커로 뿌려서 지도를 통해 한눈에 위치 파악 |
| 문화재 정보 | 문화재의 보관 장소, 문화재 지정번호, 명칭, 정보 확인 |
| 모빌리티 서비스 | 사용자가 지도에 뿌려진 마커 중 하나를 선택 시 사용자의 위치와 선택된 마커 사이에 최적 경로를 탐색 후 지도에 표시 |

# 🛠 개발 환경



- IDE : Android Stuiod 2022.3.1.19
- Language : Dart(Flutter)

# 📗 Library to use

---

| Name | Version |
| --- | --- |
| http | 1.0.0 |
| get | 4.6.5 |
| google_maps_flutter | 2.3.0 |
| geolocator | 9.0.2 |
| xml2json | 5.3.1 |
| carousel_slider | 4.2.0 |

# 📷 Screenshots



**어플 메인 화면**

![Untitled](https://github.com/KangHongGoo/KoreaCultureAssetsApp/assets/132973559/7767d60f-f19b-4692-a108-098d413758ac)


메인 화면 이미지 사진을 사용자가 탭 하면 해당 문화재의 자세한 정보를 표시하는 창을 띄웁니다.

**지도 (국보/보물) 화면**

![Untitled](%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A5%E1%84%90%E1%85%A5%20ReadMe%201d07393ecb5640268eef4b82043193ed/Untitled%201.png)

![Untitled](%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A5%E1%84%90%E1%85%A5%20ReadMe%201d07393ecb5640268eef4b82043193ed/Untitled%202.png)

우측 상단에 드롭다운 버튼을 이용해 지역을 선택합니다.

**문화재 정보 화면**

![Untitled](%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A5%E1%84%90%E1%85%A5%20ReadMe%201d07393ecb5640268eef4b82043193ed/Untitled%203.png)

![Untitled](%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A5%E1%84%90%E1%85%A5%20ReadMe%201d07393ecb5640268eef4b82043193ed/Untitled%204.png)

마커를 탭 했을 때 나오는 인포윈도우를 또 다시 탭 하면 문화재의 자세한 정보를 표시하는 창을 띄웁니다.

**모빌리티 서비스 화면**

![Untitled](%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A5%E1%84%90%E1%85%A5%20ReadMe%201d07393ecb5640268eef4b82043193ed/Untitled%205.png)

지도에서 마커를 탭 하면 단말기의 위치를 이용해 사용자 위치와 탭 한 마커 사이의 최적 경로를 표시합니다.

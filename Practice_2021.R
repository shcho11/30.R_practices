# 1. 연산자 ----
# 1.1 산술 연산자 ----
# +, -, *, /, **, ^, %%, %/%
3 + 4
3 - 4
3 * 4
3 / 4
3 ** 4   # 거듭제곱
3 ^ 4    # 거듭제곱 
13 %% 4  # 나머지
13 %/% 4 # 몫


# 1.2 할당 연산자 ----
# 저장하는 기능
# <-, ->, =
# <- : 오른쪽의 작업 결과를 왼쪽의 이름에 저장하기
# -> : 왼쪽의 작업 결과를 오른쪽의 이름에 저장하기
# =  : 함수 안에서 argument를 저장하는 기능
x <- rnorm(n = 100, mean = 10, sd = 2)
x

# x           : 데이터의 이름
# <-          : 난수 작업결과를 저장하는 기능
# rnorm()     : 난수를 생성해 주는 함수
# n, mean, sd : rnorm 함수의 argument
# n           : 난수의 개수
# mean        : 정규분포의 평균, default는 0
# sd          : 정규분포의 표준편차, default는 1


# 1.3 비교 연산자 ----
# 조건에 맞는 데이터를 추출할 때에 사용함
# >, >=, <, <=, ==, !=, !
3 > 4     # greater than
3 >= 4    # greater than equal to
3 < 4     # less than
3 <= 4    # less than equal to
3 == 4    # equal to
3 != 4    # not equal to
!(3 == 4) # not


# 1.4 논리 연산자 ----
# 조건을 2개 이상 줄 때
# &, |
# & : and, 여러 개의 조건을 동시에 만족하는 데이터 추출
# | : or,  여러 개으 조건 중에서 하나만 만족해도 데이터 추출
(3 > 4) & (5 > 4)
(3 > 4) | (5 > 4)


# 2. 데이터의 유형(Type of Data) ----
# 2.1 수치형(Numeric) ----
# (1) 정수(int : integer)
# (2) 실수(double)
x1 <- 10
x2 <- 10.2


# 2.2 문자형(Character) ----
x3 <- '인생은 고통의 바다이다.'
x4 <- "문제가 문제가 아니라 문제를 대하는 나의 태도가 문제다."


# 2.3 논리형(Logical) ----
x5 <- TRUE  # T
x6 <- FALSE # F


# 3. 엑셀 데이터 불러오기(읽어오기) ----
# 패키지(Package) : readxl
# 패키지 설치하기 : install.packages("readxl")
install.packages("readxl",
                 repose = "https://cran.yu.ac.kr/")


# 4. csv 데이터 불러오기(읽어오기) ----
# data_name <- read.csv(file   = "directory/filename.csv",
#                       header = TRUE or FALSE)
diamonds <- read.csv(file   = "d:/KB/diamonds.csv",
                     header = TRUE)


# 5. 탐색적 데이터 분석(EDA : Exploratory Data Analysis) ----
# 표, 그래프, 기술통계량
# 데이터의 특징을 파악하는 분석

# 범주형 자료(질적 자료) : 문자, 숫자(숫자의 의미가 없음)
# 수치형 자료(양적 자료) : 숫자(숫자의 의미가 있음)

# 데이터 보기 : View(data)
View(diamonds)

# data : diamonds
# 범주형 자료(질적 자료) : cut, color, clarity
# 수치형 자료(양적 자료) : carat, depth, table, price, x, y, z


# 5.1 범주형 자료의 분석 : 1개 ---
# (1) 표 = 빈도표(Frequency Table)
# i.  빈도(Frequency)
# ii. 백분율(Percent)
install.packages("tidyverse") # 데이터 분석 및 데이터 핸들링
library(tidyverse)

# data %>%
#     dplyr::count(범주형자료)           # 빈도를 구해줌
#     dplyr::mutate(퍼센트 = 퍼센트공식) # 백분율을 구해줌
diamonds %>% 
  dplyr::count(cut, sort = TRUE) %>% 
  dplyr::mutate(percent = (n/sum(n))*100)


# (2) 막대그래프
# data %>%
#     ggplot2::ggplot(mapping = aes(x = 범주형자료)) + 
#     ggplot2::geom_bar() # 그래프의 종류
diamonds %>% 
  ggplot2::ggplot(mapping = aes(x = cut)) +
  ggplot2::geom_bar()



# 5.2 수치형 자료의 분석 : 1개 ----
# (1) 표 = 빈도표
# i.  구간의 빈도
# ii. 구간의 백분율

# carat -> carat_group
# 0이상 ~ 2미만 -> "Light"
# 2이상 ~ 4미만 -> "Middle"
# 4이상 ~ 6미만 -> "Heavy"
diamonds %>% 
  dplyr::mutate(carat_group = cut(carat,
                                  breaks = c(0, 2, 4, 6),
                                  right  = FALSE,
                                  labels = c("Light", "Middle", "Heavy"))) -> diamonds
View(diamonds)

# carat       : 수치형 자료
# carat_group : 범주형 자료
diamonds %>% 
  dplyr::count(carat_group, sort = TRUE) %>% 
  dplyr::mutate(percent = (n/sum(n))*100)


# (2) 그래프
# i. 히스토그램(Histogram)
# data %>%
#    ggplot2::ggplot(mapping = aes(x = 수치형자료)) +
#    ggplot2::geom_histogram()
diamonds %>% 
  ggplot2::ggplot(mapping = aes(x = carat)) +
  ggplot2::geom_histogram() # 구간을 자동

diamonds %>% 
  ggplot2::ggplot(mapping = aes(x = carat)) +
  ggplot2::geom_histogram(breaks = c(0, 1, 2, 3, 4, 5, 6)) # 구간을 지정

diamonds %>% 
  ggplot2::ggplot(mapping = aes(x = carat)) +
  ggplot2::geom_histogram(binwidth = 0.5) # 구간의 너비

diamonds %>% 
  ggplot2::ggplot(mapping = aes(x = carat)) +
  ggplot2::geom_histogram(bins = 10) # 구간의 개수


# ii. 상자그림(Boxplot)
# 이상치(Outlier) : 아주 큰 값이나 또는 아주 작은 값
# 이상치 유무를 시각화

# data %>% 
#     ggplot2::ggplot(mapping = aes(y = 수치형자료)) +
#     ggplot2::geom_boxplot(outlier.color = "색")
diamonds %>% 
  ggplot2::ggplot(mapping = aes(y = carat)) +
  ggplot2::geom_boxplot(outlier.color = "red")


# (3) 기술통계량 = 요약통계량
# 기술통계량 : Descriptive Statistic
# 요약통계량 : Summary Statistic
# 수치형 자료들이 어떻게 생겼는지를 알려주는 숫자들

# i.   중심 = 대표값      : 평균, 절사평균, 중위수, 최빈수, 최소값, 최대값

# carat
# data %>%
#     dplyr::summarise(평균     = mean(수치형자료),
#                      절사평균 = mean(수치형자료, trim = ),
#                      중위수   = median(수치형자료))
diamonds %>% 
  dplyr::summarise(Mean        = mean(carat),
                   TrimmedMean = mean(carat, trim = 0.05),
                   Median      = median(carat))


# ii.  퍼짐 = 산포 = 다름 : 범위, 사분위범위, 표준편차, 중위수절대편차
#      표준편차       : 평균과 얼마나 다를까를 알려주는 값
#      중위수절대편차 : 중위수와 얼마나 다를까를 알려주는 값

# data %>% 
#     dplyr::summarise(범위           = max(수치형자료) - min(수치형자료),
#                      사분위범위     = IQR(수치형자료),
#                      표준편차       = sd(수치형자료),
#                      중위수절대편차 = mad(수치형자료))
diamonds %>% 
  dplyr::summarise(Range = max(carat) - min(carat),
                   IQR   = IQR(carat),
                   SD    = sd(carat),
                   MAD   = mad(carat))
# IQR : Inter Quartile Range의 약자
# SD  : Standard Deviation의 약자
# MAD : Median Absolute Deviation의 약자

# iii. 분포의 모양

# 왜도(skewness) : 대칭 여부를 알려주는 값.
# 첨도(kurtosis) : 중심이 얼마나 뾰족한가를 알려주는 값.

# 왜도 : e1071:skewness(수치형자료)
# 첨도 : e1071::kurtosis(수치형자료)

install.packages("e1071")
library(e1071)

diamonds %>% 
  dplyr::summarise(SKEW = e1071::skewness(carat),
                   KURT = e1071::kurtosis(carat))
















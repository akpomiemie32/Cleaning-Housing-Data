--Cleaning Data Using SQL Queries
--SELECT *
--FROM NashvilleHousingData



--Standardize Date Format

--SELECT saledateconverted, CONVERT(date,SaleDate)
--FROM NashvilleHousingData


--UPDATE NashvilleHousingData
--SET SaleDate = CONVERT(date,SaleDate)


--ALTER TABLE NashvilleHousingData
--ADD saledateconverted date


--UPDATE NashvilleHousingData
--SET saledateconverted = CONVERT(date,SaleDate)



--Populate Property Address Data

--SELECT *
--FROM NashvilleHousingData
----WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

--SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
--FROM NashvilleHousingData A
--JOIN NashvilleHousingData B
--    ON A.ParcelID = B.ParcelID
--	AND A.[UniqueID ]<> B.[UniqueID ]
--WHERE A.PropertyAddress IS NULL


--UPDATE A
--SET PropertyAddress = ISNULL(A.PropertyAddress,B.PropertyAddress)
--FROM NashvilleHousingData A
--JOIN NashvilleHousingData B
--    ON A.ParcelID = B.ParcelID
--	AND A.[UniqueID ]<> B.[UniqueID ]
--WHERE A.PropertyAddress IS NULL



--Breaking Address Into Individual Columns (Address, City, State)

--SELECT PropertyAddress
--FROM NashvilleHousingData

--SELECT
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
--SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address

--FROM NashvilleHousingData



--ALTER TABLE NashvilleHousingData
--ADD PropertySplitAddress	Nvarchar(255)


--UPDATE NashvilleHousingData
--SET PropertySplitAddress =  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


--ALTER TABLE NashvilleHousingData
--ADD PropertySplitCity Nvarchar(255)


--UPDATE NashvilleHousingData
--SET  PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))



--SELECT  *
--FROM NashvilleHousingData




--SELECT 
--PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,3)
--,PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,2)
--,PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,1)
--FROM NashvilleHousingData


--ALTER TABLE NashvilleHousingData
--ADD  OwnerSplitAddress Nvarchar(255)


--UPDATE NashvilleHousingData
--SET  OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,3)


--ALTER TABLE NashvilleHousingData
--ADD   OwnerSplitCity Nvarchar(255)


--UPDATE NashvilleHousingData
--SET  OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,2)



--ALTER TABLE NashvilleHousingData
--ADD    OwnerSplitState Nvarchar(255)


--UPDATE NashvilleHousingData
--SET  OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',',   '.')  ,1)


--SELECT  *
--FROM NashvilleHousingData





--Change Y and N to Yes and No in "Sold as Vacant" field 

--SELECT  DISTINCT ( SoldAsVacant), COUNT( SoldAsVacant )
--FROM NashvilleHousingData
--GROUP BY SoldAsVacant
--ORDER BY 2



--SELECT  SoldAsVacant
--, CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
--       WHEN SoldAsVacant = 'N' THEN 'NO'
--	   ELSE SoldAsVacant
--	   END
--FROM NashvilleHousingData


--UPDATE NashvilleHousingData
--SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
--       WHEN SoldAsVacant = 'N' THEN 'NO'
--	   ELSE SoldAsVacant
--	   END



	   --Remove Duplicates

WITH RowNumCTE AS(
SELECT*, ROW_NUMBER() OVER (
        PARTITION BY ParcelID,
		             PropertyAddress,
					 SaleDate,
					 SalePrice,
					 LegalReference
					 ORDER BY 
					 UniqueID
					 )Row_Num
	   

FROM NashvilleHousingData)
--ORDER BY ParcelID

SELECT*
FROM RowNumCTE
WHERE Row_Num >  1
--ORDER BY PropertyAddress




--Delete Unused Column

SELECT  *
FROM NashvilleHousingData


ALTER TABLE NashvilleHousingData
DROP COLUMN OwnerAddress,TaxDistrict,PropertyAddress



ALTER TABLE NashvilleHousingData
DROP COLUMN SaleDate
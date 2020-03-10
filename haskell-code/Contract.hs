module Contract where


type Amount = Int
data Currency = GBP | EUR | USD deriving Show
data Date = Date String deriving (Show, Eq, Ord)
--data Date = DateZ deriving Ord
data One = Int deriving Show

data Payment = Payment Amount Currency deriving Show


data Contract = 
    Zero
    | One Currency
    | Multiple Amount Contract -- Kombinator! 
    | Later Date Contract   -- den Vertrag später abschließen
    | Invert Contract
    | Both Contract Contract
    deriving Show 
--    | ZCB Amount Currency Date


scale :: Amount->Payment->Payment
scale amount1 (Payment amount2 currency) = 
               Payment(amount1 * amount2 ) currency

listMap :: (a -> b) -> [a] -> [b]
listMap f [] = [] -- leere Liste
listMap f (first:rest) = 
     (f first) : listMap f rest


evolve :: Date -> Contract -> (Contract, [Payment])

-- Was ist mit dem Vertrag bis jetzt passiert?
evolve date Zero = (Zero, [])
evolve date (One currency) = (Zero, [Payment 1 currency])
evolve date (Multiple factor contract ) = 
                    let (contractAfter, payments) = evolve date contract
                    in (Multiple factor contractAfter,
                         listMap(scale factor) payments)
evolve date (Later date' contract) = 
                  if  date >= date'
                  then evolve date contract
                  else (Later date' contract, [])
evolve date (Invert contract) = 
                    let (contractAfter, payments) = evolve date contract
                    in (Invert contractAfter,
                         listMap(scale (-1)) payments)
evolve date (Both contract1 contract2) = 
                  let (contract1', payments1) = evolve date contract1
                      (contract2', payments2) = evolve date contract2
                  in (Both contract1' contract2', 
                      payments1 ++ payments2)

--zcb1 = ZCB 100 EUR (Date "2021-01-21")

c1 = One EUR -- ich bekomme ein Euro jetzt

c2 = Multiple 100 (One EUR)

c3 = Multiple 20 c2


zcb amount currency date = Later date (Multiple amount (One currency))

zcb1 = zcb 100 EUR (Date "2021-01-21")


zcb2 = zcb 100 EUR (Date "2022-01-21")

cc = Both zcb1 (Invert zcb2)

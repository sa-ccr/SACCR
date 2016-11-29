GroupIRDTrades = function(group_trades, trade_classes_tree,hedging_set_name)
{
  
  # picking up the currencies found in the IRD trades which will be the first-level grouping applied 
  currencies   <- unique(lapply(group_trades, function(x) x$Currency))
  
  if(!missing(hedging_set_name))
  {
    if(substr(hedging_set_name,1,4)=="Vol_"||substr(hedging_set_name,1,6)=="Basis_")
      temp_currencies = paste0(hedging_set_name,"_",currencies)
    
  }else
  { temp_currencies = currencies}
  
  
  currencies_tree = list()
  for (j  in 1:length(currencies))
  {
    currencies_tree[[j]] = trade_classes_tree$AddChild(temp_currencies[[j]])
    
    currency_trades  <- group_trades[sapply(group_trades, function(x) (x$Currency==currencies[j]))]
    
    # after picking up the trades related to a specific currency, a second-level grouping will take place
    # based on the time buckets
    timebuckets       <- unique(lapply(currency_trades, function(x) x$TimeBucket))
    timebuckets_tree = list()
    
    for (k in 1:length(timebuckets))
    {
      timebuckets_tree[[k]] = currencies_tree[[j]]$AddChild(timebuckets[[k]])
      
      #picking up all the trades belonging to a specific timebucket
      timebuckets_trades  <- currency_trades[sapply(currency_trades, function(x) x$TimeBucket==timebuckets[k])]
      
      for (l in 1:length(timebuckets_trades))
      {
        tree_trade = timebuckets_tree[[k]]$AddChild(timebuckets_trades[[l]]$external_id)
        tree_trade$trade_details = Trading::GetTradeDetails(timebuckets_trades[[l]])
        tree_trade$trade = timebuckets_trades[[l]]
      }
    }
  }
  return(trade_classes_tree)
}
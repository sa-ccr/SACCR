GroupCommTrades = function(group_trades, trade_classes_tree, hedging_set_name)
{
  AssetClass <-'Commodity'
  
  # for the commodities case the Hedging sets will be created based on the commodity sector on a first
  # level (energy,metals etc) and on a second level based on the actual commodities (oil, silver etc)
  HedgingSets   <- unique(lapply(group_trades, function(x) x$SubClass))
  
  if(!missing(hedging_set_name))
  {
    if(substr(hedging_set_name,1,4)=="Vol_"||substr(hedging_set_name,1,6)=="Basis_")
      temp_HedgingSets = paste0(hedging_set_name,"_", HedgingSets)
    
  }else
  { temp_HedgingSets = HedgingSets}
  
  HedgingSets_addon <- array(data<-0,dim<-length(HedgingSets))
  HedgingSets_tree = list()
  for (j  in 1:length(HedgingSets))
  {  
    HedgingSets_trades  <- group_trades[sapply(group_trades, function(x) (x$SubClass == HedgingSets[j]))]
    
    com_types       <- unique(lapply(HedgingSets_trades, function(x) x$commodity_type))
    com_types_addon <- array(data<-0,dim<-length(com_types))
    HedgingSets_tree[[j]] = trade_classes_tree$AddChild(temp_HedgingSets[[j]])
    com_types_tree = list()
    for (k in 1:length(com_types))
    {  
      com_types_trades  <- HedgingSets_trades[sapply(HedgingSets_trades, function(x) x$commodity_type==com_types[k])]
      com_types_tree[[k]] = HedgingSets_tree[[j]]$AddChild(com_types[[k]])
      
      for (l in 1:length(com_types_trades))
      { 
        tree_trade = com_types_tree[[k]]$AddChild(com_types_trades[[l]]$external_id)
        tree_trade$trade_details = Trading::GetTradeDetails(com_types_trades[[l]])
        tree_trade$trade = com_types_trades[[l]]
      }
      
    }
  }
  return(trade_classes_tree)
}
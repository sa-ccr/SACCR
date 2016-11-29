GroupCreditTrades = function(group_trades, trade_classes_tree,hedging_set_name)
{
  # for the Credit case the Hedging sets will be created based on the reference entity
  refEntities   <- unique(lapply(group_trades, function(x) x$RefEntity))
  
  if(!missing(hedging_set_name))
  {
    if(substr(hedging_set_name,1,4)=="Vol_"||substr(hedging_set_name,1,6)=="Basis_")
      temp_refEntities = paste0(hedging_set_name,"_",refEntities)
    
  }else
  { temp_refEntities = refEntities}

refEntities_tree = list()

for (j  in 1:length(refEntities))
{  
  refEntities_trades  <- group_trades[sapply(group_trades, function(x) (x$RefEntity == refEntities[j]))]
  refEntities_tree[[j]] = trade_classes_tree$AddChild(temp_refEntities[[j]])
  for (k in 1:length(refEntities_trades))
  {
    tree_trade = refEntities_tree[[j]]$AddChild(refEntities_trades[[k]]$external_id)
    tree_trade$trade_details = Trading::GetTradeDetails(refEntities_trades[[k]])
    tree_trade$trade = refEntities_trades[[k]]
  }
}
return(trade_classes_tree)
}
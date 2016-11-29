GroupFXTrades = function(group_trades, trade_classes_tree,hedging_set_name)
{
  
  # for the FX case the Hedging sets will be created based on the ccy pair
  ccypairs   <- unique(lapply(group_trades, function(x) x$ccyPair))
  
  if(!missing(hedging_set_name))
  {
    if(substr(hedging_set_name,1,4)=="Vol_"||substr(hedging_set_name,1,6)=="Basis_")
      temp_ccypairs = paste0(hedging_set_name,"_",ccypairs)
    
  }else
  { temp_ccypairs = ccypairs}
  
  ccypairs_addon <- array(data<-0,dim<-length(ccypairs))
  ccypairs_tree = list()
  # going through all the ccy pairs found
  for (j  in 1:length(ccypairs))
  {  
    # picking up all the trades for this ccy pair
    ccypairs_trades  <- group_trades[sapply(group_trades, function(x) (x$ccyPair==temp_ccypairs[j]))]
    ccypairs_tree[[j]] = trade_classes_tree$AddChild(temp_ccypairs[[j]])
    
    for (l in 1:length(ccypairs_trades))
    {
      tree_trade = ccypairs_tree[[j]]$AddChild(ccypairs_trades[[l]]$external_id)
      tree_trade$trade_details = Trading::GetTradeDetails(ccypairs_trades[[l]])
      tree_trade$trade = ccypairs_trades[[l]]
    }
  }
  return(trade_classes_tree)
}
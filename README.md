# SACCR
R package implementing the SA-CCR methodology included in CRR2

Computes the Exposure-At-Default based on  the standardized approach
    of CRR2 (SA-CCR). The simplified version of SA-CCR has been included, as well as the OEM methodology.
	Multiple trade types of all the five major asset classes are being supported including the 'Other' Exposure and, given the inheritance-
    based structure of the application, the addition of further trade types
    is straightforward. The application returns a list of trees per Counterparty and CSA after
    automatically separating the trades based on the Counterparty, the CSAs, the hedging sets, the
    netting sets and the risk factors. The basis and volatility transactions are
    also identified and treated in specific hedging sets whereby the corresponding 
    penalty factors are applied. All the examples appearing on the
    regulatory papers (both for the margined and the un-margined workflow) have been
    implemented including the latest CRR2 developments.

If you want to become a contributor to this project, use this code for commercial purposes or for any other queries please contact us at info@openriskcalculator.com or visit our website www.openriskcalculator.com

# Donate 

If you have found this software of use, please consider supporting us by donating below:

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick" />
<input type="hidden" name="hosted_button_id" value="SRBWEQJYJ8QM4" />
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt="" border="0" src="https://www.paypal.com/en_GR/i/scr/pixel.gif" width="1" height="1" />
</form>

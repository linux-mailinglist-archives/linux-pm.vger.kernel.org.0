Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68057453CCD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 00:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKPXro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 18:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhKPXrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 18:47:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFAC061570;
        Tue, 16 Nov 2021 15:44:44 -0800 (PST)
Date:   Wed, 17 Nov 2021 00:44:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637106282;
        bh=tm3TSfY4cAnVraxIAQpho/lmj5Z/rdD/Z5W8p2qmLxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLMIqtLK6GYAzsWagI5KaSSAAZZFPSRiSCf5dsOTx7NNHLjb7K7IwUTPVJ0t5UQ8F
         o3AO6mJgMAxkXPu1a/b8Y4LVDIpeMs0BrUe9YL3iFAPMXiqNNL7V4fYpzwUs2q6qgb
         CeUDrP2lEo+1dtauTKjpOM9j+FgmOpWtEOF6Ttls=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, nicolopiazzalunga@gmail.com, njoshi1@lenovo.com,
        smclt30p@gmail.com
Subject: Re: [External] [PATCH 4/4] platform/x86: thinkpad_acpi: support
 inhibit-charge
Message-ID: <986a547b-67c5-4116-9b2a-d3ba7b2f7847@t-8ch.de>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <20211113104225.141333-5-linux@weissschuh.net>
 <82ec6164-223b-940a-6992-48ccbe47a615@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82ec6164-223b-940a-6992-48ccbe47a615@lenovo.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 2021-11-16 15:52-0500, Mark Pearson wrote:
> On 2021-11-13 05:42, Thomas Weißschuh wrote:
> > This adds support for the inhibit-charge charge_behaviour through the
> > embedded controller of ThinkPads.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > ---
> > 
> > This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/>> ---
> >  drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index e8c98e9aff71..7cd6475240b2 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
> >  #define SET_STOP	"BCSS"
> >  #define GET_DISCHARGE	"BDSG"
> >  #define SET_DISCHARGE	"BDSS"
> > +#define GET_INHIBIT	"PSSG"
> > +#define SET_INHIBIT	"BICS"
> >  
> >  enum {
> >  	BAT_ANY = 0,
> > @@ -9338,6 +9340,7 @@ enum {
> >  	THRESHOLD_START,
> >  	THRESHOLD_STOP,
> >  	FORCE_DISCHARGE,
> > +	INHIBIT_CHARGE,
> >  };
> >  
> >  struct tpacpi_battery_data {
> > @@ -9409,6 +9412,13 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
> >  		/* The force discharge status is in bit 0 */
> >  		*ret = *ret & 0x01;
> >  		return 0;
> > +	case INHIBIT_CHARGE:
> > +		/* This is actually reading peak shift state, like tpacpi-bat does */
> > +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
> > +			return -ENODEV;
> > +		/* The inhibit charge status is in bit 0 */
> > +		*ret = *ret & 0x01;
> > +		return 0;
> >  	default:
> >  		pr_crit("wrong parameter: %d", what);
> >  		return -EINVAL;
> > @@ -9447,6 +9457,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
> >  			return -ENODEV;
> >  		}
> >  		return 0;
> > +	case INHIBIT_CHARGE:
> > +		/* When setting inhibit charge, we set a default value of
> > +		 * always breaking on AC detach and the effective time is set to
> > +		 * be permanent.
> > +		 * The battery ID is in bits 4-5, 2 bits,
> > +		 * the effective time is in bits 8-23, 2 bytes.
> > +		 * A time of FFFF indicates forever.
> > +		 */
> > +		param = value;
> > +		param |= battery << 4;
> > +		param |= 0xFFFF << 8;
> > +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param))) {
> > +			pr_err("failed to set inhibit charge on %d", battery);
> > +			return -ENODEV;
> > +		}
> > +		return 0;
> >  	default:
> >  		pr_crit("wrong parameter: %d", what);
> >  		return -EINVAL;
> > @@ -9467,6 +9493,8 @@ static int tpacpi_battery_probe(int battery)
> >  	 * 4) Check for support
> >  	 * 5) Get the current force discharge status
> >  	 * 6) Check for support
> > +	 * 7) Get the current inhibit charge status
> > +	 * 8) Check for support
> >  	 */
> >  	if (acpi_has_method(hkey_handle, GET_START)) {
> >  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> > @@ -9513,6 +9541,16 @@ static int tpacpi_battery_probe(int battery)
> >  			battery_info.batteries[battery].charge_behaviours |=
> >  				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
> >  	}
> > +	if (acpi_has_method(hkey_handle, GET_INHIBIT)) {
> > +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, battery))) {
> > +			pr_err("Error probing battery inhibit charge; %d\n", battery);
> > +			return -ENODEV;
> > +		}
> > +		/* Support is marked in bit 5 */
> > +		if (ret & BIT(5))
> > +			battery_info.batteries[battery].charge_behaviours |=
> > +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> > +	}
> >  
> >  	battery_info.batteries[battery].charge_behaviours |=
> >  		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
> > @@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
> >  			return -ENODEV;
> >  		if (ret)
> >  			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> > +	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
> > +		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
> > +			return -ENODEV;
> > +		if (ret)
> > +			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> >  	}
> >  
> >  	return power_supply_charge_behaviour_show(dev, available, active, buf);
> > @@ -9710,12 +9753,20 @@ static ssize_t charge_behaviour_store(struct device *dev,
> >  	switch (selected) {
> >  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> >  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> > -		if (ret < 0)
> > +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> > +		if (ret)
> >  			return ret;
> >  		break;
> >  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> >  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
> > -		if (ret < 0)
> > +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> > +		if (ret)
> > +			return ret;
> > +		break;
> > +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> > +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 1) || ret;
> > +		if (ret)
> >  			return ret;
> >  		break;
> >  	default:
> > 
> 
> I can confirm the bit fields are correct for these calls (as for the
> previous patch)

Thanks!

Could you doublecheck the behavior for multiple batteries to maybe find a
reason why BAT1 is not inhibited as reported by Thomas Koch [0]?

> Couple of things to note, based on feedback previously from the FW team
> that I found when digging thru my battery related emails.
> 
> "Lenovo doesn't officially support the use of these calls - they're
> intended for internal use" (at this point in time - there is some
> discussion about battery recalibration support but I don't have details
> I can share there yet).
> 
> The FW team also noted that:
> 
> "Actual battery charging/discharging behaviors are managed by ECFW. So
> the request of BDSS/BICS method may be rejected by ECFW for the current
> battery mode/status. You have to check if the request of the method is
> actually applied or not"
> 
> So for the calls above (and for the BDSS calls in the previous patch) it
> would be good to do a read back of the setting to ensure it has
> completed successfully.

I'll add that for v2.

> Hope that helps

It does, thanks!

Thomas

[0] https://lore.kernel.org/platform-driver-x86/9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net/

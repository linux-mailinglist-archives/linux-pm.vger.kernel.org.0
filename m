Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21EF4654AF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbhLASGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 13:06:31 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57455 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhLASGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 13:06:31 -0500
Received: (Authenticated sender: foss@0leil.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 756D060010;
        Wed,  1 Dec 2021 18:03:07 +0000 (UTC)
Date:   Wed, 1 Dec 2021 19:03:04 +0100
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: [PATCH] power: supply: axp20x_battery: properly report current
 when discharging
Message-ID: <20211201180304.z2jtgi5udwcjf2wa@fiqs>
References: <20211119181835.441233-1-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119181835.441233-1-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Evgeny,

On Fri, Nov 19, 2021 at 09:18:35PM +0300, Evgeny Boger wrote:
> As stated in [1], negative current values are used for discharging
> batteries.
> 
> AXP PMICs internally have two different ADC channels for shunt current
> measurement: one used during charging and one during discharging.
> The values reported by these ADCs are unsigned.
> While the driver properly selects ADC channel to get the data from,
> it doesn't apply negative sign when reporting discharging current.
> 
> [1] Documentation/ABI/testing/sysfs-class-power
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 18a9db0df4b1..4ed01777035b 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -186,7 +186,6 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  				   union power_supply_propval *val)
>  {
>  	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> -	struct iio_channel *chan;
>  	int ret = 0, reg, val1;
>  
>  	switch (psp) {
> @@ -267,11 +266,11 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  			return ret;
>  
>  		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
> -			chan = axp20x_batt->batt_chrg_i;
> -		else
> -			chan = axp20x_batt->batt_dischrg_i;
> -
> -		ret = iio_read_channel_processed(chan, &val->intval);
> +			ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
> +		else {

The if should also have curly brackets now, even if it's only one line.

> +			ret = iio_read_channel_processed(axp20x_batt->batt_dischrg_i, &val1);
> +			val->intval = -val1;
> +		}

Otherwise, since the ABI is not deemed stable (testing in the path of
the name), I guess there;s no contract with userspace and we're fine
fixing this broken behavior (which userspace might have worked-around
themselves and thus we break userspace).

@Sebastian, is that ok?

Cheers,
Quentin

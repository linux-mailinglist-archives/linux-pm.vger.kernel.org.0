Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDE2F0D3D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAKHd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:33:27 -0500
Received: from mail.bugwerft.de ([46.23.86.59]:42736 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbhAKHd1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 02:33:27 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 02:33:25 EST
Received: from [192.168.178.79] (pd95ef192.dip0.t-ipconnect.de [217.94.241.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 21D474A1917;
        Mon, 11 Jan 2021 07:24:31 +0000 (UTC)
Subject: Re: [PATCH] power: supply: wm97xx_battery: Convert to GPIO descriptor
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
References: <20210110234508.218768-1-linus.walleij@linaro.org>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <6a7f256c-d9ec-4c5f-6024-0ec8296a9f95@zonque.org>
Date:   Mon, 11 Jan 2021 08:24:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210110234508.218768-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/1/2021 12:45 am, Linus Walleij wrote:
> This converts the WM97xx driver to use a GPIO descriptor
> instead of passing a GPIO number thru platform data.
> 
> Like everything else in the driver, use a simple local
> variable for the descriptor, it can only ever appear in
> one instance anyway so it should not hurt.
> 
> After converting the driver I noticed that none of the
> boardfiles actually define a meaningful GPIO line for
> this, but hey, it is converted.
> 
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Daniel Mack <daniel@zonque.org>

Can we probably merge this through Sebastian's tree? The chance for
conflicts in this area is virtually non-existent.


Thanks,
Daniel



> ---
>  arch/arm/mach-pxa/mioa701.c           |  1 -
>  arch/arm/mach-pxa/palm27x.c           |  1 -
>  arch/arm/mach-pxa/palmte2.c           |  1 -
>  drivers/power/supply/wm97xx_battery.c | 45 +++++++++++----------------
>  include/linux/wm97xx.h                |  1 -
>  5 files changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index d3af80317f2d..a79f296e81e0 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -577,7 +577,6 @@ static struct platform_device power_dev = {
>  static struct wm97xx_batt_pdata mioa701_battery_data = {
>  	.batt_aux	= WM97XX_AUX_ID1,
>  	.temp_aux	= -1,
> -	.charge_gpio	= -1,
>  	.min_voltage	= 0xc00,
>  	.max_voltage	= 0xfc0,
>  	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LION,
> diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
> index 0d246a1aebbc..6230381a7ca0 100644
> --- a/arch/arm/mach-pxa/palm27x.c
> +++ b/arch/arm/mach-pxa/palm27x.c
> @@ -212,7 +212,6 @@ void __init palm27x_irda_init(int pwdn)
>  static struct wm97xx_batt_pdata palm27x_batt_pdata = {
>  	.batt_aux	= WM97XX_AUX_ID3,
>  	.temp_aux	= WM97XX_AUX_ID2,
> -	.charge_gpio	= -1,
>  	.batt_mult	= 1000,
>  	.batt_div	= 414,
>  	.temp_mult	= 1,
> diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
> index e3bcf58b4e63..a2b10db4aacc 100644
> --- a/arch/arm/mach-pxa/palmte2.c
> +++ b/arch/arm/mach-pxa/palmte2.c
> @@ -273,7 +273,6 @@ static struct platform_device power_supply = {
>  static struct wm97xx_batt_pdata palmte2_batt_pdata = {
>  	.batt_aux	= WM97XX_AUX_ID3,
>  	.temp_aux	= WM97XX_AUX_ID2,
> -	.charge_gpio	= -1,
>  	.max_voltage	= PALMTE2_BAT_MAX_VOLTAGE,
>  	.min_voltage	= PALMTE2_BAT_MIN_VOLTAGE,
>  	.batt_mult	= 1000,
> diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
> index 58f01659daa5..a0e1eaa25d93 100644
> --- a/drivers/power/supply/wm97xx_battery.c
> +++ b/drivers/power/supply/wm97xx_battery.c
> @@ -15,11 +15,12 @@
>  #include <linux/wm97xx.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
>  
>  static struct work_struct bat_work;
> +static struct gpio_desc *charge_gpiod;
>  static DEFINE_MUTEX(work_lock);
>  static int bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
>  static enum power_supply_property *prop;
> @@ -96,12 +97,11 @@ static void wm97xx_bat_external_power_changed(struct power_supply *bat_ps)
>  static void wm97xx_bat_update(struct power_supply *bat_ps)
>  {
>  	int old_status = bat_status;
> -	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
>  
>  	mutex_lock(&work_lock);
>  
> -	bat_status = (pdata->charge_gpio >= 0) ?
> -			(gpio_get_value(pdata->charge_gpio) ?
> +	bat_status = (charge_gpiod) ?
> +			(gpiod_get_value(charge_gpiod) ?
>  			POWER_SUPPLY_STATUS_DISCHARGING :
>  			POWER_SUPPLY_STATUS_CHARGING) :
>  			POWER_SUPPLY_STATUS_UNKNOWN;
> @@ -171,18 +171,19 @@ static int wm97xx_bat_probe(struct platform_device *dev)
>  	if (dev->id != -1)
>  		return -EINVAL;
>  
> -	if (gpio_is_valid(pdata->charge_gpio)) {
> -		ret = gpio_request(pdata->charge_gpio, "BATT CHRG");
> -		if (ret)
> -			goto err;
> -		ret = gpio_direction_input(pdata->charge_gpio);
> -		if (ret)
> -			goto err2;
> -		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
> +	charge_gpiod = devm_gpiod_get_optional(&dev->dev, NULL, GPIOD_IN);
> +	if (IS_ERR(charge_gpiod))
> +		return dev_err_probe(&dev->dev,
> +				     PTR_ERR(charge_gpiod),
> +				     "failed to get charge GPIO\n");
> +	if (charge_gpiod) {
> +		gpiod_set_consumer_name(charge_gpiod, "BATT CHRG");
> +		ret = request_irq(gpiod_to_irq(charge_gpiod),
>  				wm97xx_chrg_irq, 0,
>  				"AC Detect", dev);
>  		if (ret)
> -			goto err2;
> +			return dev_err_probe(&dev->dev, ret,
> +					     "failed to request GPIO irq\n");
>  		props++;	/* POWER_SUPPLY_PROP_STATUS */
>  	}
>  
> @@ -204,7 +205,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
>  	}
>  
>  	prop[i++] = POWER_SUPPLY_PROP_PRESENT;
> -	if (pdata->charge_gpio >= 0)
> +	if (charge_gpiod)
>  		prop[i++] = POWER_SUPPLY_PROP_STATUS;
>  	if (pdata->batt_tech >= 0)
>  		prop[i++] = POWER_SUPPLY_PROP_TECHNOLOGY;
> @@ -242,23 +243,15 @@ static int wm97xx_bat_probe(struct platform_device *dev)
>  err4:
>  	kfree(prop);
>  err3:
> -	if (gpio_is_valid(pdata->charge_gpio))
> -		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
> -err2:
> -	if (gpio_is_valid(pdata->charge_gpio))
> -		gpio_free(pdata->charge_gpio);
> -err:
> +	if (charge_gpiod)
> +		free_irq(gpiod_to_irq(charge_gpiod), dev);
>  	return ret;
>  }
>  
>  static int wm97xx_bat_remove(struct platform_device *dev)
>  {
> -	struct wm97xx_batt_pdata *pdata = dev->dev.platform_data;
> -
> -	if (pdata && gpio_is_valid(pdata->charge_gpio)) {
> -		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
> -		gpio_free(pdata->charge_gpio);
> -	}
> +	if (charge_gpiod)
> +		free_irq(gpiod_to_irq(charge_gpiod), dev);
>  	cancel_work_sync(&bat_work);
>  	power_supply_unregister(bat_psy);
>  	kfree(prop);
> diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
> index 58e082dadc68..462854f4f286 100644
> --- a/include/linux/wm97xx.h
> +++ b/include/linux/wm97xx.h
> @@ -294,7 +294,6 @@ struct wm97xx {
>  struct wm97xx_batt_pdata {
>  	int	batt_aux;
>  	int	temp_aux;
> -	int	charge_gpio;
>  	int	min_voltage;
>  	int	max_voltage;
>  	int	batt_div;
> 


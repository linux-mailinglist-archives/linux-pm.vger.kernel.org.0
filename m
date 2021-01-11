Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F772F0D29
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhAKH03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbhAKH02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 02:26:28 -0500
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jan 2021 23:25:48 PST
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85678C061786
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 23:25:48 -0800 (PST)
Received: from [192.168.178.79] (pd95ef192.dip0.t-ipconnect.de [217.94.241.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 4C9204A191B;
        Mon, 11 Jan 2021 07:25:06 +0000 (UTC)
Subject: Re: [PATCH] power: supply: z2_battery: Convert to GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
References: <20210110144906.168877-1-linus.walleij@linaro.org>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <21aaf9d8-1cc3-a647-df5c-cc3777ced0f9@zonque.org>
Date:   Mon, 11 Jan 2021 08:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210110144906.168877-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/1/2021 3:49 pm, Linus Walleij wrote:
> This converts the Palm Z2 battery driver to use GPIO descriptors.
> 
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Daniel Mack <daniel@zonque.org>



> ---
>  arch/arm/mach-pxa/z2.c            | 12 +++++++-
>  drivers/power/supply/z2_battery.c | 46 ++++++++++++++-----------------
>  include/linux/z2_battery.h        |  1 -
>  3 files changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 21fd76bb09cd..a5dad8d08cac 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -488,7 +488,6 @@ static struct z2_battery_info batt_chip_info = {
>  	.batt_I2C_bus	= 0,
>  	.batt_I2C_addr	= 0x55,
>  	.batt_I2C_reg	= 2,
> -	.charge_gpio	= GPIO0_ZIPITZ2_AC_DETECT,
>  	.min_voltage	= 3475000,
>  	.max_voltage	= 4190000,
>  	.batt_div	= 59,
> @@ -497,9 +496,19 @@ static struct z2_battery_info batt_chip_info = {
>  	.batt_name	= "Z2",
>  };
>  
> +static struct gpiod_lookup_table z2_battery_gpio_table = {
> +	.dev_id = "aer915",
> +	.table = {
> +		GPIO_LOOKUP("gpio-pxa", GPIO0_ZIPITZ2_AC_DETECT,
> +			    NULL, GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static struct i2c_board_info __initdata z2_i2c_board_info[] = {
>  	{
>  		I2C_BOARD_INFO("aer915", 0x55),
> +		.dev_name = "aer915",
>  		.platform_data	= &batt_chip_info,
>  	}, {
>  		I2C_BOARD_INFO("wm8750", 0x1b),
> @@ -510,6 +519,7 @@ static struct i2c_board_info __initdata z2_i2c_board_info[] = {
>  static void __init z2_i2c_init(void)
>  {
>  	pxa_set_i2c_info(NULL);
> +	gpiod_add_lookup_table(&z2_battery_gpio_table);
>  	i2c_register_board_info(0, ARRAY_AND_SIZE(z2_i2c_board_info));
>  }
>  #else
> diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_battery.c
> index ebd2e42a4457..b1508fe70e5e 100644
> --- a/drivers/power/supply/z2_battery.c
> +++ b/drivers/power/supply/z2_battery.c
> @@ -6,7 +6,7 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -18,6 +18,7 @@
>  
>  struct z2_charger {
>  	struct z2_battery_info		*info;
> +	struct gpio_desc		*charge_gpiod;
>  	int				bat_status;
>  	struct i2c_client		*client;
>  	struct power_supply		*batt_ps;
> @@ -95,8 +96,8 @@ static void z2_batt_update(struct z2_charger *charger)
>  
>  	mutex_lock(&charger->work_lock);
>  
> -	charger->bat_status = (info->charge_gpio >= 0) ?
> -		(gpio_get_value(info->charge_gpio) ?
> +	charger->bat_status = charger->charge_gpiod ?
> +		(gpiod_get_value(charger->charge_gpiod) ?
>  		POWER_SUPPLY_STATUS_CHARGING :
>  		POWER_SUPPLY_STATUS_DISCHARGING) :
>  		POWER_SUPPLY_STATUS_UNKNOWN;
> @@ -131,7 +132,7 @@ static int z2_batt_ps_init(struct z2_charger *charger, int props)
>  	enum power_supply_property *prop;
>  	struct z2_battery_info *info = charger->info;
>  
> -	if (info->charge_gpio >= 0)
> +	if (charger->charge_gpiod)
>  		props++;	/* POWER_SUPPLY_PROP_STATUS */
>  	if (info->batt_tech >= 0)
>  		props++;	/* POWER_SUPPLY_PROP_TECHNOLOGY */
> @@ -147,7 +148,7 @@ static int z2_batt_ps_init(struct z2_charger *charger, int props)
>  		return -ENOMEM;
>  
>  	prop[i++] = POWER_SUPPLY_PROP_PRESENT;
> -	if (info->charge_gpio >= 0)
> +	if (charger->charge_gpiod)
>  		prop[i++] = POWER_SUPPLY_PROP_STATUS;
>  	if (info->batt_tech >= 0)
>  		prop[i++] = POWER_SUPPLY_PROP_TECHNOLOGY;
> @@ -206,22 +207,23 @@ static int z2_batt_probe(struct i2c_client *client,
>  
>  	mutex_init(&charger->work_lock);
>  
> -	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio)) {
> -		ret = gpio_request(info->charge_gpio, "BATT CHRG");
> -		if (ret)
> -			goto err;
> +	charger->charge_gpiod = devm_gpiod_get_optional(&client->dev,
> +							NULL, GPIOD_IN);
> +	if (IS_ERR(charger->charge_gpiod))
> +		return dev_err_probe(&client->dev,
> +				     PTR_ERR(charger->charge_gpiod),
> +				     "failed to get charge GPIO\n");
>  
> -		ret = gpio_direction_input(info->charge_gpio);
> -		if (ret)
> -			goto err2;
> +	if (charger->charge_gpiod) {
> +		gpiod_set_consumer_name(charger->charge_gpiod, "BATT CHRG");
>  
> -		irq_set_irq_type(gpio_to_irq(info->charge_gpio),
> +		irq_set_irq_type(gpiod_to_irq(charger->charge_gpiod),
>  				 IRQ_TYPE_EDGE_BOTH);
> -		ret = request_irq(gpio_to_irq(info->charge_gpio),
> +		ret = request_irq(gpiod_to_irq(charger->charge_gpiod),
>  				z2_charge_switch_irq, 0,
>  				"AC Detect", charger);
>  		if (ret)
> -			goto err3;
> +			goto err;
>  	}
>  
>  	ret = z2_batt_ps_init(charger, props);
> @@ -245,11 +247,8 @@ static int z2_batt_probe(struct i2c_client *client,
>  err4:
>  	kfree(charger->batt_ps_desc.properties);
>  err3:
> -	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio))
> -		free_irq(gpio_to_irq(info->charge_gpio), charger);
> -err2:
> -	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio))
> -		gpio_free(info->charge_gpio);
> +	if (charger->charge_gpiod)
> +		free_irq(gpiod_to_irq(charger->charge_gpiod), charger);
>  err:
>  	kfree(charger);
>  	return ret;
> @@ -258,16 +257,13 @@ static int z2_batt_probe(struct i2c_client *client,
>  static int z2_batt_remove(struct i2c_client *client)
>  {
>  	struct z2_charger *charger = i2c_get_clientdata(client);
> -	struct z2_battery_info *info = charger->info;
>  
>  	cancel_work_sync(&charger->bat_work);
>  	power_supply_unregister(charger->batt_ps);
>  
>  	kfree(charger->batt_ps_desc.properties);
> -	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio)) {
> -		free_irq(gpio_to_irq(info->charge_gpio), charger);
> -		gpio_free(info->charge_gpio);
> -	}
> +	if (charger->charge_gpiod)
> +		free_irq(gpiod_to_irq(charger->charge_gpiod), charger);
>  
>  	kfree(charger);
>  
> diff --git a/include/linux/z2_battery.h b/include/linux/z2_battery.h
> index eaba53ff387c..9e8be7a7cd25 100644
> --- a/include/linux/z2_battery.h
> +++ b/include/linux/z2_battery.h
> @@ -6,7 +6,6 @@ struct z2_battery_info {
>  	int	 batt_I2C_bus;
>  	int	 batt_I2C_addr;
>  	int	 batt_I2C_reg;
> -	int	 charge_gpio;
>  	int	 min_voltage;
>  	int	 max_voltage;
>  	int	 batt_div;
> 


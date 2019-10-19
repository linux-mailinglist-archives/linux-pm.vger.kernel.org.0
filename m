Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68052DD79A
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfJSJJs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 05:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfJSJJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Oct 2019 05:09:48 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF49C222C2;
        Sat, 19 Oct 2019 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571476187;
        bh=SobYbj/cE0iDf+fCkMv3zqZHgYr9EHU6yG7d+lpi12c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXd8X/6fp/eUzDLGupWpuJTmryrrbu5XFMOQrxNsHNeJHFQj6uNvvbvZ9OGtMJHsS
         72hDFinQbWgF5JfFZZI8nIUmSDZDcRJi6dH0dRp/5giLBnYtVq43vcJjDauTDzucmU
         0SlRAu/xCzmZSR+IBT+v2MvxvB4wkQjvCIDrV3IM=
Received: by earth.universe (Postfix, from userid 1000)
        id C31933C09B1; Sat, 19 Oct 2019 11:09:44 +0200 (CEST)
Date:   Sat, 19 Oct 2019 11:09:44 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 40/46] ARM: pxa: tosa: use gpio lookup for battery
Message-ID: <20191019090944.vfj3macmgb7i4253@earth.universe>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-40-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5kovz5serylce4st"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-40-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5kovz5serylce4st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2019 at 05:41:55PM +0200, Arnd Bergmann wrote:
> The battery driver uses a lot of GPIO lines, hardcoded from a
> machine header file.
>=20
> Change it to use a gpiod lookup table instead.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

That's a nice cleanup patch :) I assume, that this is also
merged together with the whole series through ARM, so:

Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  arch/arm/mach-pxa/tosa.c            |  23 +++++
>  drivers/power/supply/tosa_battery.c | 147 ++++++++++++++++------------
>  2 files changed, 109 insertions(+), 61 deletions(-)
>=20
> diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
> index 8329a2969b2b..ef3bbf6d158e 100644
> --- a/arch/arm/mach-pxa/tosa.c
> +++ b/arch/arm/mach-pxa/tosa.c
> @@ -365,6 +365,28 @@ static struct pxaficp_platform_data tosa_ficp_platfo=
rm_data =3D {
>  	.shutdown		=3D tosa_irda_shutdown,
>  };
> =20
> +static struct gpiod_lookup_table tosa_battery_gpio_table =3D {
> +	.dev_id =3D "wm97xx-battery",
> +	.table =3D {
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_CHARGE_OFF - TOSA_TC6393XB_GPIO_BASE=
,    "main charge off", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_CHARGE_OFF_JC - TOSA_TC6393XB_GPIO_B=
ASE, "jacket charge off", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT_SW_ON - TOSA_TC6393XB_GPIO_BASE,=
     "battery switch", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT0_V_ON - TOSA_TC6393XB_GPIO_BASE,=
     "main battery", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT1_V_ON - TOSA_TC6393XB_GPIO_BASE,=
     "jacket battery", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT1_TH_ON - TOSA_TC6393XB_GPIO_BASE=
,    "main battery temp", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT0_TH_ON - TOSA_TC6393XB_GPIO_BASE=
,    "jacket battery temp", GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BU_CHRG_ON - TOSA_TC6393XB_GPIO_BASE=
,    "backup battery", GPIO_ACTIVE_HIGH ),
> +
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT0_CRG,      "main battery full", =
GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT1_CRG,      "jacket battery full"=
, GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT0_LOW,      "main battery low", G=
PIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT1_LOW,      "jacket battery low",=
 GPIO_ACTIVE_HIGH ),
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_JACKET_DETECT, "jacket detect", GPIO=
_ACTIVE_HIGH ),
> +		{ },
> +	},
> +};
> +
> +
>  /*
>   * Tosa AC IN
>   */
> @@ -946,6 +968,7 @@ static void __init tosa_init(void)
>  	/* enable batt_fault */
>  	PMCR =3D 0x01;
> =20
> +	gpiod_add_lookup_table(&tosa_battery_gpio_table);
>  	gpiod_add_lookup_table(&tosa_mci_gpio_table);
>  	gpiod_add_lookup_table(&tosa_audio_gpio_table);
>  	pxa_set_mci_info(&tosa_mci_platform_data);
> diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/t=
osa_battery.c
> index b26b0eca33e1..d10320f348d0 100644
> --- a/drivers/power/supply/tosa_battery.c
> +++ b/drivers/power/supply/tosa_battery.c
> @@ -15,11 +15,16 @@
>  #include <linux/gpio.h>
> =20
>  #include <asm/mach-types.h>
> -#include <mach/tosa.h>
> =20
>  static DEFINE_MUTEX(bat_lock); /* protects gpio pins */
>  static struct work_struct bat_work;
> =20
> +struct tosa_gpio {
> +	const char *con;
> +	enum gpiod_flags flags;
> +	struct gpio_desc *desc;
> +};
> +
>  struct tosa_bat {
>  	int status;
>  	struct power_supply *psy;
> @@ -28,38 +33,42 @@ struct tosa_bat {
>  	struct mutex work_lock; /* protects data */
> =20
>  	bool (*is_present)(struct tosa_bat *bat);
> -	int gpio_full;
> -	int gpio_charge_off;
> +	struct tosa_gpio gpio_full;
> +	struct tosa_gpio gpio_charge_off;
> =20
>  	int technology;
> =20
> -	int gpio_bat;
> +	struct tosa_gpio gpio_bat;
>  	int adc_bat;
>  	int adc_bat_divider;
>  	int bat_max;
>  	int bat_min;
> =20
> -	int gpio_temp;
> +	struct tosa_gpio gpio_temp;
>  	int adc_temp;
>  	int adc_temp_divider;
>  };
> =20
>  static struct tosa_bat tosa_bat_main;
>  static struct tosa_bat tosa_bat_jacket;
> +static struct tosa_gpio gpiod_jacket_det =3D { "jacket detect", GPIOD_IN=
 };
> +static struct tosa_gpio gpiod_battery_switch =3D { "battery switch", GPI=
OD_OUT_LOW };
> +static struct tosa_gpio gpiod_main_battery_low =3D { "main battery low",=
 GPIOD_IN };
> +static struct tosa_gpio gpiod_jacket_battery_low =3D { "jacket battery l=
ow", GPIOD_IN };
> =20
>  static unsigned long tosa_read_bat(struct tosa_bat *bat)
>  {
>  	unsigned long value =3D 0;
> =20
> -	if (bat->gpio_bat < 0 || bat->adc_bat < 0)
> +	if (!bat->gpio_bat.desc || bat->adc_bat < 0)
>  		return 0;
> =20
>  	mutex_lock(&bat_lock);
> -	gpio_set_value(bat->gpio_bat, 1);
> +	gpiod_set_value(bat->gpio_bat.desc, 1);
>  	msleep(5);
>  	value =3D wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
>  			bat->adc_bat);
> -	gpio_set_value(bat->gpio_bat, 0);
> +	gpiod_set_value(bat->gpio_bat.desc, 0);
>  	mutex_unlock(&bat_lock);
> =20
>  	value =3D value * 1000000 / bat->adc_bat_divider;
> @@ -71,15 +80,15 @@ static unsigned long tosa_read_temp(struct tosa_bat *=
bat)
>  {
>  	unsigned long value =3D 0;
> =20
> -	if (bat->gpio_temp < 0 || bat->adc_temp < 0)
> +	if (!bat->gpio_temp.desc || bat->adc_temp < 0)
>  		return 0;
> =20
>  	mutex_lock(&bat_lock);
> -	gpio_set_value(bat->gpio_temp, 1);
> +	gpiod_set_value(bat->gpio_temp.desc, 1);
>  	msleep(5);
>  	value =3D wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
>  			bat->adc_temp);
> -	gpio_set_value(bat->gpio_temp, 0);
> +	gpiod_set_value(bat->gpio_temp.desc, 0);
>  	mutex_unlock(&bat_lock);
> =20
>  	value =3D value * 10000 / bat->adc_temp_divider;
> @@ -136,7 +145,7 @@ static int tosa_bat_get_property(struct power_supply =
*psy,
> =20
>  static bool tosa_jacket_bat_is_present(struct tosa_bat *bat)
>  {
> -	return gpio_get_value(TOSA_GPIO_JACKET_DETECT) =3D=3D 0;
> +	return gpiod_get_value(gpiod_jacket_det.desc) =3D=3D 0;
>  }
> =20
>  static void tosa_bat_external_power_changed(struct power_supply *psy)
> @@ -166,23 +175,23 @@ static void tosa_bat_update(struct tosa_bat *bat)
>  		bat->full_chrg =3D -1;
>  	} else if (power_supply_am_i_supplied(psy)) {
>  		if (bat->status =3D=3D POWER_SUPPLY_STATUS_DISCHARGING) {
> -			gpio_set_value(bat->gpio_charge_off, 0);
> +			gpiod_set_value(bat->gpio_charge_off.desc, 0);
>  			mdelay(15);
>  		}
> =20
> -		if (gpio_get_value(bat->gpio_full)) {
> +		if (gpiod_get_value(bat->gpio_full.desc)) {
>  			if (old =3D=3D POWER_SUPPLY_STATUS_CHARGING ||
>  					bat->full_chrg =3D=3D -1)
>  				bat->full_chrg =3D tosa_read_bat(bat);
> =20
> -			gpio_set_value(bat->gpio_charge_off, 1);
> +			gpiod_set_value(bat->gpio_charge_off.desc, 1);
>  			bat->status =3D POWER_SUPPLY_STATUS_FULL;
>  		} else {
> -			gpio_set_value(bat->gpio_charge_off, 0);
> +			gpiod_set_value(bat->gpio_charge_off.desc, 0);
>  			bat->status =3D POWER_SUPPLY_STATUS_CHARGING;
>  		}
>  	} else {
> -		gpio_set_value(bat->gpio_charge_off, 1);
> +		gpiod_set_value(bat->gpio_charge_off.desc, 1);
>  		bat->status =3D POWER_SUPPLY_STATUS_DISCHARGING;
>  	}
> =20
> @@ -251,18 +260,18 @@ static struct tosa_bat tosa_bat_main =3D {
>  	.full_chrg =3D -1,
>  	.psy =3D NULL,
> =20
> -	.gpio_full =3D TOSA_GPIO_BAT0_CRG,
> -	.gpio_charge_off =3D TOSA_GPIO_CHARGE_OFF,
> +	.gpio_full =3D { "main battery full", GPIOD_IN },
> +	.gpio_charge_off =3D { "main charge off" , GPIOD_OUT_HIGH },
> =20
>  	.technology =3D POWER_SUPPLY_TECHNOLOGY_LIPO,
> =20
> -	.gpio_bat =3D TOSA_GPIO_BAT0_V_ON,
> +	.gpio_bat =3D { "main battery", GPIOD_OUT_LOW },
>  	.adc_bat =3D WM97XX_AUX_ID3,
>  	.adc_bat_divider =3D 414,
>  	.bat_max =3D 4310000,
>  	.bat_min =3D 1551 * 1000000 / 414,
> =20
> -	.gpio_temp =3D TOSA_GPIO_BAT1_TH_ON,
> +	.gpio_temp =3D { "main battery temp", GPIOD_OUT_LOW },
>  	.adc_temp =3D WM97XX_AUX_ID2,
>  	.adc_temp_divider =3D 10000,
>  };
> @@ -273,18 +282,18 @@ static struct tosa_bat tosa_bat_jacket =3D {
>  	.psy =3D NULL,
> =20
>  	.is_present =3D tosa_jacket_bat_is_present,
> -	.gpio_full =3D TOSA_GPIO_BAT1_CRG,
> -	.gpio_charge_off =3D TOSA_GPIO_CHARGE_OFF_JC,
> +	.gpio_full =3D { "jacket battery full", GPIOD_IN },
> +	.gpio_charge_off =3D { "jacket charge off", GPIOD_OUT_HIGH },
> =20
>  	.technology =3D POWER_SUPPLY_TECHNOLOGY_LIPO,
> =20
> -	.gpio_bat =3D TOSA_GPIO_BAT1_V_ON,
> +	.gpio_bat =3D { "jacket battery", GPIOD_OUT_LOW },
>  	.adc_bat =3D WM97XX_AUX_ID3,
>  	.adc_bat_divider =3D 414,
>  	.bat_max =3D 4310000,
>  	.bat_min =3D 1551 * 1000000 / 414,
> =20
> -	.gpio_temp =3D TOSA_GPIO_BAT0_TH_ON,
> +	.gpio_temp =3D { "jacket battery temp", GPIOD_OUT_LOW },
>  	.adc_temp =3D WM97XX_AUX_ID2,
>  	.adc_temp_divider =3D 10000,
>  };
> @@ -294,36 +303,16 @@ static struct tosa_bat tosa_bat_bu =3D {
>  	.full_chrg =3D -1,
>  	.psy =3D NULL,
> =20
> -	.gpio_full =3D -1,
> -	.gpio_charge_off =3D -1,
> -
>  	.technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn,
> =20
> -	.gpio_bat =3D TOSA_GPIO_BU_CHRG_ON,
> +	.gpio_bat =3D { "backup battery", GPIOD_OUT_LOW },
>  	.adc_bat =3D WM97XX_AUX_ID4,
>  	.adc_bat_divider =3D 1266,
> =20
> -	.gpio_temp =3D -1,
>  	.adc_temp =3D -1,
>  	.adc_temp_divider =3D -1,
>  };
> =20
> -static struct gpio tosa_bat_gpios[] =3D {
> -	{ TOSA_GPIO_CHARGE_OFF,	   GPIOF_OUT_INIT_HIGH, "main charge off" },
> -	{ TOSA_GPIO_CHARGE_OFF_JC, GPIOF_OUT_INIT_HIGH, "jacket charge off" },
> -	{ TOSA_GPIO_BAT_SW_ON,	   GPIOF_OUT_INIT_LOW,	"battery switch" },
> -	{ TOSA_GPIO_BAT0_V_ON,	   GPIOF_OUT_INIT_LOW,	"main battery" },
> -	{ TOSA_GPIO_BAT1_V_ON,	   GPIOF_OUT_INIT_LOW,	"jacket battery" },
> -	{ TOSA_GPIO_BAT1_TH_ON,	   GPIOF_OUT_INIT_LOW,	"main battery temp" },
> -	{ TOSA_GPIO_BAT0_TH_ON,	   GPIOF_OUT_INIT_LOW,	"jacket battery temp" },
> -	{ TOSA_GPIO_BU_CHRG_ON,	   GPIOF_OUT_INIT_LOW,	"backup battery" },
> -	{ TOSA_GPIO_BAT0_CRG,	   GPIOF_IN,		"main battery full" },
> -	{ TOSA_GPIO_BAT1_CRG,	   GPIOF_IN,		"jacket battery full" },
> -	{ TOSA_GPIO_BAT0_LOW,	   GPIOF_IN,		"main battery low" },
> -	{ TOSA_GPIO_BAT1_LOW,	   GPIOF_IN,		"jacket battery low" },
> -	{ TOSA_GPIO_JACKET_DETECT, GPIOF_IN,		"jacket detect" },
> -};
> -
>  #ifdef CONFIG_PM
>  static int tosa_bat_suspend(struct platform_device *dev, pm_message_t st=
ate)
>  {
> @@ -343,6 +332,21 @@ static int tosa_bat_resume(struct platform_device *d=
ev)
>  #define tosa_bat_resume NULL
>  #endif
> =20
> +static int tosa_bat_gpio_get(struct device *dev, struct tosa_gpio *gpio)
> +{
> +	int ret;
> +
> +	if (!gpio->con)
> +		return 0;
> +
> +	gpio->desc =3D devm_gpiod_get(dev, gpio->con, gpio->flags);
> +	ret =3D PTR_ERR_OR_ZERO(gpio->desc);
> +	if (ret)
> +		dev_warn(dev, "failed to get gpio \"%s\"\n", gpio->con);
> +
> +	return ret;
> +}
> +
>  static int tosa_power_supply_register(struct device *dev,
>  			struct tosa_bat *bat,
>  			const struct power_supply_desc *desc)
> @@ -350,6 +354,23 @@ static int tosa_power_supply_register(struct device =
*dev,
>  	struct power_supply_config cfg =3D {
>  		.drv_data =3D bat,
>  	};
> +	int ret;
> +
> +	ret =3D tosa_bat_gpio_get(dev, &bat->gpio_full);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tosa_bat_gpio_get(dev, &bat->gpio_charge_off);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tosa_bat_gpio_get(dev, &bat->gpio_bat);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tosa_bat_gpio_get(dev, &bat->gpio_temp);
> +	if (ret)
> +		return ret;
> =20
>  	mutex_init(&bat->work_lock);
>  	bat->psy =3D power_supply_register(dev, desc, &cfg);
> @@ -358,49 +379,55 @@ static int tosa_power_supply_register(struct device=
 *dev,
>  }
> =20
> =20
> -static int tosa_bat_probe(struct platform_device *dev)
> +static int tosa_bat_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	int ret;
> =20
>  	if (!machine_is_tosa())
>  		return -ENODEV;
> =20
> -	ret =3D gpio_request_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
> +	ret =3D tosa_bat_gpio_get(dev, &gpiod_jacket_det);
>  	if (ret)
>  		return ret;
> =20
> +	/* these are not used anywhere, continue on failure */
> +	tosa_bat_gpio_get(dev, &gpiod_battery_switch);
> +	tosa_bat_gpio_get(dev, &gpiod_main_battery_low);
> +	tosa_bat_gpio_get(dev, &gpiod_jacket_battery_low);
> +
>  	INIT_WORK(&bat_work, tosa_bat_work);
> =20
> -	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_main,
> +	ret =3D tosa_power_supply_register(dev, &tosa_bat_main,
>  					 &tosa_bat_main_desc);
>  	if (ret)
>  		goto err_psy_reg_main;
> =20
> -	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_jacket,
> +	ret =3D tosa_power_supply_register(dev, &tosa_bat_jacket,
>  					 &tosa_bat_jacket_desc);
>  	if (ret)
>  		goto err_psy_reg_jacket;
> =20
> -	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_bu,
> +	ret =3D tosa_power_supply_register(dev, &tosa_bat_bu,
>  					 &tosa_bat_bu_desc);
>  	if (ret)
>  		goto err_psy_reg_bu;
> =20
> -	ret =3D request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
> +	ret =3D request_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc),
>  				tosa_bat_gpio_isr,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>  				"main full", &tosa_bat_main);
>  	if (ret)
>  		goto err_req_main;
> =20
> -	ret =3D request_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG),
> +	ret =3D request_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc),
>  				tosa_bat_gpio_isr,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>  				"jacket full", &tosa_bat_jacket);
>  	if (ret)
>  		goto err_req_jacket;
> =20
> -	ret =3D request_irq(gpio_to_irq(TOSA_GPIO_JACKET_DETECT),
> +	ret =3D request_irq(gpiod_to_irq(gpiod_jacket_det.desc),
>  				tosa_bat_gpio_isr,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>  				"jacket detect", &tosa_bat_jacket);
> @@ -409,9 +436,9 @@ static int tosa_bat_probe(struct platform_device *dev)
>  		return 0;
>  	}
> =20
> -	free_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG), &tosa_bat_jacket);
> +	free_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc), &tosa_bat_jacket=
);
>  err_req_jacket:
> -	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
> +	free_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc), &tosa_bat_main);
>  err_req_main:
>  	power_supply_unregister(tosa_bat_bu.psy);
>  err_psy_reg_bu:
> @@ -423,15 +450,14 @@ static int tosa_bat_probe(struct platform_device *d=
ev)
>  	/* see comment in tosa_bat_remove */
>  	cancel_work_sync(&bat_work);
> =20
> -	gpio_free_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
>  	return ret;
>  }
> =20
>  static int tosa_bat_remove(struct platform_device *dev)
>  {
> -	free_irq(gpio_to_irq(TOSA_GPIO_JACKET_DETECT), &tosa_bat_jacket);
> -	free_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG), &tosa_bat_jacket);
> -	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
> +	free_irq(gpiod_to_irq(gpiod_jacket_det.desc), &tosa_bat_jacket);
> +	free_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc), &tosa_bat_jacket=
);
> +	free_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc), &tosa_bat_main);
> =20
>  	power_supply_unregister(tosa_bat_bu.psy);
>  	power_supply_unregister(tosa_bat_jacket.psy);
> @@ -443,7 +469,6 @@ static int tosa_bat_remove(struct platform_device *de=
v)
>  	 * unregistered now.
>  	 */
>  	cancel_work_sync(&bat_work);
> -	gpio_free_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
>  	return 0;
>  }
> =20
> --=20
> 2.20.0
>=20

--5kovz5serylce4st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2q0tgACgkQ2O7X88g7
+praeQ/7B+DU7DiqYMtjOx4cjrtNjTA1KQrDWHVR8Uwf5CI9rIT2ThclCeadzhmr
MOSYr5wxnIhP8bYz6JxFVIpiPrFZsmyvTD0AtsOpTrNCxMdCwMKoa55Yn4aNQ2wO
2M7I9LImHG+Pb1NFGZmI4HMHaWtXxt3w+KK1jfoTvKPkxBsLIWyfcoKzsiUZakKO
9DBeph1f4huWMETJZiguR852GYAh1Iw07Sv29OgJJHHaeASuNz3zGo9RFw9x5RMe
deaROClfIVDrbFEmbA6Zee2IOsNgkATiXswWWVOTJC60JL5AL7t2pqktSz6lX+ZN
3IqABPOO8Shk9I0WLgV4G6jEr+Mgt3DxhXv6qsABSDJzunhnh5YJJjtVYrUUbps6
w/O5nUIOE+6yF4pUohaPWSNZLBCclsqbd4jASSFj8rPTvQKEB++KfN9gUu9el+fD
egHx8Sp6Do4dux4yhw3QmTspaRO7f3JJ5Xf/4Smqi6+zqXOt37eqPJ3xMdXLQrF1
ZxmahKiT6e0d1Rz/S4PcKEIlbQX0EhOn9H7rqhk9BEimQB4FbV7j0jTFoQeoAxd3
U3kij0Fa2Ag3BU6csxHbYfgzPUiNHeDGA03jW3e8n71sjjbY0JBkeOSg83syV67o
oIrc4Rrgpb+121MMT3dTrCXUjNv6Mruq4zAaz/VSI7l5fhaoVoI=
=m7WB
-----END PGP SIGNATURE-----

--5kovz5serylce4st--

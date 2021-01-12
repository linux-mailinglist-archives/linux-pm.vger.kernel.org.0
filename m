Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFD2F402D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbhALXRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 18:17:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbhALXRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 18:17:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B36951F45554
Received: by earth.universe (Postfix, from userid 1000)
        id 12B6D3C0C94; Wed, 13 Jan 2021 00:16:33 +0100 (CET)
Date:   Wed, 13 Jan 2021 00:16:33 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/2] power: supply: max8903: Convert to GPIO descriptors
Message-ID: <20210112231633.ljxpcl3ruhvd4mwk@earth.universe>
References: <20210110140200.127123-1-linus.walleij@linaro.org>
 <20210110140200.127123-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckbdjtxdc4inzlzq"
Content-Disposition: inline
In-Reply-To: <20210110140200.127123-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ckbdjtxdc4inzlzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 10, 2021 at 03:02:00PM +0100, Linus Walleij wrote:
> The MAX8903 uses up to 5 different GPIO lines to control and
> monitor charging.
>=20
> When converting to use GPIO descriptors instead of the old
> GPIO numbers the following side-refactorings were done:
>=20
> - Decomission the platform data container struct as all
>   GPIO descriptors are now "live" members of the driver
>   state container. The "dc_valid" and "usb_valid" just
>   indicate the presence of a DC or USB charger detection
>   line, and this can be handled by just checking if
>   the optional GPIO descriptor for each is !=3D NULL.
>=20
> - The gpiolib will now respect the GPIO_ACTIVE_LOW flag
>   for each of the lines, meaning gpiod_get_value() for example
>   will return 1 (asserted) if a line is flagged as
>   active low and is also physically low. The same applies
>   to output lines, vice versa mutatis mutandis. The code
>   has been augmented to account for this in all sites.
>=20
> - The terse parenthesis such as this:
>     gpio_set_value(pdata->cen, ta_in ? 0 :
>                      (data->usb_in ? 0 : 1));
>   have been expanded to more readable if / else if / else
>   statements that are easier for humans to read.
>=20
> - Comments were inserted to underscore polarity in each
>   case where it could be confusing to users of the old code.
>=20
> One thing is notable: the device tree bindings does not show
> an example of polarity assigned for the line "dcm-gpios"
> DC current monitor, is assumed to be flagged GPIO_ACTIVE_HIGH
> and driving it high (asserted) will achieve DC charger current
> limits and driving it low will achieve USB charger current
> limits. Device trees with this (optional) GPIO line defined
> should definately be flagged as GPIO_ACTIVE_HIGH.
>=20
> Cc: Chris Lapa <chris@lapa.com.au>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8903_charger.c | 388 +++++++++++--------------
>  1 file changed, 168 insertions(+), 220 deletions(-)
>=20
> diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/suppl=
y/max8903_charger.c
> index ab1aa7df985e..54d50b55fbae 100644
> --- a/drivers/power/supply/max8903_charger.c
> +++ b/drivers/power/supply/max8903_charger.c
> @@ -6,52 +6,32 @@
>   * MyungJoo Ham <myungjoo.ham@samsung.com>
>   */
> =20
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <linux/power_supply.h>
>  #include <linux/platform_device.h>
> =20
> -struct max8903_pdata {
> -	/*
> -	 * GPIOs
> -	 * cen, chg, flt, dcm and usus are optional.
> -	 * dok and uok are not optional depending on the status of
> -	 * dc_valid and usb_valid.
> -	 */
> -	int cen;	/* Charger Enable input */
> -	int dok;	/* DC(Adapter) Power OK output */
> -	int uok;	/* USB Power OK output */
> -	int chg;	/* Charger status output */
> -	int flt;	/* Fault output */
> -	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
> -	int usus;	/* USB Suspend Input (1: suspended) */
> -
> -	/*
> -	 * DC(Adapter/TA) is wired
> -	 * When dc_valid is true,
> -	 *	dok should be valid.
> -	 *
> -	 * At least one of dc_valid or usb_valid should be true.
> -	 */
> -	bool dc_valid;
> -	/*
> -	 * USB is wired
> -	 * When usb_valid is true,
> -	 *	uok should be valid.
> -	 */
> -	bool usb_valid;
> -};
> -
>  struct max8903_data {
> -	struct max8903_pdata *pdata;
>  	struct device *dev;
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
> +	/*
> +	 * GPIOs
> +	 * chg, flt, dcm and usus are optional.
> +	 * dok or uok must be present.
> +	 * If dok is present, cen must be present.
> +	 */
> +	struct gpio_desc *cen; /* Charger Enable input */
> +	struct gpio_desc *dok; /* DC (Adapter) Power OK output */
> +	struct gpio_desc *uok; /* USB Power OK output */
> +	struct gpio_desc *chg; /* Charger status output */
> +	struct gpio_desc *flt; /* Fault output */
> +	struct gpio_desc *dcm; /* Current-Limit Mode input (1: DC, 2: USB) */
> +	struct gpio_desc *usus; /* USB Suspend Input (1: suspended) */
>  	bool fault;
>  	bool usb_in;
>  	bool ta_in;
> @@ -72,8 +52,9 @@ static int max8903_get_property(struct power_supply *ps=
y,
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> -		if (gpio_is_valid(data->pdata->chg)) {
> -			if (gpio_get_value(data->pdata->chg) =3D=3D 0)
> +		if (data->chg) {
> +			if (gpiod_get_value(data->chg))
> +				/* CHG asserted */
>  				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  			else if (data->usb_in || data->ta_in)
>  				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> @@ -101,11 +82,17 @@ static int max8903_get_property(struct power_supply =
*psy,
>  static irqreturn_t max8903_dcin(int irq, void *_data)
>  {
>  	struct max8903_data *data =3D _data;
> -	struct max8903_pdata *pdata =3D data->pdata;
>  	bool ta_in;
>  	enum power_supply_type old_type;
> =20
> -	ta_in =3D gpio_get_value(pdata->dok) ? false : true;
> +	/*
> +	 * This means the line is asserted.
> +	 *
> +	 * The signal is active low, but the inversion is handled in the GPIO
> +	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
> +	 * tree.
> +	 */
> +	ta_in =3D gpiod_get_value(data->dok);
> =20
>  	if (ta_in =3D=3D data->ta_in)
>  		return IRQ_HANDLED;
> @@ -113,13 +100,25 @@ static irqreturn_t max8903_dcin(int irq, void *_dat=
a)
>  	data->ta_in =3D ta_in;
> =20
>  	/* Set Current-Limit-Mode 1:DC 0:USB */
> -	if (gpio_is_valid(pdata->dcm))
> -		gpio_set_value(pdata->dcm, ta_in ? 1 : 0);
> -
> -	/* Charger Enable / Disable (cen is negated) */
> -	if (gpio_is_valid(pdata->cen))
> -		gpio_set_value(pdata->cen, ta_in ? 0 :
> -				(data->usb_in ? 0 : 1));
> +	if (data->dcm)
> +		gpiod_set_value(data->dcm, ta_in);
> +
> +	/* Charger Enable / Disable */
> +	if (data->cen) {
> +		int val;
> +
> +		if (ta_in)
> +			/* Certainly enable if DOK is asserted */
> +			val =3D 1;
> +		else if (data->usb_in)
> +			/* Enable if the USB charger is enabled */
> +			val =3D 1;
> +		else
> +			/* Else default-disable */
> +			val =3D 0;
> +
> +		gpiod_set_value(data->cen, val);
> +	}
> =20
>  	dev_dbg(data->dev, "TA(DC-IN) Charger %s.\n", ta_in ?
>  			"Connected" : "Disconnected");
> @@ -142,11 +141,17 @@ static irqreturn_t max8903_dcin(int irq, void *_dat=
a)
>  static irqreturn_t max8903_usbin(int irq, void *_data)
>  {
>  	struct max8903_data *data =3D _data;
> -	struct max8903_pdata *pdata =3D data->pdata;
>  	bool usb_in;
>  	enum power_supply_type old_type;
> =20
> -	usb_in =3D gpio_get_value(pdata->uok) ? false : true;
> +	/*
> +	 * This means the line is asserted.
> +	 *
> +	 * The signal is active low, but the inversion is handled in the GPIO
> +	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
> +	 * tree.
> +	 */
> +	usb_in =3D gpiod_get_value(data->uok);
> =20
>  	if (usb_in =3D=3D data->usb_in)
>  		return IRQ_HANDLED;
> @@ -155,10 +160,22 @@ static irqreturn_t max8903_usbin(int irq, void *_da=
ta)
> =20
>  	/* Do not touch Current-Limit-Mode */
> =20
> -	/* Charger Enable / Disable (cen is negated) */
> -	if (gpio_is_valid(pdata->cen))
> -		gpio_set_value(pdata->cen, usb_in ? 0 :
> -				(data->ta_in ? 0 : 1));
> +	/* Charger Enable / Disable */
> +	if (data->cen) {
> +		int val;
> +
> +		if (usb_in)
> +			/* Certainly enable if UOK is asserted */
> +			val =3D 1;
> +		else if (data->ta_in)
> +			/* Enable if the DC charger is enabled */
> +			val =3D 1;
> +		else
> +			/* Else default-disable */
> +			val =3D 0;
> +
> +		gpiod_set_value(data->cen, val);
> +	}
> =20
>  	dev_dbg(data->dev, "USB Charger %s.\n", usb_in ?
>  			"Connected" : "Disconnected");
> @@ -181,10 +198,16 @@ static irqreturn_t max8903_usbin(int irq, void *_da=
ta)
>  static irqreturn_t max8903_fault(int irq, void *_data)
>  {
>  	struct max8903_data *data =3D _data;
> -	struct max8903_pdata *pdata =3D data->pdata;
>  	bool fault;
> =20
> -	fault =3D gpio_get_value(pdata->flt) ? false : true;
> +	/*
> +	 * This means the line is asserted.
> +	 *
> +	 * The signal is active low, but the inversion is handled in the GPIO
> +	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
> +	 * tree.
> +	 */
> +	fault =3D gpiod_get_value(data->flt);
> =20
>  	if (fault =3D=3D data->fault)
>  		return IRQ_HANDLED;
> @@ -199,159 +222,100 @@ static irqreturn_t max8903_fault(int irq, void *_=
data)
>  	return IRQ_HANDLED;
>  }
> =20
> -static struct max8903_pdata *max8903_parse_dt_data(struct device *dev)
> -{
> -	struct device_node *np =3D dev->of_node;
> -	struct max8903_pdata *pdata =3D NULL;
> -
> -	if (!np)
> -		return NULL;
> -
> -	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return NULL;
> -
> -	pdata->dc_valid =3D false;
> -	pdata->usb_valid =3D false;
> -
> -	pdata->cen =3D of_get_named_gpio(np, "cen-gpios", 0);
> -	if (!gpio_is_valid(pdata->cen))
> -		pdata->cen =3D -EINVAL;
> -
> -	pdata->chg =3D of_get_named_gpio(np, "chg-gpios", 0);
> -	if (!gpio_is_valid(pdata->chg))
> -		pdata->chg =3D -EINVAL;
> -
> -	pdata->flt =3D of_get_named_gpio(np, "flt-gpios", 0);
> -	if (!gpio_is_valid(pdata->flt))
> -		pdata->flt =3D -EINVAL;
> -
> -	pdata->usus =3D of_get_named_gpio(np, "usus-gpios", 0);
> -	if (!gpio_is_valid(pdata->usus))
> -		pdata->usus =3D -EINVAL;
> -
> -	pdata->dcm =3D of_get_named_gpio(np, "dcm-gpios", 0);
> -	if (!gpio_is_valid(pdata->dcm))
> -		pdata->dcm =3D -EINVAL;
> -
> -	pdata->dok =3D of_get_named_gpio(np, "dok-gpios", 0);
> -	if (!gpio_is_valid(pdata->dok))
> -		pdata->dok =3D -EINVAL;
> -	else
> -		pdata->dc_valid =3D true;
> -
> -	pdata->uok =3D of_get_named_gpio(np, "uok-gpios", 0);
> -	if (!gpio_is_valid(pdata->uok))
> -		pdata->uok =3D -EINVAL;
> -	else
> -		pdata->usb_valid =3D true;
> -
> -	return pdata;
> -}
> -
>  static int max8903_setup_gpios(struct platform_device *pdev)
>  {
>  	struct max8903_data *data =3D platform_get_drvdata(pdev);
>  	struct device *dev =3D &pdev->dev;
> -	struct max8903_pdata *pdata =3D pdev->dev.platform_data;
> -	int ret =3D 0;
> -	int gpio;
> -	int ta_in =3D 0;
> -	int usb_in =3D 0;
> -
> -	if (pdata->dc_valid) {
> -		if (gpio_is_valid(pdata->dok)) {
> -			ret =3D devm_gpio_request(dev, pdata->dok,
> -						data->psy_desc.name);
> -			if (ret) {
> -				dev_err(dev,
> -					"Failed GPIO request for dok: %d err %d\n",
> -					pdata->dok, ret);
> -				return ret;
> -			}
> -
> -			gpio =3D pdata->dok; /* PULL_UPed Interrupt */
> -			ta_in =3D gpio_get_value(gpio) ? 0 : 1;
> -		} else {
> -			dev_err(dev, "When DC is wired, DOK should be wired as well.\n");
> -			return -EINVAL;
> -		}
> +	bool ta_in =3D false;
> +	bool usb_in =3D false;
> +	enum gpiod_flags flags;
> +
> +	data->dok =3D devm_gpiod_get_optional(dev, "dok", GPIOD_IN);
> +	if (IS_ERR(data->dok))
> +		return dev_err_probe(dev, PTR_ERR(data->dok),
> +				     "failed to get DOK GPIO");
> +	if (data->dok) {
> +		gpiod_set_consumer_name(data->dok, data->psy_desc.name);
> +		/*
> +		 * The DC OK is pulled up to 1 and goes low when a charger
> +		 * is plugged in (active low) but in the device tree the
> +		 * line is marked as GPIO_ACTIVE_LOW so we get a 1 (asserted)
> +		 * here if the DC charger is plugged in.
> +		 */
> +		ta_in =3D gpiod_get_value(data->dok);
>  	}
> =20
> -	if (gpio_is_valid(pdata->dcm)) {
> -		ret =3D devm_gpio_request(dev, pdata->dcm, data->psy_desc.name);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed GPIO request for dcm: %d err %d\n",
> -				pdata->dcm, ret);
> -			return ret;
> -		}
> -
> -		gpio =3D pdata->dcm; /* Output */
> -		gpio_set_value(gpio, ta_in);
> +	data->uok =3D devm_gpiod_get_optional(dev, "uok", GPIOD_IN);
> +	if (IS_ERR(data->uok))
> +		return dev_err_probe(dev, PTR_ERR(data->uok),
> +				     "failed to get UOK GPIO");
> +	if (data->uok) {
> +		gpiod_set_consumer_name(data->uok, data->psy_desc.name);
> +		/*
> +		 * The USB OK is pulled up to 1 and goes low when a USB charger
> +		 * is plugged in (active low) but in the device tree the
> +		 * line is marked as GPIO_ACTIVE_LOW so we get a 1 (asserted)
> +		 * here if the USB charger is plugged in.
> +		 */
> +		usb_in =3D gpiod_get_value(data->uok);
>  	}
> =20
> -	if (pdata->usb_valid) {
> -		if (gpio_is_valid(pdata->uok)) {
> -			ret =3D devm_gpio_request(dev, pdata->uok,
> -						data->psy_desc.name);
> -			if (ret) {
> -				dev_err(dev,
> -					"Failed GPIO request for uok: %d err %d\n",
> -					pdata->uok, ret);
> -				return ret;
> -			}
> -
> -			gpio =3D pdata->uok;
> -			usb_in =3D gpio_get_value(gpio) ? 0 : 1;
> -		} else {
> -			dev_err(dev, "When USB is wired, UOK should be wired."
> -					"as well.\n");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (gpio_is_valid(pdata->cen)) {
> -		ret =3D devm_gpio_request(dev, pdata->cen, data->psy_desc.name);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed GPIO request for cen: %d err %d\n",
> -				pdata->cen, ret);
> -			return ret;
> -		}
> -
> -		gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
> -	}
> -
> -	if (gpio_is_valid(pdata->chg)) {
> -		ret =3D devm_gpio_request(dev, pdata->chg, data->psy_desc.name);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed GPIO request for chg: %d err %d\n",
> -				pdata->chg, ret);
> -			return ret;
> -		}
> +	/* Either DC OK or USB OK must be provided */
> +	if (!data->dok && !data->uok) {
> +		dev_err(dev, "no valid power source\n");
> +		return -EINVAL;
>  	}
> =20
> -	if (gpio_is_valid(pdata->flt)) {
> -		ret =3D devm_gpio_request(dev, pdata->flt, data->psy_desc.name);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed GPIO request for flt: %d err %d\n",
> -				pdata->flt, ret);
> -			return ret;
> -		}
> -	}
> +	/*
> +	 * If either charger is already connected at this point,
> +	 * assert the CEN line and enable charging from the start.
> +	 *
> +	 * The line is active low but also marked with GPIO_ACTIVE_LOW
> +	 * in the device tree, so when we assert the line with
> +	 * GPIOD_OUT_HIGH the line will be driven low.
> +	 */
> +	flags =3D (ta_in || usb_in) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	/*
> +	 * If DC OK is provided, Charger Enable CEN is compulsory
> +	 * so this is not optional here.
> +	 */
> +	data->cen =3D devm_gpiod_get(dev, "cen", flags);
> +	if (IS_ERR(data->cen))
> +		return dev_err_probe(dev, PTR_ERR(data->cen),
> +				     "failed to get CEN GPIO");
> +	gpiod_set_consumer_name(data->cen, data->psy_desc.name);
> =20
> -	if (gpio_is_valid(pdata->usus)) {
> -		ret =3D devm_gpio_request(dev, pdata->usus, data->psy_desc.name);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed GPIO request for usus: %d err %d\n",
> -				pdata->usus, ret);
> -			return ret;
> -		}
> -	}
> +	/*
> +	 * If the DC charger is connected, then select it.
> +	 *
> +	 * The DCM line should be marked GPIO_ACTIVE_HIGH in the
> +	 * device tree. Driving it high will enable the DC charger
> +	 * input over the USB charger input.
> +	 */
> +	flags =3D ta_in ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	data->dcm =3D devm_gpiod_get_optional(dev, "dcm", flags);
> +	if (IS_ERR(data->dcm))
> +		return dev_err_probe(dev, PTR_ERR(data->dcm),
> +				     "failed to get DCM GPIO");
> +	gpiod_set_consumer_name(data->dcm, data->psy_desc.name);
> +
> +	data->chg =3D devm_gpiod_get_optional(dev, "chg", GPIOD_IN);
> +	if (IS_ERR(data->chg))
> +		return dev_err_probe(dev, PTR_ERR(data->chg),
> +				     "failed to get CHG GPIO");
> +	gpiod_set_consumer_name(data->chg, data->psy_desc.name);
> +
> +	data->flt =3D devm_gpiod_get_optional(dev, "flt", GPIOD_IN);
> +	if (IS_ERR(data->flt))
> +		return dev_err_probe(dev, PTR_ERR(data->flt),
> +				     "failed to get FLT GPIO");
> +	gpiod_set_consumer_name(data->flt, data->psy_desc.name);
> +
> +	data->usus =3D devm_gpiod_get_optional(dev, "usus", GPIOD_IN);
> +	if (IS_ERR(data->usus))
> +		return dev_err_probe(dev, PTR_ERR(data->usus),
> +				     "failed to get USUS GPIO");
> +	gpiod_set_consumer_name(data->usus, data->psy_desc.name);
> =20
>  	data->fault =3D false;
>  	data->ta_in =3D ta_in;
> @@ -364,7 +328,6 @@ static int max8903_probe(struct platform_device *pdev)
>  {
>  	struct max8903_data *data;
>  	struct device *dev =3D &pdev->dev;
> -	struct max8903_pdata *pdata =3D pdev->dev.platform_data;
>  	struct power_supply_config psy_cfg =3D {};
>  	int ret =3D 0;
> =20
> @@ -372,24 +335,9 @@ static int max8903_probe(struct platform_device *pde=
v)
>  	if (!data)
>  		return -ENOMEM;
> =20
> -	if (IS_ENABLED(CONFIG_OF) && !pdata && dev->of_node)
> -		pdata =3D max8903_parse_dt_data(dev);
> -
> -	if (!pdata) {
> -		dev_err(dev, "No platform data.\n");
> -		return -EINVAL;
> -	}
> -
> -	pdev->dev.platform_data =3D pdata;
> -	data->pdata =3D pdata;
>  	data->dev =3D dev;
>  	platform_set_drvdata(pdev, data);
> =20
> -	if (pdata->dc_valid =3D=3D false && pdata->usb_valid =3D=3D false) {
> -		dev_err(dev, "No valid power sources.\n");
> -		return -EINVAL;
> -	}
> -
>  	ret =3D max8903_setup_gpios(pdev);
>  	if (ret)
>  		return ret;
> @@ -411,41 +359,41 @@ static int max8903_probe(struct platform_device *pd=
ev)
>  		return PTR_ERR(data->psy);
>  	}
> =20
> -	if (pdata->dc_valid) {
> -		ret =3D devm_request_threaded_irq(dev, gpio_to_irq(pdata->dok),
> +	if (data->dok) {
> +		ret =3D devm_request_threaded_irq(dev, gpiod_to_irq(data->dok),
>  					NULL, max8903_dcin,
>  					IRQF_TRIGGER_FALLING |
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"MAX8903 DC IN", data);
>  		if (ret) {
>  			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
> -					gpio_to_irq(pdata->dok), ret);
> +					gpiod_to_irq(data->dok), ret);
>  			return ret;
>  		}
>  	}
> =20
> -	if (pdata->usb_valid) {
> -		ret =3D devm_request_threaded_irq(dev, gpio_to_irq(pdata->uok),
> +	if (data->uok) {
> +		ret =3D devm_request_threaded_irq(dev, gpiod_to_irq(data->uok),
>  					NULL, max8903_usbin,
>  					IRQF_TRIGGER_FALLING |
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"MAX8903 USB IN", data);
>  		if (ret) {
>  			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
> -					gpio_to_irq(pdata->uok), ret);
> +					gpiod_to_irq(data->uok), ret);
>  			return ret;
>  		}
>  	}
> =20
> -	if (gpio_is_valid(pdata->flt)) {
> -		ret =3D devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
> +	if (data->flt) {
> +		ret =3D devm_request_threaded_irq(dev, gpiod_to_irq(data->flt),
>  					NULL, max8903_fault,
>  					IRQF_TRIGGER_FALLING |
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"MAX8903 Fault", data);
>  		if (ret) {
>  			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
> -					gpio_to_irq(pdata->flt), ret);
> +					gpiod_to_irq(data->flt), ret);
>  			return ret;
>  		}
>  	}
> --=20
> 2.29.2
>=20

--ckbdjtxdc4inzlzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+LdAACgkQ2O7X88g7
+ppnLhAAk6ilc7ss5zLLR2FAVH0x5LsneoUHEAu4jutxhs2Kw89ZKsd22oB+nrg7
TDDxpzu66NVPU/uEbt9pvdnlmdfJTjt9kU4ZX88e/EhW69y9X3stR40X4ATXkR+d
rdWTpB7JXJvVICZ1A3aOhfz+9JuL0kAEL79DVRI/3rY/vTsmJsCu6UwsrunYy1Fl
kBQmuBFRn8SFl+YORk32ICo4oIIGVCJIWN7fzmNYp6GxnfMvY0oMa4sqj/svCHQQ
C1fqQHFAkh5jLWzlAaTlViJ3tUf9Nh14bMN+L8fG2im6Ra7Ucsn6DzJbzfnCO6zf
jW31AiELXR8QrxB8zpo0c6alfy2bhpz9NXWqDaIzBJftqwpXSDsOUHbrB2YWA9Rd
8uEBPRLtijgZL4szVM47DiGBbSJfpTL3kto+Jf958PyWmxjjM/4rXTAKEeJW+oaV
qARhrvLANDQLuTAql5/0hoo+mFsARBPYiSChRsdY5PjvDrcn/N+OppoWkbEgfW9U
ODaljyhswO3pE/TJ2Tg5TDCsUHO2ybTwBMWceNjBNyQB+WMtXd49LKOpOLy1cmQZ
smO8fU+zPbWf0upkRg3J7CaCDDil0b1vlpmWNID0j6otjjTicO+DotiNIrAV6Mce
7DQQ2H3kzEUVj0W5SL6JmQaMLa8UNX93aAn+XytQUbBwEkQ20HI=
=PgbQ
-----END PGP SIGNATURE-----

--ckbdjtxdc4inzlzq--

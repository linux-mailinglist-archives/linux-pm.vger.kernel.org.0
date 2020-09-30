Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9127F648
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 01:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3XtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 19:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbgI3XtN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 19:49:13 -0400
Received: from earth.universe (dyndsl-091-096-063-136.ewe-ip-backbone.de [91.96.63.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D8B20BED;
        Wed, 30 Sep 2020 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601509752;
        bh=Sr5++ORuHqCBTPDc3AP7gUplpbOFGCbkmNvvXKs9KjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWAH3xLvqIwIIkm7wvL66DwS3g+fokXhBPyCLsuhC9HByd1ZhzVNxIo2g/PNpVnEx
         xPeLVNwbKGPhnay/s9PXUNg9JzTVeK8JgYHPhkx88GNY9atQWsOXLT0oRUF7YJsOyL
         ulYA4p3yQsQ18niS4WAwrcMsRk2NNFcAoLWmoVYY=
Received: by earth.universe (Postfix, from userid 1000)
        id 6E5F73C0C84; Thu,  1 Oct 2020 01:49:10 +0200 (CEST)
Date:   Thu, 1 Oct 2020 01:49:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de,
        Kevin Benson <kevin_simona@hotmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] power: supply: ucs1002: fix some health status issues
Message-ID: <20200930234910.3clu5vc55ibytcok@earth.universe>
References: <20200930084047.2927163-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkbygxtzh4ibwh4i"
Content-Disposition: inline
In-Reply-To: <20200930084047.2927163-1-l.stach@pengutronix.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zkbygxtzh4ibwh4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 30, 2020 at 10:40:47AM +0200, Lucas Stach wrote:
> Some fault events like the over-current condition will get resolved
> by the hardware, by e.g. disabling the port. As the status in the
> interrupt status register is cleared on read when the fault is resolved,
> the sysfs health property will only contain the correct health status
> for the first time it is read after such an event, even if the actual
> fault condition (like a VBUS short) still persists. To reflect this
> properly in the property we cache the last health status and only update
> the cache when a actual change happens, i.e. the ERR bit in the status
> register flips, as this one properly reflects a continued fault condition.
>=20
> The ALERT pin however, is not driven by the ERR status, but by the actual
> fault status, so the pin will change back to it's default state when the
> hardware has automatically resolved the fault by cutting the power. Thus
> we never get an IRQ when the actual fault condition has been resolved and
> the ERR status bit has been cleared in auto-recovery mode. To get this
> information we need to poll the interrupt status register after some time
> to see if the fault is gone and update our cache in that case.
>=20
> To avoid any additional locking, we handle both paths (IRQ firing and
> delayed polling) through the same single-threaded delayed work.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ucs1002_power.c | 75 ++++++++++++++++------------
>  1 file changed, 43 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/=
ucs1002_power.c
> index cdb9a23d825f..ef673ec3db56 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -38,6 +38,7 @@
> =20
>  /* Interrupt Status */
>  #define UCS1002_REG_INTERRUPT_STATUS	0x10
> +#  define F_ERR				BIT(7)
>  #  define F_DISCHARGE_ERR		BIT(6)
>  #  define F_RESET			BIT(5)
>  #  define F_MIN_KEEP_OUT		BIT(4)
> @@ -103,6 +104,9 @@ struct ucs1002_info {
>  	struct regulator_dev *rdev;
>  	bool present;
>  	bool output_disable;
> +	struct delayed_work health_poll;
> +	int health;
> +
>  };
> =20
>  static enum power_supply_property ucs1002_props[] =3D {
> @@ -362,32 +366,6 @@ static int ucs1002_get_usb_type(struct ucs1002_info =
*info,
>  	return 0;
>  }
> =20
> -static int ucs1002_get_health(struct ucs1002_info *info,
> -			      union power_supply_propval *val)
> -{
> -	unsigned int reg;
> -	int ret, health;
> -
> -	ret =3D regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS, &reg);
> -	if (ret)
> -		return ret;
> -
> -	if (reg & F_TSD)
> -		health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> -	else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
> -		health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> -	else if (reg & F_OVER_ILIM)
> -		health =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
> -	else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
> -		health =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> -	else
> -		health =3D POWER_SUPPLY_HEALTH_GOOD;
> -
> -	val->intval =3D health;
> -
> -	return 0;
> -}
> -
>  static int ucs1002_get_property(struct power_supply *psy,
>  				enum power_supply_property psp,
>  				union power_supply_propval *val)
> @@ -406,7 +384,7 @@ static int ucs1002_get_property(struct power_supply *=
psy,
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		return ucs1002_get_usb_type(info, val);
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		return ucs1002_get_health(info, val);
> +		return val->intval =3D info->health;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval =3D info->present;
>  		return 0;
> @@ -458,6 +436,38 @@ static const struct power_supply_desc ucs1002_charge=
r_desc =3D {
>  	.num_properties		=3D ARRAY_SIZE(ucs1002_props),
>  };
> =20
> +static void ucs1002_health_poll(struct work_struct *work)
> +{
> +	struct ucs1002_info *info =3D container_of(work, struct ucs1002_info,
> +						 health_poll.work);
> +	int ret;
> +	u32 reg;
> +
> +	ret =3D regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS, &reg);
> +	if (ret)
> +		return;
> +
> +	/* bad health and no status change, just schedule us again in a while */
> +	if ((reg & F_ERR) && info->health !=3D POWER_SUPPLY_HEALTH_GOOD) {
> +		schedule_delayed_work(&info->health_poll,
> +				      msecs_to_jiffies(2000));
> +		return;
> +	}
> +
> +	if (reg & F_TSD)
> +		info->health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +	else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
> +		info->health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	else if (reg & F_OVER_ILIM)
> +		info->health =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
> +	else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
> +		info->health =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +	else
> +		info->health =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +	sysfs_notify(&info->charger->dev.kobj, NULL, "health");
> +}
> +
>  static irqreturn_t ucs1002_charger_irq(int irq, void *data)
>  {
>  	int ret, regval;
> @@ -484,7 +494,7 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *d=
ata)
>  {
>  	struct ucs1002_info *info =3D data;
> =20
> -	power_supply_changed(info->charger);
> +	mod_delayed_work(system_wq, &info->health_poll, 0);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -632,6 +642,9 @@ static int ucs1002_probe(struct i2c_client *client,
>  		return ret;
>  	}
> =20
> +	info->health =3D POWER_SUPPLY_HEALTH_GOOD;
> +	INIT_DELAYED_WORK(&info->health_poll, ucs1002_health_poll);
> +
>  	if (irq_a_det > 0) {
>  		ret =3D devm_request_threaded_irq(dev, irq_a_det, NULL,
>  						ucs1002_charger_irq,
> @@ -645,10 +658,8 @@ static int ucs1002_probe(struct i2c_client *client,
>  	}
> =20
>  	if (irq_alert > 0) {
> -		ret =3D devm_request_threaded_irq(dev, irq_alert, NULL,
> -						ucs1002_alert_irq,
> -						IRQF_ONESHOT,
> -						"ucs1002-alert", info);
> +		ret =3D devm_request_irq(dev, irq_alert, ucs1002_alert_irq,
> +				       0,"ucs1002-alert", info);
>  		if (ret) {
>  			dev_err(dev, "Failed to request ALERT threaded irq: %d\n",
>  				ret);
> --=20
> 2.20.1
>=20

--zkbygxtzh4ibwh4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl91GXYACgkQ2O7X88g7
+prluQ/9FxUYcqnjUn1vGKvh5fbi7nuvQUpfaWuVhPRCH6ztioKoANS1fya0tXTM
Vigy9ImLL14HoffU6y3aJ1i05IRlCOE7/G/iIdnVNIYxXFRV02vO+IOVb+oEoat1
d91RKB3yBTrVSbtDDGEntwTRBOT/ePpeCEcVHyiRFKd4fP1fHBND0meaRcF3wHIb
owXrgMawNGrKmnH/FfTTGtO1jFK6CpMScLuSJavUKTaquGVwd8jCh/Dz6n4qa/BI
Qn5DjDVwbpvXT5EHSbXORrtTvyxEDfHvjq0Jdil9pNvgyb4+uYWJHUReuqDGNRbZ
bA/SxOm9RoePGaf3fOqn/RzwQowQtSFFeq5/jl2bFl68kAbMYgNbebVSjibIZclz
7dAj+tR1zrg3B6TiDjq4MROLunQU9AEXeRTb1VwwNhJtBU3kb/pDfw1/c7jW81di
BFWNNlmTqVXU5gzppHNC6ob92lzerRlZW/dYrAr2EouQQJQg17YWrePjEbrjrw12
2jhOBG9JSBnyIxqAEMVt/bDcDQFVARM+YrlLNcGA0t5hvJLCZm8oLHkBLgWLSp3V
mMOaSQlLyil9FE28uHQ1iM07pl11oK4K+RNuOTNVYLbXZooHEIHFbmU1rQGaL2+2
V/L9NiNaHn2r6bO3u5YK5ke1sxNQGFyS4N7PXHEl8pZugwqfpss=
=C9nr
-----END PGP SIGNATURE-----

--zkbygxtzh4ibwh4i--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655F255FFD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1Rrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1Rrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 13:47:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D89C061264;
        Fri, 28 Aug 2020 10:47:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2C2CB29AF41
Received: by earth.universe (Postfix, from userid 1000)
        id C48DE3C0C82; Fri, 28 Aug 2020 19:47:40 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:47:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jack Mitchell <ml@embed.me.uk>
Cc:     linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH] drivers: power: axp20x-battery: support setting
 charge_full_design
Message-ID: <20200828174740.iimgpn7lzjr3cm3f@earth.universe>
References: <20200729104913.627242-1-ml@embed.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6auyag4duaqdgbyd"
Content-Disposition: inline
In-Reply-To: <20200729104913.627242-1-ml@embed.me.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6auyag4duaqdgbyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 11:49:13AM +0100, Jack Mitchell wrote:
> Signed-off-by: Jack Mitchell <ml@embed.me.uk>
> ---

^ missing long description

Also the patch does not apply and needs to be rebased.

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 39 +++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index fe96f77bffa7..8ce4ebe7ccd5 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -60,6 +60,7 @@
> =20
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> =20
> +#define AXP20X_BAT_MAX_CAP_VALID	BIT(7)
> =20
>  struct axp20x_batt_ps;
> =20
> @@ -86,6 +87,7 @@ struct axp20x_batt_ps {
>  	struct axp20x_thermal_sensor sensor;
>  	/* Maximum constant charge current */
>  	unsigned int max_ccc;
> +	unsigned int charge_full_design;
>  	const struct axp_data	*data;
>  };
> =20
> @@ -260,6 +262,10 @@ static int axp20x_battery_get_prop(struct power_supp=
ly *psy,
>  		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D axp20x_batt->charge_full_design;
> +		break;
> +

So it reports 0 instead of the hardware information before
setting it once when no setup happens through DT?

-- Sebastian

>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		ret =3D axp20x_get_constant_charge_current(axp20x_batt,
>  							 &val->intval);
> @@ -401,6 +407,30 @@ static int axp20x_battery_set_max_voltage(struct axp=
20x_batt_ps *axp20x_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>  }
> =20
> +static int axp20x_set_charge_full_design(struct axp20x_batt_ps *axp_batt,
> +					      int charge_full_uah)
> +{
> +	/* (Unit: 1.456mAh) */
> +	int max_capacity_units =3D charge_full_uah / 1456;
> +	int ret;
> +
> +	u8 max_capacity_msb =3D (max_capacity_units & 0x7F00) >> 8;
> +	u8 max_capacity_lsb =3D (max_capacity_units & 0xFF);
> +
> +	axp_batt->charge_full_design =3D max_capacity_units * 1456;
> +
> +	max_capacity_msb |=3D AXP20X_BAT_MAX_CAP_VALID;
> +
> +	ret =3D regmap_write(axp_batt->regmap, AXP288_FG_DES_CAP0_REG,
> +			   max_capacity_lsb);
> +
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(axp_batt->regmap, AXP288_FG_DES_CAP1_REG,
> +			    max_capacity_msb);
> +}
> +
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp=
_batt,
>  					      int charge_current)
>  {
> @@ -492,6 +522,7 @@ static enum power_supply_property axp20x_battery_prop=
s[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_HEALTH,
> @@ -675,6 +706,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
>  		int vmin =3D info.voltage_min_design_uv;
>  		int ccc =3D info.constant_charge_current_max_ua;
> +		int cfd =3D info.charge_full_design_uah;
> =20
>  		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>  							      vmin))
> @@ -692,6 +724,13 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
>  			axp20x_batt->max_ccc =3D ccc;
>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>  		}
> +
> +		if (cfd > 0 && axp20x_set_charge_full_design(axp20x_batt,
> +							       cfd)) {
> +			dev_err(&pdev->dev,
> +				"couldn't set charge_full_design\n");
> +			axp20x_batt->charge_full_design =3D 0;
> +		}
>  	}
> =20
>  	error =3D axp20x_thermal_register_sensor(pdev, axp20x_batt);
> --=20
> 2.28.0
>=20

--6auyag4duaqdgbyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9JQzwACgkQ2O7X88g7
+prXTA//Qa9UDgZshqfY+c4VrYiZSbcx7tDahRBRWF1trTeXBtgfozIhlWCX1UPo
RnLURYl+n0fTykBdjW42panoCxUWo8+45wyAigmR+mnSDN+pzJgPQsb1GKHipuLN
gm3pVVEH+346GeJrDJbcAMrB50WEf0KQqQWmweG3lA77l3VcOtCYMJLiMyw5W94A
23PYpvVZRBSsN6lje6e9XYt/DLeESXorecz3TI8lbUHTMaepXFX7aaWUZR9ey99t
1075Drpnh/r3eo4tZwwiXhFyh6Yk69mrU62q8O7ePtHzOWJtLVJYO/mt2/yKSAyN
xjae8qEYUZGfIkf0t8gfwXewRo42yeBkoKAoeWrdHlUIlC5yplPEea2lkfDD73Ig
DBWBdmoAj1AJGhgdXJo6FYqINoTd6heptTrtu0ednwVhS2cqEFTLUi9u3Jois2fL
iz/D79tRaeHTovH/f8RVYjJLZ3tKB864C2N08i1NArDy7H0ocapLwvoWrEEvx/sT
TieBT8qTFes1R7y4QHd3Ni/ZesUIfsf8S7SVraRlvuqpZcyax7GsAfe1nVmmpKtO
lnpY4YcvLAz7RWasZx7eC/GOXynr0D3k69FaUwtYDyfAWHCM87g7GrjDIt4KEVhk
NucqgO89JEx+rNYEQYS7ILFZ5e5frBSlxWZ6vFZxLXQJaM1OfpU=
=Upaq
-----END PGP SIGNATURE-----

--6auyag4duaqdgbyd--

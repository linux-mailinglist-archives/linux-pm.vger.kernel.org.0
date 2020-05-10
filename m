Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3B1CCC46
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEJQkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:40:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgEJQkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:40:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F204D2699CB
Received: by earth.universe (Postfix, from userid 1000)
        id B0E6C3C08C7; Sun, 10 May 2020 18:40:42 +0200 (CEST)
Date:   Sun, 10 May 2020 18:40:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] power: supply: smb347-charger: Support SMB345 and
 SMB358
Message-ID: <20200510164042.y7xm2ezg7qpwsihu@earth.universe>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329162128.218584-7-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sa24v6gpbuf57hdl"
Content-Disposition: inline
In-Reply-To: <20200329162128.218584-7-david@ixit.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sa24v6gpbuf57hdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 29, 2020 at 06:21:25PM +0200, David Heidelberg wrote:
> Tested SMB345 on Nexus 7 2013. Works.
>=20
> Based on:
> - https://patchwork.kernel.org/patch/4922431/
> - https://patchwork.ozlabs.org/patch/666877/
>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

LGTM.

-- Sebastian

>  drivers/power/supply/Kconfig          |   6 +-
>  drivers/power/supply/smb347-charger.c | 109 ++++++++++++++------------
>  2 files changed, 62 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f3424fdce341..2581ed8aff5a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -598,12 +598,12 @@ config CHARGER_BQ25890
>  	  Say Y to enable support for the TI BQ25890 battery charger.
> =20
>  config CHARGER_SMB347
> -	tristate "Summit Microelectronics SMB347 Battery Charger"
> +	tristate "Summit Microelectronics SMB3XX Battery Charger"
>  	depends on I2C
>  	select REGMAP_I2C
>  	help
> -	  Say Y to include support for Summit Microelectronics SMB347
> -	  Battery Charger.
> +	  Say Y to include support for Summit Microelectronics SMB345,
> +	  SMB347 or SMB358 Battery Charger.
> =20
>  config CHARGER_TPS65090
>  	tristate "TPS65090 battery charger driver"
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index 852d2ab566e0..0cbd0743fd91 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -128,6 +128,7 @@
>   * @mains: power_supply instance for AC/DC power
>   * @usb: power_supply instance for USB power
>   * @battery: power_supply instance for battery
> + * @id: SMB charger ID
>   * @mains_online: is AC/DC input connected
>   * @usb_online: is USB input connected
>   * @charging_enabled: is charging enabled
> @@ -140,64 +141,61 @@ struct smb347_charger {
>  	struct power_supply	*mains;
>  	struct power_supply	*usb;
>  	struct power_supply	*battery;
> +	unsigned int		id;
>  	bool			mains_online;
>  	bool			usb_online;
>  	bool			charging_enabled;
>  	const struct smb347_charger_platform_data *pdata;
>  };
> =20
> -/* Fast charge current in uA */
> -static const unsigned int fcc_tbl[] =3D {
> -	700000,
> -	900000,
> -	1200000,
> -	1500000,
> -	1800000,
> -	2000000,
> -	2200000,
> -	2500000,
> +enum smb_charger_chipid {
> +	SMB345,
> +	SMB347,
> +	SMB358,
> +	NUM_CHIP_TYPES,
>  };
> =20
> +/* Fast charge current in uA */
> +static const unsigned int fcc_tbl[NUM_CHIP_TYPES][8] =3D {
> +	[SMB345] =3D {  200000,  450000,  600000,  900000,
> +		     1300000, 1500000, 1800000, 2000000 },
> +	[SMB347] =3D {  700000,  900000, 1200000, 1500000,
> +		     1800000, 2000000, 2200000, 2500000 },
> +	[SMB358] =3D {  200000,  450000,  600000,  900000,
> +		     1300000, 1500000, 1800000, 2000000 },
> +};
>  /* Pre-charge current in uA */
> -static const unsigned int pcc_tbl[] =3D {
> -	100000,
> -	150000,
> -	200000,
> -	250000,
> +static const unsigned int pcc_tbl[NUM_CHIP_TYPES][4] =3D {
> +	[SMB345] =3D { 150000, 250000, 350000, 450000 },
> +	[SMB347] =3D { 100000, 150000, 200000, 250000 },
> +	[SMB358] =3D { 150000, 250000, 350000, 450000 },
>  };
> =20
>  /* Termination current in uA */
> -static const unsigned int tc_tbl[] =3D {
> -	37500,
> -	50000,
> -	100000,
> -	150000,
> -	200000,
> -	250000,
> -	500000,
> -	600000,
> +static const unsigned int tc_tbl[NUM_CHIP_TYPES][8] =3D {
> +	[SMB345] =3D {  30000,  40000,  60000,  80000,
> +		     100000, 125000, 150000, 200000 },
> +	[SMB347] =3D {  37500,  50000, 100000, 150000,
> +		     200000, 250000, 500000, 600000 },
> +	[SMB358] =3D {  30000,  40000,  60000,  80000,
> +		     100000, 125000, 150000, 200000 },
>  };
> =20
>  /* Input current limit in uA */
> -static const unsigned int icl_tbl[] =3D {
> -	300000,
> -	500000,
> -	700000,
> -	900000,
> -	1200000,
> -	1500000,
> -	1800000,
> -	2000000,
> -	2200000,
> -	2500000,
> +static const unsigned int icl_tbl[NUM_CHIP_TYPES][10] =3D {
> +	[SMB345] =3D {  300000,  500000,  700000, 1000000, 1500000,
> +		     1800000, 2000000, 2000000, 2000000, 2000000 },
> +	[SMB347] =3D {  300000,  500000,  700000,  900000, 1200000,
> +		     1500000, 1800000, 2000000, 2200000, 2500000 },
> +	[SMB358] =3D {  300000,  500000,  700000, 1000000, 1500000,
> +		     1800000, 2000000, 2000000, 2000000, 2000000 },
>  };
> =20
>  /* Charge current compensation in uA */
> -static const unsigned int ccc_tbl[] =3D {
> -	250000,
> -	700000,
> -	900000,
> -	1200000,
> +static const unsigned int ccc_tbl[NUM_CHIP_TYPES][4] =3D {
> +	[SMB345] =3D {  200000,  450000,  600000,  900000 },
> +	[SMB347] =3D {  250000,  700000,  900000, 1200000 },
> +	[SMB358] =3D {  200000,  450000,  600000,  900000 },
>  };
> =20
>  /* Convert register value to current using lookup table */
> @@ -352,10 +350,11 @@ static int smb347_start_stop_charging(struct smb347=
_charger *smb)
> =20
>  static int smb347_set_charge_current(struct smb347_charger *smb)
>  {
> +	unsigned int id =3D smb->id;
>  	int ret;
> =20
>  	if (smb->pdata->max_charge_current) {
> -		ret =3D current_to_hw(fcc_tbl, ARRAY_SIZE(fcc_tbl),
> +		ret =3D current_to_hw(fcc_tbl[id], ARRAY_SIZE(fcc_tbl[id]),
>  				    smb->pdata->max_charge_current);
>  		if (ret < 0)
>  			return ret;
> @@ -368,7 +367,7 @@ static int smb347_set_charge_current(struct smb347_ch=
arger *smb)
>  	}
> =20
>  	if (smb->pdata->pre_charge_current) {
> -		ret =3D current_to_hw(pcc_tbl, ARRAY_SIZE(pcc_tbl),
> +		ret =3D current_to_hw(pcc_tbl[id], ARRAY_SIZE(pcc_tbl[id]),
>  				    smb->pdata->pre_charge_current);
>  		if (ret < 0)
>  			return ret;
> @@ -381,7 +380,7 @@ static int smb347_set_charge_current(struct smb347_ch=
arger *smb)
>  	}
> =20
>  	if (smb->pdata->termination_current) {
> -		ret =3D current_to_hw(tc_tbl, ARRAY_SIZE(tc_tbl),
> +		ret =3D current_to_hw(tc_tbl[id], ARRAY_SIZE(tc_tbl[id]),
>  				    smb->pdata->termination_current);
>  		if (ret < 0)
>  			return ret;
> @@ -397,10 +396,11 @@ static int smb347_set_charge_current(struct smb347_=
charger *smb)
> =20
>  static int smb347_set_current_limits(struct smb347_charger *smb)
>  {
> +	unsigned int id =3D smb->id;
>  	int ret;
> =20
>  	if (smb->pdata->mains_current_limit) {
> -		ret =3D current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
> +		ret =3D current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
>  				    smb->pdata->mains_current_limit);
>  		if (ret < 0)
>  			return ret;
> @@ -413,7 +413,7 @@ static int smb347_set_current_limits(struct smb347_ch=
arger *smb)
>  	}
> =20
>  	if (smb->pdata->usb_hc_current_limit) {
> -		ret =3D current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
> +		ret =3D current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
>  				    smb->pdata->usb_hc_current_limit);
>  		if (ret < 0)
>  			return ret;
> @@ -463,6 +463,7 @@ static int smb347_set_voltage_limits(struct smb347_ch=
arger *smb)
> =20
>  static int smb347_set_temp_limits(struct smb347_charger *smb)
>  {
> +	unsigned int id =3D smb->id;
>  	bool enable_therm_monitor =3D false;
>  	int ret =3D 0;
>  	int val;
> @@ -587,7 +588,7 @@ static int smb347_set_temp_limits(struct smb347_charg=
er *smb)
>  	}
> =20
>  	if (smb->pdata->charge_current_compensation) {
> -		val =3D current_to_hw(ccc_tbl, ARRAY_SIZE(ccc_tbl),
> +		val =3D current_to_hw(ccc_tbl[id], ARRAY_SIZE(ccc_tbl[id]),
>  				    smb->pdata->charge_current_compensation);
>  		if (val < 0)
>  			return val;
> @@ -883,6 +884,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
>   */
>  static int get_const_charge_current(struct smb347_charger *smb)
>  {
> +	unsigned int id =3D smb->id;
>  	int ret, intval;
>  	unsigned int v;
> =20
> @@ -898,10 +900,12 @@ static int get_const_charge_current(struct smb347_c=
harger *smb)
>  	 * and we can detect which table to use from bit 5.
>  	 */
>  	if (v & 0x20) {
> -		intval =3D hw_to_current(fcc_tbl, ARRAY_SIZE(fcc_tbl), v & 7);
> +		intval =3D hw_to_current(fcc_tbl[id],
> +				       ARRAY_SIZE(fcc_tbl[id]), v & 7);
>  	} else {
>  		v >>=3D 3;
> -		intval =3D hw_to_current(pcc_tbl, ARRAY_SIZE(pcc_tbl), v & 7);
> +		intval =3D hw_to_current(pcc_tbl[id],
> +				       ARRAY_SIZE(pcc_tbl[id]), v & 7);
>  	}
> =20
>  	return intval;
> @@ -1317,6 +1321,7 @@ static int smb347_probe(struct i2c_client *client,
> =20
>  	mutex_init(&smb->lock);
>  	smb->dev =3D &client->dev;
> +	smb->id =3D id->driver_data;
> =20
>  	smb->regmap =3D devm_regmap_init_i2c(client, &smb347_regmap);
>  	if (IS_ERR(smb->regmap))
> @@ -1391,13 +1396,17 @@ static int smb347_remove(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id smb347_id[] =3D {
> -	{ "smb347", 0 },
> -	{ }
> +	{ "smb345", SMB345 },
> +	{ "smb347", SMB347 },
> +	{ "smb358", SMB358 },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, smb347_id);
> =20
>  static const struct of_device_id smb3xx_of_match[] =3D {
> +	{ .compatible =3D "summit,smb345" },
>  	{ .compatible =3D "summit,smb347" },
> +	{ .compatible =3D "summit,smb358" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, smb3xx_of_match);
> --=20
> 2.25.0
>=20

--sa24v6gpbuf57hdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64LooACgkQ2O7X88g7
+ppL2w//cU8s8ZESAFjBqF20vNpqZ9KsINg0YN3+r10vtRHwS/SbW5441CY7nekz
qHCenf8/jTW372HyOZma5skIPJ6ioFZsoQxJnwFHAgBithe8qb2tYsH3nq2RhQwL
vQE56+MOTiU1D2b19n/rWUJXtvSm/Uq/tGapGCo0uIBpRvq7uMljx7m3Vp8ElSxm
NIefrRBHBQjHNoksyMZhwTwyi5narJfKosu4phpV8mUNi+nfzdsgKajqggYQgJ2+
sXnNcvwfGegTsLnJ9ROFLorOdYee1pn5CwMsGLPgkjjTTRf7UopeOpent9/EvwYR
jbm5GjsAR0hpESWw3pv3HjM+aG8Vsa6PmVL25D23chXWUQLaQl+pMwpFC8+GkD2o
51cmmYuGYpFzLCxtuN/RHKrwofXcY29SUzFOibzsUu+nH+cUMkB7+qYvyj5Zr7xR
qFwNMa0x9fay1FKWrVhQwmj5s7vEtI9iK25gVfv2yU0PtV/xQ0t2ItUTxANYBM6m
b2y+iNZ7L0KZKYuXRcmuuezUfGsKURJifBXnn7o+WHUNF/Bc1EEarxhT+Obh5Od1
/Li0nLNRTQcIQcJvXeGO23mSO3UFlAx+Q0ZFd4g0q7vnZGFAjWiFUtVf+3J17WpU
V24A5LPL7ka17qQ4iV32C4pzm9/Wvq8qQIXaRV73+z0SJZA2oKA=
=JRt5
-----END PGP SIGNATURE-----

--sa24v6gpbuf57hdl--

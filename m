Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D1353C7A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhDEIo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 04:44:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57090 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhDEIo7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 04:44:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1A0F61F44B1D
Received: by earth.universe (Postfix, from userid 1000)
        id 5F71E3C0C96; Mon,  5 Apr 2021 10:44:51 +0200 (CEST)
Date:   Mon, 5 Apr 2021 10:44:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] drivers: power_supply: cpcap-battery: Add battery type
 auto detection for mapphone devices
Message-ID: <20210405084451.7rnr3juiwxvr57uy@earth.universe>
References: <20210117233839.abcba42136d1fb9907e5bc6a@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5q5kox3q36ana5pq"
Content-Disposition: inline
In-Reply-To: <20210117233839.abcba42136d1fb9907e5bc6a@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5q5kox3q36ana5pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2021 at 11:38:39PM +0100, Carl Philipp Klemm wrote:
> This allow cpcap-battery to detect whitch battery is inserted, HW4X or BW=
8X for
> xt875 and EB41 for xt894 by examining the battery nvmem. If no known batt=
ery
> is detected sane defaults are used.

Idea sounds very good to me :)

> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
> ---
>  drivers/power/supply/cpcap-battery.c | 117 ++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 8ae0c9c7ebcb..4bd7c71c6abe 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -28,6 +28,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
> +#include <linux/nvmem-consumer.h>

You need to add at least

depends on NVMEM || !NVMEM

to the cpcap-battery Kconfig symbol. This marks the config
CPCAP_BATTERY=3Dy && NVMEM=3Dm as invalid. But considering we
expect batteries to have the NVMEM it might be better to
just add

depends on NVMEM

even though code works without NVMEM to some degree.

>  #include <linux/moduleparam.h>
> =20
>  #include <linux/iio/consumer.h>
> @@ -73,6 +74,9 @@
> =20
>  #define CPCAP_BATTERY_CC_SAMPLE_PERIOD_MS	250
> =20
> +#define CPCAP_BATTERY_EB41_HW4X_ID 0x9E
> +#define CPCAP_BATTERY_BW8X_ID 0x98
> +
>  enum {
>  	CPCAP_BATTERY_IIO_BATTDET,
>  	CPCAP_BATTERY_IIO_VOLTAGE,
> @@ -97,6 +101,7 @@ struct cpcap_interrupt_desc {
> =20
>  struct cpcap_battery_config {
>  	int cd_factor;
> +	char id;

This is not being used anywhere, please drop.

>  	struct power_supply_info info;
>  	struct power_supply_battery_info bat;
>  };
> @@ -138,6 +143,7 @@ struct cpcap_battery_ddata {
>  	int charge_full;
>  	int status;
>  	u16 vendor;
> +	bool check_nvmem;
>  	unsigned int is_full:1;
>  };
> =20
> @@ -146,6 +152,50 @@ struct cpcap_battery_ddata {
>  static bool ignore_temperature_probe;
>  module_param(ignore_temperature_probe, bool, 0660);
> =20
> +/*
> + * Based on the values from Motorola mapphone Linux kernel for the
> + * stock Droid 4 battery eb41. In the Motorola mapphone Linux
> + * kernel tree the value for pm_cd_factor is passed to the kernel
> + * via device tree. If it turns out to be something device specific
> + * we can consider that too later. These values are also fine for
> + * Bionic's hw4x.
> + *
> + * And looking at the battery full and shutdown values for the stock
> + * kernel on droid 4, full is 4351000 and software initiates shutdown
> + * at 3078000. The device will die around 2743000.
> + */
> +static const struct cpcap_battery_config cpcap_battery_eb41_data =3D {
> +	.cd_factor =3D 0x3cc,
> +	.info.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> +	.info.voltage_max_design =3D 4351000,
> +	.info.voltage_min_design =3D 3100000,
> +	.info.charge_full_design =3D 1740000,
> +	.bat.constant_charge_voltage_max_uv =3D 4200000,
> +};
> +
> +/* Values for the extended Droid Bionic battery bw8x. */
> +static const struct cpcap_battery_config cpcap_battery_bw8x_data =3D {
> +	.cd_factor =3D 0x3cc,
> +	.info.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> +	.info.voltage_max_design =3D 4200000,
> +	.info.voltage_min_design =3D 3200000,
> +	.info.charge_full_design =3D 2760000,
> +	.bat.constant_charge_voltage_max_uv =3D 4200000,
> +};
> +
> +/*
> + * Safe values for any lipo battery likely to fit into a mapphone
> + * battery bay.
> + */
> +static const struct cpcap_battery_config cpcap_battery_unkown_data =3D {
> +	.cd_factor =3D 0x3cc,
> +	.info.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> +	.info.voltage_max_design =3D 4200000,
> +	.info.voltage_min_design =3D 3200000,
> +	.info.charge_full_design =3D 3000000,
> +	.bat.constant_charge_voltage_max_uv =3D 4200000,
> +};
> +
>  static struct cpcap_battery_state_data *
>  cpcap_battery_get_state(struct cpcap_battery_ddata *ddata,
>  			enum cpcap_battery_state state)
> @@ -531,6 +581,41 @@ static void cpcap_battery_external_power_changed(str=
uct power_supply *psy)
>  	power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &prop);
>  }
> =20
> +static int cpcap_battery_match_nvmem(struct device *dev, const void *dat=
a)
> +{
> +	if (strcmp(dev_name(dev), "89-500029ba0f73") =3D=3D 0)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata=
 *ddata)
> +{
> +	struct nvmem_device *nvmem;
> +	u8 battery_id =3D 0;
> +
> +	ddata->check_nvmem =3D false;
> +
> +	nvmem =3D nvmem_device_find(NULL, &cpcap_battery_match_nvmem);
> +	if (IS_ERR_OR_NULL(nvmem)) {
> +		ddata->check_nvmem =3D true;
> +	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
> +		battery_id =3D 0;
> +		ddata->check_nvmem =3D true;
> +	}

Can we print warnings for the above problems or are there batteries
without nvmem?

> +	switch (battery_id) {
> +	case CPCAP_BATTERY_EB41_HW4X_ID:
> +		memcpy(&ddata->config, &cpcap_battery_eb41_data, sizeof(ddata->config)=
);
> +		break;
> +	case CPCAP_BATTERY_BW8X_ID:
> +		memcpy(&ddata->config, &cpcap_battery_bw8x_data, sizeof(ddata->config)=
);
> +		break;
> +	default:
> +		memcpy(&ddata->config, &cpcap_battery_unkown_data, sizeof(ddata->confi=
g));
> +	}
> +}
> +
>  static enum power_supply_property cpcap_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
> @@ -564,6 +649,9 @@ static int cpcap_battery_get_property(struct power_su=
pply *psy,
>  	int cached;
>  	s64 tmp;
> =20
> +	if (ddata->check_nvmem)
> +		cpcap_battery_detect_battery_type(ddata);
> +
>  	cached =3D cpcap_battery_update_status(ddata);
>  	if (cached < 0)
>  		return cached;
> @@ -981,30 +1069,10 @@ static int cpcap_battery_calibrate(struct cpcap_ba=
ttery_ddata *ddata)
>  	return error;
>  }
> =20
> -/*
> - * Based on the values from Motorola mapphone Linux kernel. In the
> - * the Motorola mapphone Linux kernel tree the value for pm_cd_factor
> - * is passed to the kernel via device tree. If it turns out to be
> - * something device specific we can consider that too later.
> - *
> - * And looking at the battery full and shutdown values for the stock
> - * kernel on droid 4, full is 4351000 and software initiates shutdown
> - * at 3078000. The device will die around 2743000.
> - */
> -static const struct cpcap_battery_config cpcap_battery_default_data =3D {
> -	.cd_factor =3D 0x3cc,
> -	.info.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> -	.info.voltage_max_design =3D 4351000,
> -	.info.voltage_min_design =3D 3100000,
> -	.info.charge_full_design =3D 1740000,
> -	.bat.constant_charge_voltage_max_uv =3D 4200000,
> -};
> -
>  #ifdef CONFIG_OF
>  static const struct of_device_id cpcap_battery_id_table[] =3D {
>  	{
>  		.compatible =3D "motorola,cpcap-battery",
> -		.data =3D &cpcap_battery_default_data,
>  	},
>  	{},
>  };
> @@ -1024,19 +1092,14 @@ static int cpcap_battery_probe(struct platform_de=
vice *pdev)
>  	if (!match)
>  		return -EINVAL;

Please remove all match related stuff; it was only required for
accessing match->data.

> -	if (!match->data) {
> -		dev_err(&pdev->dev, "no configuration data found\n");
> -
> -		return -ENODEV;
> -	}
> -
>  	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
> =20
> +	cpcap_battery_detect_battery_type(ddata);
> +
>  	INIT_LIST_HEAD(&ddata->irq_list);
>  	ddata->dev =3D &pdev->dev;
> -	memcpy(&ddata->config, match->data, sizeof(ddata->config));
> =20
>  	ddata->reg =3D dev_get_regmap(ddata->dev->parent, NULL);
>  	if (!ddata->reg)
> --=20
> 2.29.2

Thanks,

-- Sebastian

--5q5kox3q36ana5pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBqzf4ACgkQ2O7X88g7
+ppwDBAAm0ev5svuGPqt0bFK9/aCB/O0FwEpgUhXoqz61up92+5YkBF8fs0nKOZS
W1GgYoqCVr0qFZBhCdmCADDsVbE3lAWFlIRX+l/vhP9ohUuBf6NVFxotwmbQleyx
04Y/KI3ltfQpaAMTppRMpmMH4KdsGjBsuoyPhuEnfe+9fPMie2nkR5nDGlzTIw/N
0EOi8XdjfDsRgeBY+hd/Qz+isnWU4woQ8F66Cdz3DjlS9+GtsJG4jtEJ7btS+hb7
QFDkZ7ctnpx8+Ov+5sPJlB+nv3DXjf6ZNmNjeU/DqniuGcvmhDe3uZjqE/hbllOd
lFxS5IBzMGPR/Chw+wQy+tzjjXJyPwVqD6QDL5o+RCqiHH4JdJKZ6OFQ+MTN5mKc
QKx6uwd11k5cltx1DLLbnIKSy7hDHZSUNEZ5474w8asC2MPNOmjnf6FGPoN58tXo
L4ulHx6LpNZNlhv3EB3+MylaRIEG/f2C/zZ0Ag87zKwyjzLTOSUUDN2Cw3VJGgkG
TxCTKbM2h1lp8X08kEXZ7Z4EtppA+Fx9P3koTtVNUxpJ0oXJWcn5Ia41jLWVXwMQ
go0qM7Ide2R2kamd9a3Kp/R98dGr9mwjccTJQlx4p8xcPTholIXzsecaH48oVZtx
pR3R30+N9CvinvyEurYAnMIvyuAhjWwRo3v9QsQNU9B570AKNHY=
=qKuE
-----END PGP SIGNATURE-----

--5q5kox3q36ana5pq--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54810A35E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfKZReC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 12:34:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKZReC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 12:34:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 65A2228F75C
Received: by earth.universe (Postfix, from userid 1000)
        id 9CC2B3C0C71; Tue, 26 Nov 2019 15:52:00 +0100 (CET)
Date:   Tue, 26 Nov 2019 15:52:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191126145200.xqtvfrm6qc6yuutb@earth.universe>
References: <20191117141335.23404-1-matheus@castello.eng.br>
 <20191117141335.23404-5-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p63jbpjrfe7ezmc2"
Content-Disposition: inline
In-Reply-To: <20191117141335.23404-5-matheus@castello.eng.br>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p63jbpjrfe7ezmc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 17, 2019 at 11:13:34AM -0300, Matheus Castello wrote:
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>=20
> Now we can use "maxim,alert-low-soc-level" property with the values from
> 1% up to 32% to configure alert interrupt threshold.
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 75 ++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 9909f8cd7b5d..3fc9e1c7b257 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -29,6 +29,9 @@
>  #define MAX17040_DELAY		1000
>  #define MAX17040_BATTERY_FULL	95
>=20
> +#define MAX17040_ATHD_MASK		0xFFC0
> +#define MAX17040_ATHD_DEFAULT_POWER_UP	4
> +
>  struct max17040_chip {
>  	struct i2c_client		*client;
>  	struct delayed_work		work;
> @@ -43,6 +46,8 @@ struct max17040_chip {
>  	int soc;
>  	/* State Of Charge */
>  	int status;
> +	/* Low alert threshold from 32% to 1% of the State of Charge */
> +	u32 low_soc_alert;
>  };
>=20
>  static int max17040_get_property(struct power_supply *psy,
> @@ -99,6 +104,21 @@ static void max17040_reset(struct i2c_client *client)
>  	max17040_write_reg(client, MAX17040_CMD, 0x0054);
>  }
>=20
> +static int max17040_set_low_soc_alert(struct i2c_client *client, u32 lev=
el)
> +{
> +	int ret;
> +	u16 data;
> +
> +	level =3D 32 - level;
> +	data =3D max17040_read_reg(client, MAX17040_RCOMP);
> +	/* clear the alrt bit and set LSb 5 bits */
> +	data &=3D MAX17040_ATHD_MASK;
> +	data |=3D level;
> +	ret =3D max17040_write_reg(client, MAX17040_RCOMP, data);
> +
> +	return ret;
> +}
> +
>  static void max17040_get_vcell(struct i2c_client *client)
>  {
>  	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> @@ -115,7 +135,6 @@ static void max17040_get_soc(struct i2c_client *clien=
t)
>  	u16 soc;
>=20
>  	soc =3D max17040_read_reg(client, MAX17040_SOC);
> -

unrelated change.

>  	chip->soc =3D (soc >> 8);
>  }
>=20
> @@ -161,6 +180,24 @@ static void max17040_get_status(struct i2c_client *c=
lient)
>  		chip->status =3D POWER_SUPPLY_STATUS_FULL;
>  }
>=20
> +static int max17040_get_of_data(struct max17040_chip *chip)
> +{
> +	struct device *dev =3D &chip->client->dev;
> +	struct device_node *np =3D dev->of_node;
> +	int ret =3D 0;
> +
> +	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
> +				 &chip->low_soc_alert)) {
> +		chip->low_soc_alert =3D MAX17040_ATHD_DEFAULT_POWER_UP;
> +	} else if (chip->low_soc_alert <=3D 0 ||
> +			chip->low_soc_alert >=3D 33) {
> +		/* low_soc_alert is not between 1% and 32% */
> +		ret =3D -EINVAL;
> +	}

use device_property_read_u32(), which is not DT specific. Also
code can be simplified a bit:

chip->low_soc_alert =3D MAX17040_ATHD_DEFAULT_POWER_UP;
device_property_read_u32(dev, "maxim,alert-low-soc-level", &chip->low_soc_a=
lert);
if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33)
    return -EINVAL;
return 0;

> +
> +	return ret;
> +}
> +
>  static void max17040_check_changes(struct i2c_client *client)
>  {
>  	max17040_get_vcell(client);
> @@ -192,6 +229,9 @@ static irqreturn_t max17040_thread_handler(int id, vo=
id *dev)
>  	/* send uevent */
>  	power_supply_changed(chip->battery);
>=20
> +	/* reset alert bit */
> +	max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +
>  	return IRQ_HANDLED;
>  }
>=20
> @@ -230,6 +270,7 @@ static int max17040_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter =3D client->adapter;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct max17040_chip *chip;
> +	int ret;
>=20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>  		return -EIO;
> @@ -240,6 +281,12 @@ static int max17040_probe(struct i2c_client *client,
>=20
>  	chip->client =3D client;
>  	chip->pdata =3D client->dev.platform_data;
> +	ret =3D max17040_get_of_data(chip);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed: low SOC alert OF data out of bounds\n");
> +		return ret;
> +	}
>=20
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data =3D chip;
> @@ -256,14 +303,26 @@ static int max17040_probe(struct i2c_client *client,
>=20
>  	/* check interrupt */
>  	if (client->irq) {
> -		int ret;
> -
> -		ret =3D max17040_enable_alert_irq(chip);
> -
> -		if (ret) {
> -			client->irq =3D 0;
> +		if (of_device_is_compatible(client->dev.of_node,
> +					    "maxim,max77836-battery")) {
> +			ret =3D max17040_set_low_soc_alert(client,
> +							 chip->low_soc_alert);
> +			if (ret) {
> +				dev_err(&client->dev,
> +					"Failed to set low SOC alert: err %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			ret =3D max17040_enable_alert_irq(chip);
> +			if (ret) {
> +				client->irq =3D 0;
> +				dev_warn(&client->dev,
> +					 "Failed to get IRQ err %d\n", ret);
> +			}
> +		} else {
>  			dev_warn(&client->dev,
> -				 "Failed to get IRQ err %d\n", ret);
> +				 "Device not compatible for IRQ");

Something is odd here. Either this should be part of the first
patch ("max17040: Add IRQ handler for low SOC alert"), or both
device types support the IRQ and this check should be removed.

-- Sebastian

>  		}
>  	}
>=20
> --
> 2.24.0.rc2
>=20

--p63jbpjrfe7ezmc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3dPAwACgkQ2O7X88g7
+pqVnA/9HJ25z3TU/8d6ZS5s5PMtCNv+RCE4DKSeiKRcopdAcUJNjIz6gbR19bzQ
/0D4Vm8uXUfFtJRCC/tQ7cFZlXEhMRZs8eUo/6mYeHLu3ZPOO42/OVLU+72ai0OK
SK52O/pMnJCS3U626WL4f1AfcGcXDynVCtnJ8WP7rcTzwcIoCTQAJZ9zrhAf/Kvo
4wJyUqdJPTujLwqp9Xv1RWUMFirPLkNkk0CW8lB2kQJ9tC3ntFi7jQvn2Po9js49
98okoy1ZnNA39iRaYPJ4Xv2lI0Jhgd0FUgF5o8yzcqcbcTMhF4hll4zUVXA6Sjk7
xwEX9Q9X7H62RliKvCZ+QtEvv8ryI7UFJgKfRSOpJRKn/pGgo9GC5NKpFbRuQ0x8
Wgz6TWuWGt8AHehBhXfc69D5mm6sddq35gnLwhaTPgB+w2SBfLydc3c8xOuN1Ze+
vPwnWAphJE1Ek/kK7/u/0aOUb2njRdEhKWMVFbamoQ+X0PZELbxgrrJiwpRUdmEm
08/pZKwL5lUsedvfQ/MBn/6qo2OpXWB6js9T3nebF5Q0c1xMWtiLMFeoFr4fGYZ6
gm0hb755UotmIVxSStYj/pEz2vluve1djROKafrOSdxIjYzRaBjxasj1wLopkQBt
Nx5+4WNsMzieHaOmCfem10kmtNLXNxw7tRh4Mdol52UD1qVY2+4=
=W72K
-----END PGP SIGNATURE-----

--p63jbpjrfe7ezmc2--

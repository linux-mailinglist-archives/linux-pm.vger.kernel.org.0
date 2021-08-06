Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3E3E30D0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhHFVO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235354AbhHFVO7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A18461186;
        Fri,  6 Aug 2021 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284482;
        bh=zCZOV6mtGH/8CwtGHIxPWriGp90nAg/fdRfU3cQVJTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEjl0vH1Og/TB3UWFN7lAnVkMIrMx4DWZoBmFAA6Slav7l24Oj7t3SLrSsKOuufOP
         0x5jaNcLM3zn+O3XYmN1bhhHRX58VsnC03JGsDdICd0YoG4qORQrsgA2dNoj86cyKb
         2CSV1+mc5pLcVEoE71GfAyue+Dj9wGSf7pqa84tNXxfKB9pk30oMRcvBW/8IIUxvOV
         /UGGl7Zenw9rAEi7ifqkVVJwAAbWY9XXBXHqebkTmqKhINhYtImaxEk+apqGdabTng
         UT3Y7k0kqZek72nepUbjMVS4KZsXfVgwkr+yU+nxy2N6t/HPtNKJOQ46H/4zEv5w3L
         mVIrg0myfFCjA==
Received: by earth.universe (Postfix, from userid 1000)
        id 7E5F83C0C99; Fri,  6 Aug 2021 23:14:40 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:14:40 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 09/12] power: supply: smb347-charger: Implement USB
 VBUS regulator
Message-ID: <20210806211440.fzgy6a33cpx6rvdn@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ephl3snswcksh5tx"
Content-Disposition: inline
In-Reply-To: <20210731173842.19643-10-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ephl3snswcksh5tx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 31, 2021 at 08:38:39PM +0300, Dmitry Osipenko wrote:
> SMB347 can supply power to USB VBUS, implement the USB VBUS regulator.
> USB VBUS needs to be powered for switching OTG-cable USB port into host
> mode.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/Kconfig          |   1 +
>  drivers/power/supply/smb347-charger.c | 219 ++++++++++++++++++++++++++
>  2 files changed, 220 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 8543c89a0c1a..e83e9e4d512c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -694,6 +694,7 @@ config CHARGER_BQ256XX
>  config CHARGER_SMB347
>  	tristate "Summit Microelectronics SMB3XX Battery Charger"
>  	depends on I2C
> +	depends on REGULATOR
>  	select REGMAP_I2C
>  	help
>  	  Say Y to include support for Summit Microelectronics SMB345,
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index 1c9205ca0993..753944e774c4 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -18,6 +18,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> =20
>  #include <dt-bindings/power/summit,smb347-charger.h>
> =20
> @@ -63,12 +64,15 @@
>  #define CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT	2
>  #define CFG_THERM_MONITOR_DISABLED		BIT(4)
>  #define CFG_SYSOK				0x08
> +#define CFG_SYSOK_INOK_ACTIVE_HIGH		BIT(0)
>  #define CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED	BIT(2)
>  #define CFG_OTHER				0x09
>  #define CFG_OTHER_RID_MASK			0xc0
>  #define CFG_OTHER_RID_ENABLED_AUTO_OTG		0xc0
>  #define CFG_OTG					0x0a
>  #define CFG_OTG_TEMP_THRESHOLD_MASK		0x30
> +#define CFG_OTG_CURRENT_LIMIT_250mA		BIT(2)
> +#define CFG_OTG_CURRENT_LIMIT_750mA		BIT(3)
>  #define CFG_OTG_TEMP_THRESHOLD_SHIFT		4
>  #define CFG_OTG_CC_COMPENSATION_MASK		0xc0
>  #define CFG_OTG_CC_COMPENSATION_SHIFT		6
> @@ -92,6 +96,7 @@
>  #define CMD_A					0x30
>  #define CMD_A_CHG_ENABLED			BIT(1)
>  #define CMD_A_SUSPEND_ENABLED			BIT(2)
> +#define CMD_A_OTG_ENABLED			BIT(4)
>  #define CMD_A_ALLOW_WRITE			BIT(7)
>  #define CMD_B					0x31
>  #define CMD_C					0x33
> @@ -133,10 +138,12 @@
>   * @regmap: pointer to driver regmap
>   * @mains: power_supply instance for AC/DC power
>   * @usb: power_supply instance for USB power
> + * @usb_rdev: USB VBUS regulator device
>   * @id: SMB charger ID
>   * @mains_online: is AC/DC input connected
>   * @usb_online: is USB input connected
>   * @irq_unsupported: is interrupt unsupported by SMB hardware
> + * @usb_vbus_enabled: is USB VBUS powered by SMB charger
>   * @max_charge_current: maximum current (in uA) the battery can be charg=
ed
>   * @max_charge_voltage: maximum voltage (in uV) the battery can be charg=
ed
>   * @pre_charge_current: current (in uA) to use in pre-charging phase
> @@ -167,6 +174,8 @@
>   * @use_usb_otg: USB OTG output can be used (not implemented yet)
>   * @enable_control: how charging enable/disable is controlled
>   *		    (driver/pin controls)
> + * @inok_polarity: polarity of INOK signal which denotes presence of ext=
ernal
> + *		   power supply
>   *
>   * @use_main, @use_usb, and @use_usb_otg are means to enable/disable
>   * hardware support for these. This is useful when we want to have for
> @@ -189,10 +198,12 @@ struct smb347_charger {
>  	struct regmap		*regmap;
>  	struct power_supply	*mains;
>  	struct power_supply	*usb;
> +	struct regulator_dev	*usb_rdev;
>  	unsigned int		id;
>  	bool			mains_online;
>  	bool			usb_online;
>  	bool			irq_unsupported;
> +	bool			usb_vbus_enabled;
> =20
>  	unsigned int		max_charge_current;
>  	unsigned int		max_charge_voltage;
> @@ -213,6 +224,7 @@ struct smb347_charger {
>  	bool			use_usb;
>  	bool			use_usb_otg;
>  	unsigned int		enable_control;
> +	unsigned int		inok_polarity;
>  };
> =20
>  enum smb_charger_chipid {
> @@ -362,6 +374,11 @@ static int smb347_charging_set(struct smb347_charger=
 *smb, bool enable)
>  		return 0;
>  	}
> =20
> +	if (enable && smb->usb_vbus_enabled) {
> +		dev_dbg(smb->dev, "charging not enabled because USB is in host mode\n"=
);
> +		return 0;
> +	}
> +
>  	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
>  				  enable ? CMD_A_CHG_ENABLED : 0);
>  }
> @@ -1253,6 +1270,13 @@ static void smb347_dt_parse_dev_info(struct smb347=
_charger *smb)
>  	/* Select charging control */
>  	device_property_read_u32(dev, "summit,enable-charge-control",
>  				 &smb->enable_control);
> +
> +	/*
> +	 * Polarity of INOK signal indicating presence of external power
> +	 * supply connected to the charger.
> +	 */
> +	device_property_read_u32(dev, "summit,inok-polarity",
> +				 &smb->inok_polarity);
>  }
> =20
>  static int smb347_get_battery_info(struct smb347_charger *smb)
> @@ -1304,6 +1328,160 @@ static int smb347_get_battery_info(struct smb347_=
charger *smb)
>  	return 0;
>  }
> =20
> +static int smb347_usb_vbus_get_current_limit(struct regulator_dev *rdev)
> +{
> +	struct smb347_charger *smb =3D rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(smb->regmap, CFG_OTG, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * It's unknown what happens if this bit is unset due to lack of
> +	 * access to the datasheet, assume it's limit-enable.
> +	 */
> +	if (!(val & CFG_OTG_CURRENT_LIMIT_250mA))
> +		return 0;
> +
> +	return val & CFG_OTG_CURRENT_LIMIT_750mA ? 750000 : 250000;
> +}
> +
> +static int smb347_usb_vbus_set_new_current_limit(struct smb347_charger *=
smb,
> +						 int max_uA)
> +{
> +	const unsigned int mask =3D CFG_OTG_CURRENT_LIMIT_750mA |
> +				  CFG_OTG_CURRENT_LIMIT_250mA;
> +	unsigned int val =3D CFG_OTG_CURRENT_LIMIT_250mA;
> +	int ret;
> +
> +	if (max_uA >=3D 750000)
> +		val |=3D CFG_OTG_CURRENT_LIMIT_750mA;
> +
> +	ret =3D regmap_update_bits(smb->regmap, CFG_OTG, mask, val);
> +	if (ret < 0)
> +		dev_err(smb->dev, "failed to change USB current limit\n");
> +
> +	return ret;
> +}
> +
> +static int smb347_usb_vbus_set_current_limit(struct regulator_dev *rdev,
> +					     int min_uA, int max_uA)
> +{
> +	struct smb347_charger *smb =3D rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	ret =3D smb347_set_writable(smb, true, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D smb347_usb_vbus_set_new_current_limit(smb, max_uA);
> +	smb347_set_writable(smb, false, true);
> +
> +	return ret;
> +}
> +
> +static int smb347_usb_vbus_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct smb347_charger *smb =3D rdev_get_drvdata(rdev);
> +	int ret, max_uA;
> +
> +	ret =3D smb347_set_writable(smb, true, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	smb347_charging_disable(smb);
> +
> +	if (device_property_read_bool(&rdev->dev, "summit,needs-inok-toggle")) {
> +		unsigned int sysok =3D 0;
> +
> +		if (smb->inok_polarity =3D=3D SMB3XX_SYSOK_INOK_ACTIVE_LOW)
> +			sysok =3D CFG_SYSOK_INOK_ACTIVE_HIGH;
> +
> +		/*
> +		 * VBUS won't be powered if INOK is active, so we need to
> +		 * manually disable INOK on some platforms.
> +		 */
> +		ret =3D regmap_update_bits(smb->regmap, CFG_SYSOK,
> +					 CFG_SYSOK_INOK_ACTIVE_HIGH, sysok);
> +		if (ret < 0) {
> +			dev_err(smb->dev, "failed to disable INOK\n");
> +			goto done;
> +		}
> +	}
> +
> +	ret =3D smb347_usb_vbus_get_current_limit(rdev);
> +	if (ret < 0) {
> +		dev_err(smb->dev, "failed to get USB VBUS current limit\n");
> +		goto done;
> +	}
> +
> +	max_uA =3D ret;
> +
> +	ret =3D smb347_usb_vbus_set_new_current_limit(smb, 250000);
> +	if (ret < 0) {
> +		dev_err(smb->dev, "failed to preset USB VBUS current limit\n");
> +		goto done;
> +	}
> +
> +	ret =3D regmap_set_bits(smb->regmap, CMD_A, CMD_A_OTG_ENABLED);
> +	if (ret < 0) {
> +		dev_err(smb->dev, "failed to enable USB VBUS\n");
> +		goto done;
> +	}
> +
> +	smb->usb_vbus_enabled =3D true;
> +
> +	ret =3D smb347_usb_vbus_set_new_current_limit(smb, max_uA);
> +	if (ret < 0) {
> +		dev_err(smb->dev, "failed to restore USB VBUS current limit\n");
> +		goto done;
> +	}
> +done:
> +	smb347_set_writable(smb, false, true);
> +
> +	return ret;
> +}
> +
> +static int smb347_usb_vbus_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct smb347_charger *smb =3D rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	ret =3D smb347_set_writable(smb, true, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_clear_bits(smb->regmap, CMD_A, CMD_A_OTG_ENABLED);
> +	if (ret < 0) {
> +		dev_err(smb->dev, "failed to disable USB VBUS\n");
> +		goto done;
> +	}
> +
> +	smb->usb_vbus_enabled =3D false;
> +
> +	if (device_property_read_bool(&rdev->dev, "summit,needs-inok-toggle")) {
> +		unsigned int sysok =3D 0;
> +
> +		if (smb->inok_polarity =3D=3D SMB3XX_SYSOK_INOK_ACTIVE_HIGH)
> +			sysok =3D CFG_SYSOK_INOK_ACTIVE_HIGH;
> +
> +		ret =3D regmap_update_bits(smb->regmap, CFG_SYSOK,
> +					 CFG_SYSOK_INOK_ACTIVE_HIGH, sysok);
> +		if (ret < 0) {
> +			dev_err(smb->dev, "failed to enable INOK\n");
> +			goto done;
> +		}
> +	}
> +
> +	smb347_start_stop_charging(smb);
> +done:
> +	smb347_set_writable(smb, false, true);
> +
> +	return ret;
> +}
> +
>  static const struct regmap_config smb347_regmap =3D {
>  	.reg_bits	=3D 8,
>  	.val_bits	=3D 8,
> @@ -1314,6 +1492,14 @@ static const struct regmap_config smb347_regmap =
=3D {
>  	.num_reg_defaults_raw =3D SMB347_MAX_REGISTER,
>  };
> =20
> +static const struct regulator_ops smb347_usb_vbus_regulator_ops =3D {
> +	.is_enabled	=3D regulator_is_enabled_regmap,
> +	.enable		=3D smb347_usb_vbus_regulator_enable,
> +	.disable	=3D smb347_usb_vbus_regulator_disable,
> +	.get_current_limit =3D smb347_usb_vbus_get_current_limit,
> +	.set_current_limit =3D smb347_usb_vbus_set_current_limit,
> +};
> +
>  static const struct power_supply_desc smb347_mains_desc =3D {
>  	.name		=3D "smb347-mains",
>  	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> @@ -1330,10 +1516,24 @@ static const struct power_supply_desc smb347_usb_=
desc =3D {
>  	.num_properties	=3D ARRAY_SIZE(smb347_properties),
>  };
> =20
> +static const struct regulator_desc smb347_usb_vbus_regulator_desc =3D {
> +	.name		=3D "smb347-usb-vbus",
> +	.of_match	=3D of_match_ptr("usb-vbus"),
> +	.ops		=3D &smb347_usb_vbus_regulator_ops,
> +	.type		=3D REGULATOR_VOLTAGE,
> +	.owner		=3D THIS_MODULE,
> +	.enable_reg	=3D CMD_A,
> +	.enable_mask	=3D CMD_A_OTG_ENABLED,
> +	.enable_val	=3D CMD_A_OTG_ENABLED,
> +	.fixed_uV	=3D 5000000,
> +	.n_voltages	=3D 1,
> +};
> +
>  static int smb347_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct power_supply_config mains_usb_cfg =3D {};
> +	struct regulator_config usb_rdev_cfg =3D {};
>  	struct device *dev =3D &client->dev;
>  	struct smb347_charger *smb;
>  	int ret;
> @@ -1381,6 +1581,18 @@ static int smb347_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
> =20
> +	usb_rdev_cfg.dev =3D dev;
> +	usb_rdev_cfg.driver_data =3D smb;
> +	usb_rdev_cfg.regmap =3D smb->regmap;
> +
> +	smb->usb_rdev =3D devm_regulator_register(dev,
> +						&smb347_usb_vbus_regulator_desc,
> +						&usb_rdev_cfg);
> +	if (IS_ERR(smb->usb_rdev)) {
> +		smb347_irq_disable(smb);
> +		return PTR_ERR(smb->usb_rdev);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -1388,11 +1600,17 @@ static int smb347_remove(struct i2c_client *clien=
t)
>  {
>  	struct smb347_charger *smb =3D i2c_get_clientdata(client);
> =20
> +	smb347_usb_vbus_regulator_disable(smb->usb_rdev);
>  	smb347_irq_disable(smb);
> =20
>  	return 0;
>  }
> =20
> +static void smb347_shutdown(struct i2c_client *client)
> +{
> +	smb347_remove(client);
> +}
> +
>  static const struct i2c_device_id smb347_id[] =3D {
>  	{ "smb345", SMB345 },
>  	{ "smb347", SMB347 },
> @@ -1416,6 +1634,7 @@ static struct i2c_driver smb347_driver =3D {
>  	},
>  	.probe =3D smb347_probe,
>  	.remove =3D smb347_remove,
> +	.shutdown =3D smb347_shutdown,
>  	.id_table =3D smb347_id,
>  };
>  module_i2c_driver(smb347_driver);
> --=20
> 2.32.0
>=20

--ephl3snswcksh5tx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENpkAACgkQ2O7X88g7
+pp91BAAqI5zMOm4UbecLjdyRi+p8rkgzNYAqWl3oHUuI/w/TYMk10jHpDELUXBx
x3mBlYa0+4TZ3YhfGWSd5cwN8kqRljooHrqlZ64h6oa+RpzBvLW8FGxiCQpPf4so
5ubv8xElCgB6CEAXx7yX85jNuetA7xJVJp7RGuAWn8Tu9lrPYoNjBLPaw46IIpRR
ER6NrevVzuvtg+yHtYJ2+sy8jp68y3KSefAQPGelgWy/7K3u5v3OwLrX2RmAsOvM
vOzJmtHev2i/44PmIIGmkdl1yiOB+zpG+O0MOWfHpubZaTDiU/MZ65Vu4LeZ18CK
FHj20DCKmThG4CnZxvMI8CzIv6tGMvYljU8jBidzLMiiSR+Mg7iilZEZLRKQkLa+
JLnr6U7rIXPZWoPVZl/K9ZZEcJHG47y5X/olMfUebVh+vDDUwjI14Vvl2+gaUWyu
G4bZy2YX8HwnRH5tp9K/aFPJ18neYX4iGpErBxZI+AtqmcWkmy6r4ZppppyqFhAo
k8oaElSmAh07JKeUkw8purd72cNebZf56uYgpmIUCEBbtOX8njfnHlrLGAk2wef8
XVyvYrkP4knS3mLptoH6RgzHtVX/OeqKJAoLr+7M9zTWGi5+plTqE0QtI5vxDSto
vuFQoiF8ZHSq6XHqXREWINN6B8P+QXbhGXuOJnyTGISGZiDmGf8=
=j3qL
-----END PGP SIGNATURE-----

--ephl3snswcksh5tx--

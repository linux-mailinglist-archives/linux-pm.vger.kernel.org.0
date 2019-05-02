Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291921237F
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBUi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 16:38:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42468 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBUi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 16:38:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 02E1F2804F8
Received: by earth.universe (Postfix, from userid 1000)
        id A69433C0D1B; Thu,  2 May 2019 22:38:21 +0200 (CEST)
Date:   Thu, 2 May 2019 22:38:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, lamzin@google.com, bartfab@google.com,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        jchwong@chromium.org, tbroch@chromium.org
Subject: Re: [PATCH v8 2/2] power_supply: platform/chrome: wilco_ec: Add
 charging config driver
Message-ID: <20190502203821.vyuwp6duyvvgxe6r@earth.universe>
References: <20190424165651.236391-1-ncrews@chromium.org>
 <20190424165651.236391-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dpe6emt6fnfplnwi"
Content-Disposition: inline
In-Reply-To: <20190424165651.236391-2-ncrews@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dpe6emt6fnfplnwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2019 at 10:56:51AM -0600, Nick Crews wrote:
> Add control of the charging algorithm used on Wilco devices.
> See Documentation/ABI/testing/sysfs-class-power-wilco for the
> userspace interface and other info.
>=20
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

The driver itself looks fine. Minor nit: MODULE_LICENSE("GPL v2") is
deprecated as of bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL"
vs. "GPL v2" bogosity").

Also the proper way to handle this is having two patches. One with
the changes from drivers/platform/chrome/wilco_ec/core.c and
include/linux/platform_data/wilco-ec.h and one with the power-supply
changes.

I think merging this for 5.2 is too late. Enric cannot merge
everything via the chrome tree, since this depends on the
patches adding POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
e.t.c. I cannot merge it via power-supply without risking merge
issues with the chrome tree. Preparing a proper immutable branch
needs some time and the merge window will probably start on Monday.

Assuming this is postponed to 5.3, my suggestion is: Prepare an
immutable branch based on 5.2-rc1, which contains all commits and
is merged into power-supply and chrome tree.

-- Sebastian

> v8 changes:
> -Several documentation and comment fixups.
> v6 changes:
> -Remove CHARGE_MODE_ILLEGAL from enum charge_mode. It's not a
>  public type, and error checking could be performed in other ways.
> -Split up the commit so properties are added in a first commit
> -Move CONFIG_CHARGER_WILCO to the power/supply Kconfig
> -Use PTR_ERR_OR_ZERO() macro in probe()
> v5 changes:
> -Remove OP_SYNC, it has no immediate use case.
> -Merge properties.h into wilco-ec.h
> -Remove enum get_set_sync_op from the public interface,
>  since without OP_SYNC they are irrelevant.
> -Fix Kconfigs and Makefiles so they actually work
>  with the v4 changes
> -Tweak some formatting, spacing, and comments
> -Fix validation of charge_type so illegal values
>  can't be set. Before negative error codes were
>  accidentally getting casted to positive numbers
> -Remove more unneeded parentheses.
> v4 changes:
> -Use put_unaligned_le32() to store PID in request.
> -Move implementation from
>  drivers/platform/chrome/wilco_ec/charge_config.c to
>  drivers/power/supply/wilco_charger.c
> -Move drivers/platform/chrome/wilco_ec/properties.h to
>  include/linux/platform_data/wilco-ec-properties.h
> -Remove parentheses in switch statement in psp_val_to_charge_mode()
> -Check for any negatvie return code from psp_val_to_charge_mode()
>  instead of just -EINVAL so its less brittle
> -Tweak comments in wilco-ec-properties.h
> v3 changes:
> -Add this changelog
> -Fix commit message tags
> v2 changes:
> -Update Documentation to say KernelVersion 5.2
> -Update Documentation to explain Trickle mode better.
> -rename things from using *PCC* to *CHARGE*
> -Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
> and Wilco EC codes
> -Use devm_ flavor of power_supply_register(), which simplifies things
> -Add extra error checking on property messages received from the EC
> -Fix bug in memcpy() calls in properties.c
> -Refactor fill_property_id()
> -Add valid input checks to charge_type
> -Properly convert charge_type when get()ting
>=20
>  .../ABI/testing/sysfs-class-power-wilco       |  30 +++
>  drivers/platform/chrome/wilco_ec/core.c       |  13 ++
>  drivers/power/supply/Kconfig                  |   9 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/wilco-charger.c          | 187 ++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h        |   2 +
>  6 files changed, 242 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
>  create mode 100644 drivers/power/supply/wilco-charger.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Document=
ation/ABI/testing/sysfs-class-power-wilco
> new file mode 100644
> index 000000000000..da1d6ffe5e3c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> @@ -0,0 +1,30 @@
> +What:		/sys/class/power_supply/wilco-charger/charge_type
> +Date:		April 2019
> +KernelVersion:	5.2
> +Description:
> +		What charging algorithm to use:
> +
> +		Standard: Fully charges battery at a standard rate.
> +		Adaptive: Battery settings adaptively optimized based on
> +			typical battery usage pattern.
> +		Fast: Battery charges over a shorter period.
> +		Trickle: Extends battery lifespan, intended for users who
> +			primarily use their Chromebook while connected to AC.
> +		Custom: A low and high threshold percentage is specified.
> +			Charging begins when level drops below
> +			charge_control_start_threshold, and ceases when
> +			level is above charge_control_end_threshold.
> +
> +What:		/sys/class/power_supply/wilco-charger/charge_control_start_thresh=
old
> +Date:		April 2019
> +KernelVersion:	5.2
> +Description:
> +		Used when charge_type=3D"Custom", as described above. Measured in
> +		percentages. The valid range is [50, 95].
> +
> +What:		/sys/class/power_supply/wilco-charger/charge_control_end_threshold
> +Date:		April 2019
> +KernelVersion:	5.2
> +Description:
> +		Used when charge_type=3D"Custom", as described above. Measured in
> +		percentages. The valid range is [55, 100].
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/c=
hrome/wilco_ec/core.c
> index 05e1e2be1c91..a8e3ef59f4ea 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -89,8 +89,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  		goto unregister_debugfs;
>  	}
> =20
> +	/* Register child device to be found by charger config driver. */
> +	ec->charger_pdev =3D platform_device_register_data(dev, "wilco-charger",
> +							 PLATFORM_DEVID_AUTO,
> +							 NULL, 0);
> +	if (IS_ERR(ec->charger_pdev)) {
> +		dev_err(dev, "Failed to create charger platform device\n");
> +		ret =3D PTR_ERR(ec->charger_pdev);
> +		goto unregister_rtc;
> +	}
> +
>  	return 0;
> =20
> +unregister_rtc:
> +	platform_device_unregister(ec->rtc_pdev);
>  unregister_debugfs:
>  	if (ec->debugfs_pdev)
>  		platform_device_unregister(ec->debugfs_pdev);
> @@ -102,6 +114,7 @@ static int wilco_ec_remove(struct platform_device *pd=
ev)
>  {
>  	struct wilco_ec_device *ec =3D platform_get_drvdata(pdev);
> =20
> +	platform_device_unregister(ec->charger_pdev);
>  	platform_device_unregister(ec->rtc_pdev);
>  	if (ec->debugfs_pdev)
>  		platform_device_unregister(ec->debugfs_pdev);
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..0c67eff871c8 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
> =20
> +config CHARGER_WILCO
> +	tristate "Wilco EC based charger for ChromeOS"
> +	depends on WILCO_EC
> +	help
> +	  Say Y here to enable control of the charging routines performed
> +	  by the Embedded Controller on the Chromebook named Wilco. Further
> +	  information can be found in
> +	  Documentation/ABI/testing/sysfs-class-power-wilco
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..2b603a142701 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> +obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
> diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/=
wilco-charger.c
> new file mode 100644
> index 000000000000..b3c6d7cdd731
> --- /dev/null
> +++ b/drivers/power/supply/wilco-charger.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Charging control driver for the Wilco EC
> + *
> + * Copyright 2019 Google LLC
> + *
> + * See Documentation/ABI/testing/sysfs-class-power and
> + * Documentation/ABI/testing/sysfs-class-power-wilco for userspace inter=
face
> + * and other info.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/power_supply.h>
> +
> +#define DRV_NAME "wilco-charger"
> +
> +/* Property IDs and related EC constants */
> +#define PID_CHARGE_MODE		0x0710
> +#define PID_CHARGE_LOWER_LIMIT	0x0711
> +#define PID_CHARGE_UPPER_LIMIT	0x0712
> +
> +enum charge_mode {
> +	CHARGE_MODE_STD =3D 1,	/* Used for Standard */
> +	CHARGE_MODE_EXP =3D 2,	/* Express Charge, used for Fast */
> +	CHARGE_MODE_AC =3D 3,	/* Mostly AC use, used for Trickle */
> +	CHARGE_MODE_AUTO =3D 4,	/* Used for Adaptive */
> +	CHARGE_MODE_CUSTOM =3D 5,	/* Used for Custom */
> +};
> +
> +#define CHARGE_LOWER_LIMIT_MIN	50
> +#define CHARGE_LOWER_LIMIT_MAX	95
> +#define CHARGE_UPPER_LIMIT_MIN	55
> +#define CHARGE_UPPER_LIMIT_MAX	100
> +
> +/* Convert from POWER_SUPPLY_PROP_CHARGE_TYPE value to the EC's charge m=
ode */
> +static int psp_val_to_charge_mode(int psp_val)
> +{
> +	switch (psp_val) {
> +	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
> +		return CHARGE_MODE_AC;
> +	case POWER_SUPPLY_CHARGE_TYPE_FAST:
> +		return CHARGE_MODE_EXP;
> +	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
> +		return CHARGE_MODE_STD;
> +	case POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE:
> +		return CHARGE_MODE_AUTO;
> +	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
> +		return CHARGE_MODE_CUSTOM;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/* Convert from EC's charge mode to POWER_SUPPLY_PROP_CHARGE_TYPE value =
*/
> +static int charge_mode_to_psp_val(enum charge_mode mode)
> +{
> +	switch (mode) {
> +	case CHARGE_MODE_AC:
> +		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +	case CHARGE_MODE_EXP:
> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
> +	case CHARGE_MODE_STD:
> +		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +	case CHARGE_MODE_AUTO:
> +		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
> +	case CHARGE_MODE_CUSTOM:
> +		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum power_supply_property wilco_charge_props[] =3D {
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> +
> +static int wilco_charge_get_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +	struct wilco_ec_device *ec =3D power_supply_get_drvdata(psy);
> +	u32 property_id;
> +	int ret;
> +	u8 raw;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		property_id =3D PID_CHARGE_MODE;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		property_id =3D PID_CHARGE_LOWER_LIMIT;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		property_id =3D PID_CHARGE_UPPER_LIMIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D wilco_ec_get_byte_property(ec, property_id, &raw);
> +	if (ret < 0)
> +		return ret;
> +	if (property_id =3D=3D PID_CHARGE_MODE) {
> +		ret =3D charge_mode_to_psp_val(raw);
> +		if (ret < 0)
> +			return -EBADMSG;
> +		raw =3D ret;
> +	}
> +	val->intval =3D raw;
> +
> +	return 0;
> +}
> +
> +static int wilco_charge_set_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     const union power_supply_propval *val)
> +{
> +	struct wilco_ec_device *ec =3D power_supply_get_drvdata(psy);
> +	int mode;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		mode =3D psp_val_to_charge_mode(val->intval);
> +		if (mode < 0)
> +			return -EINVAL;
> +		return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		if (val->intval < CHARGE_LOWER_LIMIT_MIN ||
> +		    val->intval > CHARGE_LOWER_LIMIT_MAX)
> +			return -EINVAL;
> +		return wilco_ec_set_byte_property(ec, PID_CHARGE_LOWER_LIMIT,
> +						  val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		if (val->intval < CHARGE_UPPER_LIMIT_MIN ||
> +		    val->intval > CHARGE_UPPER_LIMIT_MAX)
> +			return -EINVAL;
> +		return wilco_ec_set_byte_property(ec, PID_CHARGE_UPPER_LIMIT,
> +						  val->intval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int wilco_charge_property_is_writeable(struct power_supply *psy,
> +					      enum power_supply_property psp)
> +{
> +	return 1;
> +}
> +
> +static const struct power_supply_desc wilco_ps_desc =3D {
> +	.properties		=3D wilco_charge_props,
> +	.num_properties		=3D ARRAY_SIZE(wilco_charge_props),
> +	.get_property		=3D wilco_charge_get_property,
> +	.set_property		=3D wilco_charge_set_property,
> +	.property_is_writeable	=3D wilco_charge_property_is_writeable,
> +	.name			=3D DRV_NAME,
> +	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> +};
> +
> +static int wilco_charge_probe(struct platform_device *pdev)
> +{
> +	struct wilco_ec_device *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply *psy;
> +
> +	psy_cfg.drv_data =3D ec;
> +	psy =3D devm_power_supply_register(&pdev->dev, &wilco_ps_desc, &psy_cfg=
);
> +
> +	return PTR_ERR_OR_ZERO(psy);
> +}
> +
> +static struct platform_driver wilco_charge_driver =3D {
> +	.probe	=3D wilco_charge_probe,
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +	}
> +};
> +module_platform_driver(wilco_charge_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Wilco EC charge control driver");
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platf=
orm_data/wilco-ec.h
> index 50a21bd5fd44..66d9f177bec2 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -32,6 +32,7 @@
>   * @data_size: Size of the data buffer used for EC communication.
>   * @debugfs_pdev: The child platform_device used by the debugfs sub-driv=
er.
>   * @rtc_pdev: The child platform_device used by the RTC sub-driver.
> + * @charger_pdev: Child platform_device used by the charger config sub-d=
river.
>   */
>  struct wilco_ec_device {
>  	struct device *dev;
> @@ -43,6 +44,7 @@ struct wilco_ec_device {
>  	size_t data_size;
>  	struct platform_device *debugfs_pdev;
>  	struct platform_device *rtc_pdev;
> +	struct platform_device *charger_pdev;
>  };
> =20
>  /**
> --=20
> 2.20.1
>=20

--dpe6emt6fnfplnwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzLVToACgkQ2O7X88g7
+prXWA/+M8C/iNSinqmpDYj/NwT7PloeU104pRxk/mCPc7XdKuZNf4BC2Q5mwwcj
b7TBTI46JlKLUnr/dw5sXgsfcrfRCadGHcD7SAE49Bh8MonreaUcDF7KUYIbJ9YK
HMad7S0LxcfyDlAWPJyQoUToyO6YLRtu16WQ540Xnp2YTS7PKNDtp0odjZKK82eN
OCmKSji5AKpBDYM4Rm/HlYit6i6zjbUo8qnY2bgdAAr8+eWMOjHS6wqwztTicbcU
P0znejrZy67FYSYvIUGl3Hffm9SLoHUyEiaMwWEW8h7TzykzL0YpdBaw+kDNqoQt
KLYKP5PT7zPOBpzVqmCVZfPFIHSNFN7U9zJE+4FvgeODst3Mqq247tf/Ab21C9hs
gAyvuZXXal3nWQ3qzyIUFXgNH3btFaAvw4ZOuANmCgQvudJt16N8zFaQTrWZUCw8
+kgSxpNG+6kxAu4tL5TW8lA+iU1jVerTqLcU7YpsZs6/c6Aa1fTAidKw1EUI4Dnn
sqB8pJR9BrFVk2W51w6UyiVvJ6a/f2aWV2cebH3USJopLNLjOPDLU6JDSsdlSPWJ
BHtc+5CJ3and6bbYuVwEW1t0W51D65Ut+2X2llkgb7HZWIuJt7VdM04C8odrnW2p
MEpwQsqTD0aD4kmUgRx5Ik68ZnQSxzqlaBtPbXxyx7bLf2W+hvI=
=9dJA
-----END PGP SIGNATURE-----

--dpe6emt6fnfplnwi--

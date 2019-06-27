Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CAB589EC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfF0S1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 14:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfF0S1a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 14:27:30 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3787120644;
        Thu, 27 Jun 2019 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561660048;
        bh=Tpb/DLnQ8C0e2yxhxaI2QTRSeo2WY4uDlzfbr/MJ9Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHwG7YuqJAqey6Qnea4m24wtV4/P6oXIG1jtQVm/790hez1y/SkwNMSvk+hERz+Ef
         6P0UdYsMt92rpAENehc18IjVHaGLBiGuo6eWpuClnUYkOKqChIu6JAgt0QhUkG581n
         O715hQD3lhKpvzMfOqJ2xmYVlSVwDRTD6rdxqM0A=
Received: by earth.universe (Postfix, from userid 1000)
        id C54BA3C08D5; Thu, 27 Jun 2019 20:27:25 +0200 (CEST)
Date:   Thu, 27 Jun 2019 20:27:25 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] power: supply: Add HWMON compatibility layer
Message-ID: <20190627182725.v3mgmy35fxoogofe@earth.universe>
References: <20190612084404.21685-1-andrew.smirnov@gmail.com>
 <20190612084404.21685-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxucwlb3kkc42yoi"
Content-Disposition: inline
In-Reply-To: <20190612084404.21685-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sxucwlb3kkc42yoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2019 at 01:44:04AM -0700, Andrey Smirnov wrote:
> Add code implementing HWMON adapter/compatibility layer to allow
> expositing various sensors present on power supply devices via HWMON
> subsystem. This is done in order to allow userspace to use single
> ABI/library(libsensors) to access/manipulate all of the sensors of the
> system.
>=20
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Chris Healy <cphealy@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/Kconfig              |  14 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/power_supply_core.c  |   7 +
>  drivers/power/supply/power_supply_hwmon.c | 355 ++++++++++++++++++++++
>  include/linux/power_supply.h              |  13 +
>  5 files changed, 390 insertions(+)
>  create mode 100644 drivers/power/supply/power_supply_hwmon.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c614c8a196f3..0550cedb53c9 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -14,6 +14,20 @@ config POWER_SUPPLY_DEBUG
>  	  Say Y here to enable debugging messages for power supply class
>  	  and drivers.
> =20
> +config POWER_SUPPLY_HWMON
> +	bool
> +	prompt "Expose power supply sensors as hwmon device"
> +	depends on HWMON=3Dy || HWMON=3DPOWER_SUPPLY
> +	default y
> +	help
> +	  This options enables API that allows sensors found on a
> +	  power supply device (current, voltage, temperature) to be
> +	  exposed as a hwmon device.
> +
> +	  Say 'Y' here if you want power supplies to
> +	  have hwmon sysfs interface too.
> +
> +
>  config PDA_POWER
>  	tristate "Generic PDA/phone power driver"
>  	depends on !S390
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index c56803a9e4fe..0a87cfe49b21 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -6,6 +6,7 @@ power_supply-$(CONFIG_SYSFS)		+=3D power_supply_sysfs.o
>  power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_leds.o
> =20
>  obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
> +obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
>  obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
> =20
>  obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index c917a8b43b2b..67e78538bb9c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1062,6 +1062,10 @@ __power_supply_register(struct device *parent,
>  	if (rc)
>  		goto create_triggers_failed;
> =20
> +	rc =3D power_supply_add_hwmon_sysfs(psy);
> +	if (rc)
> +		goto add_hwmon_sysfs_failed;
> +
>  	/*
>  	 * Update use_cnt after any uevents (most notably from device_add()).
>  	 * We are here still during driver's probe but
> @@ -1080,6 +1084,8 @@ __power_supply_register(struct device *parent,
> =20
>  	return psy;
> =20
> +add_hwmon_sysfs_failed:
> +	power_supply_remove_triggers(psy);
>  create_triggers_failed:
>  	psy_unregister_cooler(psy);
>  register_cooler_failed:
> @@ -1232,6 +1238,7 @@ void power_supply_unregister(struct power_supply *p=
sy)
>  	cancel_work_sync(&psy->changed_work);
>  	cancel_delayed_work_sync(&psy->deferred_register_work);
>  	sysfs_remove_link(&psy->dev.kobj, "powers");
> +	power_supply_remove_hwmon_sysfs(psy);
>  	power_supply_remove_triggers(psy);
>  	psy_unregister_cooler(psy);
>  	psy_unregister_thermal(psy);
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> new file mode 100644
> index 000000000000..51fe60440d12
> --- /dev/null
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  power_supply_hwmon.c - power supply hwmon support.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +
> +struct power_supply_hwmon {
> +	struct power_supply *psy;
> +	unsigned long *props;
> +};
> +
> +static int power_supply_hwmon_in_to_property(u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_in_average:
> +		return POWER_SUPPLY_PROP_VOLTAGE_AVG;
> +	case hwmon_in_min:
> +		return POWER_SUPPLY_PROP_VOLTAGE_MIN;
> +	case hwmon_in_max:
> +		return POWER_SUPPLY_PROP_VOLTAGE_MAX;
> +	case hwmon_in_input:
> +		return POWER_SUPPLY_PROP_VOLTAGE_NOW;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int power_supply_hwmon_curr_to_property(u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_curr_average:
> +		return POWER_SUPPLY_PROP_CURRENT_AVG;
> +	case hwmon_curr_max:
> +		return POWER_SUPPLY_PROP_CURRENT_MAX;
> +	case hwmon_curr_input:
> +		return POWER_SUPPLY_PROP_CURRENT_NOW;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> +{
> +	if (channel) {
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT;
> +		case hwmon_temp_min_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN;
> +		case hwmon_temp_max_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX;
> +		default:
> +			break;
> +		}
> +	} else {
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return POWER_SUPPLY_PROP_TEMP;
> +		case hwmon_temp_max:
> +			return POWER_SUPPLY_PROP_TEMP_MAX;
> +		case hwmon_temp_min:
> +			return POWER_SUPPLY_PROP_TEMP_MIN;
> +		case hwmon_temp_min_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_ALERT_MIN;
> +		case hwmon_temp_max_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_ALERT_MAX;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +power_supply_hwmon_to_property(enum hwmon_sensor_types type,
> +			       u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return power_supply_hwmon_in_to_property(attr);
> +	case hwmon_curr:
> +		return power_supply_hwmon_curr_to_property(attr);
> +	case hwmon_temp:
> +		return power_supply_hwmon_temp_to_property(attr, channel);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
> +					   u32 attr)
> +{
> +	return type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_label;
> +}
> +
> +static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
> +					   u32 attr)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return attr =3D=3D hwmon_in_min ||
> +		       attr =3D=3D hwmon_in_max;
> +	case hwmon_curr:
> +		return attr =3D=3D hwmon_curr_max;
> +	case hwmon_temp:
> +		return attr =3D=3D hwmon_temp_max ||
> +		       attr =3D=3D hwmon_temp_min ||
> +		       attr =3D=3D hwmon_temp_min_alarm ||
> +		       attr =3D=3D hwmon_temp_max_alarm;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static umode_t power_supply_hwmon_is_visible(const void *data,
> +					     enum hwmon_sensor_types type,
> +					     u32 attr, int channel)
> +{
> +	const struct power_supply_hwmon *psyhw =3D data;
> +	int prop;
> +
> +
> +	if (power_supply_hwmon_is_a_label(type, attr))
> +		return 0444;
> +
> +	prop =3D power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0 || !test_bit(prop, psyhw->props))
> +		return 0;
> +
> +	if (power_supply_property_is_writeable(psyhw->psy, prop) > 0 &&
> +	    power_supply_hwmon_is_writable(type, attr))
> +		return 0644;
> +
> +	return 0444;
> +}
> +
> +static int power_supply_hwmon_read_string(struct device *dev,
> +					  enum hwmon_sensor_types type,
> +					  u32 attr, int channel,
> +					  const char **str)
> +{
> +	*str =3D channel ? "temp" : "temp ambient";
> +	return 0;
> +}
> +
> +static int
> +power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct power_supply_hwmon *psyhw =3D dev_get_drvdata(dev);
> +	struct power_supply *psy =3D psyhw->psy;
> +	union power_supply_propval pspval;
> +	int ret, prop;
> +
> +	prop =3D power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0)
> +		return prop;
> +
> +	ret  =3D power_supply_get_property(psy, prop, &pspval);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	/*
> +	 * Both voltage and current is reported in units of
> +	 * microvolts/microamps, so we need to adjust it to
> +	 * milliamps(volts)
> +	 */
> +	case hwmon_curr:
> +	case hwmon_in:
> +		pspval.intval =3D DIV_ROUND_CLOSEST(pspval.intval, 1000);
> +		break;
> +	/*
> +	 * Temp needs to be converted from 1/10 C to milli-C
> +	 */
> +	case hwmon_temp:
> +		if (check_mul_overflow(pspval.intval, 100,
> +				       &pspval.intval))
> +			return -EOVERFLOW;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*val =3D pspval.intval;
> +
> +	return 0;
> +}
> +
> +static int
> +power_supply_hwmon_write(struct device *dev, enum hwmon_sensor_types typ=
e,
> +			 u32 attr, int channel, long val)
> +{
> +	struct power_supply_hwmon *psyhw =3D dev_get_drvdata(dev);
> +	struct power_supply *psy =3D psyhw->psy;
> +	union power_supply_propval pspval;
> +	int prop;
> +
> +	prop =3D power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0)
> +		return prop;
> +
> +	pspval.intval =3D val;
> +
> +	switch (type) {
> +	/*
> +	 * Both voltage and current is reported in units of
> +	 * microvolts/microamps, so we need to adjust it to
> +	 * milliamps(volts)
> +	 */
> +	case hwmon_curr:
> +	case hwmon_in:
> +		if (check_mul_overflow(pspval.intval, 1000,
> +				       &pspval.intval))
> +			return -EOVERFLOW;
> +		break;
> +	/*
> +	 * Temp needs to be converted from 1/10 C to milli-C
> +	 */
> +	case hwmon_temp:
> +		pspval.intval =3D DIV_ROUND_CLOSEST(pspval.intval, 100);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return power_supply_set_property(psy, prop, &pspval);
> +}
> +
> +static const struct hwmon_ops power_supply_hwmon_ops =3D {
> +	.is_visible	=3D power_supply_hwmon_is_visible,
> +	.read		=3D power_supply_hwmon_read,
> +	.write		=3D power_supply_hwmon_write,
> +	.read_string	=3D power_supply_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *power_supply_hwmon_info[] =3D {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_INPUT     |
> +			   HWMON_T_MAX       |
> +			   HWMON_T_MIN       |
> +			   HWMON_T_MIN_ALARM |
> +			   HWMON_T_MIN_ALARM,
> +
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_INPUT     |
> +			   HWMON_T_MIN_ALARM |
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_MAX_ALARM),
> +
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_AVERAGE |
> +			   HWMON_C_MAX     |
> +			   HWMON_C_INPUT),
> +
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_AVERAGE |
> +			   HWMON_I_MIN     |
> +			   HWMON_I_MAX     |
> +			   HWMON_I_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info power_supply_hwmon_chip_info =3D {
> +	.ops =3D &power_supply_hwmon_ops,
> +	.info =3D power_supply_hwmon_info,
> +};
> +
> +static void power_supply_hwmon_bitmap_free(void *data)
> +{
> +	bitmap_free(data);
> +}
> +
> +int power_supply_add_hwmon_sysfs(struct power_supply *psy)
> +{
> +	const struct power_supply_desc *desc =3D psy->desc;
> +	struct power_supply_hwmon *psyhw;
> +	struct device *dev =3D &psy->dev;
> +	struct device *hwmon;
> +	int ret, i;
> +
> +	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
> +			       GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	psyhw =3D devm_kzalloc(dev, sizeof(*psyhw), GFP_KERNEL);
> +	if (!psyhw) {
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	psyhw->psy =3D psy;
> +	psyhw->props =3D bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
> +				     GFP_KERNEL);
> +	if (!psyhw->props) {
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret =3D devm_add_action(dev, power_supply_hwmon_bitmap_free,
> +			      psyhw->props);
> +	if (ret)
> +		goto error;
> +
> +	for (i =3D 0; i < desc->num_properties; i++) {
> +		const enum power_supply_property prop =3D desc->properties[i];
> +
> +		switch (prop) {
> +		case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		case POWER_SUPPLY_PROP_TEMP:
> +		case POWER_SUPPLY_PROP_TEMP_MAX:
> +		case POWER_SUPPLY_PROP_TEMP_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +			set_bit(prop, psyhw->props);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	hwmon =3D devm_hwmon_device_register_with_info(dev, psy->desc->name,
> +						psyhw,
> +						&power_supply_hwmon_chip_info,
> +						NULL);
> +	ret =3D PTR_ERR_OR_ZERO(hwmon);
> +	if (ret)
> +		goto error;
> +
> +	devres_close_group(dev, power_supply_add_hwmon_sysfs);
> +	return 0;
> +error:
> +	devres_release_group(dev, NULL);
> +	return ret;
> +}
> +
> +void power_supply_remove_hwmon_sysfs(struct power_supply *psy)
> +{
> +	devres_release_group(&psy->dev, power_supply_add_hwmon_sysfs);
> +}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index bdab14c7ca4d..f850d4110935 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -475,4 +475,17 @@ static inline bool power_supply_is_watt_property(enu=
m power_supply_property psp)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_POWER_SUPPLY_HWMON
> +int power_supply_add_hwmon_sysfs(struct power_supply *psy);
> +void power_supply_remove_hwmon_sysfs(struct power_supply *psy);
> +#else
> +static inline int power_supply_add_hwmon_sysfs(struct power_supply *psy)
> +{
> +	return 0;
> +}
> +
> +static inline
> +void power_supply_remove_hwmon_sysfs(struct power_supply *psy) {}
> +#endif
> +
>  #endif /* __LINUX_POWER_SUPPLY_H__ */
> --=20
> 2.21.0
>=20

--sxucwlb3kkc42yoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0VCo0ACgkQ2O7X88g7
+pp0cQ//QvMJZwidClEwt1HmP3LlZDraLKAo37xYUCcD8d2Zh00dVFNMJY3Utqps
nlbX6hS2gpuD+fZ9akMRmM5F121xf6xuydhosTi4xtjEgkJqE+uIEjAZK/s7MISU
+Yx1Y8uAG0eWWdfgPMeNPL0UMixPxeqq+0VQhsAec7a4k4CPbR07mwTJqGXD5ggJ
ewjLSb2yrb9yh2NXWPIZ4BzUE0R6vRA9X0loovSAtSTsEDnEiY1Bv22LpForQnUE
I2vzny1qn03x7Sc+MKynHA0Gw16UqkiXLsK5w3GKAmu5kAuqQqa++lCsCMBswO94
GfRZNd7WEbw0H0TZXYmB9kdEK9eZOwaHWkPuMDtzhV7CpDpfPtntP7jQE5zgZJno
lubbnZr5bK51XnQAzDH1DKkdvwuiseU/Xhrgx9XI1rWS05wyuZ4yWEIVT7SoObcS
LohGZdLc9y8DM2xVEw75NuB/N+eSfCLZLuvO7+EMIXNwbplge6amqipqrm7xkPLu
p1n79zknek7A5of+fZMBjWAfblkN1dfuE4GzX/GbrLlLxTzdsoMzfRdT0ub5Z/nh
BD4+Ly94KLT1agftjWid27B6J25QvQ2N/NZilfl15ZiEkQCBL2TpKvcmE+9KpmvE
PNy5t1CmSfzfHYcWM3k1K9s/5Uq0VYxMjHHUm00eHN4NhtiXNs0=
=ercd
-----END PGP SIGNATURE-----

--sxucwlb3kkc42yoi--

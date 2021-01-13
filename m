Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756292F5832
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 04:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhANCPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 21:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbhAMVVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 16:21:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2CBC061575;
        Wed, 13 Jan 2021 13:20:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A7BE41F450C7
Received: by earth.universe (Postfix, from userid 1000)
        id D41A73C0C94; Wed, 13 Jan 2021 22:20:23 +0100 (CET)
Date:   Wed, 13 Jan 2021 22:20:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 5/7] power: reset: Add poweroff driver for ATC260x
 PMICs
Message-ID: <20210113212023.5pqk5dlzs4qd6xat@earth.universe>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
 <466a2ad571343fdcb3061af6996091a787c9568e.1610534765.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="myf3sar6iguaxnb7"
Content-Disposition: inline
In-Reply-To: <466a2ad571343fdcb3061af6996091a787c9568e.1610534765.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--myf3sar6iguaxnb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 13, 2021 at 01:05:55PM +0200, Cristian Ciocaltea wrote:
> This driver provides poweroff and reboot support for a system through
> the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> family of PMICs.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

> Changes in v5:
>  - Drop unneeded '#include <linux/of.h>'
>=20
> Changes in v4:
>  - None
>=20
> Changes in v3:
>  - Removed the unnecessary driver compatibles
>=20
>  drivers/power/reset/Kconfig            |   8 +-
>  drivers/power/reset/Makefile           |   1 +
>  drivers/power/reset/atc260x-poweroff.c | 262 +++++++++++++++++++++++++
>  3 files changed, 270 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/power/reset/atc260x-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index b22c4fdb2561..1737e227b16e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -39,6 +39,13 @@ config POWER_RESET_AT91_SAMA5D2_SHDWC
>  	  This driver supports the alternate shutdown controller for some Atmel
>  	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
> =20
> +config POWER_RESET_ATC260X
> +	tristate "Actions Semi ATC260x PMIC power-off driver"
> +	depends on MFD_ATC260X
> +	help
> +	  This driver provides power-off and restart support for a system
> +	  through Actions Semi ATC260x series PMICs.
> +
>  config POWER_RESET_AXXIA
>  	bool "LSI Axxia reset driver"
>  	depends on ARCH_AXXIA
> @@ -292,4 +299,3 @@ config NVMEM_REBOOT_MODE
>  	  action according to the mode.
> =20
>  endif
> -
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 9dc49d3a57ff..b4601c0a96ed 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) +=3D as3722-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) +=3D at91-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_RESET) +=3D at91-reset.o
>  obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) +=3D at91-sama5d2_shdwc.o
> +obj-$(CONFIG_POWER_RESET_ATC260X) +=3D atc260x-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AXXIA) +=3D axxia-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMKONA) +=3D brcm-kona-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMSTB) +=3D brcmstb-reboot.o
> diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset=
/atc260x-poweroff.c
> new file mode 100644
> index 000000000000..98f20251a6d1
> --- /dev/null
> +++ b/drivers/power/reset/atc260x-poweroff.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Poweroff & reset driver for Actions Semi ATC260x PMICs
> + *
> + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +
> +struct atc260x_pwrc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct notifier_block restart_nb;
> +	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
> +};
> +
> +/* Global variable needed only for pm_power_off */
> +static struct atc260x_pwrc *atc260x_pwrc_data;
> +
> +static int atc2603c_do_poweroff(const struct atc260x_pwrc *pwrc, bool re=
start)
> +{
> +	int ret, deep_sleep =3D 0;
> +	uint reg_mask, reg_val;
> +
> +	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
> +	if (!restart && !power_supply_is_system_supplied()) {
> +		deep_sleep =3D 1;
> +		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
> +	}
> +
> +	/* Update wakeup sources */
> +	reg_val =3D ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
> +		  (restart ? ATC2603C_PMU_SYS_CTL0_RESET_WK_EN
> +			   : ATC2603C_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
> +
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
> +				 ATC2603C_PMU_SYS_CTL0_WK_ALL, reg_val);
> +	if (ret)
> +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> +
> +	/* Update power mode */
> +	reg_mask =3D ATC2603C_PMU_SYS_CTL3_EN_S2 | ATC2603C_PMU_SYS_CTL3_EN_S3;
> +
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3, reg_mas=
k,
> +				 deep_sleep ? 0 : ATC2603C_PMU_SYS_CTL3_EN_S3);
> +	if (ret) {
> +		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Trigger poweroff / restart sequence */
> +	reg_mask =3D restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN
> +			   : ATC2603C_PMU_SYS_CTL1_EN_S1;
> +	reg_val =3D restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN : 0;
> +
> +	ret =3D regmap_update_bits(pwrc->regmap,
> +				 restart ? ATC2603C_PMU_SYS_CTL0 : ATC2603C_PMU_SYS_CTL1,
> +				 reg_mask, reg_val);
> +	if (ret) {
> +		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
> +			restart ? 0 : 1, ret);
> +		return ret;
> +	}
> +
> +	/* Wait for trigger completion */
> +	mdelay(200);
> +
> +	return 0;
> +}
> +
> +static int atc2609a_do_poweroff(const struct atc260x_pwrc *pwrc, bool re=
start)
> +{
> +	int ret, deep_sleep =3D 0;
> +	uint reg_mask, reg_val;
> +
> +	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
> +	if (!restart && !power_supply_is_system_supplied()) {
> +		deep_sleep =3D 1;
> +		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
> +	}
> +
> +	/* Update wakeup sources */
> +	reg_val =3D ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
> +		  (restart ? ATC2609A_PMU_SYS_CTL0_RESET_WK_EN
> +			   : ATC2609A_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
> +
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
> +				 ATC2609A_PMU_SYS_CTL0_WK_ALL, reg_val);
> +	if (ret)
> +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> +
> +	/* Update power mode */
> +	reg_mask =3D ATC2609A_PMU_SYS_CTL3_EN_S2 | ATC2609A_PMU_SYS_CTL3_EN_S3;
> +
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL3, reg_mas=
k,
> +				 deep_sleep ? 0 : ATC2609A_PMU_SYS_CTL3_EN_S3);
> +	if (ret) {
> +		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Trigger poweroff / restart sequence */
> +	reg_mask =3D restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN
> +			   : ATC2609A_PMU_SYS_CTL1_EN_S1;
> +	reg_val =3D restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN : 0;
> +
> +	ret =3D regmap_update_bits(pwrc->regmap,
> +				 restart ? ATC2609A_PMU_SYS_CTL0 : ATC2609A_PMU_SYS_CTL1,
> +				 reg_mask, reg_val);
> +	if (ret) {
> +		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
> +			restart ? 0 : 1, ret);
> +		return ret;
> +	}
> +
> +	/* Wait for trigger completion */
> +	mdelay(200);
> +
> +	return 0;
> +}
> +
> +static int atc2603c_init(const struct atc260x_pwrc *pwrc)
> +{
> +	int ret;
> +
> +	/*
> +	 * Delay transition from S2/S3 to S1 in order to avoid
> +	 * DDR init failure in Bootloader.
> +	 */
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3,
> +				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN,
> +				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN);
> +	if (ret)
> +		dev_warn(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> +
> +	/* Set wakeup sources */
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
> +				 ATC2603C_PMU_SYS_CTL0_WK_ALL,
> +				 ATC2603C_PMU_SYS_CTL0_HDSW_WK_EN |
> +				 ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
> +	if (ret)
> +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int atc2609a_init(const struct atc260x_pwrc *pwrc)
> +{
> +	int ret;
> +
> +	/* Set wakeup sources */
> +	ret =3D regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
> +				 ATC2609A_PMU_SYS_CTL0_WK_ALL,
> +				 ATC2609A_PMU_SYS_CTL0_HDSW_WK_EN |
> +				 ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
> +	if (ret)
> +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void atc260x_pwrc_pm_handler(void)
> +{
> +	atc260x_pwrc_data->do_poweroff(atc260x_pwrc_data, false);
> +
> +	WARN_ONCE(1, "Unable to power off system\n");
> +}
> +
> +static int atc260x_pwrc_restart_handler(struct notifier_block *nb,
> +					unsigned long mode, void *cmd)
> +{
> +	struct atc260x_pwrc *pwrc =3D container_of(nb, struct atc260x_pwrc,
> +						 restart_nb);
> +	pwrc->do_poweroff(pwrc, true);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int atc260x_pwrc_probe(struct platform_device *pdev)
> +{
> +	struct atc260x *atc260x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct atc260x_pwrc *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D &pdev->dev;
> +	priv->regmap =3D atc260x->regmap;
> +	priv->restart_nb.notifier_call =3D atc260x_pwrc_restart_handler;
> +	priv->restart_nb.priority =3D 192;
> +
> +	switch (atc260x->ic_type) {
> +	case ATC2603C:
> +		priv->do_poweroff =3D atc2603c_do_poweroff;
> +		ret =3D atc2603c_init(priv);
> +		break;
> +	case ATC2609A:
> +		priv->do_poweroff =3D atc2609a_do_poweroff;
> +		ret =3D atc2609a_init(priv);
> +		break;
> +	default:
> +		dev_err(priv->dev,
> +			"Poweroff not supported for ATC260x PMIC type: %u\n",
> +			atc260x->ic_type);
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (!pm_power_off) {
> +		atc260x_pwrc_data =3D priv;
> +		pm_power_off =3D atc260x_pwrc_pm_handler;
> +	} else {
> +		dev_warn(priv->dev, "Poweroff callback already assigned\n");
> +	}
> +
> +	ret =3D register_restart_handler(&priv->restart_nb);
> +	if (ret)
> +		dev_err(priv->dev, "failed to register restart handler: %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int atc260x_pwrc_remove(struct platform_device *pdev)
> +{
> +	struct atc260x_pwrc *priv =3D platform_get_drvdata(pdev);
> +
> +	if (atc260x_pwrc_data =3D=3D priv) {
> +		pm_power_off =3D NULL;
> +		atc260x_pwrc_data =3D NULL;
> +	}
> +
> +	unregister_restart_handler(&priv->restart_nb);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver atc260x_pwrc_driver =3D {
> +	.probe =3D atc260x_pwrc_probe,
> +	.remove =3D atc260x_pwrc_remove,
> +	.driver =3D {
> +		.name =3D "atc260x-pwrc",
> +	},
> +};
> +
> +module_platform_driver(atc260x_pwrc_driver);
> +
> +MODULE_DESCRIPTION("Poweroff & reset driver for ATC260x PMICs");
> +MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.30.0
>=20

--myf3sar6iguaxnb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl//ZBcACgkQ2O7X88g7
+prL/A//cMPbifHzEcQqrm7+8mQmURrRtgQUKY1kVr8fVAaD4fE+i2FrlUKQeZf1
MaO950sxS4A5Yy69FMdicS7MHN/N+qiUsnLWtfe9GFlT5FzB82Qig/Bh5q4QzyAt
5/cgcTZDv2wHpAoj/tdAogiDlRQ0G3fdCUKxXVTcfwivrvQaUOfZ3QeRhRkEhBUE
eyDAqrJdiviX75N2v6JJ1ONYHUeomKUlIYGNo2+dpT55NG0ysdOFRfWO2gN8QcEQ
hIrqK/aDQtV9YO52W52I0iI17LfSnsxIUUuW3fUWSFnk+Bk21aDZO4LXAHkZfqfX
WPHa5r/oQGfvztfOv6Osjqx9RqRYRDbTCIghnKxRqon6d9SZ5xYxselO6YcQMcCV
wRf325Z9q2sc/BIx++xggre/xqvX8dQ8hw9jldDLMPRk/amR+nMP58HE4utMl5o0
qSHstbJXVl+hTDGbpKaeZYCVEd3vUddlUior6qR+LpW50nA1rIsAS8Ewq/RHG327
48je5uAcaPCgRFJhTpQhMpx7EH5M3tpGeaU+3E28sv2LTOtXryMKFJPTXVuFx39y
snGgWBIevQu4XtoDIGNzLjwtSGmH7GRp5YqdS/SCIRvkYZqQWd3ikbmtZ+FxFTNe
QvtsViE2M+GrL/ds+UAFV/9St5u4QPl3M5aj9XEg45/YzazWAiU=
=NlC6
-----END PGP SIGNATURE-----

--myf3sar6iguaxnb7--

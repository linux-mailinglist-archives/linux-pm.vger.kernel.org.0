Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19F9A4BB0
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfIAUMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 16:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIAUL7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Sep 2019 16:11:59 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C1C2190F;
        Sun,  1 Sep 2019 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567368718;
        bh=QlXmttwlCxH6Ab1wpfZuCW03XfOrxXj8aSMRY6GQGDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKp9+xURL8QcWlqaaha3B2ZJxAdbGf1M77IcuYDPcynjHWF8f8r75/RrjEWoQLP8m
         LK5BSrw2z1Vx764ZH4Qs/410jviGTL6alEJ7KCDVL0ykaRwEWfSoIxVPkTitGdtvYV
         XaVQXzRcXi0bq96OzfWYx5UevM9bV8dP/ldB9w0s=
Received: by earth.universe (Postfix, from userid 1000)
        id 7741D3C0B7F; Sun,  1 Sep 2019 22:11:55 +0200 (CEST)
Date:   Sun, 1 Sep 2019 22:11:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>, linux-pm@vger.kernel.org,
        Josef Friedl <josef.friedl@speed.at>,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 11/13] power: reset: add driver for mt6323 poweroff
Message-ID: <20190901201155.dyaxncuixq7vvdbh@earth.universe>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-12-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hahqm2gkodncklw"
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-12-frank-w@public-files.de>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3hahqm2gkodncklw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 18, 2019 at 03:56:09PM +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
>=20
> add poweroff driver for mt6323 and make Makefile and Kconfig-Entries
>=20
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: split out mfd/mt6397/core.h
> changes since v4: none
> changes since v3: none
> changes since v2: none (=3Dv2 part 5)
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/Kconfig           | 10 +++
>  drivers/power/reset/Makefile          |  1 +
>  drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/power/reset/mt6323-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a564237278ff..c721939767eb 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -140,6 +140,16 @@ config POWER_RESET_LTC2952
>  	  This driver supports an external powerdown trigger and board power
>  	  down via the LTC2952. Bindings are made in the device tree.
> =20
> +config POWER_RESET_MT6323
> +       bool "MediaTek MT6323 power-off driver"
> +       depends on MFD_MT6397
> +       help
> +         The power-off driver is responsible for externally shutdown down
> +         the power of a remote MediaTek SoC MT6323 is connected to throu=
gh
> +         controlling a tiny circuit BBPU inside MT6323 RTC.
> +
> +         Say Y if you have a board where MT6323 could be found.
> +
>  config POWER_RESET_QNAP
>  	bool "QNAP power-off driver"
>  	depends on OF_GPIO && PLAT_ORION
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 85da3198e4e0..da37f8b851dc 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/=
mt6323-poweroff.c
> new file mode 100644
> index 000000000000..1caf43d9e46d
> --- /dev/null
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Power off through MediaTek PMIC
> + *
> + * Copyright (C) 2018 MediaTek Inc.
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/rtc.h>
> +
> +struct mt6323_pwrc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 base;
> +};
> +
> +static struct mt6323_pwrc *mt_pwrc;
> +
> +static void mt6323_do_pwroff(void)
> +{
> +	struct mt6323_pwrc *pwrc =3D mt_pwrc;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +
> +	ret =3D regmap_read_poll_timeout(pwrc->regmap,
> +					pwrc->base + RTC_BBPU, val,
> +					!(val & RTC_BBPU_CBUSY),
> +					MTK_RTC_POLL_DELAY_US,
> +					MTK_RTC_POLL_TIMEOUT);
> +	if (ret)
> +		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
> +
> +	/* Wait some time until system down, otherwise, notice with a warn */
> +	mdelay(1000);
> +
> +	WARN_ONCE(1, "Unable to power off system\n");
> +}
> +
> +static int mt6323_pwrc_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6397_chip =3D dev_get_drvdata(pdev->dev.parent);
> +	struct mt6323_pwrc *pwrc;
> +	struct resource *res;
> +
> +	pwrc =3D devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> +	if (!pwrc)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwrc->base =3D res->start;
> +	pwrc->regmap =3D mt6397_chip->regmap;
> +	pwrc->dev =3D &pdev->dev;
> +	mt_pwrc =3D pwrc;
> +
> +	pm_power_off =3D &mt6323_do_pwroff;
> +
> +	return 0;
> +}
> +
> +static int mt6323_pwrc_remove(struct platform_device *pdev)
> +{
> +	if (pm_power_off =3D=3D &mt6323_do_pwroff)
> +		pm_power_off =3D NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt6323_pwrc_dt_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6323-pwrc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
> +
> +static struct platform_driver mt6323_pwrc_driver =3D {
> +	.probe          =3D mt6323_pwrc_probe,
> +	.remove         =3D mt6323_pwrc_remove,
> +	.driver         =3D {
> +		.name   =3D "mt6323-pwrc",
> +		.of_match_table =3D mt6323_pwrc_dt_match,
> +	},
> +};
> +
> +module_platform_driver(mt6323_pwrc_driver);
> +
> +MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--3hahqm2gkodncklw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1sJgcACgkQ2O7X88g7
+ppiQw/+LtS6wsjmh6ARgHlsOn/nsSf21K7xA0uk3UPYy7muMYmP6wsTQ5cRqjK2
W1XrHqKmlSknV0QKhOC9CGxqy5y61hiECNUYF6iXKMOIdx4k7u4hlfRQoAAOw5Ya
97lFTQvD4Obi7Fp8l+zaNmbfYSIEL6Ah2MHH+ol9RBTRxnY1esdIOpcuyuOJfir4
LIYeJv+/oBF+xqixgomZKOHh8Xw1xq6yJQgxAs6LBoawvE6v2S+er1GgmKR/t6r4
fEYOTH2dlN51bHqSBs5mhyUik/LCW+RdOnpKA+H7A1vogxWoyLqhU0sFrvbCsTAD
o7GSFWFwN+26XZ8vwFn0q8D/1YSXebCtLdU73fGik3+jo1bGylR49dzq4bBUZAnT
jo4AQvYCdhPkysuS0qelA7NeiVbcnAuv8wUA2Pdq7uDbomGNRSMMgKATHGMaPIXN
MhUsgLiet8tdJ7ywcf/MYB4yp98OeFsvBQmJ+PQqFp0896FAvaJrRVIfja9uKWvc
dPgJDF1ZZRj6h3R1K+IogGroroj/gexcftWbCS2k8u8Euj7A2yYxqxJ33dlkdmyh
1NFZXaR5fy4X9VyYMKrEzT+hvr0nbjdSdaHbng0IzV4x6GLWxatC5Q/QknHJGhx5
deKN8AEX3jCS4JJBxsLILjEpyc+T0CijPJTTveQDzhAN8WMGPBM=
=gn38
-----END PGP SIGNATURE-----

--3hahqm2gkodncklw--

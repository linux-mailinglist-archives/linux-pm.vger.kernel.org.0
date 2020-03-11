Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80E1824C7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 23:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgCKWYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 18:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWYz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 18:24:55 -0400
Received: from jupiter.universe (dyndsl-037-138-186-138.ewe-ip-backbone.de [37.138.186.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4904820575;
        Wed, 11 Mar 2020 22:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583965494;
        bh=UZudGW4ntWR2WDjFg7rUyYyM4uljMpWCzCsi4J+ORvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfGX/r286WMLdJy5TKyVTTLMx6xyzdGvb1b0jKt8PBaYqHqLf+JvTFGPC9iB6rcxK
         sLrugxbZURjcvYnT7DmgWKnw+/NSDwe+QkcNCSlHXH89QgTBay2LsWf1FCHihdRlhf
         e5wgd8i82/7gEPDbFUU7lRaAnJx1O3gj8l8OlSEs=
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8F7CB4800FC; Wed, 11 Mar 2020 23:24:52 +0100 (CET)
Date:   Wed, 11 Mar 2020 23:24:52 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v10 4/5] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200311222452.nxeajmbbpidbwyal@jupiter.universe>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2zavgzncyp2cq5o"
Content-Disposition: inline
In-Reply-To: <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h2zavgzncyp2cq5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 11, 2020 at 05:17:02PM +0800, Hsin-Hsiung Wang wrote:
> From: Ran Bi <ran.bi@mediatek.com>
>=20
> This add support for the MediaTek MT6358 RTC. Driver using
> compatible data to store different RTC_WRTGR address offset.
> This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> driver which only needed by armv7 CPU without ATF.
>=20
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---

Should be fine to simply merge this through RTC:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/mt6323-poweroff.c |  2 +-
>  drivers/rtc/rtc-mt6397.c              | 32 ++++++++++++++++++++++++-----=
---
>  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
>  3 files changed, 33 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/=
mt6323-poweroff.c
> index 1caf43d..0532803 100644
> --- a/drivers/power/reset/mt6323-poweroff.c
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -30,7 +30,7 @@ static void mt6323_do_pwroff(void)
>  	int ret;
> =20
>  	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> -	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR_MT6323, 1);
> =20
>  	ret =3D regmap_read_poll_timeout(pwrc->regmap,
>  					pwrc->base + RTC_BBPU, val,
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index cda238d..7a5a9e2 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,18 +9,38 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
>  #include <linux/mfd/mt6397/rtc.h>
>  #include <linux/mod_devicetable.h>
> =20
> +static const struct mtk_rtc_data mt6358_rtc_data =3D {
> +	.wrtgr =3D RTC_WRTGR_MT6358,
> +};
> +
> +static const struct mtk_rtc_data mt6397_rtc_data =3D {
> +	.wrtgr =3D RTC_WRTGR_MT6397,
> +};
> +
> +static const struct of_device_id mt6397_rtc_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6323-rtc",
> +		.data =3D (void *)&mt6397_rtc_data, },
> +	{ .compatible =3D "mediatek,mt6358-rtc",
> +		.data =3D (void *)&mt6358_rtc_data, },
> +	{ .compatible =3D "mediatek,mt6397-rtc",
> +		.data =3D (void *)&mt6397_rtc_data, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
> +
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  {
>  	int ret;
>  	u32 data;
> =20
> -	ret =3D regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	ret =3D regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -269,6 +289,9 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->addr_base =3D res->start;
> =20
> +	rtc->data =3D (struct mtk_rtc_data *)
> +			of_device_get_match_data(&pdev->dev);
> +
>  	rtc->irq =3D platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0)
>  		return rtc->irq;
> @@ -325,13 +348,6 @@ static int mt6397_rtc_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>  			mt6397_rtc_resume);
> =20
> -static const struct of_device_id mt6397_rtc_of_match[] =3D {
> -	{ .compatible =3D "mediatek,mt6323-rtc", },
> -	{ .compatible =3D "mediatek,mt6397-rtc", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
> -
>  static struct platform_driver mtk_rtc_driver =3D {
>  	.driver =3D {
>  		.name =3D "mt6397-rtc",
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rt=
c.h
> index 7dfb63b..66534ed 100644
> --- a/include/linux/mfd/mt6397/rtc.h
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -18,7 +18,9 @@
>  #define RTC_BBPU_CBUSY         BIT(6)
>  #define RTC_BBPU_KEY            (0x43 << 8)
> =20
> -#define RTC_WRTGR              0x003c
> +#define RTC_WRTGR_MT6358       0x3a
> +#define RTC_WRTGR_MT6397       0x3c
> +#define RTC_WRTGR_MT6323       RTC_WRTGR_MT6397
> =20
>  #define RTC_IRQ_STA            0x0002
>  #define RTC_IRQ_STA_AL         BIT(0)
> @@ -65,6 +67,10 @@
>  #define MTK_RTC_POLL_DELAY_US  10
>  #define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
> =20
> +struct mtk_rtc_data {
> +	u32			wrtgr;
> +};
> +
>  struct mt6397_rtc {
>  	struct device           *dev;
>  	struct rtc_device       *rtc_dev;
> @@ -74,6 +80,7 @@ struct mt6397_rtc {
>  	struct regmap           *regmap;
>  	int                     irq;
>  	u32                     addr_base;
> +	const struct mtk_rtc_data *data;
>  };
> =20
>  #endif /* _LINUX_MFD_MT6397_RTC_H_ */
> --=20
> 2.6.4

--h2zavgzncyp2cq5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5pZTQACgkQ2O7X88g7
+pq9wQ/+KoirFKK4cM7Qw34TtpdNX2uGtfuzcUmBKNjfJl/5WCUE/qo5WgaKcplR
VgE7uQWOzATqT3mQxG0iH2lzyXd2BVP2PJyEbswUyWTw/hZYLsrT2i+DKvQ4UKQa
WDKOvNwWsZMJrVAYnyV35Xsp4pWr2yFER61UiAMLlaXhhRzOLQE+P8dd4dr0cFhu
OgWclCmPjvLgVJsRbLvbyhQ2cLmTwnwBJICbHG+j8FQ0se2EgwzLyOl/45/6Oae+
qIzjAlZwYAwTmSpwCUeTLSJBp8i4BRg/xETQYpGf6cfBrf7VzBnQFZMo7rdGfj5G
gTJtq7yqAHlCXN1xQsYhy1Xx+SCl9y6Afjr7jyPW3iHnGvjrVeD1SR7tpDL3G9aT
iRviJlgdfpp7SrT0PwQkQ+Nk2OS2CqUcdWoTjODOtUPxQeAVcE2Hj14qjlcvftVa
+TGsljzNgIu8rfjwyqnf4ppfSMzK+M5tWCyzPLmKxZSchgvHILQ5DFlpYYG8HV/E
rUWRsEO9o1KZdlaOne98g90WZqbbqPRa3qpPUihmvj0yUlNsB7cPWBalFx8A8kAc
dGXnDj36egCGIb4Y5R3GtStgE6J4aDctSQuQzlm6vfk2C7sebUuTLmuy44TWMxez
L8QZ8aytJjFJ2dDAyUkHuTDJ47im2TyeIAbPfB/HkA7UYSM/Ars=
=P8yi
-----END PGP SIGNATURE-----

--h2zavgzncyp2cq5o--

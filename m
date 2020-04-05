Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3919E81F
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 02:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDEAne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 20:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgDEAne (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Apr 2020 20:43:34 -0400
Received: from earth.universe (dyndsl-095-033-168-093.ewe-ip-backbone.de [95.33.168.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006D9206C3;
        Sun,  5 Apr 2020 00:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586047413;
        bh=zJ2PFpEYB9JE8j9pPZ9xRtBENIAE4PP4mrsX1laAi0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Htgg3Gnc/7wV1P1qXpt8Tw4WpHHXo6EPJQM14fi6qFri62INtV7b2hOvfJXkxrsEt
         Cd/UWVa9ZgyaRw3FaKL1w6v+aKcIzdzvJ0/5emB/ExlcLli4kHahUmoxE30Ea9R6C/
         dijN2pHPWYvmMSkk18V72eQ8sPXyczWFL+h/EinQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 39F4D3C082A; Sun,  5 Apr 2020 02:43:31 +0200 (CEST)
Date:   Sun, 5 Apr 2020 02:43:31 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v11 4/5] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200405004331.e55z5gobskjerz5f@earth.universe>
References: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2bxduq5dd7on66yi"
Content-Disposition: inline
In-Reply-To: <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2bxduq5dd7on66yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2020 at 12:07:36PM +0800, Hsin-Hsiung Wang wrote:
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

I expect this will not be merged through power-supply. No need to
provide an immutable branch for this trivial change.

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/reset/mt6323-poweroff.c |  2 +-
>  drivers/rtc/rtc-mt6397.c              | 23 +++++++++++++++++++----
>  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
>  3 files changed, 28 insertions(+), 6 deletions(-)
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
> index cda238d..7f3dfd2 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,6 +9,7 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> @@ -20,7 +21,7 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  	int ret;
>  	u32 data;
> =20
> -	ret =3D regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	ret =3D regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -269,6 +270,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->addr_base =3D res->start;
> =20
> +	rtc->data =3D of_device_get_match_data(&pdev->dev);
> +
>  	rtc->irq =3D platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0)
>  		return rtc->irq;
> @@ -325,10 +328,22 @@ static int mt6397_rtc_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>  			mt6397_rtc_resume);
> =20
> +static const struct mtk_rtc_data mt6358_rtc_data =3D {
> +	.wrtgr =3D RTC_WRTGR_MT6358,
> +};
> +
> +static const struct mtk_rtc_data mt6397_rtc_data =3D {
> +	.wrtgr =3D RTC_WRTGR_MT6397,
> +};
> +
>  static const struct of_device_id mt6397_rtc_of_match[] =3D {
> -	{ .compatible =3D "mediatek,mt6323-rtc", },
> -	{ .compatible =3D "mediatek,mt6397-rtc", },
> -	{ }
> +	{ .compatible =3D "mediatek,mt6323-rtc",
> +		.data =3D &mt6397_rtc_data, },
> +	{ .compatible =3D "mediatek,mt6358-rtc",
> +		.data =3D &mt6358_rtc_data, },
> +	{ .compatible =3D "mediatek,mt6397-rtc",
> +		.data =3D &mt6397_rtc_data, },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
> =20
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rt=
c.h
> index 7dfb63b..6200f3b 100644
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
> +	u32                     wrtgr;
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

--2bxduq5dd7on66yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6JKaMACgkQ2O7X88g7
+poXSw/6A/hFwFRpm7tI04tkDezVAWK+d2kPK2/7BIIqjbwpXbI1fVn9z58XVYI5
NJVAgFjdCS8sfwl2cTTynfCm7Vk64a9kyUacYLNvfufgCEg6M0EeRNeZ3s6AU6s6
YyE5+X0mV/ioZh2hDLghQBvd6Re/qletLi/Ku8R99s/aqmLp00FklHWN1gXMnWsv
sKj7gQkPqw1bGW31QQWJKs2cotojGscMfI4g2ncXguz7jLa8zohgP4T85fm5i3Ik
ute+YbwbgoCoXWGbgJ8JrbMnfP/FreiZ0DsuyQNlbi8oA1Sr1adwUg11PB/E+wU1
YPBQ4qfGitvXtoQ8nml8am+0+rr4WKdzGJ92aio5DBYD0amVbFTV86zk1CSU1J8o
2n678g2xYyw9ZLmjP0G+Qy5pVBVP7jBd65WEPPQZYBwTSdUxOwXMcl9rxYyqY5bt
GzK7NbqjDUQJJtMi9VU4kqkTF0ZjO54h0i/eMOSXyM3hS2CB59EGZABsRQG7WcO9
b6VAAM/WHuDmg+oW1QNt9wn6CaRoxS3FFePo+J2rXejzHqpTOrnw99Mn9LmVZLZE
plxt+XcsN1o+TOm6AmSB6OEi2sMCl/22ApUMyrV+2J0DUVJqCDpW1jXP+ol/RH1u
bC5+zJNxe1OSesRx/Ia7rl3RpmP9wQC1UQAX/HDBuyWmdikiXTQ=
=c+EE
-----END PGP SIGNATURE-----

--2bxduq5dd7on66yi--

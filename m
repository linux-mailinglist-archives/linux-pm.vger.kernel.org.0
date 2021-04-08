Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D45358382
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHMoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 08:44:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7072C061760;
        Thu,  8 Apr 2021 05:43:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7CA971F45CCE
Received: by earth.universe (Postfix, from userid 1000)
        id 59D743C0C96; Thu,  8 Apr 2021 14:43:52 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:43:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     zhuguangqing83@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix missing IRQF_ONESHOT as only threaded
 handler
Message-ID: <20210408124352.3kvfpwj74ymfjqfm@earth.universe>
References: <20210406052829.22826-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25m4cz6hxukmhk4d"
Content-Disposition: inline
In-Reply-To: <20210406052829.22826-1-zhuguangqing83@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--25m4cz6hxukmhk4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 06, 2021 at 01:28:29PM +0800, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>=20
> Coccinelle noticed:
>  1. drivers/power/supply/pm2301_charger.c:1089:7-27: ERROR: Threaded IRQ
>     with no primary handler requested without IRQF_ONESHOT
>  2. drivers/power/supply/tps65090-charger.c:303:8-33: ERROR: Threaded IRQ
>     with no primary handler requested without IRQF_ONESHOT
>  3. drivers/power/supply/tps65217_charger.c:239:8-33: ERROR: Threaded IRQ
>     with no primary handler requested without IRQF_ONESHOT
>  4. drivers/power/supply/lp8788-charger.c:502:8-28: ERROR: Threaded IRQ
>     with no primary handler requested without IRQF_ONESHOT
>=20
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---

I merged a patch fixing missing IRQF_ONESHOT flags in power-supply
=66rom dongjian two weeks ago as 2469b836fa83. Please make sure you
are basing your work on up to date for-next branches before sending
out patches!

Thanks,

-- Sebastian

>  drivers/power/supply/lp8788-charger.c   | 2 +-
>  drivers/power/supply/pm2301_charger.c   | 2 +-
>  drivers/power/supply/tps65090-charger.c | 3 ++-
>  drivers/power/supply/tps65217_charger.c | 4 ++--
>  4 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index e7931ffb7151..397e5a03b7d9 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -501,7 +501,7 @@ static int lp8788_set_irqs(struct platform_device *pd=
ev,
> =20
>  		ret =3D request_threaded_irq(virq, NULL,
>  					lp8788_charger_irq_thread,
> -					0, name, pchg);
> +					IRQF_ONESHOT, name, pchg);
>  		if (ret)
>  			break;
>  	}
> diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply=
/pm2301_charger.c
> index ac06ecf7fc9c..a3bfb9612b17 100644
> --- a/drivers/power/supply/pm2301_charger.c
> +++ b/drivers/power/supply/pm2301_charger.c
> @@ -1089,7 +1089,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_cli=
ent *i2c_client,
>  	ret =3D request_threaded_irq(gpio_to_irq(pm2->pdata->gpio_irq_number),
>  				NULL,
>  				pm2xxx_charger_irq[0].isr,
> -				pm2->pdata->irq_type,
> +				pm2->pdata->irq_type | IRQF_ONESHOT,
>  				pm2xxx_charger_irq[0].name, pm2);
> =20
>  	if (ret !=3D 0) {
> diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supp=
ly/tps65090-charger.c
> index 6b0098e5a88b..d55bcc341854 100644
> --- a/drivers/power/supply/tps65090-charger.c
> +++ b/drivers/power/supply/tps65090-charger.c
> @@ -301,7 +301,8 @@ static int tps65090_charger_probe(struct platform_dev=
ice *pdev)
> =20
>  	if (irq !=3D -ENXIO) {
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -			tps65090_charger_isr, 0, "tps65090-charger", cdata);
> +			tps65090_charger_isr, IRQF_ONESHOT,
> +			"tps65090-charger", cdata);
>  		if (ret) {
>  			dev_err(cdata->dev,
>  				"Unable to register irq %d err %d\n", irq,
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 814c2b81fdfe..cba3967ff275 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -238,8 +238,8 @@ static int tps65217_charger_probe(struct platform_dev=
ice *pdev)
>  	for (i =3D 0; i < NUM_CHARGER_IRQS; i++) {
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
>  						tps65217_charger_irq,
> -						0, "tps65217-charger",
> -						charger);
> +						IRQF_ONESHOT,
> +						"tps65217-charger", charger);
>  		if (ret) {
>  			dev_err(charger->dev,
>  				"Unable to register irq %d err %d\n", irq[i],
> --=20
> 2.17.1
>=20

--25m4cz6hxukmhk4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBu+ogACgkQ2O7X88g7
+pr2Sw//WaQngatrCsqnO9qhac4PWDv+5Qe11OdgvwB453MMiSqeZFd5BO/b/z2O
6zctraiKJWyhQAOZOGZPL8RPb2psFaFmGGJCAXPYEmIxFhF8y/r5YoMNOjPoJrSy
mSumlKeIU2jbwm6q7flQogjiKQeyiO/7TGfqgqIlBNjRon5bSOPzjExEyq5SGc+V
iiAhPt1ng0wdTDlLOns/gMBK2HgWpPShrSFzKOtbThc6REAV2NEgvsSiOGp0MF5i
YBV/11M9E8eNrtnNvOnLc2QLTEzuUPlvhmN1JkBVDQqcJ6InQCf0xqZQhnDhtty5
clCKs4IDklUWuCIwmRBLOJ1i/C6YoQmIKn5M5XtGM/o2xA29LXc7h5ieXwyiOmWM
x7lH4NIzjShoj8na0pPcQN/7v18B4BQbuV5rwvj5m7OlKdeEXyhPv6853zb4ZutM
mB+NwtILbPGMwtpQKveFbvOPkLRd9gmOcT3r6WFefoscng6RXwXK1kbuTyeibsvy
xRtAQBaH0BKQQTUEzzI4Bdasf7PzHDJbHECfFG18si4LiVFcz0tlf3GTGn2APHQ7
g/YzCh/9hJtyUNzT8SHIq10709b67ckpW89QfbZ9JNuX9h0GUkPHoXPJRNh+ZZ4Z
jj2/YaZ4q6XCbSOWpZVgWhWmykd5b1MPxm7mx19yZiw3ZXsuqh4=
=dScd
-----END PGP SIGNATURE-----

--25m4cz6hxukmhk4d--

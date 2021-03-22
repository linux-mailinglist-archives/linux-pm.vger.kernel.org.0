Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F66344659
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCVN6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 09:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCVN6f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 09:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 518786196C;
        Mon, 22 Mar 2021 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616421514;
        bh=lVJXeggsx709epOlSGTiBeUB6SScnAKY76cjl4xiPL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apaUr9ALgG3ynOkV8CDghXKHHHgB+8faXYxLDMkj2c4slvdNXamS0RRKwOiCj9FTq
         hT02ftf+ZSDscguWz04Xv6TwV3OSjg9OdCI+zh/MJwzT1ubdOPZKtwtEGalOckLy6A
         pZ2io8TIVZU6nhgEczaDFosvohq8Cr50U7afoti7Zgpcix+IYM7kJZBin3pXboCgXO
         pvgrRAp23b15i98z90HecY2FZmNd0PdQW52qLje2WSrQR8GF9Ib4j0xDlQz5NaayRL
         6ScqB8dOdVnVqrXtKRyH5q5x/1OEIwK64FyHiAwpF0Lm0wpwGE6mIJMO68dpf+H67I
         NwI/SxpkKYIGg==
Received: by earth.universe (Postfix, from userid 1000)
        id F3F993C0C96; Mon, 22 Mar 2021 14:58:31 +0100 (CET)
Date:   Mon, 22 Mar 2021 14:58:31 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Jian Dong <dj0227@163.com>
Cc:     milo.kim@ti.com, huyue2@yulong.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dongjian <dongjian@yulong.com>
Subject: Re: [PATCH] power-supply: Use IRQF_ONESHOT
Message-ID: <20210322135831.b2xly44u3kyhnrzb@earth.universe>
References: <1616412093-144386-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sd4c2gfoiwny77qf"
Content-Disposition: inline
In-Reply-To: <1616412093-144386-1-git-send-email-dj0227@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sd4c2gfoiwny77qf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 22, 2021 at 07:21:33PM +0800, Jian Dong wrote:
> From: dongjian <dongjian@yulong.com>
>=20
> Fixes coccicheck error:
>=20
> drivers/power/supply/pm2301_charger.c:1089:7-27: ERROR:
> drivers/power/supply/lp8788-charger.c:502:8-28: ERROR:
> drivers/power/supply/tps65217_charger.c:239:8-33: ERROR:
> drivers/power/supply/tps65090-charger.c:303:8-33: ERROR:
>=20
> Threaded IRQ with no primary handler requested without IRQF_ONESHOT
>=20
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/lp8788-charger.c   | 2 +-
>  drivers/power/supply/pm2301_charger.c   | 2 +-
>  drivers/power/supply/tps65090-charger.c | 2 +-
>  drivers/power/supply/tps65217_charger.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index e7931ff..397e5a0 100644
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
> index ac06ecf..a3bfb96 100644
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
> index 6b0098e..0990b2f 100644
> --- a/drivers/power/supply/tps65090-charger.c
> +++ b/drivers/power/supply/tps65090-charger.c
> @@ -301,7 +301,7 @@ static int tps65090_charger_probe(struct platform_dev=
ice *pdev)
> =20
>  	if (irq !=3D -ENXIO) {
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -			tps65090_charger_isr, 0, "tps65090-charger", cdata);
> +			tps65090_charger_isr, IRQF_ONESHOT, "tps65090-charger", cdata);
>  		if (ret) {
>  			dev_err(cdata->dev,
>  				"Unable to register irq %d err %d\n", irq,
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 814c2b8..ba33d16 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_dev=
ice *pdev)
>  	for (i =3D 0; i < NUM_CHARGER_IRQS; i++) {
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
>  						tps65217_charger_irq,
> -						0, "tps65217-charger",
> +						IRQF_ONESHOT, "tps65217-charger",
>  						charger);
>  		if (ret) {
>  			dev_err(charger->dev,
> --=20
> 1.9.1
>=20
>=20

--sd4c2gfoiwny77qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYonwACgkQ2O7X88g7
+pouyg/8C+DfUdjwrlFMl97dMgfYMT9ZmQ/gyli/WNHr9IOCIwAaaNsiyWeeZV0/
iRULotftxgnUGP2vq918xfwfrMHTjgQCUmAqlXhUhD2TNCTswm1fup5a2g6hSUuk
eLtr6AlF3aGFyibw+iPpCrolXhKS33ijYQPi6F6oCXPCAjiYzEYuZuwwbRunE5iG
ioCMiHybgbRhe+jeKdhVzci3OwuRZp54mFNgBAV1FLeY9zOik8RJM4kHLkPixJli
ujGWsaW2bxTU5UOkxJqlqrHENBFo9OU6d5JeQuTYnkBsB4eItqhjilQpVHLK1Rbb
VfsPWBIxCtGg63pplWC15imUZgXWnFSIX44Z1dNtMwqzDxoCbNkarRuh06KVgXLj
b0btpWCNcuu0bzBPY3ydl8xS+L8rJXJLm++VO8X7qp8avF9hEAx1ivIET0oXtgSM
32ohiiYGa34rbGUQPq3aIYonxRxrL2DfaU5jfxvbZRVaXAKHisnWpEM56xip0upe
gOUA16+N7zS51klXlOcVKQESekiO8lKM44zfTyHuPn9SaHcJftB2UPGRvassS2fg
SW+XSzqhMUuYRN3xNo7IRi/mSKfaTX1CkfQnusvy3X3RxEemu5/JXBTRGLz9eiwT
11ied89aAqx1K2LaTVe8+2OKeojrWpO3BLbn/XCVaRke9LdQmsg=
=nP6l
-----END PGP SIGNATURE-----

--sd4c2gfoiwny77qf--

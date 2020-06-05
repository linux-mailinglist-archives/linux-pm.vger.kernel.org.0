Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588FD1F036A
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 01:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgFEXQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 19:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgFEXQU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 19:16:20 -0400
Received: from earth.universe (dyndsl-037-138-189-219.ewe-ip-backbone.de [37.138.189.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B01206FA;
        Fri,  5 Jun 2020 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591398980;
        bh=2l6sldffhApfiRus+in0DwYUQ9/aq1/cnVknAJC+C2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVtZ+Od1h4ryAY94nFKhYQwMeaUm1bm1+9sboBEDOCCnt85NHZ0wh3p8UB126Dywn
         jFvcztS6r5pny+RzeU1uk4X8xWIAylWkxdoyLMH6jKz0fRf7I1lLVXO0fEo4HaycDd
         KNCufYdMvKa5wDpjdmrBdsNHhV/s5IV5CnnAnP6Y=
Received: by earth.universe (Postfix, from userid 1000)
        id 2B1643C08C7; Sat,  6 Jun 2020 01:16:18 +0200 (CEST)
Date:   Sat, 6 Jun 2020 01:16:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: gpio-poweroff: add missing '\n' in
 dev_err()
Message-ID: <20200605231618.u5zxqx5y3im3um2i@earth.universe>
References: <20200603162118.14403-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6dldtkj2sxxihs2"
Content-Disposition: inline
In-Reply-To: <20200603162118.14403-1-luca@lucaceresoli.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--g6dldtkj2sxxihs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 03, 2020 at 06:21:18PM +0200, Luca Ceresoli wrote:
> dev_err() needs a terminating newline.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/gpio-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index 6a4bbb506551..c5067eb75370 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -54,7 +54,7 @@ static int gpio_poweroff_probe(struct platform_device *=
pdev)
>  	/* If a pm_power_off function has already been added, leave it alone */
>  	if (pm_power_off !=3D NULL) {
>  		dev_err(&pdev->dev,
> -			"%s: pm_power_off function already registered",
> +			"%s: pm_power_off function already registered\n",
>  		       __func__);
>  		return -EBUSY;
>  	}
> --=20
> 2.26.2
>=20

--g6dldtkj2sxxihs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7a0jsACgkQ2O7X88g7
+ppZ5g/6A0ryNyhbod9qukwv6kwdkDspkf4G/D7qYyqkZsYmSbXd74VoynbVeAPX
/t4gAwBujKKySL3KhySQisk2s5WheU+6hP4ZnMVt/aEmQ3MGS289GtysT4UvLzu1
HDb7X/GR3t4VxctMk667OV0uQXKY5CwML81jgcWTnNDd3Uk9NLVpxKfHY3imGcLS
SyEW3gDhXx12vVEbDapEfJ5jje5KmQCu2QalMGlrCrpzHitHZBTISFm2cjxw1eXh
V/cOINWAzt/EuzLnXJawqNQnXapVuGOKesqrW4LsmMSjxkDfZdV9jbdKJpSFmX7w
1oyXRJRxwF7fBoTSfUVsKFlD9uCiU6cEj+uAUc2bsNQbW6oQUdVNmKzsjl29vKeb
cnY+evIl05Dtu2Sb6YHMR5A66HcomMu5RBW7ehebdxL1nHiOSHw4ocniibteotEg
su4t5gE7pEnrCcJkpj2U0EfBHdDUyakevGGGB3Dw1Ha8F/rLE00MTfza00kwoH6F
oZjEwx1/AJaproDIRuS7d4IaWBl+02tEQkzf0P4mRs0EQwgfEw7QV73XVP2RUJq3
dllnvWuZI4Yeon74mV3l8xg0Pe7Q4+CBlmIdA9OWH3VfKx/tG6QrIjSJSxEQxmVA
m2A5VItZYrOcMyLU1FS+yXSAwIdycWT0hZVDww/sV9F7CqvWo1M=
=0XmW
-----END PGP SIGNATURE-----

--g6dldtkj2sxxihs2--

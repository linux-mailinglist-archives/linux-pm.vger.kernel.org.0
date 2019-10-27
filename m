Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40690E695F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 22:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJ0VgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Oct 2019 17:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfJ0VgE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Oct 2019 17:36:04 -0400
Received: from earth.universe (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32427205C9;
        Sun, 27 Oct 2019 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572212163;
        bh=8gXctTboVSnMqMtZlXRkBfoUYNqf/4y3OKkcNN3kbPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVYez2nM3fw/fNROG2R4WqCelxumB7QxQmwPCBFVI4P5heyusrH7lCquSpgcm5MZN
         WYcuDWCzBn77Trxgj6Dno/3k9un918Rq8O1I7brUJ/G96k3xBMCMIlxPqQqrDp56EO
         iAjUhxmOYsv+UrziHsUcbQkWT7iQQKfOoFhx+2cw=
Received: by earth.universe (Postfix, from userid 1000)
        id 18F8F3C09B2; Sun, 27 Oct 2019 22:36:01 +0100 (CET)
Date:   Sun, 27 Oct 2019 22:36:01 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bd70528: Add MODULE_ALIAS to allow module
 auto loading
Message-ID: <20191027213601.tcnw4cyqoaq3ps64@earth.universe>
References: <20191023123453.GA2918@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7ek4ubl4x4mue4i"
Content-Disposition: inline
In-Reply-To: <20191023123453.GA2918@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u7ek4ubl4x4mue4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 23, 2019 at 03:35:24PM +0300, Matti Vaittinen wrote:
> The bd70528 charger driver is probed by MFD driver. Add MODULE_ALIAS
> in order to allow udev to load the module when MFD sub-device cell for
> charger is added.
>=20
> Fixes: f8c7f7ddd8ef0 ("power: supply: Initial support for ROHM BD70528 PM=
IC charger block")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Not sure if this should be bugfix or new feature. I don't think Fixes
> tag is a problem though.
>=20
>  drivers/power/supply/bd70528-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/suppl=
y/bd70528-charger.c
> index 1bb32b7226d7..b8e1ec106627 100644
> --- a/drivers/power/supply/bd70528-charger.c
> +++ b/drivers/power/supply/bd70528-charger.c
> @@ -741,3 +741,4 @@ module_platform_driver(bd70528_power);
>  MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
>  MODULE_DESCRIPTION("BD70528 power-supply driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:bd70528-power");
> --=20
> 2.21.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20

--u7ek4ubl4x4mue4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl22DcAACgkQ2O7X88g7
+pryuA/9G3U2slYrkWhOdE4sZk/YK82oNLgoHStSfBw/wzQWhDojXcVvqrKLcH4J
G4I4P/+q6FQFDVez2cG0GZLDYdvsDg+ivTk/cpgmGiMNag9eeesD6TtBoi5yvxhD
8MhSoWdJ6NCRWUq5Q7MvJaIOd/d3heGmRR0WZ6ih6Go+R2SJAu0OLX54ZqwbcysN
4TZL5CnnWxKQLQxgbcFrjI5XAI0TpxpPsaZ9FJ2d9hYaMMzl7XjySQF+Wxlwi5Gp
iCY4MV7QR7IsFZ2oh3t+ZW1QncRub/30EwBMSR7+rOSdJ3M32jRZErXqAnt4F5Lf
CJRksQSB+CVmNEbOziDg6yHecPqDiMzADiWQKzg8Tw/UadGWaTfAlpFx0TfOy4Bv
KFeDi1OIJ/kopx5FhOzlddGcUE7b302xqTKZoW3TleBGf4noBZBo0CwmPyHHlpWx
mfpTCYbN/MiijecaCAUdkzBOL6hZ9hQAjtdT/BOcPgWLxGzjYL4nVL2ZrA7gsF+N
t0O5pMxFkenTwMioj05qNu3zbROLmYq/YnBqu7Zq7RTF5vK4x/SKvGcR+ZI8R6Xr
LlXk6LtHejc8nw2lpIX332fz6x6lPiaY1HaZdtnJBjzcW9lGnfLckzr4teJGxEm0
e8C8c7eRSGJeHpV6LDXzHB4jm+uyu+9ZoxV8j7hosOcv+/X3+28=
=TPBa
-----END PGP SIGNATURE-----

--u7ek4ubl4x4mue4i--

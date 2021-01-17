Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512C2F9486
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 19:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbhAQSWD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 13:22:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59442 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbhAQSWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 13:22:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 96E761F44A51
Received: by earth.universe (Postfix, from userid 1000)
        id BC9953C0C95; Sun, 17 Jan 2021 19:21:17 +0100 (CET)
Date:   Sun, 17 Jan 2021 19:21:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolassaenzj@gmail.com,
        Nicolas Saenz Julienne <nicolas.saenz@prodys.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] power: supply: fix sbs-charger build, needs REGMAP_I2C
Message-ID: <20210117182117.ewq2e6ce2c5p2mdz@earth.universe>
References: <20210116211310.19232-1-rdunlap@infradead.org>
 <537de36b-6709-3e58-5610-9f54e2bee8a9@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zzpialt2nuswu7ld"
Content-Disposition: inline
In-Reply-To: <537de36b-6709-3e58-5610-9f54e2bee8a9@fold.natur.cuni.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zzpialt2nuswu7ld
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2021 at 10:48:44AM +0100, Martin Mokrejs wrote:
> Hi Randy,
>   thank you very much. I would not mind dropping my name but I tested the=
 patch
> now with 5.4.89 so you may actually also add
>=20
> Tested-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
>=20
> It also happened with 5.10.7, it is probably obvious.
>=20
> Thank you for quick action.
> Martin
>=20
> On 16/01/2021 22:13, Randy Dunlap wrote:
> > CHARGER_SBS should select REGMAP_I2C since it uses API(s) that are
> > provided by that Kconfig symbol.
> >=20
> > Fixes these errors:
> >=20
> > ../drivers/power/supply/sbs-charger.c:149:21: error: variable =E2=80=98=
sbs_regmap=E2=80=99 has initializer but incomplete type
> >  static const struct regmap_config sbs_regmap =3D {
> > ../drivers/power/supply/sbs-charger.c:150:3: error: =E2=80=98const stru=
ct regmap_config=E2=80=99 has no member named =E2=80=98reg_bits=E2=80=99
> >   .reg_bits =3D 8,
> > ../drivers/power/supply/sbs-charger.c:155:23: error: =E2=80=98REGMAP_EN=
DIAN_LITTLE=E2=80=99 undeclared here (not in a function)
> >   .val_format_endian =3D REGMAP_ENDIAN_LITTLE, /* since based on SMBus =
*/
> > ../drivers/power/supply/sbs-charger.c: In function =E2=80=98sbs_probe=
=E2=80=99:
> > ../drivers/power/supply/sbs-charger.c:183:17: error: implicit declarati=
on of function =E2=80=98devm_regmap_init_i2c=E2=80=99; did you mean =E2=80=
=98devm_request_irq=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >   chip->regmap =3D devm_regmap_init_i2c(client, &sbs_regmap);
> > ../drivers/power/supply/sbs-charger.c: At top level:
> > ../drivers/power/supply/sbs-charger.c:149:35: error: storage size of =
=E2=80=98sbs_regmap=E2=80=99 isn=E2=80=99t known
> >  static const struct regmap_config sbs_regmap =3D {
> >=20
> > Fixes: feb583e37f8a ("power: supply: add sbs-charger driver")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: nicolassaenzj@gmail.com
> > Cc: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > ---
> > Martin, do you want Reported-by: on this?

Thanks, queued. I added Reported-by and Tested-by from Martin.

-- Sebastian

> >=20
> >  drivers/power/supply/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > --- linux-next-20210115.orig/drivers/power/supply/Kconfig
> > +++ linux-next-20210115/drivers/power/supply/Kconfig
> > @@ -229,6 +229,7 @@ config BATTERY_SBS
> >  config CHARGER_SBS
> >  	tristate "SBS Compliant charger"
> >  	depends on I2C
> > +	select REGMAP_I2C
> >  	help
> >  	  Say Y to include support for SBS compliant battery chargers.
> > =20
> >=20
>=20

--zzpialt2nuswu7ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAEgBcACgkQ2O7X88g7
+prWyBAAoxtPZN6DuY6SHm6D8CnY7c7aVcpUum3Ipc3dLD1HOKOc2t+qo2dtMBbX
WJALYV/QhsBmOChnNNd9962fOhxlU8mpBftAO6FONjCJnupRdG5cTqacJBcUv8R2
UZb6ABAmFkjScRUoGXR7OcBirzCbwNh9/e0sIxu4JrCAA9qtXuFCQt4/lAtWVSiT
m582qGLMDEH9cbrmlITgAmDPgzXZHQJugCAA0zt1kFbd5d7XfZCHXW50lAvNb+Bw
MvApWZEK0hD1YrGcYOLwz8CMHoiDUYZm+3LC0n4gZoZxVc9ey/84pr0PnI0b9Ttr
K346KBMnArUpBATUG3OloCdfGc744anNe+FA5DbpYZc0YeZJ9QJ8nHe8H/bzsSFW
RxzeWwejrfj2jE5f+avln0Cuup+5uzt7XUh/xV4tTU/PjhUfdDBiU+k3ai/9r2ql
qtAP5vi1BOov7unk6HOZmtCHRTzIhDtyRM7/hXt9ktKXnfU/WJDGzRomSJR0clfT
yTFROIEBCAiE9czAogHnD8h8IL7lVAoIzmZNCsI4nwiL/9csYm9LtUwHNZwhIg0x
ZHKuWpFqHF0zT23kofOTiZyfIeXWnx9jlwHP12s3672K+Ks2ZDp95uVZXK0d0uDJ
ZsmM+MlPwqw4JUhssPZE1rsjZrjxipY9LosE3ziM29byjak4GUc=
=4asC
-----END PGP SIGNATURE-----

--zzpialt2nuswu7ld--

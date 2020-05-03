Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F351C2EEF
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgECT4W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECT4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 15:56:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8DC061A0E;
        Sun,  3 May 2020 12:56:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8273C2A05B9
Received: by earth.universe (Postfix, from userid 1000)
        id A0CCA3C08C7; Sun,  3 May 2020 21:56:18 +0200 (CEST)
Date:   Sun, 3 May 2020 21:56:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/11] power: bq25890: remove redundant I2C bus check
Message-ID: <20200503195618.pzqlrvcm57wntkkz@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <1b3c0d2b01c56cfc073f9ff4961f077098edbe67.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oizyatvdpv6rhida"
Content-Disposition: inline
In-Reply-To: <1b3c0d2b01c56cfc073f9ff4961f077098edbe67.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oizyatvdpv6rhida
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:10PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> regmap initialization will check I2C adapter functionality.
> Remove redundant check in the driver.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index aebd1253dbc9..c642519ef7b2 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -881,17 +881,11 @@ static int bq25890_fw_probe(struct bq25890_device *=
bq)
>  static int bq25890_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> -	struct i2c_adapter *adapter =3D client->adapter;
>  	struct device *dev =3D &client->dev;
>  	struct bq25890_device *bq;
>  	int ret;
>  	int i;
> =20
> -	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> -		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> -		return -ENODEV;
> -	}
> -
>  	bq =3D devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
>  	if (!bq)
>  		return -ENOMEM;
> --=20
> 2.20.1
>=20

--oizyatvdpv6rhida
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vIeIACgkQ2O7X88g7
+prt/hAAp37MLFvHslLZjA4DIzWp/YtYBDoOtUSEeqHuFQNwnNDbWHf5lDQvC5bM
zFrN8zbkV0zREWAvCH+xqwYmgxIF9W31QBNDU5bBqnVGL5cMy1V0/umZGyg200nK
04Nhw1IojeqjH/aCAoqMkIT6DayNJ+kOGrGLuMDqPrB6MOHyWk+XnOnHTxfzhRK0
HRLz5zXjFDhZR+ov+3fCJv3j9S4HSaAiQQQRDUr6kP0i0g9/+WbwPLHAg70qjqm4
m2bOvTgdrz4K7HUyXmCwFc44YBwOqIRg7eGvNCMXMTXXxQR/dzNwK2VvFxymqy22
wifdhilNjoENSzRwD0Zk8+JutpxAbxmXawt2pjcP8etnn381hg50kwdJocs0r7UN
LkPC48G6H34dKRTnywx2zZnetxxH5XQymXXaobikzlcZULvoFpXEb6/Sz9juXLOE
3jA0B0wViqNENPjkbQ6TA+v/P7xp9qATR2cnoTc1qFc8Sq0t6yWV3vGqJwqTpB++
hQcl/XL0o/iJGGENaOt1ZZ1B+O7gVWbWeqEeFwVoIynsfLMSFTWjChT7n/G7n+CD
5ssHd9S3+fDALpuBK8LJvCnx3qqbimQJqoVM/by0xexJ5MVJz6kdjGzi9zzXfAm/
8cbqkAeDRF2LMIAnyVqYnA6tXIFwQB4DYNK3ZPB67PHsWu1riBc=
=sKHT
-----END PGP SIGNATURE-----

--oizyatvdpv6rhida--

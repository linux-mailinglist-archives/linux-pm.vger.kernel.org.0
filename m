Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0138D22FE6E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgG1ATj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 20:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG1ATj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 20:19:39 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FA420786;
        Tue, 28 Jul 2020 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595895579;
        bh=vsiTrIcZ56SSOxyiEUoEwv+DpHiWDpQ4NqHzGqLqy3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYCMeK0MW7pG2TuN8wCprFNbGTxiU0frezxvvY/Brck/TqRWqtKMY6p6ZDqYHgpzm
         UYDLLpsfd6AVXo63eI70TvuKt7nSTWho9ggj2+P/cUKNT+sk7JbB0rWgFbmRyVjyhw
         Gd5MZU0gk9jAAI7JRaR06EVHaKjML1OMPRUni7OQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 4F75B3C0B87; Tue, 28 Jul 2020 02:19:37 +0200 (CEST)
Date:   Tue, 28 Jul 2020 02:19:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] power: supply: rt5033_battery: Fix error code in
 rt5033_battery_probe()
Message-ID: <20200728001937.vtvneczrskc6cs4u@earth.universe>
References: <1593680332-31884-1-git-send-email-fanpeng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7od7w7hhl7sikvqk"
Content-Disposition: inline
In-Reply-To: <1593680332-31884-1-git-send-email-fanpeng@loongson.cn>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7od7w7hhl7sikvqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 02, 2020 at 04:58:52PM +0800, Peng Fan wrote:
> In the function rt5033_battery_probe(), it should return -ENOMEM
> instead of -EINVAL when call function devm_kzalloc() failed.
>=20
> Signed-off-by: Peng Fan <fanpeng@loongson.cn>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/rt5033_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index d8667a9..f330452 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -125,7 +125,7 @@ static int rt5033_battery_probe(struct i2c_client *cl=
ient,
> =20
>  	battery =3D devm_kzalloc(&client->dev, sizeof(*battery), GFP_KERNEL);
>  	if (!battery)
> -		return -EINVAL;
> +		return -ENOMEM;
> =20
>  	battery->client =3D client;
>  	battery->regmap =3D devm_regmap_init_i2c(client,
> --=20
> 2.1.0
>=20

--7od7w7hhl7sikvqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fbxkACgkQ2O7X88g7
+pog2A/8DVU5QYgx87Or/U3pWkw+/hgTRmm5UVuocenyM22SgCXnd+SHVLLpF12P
NinS8uhYlufo7HRznagwQr1t2uy2AT8IpQ13VpwjcidHZYbCqudJtUNL9gJ0VYVO
OKmwlQeROyXnjqiM5dKA48TXcFvXFmzsg9vOphwsN+uY0DsoZOimHmGHc2XRZ+dc
x3HmlBNX9z8C+y1JoiP/b7H8oXXUhxXnZZ0Ogs04jmlE38CSClPwAhVvcd8umqyZ
sZgnGlaG2uCV8/ZvSvstBzEJAwaP23VLEZoqccs+9v3nI97JVml0oAP1U8yq7Xah
XF1h8bxRsxzxZ2cq1htGlXy7TlwNmHqgBiskM+AyuHOOViKyGJR5ug/RCUEGc5y+
JT39Yk6rhrowEIZlsAaJGOWGeuXAHO1UwE1bg6nZDazRPZ9GExk9bmu7vrhnLODS
CHnnaMh2oK+KW2oVenfm1y7Du1GAa3jiDCLTXXFV6ZACQu9jh7N55BzdfdnvmInR
NzHV9+55pcbk9U/blUGn4A4LTzBdptv6z/Y42URoghn2ks4dxNlhtwKCWWIVEm3p
uc24pzQJJp4YpexNlZr+giQ/jD6muqgUdS5lml8rPTw7Dui5Ya9Z4Q8YHNfhnzit
ZwZfH8dlK7Z8uoKco4TeafPi91n25hyPgx//TgqyhMNvBCYaRvE=
=xY1+
-----END PGP SIGNATURE-----

--7od7w7hhl7sikvqk--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936728A466
	for <lists+linux-pm@lfdr.de>; Sun, 11 Oct 2020 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgJJXbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Oct 2020 19:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJJXbA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Oct 2020 19:31:00 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7E52078D;
        Sat, 10 Oct 2020 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602372660;
        bh=37d/LidKjvY0cD+ouqOyVb5R8tfno1hd9g+Ti8C101c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yFjrwLMA7fs7byRYZQ9Oj4Et9nbTZP+oqf6sQy2bhlzgICTmyxLE6QZmBXcqHpTiV
         PMu23uBbgKZt5R3nOvbY0527ebnSJ7XnoH75E0SkmjB51MR2igWgos2lQ8EoBa2QR7
         pbYXZ0zKxxLnHtmZJEAUDi5IynNxKj/YcfKXhhUM=
Received: by earth.universe (Postfix, from userid 1000)
        id E74233C0C87; Sun, 11 Oct 2020 01:30:57 +0200 (CEST)
Date:   Sun, 11 Oct 2020 01:30:57 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] power: supply: ltc2941: Fix ptr to enum cast
Message-ID: <20201010233057.5gdelhmobcvctkwl@earth.universe>
References: <20201010065526.2466583-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sh4ll5ysvwoxq4hx"
Content-Disposition: inline
In-Reply-To: <20201010065526.2466583-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sh4ll5ysvwoxq4hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 10, 2020 at 09:55:26AM +0300, Iskren Chernev wrote:
> clang complains about casting pointers to smaller enum types.
>=20
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ltc2941-battery-gauge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 30a9014b2f95e..10cd617516ec2 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -473,7 +473,8 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,
> =20
>  	np =3D of_node_get(client->dev.of_node);
> =20
> -	info->id =3D (enum ltc294x_id)of_device_get_match_data(&client->dev);
> +	info->id =3D (enum ltc294x_id) (uintptr_t) of_device_get_match_data(
> +							&client->dev);
>  	info->supply_desc.name =3D np->name;
> =20
>  	/* r_sense can be negative, when sense+ is connected to the battery
>=20
> base-commit: 411643e949f4e616f758e2c6079f333b0e704c49
> --=20
> 2.28.0
>=20

--sh4ll5ysvwoxq4hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+CRC4ACgkQ2O7X88g7
+pq3dRAAqMBUbN7E1UWOIfDfDuU+sFXPnQmOTg7C9lkU/73FSG1Ka1uwdZlQz8SP
GJwbJV7I4Cbaymd4jCTcnJOzkpKF8I4dCRt4TIC4wpjbUkoYRmWhkwigre9t0u4S
5lsr/0ZcrlQbWyOjcf8iEshXRcBGsiur0MgZlLz6ubZzi/otfuJ3tT4827OAgQCo
/qa7LE2mivbYyBOFgQDbUoX5me//rAOGwy2/HA/jeAcu+87KdZcPDUqtCa1XABG2
Lb2+QVqdZpAYgBYhEjf1qEQYoNUon1ggtT8a0ygBcFbLk3PA+AHyWN35KiuPqMAD
FWzu52fYinkbFsQxeBLym/pvyMKnIS8ypYNqrGw1ijto8+466CTUW8yCS2jTcG1k
UDyVtJGX5bhd8nIIBzZl85FXS22qiibQztIxHjy4dYk2a0UDVH47QSYmboX9VA5d
gBx63Lr3z/Lt+KAnlw0upc+V25kCTWkqEt1uOawy8nHOm6EIL8XPu+N1J/kBulJ5
oKuc6hDuDYXLjrunssaIgF/b14hARo2C9ECTK73wdxgA+NrnIHCdY13iARQtCEYA
eyeguuFPOl0OQPuMJ7//+9dAAbqHR0Ykip5ZrbS+gn+WyjiNPdaXDmrvZcMwSDOW
y1UBiX1wfEdKsr1jRRLH8NLfFNsJinX6NVKQT9xJ8epydE2/3rs=
=YIFo
-----END PGP SIGNATURE-----

--sh4ll5ysvwoxq4hx--

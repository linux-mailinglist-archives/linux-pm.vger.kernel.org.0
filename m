Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9836FD59EA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 05:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfJNDXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 23:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfJNDX3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Oct 2019 23:23:29 -0400
Received: from earth.universe (unknown [88.128.80.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A97820815;
        Mon, 14 Oct 2019 03:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571023408;
        bh=2TAkqUjfo4xpokDHfzTm7Gp3ss5oXn8eypzf4r8mV1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFv3J1s/Gf04BhJl3kmUDbO5vSXAIinZEIDOiYpC0WksRjMBwAx8x0jKVVcaHjfJa
         FuvAd5aUyJQn77UE4h0rl58QmWtX5agNI8DUWwi5m3JFFS68KYXfGSZTHcPgA2HvvQ
         54ylPqJok4uJRi5+AMKmVCPffkPJsDm9uRUEV58E=
Received: by earth.universe (Postfix, from userid 1000)
        id 04B3E3C0CA1; Mon, 14 Oct 2019 05:23:26 +0200 (CEST)
Date:   Mon, 14 Oct 2019 05:23:25 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17042_battery: fix some usage of
 uninitialized variables
Message-ID: <20191014032325.y65gis5zek5kr5hu@earth.universe>
References: <20191003172948.15834-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz27t4fnjwz7cjcf"
Content-Disposition: inline
In-Reply-To: <20191003172948.15834-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cz27t4fnjwz7cjcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 03, 2019 at 10:29:48AM -0700, Yizhuo wrote:
> Several functions in this file are trying to use regmap_read() to
> initialize the specific variable, however, if regmap_read() fails,
> the variable could be uninitialized but used directly, which is
> potentially unsafe. The return value of regmap_read() should be
> checked and handled. The same case also happens in function
> max17042_thread_handler() but it needs more effort to patch.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---

This does not improve the situation much. You should change the
functions from 'void' to 'int' return code and propagate the error
code, otherwise the following code assumes everything to be correct.
Also the Signed-off-by name and the patch author's name seems to be
incomplete.

Thanks,

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index e6a2dacaa730..b897776a2749 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -675,8 +675,12 @@ static void max17042_reset_vfsoc0_reg(struct max1704=
2_chip *chip)
>  {
>  	unsigned int vfSoc;
>  	struct regmap *map =3D chip->regmap;
> +	int ret;
> +
> +	ret =3D regmap_read(map, MAX17042_VFSOC, &vfSoc);
> +	if (ret)
> +		return;
> =20
> -	regmap_read(map, MAX17042_VFSOC, &vfSoc);
>  	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_UNLOCK);
>  	max17042_write_verify_reg(map, MAX17042_VFSOC0, vfSoc);
>  	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_LOCK);
> @@ -686,12 +690,18 @@ static void max17042_load_new_capacity_params(struc=
t max17042_chip *chip)
>  {
>  	u32 full_cap0, rep_cap, dq_acc, vfSoc;
>  	u32 rem_cap;
> +	int ret;
> =20
>  	struct max17042_config_data *config =3D chip->pdata->config_data;
>  	struct regmap *map =3D chip->regmap;
> =20
> -	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
> -	regmap_read(map, MAX17042_VFSOC, &vfSoc);
> +	ret =3D regmap_read(map, MAX17042_FullCAP0, &full_cap0);
> +	if (ret)
> +		return;
> +
> +	ret =3D regmap_read(map, MAX17042_VFSOC, &vfSoc);
> +	if (ret)
> +		return;
> =20
>  	/* fg_vfSoc needs to shifted by 8 bits to get the
>  	 * perc in 1% accuracy, to get the right rem_cap multiply
> @@ -1108,7 +1118,12 @@ static int max17042_probe(struct i2c_client *clien=
t,
>  	if (!client->irq)
>  		regmap_write(chip->regmap, MAX17042_SALRT_Th, 0xff00);
> =20
> -	regmap_read(chip->regmap, MAX17042_STATUS, &val);
> +	ret =3D regmap_read(chip->regmap, MAX17042_STATUS, &val);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get MAX17042_STATUS.\n");
> +		return ret;
> +	}
> +
>  	if (val & STATUS_POR_BIT) {
>  		INIT_WORK(&chip->work, max17042_init_worker);
>  		ret =3D devm_add_action(&client->dev, max17042_stop_work, chip);
> --=20
> 2.17.1
>=20

--cz27t4fnjwz7cjcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j6g4ACgkQ2O7X88g7
+poLzQ/+McwlrOE8QpCgorKz8Cdr/IzBeQNRS3Q7EQEPiSr71Yp5z8qfQ8FiYLFO
lXpendoxonoYVELlrXuDdB1cyA3J0Ybvz6uTIC2Mt3fb89AjvIJX3/5SqIIfFoir
prUdyYg7cU4NhCWvcUXbkL9o9OFMfSjR3+fZskkVkb82TYjwWdK7T2ueuUVYCAoc
wD6CYv7KCYG0F7IDVvJuiqNiyF+cLHJRMaZCBmxp5wwoBmobWbRZQaDqrv/h4XHA
8GH5GcVvMlZeE1rBmmFKjiUXXMI/IMKp0jPYjvQCkTLjg8PGgrG5H4m5AL6MTwU6
UkiF0WMhbdsBGFPsmyE7+vAGnBhzWKyG+FpZWh/9hF9rTp6rSpXYLXGCgV/4H9ep
k1MaGxQKfxpgqZhB7VC2GvGA0qQWxl6fbOcYsfIlMhCrqOlBxfxCT5cAztQaWdxg
tMJE6s2dFueR/mYJXAuRw5cL05FnpSnLgq2vbpqZKYWNGnAv2uvkQdUDw3tfrsmE
EROgYWKHMXCihUs+1YvJtNJfTa6cU1Z8SgX7xKaF8VYGiFHqfUPN3+SzoJ+UZZZf
yCoX1fZjVW5EgDsMTm9HJwNS5JTv7bcQWH3AHAEGDZ7KgETX+PD2EogazMUMW8am
J3v/pUZhckVPDbwlt+UfvKq5SIB8ccMjQU3xDO8L0WDDIs5hTTc=
=wDCo
-----END PGP SIGNATURE-----

--cz27t4fnjwz7cjcf--

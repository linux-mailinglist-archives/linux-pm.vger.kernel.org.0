Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457A22F8D24
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbhAPLoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 06:44:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47932 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPLoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 06:44:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 89AE91F44A78
Received: by earth.universe (Postfix, from userid 1000)
        id 20B023C0C94; Sat, 16 Jan 2021 12:43:24 +0100 (CET)
Date:   Sat, 16 Jan 2021 12:43:24 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power/supply/bq24190_charger: convert comma to
 semicolon
Message-ID: <20210116114324.7zcbzvb6j6jyislt@earth.universe>
References: <20201214134054.4296-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3dq6t5hfgftofph"
Content-Disposition: inline
In-Reply-To: <20201214134054.4296-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f3dq6t5hfgftofph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 14, 2020 at 09:40:54PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>=20
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index d14186525e1e..00c4f335481f 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1757,7 +1757,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	charger_cfg.drv_data =3D bdi;
>  	charger_cfg.of_node =3D dev->of_node;
>  	charger_cfg.supplied_to =3D bq24190_charger_supplied_to;
> -	charger_cfg.num_supplicants =3D ARRAY_SIZE(bq24190_charger_supplied_to),
> +	charger_cfg.num_supplicants =3D ARRAY_SIZE(bq24190_charger_supplied_to);
>  	bdi->charger =3D power_supply_register(dev, &bq24190_charger_desc,
>  						&charger_cfg);
>  	if (IS_ERR(bdi->charger)) {
> --=20
> 2.22.0
>=20

--f3dq6t5hfgftofph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC0VsACgkQ2O7X88g7
+pofVg//fs+Y9vFVLr2vxRDd4ylheYPQaFlBMJ+VB04j8XkvlKMGa8zMS9KGzDIk
mRURXLVgQJ0FHXq6+KmZb0QJ0x8zGu4qyVE4ZUDEBCvy+DmtAKTx33NX5f2syewL
UR+ykgOpZ7tYZ244HhyDg98vhoaNjJEx0/qy51Sn3mav1IKIwYLEPmwLw3GW56bQ
122zkFo44yyKaWlM8jageQcsxnho3ioyLjNMP0ptaBEMD+yiEHagpHdoEnLAuko6
U+slbOrWtv7wt+nNvLChvjDLlk+UivVS4PaxE3GGw/AcAQFae3RBFYky2d7hi4a7
KqeMWhApGR2HshdTv/WNd9t3kOmYNFVKQ77sSXdGbI3YwozwJuzsQRO5c5zTsQoL
X8Lp+mFzC5kYCxHDt4Qc0z1QnZ98O2CBiLvhfU0DCQmIv31NNwZj0UCc/PRMM/uA
gr7t0wMZ9CivOOSBs15xlE+Iz7CLzUD6zs1H32ODyPxhkiszaYsN6ng+mHE6rgIJ
6Y7ch7PYr48IturHHmovKwYHrpeHVztB3urfKTLsTsfA7ehlZM2bbEMe2IinN8TP
hu9M0OGgXjAcJ64ADbwfI6L5lnp/mpi4XzjAT56TnR9/bpyO2NtT0GOEkRnrLlMg
D2/vBGNn3VvnIqkfTHuW1gcj5KDwZXMfMn5XK90efSB9ON6Sfjw=
=E5st
-----END PGP SIGNATURE-----

--f3dq6t5hfgftofph--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AC2F8D26
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAPLod (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 06:44:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47938 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPLoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 06:44:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D88821F45E81
Received: by earth.universe (Postfix, from userid 1000)
        id 04B0B3C0C94; Sat, 16 Jan 2021 12:43:49 +0100 (CET)
Date:   Sat, 16 Jan 2021 12:43:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: ab8500_fg: convert comma to
 semicolon
Message-ID: <20210116114348.x5erkpwwzwfyowy3@earth.universe>
References: <20201214134000.4243-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mlj73v7fip325zvq"
Content-Disposition: inline
In-Reply-To: <20201214134000.4243-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mlj73v7fip325zvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 14, 2020 at 09:40:00PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>=20
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 592a73d4dde6..6594f09c993c 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -857,7 +857,7 @@ static int ab8500_fg_volt_to_capacity(struct ab8500_f=
g *di, int voltage)
>  	const struct abx500_v_to_cap *tbl;
>  	int cap =3D 0;
> =20
> -	tbl =3D di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl,
> +	tbl =3D di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl;
>  	tbl_size =3D di->bm->bat_type[di->bm->batt_id].n_v_cap_tbl_elements;
> =20
>  	for (i =3D 0; i < tbl_size; ++i) {
> --=20
> 2.22.0
>=20

--mlj73v7fip325zvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC0XQACgkQ2O7X88g7
+prf0w/+PKxWaHtDNVQAV/m6l0jduMXpwcWZPEiEGlpwrYa+xckr+dA6hwDLuzPt
NNYAm98rYVIX4/Yq2AtE3Y3YM4/q1lIXRh4PqcmFy8AB6InyRLH8xyv5LUZUWmyp
4vDBkovbxnc2IhGpi0wUVY+2GI8h+XYg/ToZwv/KxHtCjpsDB4F5umiArJORzSBx
wEA/Px5rdi6FihVxH1AuO/FLlEeVPI9Q0FmCs7p5isBQMhBl87I2mHQ5nEmYXoK5
wPV7D0N47WQ625G4LQ6huXRi9bLICHnkRckRBSiuIImBgWQZQg/5UJbMYMMJ5whE
qBRYQCXegAHir/Zj7qwqXIdflysxTnp9OXFxHBPsxuduAPv7ax9j7caNl9spI9Bt
5Ld7jtHmylOcjPTxTh8Yd4W0TO0qzjs1oBkBkcBU5ruXDY8Bv4hBiSjxGk8Keujs
Ib8aKp634wReEITyVhfV0EjTvp7Xccbx4/f01lX9crWH+1OwPuua/pFEGvh27nJO
sBRvm3YrV3mdBvAYhaouiK//TLlbwFpwuakQKEgaQ75IuOc8PCbsrwOKbu0GO//i
Ot6YjkMUbPK4CbV/NO3TzHB+0/iqT8g4Injgs9N9p1pMNy7cSchEcdZj7pFkYYwJ
XpI463bgtrq+n9DJ8QDWDEygBhbjKyF0UN4HvHczKkt2eVMa45Q=
=jBrW
-----END PGP SIGNATURE-----

--mlj73v7fip325zvq--

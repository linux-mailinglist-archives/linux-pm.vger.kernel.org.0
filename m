Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6113CE4F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgAOUws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:52:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48750 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAOUws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 15:52:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8FBA828EAC8
Received: by earth.universe (Postfix, from userid 1000)
        id C2D3C3C0C7C; Wed, 15 Jan 2020 21:52:43 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:52:43 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     l.stach@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] power: suppy: ucs1002: Make the symbol
 'ucs1002_regulator_enable' static
Message-ID: <20200115205243.mqhlgwxazdz4n3ob@earth.universe>
References: <20191220094144.41142-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hnlpxa6gspkazlpn"
Content-Disposition: inline
In-Reply-To: <20191220094144.41142-1-chenwandun@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hnlpxa6gspkazlpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued.

-- Sebastian

On Fri, Dec 20, 2019 at 05:41:44PM +0800, Chen Wandun wrote:
> Fix the following sparse warning:
>=20
> drivers/power/supply/ucs1002_power.c:492:5: warning: symbol 'ucs1002_regu=
lator_enable' was not declared. Should it be static?
>=20
> Fixes: a3d70dacc727 ("power: suppy: ucs1002: disable power when maxcurren=
t is 0")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  drivers/power/supply/ucs1002_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/=
ucs1002_power.c
> index 0ca80d00b80a..cdb9a23d825f 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -489,7 +489,7 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *d=
ata)
>  	return IRQ_HANDLED;
>  }
> =20
> -int ucs1002_regulator_enable(struct regulator_dev *rdev)
> +static int ucs1002_regulator_enable(struct regulator_dev *rdev)
>  {
>  	struct ucs1002_info *info =3D rdev_get_drvdata(rdev);
> =20
> --=20
> 2.17.1
>=20

--hnlpxa6gspkazlpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4fe5sACgkQ2O7X88g7
+po6jQ/+Irt0N8MOKBe+boPgXjEaA6LsQ9Ua1tMtYTjeX/ZJq3Vd+yJoPTzpxn5L
sf2Xpa9c8qc69XrJwXcJ32FNjkTLYjooC8aWjNcQOtE6hHcpW0hGITVCsImt+Chr
xbumKUl7hrX2h1eSTtNsU2r0okxk5Ct0MMIb7KmMdoiwO+Vq4l2CFjdh0N2Qw7V3
hGNaEw2DjYCt8WKEe7+owFeaEnFxedxOZYMYoQSNya/SOOgWKaufKI3BkMqhMQFG
3mqrL2BN/BAzV1flRK7BIDMpMtrTiskKfaYQW++AOI3Jmab9zyOu5hhie/WWcXwh
uUdxYWRh3UDRIyA4rHvxE9dkawWYmKmZeX2aVRalywE5zo2/dzMoBSd8kENM01Q6
8ocnp44v9elSwtB+UZKNGZLZWTCbdmyFAkMfq4hCCkIBGxNIXihwbFB+IHrTMuJi
v9qS+qJhTvO/uidA9lnrq8GsKy6lRU9KJNXngZG2oWinU4G+6flrTvJ+Hc2OsXwx
dr7xUBDwJaAKiNOQqeDwS9x8LKJ3Wh42DCNboOykLRzy6dFBYlkRaz9rmVimP7EG
yOk68F7C9PIXeOsjV3Ovz9egMqYQY9hhg746x157OY9M6RZP6xPwSNbxvWJOZLSm
zBIFVnTa5O3UjAqQn5yktnWnCANf2EY7NTXGQQ/n05IwSCsQPhg=
=8Odx
-----END PGP SIGNATURE-----

--hnlpxa6gspkazlpn--

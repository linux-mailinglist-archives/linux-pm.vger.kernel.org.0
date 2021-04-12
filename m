Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8867235D190
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbhDLT7y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 15:59:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbhDLT7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 15:59:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 188B71F44D1C
Received: by earth.universe (Postfix, from userid 1000)
        id E16903C0C96; Mon, 12 Apr 2021 21:59:30 +0200 (CEST)
Date:   Mon, 12 Apr 2021 21:59:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power/reset: Add missing MODULE_DEVICE_TABLE
Message-ID: <20210412195930.zyzgjwjzgkqhe4rc@earth.universe>
References: <20210410035040.11370-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ldtjcraeudyq4k5g"
Content-Disposition: inline
In-Reply-To: <20210410035040.11370-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ldtjcraeudyq4k5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 10, 2021 at 11:50:40AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/restart-poweroff.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset=
/restart-poweroff.c
> index d233daa5835b..04d4228119b2 100644
> --- a/drivers/power/reset/restart-poweroff.c
> +++ b/drivers/power/reset/restart-poweroff.c
> @@ -45,6 +45,7 @@ static const struct of_device_id of_restart_poweroff_ma=
tch[] =3D {
>  	{ .compatible =3D "restart-poweroff", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
> =20
>  static struct platform_driver restart_poweroff_driver =3D {
>  	.probe =3D restart_poweroff_probe,
>=20

--ldtjcraeudyq4k5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmB0ppkACgkQ2O7X88g7
+poKdQ//XfIG/zO5tro961sC5McdKqBvNfitlCdg2iZJHS+4tMMdZsqLrGXhYFUY
qZswkQpQtfoLRhNfTydFMuNE7+3WSwFWnoGXeZtm6i2KEyuhjhCszGyTBwlQd4c3
OV3N3M9biP/Oe6QZZxttTGK+MqUr6Uzs+qbGu7DSKtGLhicFPCsjkDrh5A69aimQ
IcCd6MBEQP48e/WlPK4PsJSRzbVI/Wb/qF9d6N/L4EGj12IXFRXhN4iRvwetx5Gg
Xi+VQRwChkeRyEmFh5/509esiN5ukE10NXdl2KSg8kx4bkoeI3bXdZCETiuuuIGD
wAsswybmBn/tysHFSY+u1dwURIajJTeHqaO+3/7doPd8//Uxo0lBaD8MtJln0eVx
1venlIu8vFgU7Ryb3nAZhVB35+w/kUjWp0nTY2Iblmq0qH5JrUnowFFnoAgtJepP
lLFLa0tcPRtksWhNMa3Zsw8/pm02v6uZi5KPY77dMuyqWTR5BO9VPOgE0i721IsZ
nJewRGsSPdx+DqFhyfYt+mcmsOESPNAki3+QSbv3APz4cEva5nufMQRWW2i/H0K6
w+lOEsiFVgBSNA6XzFZhVp5KbS0a8HQaroBLec9TJm+owipZ3/TKAnmYlOMXvVfE
JztOyMT8KcvH9xpIU75wpDM1pvGL+SKLep6p1paU57+MUZSm45o=
=gxXx
-----END PGP SIGNATURE-----

--ldtjcraeudyq4k5g--

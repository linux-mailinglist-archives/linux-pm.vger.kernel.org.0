Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB26D39A640
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFCQxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFCQxv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 12:53:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE88C06174A;
        Thu,  3 Jun 2021 09:52:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 45A3D1F417BA
Received: by earth.universe (Postfix, from userid 1000)
        id 272DC3C0C95; Thu,  3 Jun 2021 18:52:03 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:52:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Drop unnecessary NULL check after
 container_of
Message-ID: <20210603165203.qxueroi77sb4xwsx@earth.universe>
References: <20210511203711.1673001-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c4hmboxfmrz4g6am"
Content-Disposition: inline
In-Reply-To: <20210511203711.1673001-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c4hmboxfmrz4g6am
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2021 at 01:37:11PM -0700, Guenter Roeck wrote:
> The result of container_of() operations is never NULL unless the element
> is the first element of the embedded structure, which is not the case her=
e.
> The NULL check is therefore unnecessary and misleading. Remove it.
>=20
> This change was made automatically with the following Coccinelle script.
>=20
> @@
> type t;
> identifier v;
> statement s;
> @@
>=20
> <+...
> (
>   t v =3D container_of(...);
> |
>   v =3D container_of(...);
> )
>   ...
>   when !=3D v
> - if (\( !v \| v =3D=3D NULL \) ) s
> ...+>
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index a9be10eb2c22..f407cec49aa3 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3171,9 +3171,6 @@ static int ab8500_charger_usb_notifier_call(struct =
notifier_block *nb,
>  	enum ab8500_usb_state bm_usb_state;
>  	unsigned mA =3D *((unsigned *)power);
> =20
> -	if (!di)
> -		return NOTIFY_DONE;
> -
>  	if (event !=3D USB_EVENT_VBUS) {
>  		dev_dbg(di->dev, "not a standard host, returning\n");
>  		return NOTIFY_DONE;
> --=20
> 2.25.1
>=20

--c4hmboxfmrz4g6am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5CLMACgkQ2O7X88g7
+podVQ//ZlOKk8I8xZGuRAT8gKtTnB0d2jIrG9J0rH2iQwTJDJP7lqjZY6dCTfx9
G/HQPSDUNt5Swz4dtJwQJ2cb4KFDdVqoJvHfqKZbLE80iSRUOAd7gpLnKSU9TrW2
Lovjm3++qrQ6BksvMhR4JcF1U9mZ+3JIatd9zCIY1KGyXO6vtj6tqjZEi6NEdUlE
gHt8lmlBWFDfYEawecs/djKCIoTCEpXkklSX0IAwX6U5gOvnGHNX4MRrjtYA8B1R
odibul9OSJ3cK+1aBHH4sjvtUmVzpDdRcaGhZMewr0UxJBFJJ4N9ALxoC2RhBlbF
0J7P7WttjSvxc/FG/LG90ZFtM8Rd6L5LM1vr6x1aDuk9QxkRfySS+9oFs7KQxTGJ
N4nU4zl8sPCCrPc4oYvOIM00kgKgWLt6TC6s7BLWjBpTQRG1OqXIOmE7zgTabZGm
J9lKdbeV+3POZFCqGUrIaaz6zuUGwDNJgSB968cVai/v3VH3VWZm6bKtQFxN3qFC
FmuZnTQobTFAPQD03ZwKZYxKvLWOkDk70adbN6P9HYEJDq7zpJIsee5ACQAjX3WG
/vazolvNy0Xyaj0z9XT7hLIHxshIFN6FeEREKG0ZEj8stFR52xJunn8zTVLMdLkl
o1279P1oJxE91w7MUO0kVVKpItj/1/jaEqJOyodNuF4rfeC7I0M=
=K2AW
-----END PGP SIGNATURE-----

--c4hmboxfmrz4g6am--

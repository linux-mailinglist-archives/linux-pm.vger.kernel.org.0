Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16712591C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLSBNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:13:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39448 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSBNe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:13:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 35BD0292A17
Received: by earth.universe (Postfix, from userid 1000)
        id 1A4BF3C0C7B; Thu, 19 Dec 2019 02:13:31 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:13:31 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] power: supply: sbs-battery: use octal permissions on
 module param
Message-ID: <20191219011331.kp2ifdswwfarq5bj@earth.universe>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4hu4uqhh7xglktg"
Content-Disposition: inline
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k4hu4uqhh7xglktg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 01, 2019 at 03:06:59PM -0400, Jean-Francois Dagenais wrote:
> Symbolic permissions 'S_IRUSR | S_IRGRP | S_IROTH' are not
> preferred. Use octal permissions '0444'.
>=20
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 048d205d7074..0e66968dabc3 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -994,6 +994,6 @@ module_i2c_driver(sbs_battery_driver);
>  MODULE_DESCRIPTION("SBS battery monitor driver");
>  MODULE_LICENSE("GPL");
> =20
> -module_param(force_load, bool, S_IRUSR | S_IRGRP | S_IROTH);
> +module_param(force_load, bool, 0444);
>  MODULE_PARM_DESC(force_load,
>  		 "Attempt to load the driver even if no battery is connected");
> --=20
> 2.23.0
>=20

--k4hu4uqhh7xglktg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36zroACgkQ2O7X88g7
+pqiVg//ZRYUeSJ0oP8UvjeEmoMU+p9N2wMJGDexpNTW96z4UHH3X3uuP45Rr73x
TKOrGOSNgjbC8lXEj9RBhT9Xkhk7rDE1h97KvHQl1Zlft1Uxt2FWya+kzskVI0lk
8FrKWQUK13rKHeoYoXisqWsYEr5NLeblMASeyTf31aliswVdfMOR+/W2eAFZAHhU
YbtsAAVvX+6i0VjY42AEm8YQPa0G8cbW4pM3GYfqEDo/Fdtk/06cKb+c3ARR9GYk
Zbo3eYtHB4Fs+7Bg9joxmHWQBmTKNZXbEG9DfgMiIu9LxzJaBxaFzRBye6yCYiBz
0+4Kco8p0qxFEB0FyL7/2H6ik3DhqjkLWE+jIRNa6FOGKdKF1/stt40oZl2WDSGQ
ksG5ss29pXrHj/lYRZ8APnmy+Q/kbxLWWd9RbYasMEiP9PUzKB35E+zAi2WIoycZ
BYiqQpJlQLGvf2ndyxdrCW3xCF0qtHhpw1OZ42mMp4FEZfp05KLckWLRFhxEtw5X
KcCnHb30Ucxx6ySENWz6XBPFsxzMDbgcC7mjIMi5JgRIxMWhkMTWjEr/C42lKE89
1pihLPw0SRIX52f6CURtDvrEumg8V8mOABKsb/otWM6lY4in0Qrdgcq/YeM1DoAk
ocNwjNfiZOHsQ+fCcsxmxKtbbQWfIB/j9Yo+QAhBz02wkQ+z5mw=
=LxI0
-----END PGP SIGNATURE-----

--k4hu4uqhh7xglktg--

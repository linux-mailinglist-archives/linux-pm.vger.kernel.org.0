Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27601CCD58
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 21:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEJTvE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbgEJTvE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 15:51:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC744C061A0C;
        Sun, 10 May 2020 12:51:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A6A532A08CD
Received: by earth.universe (Postfix, from userid 1000)
        id AA8803C08C7; Sun, 10 May 2020 21:50:59 +0200 (CEST)
Date:   Sun, 10 May 2020 21:50:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-pm@vger.kernel.org, brendanhiggins@google.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH] lib: linear_ranges: Add missing MODULE_LICENSE()
Message-ID: <20200510195059.dijv6ysac42a6nuq@earth.universe>
References: <20200509151519.GA7100@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yg3s6qf7ohrjd3se"
Content-Disposition: inline
In-Reply-To: <20200509151519.GA7100@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yg3s6qf7ohrjd3se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 09, 2020 at 06:15:19PM +0300, Matti Vaittinen wrote:
> When linear_ranges is compiled as module we get warning
> about missing MODULE_LICENSE(). Fix it by adding
> MODULE_LICENSE("GPL") as is suggested by SPDX and EXPORTs.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>=20
> I saw Mark applied the linear-ranges patch. So I sent this fix as
> incremental patch - but I still use the same Linus tree as a base of
> this fix - the linear-ranges file should be unchanged in regulator tree.
> If this does not apply I can clone regulator tree and create this fix on
> it.
>=20
> I don't know if this is the correct way to fix this as the linear-ranges
> should be merged to power-supply tree.
>=20
> I guess we can either:
> - Use this patch to fix regulator tree and create fixed tag for
>   power-supply(?)
> - Add this fix in the original series and resend whole series(?)
> - re-create the series and drop the already applied patches. Add this
>   fix as a fixup patch in new series and apply it to power-supply tree
>   after the linear-ranges from regulator is merged to power-supply.
>=20
>  Please adviece me if this patch is not the way to go.
>=20
> Oh, and I am really sorry for the trouble. I saw I had regulators=3Dy
> in all of my compilations due to some pincontrol dependencies. So
> linear-ranges was not built as module in any of my test compilations :(
>=20
> Thanks for testing Mark!

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I think it makes sense to just queue this through the regulator tree.
Apart from that you should add a MAINTAINERS file entry for the
linear_ranges lib. Main user is regulators, so future patches should
probably be queued through its tree.

-- Sebastian

>  lib/linear_ranges.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
> index d1336c75ccd7..9495ef3572b7 100644
> --- a/lib/linear_ranges.c
> +++ b/lib/linear_ranges.c
> @@ -12,6 +12,7 @@
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/linear_range.h>
> +#include <linux/module.h>
> =20
>  /**
>   * linear_range_values_in_range - return the amount of values in a range
> @@ -239,3 +240,6 @@ int linear_range_get_selector_high(const struct linea=
r_range *r,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
> +
> +MODULE_DESCRIPTION("linear-ranges helper");
> +MODULE_LICENSE("GPL");
> --=20
> 2.21.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20

--yg3s6qf7ohrjd3se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64Wx0ACgkQ2O7X88g7
+pofrw//YFyv13THGq5MxNK50UVeuJkY4S79XhCf8X1P09EnZRmVkD1bZUgQ1McD
yLW7YB8JAJ8XVtbJ1Mh4/uoyppdW9RrqnBbzdRNpU79eVb/sF7/sZHHsfFC8WHdz
Ff2XXQBEy0vu6dyEbaXkiTzYgfRAt5e04FQ4I/pFWtwEguCcx5LqV7lzYfhtNfTK
bmR+dtnnrPu/otNNNHKKTXYj+HQijNyRviVzrbNRlZmYL78Bjfqjp46SXAvktK6/
RzqwtKyV9UpmY33oiiXhTP5q4Wg8SCQ8hFNj8fgFT4hecm8hO4S8aNojPrtJvjzk
7hSO76elClvE0GjFN3b/GuqpUM5FApqeTM047Ml0UO1+P9n6mxHiNOXPMPl1mdvB
2WjNOii30IOZYAsrasPY+oHBkpSHdSN3u1e+rsEBHqzbHNm729GZtzHDh8t4NzrT
6cKDHf7LvP3og+xzm8PYgGj5biqo3wzqQtkN93kYd0DvpQ5OZPx4qDPgPJtVqUwT
3jWy1zw4GacA2KjQn13pGoMDbZbKWEpkQKk9lQc5levoBxORYazzHKC66QYP3VLt
gO1N0YCHmog90krF9x0Po31G+YhSacmFkUsbW16zkw472/oWKhol5cyNHWEiBw0l
QF3Uep26aL5XE/Hd8+553tm9+ZHZev+hh291neLz2GdTywCXeT0=
=fi0g
-----END PGP SIGNATURE-----

--yg3s6qf7ohrjd3se--

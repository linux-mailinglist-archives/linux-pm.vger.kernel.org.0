Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD8354127
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhDEKUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhDEKUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 06:20:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC3C061756;
        Mon,  5 Apr 2021 03:19:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0E9DB1F449BA
Received: by earth.universe (Postfix, from userid 1000)
        id A3B813C0C96; Mon,  5 Apr 2021 12:19:52 +0200 (CEST)
Date:   Mon, 5 Apr 2021 12:19:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: power: supply: add entry for S3C ADC
 battery driver
Message-ID: <20210405101952.itm5xxthn4qphj3u@earth.universe>
References: <20210210172108.334896-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="royifewygga4fejm"
Content-Disposition: inline
In-Reply-To: <20210210172108.334896-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--royifewygga4fejm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 10, 2021 at 06:21:06PM +0100, Krzysztof Kozlowski wrote:
> The S3C ADC battery driver is a very old piece of code but still used by
> (very old as well) S3C24xx platforms (iPAQ h1930/h1940/rx1950).
> Currently the header file is not covered by maintainers file, so it
> might look abandoned.  Add a new entry for entire S3C ADC battery driver
> with Krzysztof Kozlowski as maintainer (as Krzysztof maintains still
> Samsung S3C24xx platform) to indicate that some basic review can take
> place.
>=20
> However considering that the S3C24xx platform is quite old with only few
> users currently and Krzysztof does not have the actual hardware, let's
> mark the driver as "Odd fixes".
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, much appreciated. I queued this series some time ago, but
forgot to send a notification.

-- Sebastian

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f7aa507b812..6abf7cc513df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15614,6 +15614,13 @@ S:	Supported
>  W:	http://www.ibm.com/developerworks/linux/linux390/
>  F:	drivers/s390/scsi/zfcp_*
> =20
> +S3C ADC BATTERY DRIVER
> +M:	Krzysztof Kozlowski <krzk@kernel.org>
> +L:	linux-samsung-soc@vger.kernel.org
> +S:	Odd Fixes
> +F:	drivers/power/supply/s3c_adc_battery.c
> +F:	include/linux/s3c_adc_battery.h
> +
>  S3C24XX SD/MMC Driver
>  M:	Ben Dooks <ben-linux@fluff.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> --=20
> 2.25.1
>=20

--royifewygga4fejm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq5EgACgkQ2O7X88g7
+pouPA/+JJt47wBPf5nSss12X06nU0PBmJqvJI2u7ft7BX1GDlO/r06M6dJJGbI+
B8+H3tFh1usN7HMxY4u4un2VsnF69q3TQNzQIXRWmrnDU+VTDidEnl82L9g6oIFR
nCSQLvyiZQJjQJL7F8C4gjwwDslKvhXnKQg9dIP2kUMA/aMAThkx9M8QBJuPLezZ
sc4VqZyZyuIo1tVRwojHjbNV2i4gUlbYSO8ugnc0uPUxoc4RWGiAwvAaWj/AXovI
eT9I9uPDV57uu+jYUg8HxFxvYxZxUSw2x8pEAfhBp1mlt7Ih4I6jCDfhw/efgXQw
DDahWmSXtTUkBgf05QTikIH5zquG9P7KiNr3Vq0aOyOLTwj4aHZ8N82W9i/PnpKv
EDeye+3nF51UfNPvc5pdePrQBWEAqcneiG61F7oGDRsdQJ40wh8s8QchN2RAO1uJ
FEyHLpliJ0wK4aLOGcT4Y2C//VcPaJHh7UP/ugzaCMkJBVXHwo2af9S+pvUVGZHX
drKQt7ymEumPhkRG+xietbH3mg9vRlIR/9YJpLbhYZyqP5mIIRKJRfGhu3VevlEc
EaLra3B9MggIp2D5pS7h/ViZ3PMp25EFJZFc78mP/IIDwOIafnRvLdKJunQyfDO6
oOPkYqmb8g5/hdeOY5FxtlRHiq1gCGITnbLdgd3/XFdcFF9MSew=
=q3bO
-----END PGP SIGNATURE-----

--royifewygga4fejm--

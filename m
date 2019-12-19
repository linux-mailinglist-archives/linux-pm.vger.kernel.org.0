Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34C012590C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLSBEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:04:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39384 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSBEx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:04:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9073D2911A3
Received: by earth.universe (Postfix, from userid 1000)
        id 2F2903C0C7B; Thu, 19 Dec 2019 02:04:49 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:04:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: Fix Kconfig indentation
Message-ID: <20191219010449.hqwpyconyywymrti@earth.universe>
References: <1574306395-12906-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vs4cusmq2csjes2"
Content-Disposition: inline
In-Reply-To: <1574306395-12906-1-git-send-email-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6vs4cusmq2csjes2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 21, 2019 at 04:19:55AM +0100, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---

Thanks, queued.

-- Sebastian

> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.
> ---
>  drivers/power/reset/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index c721939767eb..0498363203e8 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -141,14 +141,14 @@ config POWER_RESET_LTC2952
>  	  down via the LTC2952. Bindings are made in the device tree.
> =20
>  config POWER_RESET_MT6323
> -       bool "MediaTek MT6323 power-off driver"
> -       depends on MFD_MT6397
> -       help
> -         The power-off driver is responsible for externally shutdown down
> -         the power of a remote MediaTek SoC MT6323 is connected to throu=
gh
> -         controlling a tiny circuit BBPU inside MT6323 RTC.
> -
> -         Say Y if you have a board where MT6323 could be found.
> +	bool "MediaTek MT6323 power-off driver"
> +	depends on MFD_MT6397
> +	help
> +	  The power-off driver is responsible for externally shutdown down
> +	  the power of a remote MediaTek SoC MT6323 is connected to through
> +	  controlling a tiny circuit BBPU inside MT6323 RTC.
> +
> +	  Say Y if you have a board where MT6323 could be found.
> =20
>  config POWER_RESET_QNAP
>  	bool "QNAP power-off driver"
> --=20
> 2.7.4
>=20

--6vs4cusmq2csjes2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36zLEACgkQ2O7X88g7
+pogZg//VdCdZ79V71shkba9VYra6IoHJseyBBTafueLgDSUgMz1ue4W7wTIiOpw
jzUsaLuaV4jnXaL8fqzAJuCgylOfSLdpHDZkkzWW2YARB7hgshieOIwBrWzgfQAk
E++BEbTdjXbcxna3CpuaSiwuWmh6jfb+YoMu+oSzY2KvbTg8EmiSbfNh8WvNgXBP
XNSqEtNlLtdvfkbDvtX1HScGvcF7KlCvacax/2PXBOwywC5DEw7XTENd0Jpqyl96
zD7c9rVZZhk9w9rYXD7fk//xvKrKAdSfG9Ub6BWW/AncpU1RGxPreBje7KMAtRp6
cQ4cgoIlNitrD+tNheRRdii7fyDqyIl2YRwZ+Ckgj4LcwhoDMNDwOpLdZR1fOtxA
+dgrmitmEv6KSwyrmNTDIN9rQFlKOSFkokxn9GCP0WfDj710tsShNBHn7NGtOZ9y
c5i33dQNBcUPL+Ep8B+tb8nwLrPm3OrR2ptN7AJ82CYIBH9O+6cT1nl4Bjt+DU9N
NVdhVrACsu4Feutx8gHzlqF5lJYx9HWg84ngEi1cYhSVK25kv2rOMufPxanK+ULC
QEJiFWWlcyMmuVHdHglgzSZBFFnmPZkVoDo27/DchVIYUOnevTBzxxOIG6/MyP5p
CUarJceGzYNSnf3qESDp6IAQ5debhOPi+B71MjkNfHirsXG9ZNg=
=PQMd
-----END PGP SIGNATURE-----

--6vs4cusmq2csjes2--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183642C84B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMSFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 14:05:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80DC061570;
        Wed, 13 Oct 2021 11:03:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 151381F44750
Received: by earth.universe (Postfix, from userid 1000)
        id 51AFB3C0CA8; Wed, 13 Oct 2021 20:03:40 +0200 (CEST)
Date:   Wed, 13 Oct 2021 20:03:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Specify variations of MAX8903
Message-ID: <20211013180340.hm6kyu45xo3hjofx@earth.universe>
References: <20210915110340.17411-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loq3b2vznypewfyg"
Content-Disposition: inline
In-Reply-To: <20210915110340.17411-1-ramona.nechita@analog.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--loq3b2vznypewfyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 15, 2021 at 02:03:40PM +0300, Ramona Alexandra Nechita wrote:
> MAX8903 has multiple variations (A-E/G/H/J/N/Y).
> Specified them in the Kconfig and in the file comment.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---

why? I would expect people to identify this as the correct driver
without this list and it's definetly not grepable.

-- Sebastian

>  drivers/power/supply/Kconfig           | 2 +-
>  drivers/power/supply/max8903_charger.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c84a7b1caeb6..cca779480b1c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -442,7 +442,7 @@ config CHARGER_ISP1704
>  	  ISP1707/ISP1704 USB transceivers.
> =20
>  config CHARGER_MAX8903
> -	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
> +	tristate "MAX8903A/B/C/D/E/G/H/J/N/Y Battery DC-DC Charger for USB and =
Adapter Power"
>  	help
>  	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
>  	  The driver supports controlling charger-enable and current-limit
> diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/suppl=
y/max8903_charger.c
> index 0bd39b0cc257..4e5c669e6607 100644
> --- a/drivers/power/supply/max8903_charger.c
> +++ b/drivers/power/supply/max8903_charger.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * max8903_charger.c - Maxim 8903 USB/Adapter Charger Driver
> + * max8903_charger.c - Maxim 8903A/B/C/D/E/G/H/J/N/Y USB/Adapter Charger=
 Driver
>   *
>   * Copyright (C) 2011 Samsung Electronics
>   * MyungJoo Ham <myungjoo.ham@samsung.com>
> --=20
> 2.25.1
>=20

--loq3b2vznypewfyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFnH3cACgkQ2O7X88g7
+ppraxAAmBHpPrSMWVjrKINz4Q7A7H0HE8jknIDyv+rzZfR9E12Ohru36WTgevp3
HVbhic2D8TTeXbPCPt7X8ouhhYyHYm0a2kl0yCY8AYvIUi9oP9zvGQqyQhfaU1sB
miawyT2vro5j8m4lttsATleUyOGtnPg7ITT4iH413zxnrYPrgY7y+plmDcw2s+Cq
cjSrA/jtuxX0OeG9PG1CFuam+fZMIgEbicBUP5eAkwG6W+N2aa1sI2ZaZeYMbSnB
inXXUbgVGvtYEYvsHyYQscCWMaZmemIrrygr6ROhy1rV3Nj6qpAF3lerwin8vqPV
Szy5uN2ZNyRSzhsSTr12QRchtVJwEofVYqL6I8rNRL087397nD5gLFQ16reMSgr5
XG/Df3+PrpfxPgEzVOzB18SpBw0WFUnRCCClDD+fnfGzBcdLE/9fajp/7SZ6Wp+k
UJ4PKoCzTpgaB0AnTVuQsgLqqEtGZRQQUthqD6nWegakM0xzg7ApcJuoMpyLcTRr
11ce5HpYtSIZjhKTGAvQTeyIUSlXcjXYSfiWLs9Jdq2Ip4kdds4TC1Zc417TWw4M
moUorDk569s1IwZUrlMsczt4j+2JuQ1y84Xc/ISg9+aUlw5tgLzcP/XsXTD9YJb4
KbEkL6S/bSH5t41qycF4xJ5Eo5oHJVKVGXfN4myP/6nNxxZ+qc8=
=R4LM
-----END PGP SIGNATURE-----

--loq3b2vznypewfyg--

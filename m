Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3432F400F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbhALXQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 18:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhALXQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 18:16:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520EC061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 15:15:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2F1E71F45558
Received: by earth.universe (Postfix, from userid 1000)
        id 208513C0C94; Wed, 13 Jan 2021 00:15:40 +0100 (CET)
Date:   Wed, 13 Jan 2021 00:15:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/2] power: supply: max8903: Absorb pdata header
Message-ID: <20210112231540.tf5lywpuptiwecpk@earth.universe>
References: <20210110140200.127123-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2urnyburjehkze3"
Content-Disposition: inline
In-Reply-To: <20210110140200.127123-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--x2urnyburjehkze3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 10, 2021 at 03:01:59PM +0100, Linus Walleij wrote:
> The platform data header is not included by any other file in
> the kernel but the driver itself. Decomission the stand-alone
> header and absorb it into the driver itself.
>=20
> Cc: Chris Lapa <chris@lapa.com.au>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8903_charger.c | 32 ++++++++++++++++++-
>  include/linux/power/max8903_charger.h  | 43 --------------------------
>  2 files changed, 31 insertions(+), 44 deletions(-)
>  delete mode 100644 include/linux/power/max8903_charger.h
>=20
> diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/suppl=
y/max8903_charger.c
> index 0bd39b0cc257..ab1aa7df985e 100644
> --- a/drivers/power/supply/max8903_charger.c
> +++ b/drivers/power/supply/max8903_charger.c
> @@ -15,7 +15,37 @@
>  #include <linux/slab.h>
>  #include <linux/power_supply.h>
>  #include <linux/platform_device.h>
> -#include <linux/power/max8903_charger.h>
> +
> +struct max8903_pdata {
> +	/*
> +	 * GPIOs
> +	 * cen, chg, flt, dcm and usus are optional.
> +	 * dok and uok are not optional depending on the status of
> +	 * dc_valid and usb_valid.
> +	 */
> +	int cen;	/* Charger Enable input */
> +	int dok;	/* DC(Adapter) Power OK output */
> +	int uok;	/* USB Power OK output */
> +	int chg;	/* Charger status output */
> +	int flt;	/* Fault output */
> +	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
> +	int usus;	/* USB Suspend Input (1: suspended) */
> +
> +	/*
> +	 * DC(Adapter/TA) is wired
> +	 * When dc_valid is true,
> +	 *	dok should be valid.
> +	 *
> +	 * At least one of dc_valid or usb_valid should be true.
> +	 */
> +	bool dc_valid;
> +	/*
> +	 * USB is wired
> +	 * When usb_valid is true,
> +	 *	uok should be valid.
> +	 */
> +	bool usb_valid;
> +};
> =20
>  struct max8903_data {
>  	struct max8903_pdata *pdata;
> diff --git a/include/linux/power/max8903_charger.h b/include/linux/power/=
max8903_charger.h
> deleted file mode 100644
> index 02f94a1b323b..000000000000
> --- a/include/linux/power/max8903_charger.h
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * max8903_charger.h - Maxim 8903 USB/Adapter Charger Driver
> - *
> - * Copyright (C) 2011 Samsung Electronics
> - * MyungJoo Ham <myungjoo.ham@samsung.com>
> - */
> -
> -#ifndef __MAX8903_CHARGER_H__
> -#define __MAX8903_CHARGER_H__
> -
> -struct max8903_pdata {
> -	/*
> -	 * GPIOs
> -	 * cen, chg, flt, dcm and usus are optional.
> -	 * dok and uok are not optional depending on the status of
> -	 * dc_valid and usb_valid.
> -	 */
> -	int cen;	/* Charger Enable input */
> -	int dok;	/* DC(Adapter) Power OK output */
> -	int uok;	/* USB Power OK output */
> -	int chg;	/* Charger status output */
> -	int flt;	/* Fault output */
> -	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
> -	int usus;	/* USB Suspend Input (1: suspended) */
> -
> -	/*
> -	 * DC(Adapter/TA) is wired
> -	 * When dc_valid is true,
> -	 *	dok should be valid.
> -	 *
> -	 * At least one of dc_valid or usb_valid should be true.
> -	 */
> -	bool dc_valid;
> -	/*
> -	 * USB is wired
> -	 * When usb_valid is true,
> -	 *	uok should be valid.
> -	 */
> -	bool usb_valid;
> -};
> -
> -#endif /* __MAX8903_CHARGER_H__ */
> --=20
> 2.29.2
>=20

--x2urnyburjehkze3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+LZsACgkQ2O7X88g7
+ppjGg/+KMR+WWy0+xdTQVBQORzTlBQeaIzG+gnBsNX7KLtyLZ5KgqwxC/NDgi8T
t8m2Z/L4X9j8sg3WcKVWMQ8zVyxK7Hypw/T0HBN/cI/gYE39Nvrf3ICc5xF+fSCr
vlIVpYIaAfiXeHn+VMpOGJr417BtLGhpGdNf6DgC6mIz4+diiTLZN8/tMWmg+XSE
G22Cbu3/25+khgkaFR2ib0u12sPxXaVMVnZy2TfvrAxrkaIGCj9lNboG6x0PEIzK
85XgdASzbL2o86hmx9Hq0+Du6VbrJbw4MXhczNQv+WaYfWmyLa8Zppw6uS2qnZpH
t94H7xKqtnKkOcqxuHKho8HL2ScN7PN9SEKQD5MaexCFDKQjFLgH9ja9KjpOWP9B
Ue+5XhtJgTaqheWau00CTjYVRCq/mokt63E9jW6+MoQWGQnWxNUHXPpnT+JhKDKs
hAeRodIqzMeGvOc/uzYqU1iaQ3H0EMDwOM0JvCkgSbq6gdvPh7lnM8FSHvm/Mtgz
VQOejoGdj/2LW1db7dWBaK9Qb+Hxv3owzZNNx2XKO10WCV3bnMlghbMCsCDPvkIg
gRT7xGPUNAuwulnIIFosHI0pl0bwCFlFKDq0SEVuQZxM1xfXTS00vJ7l7uSlVE1D
VFWhWOvRx5FvIGoV6vtmOpPfUc5JdyflMT8ufi6iBXz3s9h4/KE=
=tZoP
-----END PGP SIGNATURE-----

--x2urnyburjehkze3--

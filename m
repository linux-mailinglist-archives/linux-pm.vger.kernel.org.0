Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393ED481F5D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhL3TET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 14:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhL3TET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 14:04:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E2C061574
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 11:04:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n30in-0000R5-Bw; Thu, 30 Dec 2021 20:04:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n30il-007XDP-9M; Thu, 30 Dec 2021 20:04:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n30ij-0003ve-Ny; Thu, 30 Dec 2021 20:04:13 +0100
Date:   Thu, 30 Dec 2021 20:04:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>, alvin@alvinhc.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: Kconfig: simplify dependency of THERMAL_HWMON
Message-ID: <20211230190413.3zxp36oj72sbunwa@pengutronix.de>
References: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0hWYJikZnt9NZHv+3GeMCLU-BtQciKcuazEDST_541nEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hztwvx4r4y65ojug"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWYJikZnt9NZHv+3GeMCLU-BtQciKcuazEDST_541nEw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hztwvx4r4y65ojug
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 30, 2021 at 04:37:20PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 20, 2021 at 10:58 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > THERMAL is bool (since commit 554b3529fe01 ("thermal/drivers/core:
> > Remove the module Kconfig's option") in v5.2-rc1) and so cannot be
> > configured as a module. As THERMAL_HWMON also depends on THERMAL (via a
> > big if block in drivers/thermal/Kconfig) the condition
> >
> >         depends on HWMON=3Dy || HWMON=3DTHERMAL
> >
> > is equivalent to the simpler
> >
> >         depends on HWMON=3Dy
> >
> > . Use the latter.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> The change looks reasonable to me, but 0-day is evidently unhappy with
> it.  Can you have a look at its replies to this message, please?

0-day isn't happy because I only wrote HWMON=3Dy in the commit log, but
not in the Kconfig. The bot should be improved to better understand
the intention of a patch :-)

> > ---
> > Hello,
> >
> > I want to use this patch as an opportunity to question if THERMAL being
> > a bool and not a tristate is still considered the right thing to do.
>=20
> IIRC there are correctness concerns regarding modular THERMAL.

In the commit log of 554b3529fe018 this sounds more like modular being a
burden to maintain because most systems use =3Dy anyhow.

> > This dependency attracted attention in the context of the armel Debian
> > kernel which has HWMON=3Dm for binary size reason. When THERMAL was
> > changed to bool this resulted in THERMAL_HWMON not being available any
> > more.

So on these systems THERMAL_HWMON is forced to be off, which I guess is
still less correct than THERMAL=3Dm?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hztwvx4r4y65ojug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHOAqoACgkQwfwUeK3K
7Alcgwf/R2ykkpAKXniWEIh0NKTUz626ajcRx1NjqmJg8WtwmTUuqmQG4fEFvq0k
053xMhC6FJsq+LPaKgJOaH8PYEcrM7dDEtqzBZQqZyW+QIhDAOKnCebayPm7YRrr
B6kp+JKm9SkO+CAogMkQuGXCuVfIoWLKCP2PAps4yPv2ckqMLwRvxTlhZUAoFMvw
M1nMfBMQLMV6c/Jxk9vf/JMNeS6x9No7N/cvQT+TidKY25wWmV8eUAIpbIxqbe0g
FYDlmw1hyTxlFDP6LE6BgKc+ImG4VvtZj8rweey5mYh5T9Q835AOOcJ9YLOaHWcT
gauzQXzM2ZI2tv1rHECcwVnLBHYGgw==
=BSE+
-----END PGP SIGNATURE-----

--hztwvx4r4y65ojug--

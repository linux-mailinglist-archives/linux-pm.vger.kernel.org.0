Return-Path: <linux-pm+bounces-670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6B8031CC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599781C20A35
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A422EFC;
	Mon,  4 Dec 2023 11:55:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C4D3
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 03:55:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7Xi-0000dh-PN; Mon, 04 Dec 2023 12:55:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7Xh-00DVSK-Pl; Mon, 04 Dec 2023 12:55:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7Xh-00E1So-Gg; Mon, 04 Dec 2023 12:55:17 +0100
Date: Mon, 4 Dec 2023 12:55:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Message-ID: <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
References: <20230712094014.41787-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wql4bbahif3ubg5s"
Content-Disposition: inline
In-Reply-To: <20230712094014.41787-1-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--wql4bbahif3ubg5s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Can you pick this up?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wql4bbahif3ubg5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVtviQACgkQj4D7WH0S
/k5RVAf9GssNsesa0iKADCcIdZ5sTs4QcBmxOLz6FhLgc0e4kZB7HPxoLP9t+VbV
/qR0w8tyX3KPQEcdEuRc8jkmlCJczPAs5t6T7eKW3YQsYesBdW/ACDge6hnjC0Ja
H/KmLgaZD39rcdSrOmVY4vFzo04sXVkiCqEFKUAwWs9ahF75Jru3Ei40M79JQuXm
g87s15i2rzUqpN+LQN26ZMH5T9HYneFmPjZRoypYr7mSeewcKewmWhS3qJbJKJ3/
1qtx6IaaO05+QJdEud87Bch0Dxa2N10XKrD4teSpvQdAy5tPTRwSFGPylQG6Zs7n
1E7r/q9XvnhWwDxLuqUrtok8vVuEDw==
=HURS
-----END PGP SIGNATURE-----

--wql4bbahif3ubg5s--


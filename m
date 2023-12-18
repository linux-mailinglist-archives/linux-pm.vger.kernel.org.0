Return-Path: <linux-pm+bounces-1333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D070817C40
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 21:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B0B1C21E7F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A47206D;
	Mon, 18 Dec 2023 20:48:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437C73498
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKXh-0001h2-EW; Mon, 18 Dec 2023 21:48:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKXf-00GmT7-Kp; Mon, 18 Dec 2023 21:48:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKXf-005XK5-BY; Mon, 18 Dec 2023 21:48:47 +0100
Date: Mon, 18 Dec 2023 21:48:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Guillaume La Roque <glaroque@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-amlogic@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, 
	kernel@pengutronix.de, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] thermal: amlogic: Two cleanups
Message-ID: <7r2dj6eggv5lb4j7twcooykvahwnyhqay3evqjclu33z47dm7c@guvng32lhvtj>
References: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kdaskvvreg6ybvsg"
Content-Disposition: inline
In-Reply-To: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--kdaskvvreg6ybvsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 16, 2023 at 12:26:34PM +0100, Uwe Kleine-K=F6nig wrote:
> while rebasing my patch stack to v6.7-rc1 I spotted these two patch
> opportunities for the amlogic thermal driver.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (2):
>   thermal: amlogic: Make amlogic_thermal_disable() return void
>   thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

gentle ping! Is there a chance these patches make it into v6.8-rc1?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kdaskvvreg6ybvsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWAsC4ACgkQj4D7WH0S
/k4HOQf/d2TKH9Kv+h5Y+EiK234Xli8lpNbzNN3mB1J3KCVAyHeYVFJh+kkXjN/Y
t79hpexVXl5IJGLHHddDd1Qvv/fVC3in7h6vXEa44dqxpRCtMV23+zux3UXvZPfr
X/w49Ufsu0jwGQjYMr0p0yt949QNY2u+Pl7mod0Z/m0q63hCk7aG9XpgoCOZ1C4E
eS2b4k2X252WUR/dJUTHgrPIV3znpRotrP79FgbsnPmWbCVY26hljzzMYFj3YX/f
HTZ9JC8JgfkIPAr94s0mJcMZoC+qobMgGbUO+7ugVOtmjiE0Cmg6iL9FqqDCrh0M
Rt8kqVbF//la/b2B0Ahjauq/30FePg==
=Ix8U
-----END PGP SIGNATURE-----

--kdaskvvreg6ybvsg--


Return-Path: <linux-pm+bounces-1035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECED810B6F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B53B20F96
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDC18B15;
	Wed, 13 Dec 2023 07:25:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B3BD
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 23:25:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDJcR-0005Io-CZ; Wed, 13 Dec 2023 08:25:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDJcP-00FWGt-JT; Wed, 13 Dec 2023 08:25:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDJcP-0029iG-9n; Wed, 13 Dec 2023 08:25:21 +0100
Date: Wed, 13 Dec 2023 08:25:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Yangtao Li <frank.li@vivo.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] power: reset: at91: mark at91_wakeup_status non-__init
Message-ID: <20231213072521.z7a37uayjide7ui4@pengutronix.de>
References: <20231212214658.213510-1-arnd@kernel.org>
 <20231212215002.GA3300655@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2h7skrbthp4xldgb"
Content-Disposition: inline
In-Reply-To: <20231212215002.GA3300655@dev-arch.thelio-3990X>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--2h7skrbthp4xldgb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Justin Stitt from Cc, their email address bounced for me in the
past]

On Tue, Dec 12, 2023 at 02:50:02PM -0700, Nathan Chancellor wrote:
> On Tue, Dec 12, 2023 at 10:46:49PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > Two copies of the at91_wakeup_status() function are called by the
> > respective probe() callbacks and are marked __init, but the probe
> > functions are no longer annotated that way. This works with gcc because
> > the functions always get inlined, but clang keeps them separate, which
> > can lead to executing freed memory:
> >=20
> > WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff=
_probe+0x80 (section: .text) -> at91_wakeup_status (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_pr=
obe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)
> >=20
> > Drop the incorrect annotation on these.
> >=20
> > Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_pl=
atform_driver_probe()")
> > Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using modu=
le_platform_driver_probe()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Thanks, I sent the same change three weeks ago at this point:
>=20
> https://lore.kernel.org/20231120-fix-at91-modpost-warnings-v1-1-813671933=
863@kernel.org/
>=20
> Your commit message is a little better than mine and I don't really care
> which one goes in but it would be good if this could get cleared up
> soon...
>=20
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I don't care either. Given the change is identical (Nathan's submission
even has "index 126e774e210c..93eece027865 100644" which exactly matches
Arnd's patch), I'll forward my Reviewed-by: tag to here:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2h7skrbthp4xldgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV5XGAACgkQj4D7WH0S
/k55KQf9GUq3jC0MeHzrwP9lxo1/WQN9lBC9WQgqI9WYVVui8rPK+DRN+z5EFd6y
fCzXQdZBDkyQidwM6cKUzL1tB+/Dt8jn7LGcamvCoMWESMAUKXTh09A1OdofXDDp
1UJXHKzhkzGh0t/xf0ANCsKTLSDoQNMPYQSDQzaiiO4F30Q/cjeZjR5OveK9EOVx
2tjq5yYWmq7u+wcNVlyRIY0mRBq3JMEIGfXxTSxDQ9Li+VmtbQzidVco2IzgBNWO
QocK20HBU7OKBUHttn8zpUNApVYPbgd2/hGGXkaYakRVVm3vqMTpLJfSqvWhZZHY
OCNKhw2KL4eq+hhybp3bPaaM6M+9eg==
=XMUr
-----END PGP SIGNATURE-----

--2h7skrbthp4xldgb--


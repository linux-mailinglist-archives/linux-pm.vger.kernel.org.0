Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF865150E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 22:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiLSVl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiLSVlu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 16:41:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D228FCEC
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 13:41:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7NtF-0002aX-Hk; Mon, 19 Dec 2022 22:41:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7NtD-000QW5-LE; Mon, 19 Dec 2022 22:41:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7NtC-006Qig-Mb; Mon, 19 Dec 2022 22:41:38 +0100
Date:   Mon, 19 Dec 2022 22:41:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr
 pointer
Message-ID: <20221219214138.odltlebj7t63azmp@pengutronix.de>
References: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnz4bha26mjztzkq"
Content-Disposition: inline
In-Reply-To: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qnz4bha26mjztzkq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 12, 2022 at 04:00:32PM +0200, Uwe Kleine-K=F6nig wrote:
> The probe function stores the sr_info pointer using
> platform_set_drvdata(). Use the corresponding platform_get_drvdata() to
> retrieve that pointer in the remove and shutdown functions.
>=20
> This simplifies these functions and makes error handling unnecessary.
> This is a good thing as at least for .remove() returning an error code
> doesn't have the desired effect.
>=20
> This is a preparation for making platform remove callbacks return void.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I didn't get any feedback on this patch and it didn't appear in next.

Did if fell through the cracks? Are there any concerns?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qnz4bha26mjztzkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOg2o8ACgkQwfwUeK3K
7AmFaggAm5evsoOnxD+RBjLuZ3jkHGcyJATJtGYZKAXv4T3hxNw6vrG6KvT6UHnC
GOQ5etIfbNdVSIYzCLt0IUl5h50F6DbOVOZC1X4PX9hy1KCLwRCVdwrgmNNa++U/
oQ+NSxjBWmrY9TLr/rcv+T3PNQNmEHpE+vP6vxJwFVaXR1VfNd3VWM6f3URowbUi
N/YbGsprvKwOa9iavAwCr4Kq55R2dxbAkBBS4QHSwv4bkc9m9P0AJLm/TkoW4Ep3
GSze0IThDMMk2tcM19iimY6v/Tjb02UyPKt1IVrNasgbmZnurIWhbvh1ta1F29Zi
sHS2SaUP/wPrh77uty9pkch9Lgz92w==
=twGR
-----END PGP SIGNATURE-----

--qnz4bha26mjztzkq--

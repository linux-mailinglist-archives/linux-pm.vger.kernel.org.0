Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B324A64B0DE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiLMIOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 03:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMIOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 03:14:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84156B13
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 00:14:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p50QI-0003Xp-Nd; Tue, 13 Dec 2022 09:13:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p50QG-004Cly-15; Tue, 13 Dec 2022 09:13:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p50QG-004i5s-3i; Tue, 13 Dec 2022 09:13:56 +0100
Date:   Tue, 13 Dec 2022 09:13:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Message-ID: <20221213081355.qat43wnbiyw763wc@pengutronix.de>
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
 <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrlszxve5te333cp"
Content-Disposition: inline
In-Reply-To: <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
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


--xrlszxve5te333cp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Tue, Dec 13, 2022 at 08:46:45AM +0100, Daniel Lezcano wrote:
> On 12/12/2022 23:02, Uwe Kleine-K=F6nig wrote:
> > A remove callback just returning 0 is equivalent to no remove callback
> > at all. So drop the useless function.
>=20
> AFAIU, without the remove callback the module can not be unloaded, no?

This is a wrong expectation. As Marko already pointed out the relevant
code path in platform_remove(), having no remove callback is equivalent
to a remove callback that returns zero unconditionally.

Note that driver unbinding and module unloading are two separate
concepts.

If you want to prevent driver unbinding, you can set struct
device_driver::suppress_bind_attrs.

For modules your assumption is true: If there is an init but no exit
function, a module cannot be unloaded[1]. Also while a reference to the
module is held, the module won't go away. (E.g. a bound device holds
such a reference.)

Best regards
Uwe

[1] apart from MODULE_FORCE_UNLOAD

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xrlszxve5te333cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOYNEAACgkQwfwUeK3K
7AmaNgf/QfVzBCAXu/r85UNOnsmdacU9w1dhmrXfHo4eoglG9DsmSOJpMuYtY7mK
pBgo8hU9EjACGMm495dydEBN6YHpjBpRAl6eJT/ky7vK7juN3apGsSCI9qZ3zzJV
y5VqffpEhz/WqQjtYjhxixbKcSnyWvlGbeey4kJ00HqESGJ8R5zSUvtjZqdvhVLL
A9ysJ8bVQE3UdYK88kYe/lzDMnbpIRil/o3jajp6MpBwbSA1V2x/C7hvbmkHW/wo
ydNuDMdftyLXt/ePhZflP3hSmMtMHIlns9riIWQRROeBmZ4YKRUbz0ox9n7B4Q7D
AV+4BlTmH06GutULRokGZPC+Oa10EA==
=P2Uk
-----END PGP SIGNATURE-----

--xrlszxve5te333cp--

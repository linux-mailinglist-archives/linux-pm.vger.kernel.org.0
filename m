Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571C47AE697
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjIZHR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZHR5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 03:17:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4BDEB
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 00:17:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql2KH-0003JD-7I; Tue, 26 Sep 2023 09:17:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql2KG-0093NE-Iq; Tue, 26 Sep 2023 09:17:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql2KG-004tvU-9J; Tue, 26 Sep 2023 09:17:44 +0200
Date:   Tue, 26 Sep 2023 09:17:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>, "lee@kernel.org" <lee@kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] backlight: pwm_bl: Disable PWM on shutdown and suspend
 disabled PWM emiting inactive state")
Message-ID: <20230926071744.oikg3ndaq6x7yjrw@pengutronix.de>
References: <DB9PR04MB84779AF9758B7FE747C6693D80869@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <20230322070352.xfwmnqyrao3mifuu@pengutronix.de>
 <DB9PR04MB8477FD24740251860648786380869@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <20230322085129.jxxz55tbcxkc6usd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ds4pnxi44iyaelx"
Content-Disposition: inline
In-Reply-To: <20230322085129.jxxz55tbcxkc6usd@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7ds4pnxi44iyaelx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 22, 2023 at 09:51:29AM +0100, Uwe Kleine-K=F6nig wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend, because PWM
> drivers usually refuse to suspend if they are still enabled.
>=20
> Also adapt shutdown to disable the PWM for similar reasons.
>=20
> Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per back=
light toggle")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch was never applied but I think it is still needed. I assume it
fell through the cracks?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ds4pnxi44iyaelx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUShZcACgkQj4D7WH0S
/k42Tgf/Tir1DYkvJiUE1QS6MkI16X656C4B4XQbHRwG1pSy2RgetRNm08W+X/j6
nBGthOGckEwMPDATx7U/TP6Me5taUO8otLanBnZholUnGQWL6utcRNCYI+bURrWH
meqqPB6qFS74qib1161gTlrvHKkekqqDXuTCznWdSAtQOF4QWwnAguOee6QUHgr+
GLsgwfSBZkogfxffEh0PYdb50ttrFIxd0ZSmoPWDzPgJR27YGtGy5MoQ0Z6//f7z
bIdWhTCnIlZqIP7+UIua/1LKNXKYa5YVVWwTpU5fq2pGU5sRhrPgY/qamDwG/QZ4
QNlQ+Wu3YS2IswvekbDn6sTWUipk3w==
=Sftu
-----END PGP SIGNATURE-----

--7ds4pnxi44iyaelx--

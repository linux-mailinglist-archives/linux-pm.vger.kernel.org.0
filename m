Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29257E12E5
	for <lists+linux-pm@lfdr.de>; Sun,  5 Nov 2023 10:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjKEJxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Nov 2023 04:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjKEJxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Nov 2023 04:53:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C719CC
        for <linux-pm@vger.kernel.org>; Sun,  5 Nov 2023 01:53:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZow-0002g3-Vs; Sun, 05 Nov 2023 10:53:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZov-006l9m-1v; Sun, 05 Nov 2023 10:53:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZou-00D8qC-OS; Sun, 05 Nov 2023 10:53:28 +0100
Date:   Sun, 5 Nov 2023 10:53:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/14] power: reset: Drop platform_driver_probe() and
 convert to platform remove callback returning void
Message-ID: <20231105095328.gi6yi455xlmihmms@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exvhp4fxjdw7awiz"
Content-Disposition: inline
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--exvhp4fxjdw7awiz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Sat, Nov 04, 2023 at 10:15:02PM +0100, Uwe Kleine-K=F6nig wrote:
> there are two different types of patches here that would justify to
> different series. But as the patches are not independant I chose to put
> them in a single series.
>=20
> The first three patches drop usage of platform_driver_probe(). This is a
> concept that isn't so relevant any more today. I didn't check, but it
> saves typically only a few 100k and there are thoughts to deprecate it
> to simplify the core. Getting the usage right is not trivial though the
> at91 drivers got it nearly right. The alternative to these patches is to
> add __ref to the driver struct ideally with a comment describing the
> need like is e.g. done in commit 5b44abbc39ca ("platform/x86: hp-wmi::
> Mark driver struct with __refdata to prevent section mismatch warning").
>=20
> The remaining patches convert the platform drivers to .remove_new(), see
> commit 5c5a7680e67b ("platform: Provide a remove callback that returns
> no value") for an extended explanation and the eventual goal. All
> conversions but one are trivial as the remove functions return zero
> unconditionally. The only exception is the tps65086-restart driver.

I forgot to convert two of the drivers that used platform_driver_probe()
before. I added them as patches 15 and 16 to this series in the hope
that b4 (or whatever tool you use to apply patches) gets that right.

> Uwe Kleine-K=F6nig (14):
>   power: reset: at91-poweroff: Stop using module_platform_driver_probe()
>   power: reset: at91-reset:: Stop using module_platform_driver_probe()

If you could do s/::/:/ on that patch description that would be great.
(Or should I resend for that?)

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--exvhp4fxjdw7awiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVHZhcACgkQj4D7WH0S
/k5Jtgf40bkUI/tsBT/eZ+3h+kAaBPC08oSM1xfjCN+GUtb6iX04GbymnfMlJtmv
CnIUVrxvvgtEN9L+hXNxSAieshEoBVk3TKFKI5mZWCxNUNL3L0KtsuHqWj5gcMSA
DIw46hr/yAJcUhiIkyDH3oPzSwVc1JMoOKJ550PInrP9gi9f7YppCPQBV0W7ifDP
DXV5xfmXq359kRsrbia2Tt0jOXMSoOdRM81O62BiNGQ7XceIjNKAeEx/NGm2jYag
oWwPyP4SbLNFVkqeNEiFD/4der+mqkJuefoQv+AlATpBsCUfzKDdcnmKjSbWhcGn
nRewc9gpBbRmYHpPKV3u7R91oOui
=xpzD
-----END PGP SIGNATURE-----

--exvhp4fxjdw7awiz--

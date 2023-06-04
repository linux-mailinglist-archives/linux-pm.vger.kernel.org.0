Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D077219FA
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 22:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjFDUii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jun 2023 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjFDUih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 16:38:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E14CE
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 13:38:37 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBE75660037C;
        Sun,  4 Jun 2023 21:38:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685911115;
        bh=qRQQB2uZi3P00xsxcFI3Psh5r6qA3AM6/mQw97gyuqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpbBvjeBAvkBsfWooZIF9gmttBTRAaEH1oI52aXtllg7P8MVRgrkHGflvp0CxUamr
         lkKsswhDCTzMqttWoMWo7D6AqWbSOCvar6Z5v2cmwhVcMACGKFmQpor/jvBUnBiRuZ
         hHOOzwR1hxPmU10u5SHvo8lb2lr26sfxJBuJu60nzDBubpBTNkyZvwCnZrDJsSRyD7
         oEpipo2htBpQxgiH+KnNDm32t2P33UfxBZpzKodGtIBAZTSF5i73AMR1RYeIN6Aphv
         jPw3Ov0pmgQjeblKzWR9lYbEXXJiqOrGkODtzQDsbovot0EDJIw4FFv2RP+lSLVvzO
         VTolm0z9jBK3w==
Received: by mercury (Postfix, from userid 1000)
        id CD33E1060921; Sun,  4 Jun 2023 22:38:31 +0200 (CEST)
Date:   Sun, 4 Jun 2023 22:38:31 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Switch i2c drivers back to use .probe()
Message-ID: <20230604203831.vwev4nuw2eugmkbq@mercury.elektranox.org>
References: <20230517165514.163216-1-u.kleine-koenig@pengutronix.de>
 <20230526160031.itnqw4skpfdwlawt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3cldheaddz7aepda"
Content-Disposition: inline
In-Reply-To: <20230526160031.itnqw4skpfdwlawt@pengutronix.de>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3cldheaddz7aepda
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 26, 2023 at 06:00:31PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, May 17, 2023 at 06:55:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") conve=
rt
> > back to (the new) .probe() to be able to eventually drop .probe_new() f=
rom
> > struct i2c_driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > I used v6.4-rc1 as base for this patch, but it also fits on top of
> > today's next master. If there are some conflicts when you apply it, feel
> > free to just drop all conflicting hunks, I'll care about the fallout
> > later.
> >=20
> > I chose to do this in a single patch for all drivers below
> > drivers/power/supply. If you want me to split it, just tell me.
> >=20
> > Also note I didn't Cc: all the individual maintainers to not exceed the
> > allowed length of To: and Cc:. If this patch will be split I can extend
> > the audience accordingly.
>=20
> I didn't get any feedback on this patch. It's great if it makes it into
> the mainline during the next merge window. Any chances for that?
>=20
> Best regards
> Uwe

Sorry, I'm still catching up in going through my backlog. It's
queued now.

-- Sebastian

--3cldheaddz7aepda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmR89kQACgkQ2O7X88g7
+ppSPA/9G54Q8TSG4+10Ap9g2y+hqL6qS81N8vTDmV7ySWPNv/srkrd7bFIJrJ9h
Q4A3aBvHUYmjL0eM8Wi0gNJlDc6boaE/T+zpRisuUfgSBXkX1DvCdnpSg6dYTTvR
REgubAlwq+5+wHdMx/Waaaa2umyAJsLCKbbaZrVrRDLjO9M5/+wfYYJ6lAK+0Vmg
MKkx5LKslGCE6D1kj2Pz7foAspU/6/mtqo+59knxYXE14s2uX607JWdS5QU54w27
WrdP58zt9iPNCCtbbTqwABEUp6SL/OUpH7brJI+0asN+8v39fxL7NWmtEOkSlnpb
4mkdGfEXMa+A6+hituP5yTwNTXLenPZ6Ws9KSf4mLuTo+1ETBP1nzevCGooAvGpK
BbctbbV/Bx1bWkP8BdBJ6vrwovwWHbdvpn5ipQsEo5dcxLRhMicykCl19hyftqeg
Dkj0rZXVCP+GOuADFlFZfWMBdxxghVxxiPQQsVMTygSys4T3IMca+ZjcjYR/mzLk
2b7jn/HVZAk/iLQ+d/hkllQD4DT7EOnMrMXqSSpPTNmjm+2L9wnDL4Jum4cjSldL
yNG9/A8VkEddIY6Obk+PMZpFqYXkvZ86nhp1YzqAHw2+ghJsL3XAl8JttW2rfDEs
YSq1BQz58cjT9whRUGYJRdU0+yZgcF3Ex/5uOwtjsaCWOPUGZco=
=JeSU
-----END PGP SIGNATURE-----

--3cldheaddz7aepda--

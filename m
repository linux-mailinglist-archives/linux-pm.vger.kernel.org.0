Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED04B2D85
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 20:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiBKT3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Feb 2022 14:29:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiBKT3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Feb 2022 14:29:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62250BA4
        for <linux-pm@vger.kernel.org>; Fri, 11 Feb 2022 11:29:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0C2081F472C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644607747;
        bh=FtdCwLBpCq4gh/bf2l1KJY+W9lELLUlsMvBoEJj7IQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dP3LSkWTPVvKPhAA2gA/1NjqqrfzUIuNHrsd5eSg7cfEGPC5+nVj5sZxyM07BbuM3
         Psvp+cG/cU4DW2cajbCGpd+D9SxiCsWnh119Qu6oJxI21Rb6PmM9Ux4VlPiRuyL5lu
         uV/W/4ElBWn9VaIYNNa2z3oqI+BFQrBUe9cMGxylGpBMZN+TzF5dQe1yZD3mO4P6Hc
         ofjUNKYkGc2aIA6/QZpmWS3bAaPTgYa5/NXD0jaXaIsSg+A0w+245ZtlrAU7Ooyleu
         2CX+NWW47bhe6rsJrrHlY48ddmIIqjmEXGCTtm+BEQUo+9QAbwEIJO3p6EsF5o3Qtp
         /9Mqbq4O3yp7Q==
Received: by mercury (Postfix, from userid 1000)
        id 5A22D1060908; Fri, 11 Feb 2022 20:29:05 +0100 (CET)
Date:   Fri, 11 Feb 2022 20:29:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/11 v2] AB8500 charging fixes
Message-ID: <20220211192905.aknwrogfai73fslk@mercury.elektranox.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbcbg3o3prvhx3ek"
Content-Disposition: inline
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zbcbg3o3prvhx3ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 29, 2022 at 01:49:14AM +0100, Linus Walleij wrote:
> This is a first round of AB8500 charging patches for v5.18.
>=20
> ChangeLog v1->v2:
> - Patch 5 contained code based on a patch I will submit in
>   the next iteration, now augmented to apply and build
>   cleanly.
>=20
> Linus Walleij (11):
>   power: supply: ab8500: Drop BATCTRL thermal mode
>   power: supply: ab8500: Swap max and overvoltage
>   power: supply: ab8500: Integrate thermal zone
>   power: supply: ab8500_fg: Break loop for measurement
>   power: supply: ab8500_fg: Break out load compensated voltage
>   power: supply: ab8500_fg: Safeguard compensated voltage
>   power: supply: ab8500_fg: Drop useless parameter
>   power: supply: ab8500_chargalg: Drop charging step
>   power: supply: ab8500_chargalg: Drop enable/disable sysfs
>   power: supply: ab8500_charger: Restrict ADC retrieveal
>   power: supply: ab8500_charger: Fix VBAT interval check
>=20
>  drivers/power/supply/Kconfig           |   2 +
>  drivers/power/supply/ab8500-bm.h       |  49 ----
>  drivers/power/supply/ab8500_bmdata.c   |  34 +--
>  drivers/power/supply/ab8500_btemp.c    | 330 +++----------------------
>  drivers/power/supply/ab8500_chargalg.c | 318 +-----------------------
>  drivers/power/supply/ab8500_charger.c  |  43 ++--
>  drivers/power/supply/ab8500_fg.c       |  96 ++++---
>  7 files changed, 138 insertions(+), 734 deletions(-)

Thanks, queued.

-- Sebastian

--zbcbg3o3prvhx3ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGuP0ACgkQ2O7X88g7
+pqk/Q/+Je1hzvGFe3L+iem/kq59r0COqiG7toPOnkE8Vd1x/DJS4iBN8ZAAWBjg
m7mPG8SIXHMt8l5roYtM9fZxSIPYHv/Md6qp8JgyHr3L89+6iTA4/sPKtFZLKctW
jYnfiPxZoR2tS+WFcVegbPamtQ2dCgp3+FpMk9jigm0NcqNQt4gNZ6VXABNabz6j
RqlCURIXXexdNyRf//xB7uibwDOm3CE4M0ALRe0TJKKaPMR9Tn/iNI/cVl3nBZK7
QeUqx0GGtPX6I2mk9b/uoIIaka1ijbpDJIc44grJCHC2NqCViAoWfu1VVYmGfYF5
Kzt6+mB+QJI07xoTv2Tirp9iGI+DirCQWZsZW1waHjIQAeQwMFDSmMT67DnE0Wmp
Oq894gEE+JZbtXZSkZxigMEAZAo+TIZTN+sigg2N+Y/itfhTkJfWePAcAbfRTQy2
KecdyBlMts8z6RWWgpPVaD2emk9z4zlsvEGGycoovZsYDEU1OMEOcj4JDVOgMQml
jbwv5lf8/+bC83TDyEyGrYtn4N6c3k27WdaY2TuliygBtjH8pK4ZBx7varYN30kC
R6O2QLbuUeiG03DaBIjjCWYRs/CtttBIkknfR5t1hrGkWTABDKzRYSrdqQAhBX62
K0flMGxs3Ig2DdFcU/x7hDLe/5+S4L/EGJE9bL5UpQZCyS6Nf0U=
=+NB+
-----END PGP SIGNATURE-----

--zbcbg3o3prvhx3ek--

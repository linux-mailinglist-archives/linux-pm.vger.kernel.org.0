Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F64C6AAB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Feb 2022 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiB1LhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiB1LhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 06:37:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F370F77
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 03:36:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 91B151F4339A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646048204;
        bh=zHXSDJpEgAeM9hjHI5NN6V6TLI2xlZwaFpHo7S99Gfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQLt+xUfIX0w3j/zybaFGFWUzq1NsaGM4WhnlTMenwaL6gDY7ULFIHq883yi01A9t
         M0YpJVP54O/7nOpci7knaaYmyBrrAtZEdbJWdS4znZtRbW7v9bz9MsP1n6A2cnipzE
         hQgiW8mwsS48+B5Wpff1DTQGZrMyDBbQ3dPi9l//QpC5OOCSUtq6Ry/ncEPi6TPANL
         wf8qtfAGM46vVPbks2sfCIHhq/4J1G6Sd9zLAIlRury6v0WFTxD3MG5+XsPih9JPaO
         b8V9d0Ko1VusDaLwdr8hKdp+R66jfJ1EHUm9/7A/tpGdf9c8bYjr4BF6BXYov12CbT
         Cqb8Z3P73hDIA==
Received: by mercury (Postfix, from userid 1000)
        id 58AEF106049B; Mon, 28 Feb 2022 12:36:42 +0100 (CET)
Date:   Mon, 28 Feb 2022 12:36:42 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 0/6 v4] AB8500 charging, the final steps
Message-ID: <20220228113642.ewrp7ewwfsif4jua@mercury.elektranox.org>
References: <20220225232800.2021909-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hrrjcf77dwelgnem"
Content-Disposition: inline
In-Reply-To: <20220225232800.2021909-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hrrjcf77dwelgnem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 26, 2022 at 12:27:54AM +0100, Linus Walleij wrote:
> Samsung Galaxy Ace 2
> Samsung Galaxy S Advance
> Samsung Galaxy S III mini
> Samsung Galaxy Xcover 2
> Samsung Galaxy Beam
> Samsung Galaxy Exhibit
> Samsung Galaxy Amp
>=20
> The steps are as follows:
>=20
> - Add charging setting for maintenance charging in two steps.
>   After this we fall back to discharging to the restart threshold.
>=20
> - Add optional alert mode charging when the battery is alert warm
>   or cold, so as to mitigate the condition. I suspect mostly the
>   battery gets alert warm and then this will pull down the charging
>   current a bit.
>=20
> - Add BTI (Battery Type Indicator) resistance fields.
>=20
> - Add VBAT-to-Ri internal resistance look-up and interpolation.
>   Samsung seem to use this on all the Samsung SDI battery
>   charging code I have seen.
>=20
> - Add the static data for all the Samsung batteries and detect
>   them from compatible property.
>=20
> All of this is enabled in the AB8500 simultaneously so for each
> new feature a user is introduced.
>=20
> ChangeLog v3->v4:
> - Rebase on Sebastians linux-power-supply tree.
> - Fix a small bug in the Samsung static data.
>=20
> ChangeLog v2->v3:
> - Collect Matti's review tags
> - Fix up Samsung battery data tables
>=20
> ChangeLog v1->v2:
> - Address review comments
> - Split alert charging mode in one for low resp high temp
> - Fix build errors with Samsung static data
>=20
>=20
> Linus Walleij (6):
>   power: supply: ab8500: Standardize maintenance charging
>   power: supply: ab8500: Standardize alert mode charging
>   power: supply: ab8500: Standardize BTI resistance
>   power: supply: Support VBAT-to-Ri lookup tables
>   power: supply: ab8500_fg: Use VBAT-to-Ri if possible
>   power: supply: Static data for Samsung batteries
>=20
>  drivers/power/supply/Kconfig               |   6 +
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/ab8500-bm.h           |  30 -
>  drivers/power/supply/ab8500_bmdata.c       |  52 +-
>  drivers/power/supply/ab8500_btemp.c        |  14 +-
>  drivers/power/supply/ab8500_chargalg.c     |  89 +-
>  drivers/power/supply/ab8500_fg.c           |  35 +-
>  drivers/power/supply/power_supply_core.c   | 116 ++-
>  drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
>  drivers/power/supply/samsung-sdi-battery.h |  13 +
>  include/linux/power_supply.h               | 207 ++++-
>  11 files changed, 1386 insertions(+), 96 deletions(-)
>  create mode 100644 drivers/power/supply/samsung-sdi-battery.c
>  create mode 100644 drivers/power/supply/samsung-sdi-battery.h

Thanks, queued.

-- Sebastian

--hrrjcf77dwelgnem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIcs7wACgkQ2O7X88g7
+ppryRAAmFOwDQ05V4VfSHqYJeAYxdo+M4ly+wlnLPIZvKo9oMIy7VXElkCFK6+k
mWoL5gaZjv3rOXc1c6dX8z74VlgbqNRylLkiKPuL5XFZW/tmRjOnw2cr/rOt/gUN
2lKHyNHqkrieyr7/xTwOSaNLin9gAgppnmgs0EvNCYYK49WE3ngNEW+QHRHS6JkK
1fBYMfnJnuU+bBImuA74mQVcgXXX+D02iuU5K9VnmtiafnxJ8W8zgwz73gHu7VtT
j4/olVsjOxDI20wM0x4V77Ca+2j5B02v8bhwn8D1nVdOwZOKtbykUfeYg4TEjpXq
Xg9xeuA9QW0vO4RvvbtxHzPB2JeXOfTLjWO3xBXKlax5G8LU05mFZ3gbYXcsqvdC
6Ke9urS0sgR9ygHj0yVoj3F+KKs8pMgl6BGmZv5Rniv+4ThqSgrlFLAkCqPc85ae
UQMdpSiLY3Oi+Py2U2sXja5xspkE83m0VOoSs1n72gMxlczrkVUDGv/FP5BYrQ7U
K8WAEcC9ILtLEBqrEsFghnNKXrAh8vp4BiEiT2twWsd4VdqL2BfUSq0nWf54sIAH
4OpZug7L9T+e2HQf2UcyrY+glLnuisEOy83pl1HHf879QdWMd5Ixc6Y58bFBUVuP
XsxNoRa4GTmlx2x1gU8daGnLmphAXE00J+ZyhXuYNsVNcjE9SkI=
=qyyD
-----END PGP SIGNATURE-----

--hrrjcf77dwelgnem--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A034C4DF0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiBYSia (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 13:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 13:38:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE862DA83
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 10:37:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 30BF01F4662E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645814273;
        bh=alrDDBsdyKA7nPE7/KNwQoaM89H/d+sdnGz8tRyfhKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZ6A45kQJ+jleaCpbFHRiyk00hipt8hKRvu3UImoRfiTUBz5dJv0AHbRCYmwP4LEl
         K0Jhch76s9o1z55l+NVPfBeDZAeh1ACGwQ0Ku0bqXdQVqHGAa4ignp/qDIWVIeaQRT
         5dLyKQy2Zfmj/muDwWVmvKoyywTIETQ2KWdJZ0k0ftUw6SZ6jcafrTbjlH56J/A6MM
         rq/ghczVAvT1CHxAN0eL4TRy7Dfw4y3jtFGWUhLxevDN65QmwWVMXDO1Ksn2nZk30V
         fLe30t7xc5ubKUSx4lm7rscawwwDtdFLm3kHbh8Mcm91Pt0aUjpY/GKWq8TVFd1pTI
         1+0fUNq1jypIQ==
Received: by mercury (Postfix, from userid 1000)
        id 0E9F2106049B; Fri, 25 Feb 2022 19:37:51 +0100 (CET)
Date:   Fri, 25 Feb 2022 19:37:51 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 0/6 v3] AB8500 charging, the final steps
Message-ID: <20220225183751.rbneox5w7q2povfb@mercury.elektranox.org>
References: <20220225001314.1881549-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izm2abndut7bogmx"
Content-Disposition: inline
In-Reply-To: <20220225001314.1881549-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--izm2abndut7bogmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, Feb 25, 2022 at 01:13:08AM +0100, Linus Walleij wrote:
> This makes AB8500 charge the Samsung batteries on the following
> mobile phones:
>=20
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
>  drivers/power/supply/power_supply_core.c   | 136 ++-
>  drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
>  drivers/power/supply/samsung-sdi-battery.h |  13 +
>  include/linux/power_supply.h               | 207 ++++-
>  11 files changed, 1396 insertions(+), 106 deletions(-)
>  create mode 100644 drivers/power/supply/samsung-sdi-battery.c
>  create mode 100644 drivers/power/supply/samsung-sdi-battery.h

The patchset looks good to me, but does not apply. Please rebase.

Thanks,

-- Sebastian

--izm2abndut7bogmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIZIfMACgkQ2O7X88g7
+prlSg/9FEhhBgS3FcVoebU47zYMFq554n0ASUvBTfNiZHfdW6k1l1qz1bW3wiFb
9nU1981GGrrLHE6LqQh0yulF7MwjVxYcZZxzkBqjFBt5c3mzzJiRSfgGfaMvLUmZ
PLSXJ3yGBLtcAD916z/2cybJN40T7f22ITsjrL/nzOh9ZGg2xaVkyQmOsDj6Vqyf
t8ExKWepIcm3F/fx5PIUM3ufgqdMGh2p+05vtzILMQ6jDaMWK7yc6VOP3ndYK2YM
WbrRbAfm9YNhegr2cUIrDC2Pi0sKeECIcxKzLvBpElqtCQx6GYIkZce5jULnO9ni
SqAcxQQQXTt3lYUPSpq82/qqwB2oZDd5d3dLAPvlo59DVVQYkIFTIM0acjLQit92
YkMFyC0Y1vp1QTbDJuPTKKw0XhwzYLjm5z8oj4lzd5ZSDCwhn5z75XYuPDxKT3st
YhYL41BWcu/1KwqZ1b3O8Lfgq3DKnaDpLQtGi2R/Qtfz9WivzH5KqhQCBnThtiDj
aLnwtJ6s1TZarRg8ZLvvjTVISq5GDMYedZxecyhrDtjnnSYthSp1OWUIn+7987AO
JnmOgLwUCOKu+8QPbmzXiB14by8nv2Rn//QZSMxdYveXBSR4hItBhQ/xXpZ85ZvK
s19iRxUeamoJTJKYpMcoBz+Cau7j9Rrq+uFiLeWyNnR79Yq5ioU=
=Qv2B
-----END PGP SIGNATURE-----

--izm2abndut7bogmx--

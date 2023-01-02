Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78E65B81C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 00:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjABXPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 18:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjABXPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 18:15:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D135C5FF7
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 15:15:33 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73FDD660038D;
        Mon,  2 Jan 2023 23:15:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672701332;
        bh=jZvW+7rNsA/r37u4/TXqK05SmZSFv5Wu4Z4b2L6LZxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PP+Xps4QgvJCfIf7DSxaXzYYJtKyyM2NkYzkYH+Q2hvQeT2UakQqo226DGmRkyEtP
         YN9VlLNFGhWDnoU0zisbia1XVOKc54cZFORdsLLD/fq1LHcv6aDfF0xyNiKBT90+6J
         an8WHSLEmpCTp+M1ffZlUULY37YmnxFxhZf+MN1AXwzWNI8VBFVjtnhoWZR76aK8Oi
         /Qs8ICohxNcH3r/OqmmDCjDvJHNu3/C0w446Gg2WoJSs3cuv6jAKk4dYqWiIPKYigI
         Tx8Ye0+GSx/Mu5jwv97bWFPcK9xltiOBb1mJym78TUbXqSc+hG+OSqhzNhoyS72EwQ
         jhiRfU8Xxnfug==
Received: by mercury (Postfix, from userid 1000)
        id 35EBD106076E; Tue,  3 Jan 2023 00:15:30 +0100 (CET)
Date:   Tue, 3 Jan 2023 00:15:30 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/9] power: supply: bq25890: Fixes for 6.2 + further
 work for 6.3
Message-ID: <20230102231530.3eumtnr6jqjv5jlt@mercury.elektranox.org>
References: <20221128092856.71619-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4w24wzwcjvmsufd"
Content-Disposition: inline
In-Reply-To: <20221128092856.71619-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--o4w24wzwcjvmsufd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 28, 2022 at 10:28:47AM +0100, Hans de Goede wrote:
> Hi Sebastian, Marek,
>=20
> Here is v2 of my bq25890 series from yesterday, addressing the few
> small remarks from Marek + adding Marek's Reviewed-by to most of
> my patches. Note I dropped patch 1/10 from the v1 series since that
> has already been merged.
>=20
> Here is a (slightly updated) copy of the v1 cover letter:
>=20
> I have been working on getting a Lenovo Yoga Tab 3 Pro (YT3-X90F) to
> work with the mainline kernel. This tablet has 2 batteries with
> 2 bq25892 chargers both connected to a single Micro-USB connector.
>=20
> Supporting the 2 charger board also requires the recent HiZ mode patches
> from Marek, to avoid merging order problems / conflicts I have included
> a copy of Marek's series here so this series obsoletes the:
>=20
> [PATCH 1/2] power: supply: bq25890: Factor out chip state update
> [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
> [PATCH v2 1/2] power: supply: bq25890: Factor out chip state update
> [PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support
>=20
> patches from Marek.
>=20
> While working on adding support for this I also noticed some generic issu=
es
> with the bq25890 driver currently in linux-power-supply/for-next and I al=
so
> have some fixes to the HiZ support on top of Marek's support.
>=20
> So this entire series consist of 4 parts:
>=20
> 1. Patches 1-2:
>=20
> Generic bugfixes for the bq25890 charger in its current state
> in linux-power-supply/for-next.
>=20
> 2. Patches 3-4:
>=20
> Marek's HiZ support work, thank you Marek.
>=20
> 3. Patches 5-6:
>=20
> Some fixes / improvements from me to Marek's HiZ support.
>=20
> 4. Patch 7-9:
>=20
> The actual support for boards with 2 chargers.

I just queued patches 3-7 to power-supply's for-next branch.

Thanks,

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
> Hans de Goede (7):
>   power: supply: bq25890: Ensure pump_express_work is cancelled on
>     remove
>   power: supply: bq25890: Fix usb-notifier probe and remove races
>   power: supply: bq25890: Fix setting of F_CONV_RATE rate when disabling
>     HiZ mode
>   power: supply: bq25890: Always take HiZ mode into account for ADC rate
>   power: supply: bq25890: Support boards with more then one charger IC
>   power: supply: bq25890: Add support for having a secondary charger IC
>   power: supply: bq25890: Add new linux,iinlim-percentage property
>=20
> Marek Vasut (2):
>   power: supply: bq25890: Factor out chip state update
>   power: supply: bq25890: Add HiZ mode support
>=20
>  drivers/platform/x86/x86-android-tablets.c |   2 +-
>  drivers/power/supply/bq25890_charger.c     | 226 ++++++++++++++++-----
>  2 files changed, 179 insertions(+), 49 deletions(-)
>=20
> --=20
> 2.37.3
>=20

--o4w24wzwcjvmsufd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzZY0ACgkQ2O7X88g7
+pr0/hAAjrMYnoWtVCe1RsH11M8T01kxMT++hEBn9g/9LbVwizv3VFZUjwL9fxtR
qJ1Q/FS7AGjhjNhRwfhxkH9R1IpEgoUjZwh+ebbs/x5VXRnp9nTcjkT7m1cgYbW8
hmn6Mm4CnxJ71hf+kYGIDaWEtkXIP63E2m2kT4rdeZO0sIpRpsxxHj9rGbgtckns
noph3VYnIKLnX2EgT1tz/ugWulWjc30B1jSeHqk5DgA+tyzJPvQ3/8p5eAGsCwuU
0xwGjTcsyQPY+ho/xvRmCPsoUEqu4QJYOsTRXBjv9VOUoY4rxZnB8yykvYvZBaEn
x6GcFAA+YCcXdpM7kaazpXEAasydoXj9uHzh4933iYNvA2NDXWyzsGtDONj0XcFC
aMzwccDBwy3TIVdgWA9Wdg299bTWOSN/hXUH2fkEKnGmpjRAdI6TOtvX2YOnLHHY
n4BElwZionDezgGqiwkihbp/l39lY/26ytM/+ZxlmnxPOMGsMl3r2jMLXs285GGX
fVOfteFr+oZ8CskGdSQ4wXZHvtqTFjQ4TSD9PXdkxkSerZnmTEmld/AqHlQXf8Xw
gifUIYZARy4cA9Bil46KffRZOIeeHNRpJh+TwrApCZRIFahHZXzJg+4O5ku/Bzv7
CYxxYrA85o6iz4ML+ipnGad0fBH/3wRCg0i0F85vM3FbOW/SO+Y=
=Jv9a
-----END PGP SIGNATURE-----

--o4w24wzwcjvmsufd--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764322E349
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 01:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGZX01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 19:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgGZX01 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 19:26:27 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3636B206E3;
        Sun, 26 Jul 2020 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595805986;
        bh=0VlfzMzEoDv3JMuejseGbjOabYqqKKALYkgoIy5Lu5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzodRvKKjQypa87M1xak9FCCUPyCdpuTekk2w2dT4DvuZNLLdTNFgx/TjOh4o37To
         pGnz76Y/VGOb5de2oWk+qjxS6leyDmojtU50PqpwWWnVor5dYpNk6j2ZR5J67I4NsO
         kSE3nmEWrvDdM5/SkhPxmo5TtgoZ6KU7vj9X8l7M=
Received: by earth.universe (Postfix, from userid 1000)
        id 68B3D3C0B87; Mon, 27 Jul 2020 01:26:24 +0200 (CEST)
Date:   Mon, 27 Jul 2020 01:26:24 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     pali@kernel.org, robh@kernel.org, afd@ti.com, dmurphy@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sspatil@android.com
Subject: Re: [PATCH v17 0/4] Add JEITA properties and introduce the bq2515x
 charger
Message-ID: <20200726232624.wmrcvjznbrxibc5n@earth.universe>
References: <20200720204400.7351-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="maykluao2dom5sag"
Content-Disposition: inline
In-Reply-To: <20200720204400.7351-1-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--maykluao2dom5sag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2020 at 03:43:56PM -0500, Ricardo Rivera-Matos wrote:
> Hello,
>=20
> This patchset adds additional health properties to the power_supply heade=
r.
> These additional properties are taken from the JEITA specification. This
> patchset also introduces the bq2515x family of charging ICs.
>=20
> Dan Murphy (2):
>   power_supply: Add additional health properties to the header
>   dt-bindings: power: Convert battery.txt to battery.yaml
>=20
> Ricardo Rivera-Matos (2):
>   dt-bindings: power: Add the bindings for the bq2515x family of
>     chargers.
>   power: supply: bq25150 introduce the bq25150

I merged patches 1,3,4 (the bq2515x ones). The patch converting
battery.txt to battery.yaml is not ok in its current form.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power   |    3 +-
>  .../bindings/power/supply/battery.txt         |   86 +-
>  .../bindings/power/supply/battery.yaml        |  157 +++
>  .../bindings/power/supply/bq2515x.yaml        |   93 ++
>  drivers/power/supply/Kconfig                  |   13 +
>  drivers/power/supply/Makefile                 |    1 +
>  drivers/power/supply/bq2515x_charger.c        | 1169 +++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c     |    3 +
>  include/linux/power_supply.h                  |    3 +
>  9 files changed, 1442 insertions(+), 86 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515=
x.yaml
>  create mode 100644 drivers/power/supply/bq2515x_charger.c
>=20
> --=20
> 2.27.0
>=20

--maykluao2dom5sag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8eESAACgkQ2O7X88g7
+prAwA/8Cq8HvmjsJjY0MKETTACC3nSAazOZGwZwdPEumJ6O+isQp3SxHnLhrFFe
0lqP++duLGG2raQJzHDqNpu4plw71hY3aNWEE5V2u3zQ18PJMzvC8zB/Loqt7Ni7
1TORkY670e39/EgaSJR+ZVzzk1OBqqvcUQaakcieOw80wvKRfNjs8vh3spb4TmRX
JgetZZUOBUWqara7UbEnHkMMf7B/lABP8tiakP+8+mVYicEaiUmqAzUprY1Av2T6
vxV8g91orMOjqAyH/oK9Z90gFUbjjyauS2lFxLGnFS3sO70O4NyDfFLekiKHmvxS
uEeLvr63QcbWlUw7/BvCypIRi8MJ965hENLTsMQ74BAHC31WbFOLoNuSnb3NtO8Z
rKnx6k76M6+Hm7X+GFLFzKo4Q/94SL8bxxfOK5PrDy5Xi+OB/PzfAE4kTomDhO5N
BKmWUpcl+zIlJ09Ejez4w0wndVrvaHNcc4CAoxwTEthw/yRqrkCJop61HKUPjL62
A5E2HLtQRdR3u4ypLN4yXUkAYdaKFYCnm+Xh8X4C3Zh6n4nTCcFE4e39o3wu8OdL
KJZcK4gOqt5FxXSCMHV5L63f3GGIPaAbZLhtdF35T6e+0MM/2odbMpu5bbG1Tjox
wJLKtVQljzmocuZjVBzGEfpS0rwHWH4x+vbW/Yx4dNDJzbsqZm0=
=zotz
-----END PGP SIGNATURE-----

--maykluao2dom5sag--

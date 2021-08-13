Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647B43EB99A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhHMPzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHMPzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 11:55:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E2C061756;
        Fri, 13 Aug 2021 08:54:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 618541F40E8C
Received: by earth.universe (Postfix, from userid 1000)
        id 449DF3C0C99; Fri, 13 Aug 2021 17:54:38 +0200 (CEST)
Date:   Fri, 13 Aug 2021 17:54:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Message-ID: <20210813155438.4ssph6deqksob2uv@earth.universe>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikusuaweozgwybmv"
Content-Disposition: inline
In-Reply-To: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ikusuaweozgwybmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 19, 2021 at 11:39:11AM +0800, Gene Chen wrote:
> This patch series add MT6360 Charger support contains driver and binding
> document

Thanks, queued.

-- Sebastian

> Gene Chen (3)
>  lib: add linear range get selector within
>  dt-bindings: power: Add bindings document for Charger support on MT6360 =
PMIC
>  power: supply: mt6360_charger: add MT6360 charger support
>=20
>  Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   4=
8=20
>  drivers/power/supply/Kconfig                                       |   1=
1=20
>  drivers/power/supply/Makefile                                      |    =
1=20
>  drivers/power/supply/mt6360_charger.c                              |  86=
7 ++++++++++
>  include/linux/linear_range.h                                       |    =
2=20
>  lib/linear_ranges.c                                                |   3=
1=20
>  6 files changed, 960 insertions(+)
>=20
> changelogs between v1 & v2
>  - Add binding property with unit and custom name prefix
>  - Remove extcon device, redundant brackets and interrupts
>  - Fix power supply prop "charger type"
>=20
> changelogs between v2 & v3
>  - Add register selector to value mapping
>=20
> changelogs between v3 & v4
>  - move pdata vinovp to mt6360_chg_info
>  - remove unuse sysfs attribute
>  - refactor debug log and warning
>  - add power supply prop input voltage limit
>=20
> changelogs between v4 & v5
>  - add linear range selector mapping
>  - use linear range to map charger setting
>=20
> changelogs between v5 & v6
>  - use REGULATOR_LINEAR_RANGE
>  - use devm_work_autocancel
>  - fix Kconfig description
>=20
>=20

--ikusuaweozgwybmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWlb4ACgkQ2O7X88g7
+ppfhg//Yi9xvms8G9ziPuIbkk/ywWDy7CTX6w5F2khCLGeODcH5NRpXPimmnrES
tod2JRpFOEvSplEAosnQR2e0PgCdCL2k0x0Ii0jQWJ3oJwSawTMGM95wx+7XiQB7
S/ncgc4Q9XkRx0btxMJ2ogKxjQzSKFh43AAhymt/p33ErnDvkbRNTX50SLNvyafy
/d0cry4eYF/wVU0L3xzO1RwILaK7HbOCoGI9XPzjR+76z9zQibtzJ9jg8/qSD2iP
BopKCrqOPTQvHGNt0/UHeVFj4OB34qhiHQqih0zONA9DdzLYOtvBvxpGn/1a31xN
0x4DzAOoVL3RcdAAT6dzrVsck8xn55wC2VcMDnMZd0uPANNLnILcXsWriaa69wrS
cj7Y1SUJdq7fbS3u3Pm6qcRDc24BORSR+oulRNJUaPM+Ylr/ADW+m9XCgTwCYnCQ
WUcqxa8rN+SEVDjo4mpBe2X5hOvn5hJopr7Xt6460sMtqvWN11H/B+NtdT47EwuG
pr6MZbqV2AUeZsz3Kf5F8i+QDeHMHn3vj6nkphP3w29gDcEGhd2bRqZ3QAG0tg03
vlLl07V1kryFcI0CQC5QPDEzLKG6whmmARoqJHVgR9Yw/bsvm97XPnX03fVVqwjT
gPwvndYyHoo4M8rhN6C6KdJVyjoUGo7CdnZO5nbUTK8cAPK685c=
=E5U1
-----END PGP SIGNATURE-----

--ikusuaweozgwybmv--

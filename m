Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1AC33A8E1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 00:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCNXm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 19:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhCNXmE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 19:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 668E064E74;
        Sun, 14 Mar 2021 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615765324;
        bh=Fa+vffWf6KNHw+UlD0jpNfvPkDMOIa+hurO1m1Rmlnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrdGLz0YTI/wAZQcxT5ZIPmpQJPO6fJzlInGwvZc9eU+kMQ/hhkywENPK3hNJNSlg
         RpZpP8mPpw3JCgcMxF/fLg4aXZk37Xi4p00P2UMgNByvOD/Z1ZMEjrncVTdxbe6JvC
         TWNZmrVGdbDdJtDo5p91FRWPtcYH71HTeGQwPrR6p+Tra+9J77OgYGIK9xtyBZRkz0
         UgT1y2zOqras/B3ZcyxZuPiZLlPdovFnOQXw5gUJDKW23mENHs7exTj74ZMCl2bBo8
         b33gsGbbosYpDX9b49oOR7N0dOzjs8XaC2WYzhE0FUtG3pEcalc6lrAkJdupDvPYdW
         cpvdOeuA4BW2g==
Received: by earth.universe (Postfix, from userid 1000)
        id 86A303C0C96; Mon, 15 Mar 2021 00:42:02 +0100 (CET)
Date:   Mon, 15 Mar 2021 00:42:02 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     robh+dt@kernel.org, pali@kernel.org, krzk@kernel.org, afd@ti.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Message-ID: <20210314234202.xijndjgltdcyuggh@earth.universe>
References: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dutgwz3jkhiferw2"
Content-Disposition: inline
In-Reply-To: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dutgwz3jkhiferw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 05, 2021 at 06:49:47AM +0000, LI Qingwu wrote:
> Changes in V5:
>=20
> 1. Change [BQ27XXX_REG_TTES] from INVALID_REG_ADDR to 0x1c,
> the StandbyTimeToEmpty command of bq78z100.
> 2. Add [BQ27XXX_REG_RC] =3D 0x10. the RemainingCapacity command of
> bq78z100.
> 3. Set [BQ27XXX_REG_AE] to INVALID_REG_ADDR, support by bq78z100.
> 4. Delete property POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, not support
> by bq78z100

I also asked to check other exposed properties and to provide
a dump of the power-supply uevent in commit message or cover
letter to verify chip works as expected. I cannot see the dump
and you are exposing at least one property that always reports
-ENODATA. I intentionally will not point out the exact property,
so that you have to properly test your patch before submitting.

Thanks,

-- Sebastian

> LI Qingwu (2):
>   dt-bindings: power: bq27xxx: add bq78z100
>   power: supply: bq27xxx: Add support for BQ78Z100
>=20
>  .../bindings/power/supply/bq27xxx.yaml        |  1 +
>  drivers/power/supply/bq27xxx_battery.c        | 44 +++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
>  include/linux/power/bq27xxx_battery.h         |  1 +
>  4 files changed, 48 insertions(+)
>=20
> --=20
> 2.17.1
>=20

--dutgwz3jkhiferw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOn0MACgkQ2O7X88g7
+ppUUA/+LyLaX43lfgDDQfcHGCMdQ9T4Q+YzEMudDaJlisrf51pEE32B6pmwzvGg
rSSncyUxyIIi98BhEt5xsO4gAu9w9DH5tBAbqk1z0FRC4KYtRay0Z6Fj1F3ix/RX
2vyxBnADkTZ28Vkz49IDyuO5WLSaX2aiq4Pvfu3XWoS8txXV0MDW149g+F80dC6d
EPb4N8KK3+LTdJn4G9Xph9HBNjXR3US5oaJouz5cLfWXeUuWI9KBgfe+8LKPaD1I
VZEbFV+5a+3OdJxcqcdKICXInjL4+is8uVkiiEjvAP8hXxdpe+7TZLw+JgiumT9+
sbih+qdmo3Mz9vYlbBBWeVgwYFkAhO0ES0+RxCm9r/8wmqUqkRhrbKUMmE4dod+/
SPN5Ln4JrbxcG7iwSDqFooRY41Xy5x8Wc7sUKNpphn4zGXq1Xv800rZtTOS2vXUf
irE/kUIxiu63LDZMcLHhVXVE4SVv4C3wQ8LPL6FbdExlD0q1C1wUvgpnp6dw1TSY
/8zhOETOAB3aJ2UyVRC1FXXzglkUhjkccpTDD0ScitVHGxEPgF6aoY40mljL+UPJ
0Ei8jsqMhoQeis4a3NCJ/8qSfDgnsJWEaoi5MioSRQTX6XSkRt654KbXTuS1gPrL
kHL1UdNacnCE+0UcI6GQ75geIDij1JQrwmqUDVL0942uIBI6OqA=
=rRkr
-----END PGP SIGNATURE-----

--dutgwz3jkhiferw2--

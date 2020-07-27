Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1A22FC40
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 00:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgG0Wgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0Wgt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 18:36:49 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582DA206D7;
        Mon, 27 Jul 2020 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595889408;
        bh=Q1+CdX6g1uX5/O4dcOLZ5AB/jAjBef9C9fNZJmce1m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OX4KJ4iq2Aza8rqPoReQm3fxVnq8XzWC0xaUVoAK0XQvyPTpJhf0sFbyztkBGJS/R
         44zN+Ed8FCn80kX+4SeRqPFP6+mg7L0deOIXJ4mRqKXpxpLRN4nhk9r0PzvwTuTkCz
         FFhDe6wqOUi7SVs1c8zJahy/rDixare7AmYGvnYQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 1A3243C0B87; Tue, 28 Jul 2020 00:36:46 +0200 (CEST)
Date:   Tue, 28 Jul 2020 00:36:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v3 2/4] power: supply: bq27xxx_battery: Add the BQ27561
 Battery monitor
Message-ID: <20200727223646.vjnkyrmipwin3pj6@earth.universe>
References: <20200721163206.25438-1-dmurphy@ti.com>
 <20200721163206.25438-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzrshq2akzwyrchr"
Content-Disposition: inline
In-Reply-To: <20200721163206.25438-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dzrshq2akzwyrchr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 21, 2020 at 11:32:04AM -0500, Dan Murphy wrote:
> Add the Texas Instruments BQ27561 battery monitor.  The register address
> map is laid out the same as compared to other devices within the file.
> The battery status register has differing bits to determine if the
> battery is full, discharging or dead.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Looks mostly good to me, but

[...]

> @@ -1710,6 +1769,13 @@ static int bq27xxx_battery_capacity_level(struct b=
q27xxx_device_info *di,
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> +	} else if (di->opts & BQ27561_O_BITS) {
> +		if (di->cache.flags & BQ27561_FLAG_FC)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> +		else if (di->cache.flags & BQ27561_FLAG_DIS_CH)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;

Shouldn't this be checking for FLAG_FDC instead of FLAG_DIS_CH?

-- Sebastian

--dzrshq2akzwyrchr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fVvsACgkQ2O7X88g7
+pq4BhAAobVH8GBXmthjmhclE8H+qS3thRQaDNbpb4ind+SP2i5f9YdaIf9Nxa/e
XFWS1SbU1AcTTs6jGE2OeGt8dHqIsp/fp/Nhpog17e+4/nujlMyYSqFJzasalGTd
lz5zMvfmfIBbt++UcsccFXoUNG3YKNP/pc4rKMQNL4iyqEWyGj+S0SCqjBNe409U
f0DMj2/32+RbJVB1GONooer/9drlpShdOND62ALDxXUBbVhT2Zh6bcMX0R7YRmSd
RruoWxlHH1fUFeBNMQAcBal6WAxmPu23oLLDnXAvqcehioGnBWVMr4nVeeuMXpuV
0/LLXgz5PIzwsGvVLq6jkLXzjPIH9uoaiyJoJyqGOBXVOal39tDG8Vt5stNilkNo
zGUd9ebkxBVBcS5AhEWrPTEXkwKRwKs+wbIq6ccpfi22b3gI7GsjGLwBhdJBynvk
DloHl/dM3+HpKo0h5S56cMnEFt/08WqetU2/83XW1+TRpVq3lH7jueTGWArK38qs
FhHvs+pM3o2mWLrYIBTpEO3048Sb93vauby20MMP14CpSafrOfYZXYWcsoC4WIZa
T99D19eSJvSpRULxjHHQqA+KN6lP+UZ4D8BDXCgeyXcen9DXr/N+WrE2CGzEWj5m
1ImaoB45hu1HZgt53ezthI4Ak6EZzbg5ObRFl92zPSH/7hqD7rI=
=G+a9
-----END PGP SIGNATURE-----

--dzrshq2akzwyrchr--

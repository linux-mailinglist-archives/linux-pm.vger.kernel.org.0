Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01123117D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgG1SR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 14:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgG1SR6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jul 2020 14:17:58 -0400
Received: from earth.universe (dyndsl-091-096-060-166.ewe-ip-backbone.de [91.96.60.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CDF2070B;
        Tue, 28 Jul 2020 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595960278;
        bh=5vq1INeu5FXV8HgUInTtWnDacbvKHUXhSIMQvzhdJUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdeKeQ9B8TAahhIF9nk2UVxwCRImgOoHnRfRBo3FBb+Zxv7GSSoI8gC3BsWws9Zhn
         ibPwLNkijspxEE8F7/fCY9om8Fln1pnXJCxYpkJMf8Tha6H7vE0wqAYE1EUJmPe3Gs
         v1cd6ViBWzoZRE1sLTRTxRW3GYgIrBIOmObk6BFs=
Received: by earth.universe (Postfix, from userid 1000)
        id 8C2AC3C0B87; Tue, 28 Jul 2020 20:17:55 +0200 (CEST)
Date:   Tue, 28 Jul 2020 20:17:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: bq27xxx_battery: Add the BQ27561
 Battery monitor
Message-ID: <20200728181755.6bkhp7j3cqtpooof@earth.universe>
References: <20200728141113.31518-1-dmurphy@ti.com>
 <20200728141113.31518-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wfexptlluq3ij3y"
Content-Disposition: inline
In-Reply-To: <20200728141113.31518-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5wfexptlluq3ij3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 28, 2020 at 09:11:11AM -0500, Dan Murphy wrote:
> Add the Texas Instruments BQ27561 battery monitor.  The register address
> map is laid out the same as compared to other devices within the file.
> The battery status register has differing bits to determine if the
> battery is full, discharging or dead.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 68 +++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 942c92127b6d..654d38bcd7e0 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -43,6 +43,7 @@
>   * http://www.ti.com/product/bq27411-g1
>   * http://www.ti.com/product/bq27441-g1
>   * http://www.ti.com/product/bq27621-g1
> + * https://www.ti.com/lit/gpn/bq27z561

Applying this failed, because I applied a patch converting the
http urls to https. I would have fixed this silently, but it made
me notice the chip name is bq27z561 instead of simply bq27561.

You named it without the 'z' everywhere, is there a reason?
Searching for bq27561 basically only finds your patches and
you decided not to drop the z for the bq28z610.

-- Sebastian

--5wfexptlluq3ij3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8ga8YACgkQ2O7X88g7
+pq61A/9HALzLbaV2nB6FTOZLs3BMj4LSQ1/WIesGXn03CnKce4akvgjygjlAbhj
NYTXV/3SbI8BXgfnTd6ooetOqVmRwoHOo7Z7wtNCTyW38v53uM60GX1TGEiEVSb1
2SD/2W/vzmOjQfsWKm5+xTfhpBPFnV4Y2KTnmgzVBUtiI+dXUdc1FLSBNfksQnlL
nS2f7BN1IWUaaR0GyUub2yeaExzpEDvYritor9tbDBH3IFjYoRrDsBkyp3DFh9fG
+9nlNjIz7QkE5yjaCx68/iZfjSSAEWv28DTjSo7dh24fBrshz4dQ1185Tb7Xiz9F
POa9E+Cl4VhhDd5QWDCgo9VC392TZE5GRhFTJwXT25RJ1sn5A+zFVYxKK35aks92
DKXLmFVUMG2fF3aULBl2mHFccxKq4TIDR9BZypBgjOkyt74NgW6CrJnCU2cleWet
N3XrKiyK901IAd/BF+YLthmuTfiolFz3jwkpgIzix4A6fJ1+dOzXamL/TLk2dT8w
MdR5dRnZwgGNYk3R/GsgE36VXLjIvgMtjvAwbD9ergm8XqiBr5Hk+ooUr3o+CPmF
ilRQ7h7pwhIjnmnqdr7ZHrzNFgjT9rIBt7lSbKi2SrI2hNBNe/GBoe49AcvJtqlt
M5nV4tgf91iZ0bTTlHfgcnxtBX5OhDWXdM257OZtjdz8e3Agf/M=
=pMEP
-----END PGP SIGNATURE-----

--5wfexptlluq3ij3y--

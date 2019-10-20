Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31CDDE68
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJTMZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 08:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfJTMZQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 08:25:16 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6751821928;
        Sun, 20 Oct 2019 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571574315;
        bh=6f/XFCrE7zOPjeWI0k6rXn67ULxHC+lwjPuFMdAkeFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRlpsRvxwRs+OW5xmISJKJ9neZifgrDoxOeRqrWZgC5Gg8zo5vyZwjl6EMtmC7QeI
         m7hKvijknIEux4LKqoh+vV3687jm1tGBhs9j9VRTT2tdiu3sUC62r36DO/bXj1UTgi
         L6SKrT06ptA1fWnat4FGE14BpDVmngJs2v1v4l1c=
Received: by earth.universe (Postfix, from userid 1000)
        id C66503C09B1; Sun, 20 Oct 2019 14:25:10 +0200 (CEST)
Date:   Sun, 20 Oct 2019 14:25:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power_supply: Add additional health properties to
 the header
Message-ID: <20191020122510.4llflz7s2kogcdbf@earth.universe>
References: <20190930143137.21624-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jfdksylty7r6khjs"
Content-Disposition: inline
In-Reply-To: <20190930143137.21624-1-dmurphy@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jfdksylty7r6khjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2019 at 09:31:35AM -0500, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.

You used OVERHEAT instead of HOT in the implementation,
which makes sense to me, so please drop HOT here. Also
this needs to be documented in the ABI documentation:

Documentation/ABI/testing/sysfs-class-power

-- Sebastian

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  include/linux/power_supply.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f737e7d..bd0d3225f245 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -61,6 +61,9 @@ enum {
>  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_OVERCURRENT,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>  };
> =20
>  enum {
> --=20
> 2.22.0.214.g8dca754b1e
>=20

--jfdksylty7r6khjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sUiYACgkQ2O7X88g7
+poKmhAAnJUK0KspPdK3MYnk2vjwcP1McDUuH/Cqh2tLrweww3+e9PDcbcU78/7x
noC7LRAvfe64fG0JwRRkiXUjNko2utAayVCJTqmyzuX/OYmDsLXYCDRGLOJxvc4T
sy7/fSJAii7bxJF1PspbpWE3MLx2+kfmB/PfYWs5znfBgsnpd10STZ7Qf/lWtHwT
89royHrGRQ3YTeqJaaVJV041N5Mx4AJ97HBRc9J1m8nowH/MOQFIsANONcgw4y25
2bh/apxcBTKXNrhkQ+rBd/xBNzb5nAcrYRCSNopYIe8jCK2I0K9BzTP5+cloNrxD
0q0n/wPl9WPMSkYsVJw9e5pWLwPkxUNmBqlxan287hAvLh6tPJEGTUHFRinUB5TA
uJa7oJZ1H41rAT5ssr7Ive7XNpxgEuS96dRHcy6CpNwyDVZQbjBPXSIeCqmR2zZB
FCP0MXEKP3w650CKeqEZljfTlQs+WnPHq9U1p5P4z2Brha1GRCuyGnBtxYiDirqg
awSdgXoTwZFyg+ieV31xfBqkanfAdOq6glEzFOmdL4hPBKsW+Iz3sX1tqYfk3Slg
vXvkC/DsPx5UleehazDvRvP22xo/S3R85TIwutaaanQEwaVmC75bW/uCYwPmjz44
lre9pXhv/Rcub4X2ujFms+xzpIPi+TlOHov1a17lRQUjOzU234w=
=1n0y
-----END PGP SIGNATURE-----

--jfdksylty7r6khjs--

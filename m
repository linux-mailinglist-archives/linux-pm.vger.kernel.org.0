Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7342E287EFC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgJHXHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 19:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbgJHXHx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 19:07:53 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552B322248;
        Thu,  8 Oct 2020 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602198472;
        bh=WTNOsnliNtP6ZQO0NYEV7e0YaYvPZhCBUuNYeSP7FDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbIV3ehCl4ewNopdw1JECI3aR0VH3fT6bmv0s6dEBe4oHkM+m62ZrF4pIW/5Hlnby
         /3PrvaQ26mFr9PcXpOddLJ8ksp/bEj5/liz4kp5NY2yshZukMpX2z+DjQLZ4JDzGpw
         Wv4hJTrsfgXi1Gx8KEzmwEV89yY7nglGCvCSv1Ag=
Received: by earth.universe (Postfix, from userid 1000)
        id E53153C0C87; Fri,  9 Oct 2020 01:07:49 +0200 (CEST)
Date:   Fri, 9 Oct 2020 01:07:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: max17040: Fix ptr to enum cast
Message-ID: <20201008230749.pawqtio7jzvsn2hr@earth.universe>
References: <20201005200038.1032697-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aavobxw732x42ey3"
Content-Disposition: inline
In-Reply-To: <20201005200038.1032697-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--aavobxw732x42ey3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 05, 2020 at 11:00:38PM +0300, Iskren Chernev wrote:
> clang complains about casting pointers to smaller enum types.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---

Thanks, queued.

> P.S. I fixed a similar issue in v5, but it was in another patch, and the
> test robot only complains about the first issue, so I missed this one.
>=20
> There is a similar warning in ltc2941-battery-gauge, let me know if I
> should submit a fix for it as well.

Sure.

-- Sebastian

>  drivers/power/supply/max17040_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 1d7510a59295d..d956c67d51558 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -247,7 +247,7 @@ static int max17040_get_of_data(struct max17040_chip =
*chip)
>  {
>  	struct device *dev =3D &chip->client->dev;
>  	struct chip_data *data =3D &max17040_family[
> -		(enum chip_id) of_device_get_match_data(dev)];
> +		(uintptr_t) of_device_get_match_data(dev)];
>  	int rcomp_len;
>  	u8 rcomp[2];
>=20
>=20
> base-commit: f9d293364b452b651292ed3034dd06c57b1754d5
> --
> 2.28.0
>=20

--aavobxw732x42ey3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/m8UACgkQ2O7X88g7
+pra5w//c+UKoMj9kaEf8dq6+ZxRhiTKHfqfY6jBnwafLSOpknREm1nIs0FfLo8b
C8/H87Eljd3AZmt814q+Dvb3/kV/We4/aUy/O6Zqb/2wJ9kD96HzINqLcpogcRM/
V9/L5q/0Cukwjm6sQq5KZ5jzeOqt5QCzlYi5GdL+Am8gx3mD5w0u4JuxDiXyIGF6
L0d5Gdc9s+u/yrEnbr+MzCdcW2kSMIumNHzha8UBTEVb9q/+iEnwuf+lNyKYCQ/A
q1/sbt43Go9QpHRAMxxrUI3Vm43e0UaObNsVAlkJI+6GMXA/HFGR5mXC4M3rb2Cm
AWg14E7uDA1F3LHd8IeG2boF4CKeS2aA1EUNwE00TV73M4JucfdnCPkYuXjb0mDi
mnNEJ11nj9zKevfB46ir9HesPtaTbXQCmaDR84yvK568mu4noBMouBkj0ZPSKqmX
wz4j0VX4Ij72WGP+SxM9Ip+nyy+y8KcWdyQUQ/OIvFSmHnTdrVPRv6ibV/4zqHEX
8CPEtPACv0DK97KBILR6i3w0OuXvR8r8oh7JoAkkT8FZxXMeFW48HxRr84GY89mW
opxcfJKepiCrBsRs3N/4qrs2gF1JwCSDpPO9DcLjiKqLakvCbn45oJBXBiBKoleD
ecsdlcBXelfvXN9hs9Yj/vZRBdIwmxKyoF12Al2PyTuhRJ1BibI=
=UYJ+
-----END PGP SIGNATURE-----

--aavobxw732x42ey3--

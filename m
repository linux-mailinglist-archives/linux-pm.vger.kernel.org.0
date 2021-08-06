Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD583E3159
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbhHFVrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241587AbhHFVrc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:47:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8379610FD;
        Fri,  6 Aug 2021 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628286436;
        bh=eHdgp7qlzGkw1EVFauYqPH7BFtLqWWFTuQSQQ6Xf048=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dtkl0YpBpRhQ3FjBoHFGKcLd0r8S4RXgQMZ4NBwkjKP0qozw13+F351ZycLNAU4lb
         sCf5OFwf43/Nn09phsWheA6ek9BhMCrfe3hZvKC9CUCN3Ijm5NJ5lOqad5LxiPijYJ
         HyZNlfSiWMDVC5wYGekaD54v0O8fXGIQntQnLzZSeBUpBfB6FiaarO+pm6MNGtP3WY
         c7/+UbZG9Ytpoe7Y+QwzY99b1lnsx88gSIBuX6ZXJZzAHDUto6syT5sKIPirIUyQ5E
         HgakvUbgoUlm1YXLBKPxRQrVzcfx1KQLZZiUweNC+JJp8k9wADP9Fy8BOEzUtalKLf
         Jr0FwDdI98wbg==
Received: by earth.universe (Postfix, from userid 1000)
        id D2CD53C0C99; Fri,  6 Aug 2021 23:47:13 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:47:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: Use IS_ERR() to check and
 simplify code
Message-ID: <20210806214713.p7ygp2iux6wjxk5n@earth.universe>
References: <20210720061836.29148-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ax6wwmzhmgmytfow"
Content-Disposition: inline
In-Reply-To: <20210720061836.29148-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ax6wwmzhmgmytfow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 20, 2021 at 02:18:36PM +0800, Tang Bin wrote:
> Use IS_ERR() and PTR_ERR() instead of PTR_ERR_OR_ZERO() to
> simplify code, avoid redundant judgements.
>=20
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

I think the original variant is the simpler one. Also
compiler should be able to optimize this.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 90eba3646..7007e5d53 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -912,10 +912,9 @@ static int cpcap_battery_probe(struct platform_devic=
e *pdev)
> =20
>  	ddata->psy =3D devm_power_supply_register(ddata->dev, psy_desc,
>  						&psy_cfg);
> -	error =3D PTR_ERR_OR_ZERO(ddata->psy);
> -	if (error) {
> +	if (IS_ERR(ddata->psy)) {
>  		dev_err(ddata->dev, "failed to register power supply\n");
> -		return error;
> +		return PTR_ERR(ddata->psy);
>  	}
> =20
>  	atomic_set(&ddata->active, 1);
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20

--ax6wwmzhmgmytfow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENreEACgkQ2O7X88g7
+pp1QA/+KnBEXpwJMSs5kpz38wuxzFoBm/lCJzDq0AjouV7Jhgznpj09iYOZBDRR
YCw5FCllWMIRBEDmX8Qr7OKfgiMkpm5P5J7Lqd8IbpWQy0W5Ym/gm+pLeTdQ5qN/
lXbcPl0dRPRFymNvWUdPzVs6FjLR02G+c1segXKPfxzZTVXr6kN10j28PVZNGvvr
Pl6Mt1nVbhJE1tS42vtQoW2jiQ7Y11nTRyUX39X6FBvmeUrv/FlrnJ76wQXElJCA
KmsKVfyqur/rwUgzI1dhk9jyJ9+0fVsgflIAbm9bZFhzeGBRDnse5hHQd6nkjiSl
rG4CktPPwJ0dG3wJyL4Z71YxDXmOxfu5X4tD7GrO11p4oAA7qlFmzLe1K1NEevmZ
SZScT8hiRGKcOh/WOugYQHNg9EWAI7XH48nZ2w3WksTwWo/bVXJiT0fa1rLDhWfK
zjrDrCq9BiSylc7swra3AVx3S07dMqsYlOR1ezTbCOqx40m5HJiXCvREJIwSZj7+
7/VK5GNG7gjZRp9fFOAquy7Vfad6/McrTJUGLrMEJwiHAPSbGG4nWnqwl0THQ+m1
nJTjBcvSybDUpnjcbhpcF1WIF3eXzPRG2elwq5vpEjxH8b3medD5HOY5DHzyNLfN
CRpTZgp+fnGDHOaU3ZNm9F+opAPhWoCAqTRdiZ4or8lA3Q7iARA=
=BOVH
-----END PGP SIGNATURE-----

--ax6wwmzhmgmytfow--

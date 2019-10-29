Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865A9E860A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJ2KrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 06:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfJ2KrR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 06:47:17 -0400
Received: from earth.universe (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA83E2087F;
        Tue, 29 Oct 2019 10:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572346037;
        bh=bPgPRwEGk1WpIlNo+2VVkScLdSYBAcfmNMZD0CbgvJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC1+K+Vlea6DuSonfaVFQWYy2NX8zBJVpl1gGPj0bcJe0Kg2MWFpp7k+IqrD/bEZX
         uFtzH5CeeIXx04cLLLxr2o71nL87uy1ASdFuM6m1f+/OfINlZP0ddtcpFqcXqgVzdY
         P/6TJzQVlI1Nz/gjB4V8xdonsmkxAvX6A/AEUbls=
Received: by earth.universe (Postfix, from userid 1000)
        id 997043C09B2; Tue, 29 Oct 2019 11:47:13 +0100 (CET)
Date:   Tue, 29 Oct 2019 11:47:13 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: gpio-restart: don't error on deferral
Message-ID: <20191029104713.tvdeskct2ulvo6pv@earth.universe>
References: <20191029004302.384-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3fv7kb6h6ycyusl"
Content-Disposition: inline
In-Reply-To: <20191029004302.384-1-chris.packham@alliedtelesis.co.nz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--o3fv7kb6h6ycyusl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 29, 2019 at 01:43:02PM +1300, Chris Packham wrote:
> Don't generate an error message when devm_gpiod_get fails with
> -EPROBE_DEFER.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Change looks good generally, but please make it like this to reduce
the amount of PTR_ERR():

ret =3D PTR_ERR_OR_ZERO(gpio_restart->reset_gpio)
if (ret) {
    if (ret !=3D -EPROBE_DEFER)
        dev_err(...)
    return ret;
}

Thanks,

-- Sebastian

>  drivers/power/reset/gpio-restart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
> index 308ca9d9d276..4aaa46b80ba2 100644
> --- a/drivers/power/reset/gpio-restart.c
> +++ b/drivers/power/reset/gpio-restart.c
> @@ -65,7 +65,8 @@ static int gpio_restart_probe(struct platform_device *p=
dev)
>  	gpio_restart->reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL,
>  			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
>  	if (IS_ERR(gpio_restart->reset_gpio)) {
> -		dev_err(&pdev->dev, "Could not get reset GPIO\n");
> +		if (PTR_ERR(gpio_restart->reset_gpio) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Could not get reset GPIO\n");
>  		return PTR_ERR(gpio_restart->reset_gpio);
>  	}
> =20
> --=20
> 2.23.0
>=20

--o3fv7kb6h6ycyusl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl24GKkACgkQ2O7X88g7
+ppLNg//e7gNFSD7knrBaxJXh+wwjjOYQjhY/U6JhYxP77dkuAQiJXizjE01u7mX
Cug/sKZM32xfkuamHoxaCdVSGTEcrJNFS6GW8Fr2dSvg1Jn9oPu9FjW2/hAsLhPp
Vulz2USN7FMzgI5a38CvOXnUp37wjGq5ZcoS/JTY+v6APQX5oGf4LGCah468HP3Q
LjK9b+cdOawoGGl1JE6qBLkcPlakoNzqVxMwYUSwu6zhB8y5nTbkxlLDeadyFtPV
MplK6UDR7BRhlej2Zh80PwFiA2LLHNcbBGMG7VqlJHKPayKavHq2B/02+nHZFEcf
wUFgxI2HimZXidAB/HXw2Ocl/9+Dpr5mZr19sA+AYDumDsoc/mFlJY0wmj4vQCbc
uOn7jdTh+/EVShtyl6DvLvqgbiGMwajjSEqJRHY78AmLCY4mi74tvtxEPWjcSHjw
FDfQri+4bGG/93LnER3Qh5vmHe11OwusghLaVi/qWHY0bjPfS/tncL4fAUYTOVLd
3rfY0lDY8VLLBgNhHN5baoLu1reNFQIjWoxIY8CVGLMpSs2fyyzAGSpo+SAD8+nr
Or1b60M0T/K3JCTDX6hrDQMh3D1L8OeHplrYVXlV66WItoUuACmwhh+FR8GbmA7t
1e+MlmQnQS5QyR3goNwlO6eDkVSQfPFOvPmajd9kf04p9yJRzAs=
=sesJ
-----END PGP SIGNATURE-----

--o3fv7kb6h6ycyusl--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6AA5CA1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfIBTQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfIBTQ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:16:27 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945E521883;
        Mon,  2 Sep 2019 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451786;
        bh=DDCYrv3lGKJ63xn/Bvcw9F7AwwviJwsM2ns4CptNxNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSf+/qBaSV27D7/nD6ebiZkSY4fKuT2tny+urCaRlf8ahzGELYKyLwtw/rsBpYM6j
         tA0SZJmnTnPUU8GDzbC3E+zeGn0vqiMwoqJP8fPW0tHgSSW4biGgVrAUrYIGtJXDA/
         dy81qZj658dgCGwsAF/ZxlB5MmyMH7AYXF6UYgWY=
Received: by earth.universe (Postfix, from userid 1000)
        id E44A53C0B7F; Mon,  2 Sep 2019 21:16:23 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:16:23 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: max77650: add MODULE_ALIAS()
Message-ID: <20190902191623.t4l4hlcorkbsjnqj@earth.universe>
References: <20190703084811.9582-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxknfcmqlmimaizl"
Content-Disposition: inline
In-Reply-To: <20190703084811.9582-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rxknfcmqlmimaizl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 03, 2019 at 10:48:10AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Define a MODULE_ALIAS() in the charger sub-driver for max77650 so that
> the appropriate module gets loaded together with the core mfd driver.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Thanks, queued. Sorry for the delay.

-- Sebastian

>  drivers/power/supply/max77650-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> index e34714cb05ec..5f9477c5cf5a 100644
> --- a/drivers/power/supply/max77650-charger.c
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -366,3 +366,4 @@ module_platform_driver(max77650_charger_driver);
>  MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
>  MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:max77650-charger");
> --=20
> 2.21.0
>=20

--rxknfcmqlmimaizl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taocACgkQ2O7X88g7
+ppuTg//dK84CNX4lS56lFT7mQTU/KJd75YQoJg6CIHH/H0QmkHm0+MZg/7w4Fu+
x8WANmvOV1G+nk9GFE2Um6KwRCIUzfkAyPf0XBAlb43M82jIxqBOfk2waXrEvGA6
DdwJT0j2l1jZRiqxvsAVt675Ine86M6BB9v1S3ZSX+VOMfyOtKHVFAx32eJ1mKHg
DMNEdkGRW/DBWYXDrtY5v6dpGeYCafGFEn++3r8GO3bmjQwLQkTlzk7JkEop75Wb
+cs0+kwbnOWiVO95W2dSorkagr8yhlRwGxkHV57VAQenQRxk0Di1tKZfoxavk4BU
dMeOeBS2/Wfrw+pEC/hQ8xiHWJnmKqzxmv9QL2+3Ta1QmgduOD9T4aZNrHcgX/ET
V8C3lmpL/LsASk9llcvs+a6EuQo+Vgr7bIPcd6Y8a9cA7zY2WPd4mZK96GL2GiBb
yChk6FJWgZjClO/vMEyILUzq2DwksEHDlyF6CO9lo09AW41qYFTj7mu6CiONUjp8
8rZz0O/RXIUX02Cs+Tk18oFmVTOqjXgZMLo3kkaRkaHwdtmdShjQKQQlB4apf8sx
RZhNnNRbY1ymMEo8w9hnTpycoX8MWpTr53vbLC8UjsZu45iG+UlkQLPReOZ9dp4f
IuG/yjWqB2EijOMnRWTGx6L8I/deaQ1jw5TrzjRFkW1mcUWYw3A=
=fAmd
-----END PGP SIGNATURE-----

--rxknfcmqlmimaizl--

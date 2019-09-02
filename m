Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CECA5C50
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfIBSh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 14:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfIBSh6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 14:37:58 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C4C2087E;
        Mon,  2 Sep 2019 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567449477;
        bh=/wM7s3NKrRlICYkMU4E2G6/DD4ggEHpOe/EtqV5iWvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG21VCKyBtbrWLmGDzDlfikGMekEU6o0oeUw7vLRJyHBSBun+UgG1Mize8hH/4f7e
         OVWwP8PCGk0+KcemtzBLgOE6FWeUpeIibdlDCj0imQZBduxedGDcx+D1XqdzurA8mW
         YfgBshdZp2b2kScZot/6XzES5+uPdOLdkv6l1Ip8=
Received: by earth.universe (Postfix, from userid 1000)
        id 586FA3C0B7F; Mon,  2 Sep 2019 20:37:55 +0200 (CEST)
Date:   Mon, 2 Sep 2019 20:37:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: gpio-restart: Fix typo when gpio reset is
 not found
Message-ID: <20190902183755.72vpe4xn2gbw4kmy@earth.universe>
References: <94b3d1f3ebeb6000c32a7bed6f8b9411bae9cf19.1567429238.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dulct22sl4bantvv"
Content-Disposition: inline
In-Reply-To: <94b3d1f3ebeb6000c32a7bed6f8b9411bae9cf19.1567429238.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dulct22sl4bantvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 02, 2019 at 03:00:40PM +0200, Michal Simek wrote:
> Trivial patch which just corrects error message.
>=20
> Fixes: 371bb20d6927 ("power: Add simple gpio-restart driver")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

Thanks, queued.

-- Sebastian

>=20
>  drivers/power/reset/gpio-restart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
> index 2880cd5ae0d2..308ca9d9d276 100644
> --- a/drivers/power/reset/gpio-restart.c
> +++ b/drivers/power/reset/gpio-restart.c
> @@ -65,7 +65,7 @@ static int gpio_restart_probe(struct platform_device *p=
dev)
>  	gpio_restart->reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL,
>  			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
>  	if (IS_ERR(gpio_restart->reset_gpio)) {
> -		dev_err(&pdev->dev, "Could net get reset GPIO\n");
> +		dev_err(&pdev->dev, "Could not get reset GPIO\n");
>  		return PTR_ERR(gpio_restart->reset_gpio);
>  	}
> =20
> --=20
> 2.17.1
>=20

--dulct22sl4bantvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tYYMACgkQ2O7X88g7
+poRMw//V7Ow1mpLJIwknsKNr9wI/GzrbyKQnLvAYrBdPMVvx2m2PSBsvUw+kVQJ
YmihXkkLacM7EQnWbKtr/R7Lq0Ld6wmSvCqhFyzvaPhydqgSEdhBh7JRk8yN8eW/
7ptnYelb925VkFn5dcz7KAHZ7AIP6lP8CJGU06I4HSaYsYliQbyvcDL5vwSB7oGP
qF/1ESwqh/x7Kq4u6EfHYGbT2gtD294ZWA2tUZK6R8hqh4242Nc6sdGkxnHw09Gt
TGowAhfeJ9blsvtMV9MOHHJbSCn46fK/5IaoEcy/p4AYyatTKdLKV5BcQC1Y8OGU
OdsSVOTOP/HYNCHgVPu9zgnkxymnVIM49/oe9+3Jn7h/s3cHLRCEi96gFOXTNpVF
kmgoGE/cOod2jL9+65ToivZBtttcsePXnx06NzSUMzTwN/T086I51S2Vr/J0ufGn
YCEBVG4+cm9jSGejUqs/ZGM+hJ583BLeOfFhxYGSM1/jAlg7jZzEwqEsgFDVWYlL
2eZ23z3Ez1/peYgCPlE/AK9AEoup0Ot9S9+T5wg+xtHMpov1FK1TcS827Y1Av4w2
xshXBOZAMM+jZP38bLJixQ+CCrs6psp3CRZj2qUQ+HvAS8+O2vqao/r5hcQb4aKF
wi4ShqQ/Xfk+IQ7N77TwoTxdyP0tx1+SnGODczCGXE8RIMd+w8w=
=m9Nx
-----END PGP SIGNATURE-----

--dulct22sl4bantvv--

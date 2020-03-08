Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5917D5A4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 19:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCHSyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 14:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHSyr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Mar 2020 14:54:47 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C576E20663;
        Sun,  8 Mar 2020 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583693687;
        bh=Q+kfL4mkXLvM4nEGnLgXVk4GKzZ0+K/A2ern3w+0xSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GL42HVY51ZG+Fp9Jnf0GgKOU1R/rQc66l7JTQISLGNJHbMqKeLW+DTThTwAEk5JxL
         zselZ4tkuwqc/tZOcqiKK1DhPGWmmEuB/ySZGmCypYcBkhrH0THm2TLNewIn4GaJWd
         62mbeKY+pBVqH/rdXrd91X1p6Qo7HdhfgIZXDCT8=
Received: by earth.universe (Postfix, from userid 1000)
        id 5DAAB3C0C82; Sun,  8 Mar 2020 19:54:44 +0100 (CET)
Date:   Sun, 8 Mar 2020 19:54:44 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] rework at91-reset driver
Message-ID: <20200308185444.lpkpumgxhya7n356@earth.universe>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kc3gxuytlvcwlxwg"
Content-Disposition: inline
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kc3gxuytlvcwlxwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 21, 2020 at 10:03:29AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> The following patches rework the at91-reset driver and solves
> the SAM9X60 VDDCORE fast drop in the first 100us after power down.

Thanks, queued to power-supply's for-next branch.

-- Sebastian

> Claudiu Beznea (15):
>   power: reset: at91-reset: introduce struct at91_reset
>   power: reset: at91-reset: add ramc_base[] to struct at91_reset
>   power: reset: at91-reset: add sclk to struct at91_reset
>   power: reset: at91-reset: add notifier block to struct at91_reset
>   power: reset: at91-reset: convert reset in pointer to struct
>     at91_reset
>   power: reset: at91-reset: pass rstc base address to
>     at91_reset_status()
>   power: reset: at91-reset: devm_kzalloc() for at91_reset data structure
>   power: reset: at91-reset: introduce struct at91_reset_data
>   power: reset: at91-reset: introduce args member in at91_reset_data
>   power: reset: at91-reset: use r4 as tmp argument
>   power: reset: at91-reset: introduce ramc_lpr to struct at91_reset
>   power: reset: at91-reset: make at91sam9g45_restart() generic
>   power: reset: at91-reset: keep only one reset function
>   power: reset: at91-reset: get rid of at91_reset_data
>   power: reset: at91-reset: handle nrst async for sam9x60
>=20
>  drivers/power/reset/at91-reset.c | 190 +++++++++++++++++++--------------=
------
>  1 file changed, 94 insertions(+), 96 deletions(-)
>=20
> --=20
> 2.7.4

--kc3gxuytlvcwlxwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5lP20ACgkQ2O7X88g7
+prHbg/+O0XOtdVGtEj+dgQdKkxCtRq/tHyIWB/3PAUQ3fAEGtBmQVdDZS6EHi9A
xvKRTAIPw4NL4LvX3KLx90iyJdwokAU61/MX6aGcWUe7v5jgOGHsdXlfEIVlMzEo
U7UEexjUAMEAgA2aG1Dl38GNY6q/Df1QKRg63D2x1n6wRD72lzgLTYpVxQVmeEoL
FP6wYdjvYgBrvjHd0VVoUdrk218eQtzFBA/BsEyJ3Vh3RNiqTNJWamaxe83p10vb
XMVfSkdyqc/hqBDx95+QkwFcsZM6y/B1iTfjaoc08uEh3GI3k0ggpRoZDm+S3aVr
Y2n1CDekjlVisufZhwvTkDYijwyWelH4aXlUbyAK/TBJ0zOeESq7mJxHry5az5u2
+161MxZZivVZvklCh0QUgpgP0DOv1vWA4sX7thw7EXLz5HHIJacstKAQGnrUtZNL
ohIZLEU4awX3xplOltncY0PqKztbv+BTfE9RN8K6EWFjqo76pkMgHoXE+J1VtZA7
eSQiRvByrAWiWdftZGwoSjTgcO5BlqxAvzFK7nuyvAgrTkip28i+5QGs4ihgpLbz
s6DWLgts47zHLA03Ymr0Cqw9Ej+2mSeZNhzR4yJAG/fmzoICs4kvfSin9uHJDHyZ
wubsG9S0HGzZJoGQkm8458zN2GFus96QrGOwx4TLebvipvS69GU=
=ox0n
-----END PGP SIGNATURE-----

--kc3gxuytlvcwlxwg--

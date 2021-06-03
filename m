Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CED39A621
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCQro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 12:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCQrn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Jun 2021 12:47:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D33E06024A;
        Thu,  3 Jun 2021 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622738759;
        bh=/vcPDePIs8jPgy2Q/Mn4unl4wif5aBA72gTUiuDOZZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNu2iVApWy/sBwOJ2lSUVCyPjsgpnX0WrGW0I2SIw9DfxEAR2fKVbGEq0ID5Vlley
         wdzvjMWEgnMDhNN06mXEQkFZfPjyxu1U+DTU6wzKdKcRm2ubafCl53aXa6MlVNmdEc
         ZVxeNkvmtQ5/odISi7p1SxazYC7To8WIweDZ7VrW8G9uWrKHAgpWIt1RxJni2hZAnD
         /MQExUPtJLEMQ2MoP5K68ggCwTHNLRxHkGlebg8VyrgpQIigu4jcKwc+3p8vIw+GhP
         72wxNqYLpGssudAkCuvuZRA1+pUEIz+90My5vKCc3x14WWyr9ZRFPOgtG8WCpD/gUH
         Ie5urpsTxYn3g==
Received: by earth.universe (Postfix, from userid 1000)
        id 0BF0A3C0C95; Thu,  3 Jun 2021 18:45:57 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:45:57 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jian Xin <xinjian34324@163.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian Xin <xinjian@yulong.com>
Subject: Re: [PATCH] power: supply: ab8500_fg: Fix typo
Message-ID: <20210603164557.q22aruv72r2aic7o@earth.universe>
References: <20210603094718.229553-1-xinjian34324@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5rm6l5fm57j2jnln"
Content-Disposition: inline
In-Reply-To: <20210603094718.229553-1-xinjian34324@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5rm6l5fm57j2jnln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 03, 2021 at 05:47:18PM +0800, Jian Xin wrote:
> From: Jian Xin <xinjian@yulong.com>
>=20
> fix misspelled 'interrupts'
>=20
> Signed-off-by: Jian Xin <xinjian@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 06ff42c71f24..64c6037cb0bc 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -58,7 +58,7 @@
>  	((y1) + ((((y2) - (y1)) * ((x) - (x1))) / ((x2) - (x1))));
> =20
>  /**
> - * struct ab8500_fg_interrupts - ab8500 fg interupts
> + * struct ab8500_fg_interrupts - ab8500 fg interrupts
>   * @name:	name of the interrupt
>   * @isr		function pointer to the isr
>   */
> --=20
> 2.25.1
>=20

--5rm6l5fm57j2jnln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5BzwACgkQ2O7X88g7
+ppxPg//R/YeC6FDQHCew2C1A8lDT6r0yYRlrpgnY9lndbvw0MyJrbDPq5vqpTBY
KNPVn9cZoTxARkbAL6ynaIDNXtok3rtKqlVoI6vEwnUoJOYdkNL9j/XEaQci/BNn
ueEllSSx3yVkts3/pWYvGy7flyijk8qZ252GDa4OCiURys7ltK/pXJ/bBCRxaGHG
e3Zy8b5ZJcX0OnP/dXYOmr7r6pVBJTZNDj5+zzvoX8Ri3lZv+eFZiQIaI45m1RTu
ewX/pRQ0GM8keeGkglCCHBNQp/YwRwXZacoGxWJHAOxE6APFRto0veY/DMAs+gLZ
1eaCgPkBCrTL6kEAyKY7TUFy8mU+lGi829zirQFHO/MaUTeoFWZ5iGhBVDnRP+N1
/iducg2yZaPlPz7ED1nJXqYkF2pz316WEIIeUY/f4vsdwYbAtJSZ2zUfPX2nvOEM
3ZTFgk17H6O19yWg7FpPmyoAZj1+1Gmh738LzqZwgF+QCmPMQMhW0pp/nqzruyck
7XJzPn+KqBnhE1wWd1arHqvRKzTOVpjpGrBLYwOu2PUNrkAC9GMM/chD/Ba1djb7
Shxt5KIvwbsf+CijdF5H8T7eNePV+ddZ0z4Ya52BZYuT30Z3uary2Bdvs0vJxMTZ
gTRKn8G+RLTaFztNVVDae4fd8mD5gXgRjsROID1FIvKwm4gyv5s=
=G00h
-----END PGP SIGNATURE-----

--5rm6l5fm57j2jnln--

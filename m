Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53145D6B3E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfJNV0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbfJNV0t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:49 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC19121721;
        Mon, 14 Oct 2019 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088408;
        bh=Rz8xhmL935mXLtSudYn8Yr1PvTUCjNWwAoCjj8yI2QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtIJQllrBy84L7sEf7yZJPleBJieDdrmJp+JZFafMLwgj1hir8qaGHMg7mLI57x7b
         feOHpfR8QSh2iK5kyt430OLvgPI9KQNfF+dBkXYBfQaenzFnRWbda/23AWQXGn2Uyw
         xmB8qrjCC2yS7grSoCGzYdRaD4lOSwxi5njohQ0U=
Received: by earth.universe (Postfix, from userid 1000)
        id 1147F3C0CAA; Mon, 14 Oct 2019 08:59:13 +0200 (CEST)
Date:   Mon, 14 Oct 2019 08:59:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: at91-poweroff: lookup for proper PMC DT
 node
Message-ID: <20191014065913.k244l6gdgfiu4jsk@earth.universe>
References: <1569493537-7612-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d46ovw6gybmflark"
Content-Disposition: inline
In-Reply-To: <1569493537-7612-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d46ovw6gybmflark
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 26, 2019 at 01:25:37PM +0300, Claudiu Beznea wrote:
> Driver has been enabled also for SAM9X60. At the moment the patch which d=
id
> this has been sent to mainline the PMC for SAM9X60 wasn't integrated.
> SAM9X60 has a new PMC compatible (see commit 01e2113de9a5
> ("clk: at91: add sam9x60 pmc driver")). Do to this we have to
> look for proper PMC compatible here, in SHDWC driver.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-sama5d2_shdwc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> index e341cc5c0ea6..1c18f465a245 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -269,6 +269,12 @@ static const struct of_device_id at91_shdwc_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);
> =20
> +static const struct of_device_id at91_pmc_ids[] =3D {
> +	{ .compatible =3D "atmel,sama5d2-pmc" },
> +	{ .compatible =3D "microchip,sam9x60-pmc" },
> +	{ /* Sentinel. */ }
> +};
> +
>  static int __init at91_shdwc_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -313,7 +319,7 @@ static int __init at91_shdwc_probe(struct platform_de=
vice *pdev)
> =20
>  	at91_shdwc_dt_configure(pdev);
> =20
> -	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d2-pmc");
> +	np =3D of_find_matching_node(NULL, at91_pmc_ids);
>  	if (!np) {
>  		ret =3D -ENODEV;
>  		goto clk_disable;
> --=20
> 2.7.4
>=20

--d46ovw6gybmflark
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2kHMAACgkQ2O7X88g7
+pq7ohAAmySmtlvTEoMtu+Eg6ZkyLhWE91QzJjC093TI4eHPf9Qq1kRKpJvzf7w4
ft7/1dtdHaMh3WZ7QnzcqTRvYWuHqjWQn3vF/gNuuXkCbo0LBUI+zuJozc6+83Xp
XMRehD0muqSMEEPaceJAXw1uUiTn2oygLr5mDYBZpZtShk5qF5aNBRWccf8V1Npj
ZeZOj/whAqHAR5ixz3XaKOYuC9w5LWn63IrmTCtbWeJkuR3pfcjSJJkOH9MH3TYR
TipTLYjdsMGfrT6YWAFH/ay5dKKUALWYnyxkAwyis/BZuaxtUuJwLuEpXAd2WO6Q
qBrAI3XMeWvf2csWXiJ/o6Dp1TnPWh4bNwaBM3McBNbgWdPNpfYZxH1db/GpXbds
ipP/ntBN/DKtQ07VfK/2JziQ3D+bR7fi5aTueLo+5+WtzlV/poBLooTWVMRWfRQn
ljaAUWw4EkIy2W97u1/u4ZRQHbNw8FUT2zn/zlOaDDA+HGMYU0etfb7aaY45QCUe
nzQaC+QkMvKLFJe+LYnkN7ZP+Aj28pP+A4Bejc14qN4p7PHwqPWHTHF7v/SfKS5T
xXc5lezAd+uBvTZkUpXEFBw/lW3RJFgF4HbiOaU6soNYW6IhXOgKrn57GYPuOuZE
XYk2VReN/wl+jhjh96z3rM51pdkSJT9eOOxNhOQTs3diaOvsPBY=
=lBa6
-----END PGP SIGNATURE-----

--d46ovw6gybmflark--

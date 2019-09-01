Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4849A4BB6
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfIAUNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 16:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfIAUNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Sep 2019 16:13:33 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C872190F;
        Sun,  1 Sep 2019 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567368812;
        bh=FpGeQN/2TrNtJwZWQqGwpAQLVtqjB3oj4oM4GNKdQ9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeRwWEpM52UPu5NaNIXd5pzKnL8c1KSFE5ekWxeuzQsEkOVeKkbvCGbJGsL+AGg31
         zkMFlsvM37JZtVkcYpYHDyCPglnIkC5CIjmkUiuKbMi0iZ0gib6rrRjzPF9wKrAm8j
         yfEwPFCva4Xmvyfu99IV5ZNhtth7dQdEzgD08B9M=
Received: by earth.universe (Postfix, from userid 1000)
        id E90753C0B7F; Sun,  1 Sep 2019 22:13:29 +0200 (CEST)
Date:   Sun, 1 Sep 2019 22:13:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: axp288_fuel_gauge: Add Minix Neo
 Z83-4 to the blacklist
Message-ID: <20190901201329.god5j3jer2xqvk2z@earth.universe>
References: <20190825154152.80087-1-hdegoede@redhat.com>
 <20190825154152.80087-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mr2ni7e5rivkvypy"
Content-Disposition: inline
In-Reply-To: <20190825154152.80087-2-hdegoede@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mr2ni7e5rivkvypy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 25, 2019 at 05:41:52PM +0200, Hans de Goede wrote:
> The Minix Neo Z83-4 is another mini PC using the AXP288 PMIC where the
> EFI code does not disable the charger part of the PMIC causing us to repo=
rt
> battery readings (of always 100%) to userspace even though there is no
> battery in this wall-outlet powered device.
>=20
> Add it to the blacklist to avoid the bogus battery status reporting.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 6db2e86098e9..e1bc4e6e6f30 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -726,6 +726,13 @@ static const struct dmi_system_id axp288_fuel_gauge_=
blacklist[] =3D {
>  			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
>  		},
>  	},
> +	{
> +		/* Minix Neo Z83-4 mini PC */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> +		}
> +	},
>  	{}
>  };
> =20
> --=20
> 2.23.0
>=20

--mr2ni7e5rivkvypy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1sJmkACgkQ2O7X88g7
+prF5g/9GEyK6QpE4uDn1Vey5d1oenHbuOiw1ZwDJMQCtR4pgydej4+WTP0ICkOs
HxZ+FlX3Zvb+Ew64l8uheON++45iAq340Ht6am3+DnTmC4Grgh8u7Jy4YpupOT2J
1GDy//PlsGpGL6HzQHztGvInsC5e0E77jgDs4hdVb4qHW4KsnMDsuRiR0QX/FEQl
Cem/T2OVoNdCxiZ9B1me2+0IxmBKLOfQW+xE7wqI/0eeAOVlDC89JP3h2l7o0kIE
Z4LlCaCNKbub+1Ft4J68rJA/Z5QU6AVe8pnzdyiEenNmGMjNdJVViXMjYLjxro9H
5UDqWqFTx4kEMTK5ECw7UNllenqqUqR5+rxHB8tjwUaQg1IqWjrcsvfG/woftMbN
fcMHOQsqMb6Ez0UPLJPTx+WyMSNbQNxpnOVlGA2ds6ArXnC8rMyL8iKy35GXU7lZ
vnfgoQjEY3kjmDkgEktCFko5xCrmZq9UhlOO/jQrAAkDAc4kGK2PocBtcENN+cCK
rYSHI/+iRNvaGFdzrMxSzb8mt2F5J8SD05kEe5ZIQmv0PrQMPYH+/c4YeMzqUwq6
GG8P9KMPC0Qv+KIFL+uI6unoyK18gdvsv/HiTelexiMiK5yvqUkERfD+0aS3JNYU
V2uwnKjJmDJIo6+dJ+hIcaKxf7lw7UnejlHwNS7aHVML1jrlON0=
=5fzI
-----END PGP SIGNATURE-----

--mr2ni7e5rivkvypy--

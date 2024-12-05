Return-Path: <linux-pm+bounces-18613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C19E5340
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B716618B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058D1DA31D;
	Thu,  5 Dec 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+5exeIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEB1D5CE3;
	Thu,  5 Dec 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396481; cv=none; b=ae35tGhtqK3gtO1thil70+KpX6JPZ0LGFfqICc3V0JA/czfKPeNt9Srb9IRJIW5q0SZ6WhsI7AHHQ3tHcMmpe/kEEnMnZxy0TOCgBaV0j2qhOP8BEFqqKNaqlLh0dKAyKoOPndKbLZhoskr1SDVIIAYMc4VlKfZjOUmUIn0pTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396481; c=relaxed/simple;
	bh=JcI1zEQmAwPsUCqWj/3UDFGiJYxHwtuikUb7aQqXyho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR84luhh1ZRPpJ92ja4JdReiMYAxi1fQMg9mew7ycaHO1G74HxO/5DKu+niQGyAi/Y7I41K4/CjfxoY0iZLncT4AKlznqUDUholZpBB8oJgYOxDYcVCn3GnSsxjXewRLySTnmFWzUgowe79rAFEhtZwT7SYUCdmG0cR/viiSpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+5exeIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2F0C4CEDF;
	Thu,  5 Dec 2024 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396479;
	bh=JcI1zEQmAwPsUCqWj/3UDFGiJYxHwtuikUb7aQqXyho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+5exeIYFO8oWmx+yBilju6NrR3S/lvfz8SGYJL8aXoYUCwQTd0xG9+GiQnrGOIj7
	 1N55rwYqDUqVGQgZyVCRMG5MEBu7S47pR5/DcYVyFQ6jly0GJ/FjQrdc4XZdMo33wm
	 NxORS1rvR2fz+GUoUjAUIueec7siMGyckC/gr3ghULeyKNZfSPs1UiFmd4qHIgQrzb
	 qV3ZujrOjjP3t+aiKbikz55yfrd352BrNsFzsBcGA/63aAciaTc/yhjgoqbY3II+s+
	 85SiQOAR+KXKmavUJS6fjiCsmD+fMFTX6fBkFkrR/GDlRZ98PTv398eqy8914hheyo
	 zvm1c1lOZrpZA==
Received: by mercury (Postfix, from userid 1000)
	id D909210604B0; Thu, 05 Dec 2024 12:01:16 +0100 (CET)
Date: Thu, 5 Dec 2024 12:01:16 +0100
From: Sebastian Reichel <sre@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 5/8] power: ip5xxx_power: Check for optional bits
Message-ID: <p3uryekxe66hd2n7svp4j4laqjaycv5o6qu6b37shwxmiuljur@23o44yw6jmkv>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
 <20241119180741.2237692-5-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhq4ahvt5mwrn74j"
Content-Disposition: inline
In-Reply-To: <20241119180741.2237692-5-csokas.bence@prolan.hu>


--vhq4ahvt5mwrn74j
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 5/8] power: ip5xxx_power: Check for optional bits
MIME-Version: 1.0

Hi,

On Tue, Nov 19, 2024 at 07:07:37PM +0100, Cs=F3k=E1s, Bence wrote:
> Some parts may not have certain control bits. These bits
> however may be non-essential to the system's operation,
> as the default behaviour is the one we would set anyways,
> or the bits are not applicable for said part (e. g. enabling
> NTC on a part without an NTC pin, or one where it cannot
> be disabled via registers anyways).
>=20
> Signed-off-by: Cs=F3k=E1s, Bence <csokas.bence@prolan.hu>
> ---
>  drivers/power/supply/ip5xxx_power.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/i=
p5xxx_power.c
> index f64767b81c3b..f47198731a0c 100644
> --- a/drivers/power/supply/ip5xxx_power.c
> +++ b/drivers/power/supply/ip5xxx_power.c
> @@ -113,6 +113,7 @@ struct ip5xxx {
>  	u8 chg_end_inverted;
>  };
> =20
> +#define REG_FIELD_UNSUPPORTED { .lsb =3D 1 }

This belongs into the last patch. I fixed it up while applying the
series.

Greetings,

-- Sebastian

>  /* Register fields layout. Unsupported registers marked as { .lsb =3D 1 =
} */
>  struct ip5xxx_regfield_config {
>  	const struct reg_field charger_enable;
> @@ -206,9 +207,11 @@ static int ip5xxx_initialize(struct power_supply *ps=
y)
>  	 * Disable shutdown under light load.
>  	 * Enable power on when under load.
>  	 */
> -	ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.ena=
ble, 0);
> -	if (ret)
> -		return ret;
> +	if (ip5xxx->regs.boost.light_load_shutdown.enable) {
> +		ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.en=
able, 0);
> +		if (ret)
> +			return ret;
> +	}
>  	ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.boost.load_powerup_en, 1);
>  	if (ret)
>  		return ret;
> @@ -231,9 +234,11 @@ static int ip5xxx_initialize(struct power_supply *ps=
y)
>  	 * Enable the NTC.
>  	 * Configure the button for two presses =3D> LED, long press =3D> shutd=
own.
>  	 */
> -	ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
> -	if (ret)
> -		return ret;
> +	if (ip5xxx->regs.battery.ntc_dis) {
> +		ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
> +		if (ret)
> +			return ret;
> +	}
>  	ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.btn.wled_mode, 1);
>  	if (ret)
>  		return ret;
> @@ -507,9 +512,12 @@ static int ip5xxx_battery_set_voltage_max(struct ip5=
xxx *ip5xxx, int val)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
> -	if (ret)
> -		return ret;
> +	/* Don't try to auto-detect battery type, even if the IC could */
> +	if (ip5xxx->regs.battery.vset_en) {
> +		ret =3D ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.34.1
>=20
>=20
>=20

--vhq4ahvt5mwrn74j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdRh/wACgkQ2O7X88g7
+prYdQ//aYL3ELMkAJIj0YiiQw3hIAtKbYUxh9F1Pq7nYVJus1t3qzX8B3FLRq32
/PpdTQomI94jIWusEupTlCt4ycnZ1qIVDtqURt/oQ6AlIoFx32QYfp1k3AO1g2mM
+JblYEok3YFyXqdHSb+OSAG2DEvGJRHlQHUolXyXcjhdJ2JY+tNqyfO9dtAm6jN3
8qCO3nkqb6g9janHX/3eM+IkxYVkQr9yDRArd5qUQqBuAFxsUoyPhIqkLPv6Jkcx
klAIHhvRwRfjy5wjLEVjSAjZMFvAzUsAhbm+XVwIk6ee2xodtMSZ76DPAWUlcryI
y5hxRlgu6wQpJio/fmXX4SIBjUbqTj9lqk09cIMejIXLfOVczOp2uoSpmomHTRFY
+npO7bwjGfkRPD8WYAJVpCqG10AMLB2usEBWsQmlkc0nBnrjdmZiPj2/Ql/9Pcg7
sTdK+jxGOvlqGdVkrtgH7AwYriG6sJS/hhZyfxcIxSXRuPYcKkmKYDAQg9ITsZkv
tmyroqZxy0o3vVz/dBoxCAg1ChgvOec2vafeyFHr/yqqPtZhA0mG3cb1FPfQ6s9c
5m49zOITFC1WrjYcYmocX7VtHY/uwQoyLQ4iP/7kDbNT4N6u1WgE2l44KJbl2pMv
vWNgPKQZsSPdjx4VkZf3qJOiFh5OYf3AISMxaAOgGHcDNPwS2F8=
=00Dx
-----END PGP SIGNATURE-----

--vhq4ahvt5mwrn74j--


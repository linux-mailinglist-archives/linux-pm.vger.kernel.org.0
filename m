Return-Path: <linux-pm+bounces-3256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEBE84768A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4582873D7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410114D434;
	Fri,  2 Feb 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LsOZDKou"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59414C5BC
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895906; cv=none; b=VyWCh4noec0vQI65j3EY8dXIn6MnKx59vH1AzRSdDlh2it5ZGbNCNo5TwQxahjaE7Q23kj2ZVLe45TKdGGxZCQweqN8vhgJXQmv7qI48EN3ygfF1lUuwYkCYQUR4yrpjP0xVCo3xNKZFMtWrEqEl1L/0Sk5yxqxaiG9ef6PZhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895906; c=relaxed/simple;
	bh=PVPPHpevIfrxg9X8R1I3EOjZz3Hd3RWRhEwWbrLaSqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+uoSUkeZklRReqGTO7TlV3dExR4BH6EDYwnGqvelBnhYb7wFyOfmtL6eyntrUJXEtkErihxmmQS/Ceai2/Otj+lQw76jhXunNfWlFcNzboJejJeWETI+Cmv5uIFJuSF/XaCLI/puahn4Fib4k4v2QkQMwxLZ4zXdxf62goK0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LsOZDKou; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706895903;
	bh=PVPPHpevIfrxg9X8R1I3EOjZz3Hd3RWRhEwWbrLaSqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsOZDKouqm2azwCllZRePzKFDKoy4MvO1zbUJ0tid6JgrSzoj1OIPBVjW3NA1EdrT
	 fBG4VQ24919OEgPIeAH+TGSebgkkut62uX5efY+CLgeoFH4o8CHMnwTACIIDy11JvV
	 rVv1/V0oFf5tgZcXgJT//FIH3vXge8Lh5vWmu7G7roip3GgbnVQ3jFtb1UiMJ8zn1M
	 xzimLwwmL28xA7Qu77X+/jJbApaul9AUa69+sokkluLuSmNxuVjoPjE0/qp4Wr1x7S
	 B50FX5e7Vvi09jRPmsE7ru43UDFBXJ1R1M00lpcOv/w5SdvHsH1keiOuBmJ+Ahbww7
	 7JTZ/llCPGnuA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D74A73782095;
	Fri,  2 Feb 2024 17:45:02 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E569910611A5; Fri,  2 Feb 2024 18:45:00 +0100 (CET)
Date: Fri, 2 Feb 2024 18:45:00 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: axp288_charger: Add charge-inhibit
 support
Message-ID: <ggnxxsf4pcbv63is5waj3555yl2enmzgf4w7vtbhtv7qqfsujs@m3xw7splkwfm>
References: <20240104183516.312044-1-hdegoede@redhat.com>
 <20240104183516.312044-3-hdegoede@redhat.com>
 <m665fuuwj77duku4zsr5a22tn2ml44dh6l4vldypfxeihwipvq@fsh7rigfvgxg>
 <7c09ad89-bd7a-4f2d-a5ff-87d34296670d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3x27gt4x5fmz4uo"
Content-Disposition: inline
In-Reply-To: <7c09ad89-bd7a-4f2d-a5ff-87d34296670d@redhat.com>


--i3x27gt4x5fmz4uo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Jan 27, 2024 at 02:06:23PM +0100, Hans de Goede wrote:
> > We have since then added a new property for this:
> > POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
>=20
> Right I'm aware of that, but that is a property which so far
> has only been used on batteries, not chargers. [...]

Right. It's a design that leaked from the added ACPI vendor
solutions added to the kernel.

> So one possible solution which I came up with when originally
> preparing this series would be for axp288_charger.c to export a:
>=20
> int axp288_charger_inhibit_charger(struct power_supply *psy, bool inhibit=
);
>=20
> And then have axp288_fuel_gauge.c call
> power_supply_get_by_name("axp288_charger");
> and then call axp288_charger_inhibit_charger()
> with on the retrieved "axp288_charger" psy.
>=20
> And add a POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR prop
> to the fuel-gauge/battery driver this way.

I think at some point we might have to add the charge inhibit
property to a USB/MAINS typed device, considering not all
fuel-gauges come bundled with the charger counterpart, but
let's go with your suggested route for now.

Greetings,

-- Sebastian

--i3x27gt4x5fmz4uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW9KhAACgkQ2O7X88g7
+pqE4Q/+L7b5w2RbDeJ2+TryezqBEsha3BgAahVNNtH21ZgG9Gav3NPCFnallTgV
DhDgkoneeFnQMwnNa+7AZWQBUZcV40dMyC4BZITv1C7bjXkbigmhbTloQCt7JgZk
iuP15/JqZ5PoYvb+efT36PVeeiVyrXO93Naz0KoZEsNlS76bPeGvxhg37PLXu9mO
U0JHSknSHRCmHUaTLrvwBxgG7/uX5CwYqIriSGKA2Cx0wtbzY08g7hJZvxZUqGet
F5KGtfmbuNj1MZXvEak9b0IUMAs0w1nP4yUFlBdrIG+dSkdE55EJoNZJBJCgzpqK
aMrr4uvM1/DXA8iKVLUTh/8/RiwuGJvz3BXq4qmNZZ3VZb6KbnRc+eV4hlbRddTX
8MvtZfOClgW0586A2m5iNtRPxyXoSJFvnSRRVdraipIOszMRWrht1eFmDyUjzVXQ
PdTNAkj1m/I0LBG6sUx3ew89MJc17ME30K+qoETt6gPnUIvFUbhyYdPdm86wm8OL
BCqawpCrXVuly4kbIl19u0ITPnplbXHZR8qFU9Tgdi6jnbhn9sKoo8d/VM8OM4nt
G9Q0qkQOh0P6wOkQONDpYQcRdHw7+ivnyGC+ovaC1me2Fg5sVqrNiej/A1Miut/Q
s8KltlsH3fRsBYoVKOELtyoOTYgzyAxGwYiIt2CjSzQtuVinCA4=
=hG4B
-----END PGP SIGNATURE-----

--i3x27gt4x5fmz4uo--


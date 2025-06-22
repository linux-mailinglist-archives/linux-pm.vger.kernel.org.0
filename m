Return-Path: <linux-pm+bounces-29217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC8AE2DBE
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 03:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5337A41D8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81F2260C;
	Sun, 22 Jun 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Zn1VZRub"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B259AD2C
	for <linux-pm@vger.kernel.org>; Sun, 22 Jun 2025 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750554559; cv=pass; b=cshYmyhPgFPDI4lEaQRtBGbidTazlWPCQ6KZje/zPWFdcWCzsGRcQWThTlFNLr/qWZ5SzfPJzcb+zpd4dfPApHHk3+MAkQZtM+PhZFwu257FvidnROddqXXIIKm/cNysnTrVjk0bBm0N8m6OSy+UEwZFsgUNvEUx7XrRuMa2dUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750554559; c=relaxed/simple;
	bh=x9zTHKAOCpofWqAwwov+k5JYanfH9eTcnTWYuFxIbQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pODjwxIhfXiktnzyl9MTiasjhuOiX3zEpxHBHhmDAgZWb2zpxvpaepQql4c/L7uxdC3AS2kaPk+2ErsjgOf+JbanB+JvVsb4wg7sODByxhs/BkeO8j2UUa+HFH9LQqhs7dULY1lNGLSmxJpPgPl/zS89p8I9d7zL7YIQe6I5vaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Zn1VZRub; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750554551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I0Z8YukC/FwVKrItGosVU4cBCydeouhs0uN90kiPtx0fiutjul3iuvjpR5FKeTHzE5ndReASgTKxHX7UusZ6r1A4w7xJzZqp7wkFHT+w5j6Hlf5Z0rtVxBs5mHTRzhBj7CRjIoB6vz45Pp6ZxMTGRLTTnVa1l8PLzjtqkceN1fY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750554551; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JOG/1OOH1wI5Y/C0PzrBvcRwSGJKxB5EReytIzH6sKg=; 
	b=TiC5r2sHl8PjFSheL0uNsKmrAnZyDIZaAKjZ9D6HYD3p2v7A3bmCyST6Q/qmy6qVf/9BHy1w1FAnjptrpnm6jYZt5X07h7t+WMekMwRmRPdkwm2IZkdmav+tntda9PUVFBZf7RH3FAvNd/53rkz6L6Oj/slHszFKxBOVJMPNvk8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750554551;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JOG/1OOH1wI5Y/C0PzrBvcRwSGJKxB5EReytIzH6sKg=;
	b=Zn1VZRub6bKQ5Be6B5qh+l7b6GDipwuF3NHKs4brzfuPpd+N4Z3bpv6ozzqr0my1
	V0SwNZ0wqHyuvVjgZWL+nO3Doz+JK3ZJu0aLgU/TpocS0KBAHlVAv9K55v63/FxmhEa
	MW2JhnbZ0hxET8LTKCY6lMY2fpcDgA5/vElkDpGY=
Received: by mx.zohomail.com with SMTPS id 1750554548482135.5516068288074;
	Sat, 21 Jun 2025 18:09:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 84B1C1806CD; Sun, 22 Jun 2025 03:09:05 +0200 (CEST)
Date: Sun, 22 Jun 2025 03:09:05 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch to
 power_supply_batinfo_ocv2cap()
Message-ID: <cql7vri3yyk3fl6y4rrmfbj6ca75gv3y2hap5as4ulcefjenwg@jlebnndhe65x>
References: <20250608204010.37482-1-hansg@kernel.org>
 <175055104892.226297.388983002573981633.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="as24r33bdt6prphc"
Content-Disposition: inline
In-Reply-To: <175055104892.226297.388983002573981633.b4-ty@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.540.22
X-ZohoMailClient: External


--as24r33bdt6prphc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch to
 power_supply_batinfo_ocv2cap()
MIME-Version: 1.0

Hi,

On Sun, Jun 22, 2025 at 02:10:48AM +0200, Sebastian Reichel wrote:
>=20
> On Sun, 08 Jun 2025 22:40:00 +0200, Hans de Goede wrote:
> > This series converts the ug3105_battery driver from using
> > a static ovc - capcity mapping table + its own DIY code to using
> > the ovc-capacity-table(s) from the battery fwnode and using the
> > power_supply_batinfo_ocv2cap() helper.
> >=20
> > Since the ug3105_battery driver is used on ACPI platforms this relies
> > on sre's "[PATCH v2 0/5] power: supply: core: convert to fwnode" series
> > for completenes sake I've added a copy of that series + 2 fixup patches=
 to
> > "[PATCH v2 3/5] power: supply: core: battery-info: fully switch to fwno=
de",
> > the original patches are unmodified.
> >=20
> > [...]
>=20
> Applied, thanks!

> [08/10] power: supply: ug3105_battery: Use psy->battery_info
>         commit: 8842bd00a74bf758fb1abf572ec1c7d70c09dedb
> [09/10] power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv=
2cap()
>         commit: 2986e5b213cd84ac290ae68e73b7629ec8f184a6
> [10/10] power: supply: bq24190: Free battery_info
>         commit: 6aa1c3a72b99abeb7ddc649047073d701ede2c91

I obviously also applied 1-7, but without b4 as that required some
manual work to prepare the immutable branch for regulator and
squashing the fixup patches :)

Here is the pull information for regulator:

---------------------------------------------------------------------------=
----
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/ib-regulator-psy-for-v6.17-signed

for you to fetch changes up to ceed13630489fb9afbaa1326d2adc793d91fa48b:

  regulator: act8865-regulator: switch psy_cfg from of_node to fwnode (2025=
-06-22 01:39:51 +0200)

----------------------------------------------------------------
Immutable branch for power_supply_config.of_node removal for v6.17

This immutable branch updates the remaining user of
power_supply_config.of_node to use .fwnode instead, so that the
any code related to power_supply_config.of_node can be removed.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Sebastian Reichel (1):
      regulator: act8865-regulator: switch psy_cfg from of_node to fwnode

 drivers/regulator/act8865-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------------------------------------------------------=
----

Greetings,

-- Sebastian

--as24r33bdt6prphc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhXV60ACgkQ2O7X88g7
+prFzw/+P1JgMOM68wYNQebKovuVH1vuHuWj7T++zAgvslT4dGDtiyJ0+2U6cURz
ZhS+rtVh1P40FMZPMoDC/Ev8qbI5gcXhAdfKs+2ktp/BmtNwsO8PB6xK3fyX38u0
WRrH/3pCmF3FY3dJT5ORVST/NB9Rk5w/G8ERahtbFUZlsOvQZ833+4E01maqQBka
cT//TYGNJ2mS4V59xYNGHxX4qhQ0kHLdlTG0bach4cZZX4MKh7p5lPlRQQCoX1q2
9X25oGJdDtC3Qq0peY1vcYDo9RWv95xFcMDzQTjxUwLfHlUBzAviaentmgMluIZL
KpJ4J6ZkyAbiGXLPEeabluBj0mX0QFsi+B3qtPLc0GEAcxPTUt0egm9NRcbsIDA+
hdzL2K8MZxeJJH1l0nhxCLZItdUrqEJ53NDeHR/4IHUl15+KnT0dT+jupNnDVFLM
N7ZfEbQO3O2EE+sUcXQv87BwtOX9gs4DGUPM1XIzl8O8oWjCVXMJOIbgSXlboPr0
gToGdyXkvI/zyN96It/86i8TEcXHy1gqMg0k41cSVtlvKAGYjqZMyZFZ7L+9vSSn
l+ms4UMJJCwdFPWiOf6JJlOHiKTw90D3EpdIAUcd/+9EMTKb7+mtXq/gFhlbZeg5
h6LnatwNuDmBcHeDd0kI2KtmWMRtQzNRewmQ2/zf58qnTJmsKzU=
=ioaB
-----END PGP SIGNATURE-----

--as24r33bdt6prphc--


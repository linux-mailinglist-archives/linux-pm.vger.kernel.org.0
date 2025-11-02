Return-Path: <linux-pm+bounces-37266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 936BBC29A6C
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 00:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367344E5A12
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0723C8A1;
	Sun,  2 Nov 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZdeONz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0092367D7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127100; cv=none; b=DSQZrt/CNExUzNRFwvGrEWJU0WJ/Q8MjR/iAqBIaxSMvipLBfyPZi/tx3kjMGqI4Ju7iXtmD04uxu0ZgRIPHtRFX/DWzYOMCnGj2wFq+0DOX8evYEojG1rGxnmvuSwoIcMs4tuLAB7ZYu3OXMNJzfspOINI60/fDwnneLnKPM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127100; c=relaxed/simple;
	bh=F72z28N0gUPu6yPCaYpUAFSWhOsLfxnKTEcOeEgF6H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDEBfzcDpPAoHm+wU+9E9R1Ur77hQXuLXwg9z4hLkw/BXtBTPnlt3pTk4A0lmGloT9FIu5e46iq7MB1MB7E0yPh/XVUdxuVdsa7X96b6u0stXvf+TG2+kg7weAgmuBJ6JjrqZvujeZ/Q6i6e2+hfFiHVLP/fHqNOc4Oqu9f6kis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZdeONz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26876C4CEF7;
	Sun,  2 Nov 2025 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762127099;
	bh=F72z28N0gUPu6yPCaYpUAFSWhOsLfxnKTEcOeEgF6H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZdeONz6A1E1CYepuHdPfIDa5BgPNEeiuywAIXXyTecq9qV3YSNxLM3EjogbV6Z3P
	 yMYEZ5YcFrbREtat3Vgy6G/s/SVbmXlytgCrNHL3EhKlovjdvxYjQmw7DELl6vBNUr
	 xgEhSdnKx2O0wFfouPb1SnxreHgmxjSNclyGQUxxinbA3NRxVscQjABYu+3fkVhA0h
	 UjDT99PRHHFLeW41HdF23Be8dAJoYg3d3ZBkRHc3PsMduJQ7XcQODpOvlfiEMNA/bR
	 aJRBVGsX4PNhcF9FKVQ0Rsss2HMXtPUb4ayqCOqsqQrBT0PJlH/aot8TLmjDIlTj2b
	 LXiXvhdVIK71Q==
Received: by venus (Postfix, from userid 1000)
	id 0CD5A180CDA; Mon, 03 Nov 2025 00:44:55 +0100 (CET)
Date: Mon, 3 Nov 2025 00:44:55 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Fleer <dev@dwurp.de>
Cc: linux-pm@vger.kernel.org
Subject: Re: power_supply sbs-9-000b: driver failed to report `technology'
 property: -5 on rk3399 google-gru
Message-ID: <5njqjtvi72z35b5chhgf66jqucvycy43ul3z4b35nfijhod2ah@v7mtbeb3mqp5>
References: <078eef57-07c9-420a-99b1-e47b3dd93204@dwurp.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hl4iwffqqlbl6dv2"
Content-Disposition: inline
In-Reply-To: <078eef57-07c9-420a-99b1-e47b3dd93204@dwurp.de>


--hl4iwffqqlbl6dv2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: power_supply sbs-9-000b: driver failed to report `technology'
 property: -5 on rk3399 google-gru
MIME-Version: 1.0

Hi,

On Fri, Oct 31, 2025 at 01:03:02PM +0100, Sebastian Fleer wrote:
> Hi,
>=20
> on an Acer Chromebook Tab 10 (RK3399 google-gru/scarlet) we see a lot of =
these error messages
> (sometime multiple times per second):
>=20
> [  247.155467] power_supply sbs-9-000b: driver failed to report `technolo=
gy' property: -5
>=20
> With POWER_SUPPLY_DEBUG=3Dy these look like this:
>=20
> [  142.335138] power_supply sbs-9-000b: driver failed to report `technolo=
gy' property: -5
> [  142.352393] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit =
conversion 0
> [  142.352437] sbs-battery 9-000b: sbs_get_property: property =3D 0, valu=
e =3D 1
> [  142.353283] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit =
conversion 51
> [  142.353310] sbs-battery 9-000b: sbs_get_property: property =3D 51, val=
ue =3D 0
> [  142.355202] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit =
conversion 2
> [  142.355231] sbs-battery 9-000b: sbs_get_property: property =3D 2, valu=
e =3D 0
> [  142.359681] sbs-battery 9-000b: sbs_read_string_data_fallback: i2c rea=
d at address 0x22 failed
>=20
> Battery status reporting with upower seems to be hit or miss:
>=20
> $ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
>   native-path:          sbs-9-000b
>   vendor:               <unkn>
>   model:                <BATT>
>   serial:               ffff
>   power supply:         yes
>   updated:              Fri Oct 31 12:41:02 2025 (3 seconds ago)
>   has history:          yes
>   has statistics:       yes
>   battery
>     present:             yes
>     rechargeable:        yes
>     state:               discharging
>     warning-level:       action
>     energy:              0 Wh
>     energy-empty:        0 Wh
>     energy-full:         36.55 Wh
>     energy-full-design:  33.78 Wh
>     voltage-min-design:  3.84 V
>     voltage-max-design:  3.84 V
>     energy-rate:         0 W
>     charge-cycles:       N/A
>     percentage:          0%
>     temperature:         23.9 degrees C
>     capacity:            100%
>     icon-name:          'battery-caution-symbolic'
>   History (charge):
>     1761910862  0.000   discharging
>     1761910806  62.000  discharging
>     1761910801  0.000   discharging
>     1761910796  62.000  discharging
>     1761910791  0.000   empty
>     1761910755  62.000  discharging
>   History (rate):
>     1761910851  0.000   discharging
>     1761910821  4.380   discharging
>     1761910791  0.000   empty
>     1761910760  1.658   discharging
>=20
> $ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
>   native-path:          sbs-9-000b
>   vendor:               <unkn>
>   model:                <BATT>
>   serial:               ffff
>   power supply:         yes
>   updated:              Fri Oct 31 12:41:07 2025 (18 seconds ago)
>   has history:          yes
>   has statistics:       yes
>   battery
>     present:             yes
>     rechargeable:        yes
>     state:               discharging
>     warning-level:       none
>     energy:              22.6548 Wh
>     energy-empty:        0 Wh
>     energy-full:         36.54 Wh
>     energy-full-design:  33.77 Wh
>     voltage-min-design:  3.84 V
>     voltage-max-design:  3.84 V
>     capacity-level:      Unknown
>     energy-rate:         73.1904 W
>     charge-cycles:       N/A
>     time to empty:       18.6 minutes
>     percentage:          62%
>     capacity:            100%
>     icon-name:          'battery-full-symbolic'
>   History (charge):
>     1761910867  62.000  discharging
>     1761910862  0.000   discharging
>     1761910806  62.000  discharging
>     1761910801  0.000   discharging
>     1761910796  62.000  discharging
>     1761910791  0.000   empty
>   History (rate):
>     1761910867  73.190  discharging
>     1761910851  0.000   discharging
>     1761910821  4.380   discharging
>     1761910791  0.000   empty
>=20
> These errors show up with kernel 6.12.55 as well as 6.17.5.
>=20
> More context is available here: https://gitlab.postmarketos.org/postmarke=
tOS/pmaports/-/issues/2261
>=20
> Any idea on how to fix this is highly appreciated.
>=20
> Best regards
> Sebastian

Looks like 'google,cros-ec-i2c-tunnel' being crappy again. Can
you check, that you are running the latest EC firmware? Apparently
things are being fixed in its firmware, see e.g. this thread:

https://lore.kernel.org/all/20240418-sbs-time-empty-now-error-v3-1-f286e29e=
3fca@collabora.com/

Greetings,

-- Sebastian

--hl4iwffqqlbl6dv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkH7PMACgkQ2O7X88g7
+pqV9A/8CVPvvJtyYhRhV2lqwaT10tMvulQ7LWCImXq9IJKqypAv4XZtsgu/8tzl
0p8NHcifhqin77sN6MmivlymMeCfHD/bzrK3IqSlVvOeyKK4l2rhN83tnoSqeY5D
Lr9t/F8PAnRV5kDzuAj6PMU9Bevp9HhmsN+auTj8HRK4Z7vhjbRqtSZtckg2k8Su
J2nbOE7VYx9SDV/mK+qpuaXPxYx+no13FtDjhPR5bJi0IgB5N4oFx5kKsUv8oLCX
nZNz9PAVMZxNKWdl2Wv/0Bm7mLFucmcKfXkgzfWWjM9sSB5iyDKifwhP5KzD1SWU
WDDCTu2UQVuPrGpM7wY0RuqETKx4dTl6F2POY2XD/bUa5X8YwYV0A9+tFxaCOkY+
0EK/cpxc3lpDE3OLCF2ivqxrc/sZlVT3X+nkEW3WIhAbzlTxxCaENdE1fMBvUqu3
bIRI3IoDJP9WLpE+UxLN6F0X3lSQizkcdeHs8QXRAap4H0J/YYFcM47K6j5BN5l/
vwrnX6/0UtjR23KmM/Rhvcxold7+1YgzLnXk1wPOMPl0f/JWxx+cZwIVb2rUuFe2
1RZciuRjaGOBp+THHBtVVt3WRCZp841OdBANHOYoXthUxpdpJmtAhzn+0OQYutwP
+7mXLPV8HlhHqiyn3fNpRl2FXRPG+jVbY55/ShPYKmNSmjRzQto=
=P22m
-----END PGP SIGNATURE-----

--hl4iwffqqlbl6dv2--


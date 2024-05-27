Return-Path: <linux-pm+bounces-8197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B397D8D0F62
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 23:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252AE1F2190A
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547A481C4;
	Mon, 27 May 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ANNYFjfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC717E8F6;
	Mon, 27 May 2024 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845080; cv=none; b=QDWQw/AqfM4TpJOnhHgeykWB4sLvztjMyKyaS4Wuv82wohC29plBzj0jq3bwMyIEldCO8bC8b9Igj39em4b33GPF5ubryeGiK0tnBQtrkTYRBveMWOPgL3an57BWZJC3SqtRxvQr/dzdI9Gw2GYVmr8bYkV8SQrCkTsYc2Zv0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845080; c=relaxed/simple;
	bh=1tfWPBOaY2HZNRVAs4AAafQP85FRZBDGs7XXyrAsnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQGldBMCMeJg+psrilD3Igq2PO4uqM0z+ClHa5bAKhJtevhYHUNs34O0eI+G5jhNH7BoVqRsv+f4/oWcpjjOB9rs6q2Z4ctRi81DWsjkubaio+s9qsXFKvtJ6xSeC8gjhXXDUzwr+krFu7WlIOMBzlzf5QE06nDLHDyNoMJUtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ANNYFjfr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716845077;
	bh=1tfWPBOaY2HZNRVAs4AAafQP85FRZBDGs7XXyrAsnRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANNYFjfr+2fdPbqbqI9TH94obBJxwIlE0TsT7BsLQTVo6FqaisMjBEu+VpxKMYPNs
	 9u54othSJlCXkTf1QWDmtsD9abcZbTIElVM/+sf8jx+wyQGiI7BkP774gE/SEUJdZb
	 uaiPxe5vXks0Ow+XZEKTpjZJHt6E9p7YOBUMAWaZvOJbVdxl+Y9lKIaywSnwHT1PVZ
	 Rm8fdwv2YfUEoySgax/Df6Xj0SGxAN6sFELExAe4/3T04ljORr45nAJy0xXQrEXO3i
	 2nmvnSKBhOeGHyI8wss6UbeviUKacgbrU2NmT6usyCGw16cgcWFXU7QrTl02jUAdaW
	 UDKoU2nZwTYew==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE6C73780480;
	Mon, 27 May 2024 21:24:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 52A2610612B3; Mon, 27 May 2024 23:24:36 +0200 (CEST)
Date: Mon, 27 May 2024 23:24:36 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC] power: supply: gpio-charger: extend for supercap charger
 ltc4041
Message-ID: <knttkcnsjvpzoknh4zhplot7cv2zwrnhvbj5no2lb63hsxwdgs@slgju4wuz3qo>
References: <9f01e84c-ef3a-4b77-955e-0bc1d95c9af0@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogobqjsd7ncmkqzf"
Content-Disposition: inline
In-Reply-To: <9f01e84c-ef3a-4b77-955e-0bc1d95c9af0@solid-run.com>


--ogobqjsd7ncmkqzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Josua,

On Thu, Apr 25, 2024 at 11:23:35AM +0000, Josua Mayer wrote:
> I came across your generic gpio-charger driver while looking at a
> design using ltc4041 charging a super-capacitor that is providing
> a few seconds of backup power. Since the charger only reports
> status via gpios, it seems like a fit.

First of all - In case you haven't noticed - Mike Looijmans is
currently working on driver support for ltc3350 (which is also
for capacitors):

https://lore.kernel.org/linux-pm/20240416121818.543896-1-mike.looijmans@top=
ic.nl

> At a closer look however none of my signals match exactly.
> I want to explore possibility of extending your driver,
> please can you comment if this driver is a suitable place
> for achieving below goals?:
>=20
> (Relevant) Signals:
> - PFO: Power-Fail, reports losing mains
> - CAPGD: Super-Capacitor Power-Good,
> =A0 reports whether capacitor is >=3D 92.5%
> - CAPFLT: Super-Capacitor Fault Status,
> =A0 effectively reports if charging stopped
> - CHGEN: Enable/Disable charging
>=20
> Intended use-case:
> Kernel should detect losing mains (or better !CAPGD),
> then either generate event for user-space to perform
> graceful shutdown, or trigger shutdown by itself.
>=20
> So far we have abused gpio-keys monitored from userspace.
>=20
> I think two properties from existing dt-bindings can match:
> gpios: <&PFO>;
> charge-status-gpios: <&CAPFLT>;

As far as I can see it can signal things to be fine without the
capacitors actually being charged (e.g. because of the disable),
so that's not an acceptable thing upstream.

> In my opinion driver is missing:
> 1. disable-gpio: <&CHGEN>;
> 2. something to describe battery charge level.
> =A0=A0 E.g. I have CAPGD signal which says either:
> =A0=A0=A0 - 0: level < 92.5%
> =A0=A0=A0 - 1: level >=3D 92.5%
> =A0=A0 This could be simplified to 0% and 92.5%

The battery charge level should not be exposed by a charger device.
Instead a second power-supply device of type POWER_SUPPLY_TYPE_BATTERY
should be created. That device should set POWER_SUPPLY_PROP_TECHNOLOGY
to the POWER_SUPPLY_TECHNOLOGY_CAPACITOR type, which is currently added
by Mike (see link from above). Then the battery charge level can be
exposed via POWER_SUPPLY_PROP_CAPACITY_LEVEL. For example when CAPGD
is low, you set POWER_SUPPLY_CAPACITY_LEVEL_LOW and when it is high you
set POWER_SUPPLY_CAPACITY_LEVEL_HIGH.

For stopping the charging there are two ways. The cleaner one is
adding support for POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE
to the battery device.

All things considered, I believe think a dedicated driver makes
sense. It should be quite simple considering it only needs to
handle a few GPIOs. Something like

compatible =3D "ltc,ltc4041";
system-good-gpios =3D <&gpio>;
capacitor-good-gpios =3D <&gpio>;
charge-enable-gpios =3D <&gpio>;
capacitor-fault-gpios =3D <&gpio>;

Then you should have 1 charger device and 1 battery device exposed
to userspace. The charger device should supply the battery device.
Charger exposes POWER_SUPPLY_PROP_ONLINE and the Battery device
exposes POWER_SUPPLY_PROP_STATUS (charging/not-charging),
POWER_SUPPLY_PROP_TECHNOLOGY, POWER_SUPPLY_PROP_CAPACITY_LEVEL
and POWER_SUPPLY_CHARGE_BEHAVIOUR.

Greetings,

-- Sebastian

--ogobqjsd7ncmkqzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZU+g0ACgkQ2O7X88g7
+prJIg//QfNWrUEiP3cLedAYbtagsc8JWR9TlvTXRvfRpAHGk9B/R6GCXRSGLWDQ
cZrjR9Fvfzv0BNd5OsHDvx8ekoDSd2/oiaHeD80/axpTUkdFzGbfP/zKWv5eeRTa
UZMwtBRTxXB8uemQIxUH/znFL5T5RPjhbL8A+yB45/ihE9fSZRO8EPxf6n05vdze
eusU8ewdF0JjDoFT86elQ/1vZFjQYMvHkFjDYj1Q99F1V1mAl+G8pk6FD8+VhDWU
3GIB/i5F9ZR+DtJcle1WjIgUzOtrRJvDCbiw0aQqp4w/vTbYzEwBvam7kPCY5/IP
p0hDvwfNbVg4Ogc50EX8s5Z6mbKrSgOqEyOH4kM9M1uDYgayDGIowlsnj+i1qs18
LojuA/3P9I4mOMqMCVHmzroDTpUiTYzt3bbObZ9dCVRy3bhIM1WGjRql9rBCMRUf
uEJ6XSp+vsGer6a+/WtGvv4p8crNyhZS+b9bw7Dm7x/AzKiyQG9ZUTdvI28jAOR5
mghenDEjdghFWr7okmrgHW3ensxoWNB4QLjBgAt8gsiE5FTat7Ie0eetEQuZtXYi
GMrGXh0szU5xNvkZ+qj348M9AWjjYtlEXrttqYt8JZHuiY0C3QkgfOEWKF+o6tpw
vrdeyA3jOZPEFgOaZpOSDjSdBIUtVJytK2lj18L/4JeR2V01usc=
=hazy
-----END PGP SIGNATURE-----

--ogobqjsd7ncmkqzf--


Return-Path: <linux-pm+bounces-19472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CC9F7182
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 01:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BF31887FA5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0A2AE69;
	Thu, 19 Dec 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Fo73o0PK"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F569380;
	Thu, 19 Dec 2024 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734569925; cv=pass; b=sBgJ6KZCT8FW492wBem/LcZYPaVc5uyi/ixNv23bZtNYZAGdvNnjdRIhSaV4dmvCG06n7+oyNoqL1gjgVIsw6dyj1cjuhpuasU20jCm7+pI3uiNDlSAPLDbGfjBQ8TiZMUQtK1NoiiYJxcQP54h/cewq7vo2PpbHfE1ytMsikY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734569925; c=relaxed/simple;
	bh=shCHHBohu3F35kps+nMfPvYTns2BPRJMPAU15JmC6Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMixRJcsuLczltOCB1lPYb7HLlusCyQq1KBMa7fQOlK9UT4tQ7zEMev24KrCvY7PpRL58bL54YEe8xKD/shFrTtWRFcSQuo7zeBqpWV+vxZpQbVyR3wq04PVwXKdLSsZIMrudq33W64GEiXnRL/KrCze+lOcniz6gDZOPPGBbzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Fo73o0PK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734569909; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bMarpRNlx9HhikgqLB6vTirWYhVHW3aiseBhI628g7jIzigW2TQEqLfccSoYi6u5kABMkGhvisE19ZMJf/+ualEyE1SL2+l1v5jiGczyMASMKRes955FFPiuk3I5SmGaao99bff0fo9M3QWWetkLjXnohykk4AvqyR9ssLOybk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734569909; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5VKnP6yh+O6+iLySKxLGCgWT4dCYDpElnEEw971vstQ=; 
	b=gTqJY8ylNKmReA6lf8x/rQs480k0/xxvy2bZStSNTl2HKj7tGH/PK2h+GLoP7rjgLjWPHsuGtk5Q24cvybj1dcCR2cOqXrmqvalq2x7imQ3CmViUVJGP6xlyRym+bZrpLKYFN1UQhmeX3BMgNlLJn74YJqOmMhvI4vYFxbQLxP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734569909;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5VKnP6yh+O6+iLySKxLGCgWT4dCYDpElnEEw971vstQ=;
	b=Fo73o0PKiVb6KYqaPzdf3bGAdfdswzDulSY+dUeHQ+ABhHgVJoq9qN+CxGzVHZQZ
	POwiG5RciYhecBuUm+GS7TGCA1k5smozoylIMw1Q2ONMxqJjQsGQuMyz8VVgj4gcsgL
	b52rRWAe4X8CMiUIItNdBww19H67zHs7Fcao0jpM=
Received: by mx.zohomail.com with SMTPS id 1734569907604140.77821012777508;
	Wed, 18 Dec 2024 16:58:27 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 037D21060345; Thu, 19 Dec 2024 01:58:21 +0100 (CET)
Date: Thu, 19 Dec 2024 01:58:21 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stefan Raufhake <raufhakestefan@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s.raufhake@beckhoff.com, 
	s.dirkwinkel@beckhoff.com, s.raufhake@beckhoff.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable
 charger
Message-ID: <xmjsvdyp63clrjkef4up7k4cgk5wfyldbij5ycsb7kumitnypi@pz6jpyyz45rv>
References: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
 <20241213102825.5509-1-raufhakestefan@gmail.com>
 <8a7948f8-b80e-463d-95ef-2f3461b96896@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjbgasd5q45kzwr5"
Content-Disposition: inline
In-Reply-To: <8a7948f8-b80e-463d-95ef-2f3461b96896@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.551.59
X-ZohoMailClient: External


--kjbgasd5q45kzwr5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable
 charger
MIME-Version: 1.0

Hi,

On Mon, Dec 16, 2024 at 08:30:45AM +0100, Krzysztof Kozlowski wrote:
> On 13/12/2024 11:28, Stefan Raufhake wrote:
> > Hallo Krzysztof,
> >=20
> >>
> >> On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
> >>> From: Stefan Raufhake <s.raufhake@beckhoff.de>
> >>>
> >>> Some GPIO-controlled power supplies can be turned off (charging disab=
led).
> >>> Support changing the charging state by setting charge_type to
> >>> POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
> >>> charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case =
for
> >>> this is disabling battery backup on a UPS.
> >>>
> >>> Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
> >>> ---
> >>>  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
> >>>  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++=
++
> >>>  2 files changed, 49 insertions(+)
> >>>
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.
> >> </form letter>
> >=20
> > Sorry, it seems I made a mistake during the patch review process.=20
> > Should I reply to your email about version 1 of the patch or only about
> > version 2? I don't want to make another mistake and open two discussion=
s=20
> > at the same time.=20
> > I hope to do better in the future.
> >=20
> >>
> >>> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-char=
ger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>> index 89f8e2bcb2d7..084520bfc040 100644
> >>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>> @@ -44,6 +44,10 @@ properties:
> >>>      maxItems: 32
> >>>      description: GPIOs used for current limiting
> >>>
> >>> +  enable-gpios:
> >>> +    maxItems: 1
> >>> +    description: GPIO is used to enable/disable the charger
> >>> +
> >>
> >> You did not respond to my comments, nothing improved. Without
> >> explanation based on hardware - which I asked - this is still a no.
> >>
> >> Implement and respond fully to previous feedback.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >=20
> >=20
> > Sorry, I'm new to this and don't really know what exactly you want for =
the
> > hardware description and how best to represent our hardware in dts.
> > For the gpio power supply, it can basically be any circuit that impleme=
nts
> > a "fully charged" GPIO and a "disable ups" GPIO.
> >=20
> > We're using a circuit built around the LTC3350 (super capacitor ups chi=
p):
> > We use this pin to indicate that our UPS is fully charged (once the inp=
ut
> > is gone, it's not fully charged anymore):
> > PFO (pin 38): Power-Fail Status Output. This open-drain output is pulled
> > low when a power failure has occurred.
> > =20
> > For the "disable ups" GPIO, we have some external circuitry around the=
=20
> > LTC3350. I can't share the schematic, but it boils down to "disable usa=
ge
> > of ups" so that the device shuts down immediately when power is lost.
> > =20
> > We've implemented this in many of our devices, but first we're looking=
=20
> > at [1] and [2], which we also want to upstream the device trees for.
> > [1] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm=
-r-cortex-r-a53/cx9240.html
> > [2] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm=
-r-cortex-r-a53/cx8200.html
> >=20
> > For the LTC3350, there is a separate driver posted to the Linux kernel
> > mail list [3] by another devolper that we would like to use in the futu=
re,
> > but without this gpio, our circuit won't work.
> > [3] https://lore.kernel.org/all/?q=3Dpower%3A+supply%3A+ltc3350-charger
>=20
> This does not address my concerns at all. Read the previous comments -
> you are duplicating existing property.

I think there is some misunderstanding. IIUIC you (Krzysztof) are
referencing the following existing gpios property without any
prefix?

>  gpios:
>    maxItems: 1
>    description: GPIO indicating the charger presence

This informs the operating system, that the charger has been plugged
in (so the GPIO is an input from operating system point of view).

The work from Stefan is not about presence detection, but
controlling if the charging should happen at all (so the GPIO is an
output from operating system point of view). So that's two very
different things.

Technically there is some overlap with another existing property:
charge-current-limit-gpios. I suppose a charger device limited to
0 Microampere is effectively off. But I think its fair to have a
dedicated GPIO for explicit disabling.

If my analysis of the situation is correct, the documentation seems
to be bad. Please suggest better wording :)

P.S.: binding and driver should be send in separate patches.

Greetings,

-- Sebastian

--kjbgasd5q45kzwr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdjb6kACgkQ2O7X88g7
+pqvww//SI5mMm2ATGNhhViIxS4C7RmQBIA8DlYbs1sMvNt4VTHN8pqk8pFebgNE
9AOkuUd/taHHvk9YD6fwhHEcUWT8jmgKYCQ9C+TvxL4XJEwbTLmET4oI8nKX9pvg
HNgkaRjebbfzCNrKmqMyT4ZL0j8i/byU3o57K4pPwf7arFRn3drPp125GdnlMsc3
7GDkYc1WgdlM+VS/EaLF8lTANvRcCaJnw7gpjrkedrXVRwuD5UhpqRnQw5JIcaBu
inmi2NFTX9Hj8KKga5ZXhk/uHXQfnAThnWCSsF9YbliC7N5b4e/kJHcbis6I260Y
kIds3lOTaRCA5Am6i9p0Uc2V8uzW/bNtdkd64R66itc6Iw+7+dmM9hlxRJu+lAMV
zFYw/k1c3yZJ6hqPwpf2NA2SDMV/cbukRgOc/z/Zy73R71YsaF4FU+kH/vGIZnhV
PCpAVYaWxtspU4IeI2XbDeiINs7V74T1ntqIPVzf9P4ky6dDUe1b9rcM5NqncHsp
etKMuKR1uA/wtxUIRc75bER3n/2iXaRsVNPDmhtwsrQXMFIaKagQCSlg4khze7EV
M/3IeTb2vKhqyRaJAjyj2bdOI/E+SguXHlLdv160SHneGO54Q6Rszk0o5a61AT5g
xiY3Ax+ondAwvm24E4qO/+d8ShHlWjRS/QNnZitwpuIz1LkzrJk=
=CvNq
-----END PGP SIGNATURE-----

--kjbgasd5q45kzwr5--


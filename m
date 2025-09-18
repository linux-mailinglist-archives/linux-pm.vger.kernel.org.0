Return-Path: <linux-pm+bounces-34965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3107B855E4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BC11610CE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB1263F4A;
	Thu, 18 Sep 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/9hiC+P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2A221294;
	Thu, 18 Sep 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207111; cv=none; b=aox1238BpRkwuXmfEr6pogAGsYYxb9Kf64Z3uLpGYZdI0dtDjZSp8Y+7wkSLCZi7xSZJBrSzhSebsO0unnN6ZC/QXZjuxf4zGg/ok3JGZNctIRQNrTGJYn2ZDAuNFRKld0b0eeo6pwfVmEY5ief8ATfBIf/APtQnjHphHKZLucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207111; c=relaxed/simple;
	bh=TnEtqt8zRGxOFJsu788AtxTj+2RhD/P9D9iENr1RLsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrJ+2SBEx5IOeWXEnlmp1E70iagIjhbifFZdaOB1UZ+KDEW48efv4O6kplgMWd44x1C/HABuJau1dOPNZ3der+7Bci3s2+p7GaBTCn4jtdJHI0lpAte2XDYblkhmRuGoz444EqWzazM+kD3ZuPIVFulZviEm1P7gRhw09+AN0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/9hiC+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B627C4CEE7;
	Thu, 18 Sep 2025 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207110;
	bh=TnEtqt8zRGxOFJsu788AtxTj+2RhD/P9D9iENr1RLsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/9hiC+PDFXwaByDc1DFa5e9ZTZBtxJ+/G6w5YueOsdVO5ciMBla44UMSfGCgz8XM
	 bNoxbb6mu2qK1npKPmJg9W+U7VD0+aJhWWTP4Z+Zn+XCVYQfJpgTgagvdANYISHP0/
	 9ygmDKt4hQ+XRLrtbvS0uzydzsqdPv3MPfvIhBbUvzIbLqmZJ+PnqJuvmukPyPoZ5z
	 mvWIdNAxUvKdFRLmcotdXTNaiXxXjmqR3qxAhr6t3v59A+hXPAQog1JYN/R1ieFxoI
	 7xC85bVxy1ISwotk+O6IzDzDyCAm0TVermGXu0vQNoVA4d5TmxBV3BDeoqzr6CS3Sj
	 HxB1/+QksQ1Xg==
Date: Thu, 18 Sep 2025 15:51:45 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Thomas Antoine <t.antoine@uclouvain.be>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
Message-ID: <20250918-untying-safeness-8f8f5c6fd142@spud>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
 <20250915-presoak-answering-2df6fca532ad@spud>
 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
 <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkdfRE5owrDi+GpM"
Content-Disposition: inline
In-Reply-To: <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>


--bkdfRE5owrDi+GpM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 02:02:55PM +0100, Andr=E9 Draszik wrote:
> On Thu, 2025-09-18 at 14:36 +0200, Thomas Antoine wrote:
> > On 9/15/25 7:31 PM, Conor Dooley wrote:
> > > On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay=
 wrote:
> > > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > > >=20
> > > > The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
> > > > Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
> > > > Controller (TCPC), NVMEM, and additional GPIO interfaces
> > > >=20
> > > > Use max77759-fg compatible to avoid conflict with drivers for other
> > > > functions.
> > > >=20
> > > > The battery node is used to pass the REPCAP and ICHGTERM values
> > > > needed for the initialization of the fuel gauge.
> > > >=20
> > > > The nvmem cells are used to get initialization values and to backup
> > > > the learning and the number of cycles. It should work out of the box
> > > > with gs101-oriole and gs101-raven which were previously running
> > > > Android.
> > > >=20
> > > > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > > > ---
> > > > =A0.../bindings/power/supply/maxim,max77759.yaml=A0=A0=A0=A0=A0 | 7=
8 ++++++++++++++++++++++
> > > > =A01 file changed, 78 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,m=
ax77759.yaml
> > > > b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..4d45739fcaf26273ec5=
7b60049d6d0421df38efb
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759=
=2Eyaml
> > > > @@ -0,0 +1,78 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yam=
l#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Maxim Integrated MAX77759 fuel gauge
> > > > +
> > > > +maintainers:
> > > > +=A0 - Thomas Antoine <t.antoine@uclouvain.be>
> > > > +
> > > > +allOf:
> > > > +=A0 - $ref: power-supply.yaml#
> > > > +
> > > > +properties:
> > > > +=A0 compatible:
> > > > +=A0=A0=A0 const: maxim,max77759-fg
> > >=20
> > > Compatible doesn't match the filename, why?
> > > I assume the "fg" is fuel-gauge, but can this device be anything else?
> >=20
> > The max77759 is a multifunction chip.
> > The following compatibles are already used for some of those functions:
> > - maxim,max77759 (for the pmic)
> > - maxim,max77759-gpio
> > - maxim,max77759-nvmem
> > - maxim,max77759-tcpci
> >=20
> > The fuel gauge functionality that is added with this patch is very simi=
lar
> > to the functionality of the max1720x which is why the filename was chos=
en
> > to fit other maxim fuel gauge chips pattern.
> >=20
> > Maybe it would be better to use the maxim,max77759-battery compatible to
> > match the filename? It would also fit with the already existing
> > maxim,max77705-battery and maxim,max77849-battery compatibles.
>=20
> It also has a (battery) charger, a -battery compatible could be misleadin=
g.
> The datasheet refers to these subblocks as FG (for fuelgauge) and CHARGER.
> I'd suggest keeping those terms.
>=20
> Additionally, the FG block can also measure temperature and battery ID. F=
or
> those, a combination of (top-level) PMIC and FG registers are needed
> unfortunately. Which means that the FG should probably be an MFD child
> device, even though the FG itself doesn't depend on the top-level. Otherw=
ise
> it'd be hard to access the top-level PMIC register.

Keeping the -fg is fine, just propagate it to the filename. I dunno
where the -battery came from, since that doesn't match the filename
either.

--bkdfRE5owrDi+GpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwcgAAKCRB4tDGHoIJi
0vCYAP94q3x/h8nskwf9D0kk+qZG9caQn1cij0ehZ3ftRZ7bfQD/YcvfkHYyv5B0
voZuJSO4UzkFc6GuE+/boRTlGhrHUAA=
=3R4x
-----END PGP SIGNATURE-----

--bkdfRE5owrDi+GpM--


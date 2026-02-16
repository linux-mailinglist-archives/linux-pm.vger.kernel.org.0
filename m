Return-Path: <linux-pm+bounces-42717-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOjyGxNnk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42717-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A914718D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 314253003800
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BD2E62A9;
	Mon, 16 Feb 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8L/CO09"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5A18A6CF;
	Mon, 16 Feb 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267852; cv=none; b=MH54SSV4VjfPc0lGWcl9X0rWFUYU3KsgZgT7BTXZ3BhM12gVjfPgg/WeoakjRKhuin6mVDW/U0nXnNWVR7vNdurWwkzkNy893fSeqn6/TL3ZxzCoBbXXsQ4Bn1jmo4b4kBKOCwzJuSrAXD1cyNrkdldaZXbNQEXWQeEft8du5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267852; c=relaxed/simple;
	bh=wdSxH4E1pJ6SIf/GdFwtidQESX6c9IiN7amgF/woRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roGx7B2RVXNpsobAA6EffP7+1wFNPs/GSSVsxGlIsQ088v+eIUEOx65xkpULdSQysM/PiNNBk8k86AEPtccExPQ2tifanPJFzq9YCoCxI4Xo8qUZE8Nm/XRiY187OZOV8eJfU1/JzMoLDQfV4sdei6BVTvQKBeCxhRQWXDzYKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8L/CO09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D9C116C6;
	Mon, 16 Feb 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771267852;
	bh=wdSxH4E1pJ6SIf/GdFwtidQESX6c9IiN7amgF/woRh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8L/CO09fAu5jQ7NSfQAi+QiNSYAnfMt+tXMViQwx8Kmdt8djs2hmneRIdBoHAwUo
	 zkHIN/XhjVwqE7Vm25LrodSLws8n78kaB1wQxfZEpjMwoDH6wwqaV5gKyKhMN0k1q1
	 nHLdwLrSa2150S6uuw6V1XwzplGHwC46ZfW+VGmkKzHRAkEfUxf3yDIqKFmaFWZ45l
	 xJ7K9QfhcH0tWzKe8PZnC1mEjMAs9K4YFYbs+orwCdpbxAwIrQJQGu20TqzDzS8w5r
	 bXJTkN+5DKWtA1zR1DMv+cgIzs8Spca9t4aaO6cnJMtEfNOJIp/JcKDXbRI7qudAv9
	 afDrbT5ruMDIQ==
Date: Mon, 16 Feb 2026 18:50:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Message-ID: <20260216-plunder-defense-de11cf56dd3d@spud>
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pykK8frgXntPmpM9"
Content-Disposition: inline
In-Reply-To: <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42717-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 8F6A914718D
X-Rspamd-Action: no action


--pykK8frgXntPmpM9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:04 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> > > Document embedded controller used in ASUS Transformer device series.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++=
++
> > >  1 file changed, 98 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/embedded-contro=
ller/asus,transformer-ec.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/embedded-controller/as=
us,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-control=
ler/asus,transformer-ec.yaml
> > > new file mode 100644
> > > index 000000000000..670c4c2d339d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/embedded-controller/asus,tran=
sformer-ec.yaml
> > > @@ -0,0 +1,98 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/embedded-controller/asus,transfor=
mer-ec.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASUS Transformer's Embedded Controller
> > > +
> > > +description:
> > > +  Several Nuvoton based Embedded Controllers attached to an I2C bus,
> > > +  running a custom ASUS firmware, specific to the ASUS Transformer
> > > +  device series.
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/power/supply/power-supply.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - asus,p1801-t-ec-pad
> > > +          - asus,sl101-ec-dock
> > > +          - asus,tf600t-ec-pad
> > > +          - asus,tf701t-ec-pad
> > > +
> > > +      - items:
> > > +          - enum:
> > > +              - asus,tf101-ec-dock
> > > +              - asus,tf101g-ec-dock
> > > +              - asus,tf201-ec-dock
> > > +              - asus,tf300t-ec-dock
> > > +              - asus,tf300tg-ec-dock
> > > +              - asus,tf300tl-ec-dock
> > > +              - asus,tf700t-ec-dock
> > > +          - const: asus,transformer-ec-dock
> > > +
> > > +      - items:
> > > +          - enum:
> > > +              - asus,tf201-ec-pad
> > > +              - asus,tf300t-ec-pad
> > > +              - asus,tf300tg-ec-pad
> > > +              - asus,tf300tl-ec-pad
> > > +              - asus,tf700t-ec-pad
> > > +          - const: asus,transformer-ec-pad
> >
> > Can you explain somewhere here what the "dock" and "pad" devices are and
> > how they differ? For example, I am currently wondering why tf700t has b=
oth
> > "dock" and "pad".
>=20
> "pad" is used for the controller in the tablet itself in the pad
> "dock" is used for the controller in the mobile dock keyboard.
> Seems quite obvious.

To someone intimately familiar with the devices maybe. Not to the people
you have to justify your patches to. Your response implies that this is
some sort of thing that's like a surface, but please put an explicit
explanation into the binding somewhere as to what each compatible is
for.

> > Also, why are some of the compatibles permitted standalone? That should
> > be mentioned in your commit message too. Also, other than the sl101, the
> > standalone ones seem to have the same match data in the mfd driver. Why
> > are fallbacks not made use of there?
> >
>=20
> Because standalone compatibles describe a unique hw configuration
> which cannot be grouped into something meaningful. asus,p1801-t-ec-pad
> is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
> for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered EC
> in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
> Different generations, different form-factors.

I don't see any reasons here that eliminate fallback compatibles.
+	{ .compatible =3D "asus,p1801-t-ec-pad", .data =3D &asus_ec_pad_charger_d=
ata },
+	{ .compatible =3D "asus,tf600t-ec-pad", .data =3D &asus_ec_pad_charger_da=
ta },
+	{ .compatible =3D "asus,tf701t-ec-pad", .data =3D &asus_ec_pad_charger_da=
ta },
+	{ }
Three of them use the same match data, so you need to explain why you've
made these three standalone when all the others that share a programming
model got a generic fallback. Fallback usage is based on programming
model, not based on whether the devices are a physically different, so
your explanation must reflect this.

> > Since this transformer series seems to have multiple programming models
> > for "ec-pad" devices, it calls into question your use of the generic
> > fallback compatibles is appropriate and makes it seem like you should be
> > using device compatibles as a fallback.
>=20
> That is redundant.

I don't understand how that is a response to what I said.

> > The rest looks okay other than the filename, which doesn't match any of
> > the compatibles that you've got here.
> >
>=20
> How should I call it then?

Make it match a compatible, just like any other binding.

--pykK8frgXntPmpM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZNnBwAKCRB4tDGHoIJi
0ofNAQDLN/OiGK2nLtK85gSe4GDLxKR0WMvl6RLdJ9skwUi5XAEAsztEhTn77T7t
eA2U4+Hp3EMaqwEr0dF90NbsjEyS2QA=
=Aq6+
-----END PGP SIGNATURE-----

--pykK8frgXntPmpM9--


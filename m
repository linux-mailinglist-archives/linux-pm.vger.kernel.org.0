Return-Path: <linux-pm+bounces-42732-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COn0I3VLlGm/CAIAu9opvQ
	(envelope-from <linux-pm+bounces-42732-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:05:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037A14B257
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C673025D3C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8732ED43;
	Tue, 17 Feb 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boypn1/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648D31AF17;
	Tue, 17 Feb 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326315; cv=none; b=TLS8cHjc4H+tck93WmCSPwzbXHIgwipxnjPL6MvaJjQQUYPHr9PgvQOHlmPnRSXtKEBYY6cBiPyZsfnF+E7tS3iPBdhP2DKt3RrNzTIJdtdtMQIRI9SIVt7tKanQRGxzhJ4ICBx/1boglOFa+/bJAhXSojvV9ahF5ocetU7VHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326315; c=relaxed/simple;
	bh=gPyyR/7ikvEQ+k0catKV22lHF1UzCfh9kkZOmgBBZ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuCkVWvmDSY8U0YyMCG6chKk0t6q0KdDL/0E+ipGrPO++KYRRs1RdtmzegQSiM4653wtJ0gVU+Q+bqMk6XLRgsngf7936E55+TEmham/p9e9XG1kXau8GPOX3Vf8xFEBYhYqn0dee320hmxSNlA+PG7vc+7dVc/PiIDqsUkR8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boypn1/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD86C4CEF7;
	Tue, 17 Feb 2026 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326315;
	bh=gPyyR/7ikvEQ+k0catKV22lHF1UzCfh9kkZOmgBBZ3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boypn1/Y3AGFpbdM9BQTCvpQdWf6O5TUYde+H9jYdeJTY2EdTTXa/q5ci7N9FHwab
	 Z7RN4hsXnDBep/SFI0QlZHY+lT80Xig6F6D7u8cKPiPz9mC1snjtd8wDPd1oJRtGax
	 FSJOA50Ymy0J9P3o93EQKy8oBpaEPEsg796H5V6hAi2UnrkVP5wBYYMG995TepHkT/
	 ej/7/G8FrAX0R7gVRFUz+8UK4IMe/rEhehAvGtJIICslg0EQrw9NCCh6bsoQ+NF3X3
	 ZvKfSwgR7w+uLqHLyBrPcbWhZqKkSMwCzsNokkF98V0XwiOOQlLws0JTFyAyjfCy7e
	 FtWJ5WiIUfcMw==
Date: Tue, 17 Feb 2026 11:05:09 +0000
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
Message-ID: <20260217-vowed-botany-b1c47c7e40b8@spud>
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QE7oyCjZTLka3179"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42732-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3037A14B257
X-Rspamd-Action: no action


--QE7oyCjZTLka3179
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:14:40PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:50 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
> > > =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:0=
4 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> > > > > Document embedded controller used in ASUS Transformer device seri=
es.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  .../asus,transformer-ec.yaml                  | 98 +++++++++++++=
++++++
> > > > >  1 file changed, 98 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/embedded-co=
ntroller/asus,transformer-ec.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/embedded-controlle=
r/asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-con=
troller/asus,transformer-ec.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..670c4c2d339d
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/embedded-controller/asus,=
transformer-ec.yaml
> > > > > @@ -0,0 +1,98 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/embedded-controller/asus,tran=
sformer-ec.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: ASUS Transformer's Embedded Controller
> > > > > +
> > > > > +description:
> > > > > +  Several Nuvoton based Embedded Controllers attached to an I2C =
bus,
> > > > > +  running a custom ASUS firmware, specific to the ASUS Transform=
er
> > > > > +  device series.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: /schemas/power/supply/power-supply.yaml
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - enum:
> > > > > +          - asus,p1801-t-ec-pad
> > > > > +          - asus,sl101-ec-dock
> > > > > +          - asus,tf600t-ec-pad
> > > > > +          - asus,tf701t-ec-pad
> > > > > +
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - asus,tf101-ec-dock
> > > > > +              - asus,tf101g-ec-dock
> > > > > +              - asus,tf201-ec-dock
> > > > > +              - asus,tf300t-ec-dock
> > > > > +              - asus,tf300tg-ec-dock
> > > > > +              - asus,tf300tl-ec-dock
> > > > > +              - asus,tf700t-ec-dock
> > > > > +          - const: asus,transformer-ec-dock
> > > > > +
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - asus,tf201-ec-pad
> > > > > +              - asus,tf300t-ec-pad
> > > > > +              - asus,tf300tg-ec-pad
> > > > > +              - asus,tf300tl-ec-pad
> > > > > +              - asus,tf700t-ec-pad
> > > > > +          - const: asus,transformer-ec-pad

> > > > Also, why are some of the compatibles permitted standalone? That sh=
ould
> > > > be mentioned in your commit message too. Also, other than the sl101=
, the
> > > > standalone ones seem to have the same match data in the mfd driver.=
 Why
> > > > are fallbacks not made use of there?
> > > >
> > >
> > > Because standalone compatibles describe a unique hw configuration
> > > which cannot be grouped into something meaningful. asus,p1801-t-ec-pad
> > > is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
> > > for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered EC
> > > in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
> > > Different generations, different form-factors.
> >
> > I don't see any reasons here that eliminate fallback compatibles.
> > +       { .compatible =3D "asus,p1801-t-ec-pad", .data =3D &asus_ec_pad=
_charger_data },
> > +       { .compatible =3D "asus,tf600t-ec-pad", .data =3D &asus_ec_pad_=
charger_data },
> > +       { .compatible =3D "asus,tf701t-ec-pad", .data =3D &asus_ec_pad_=
charger_data },
> > +       { }
> > Three of them use the same match data, so you need to explain why you've
> > made these three standalone when all the others that share a programming
> > model got a generic fallback. Fallback usage is based on programming
> > model, not based on whether the devices are a physically different, so
> > your explanation must reflect this.
> >
> > > > Since this transformer series seems to have multiple programming mo=
dels
> > > > for "ec-pad" devices, it calls into question your use of the generic
> > > > fallback compatibles is appropriate and makes it seem like you shou=
ld be
> > > > using device compatibles as a fallback.
> > >
> > > That is redundant.
> >
> > I don't understand how that is a response to what I said.
> >
>=20
> in other words you propose this:
>=20
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - asus,sl101-ec-dock
>               - asus,tf101-ec-dock
>               - asus,tf101g-ec-dock
>               - asus,tf201-ec-dock
>               - asus,tf300t-ec-dock
>               - asus,tf300tg-ec-dock
>               - asus,tf300tl-ec-dock
>               - asus,tf700t-ec-dock
>           - const: asus,transformer-ec-dock
>=20
>       - items:
>           - enum:
>               - asus,p1801-t-ec-pad
>               - asus,tf201-ec-pad
>               - asus,tf300t-ec-pad
>               - asus,tf300tg-ec-pad
>               - asus,tf300tl-ec-pad
>               - asus,tf700t-ec-pad
>               - asus,tf600t-ec-pad
>               - asus,tf701t-ec-pad
>           - const: asus,transformer-ec-pad
>=20
> And in the driver add match to every single entry of enums?

No, I was talking about removing the generic compatibles entirely, since
they are not suitably generic to cover all devices at the point of
addition. So like:

items:
  - enum:
      - asus,tf101-ec-dock
      - asus,tf101g-ec-dock
      - asus,tf201-ec-dock
      - asus,tf300t-ec-dock
      - asus,tf300tg-ec-dock
      - asus,tf300tl-ec-dock
  - const: asus,tf700t-ec-dock

and

items:
  - enum:
      - asus,p1801-t-ec-pad
      - asus,tf600t-ec-pad
  - const: asus,tf701t-ec-pad

I dunno about these particular devices, but if there's already two
programming models for these devices, what's to stop there being more
added if/when a new generation of produces arrives?

--QE7oyCjZTLka3179
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZRLYgAKCRB4tDGHoIJi
0pTTAQCVObXrsRXv5jQUguwX1zozTmuRFRNaaceYPxOh+/AUVwD9HSdIhSFsgObt
RmWepdzWGxjVStDf7GfdD7Q+ybVIJQU=
=lLER
-----END PGP SIGNATURE-----

--QE7oyCjZTLka3179--


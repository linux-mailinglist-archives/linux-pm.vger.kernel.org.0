Return-Path: <linux-pm+bounces-42752-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPijCeF0lGnVDwIAu9opvQ
	(envelope-from <linux-pm+bounces-42752-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:02:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBED14CEA1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37C2A3003986
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBF331076A;
	Tue, 17 Feb 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXKtvdZD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197522BB13;
	Tue, 17 Feb 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336909; cv=none; b=JGYa2um1USZhpd6AuDm88r2x+zhlBcaoy2tV5QerxhjibAjh9QAKaq2E0ly7FwNIzNPSJNEcU4x3elSueApDEZdcf4d8e5Nk5SGJF+5bXeEHR4mfSfZGtuhb31eIeQ7k6AhjU5u/nExTz4ALmXtDM476Ed45WdcL6+xluVTGk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336909; c=relaxed/simple;
	bh=5kpz9DahDa3dNg2Aq2TuzXzUHYtmqL+QxJ5bKElFvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c19afy2m4+lTtpKuPamfsDp6HGD9QtWK0ffKs/9cGmzjadsK4E4AfCNyZhG72N1m+TKudGqdqN9Bu18/F+3otr3GDyytGXDFscFRMb3RZalzZlT/jNOIfisa3ELff2I+5JGSGyjkcG4ElCHV5gUSkKSKNkqvOGP/NXzpV0zPqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXKtvdZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6365C4CEF7;
	Tue, 17 Feb 2026 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771336908;
	bh=5kpz9DahDa3dNg2Aq2TuzXzUHYtmqL+QxJ5bKElFvNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXKtvdZDdhIJoNpJom4FnxDF+5cVahudPbINCM/T/KuW9Vy19S6yHrBXH56qc+XUw
	 8dJXs197V0uIKP+Jcu1a7yeGXiMKGsoKX5F4Yhft6Hgwe8Jq0JO1coskuuJSCPQ0CP
	 7we+RkMFCOMsB7qESvykP+VyeveH3quQMHdIRRh/rc85wOs03Tetwd0AVSvAuMpihC
	 qgoZfgKVu6IlqP9jDsAwu8iQBv9exYChMeS7MwmRIuShdN4/qqo4hrGxJk58IlpJp3
	 Vuq7X9c9U6Jk+PhtW+Q3psLjgZPt0OFCOCqw0RqMC6kVB87OI04/B0UgCZ+GPquK3x
	 5JSMYAPR9vXAQ==
Date: Tue, 17 Feb 2026 14:01:43 +0000
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
Message-ID: <20260217-reflux-secluded-a4754a6d8348@spud>
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
 <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BSN6ohZivsB0eTKO"
Content-Disposition: inline
In-Reply-To: <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RSPAMD_URIBL_FAIL(0.00)[devicetree.org:query timed out];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-42752-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[clamor95.gmail.com:query timed out];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: DCBED14CEA1
X-Rspamd-Action: no action


--BSN6ohZivsB0eTKO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 01:23:06PM +0200, Svyatoslav Ryhel wrote:
>=20
>=20
> 17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 13:05:09 GMT=
+02:00, Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >On Mon, Feb 16, 2026 at 09:14:40PM +0200, Svyatoslav Ryhel wrote:
> >> =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:50=
 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >> >
> >> > On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
> >> > > =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 2=
0:04 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >> > > >
> >> > > > On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> >> > > > > Document embedded controller used in ASUS Transformer device s=
eries.
> >> > > > >
> >> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> > > > > ---
> >> > > > >  .../asus,transformer-ec.yaml                  | 98 ++++++++++=
+++++++++
> >> > > > >  1 file changed, 98 insertions(+)
> >> > > > >  create mode 100644 Documentation/devicetree/bindings/embedded=
-controller/asus,transformer-ec.yaml
> >> > > > >
> >> > > > > diff --git a/Documentation/devicetree/bindings/embedded-contro=
ller/asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-=
controller/asus,transformer-ec.yaml
> >> > > > > new file mode 100644
> >> > > > > index 000000000000..670c4c2d339d
> >> > > > > --- /dev/null
> >> > > > > +++ b/Documentation/devicetree/bindings/embedded-controller/as=
us,transformer-ec.yaml
> >> > > > > @@ -0,0 +1,98 @@
> >> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> > > > > +%YAML 1.2
> >> > > > > +---
> >> > > > > +$id: http://devicetree.org/schemas/embedded-controller/asus,t=
ransformer-ec.yaml#
> >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > > > > +
> >> > > > > +title: ASUS Transformer's Embedded Controller
> >> > > > > +
> >> > > > > +description:
> >> > > > > +  Several Nuvoton based Embedded Controllers attached to an I=
2C bus,
> >> > > > > +  running a custom ASUS firmware, specific to the ASUS Transf=
ormer
> >> > > > > +  device series.
> >> > > > > +
> >> > > > > +maintainers:
> >> > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> >> > > > > +
> >> > > > > +allOf:
> >> > > > > +  - $ref: /schemas/power/supply/power-supply.yaml
> >> > > > > +
> >> > > > > +properties:
> >> > > > > +  compatible:
> >> > > > > +    oneOf:
> >> > > > > +      - enum:
> >> > > > > +          - asus,p1801-t-ec-pad
> >> > > > > +          - asus,sl101-ec-dock
> >> > > > > +          - asus,tf600t-ec-pad
> >> > > > > +          - asus,tf701t-ec-pad
> >> > > > > +
> >> > > > > +      - items:
> >> > > > > +          - enum:
> >> > > > > +              - asus,tf101-ec-dock
> >> > > > > +              - asus,tf101g-ec-dock
> >> > > > > +              - asus,tf201-ec-dock
> >> > > > > +              - asus,tf300t-ec-dock
> >> > > > > +              - asus,tf300tg-ec-dock
> >> > > > > +              - asus,tf300tl-ec-dock
> >> > > > > +              - asus,tf700t-ec-dock
> >> > > > > +          - const: asus,transformer-ec-dock
> >> > > > > +
> >> > > > > +      - items:
> >> > > > > +          - enum:
> >> > > > > +              - asus,tf201-ec-pad
> >> > > > > +              - asus,tf300t-ec-pad
> >> > > > > +              - asus,tf300tg-ec-pad
> >> > > > > +              - asus,tf300tl-ec-pad
> >> > > > > +              - asus,tf700t-ec-pad
> >> > > > > +          - const: asus,transformer-ec-pad
> >
> >> > > > Also, why are some of the compatibles permitted standalone? That=
 should
> >> > > > be mentioned in your commit message too. Also, other than the sl=
101, the
> >> > > > standalone ones seem to have the same match data in the mfd driv=
er. Why
> >> > > > are fallbacks not made use of there?
> >> > > >
> >> > >
> >> > > Because standalone compatibles describe a unique hw configuration
> >> > > which cannot be grouped into something meaningful. asus,p1801-t-ec=
-pad
> >> > > is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
> >> > > for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered=
 EC
> >> > > in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
> >> > > Different generations, different form-factors.
> >> >
> >> > I don't see any reasons here that eliminate fallback compatibles.
> >> > +       { .compatible =3D "asus,p1801-t-ec-pad", .data =3D &asus_ec_=
pad_charger_data },
> >> > +       { .compatible =3D "asus,tf600t-ec-pad", .data =3D &asus_ec_p=
ad_charger_data },
> >> > +       { .compatible =3D "asus,tf701t-ec-pad", .data =3D &asus_ec_p=
ad_charger_data },
> >> > +       { }
> >> > Three of them use the same match data, so you need to explain why yo=
u've
> >> > made these three standalone when all the others that share a program=
ming
> >> > model got a generic fallback. Fallback usage is based on programming
> >> > model, not based on whether the devices are a physically different, =
so
> >> > your explanation must reflect this.
> >> >
> >> > > > Since this transformer series seems to have multiple programming=
 models
> >> > > > for "ec-pad" devices, it calls into question your use of the gen=
eric
> >> > > > fallback compatibles is appropriate and makes it seem like you s=
hould be
> >> > > > using device compatibles as a fallback.
> >> > >
> >> > > That is redundant.
> >> >
> >> > I don't understand how that is a response to what I said.
> >> >
> >>=20
> >> in other words you propose this:
> >>=20
> >> properties:
> >>   compatible:
> >>     oneOf:
> >>       - items:
> >>           - enum:
> >>               - asus,sl101-ec-dock
> >>               - asus,tf101-ec-dock
> >>               - asus,tf101g-ec-dock
> >>               - asus,tf201-ec-dock
> >>               - asus,tf300t-ec-dock
> >>               - asus,tf300tg-ec-dock
> >>               - asus,tf300tl-ec-dock
> >>               - asus,tf700t-ec-dock
> >>           - const: asus,transformer-ec-dock
> >>=20
> >>       - items:
> >>           - enum:
> >>               - asus,p1801-t-ec-pad
> >>               - asus,tf201-ec-pad
> >>               - asus,tf300t-ec-pad
> >>               - asus,tf300tg-ec-pad
> >>               - asus,tf300tl-ec-pad
> >>               - asus,tf700t-ec-pad
> >>               - asus,tf600t-ec-pad
> >>               - asus,tf701t-ec-pad
> >>           - const: asus,transformer-ec-pad
> >>=20
> >> And in the driver add match to every single entry of enums?
> >
> >No, I was talking about removing the generic compatibles entirely, since
> >they are not suitably generic to cover all devices at the point of
> >addition. So like:
> >
>=20
> Actually, they all can be grouped under asus,transformer-ec fallback if t=
hat is needed, both pad and dock EC have the same core functions just diffe=
rent set of cells. And then in the driver each compatible will get a dedica=
ted matching data. Will this work?
>=20
> properties:
>   compatible:
>       - items:
>           - enum:
>               - asus,p1801-t-ec-pad
>               - asus,sl101-ec-dock
>               - asus,tf101-ec-dock
>               - asus,tf101g-ec-dock
>               - asus,tf201-ec-dock
>               - asus,tf201-ec-pad
>               - asus,tf300t-ec-dock
>               - asus,tf300t-ec-pad
>               - asus,tf300tg-ec-dock
>               - asus,tf300tg-ec-pad
>               - asus,tf300tl-ec-dock
>               - asus,tf300tl-ec-pad
>               - asus,tf700t-ec-dock
>               - asus,tf700t-ec-pad
>               - asus,tf600t-ec-pad
>               - asus,tf701t-ec-pad
>           - const: asus,transformer-ec
>=20
> And them schema name will match the genetic compatible.
>=20
> >items:
> >  - enum:
> >      - asus,tf101-ec-dock
> >      - asus,tf101g-ec-dock
> >      - asus,tf201-ec-dock
> >      - asus,tf300t-ec-dock
> >      - asus,tf300tg-ec-dock
> >      - asus,tf300tl-ec-dock
> >  - const: asus,tf700t-ec-dock
> >
> >and
> >
> >items:
> >  - enum:
> >      - asus,p1801-t-ec-pad
> >      - asus,tf600t-ec-pad
> >  - const: asus,tf701t-ec-pad
> >
> >I dunno about these particular devices, but if there's already two
> >programming models for these devices, what's to stop there being more
> >added if/when a new generation of produces arrives?
>=20
> There will be no new devices with this EC, last one was around 2013.

And what is to stop the next device in 2027 or w/e having a different
programming model (so a third)? That's my point, I wasn't talking about
there being more devices with two programming models evidenced here.

--BSN6ohZivsB0eTKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZR0xAAKCRB4tDGHoIJi
0mbTAP9S6Jq17X6Rujp8EuQk5Zee5mEjpHJ2YpwnCzxQnJObNgD/cZUZ2weA3O2n
XAIol5+H+/vBbYelSimFpVZrPjZpgAE=
=oBnj
-----END PGP SIGNATURE-----

--BSN6ohZivsB0eTKO--


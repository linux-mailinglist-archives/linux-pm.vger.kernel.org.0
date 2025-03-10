Return-Path: <linux-pm+bounces-23778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D3A59ABD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12FD1890C99
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757EF22F17A;
	Mon, 10 Mar 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3kuO3S+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFA1BCA1B;
	Mon, 10 Mar 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623320; cv=none; b=LqU5e0l2vmVeEy82H2rCEc+/+D9+C/tdGAalq0O/bmYdyyQ9BFKi5VOHvd1SRmYyHsyr3sgTV2hSxzIaMZAYMOmpVCpHvbWI9RmNLTISz7s+3TQR4whzHFn9u56RyBeLMOBACmzr6qB20xJbCZVFPDBQrSWme0D5l/seoftx9Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623320; c=relaxed/simple;
	bh=RCE73KHSUJ50jx3NFplvsYyJfYQ1fa2jm0Y9GrKAnwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK/QPsDucSoPRhhR6d6cq6US7YyUIClPeS51NPW2GD4RrfgbPJbw6e0X3mo9/GVSAELmovLcN3oeU1FrvQKjQ+kJqh/mrPDVqAem1Ij5ZiK40cWjnIsqUkVb/glYGx7f7NdyG/RkiFgFuerjmRZNgzwwlAPhUMlnCD9ehW0yYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3kuO3S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D516C4CEE5;
	Mon, 10 Mar 2025 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623318;
	bh=RCE73KHSUJ50jx3NFplvsYyJfYQ1fa2jm0Y9GrKAnwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3kuO3S+Nx7mCzhWvx/E/uIZ2vURLJ4P2hDaJ/deXkTW5gSBPZ/iLJVR2JXwWHjUB
	 +QryoEs3PGgZ3VFmGnP3YWKk+omEPpJalBHrodC6z5anZmuMoXxlTc+ndYdHSSa0Ow
	 0905svS6DLYRFVfGYi2VTtnGFESX5SAVoXdRjKWyj//gNXF64A5J6arWZ78ImhY5ZF
	 Z+RuABasjNYhtf9eI7lt+nKeTWLg2jtryY+RblgQtZmgE3JMw2cXb8hGqfbNSX1yNo
	 9t326LigmhFb7EiFJePa+VlsNLKXHRXxuogam0HqQws4j4NmCLSnM/w1XJYOlbWsWQ
	 TuaRFNZZuP75g==
Date: Mon, 10 Mar 2025 16:15:12 +0000
From: Conor Dooley <conor@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250310-blurry-scam-bee8233878bc@spud>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-barbell-pretzel-368d6a4d1336@spud>
 <OSBPR01MB2775D121B55A0C543F251BAEFFD72@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y4DhUv2VFm8QJbH+"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2775D121B55A0C543F251BAEFFD72@OSBPR01MB2775.jpnprd01.prod.outlook.com>


--Y4DhUv2VFm8QJbH+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2025 at 10:39:27AM +0000, John Madieu wrote:
> Hi Conor,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Friday, March 7, 2025 5:04 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Docume=
nt
> > the TSU unit
> >=20
> > On Fri, Mar 07, 2025 at 03:55:27PM +0000, John Madieu wrote:
> > > Hi Conor,
> > >
> > > > > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > > > ---
> > > > > > > v1 -> v2:
> > > > > > >  * Fix reg property specifier to get rid of yamlint warnings
> > > > > > >  * Fix IRQ name to reflect TSU expectations
> > > > > > >
> > > > > > > +    enum: [0, 1]
> > > > > > > +    description: |
> > > > > > > +      TSU operating mode:
> > > > > > > +      0: Mode 0 - Conversion started by software
> > > > > > > +      1: Mode 1 - Conversion started by ELC trigger
> > > > > >
> > > > > > Can you make this "software" and "elc" or something please,
> > > > > > unless people will genuinely find "0" and 1" to be more
> > informative.
> > > > > > And why doesn't the property have a default?
> > > > >
> > > > > Sorry for miss-specifying.
> > > > > ELC is an external event trigger. May be should I specify it like
> > that ?
> > > >
> > > > If "elc trigger" is meaningful to people using hte device (IOW, it
> > > > matches datasheet wording) then that's fine I think.
> > >
> > > "elc trigger" matches datasheet wording.
> > >
> > > >
> > > > > To make sure I got your point, do you mean specifying a default
> > > > > value in bindings ?
> > > >
> > > > The property doesn't actually need to be required, it could easily
> > > > have a default (say software) and only be set in the case of using
> > > > the elc trigger - which brings you to Rob's comment that it can just
> > > > be a boolean, setting the property if elc and leaving it out of
> > software.
> > >
> > > Got the point now. I can make it default to software trigger, and add
> > > optional Boolean property to ELC trigger. Let's say "renesas,elc-
> > trigger;"
> >=20
> > Yah, that works.
> >=20
> > >
> > > >
> > > > Rob's other comment was
> > > >
> > > > | Who/what decides the mode? If a user is going to want to change
> > > > | this, then it should be a runtime control, not a DT property.
> > >
> > > Changes are not possible at runtime. Some customers may want software,
> > > while other may want the external trigger, and this is immutable
> > > configuration.
> >=20
> > What makes it immutable? Set by some wiring on the board? I couldn't fi=
nd
> > the user in your driver patches to better understand how you were using
> > it.
>=20
> I haven't prototyped ELC trigger yet. Since the hardware manual
> describes about ELC trigger, I have documented it in bindings. If you
> think, it is not needed at this stage, then I can drop it now and
> revisit later.

Ideally a binding is complete, even if the driver isn't. To me
"immutable" would mean something like "the trigger type is determined by
hardware or firmware configuration", but if it is determined by register
writes (e.g. wired up for elc trigger, but you can opt for software
trigger in the driver) then it should be a userspace control.

--Y4DhUv2VFm8QJbH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ88QEAAKCRB4tDGHoIJi
0vhMAQCm2Y7JfoFQzgyGUf9s0PImQnGR4b2zFgNyA8NdDDoM3QD/eDs9SL5uwZcg
mBlbEbmXWmVrRzklDQPVrwR33fZJwQg=
=zZHw
-----END PGP SIGNATURE-----

--Y4DhUv2VFm8QJbH+--


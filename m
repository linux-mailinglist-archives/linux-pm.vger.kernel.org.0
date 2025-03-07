Return-Path: <linux-pm+bounces-23640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA3A56D17
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8A3B8854
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8161221554;
	Fri,  7 Mar 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqtpgJxM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A392206B6;
	Fri,  7 Mar 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363433; cv=none; b=WXiNDRn9K1pS7lUAboCjc2B8NYoCUL8Z27GXexTBxT/1xgolah0C6MemTRvtz75hYl+qthwGq3zoWDh0662dj4rCHmtvSaBvBcAPC5TKE1DwbdAHiEjQTuR+OByDvnIpcEky45+43iA8ziK+drKXVqsuyFwDOiW+vQ+Bxmxl2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363433; c=relaxed/simple;
	bh=jKcE6LBMQIEZD2siLfa8qIZAQzMXrOFejG9YW9TQFCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muoYEIAZG9HmRGJAlrl1PjmwbEwAt0TWI7xVn9j8u1dpz3nlg8qOl35TN7Ort4o51zXmWLtIfB2I5aM4H0kHhZgY6n7EHIse+GMVuq5q9rUkNk7HNxdSybfVC7A6615ROjVLLLibTJd3Ohlet5wJGYaCp1JZ5/TS3B4W+MPq4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqtpgJxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF8C4CEE3;
	Fri,  7 Mar 2025 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363433;
	bh=jKcE6LBMQIEZD2siLfa8qIZAQzMXrOFejG9YW9TQFCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqtpgJxM+FeMrOrrVjR4r9cUjgMcwN9iUIv+6+iR8KBfhyMfBbVmAMm+VSjWprAou
	 Hbymjq5Syj6JTZBa8Xjni9057HvoMx9qOQLbtsVRXcgEAHwb5dogZFSDMmyBGLqPUT
	 AtOU81kinqiCYTA+fCx98rXK7uz5ZXzgoooO5oYNjrkNQZXgZak8KAnZhlAVdCk3Bc
	 X2zpr2dmAZ8FE+P4BinuR9nTL4qyGZJXZGapTjFcAXfpoIaTMPinysbS6k/eZP5Zbl
	 vlvqKNeR4VPnGk7kmjAYk1FuHqrgxWTPWcTzqZYHzfkgUWJkXty0GgdyQO5oY/9Zpm
	 fQ7VtAswFxmfg==
Date: Fri, 7 Mar 2025 16:03:46 +0000
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
Message-ID: <20250307-barbell-pretzel-368d6a4d1336@spud>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FptXTXAIhD0gPfos"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>


--FptXTXAIhD0gPfos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 03:55:27PM +0000, John Madieu wrote:
> Hi Conor,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Friday, March 7, 2025 4:33 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Docume=
nt
> > the TSU unit
> >=20
> > On Fri, Mar 07, 2025 at 03:14:05PM +0000, John Madieu wrote:
> > > Hi Conor,
> > >
> > > Thanks for your review!
> > >
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Friday, February 28, 2025 8:03 PM
> > > > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu:
> > > > Document the TSU unit
> > > >
> > > > On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> > > > > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block
> > > > > designed to measure the junction temperature. The device provides
> > > > > real-time temperature measurements for thermal management,
> > > > > utilizing a single dedicated channel (channel 1) for temperature
> > sensing.
> > > > >
> > > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > >  * Fix reg property specifier to get rid of yamlint warnings
> > > > >  * Fix IRQ name to reflect TSU expectations
> > > > >
> > > > > +    enum: [0, 1]
> > > > > +    description: |
> > > > > +      TSU operating mode:
> > > > > +      0: Mode 0 - Conversion started by software
> > > > > +      1: Mode 1 - Conversion started by ELC trigger
> > > >
> > > > Can you make this "software" and "elc" or something please, unless
> > > > people will genuinely find "0" and 1" to be more informative.
> > > > And why doesn't the property have a default?
> > >
> > > Sorry for miss-specifying.
> > > ELC is an external event trigger. May be should I specify it like tha=
t ?
> >=20
> > If "elc trigger" is meaningful to people using hte device (IOW, it matc=
hes
> > datasheet wording) then that's fine I think.
>=20
> "elc trigger" matches datasheet wording.
>=20
> >=20
> > > To make sure I got your point, do you mean specifying a default value
> > > in bindings ?
> >=20
> > The property doesn't actually need to be required, it could easily have=
 a
> > default (say software) and only be set in the case of using the elc
> > trigger - which brings you to Rob's comment that it can just be a boole=
an,
> > setting the property if elc and leaving it out of software.
>=20
> Got the point now. I can make it default to software trigger, and add opt=
ional
> Boolean property to ELC trigger. Let's say "renesas,elc-trigger;"

Yah, that works.

>=20
> >=20
> > Rob's other comment was
> >=20
> > | Who/what decides the mode? If a user is going to want to change this,
> > | then it should be a runtime control, not a DT property.
>=20
> Changes are not possible at runtime. Some customers may want software,
> while other may want the external trigger, and this is immutable=20
> configuration.

What makes it immutable? Set by some wiring on the board? I couldn't
find the user in your driver patches to better understand how you were
using it.

--FptXTXAIhD0gPfos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sY4gAKCRB4tDGHoIJi
0ut/APj8ly7agJVBfsuReMJT8RtHUn7mZHkeTYHpMWJm/lYEAQDHM+aoQ7IZhrsm
zco87OB941IsVq/iRfFQNx78HSNvAQ==
=kAfv
-----END PGP SIGNATURE-----

--FptXTXAIhD0gPfos--


Return-Path: <linux-pm+bounces-1165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B58137F5
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C74282CBE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531665A75;
	Thu, 14 Dec 2023 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay/G2Cb2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFA4CE1C;
	Thu, 14 Dec 2023 17:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF93FC433C8;
	Thu, 14 Dec 2023 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574037;
	bh=W7tZDh7BmueubYkX0L+UqKxtIU97nLro5NvjR6o1oRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay/G2Cb2AqLr6Qan67U53MLXsGEXhoB7kGFC7Jvx0SvVHQ4+6Q5tsZyJWp+8xbTeA
	 p/KpJrJSMu8T+Kn9ywQmducL8h+m4jkmj8D5H1ZeydT1SIF1LqDT1ZmtYOMe9FBSze
	 UG9JzaNNXPyqA5MCN4EIGpCmZHXADN00ePkRzx+8eX98GrfbRSUgKJBYrqixJjEwOB
	 UQrz1nY94AT8l8HgEPofNV2TTGzy+TnnYc1njn3egTDNX+rZjMHv5kaRXKBJQvmYZX
	 nLBAWYbqWRdEM+Trx0xwXE+mlyhr5Wgj2nllCkEFbzOTDUHD2/kvYA8QbW67UDVJUr
	 yth6cA/L/ebjg==
Date: Thu, 14 Dec 2023 17:13:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
	daniel.lezcano@linaro.org, rafael@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <20231214-smoked-extending-a76e33621470@spud>
References: <20230928222130.580487-1-festevam@gmail.com>
 <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud>
 <a591318fbba10b764075e9395ddd9f7f@denx.de>
 <20231210-stimulant-halogen-e3aaca2279c5@spud>
 <20231210153749.GA4141628-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o/zLyy+00YK9JiDd"
Content-Disposition: inline
In-Reply-To: <20231210153749.GA4141628-robh@kernel.org>


--o/zLyy+00YK9JiDd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 09:37:49AM -0600, Rob Herring wrote:
> On Sun, Dec 10, 2023 at 02:52:45PM +0000, Conor Dooley wrote:
> > On Sat, Dec 09, 2023 at 05:59:17PM -0300, Fabio Estevam wrote:
> > > Hi Conor,
> > >=20
> > > On 09/12/2023 17:23, Conor Dooley wrote:
> > >=20
> > > > You're adding the constraints and items at the wrong level AFAICT.
> > > > I think something like the below better matches your constraints?
> > >=20
> > > Thanks for your example.
> > >=20
> > > With your change the fsl,imx93-tmu case works correctly:
> > > if I pass the number of fsl,tmu-range entries different than 7,
> > > dt_binding_check correctly complains.
> > >=20
> > > However, if I pass 7 entries to fsl,qoriq-tmu it should complain as it
> > > expects 4, but it
> >=20
> > btw, unrelated - minItems seems (from a grep) like it needs to be 2 not
> > 4.
> >=20
> > > does not.
> > >=20
> > > On top of your patch:
> > >=20
> > > --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > > +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > > @@ -104,7 +104,7 @@ additionalProperties: false
> > >  examples:
> > >    - |
> > >      tmu@f0000 {
> > > -        compatible =3D "fsl,imx93-tmu";
> > > +        compatible =3D "fsl,qoriq-tmu";
> > >          reg =3D <0xf0000 0x1000>;
> > >          interrupts =3D <18 2 0 0>;
> > >          fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x000100=
6a 0 0
> > > 0>;
> > >=20
> > > make dt_binding_check DT_SCHEMA_FILES=3Dqoriq-thermal.yaml
> > >   LINT    Documentation/devicetree/bindings
> > >   DTEX
> > > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dts
> > >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >   DTC_CHK
> > > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dtb
> > >=20
> > > Any suggestions?
> >=20
> > I dunno. I spent far far longer than I would like to admit trying to fix
> > this. Firstly my suggestion here is crap I think and only applies to
> > ___matrices___. I think it needs to be the way you had it in your diff,
> > but I cannot figure out why it doesn't apply the maxItems constraint.
> >=20
> > Perhaps Rob or Krzysztof can figure out what we were overlooking.
> > The diff in question was something like:
>=20
> I suspect something is going afoul in the fixups. Will look at it=20
> tomorrow.

Did you manage to figure out what was causing this btw?

--o/zLyy+00YK9JiDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXs30QAKCRB4tDGHoIJi
0ll/AQDdrA2fopqsmC+RNzzILrOgEpM2SMrlFJUh9OPn9gLYbwEApP842vBslNRT
UvBQHdUp8jIG55HwTfyI4eYjNVJ/Igw=
=8sOF
-----END PGP SIGNATURE-----

--o/zLyy+00YK9JiDd--


Return-Path: <linux-pm+bounces-11166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4042932BCD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F09FB211BD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D119DF70;
	Tue, 16 Jul 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLOS9VHu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE917C9E9;
	Tue, 16 Jul 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144934; cv=none; b=GAWKtnGWcKZ3RszuI1QXHnK+5mf3kJxrAImyU0h9CvfJa1JV++Uhqbps41vumpQgdsyj1rL2KAk2qPyzKVLjQP6j5gVeiMKJGpqNdXv0CSY4HIUvHYk9YCA+FXo15vzza2+SScSeoX5B3DplWyhANrKW6vqbEJbzmFqcLEIjTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144934; c=relaxed/simple;
	bh=yiL5E+wPu5Y3x7KMwlKXxy7AiUQK/uEVh2InvXmnZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUaiJYNu3vn+QiMa/YGIdttFGKxWdVZyFeGQlLm9zneRJ/XQP0mmzJZLHKuYJN8Njtq8HwzT6nY3JSaok9VBMHXsZCJP4eIoRkcGcdLIFUHrExTkg/IU9rZrCHsogW4RE6/rTNE++QRr0z4OjespuDzdceF9io7cLHfS4qVRQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLOS9VHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EDC116B1;
	Tue, 16 Jul 2024 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721144934;
	bh=yiL5E+wPu5Y3x7KMwlKXxy7AiUQK/uEVh2InvXmnZ/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLOS9VHucp2wLzSGwVwdHHVS7zo0Req291hcCYJDsqPQaVGdNHmPIAXGiM44ANWH/
	 q8GNQ7/1E3SFJTc90AJz5GZHz57pIB3wlpccOHNI7OAxgtARBTdfwrA8JVr9lhqGYl
	 KcG6G3c+gqQngcMuirgGtSXTn80pNeoWY6DRwmI+EtaWvoO/gsMgM4bTfVyPe+YYGj
	 uEnIYrCv8jHPAd1PZsGxSfGyPEUq2Rnc07DceLdTaVjuv0wbDdt1FHkvueqgf+/Uiv
	 kRpp7DRjl8PmEyloroTZF2QFCuIGhagQ9pSgyCSsaEkZAswG0eom6eSqNCez4CQYnH
	 IZlrpZXyrcRfw==
Date: Tue, 16 Jul 2024 16:48:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Haylen Chu <heylenay@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID: <20240716-cloning-canopy-a6799dc7f3b9@spud>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sd00rq2NvKriVqOy"
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>


--sd00rq2NvKriVqOy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 08:43:19PM +0800, Chen Wang wrote:
>=20
> On 2024/7/16 17:42, Haylen Chu wrote:
> > Add devicetree binding documentation for thermal sensors integrated in
> > Sophgo CV180X SoCs.
> >=20
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >   .../thermal/sophgo,cv1800-thermal.yaml        | 55 +++++++++++++++++++
>=20
> I see sometimes you call it cv1800, and in patch 3, the file name is
> cv180x_thermal.c, and for dts changes, you changed cv18xx.dtsi. Please un=
ify
> it.
>=20
> I think sg200x is new name for cv181x serias, so if you want to cover
> cv180x/sg200x, is cv18xx better?
>=20
> >   1 file changed, 55 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,c=
v1800-thermal.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-therma=
l.yaml
> > new file mode 100644
> > index 000000000000..58bd4432cd10
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.y=
aml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800 on-SoC Thermal Sensor
> > +
> > +maintainers:
> > +  - Haylen Chu <heylenay@outlook.com>
> > +
> > +description: Sophgo CV1800 on-SoC thermal sensor
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800-thermal
> cv18xx-thermal ?

Please, no wildcards in compatibles :/

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: The thermal sensor clock
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  sample-rate-hz:
> > +    minimum: 1
> > +    maximum: 1908
> > +    default: 1

I still don't think this belongs in the devicetree, but is actually
software policy.

Cheers,
Conor.

> > +
> > +  '#thermal-sensor-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +        #include <dt-bindings/clock/sophgo,cv1800.h>
> > +        #include <dt-bindings/interrupt-controller/irq.h>
> > +        thermal-sensor@30e0000 {
> > +            compatible =3D "sophgo,cv1800-thermal";
> > +            reg =3D <0x30e0000 0x100>;
> > +            clocks =3D <&clk CLK_TEMPSEN>;
> > +            interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
> > +            #thermal-sensor-cells =3D <0>;
> > +        };
> > +...

--sd00rq2NvKriVqOy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpaWYAAKCRB4tDGHoIJi
0mZqAP999xRpJzMXtWpyPBcbx37rhh26FZfxxiKu7D2l5nbsmgEAsTuQYEbczSgm
nYQXCbcQ4qhl/2WwYfp6srrcImU5Awc=
=2jKi
-----END PGP SIGNATURE-----

--sd00rq2NvKriVqOy--


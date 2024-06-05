Return-Path: <linux-pm+bounces-8655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E338FD465
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A5288FC4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF64194AEC;
	Wed,  5 Jun 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzecBLOc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1471139D00;
	Wed,  5 Jun 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610063; cv=none; b=NhvOC+iaXtLUoBHFQEzjKt5JwTaM+FIbLWltUzkUeNdxIzYn7g44LwKeUPuVPcJrap6fFhkFSxJwUNauZisUsh1kMfcLS3KjEm0POMuvkMcUFJI8qhSfi9qWgBeePVpaLF5LSTkDo+h6hMQQZfVJqQ/tjCuXyliqVOzJitrz76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610063; c=relaxed/simple;
	bh=A8lg5hz+MBOmGn5ya8/fL07rjZlvK77wfF8N5N6s7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw7l+VPUFnMy9cweBbFe61Z97h6x0dEbNEISpPzADJyKHLROg3eHtbQCPSi35BW3WTd0KQ+ZiXRwPUNgWT6RsgyXsbVGhKXiJe7tZR3tbR4hzE3eFlS9YRAWQpHZCs5XxA1xtH1ZMtiO1QFTowWC7dJgPYT16+HYUMz5hhvuZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzecBLOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FD8C2BD11;
	Wed,  5 Jun 2024 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610063;
	bh=A8lg5hz+MBOmGn5ya8/fL07rjZlvK77wfF8N5N6s7aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzecBLOcSILnskzdHSvhm2It8XC1bmx/lcsBrKDsKX86PvaXgBWRFa+xUD+26xIDJ
	 SFLQxn9UDgsrp4y3e0Z5nFYhTT7ekyNHbCLr0SdhIW65m2vpMRx6F0d/NPshS8EMrx
	 zqb/c+X8v94QIWOmN2HEBoNa6qS4LwJ975bk9cvo5njY6qQeBc5ZMhMgyeGXH7XZQg
	 Ef1v0hQqrcvRZllDwbxnBId9n/YCOlQBVNMy8AILyg9CSA0KxGSID5u/smQ7CTXpBY
	 clssyHfC1PN+jDBiD/uEHld7OX9xG2nBBuLqc4TYAEVS0JX179I6RUhDBubBIjDPM0
	 935ce12yzNZIA==
Date: Wed, 5 Jun 2024 18:54:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Haylen Chu <heylenay@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal
Message-ID: <20240605-tightwad-janitor-82cfceb1469d@spud>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42189977B4172405F5704CC4D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49531F55C8D7DC5D0050CAF9BBF92@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOo6vMANsZN3Leyq"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49531F55C8D7DC5D0050CAF9BBF92@IA1PR20MB4953.namprd20.prod.outlook.com>


--zOo6vMANsZN3Leyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:40:32AM +0800, Inochi Amaoto wrote:
> On Tue, Jun 04, 2024 at 12:54:19PM GMT, Haylen Chu wrote:
> > Add devicetree binding documentation for thermal sensors integrated in
> > Sophgo CV180X SoCs.
> >=20
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >  .../thermal/sophgo,cv180x-thermal.yaml        | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv=
180x-thermal.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv180x-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv180x-therma=
l.yaml
> > new file mode 100644
> > index 000000000000..1c3a6f74ff1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.y=
aml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sophgo,cv180x-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV180x on-SoC Thermal Sensor
> > +
> > +maintainers:
> > +  - Haylen Chu <heylenay@outlook.com>
> > +
> > +description: Binding for Sophgo CV180x on-SoC thermal sensor
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800-thermal
> > +      - sophgo,cv180x-thermal
> > +
>=20
> Is this necessary? I don't find any change between the sensor of these.

"cv180x" isn't even a real device. Either we have a compatible that
matches an actual SoC and use it everywhere, or we add ones for each SoC
and have a fallback to cv1800.

> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: The thermal sensor clock
> > +
> > +  clock-names:
> > +    const: clk_tempsen

clock-names is not useful here as there's only one clock.
"clk_tempsen" sounds more like the name for this clock at the provider
than at the consumer anyway.

> > +
> > +  accumulation-period:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Accumulation period for a sample
> > +    oneOf:
> > +      - const: 0
> > +        description: 512 ticks
> > +      - const: 1
> > +        description: 1024 ticks
> > +      - const: 2
> > +        description: 2048 ticks
> > +      - const: 3
> > +        description: 4096 ticks
> > +    default: 2
> > +
> > +  chop-period:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: ADC chop period

What's a "chop" and why is either this or the accumulation-period a
fixed property of the hardware? Shouldn't this choice really be up to
the user?

> > +    oneOf:
> > +      - const: 0
> > +        description: 128 ticks
> > +      - const: 1
> > +        description: 256 ticks
> > +      - const: 2
> > +        description: 512 ticks
> > +      - const: 3
> > +        description: 1024 ticks

Can we just make the number of ticks the unit here, and above?
Also, a "oneOf: - const" structure is just an enum.

> > +    default: 3
> > +
> > +  sample-cycle-us:
> > +    description: Period between samples
> > +    default: 1000000

No constraints?

Thanks,
Conor.

> > +
> > +  '#thermal-sensor-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +        #include <dt-bindings/clock/sophgo,cv1800.h>
> > +        thermal-sensor@30e0000 {
> > +            compatible =3D "sophgo,cv180x-thermal";
> > +            reg =3D <0x30e0000 0x100>;
> > +            clocks =3D <&clk CLK_TEMPSEN>;
> > +            clock-names =3D "clk_tempsen";
> > +            #thermal-sensor-cells =3D <0>;
> > +        };
> > +...
>=20
> Where is the interrupt number? The sensors does support the interrupt,
> but I don't see you describe it in the binding.
>=20
> > --=20
> > 2.45.2
> >=20

--zOo6vMANsZN3Leyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCmSQAKCRB4tDGHoIJi
0lO6AP9sW5xE2Dz5LvNJjPgXDWtF96Y9pG6mweRGMoUn50K5aQEAibhcLwbeJFd5
S4Ye7d9hhxUVcwTpWFotGEFVBPZPlAk=
=GiCK
-----END PGP SIGNATURE-----

--zOo6vMANsZN3Leyq--


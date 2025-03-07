Return-Path: <linux-pm+bounces-23638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB82A56C2A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1216AEBE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744421D01B;
	Fri,  7 Mar 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUObU9qs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035521ABD2;
	Fri,  7 Mar 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361593; cv=none; b=aeGh1FtpIG8aVRMyZ82Raef2UF3o/0Uj9LlsPcLzh1YbqWsfkOecKjFs0rwf0tFUsjoVDrDqgDWjbw1pVVJnkXub8ZacwaR1m/Mw+jdcGbljwrto4hwlHJGyIk3N1YKfyAJa/mSfbGzRAvS/qOdiVRyO7bi8nP0bo1Or2hW06rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361593; c=relaxed/simple;
	bh=T8pm9fzwyKtv3TmcyIBDRu8FWKQO9PkFtQpCXZzkH5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNmXMj2eqF+8JrjplndbcMn7uKoKCU2lU8pN5Ql96FdM/Kb3M5JJLyzqwojixPT3jqIJq9xfiW6FuA5VK5AeLQvTp3MMgXBJYNpyELLLs8phaZ/U4+FPvAghW/82zm60+ZbaE00H3K/A8Ed1Cjk3OTOMCe/nASsN/29cUdXRk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUObU9qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD04C4CED1;
	Fri,  7 Mar 2025 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361592;
	bh=T8pm9fzwyKtv3TmcyIBDRu8FWKQO9PkFtQpCXZzkH5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUObU9qsjd1SooeVdUfrrJl9fVYTuXf+V439lXM1M7u0b5lKvuIMBf/hNgn3h1cZ4
	 wtohVxDmaoJOxnGSx3co3YI7J3bR9OmrleAurHNVvvFApz7SPumbRu06wbccHRPw9C
	 kWAoR5ZN3YcxKvCx416ezcBICJGp8I4SCzzt0WfedBtFKqX5fkqF4wRGVRNabQm0qg
	 DT5qoI699jnzTOO0ne+jj0Z/ZGrQY2S1jojvv40kjy13z0jY1zYwvdBIn4CD5mLC60
	 uesnhPB79pTv8GIMKAiCvAfh5HFBcnskvV9dxt6EUO/v5uje+7FJpHp1AxJWR16Koa
	 g/znbMB1M8rng==
Date: Fri, 7 Mar 2025 15:33:05 +0000
From: Conor Dooley <conor@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
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
Message-ID: <20250307-everyone-ragweed-e05a10a9646b@spud>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWY9G/uo86esg184"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>


--aWY9G/uo86esg184
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 03:14:05PM +0000, John Madieu wrote:
> Hi Conor,
>=20
> Thanks for your review!
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Friday, February 28, 2025 8:03 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Docume=
nt
> > the TSU unit
> >=20
> > On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> > > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block
> > > designed to measure the junction temperature. The device provides
> > > real-time temperature measurements for thermal management, utilizing a
> > > single dedicated channel (channel 1) for temperature sensing.
> > >
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > ---
> > > v1 -> v2:
> > >  * Fix reg property specifier to get rid of yamlint warnings
> > >  * Fix IRQ name to reflect TSU expectations
> > >
> > >  .../thermal/renesas,r9a09g047-tsu.yaml        | 123 ++++++++++++++++=
++
> > >  1 file changed, 123 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > > b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > > new file mode 100644
> > > index 000000000000..e786561ddbe3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.
> > > +++ yaml
> > > @@ -0,0 +1,123 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +http://devicetree.org/schemas/thermal/renesas,r9a09g047-tsu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas RZ/G3E Temperature Sensor Unit (TSU)
> > > +
> > > +maintainers:
> > > +  - John Madieu <john.madieu.xa@bp.renesas.com>
> > > +
> > > +description:
> > > +  The Temperature Sensor Unit (TSU) is an integrated thermal sensor
> > > +that
> > > +  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU
> > > +provides
> > > +  real-time temperature measurements for thermal management.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: renesas,r9a09g047-tsu
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description: |
> > > +      Interrupt specifiers for the TSU:
> > > +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> > > +      - S12TSUADCMPI1: Comparison result interrupt signal (level)
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: adi
> > > +      - const: adcmpi
> > > +
> > > +  "#thermal-sensor-cells":
> > > +    const: 0
> > > +
> > > +  renesas,tsu-calibration-sys:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: |
> > > +      Phandle to the system controller (sys) that contains the TSU
> > > +      calibration values used for temperature calculations.
> > > +
> > > +  renesas,tsu-operating-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +    description: |
> > > +      TSU operating mode:
> > > +      0: Mode 0 - Conversion started by software
> > > +      1: Mode 1 - Conversion started by ELC trigger
> >=20
> > Can you make this "software" and "elc" or something please, unless peop=
le
> > will genuinely find "0" and 1" to be more informative.
> > And why doesn't the property have a default?
>=20
> Sorry for miss-specifying.
> ELC is an external event trigger. May be should I specify it like that ?

If "elc trigger" is meaningful to people using hte device (IOW, it
matches datasheet wording) then that's fine I think.

> To make sure I got your point, do you mean specifying a default value in
> bindings ?

The property doesn't actually need to be required, it could easily have
a default (say software) and only be set in the case of using the elc
trigger - which brings you to Rob's comment that it can just be a
boolean, setting the property if elc and leaving it out of software.

Rob's other comment was

| Who/what decides the mode? If a user is going to want to change this,=20
| then it should be a runtime control, not a DT property.

which I think needs an answer ;)

--aWY9G/uo86esg184
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sRsQAKCRB4tDGHoIJi
0ioIAP0R4s3zFK5NRjcsBtyJZDB/M7Q2SCqtsT6CE2fAYWOOsgD/UCmd1Aqqudy+
R+Wg5p4BqNSch5uuEQ1JlX9CAR0TwgM=
=rZ5t
-----END PGP SIGNATURE-----

--aWY9G/uo86esg184--


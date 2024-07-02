Return-Path: <linux-pm+bounces-10355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6D9241BA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89261B24680
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C81BB684;
	Tue,  2 Jul 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIh4HYNR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E61BA080;
	Tue,  2 Jul 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932447; cv=none; b=qqM99SoLu/utYNa86pz8WIRgefNDtKhd+hQBEVzqKB2Cux1H69qHM108hii3VfQPz9bZyDpcQwjiulNVA++xsrxhKqVnt8rrVlvTH+sR9fyn1Wkp9TRHWM4rw3dX/vVdv7lFw2VFe5SpmSO9epV13WXaGbBzagwPqUZEy37XZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932447; c=relaxed/simple;
	bh=HAu5MXagusH8Y8IO8gLkVN9AN4GtavJDI9q++gRfbt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObW0D15gkrViB9knw/N0A7/wZw4a+dywVY2yLe1aLsGeGq1JS0pZ/Xr0Dy+7wWUrvzuwGnkdpeJy9ozXKvotweQzZBxko/MYOz0X7rfHA6W2SLbekXuC1HRAAJVexKakylB2vMe02RsYIkTRs2e8SAkFk3eZbl2cBKF8b2CQFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIh4HYNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42BCC2BD10;
	Tue,  2 Jul 2024 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932447;
	bh=HAu5MXagusH8Y8IO8gLkVN9AN4GtavJDI9q++gRfbt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIh4HYNRke/G3/IhSdtY+p9k6djkA5WRhd4A/8lWN7WdJviYJ/8AHiNQmPKyOp2/Z
	 828nx8bmngWCeIyy26cq5e4t8t7KFiZefldBLDhl2m0xC4glpbJCl5j+DaZtjoLGy8
	 2WSkzNRGz2z/Y3VAoaMXTuenYUqLOIFovdF5cUgA2s/Z2ejNXTQH/Ju2XNLK6WNfrF
	 RGgmtfLy0U7LF9V4ImaFlSOrvPNOk/5p1TJvD8ANGV7aTjdMO3MM2MdcYnE4DMm7lB
	 thioDrLH+PourfWA4Gmzz4b0UBXEDqB/NHtaFi11pbcupF2Q+mbu3AALOCRbrK7zdM
	 qH0luSwjxEx/Q==
Date: Tue, 2 Jul 2024 16:00:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID: <20240702-aptitude-overripe-8ac9aa3c6b90@spud>
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cj+2FTDLsk6UdrLf"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>


--Cj+2FTDLsk6UdrLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rob/Krzysztof, Haylen,

On Tue, Jul 02, 2024 at 09:30:24AM +0000, Haylen Chu wrote:
> Add devicetree binding documentation for thermal sensors integrated in
> Sophgo CV180X SoCs.
>=20
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  .../thermal/sophgo,cv1800-thermal.yaml        | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv18=
00-thermal.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.=
yaml
> new file mode 100644
> index 000000000000..016299822c16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 on-SoC Thermal Sensor
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +description: Binding for Sophgo CV1800 on-SoC thermal sensor
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: The thermal sensor clock
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  accumulation-period:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Accumulation period for a sample
> +    enum:
> +      - 512
> +      - 1024
> +      - 2048
> +      - 4096
> +    default: 2048
> +
> +  chop-period:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: ADC chop period
> +    enum:
> +      - 128
> +      - 256
> +      - 512
> +      - 1024
> +    default: 1024
> +
> +  sample-cycle-us:

the more common term btw would be "sample-rate" rather than
"sample-cycle".

> +    description: Period between samples. Should be greater than 524us.

The constraint here should be "minimum: 524". What's the upper limit?

> +    default: 1000000

Rob/Krzysztof, could you comment on the suitability of the three custom
properties here? I know if this was an IIO device, these kinds of things
would be controllable from userspace, and not in the binding. I
mentioned this on the previous version, but I'm not really sure if
thermal devices are somehow different:
https://lore.kernel.org/all/SEYPR01MB4221A739D0645EF0255336EBD7CE2@SEYPR01M=
B4221.apcprd01.prod.exchangelabs.com/

Cheers,
Conor.

> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/clock/sophgo,cv1800.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        thermal-sensor@30e0000 {
> +            compatible =3D "sophgo,cv1800-thermal";
> +            reg =3D <0x30e0000 0x100>;
> +            clocks =3D <&clk CLK_TEMPSEN>;
> +            interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
> +            #thermal-sensor-cells =3D <0>;
> +        };
> +...
> --=20
> 2.45.2
>=20

--Cj+2FTDLsk6UdrLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQWGQAKCRB4tDGHoIJi
0uEgAP47Q2cX9PmFKJkFJalVe/Rw7yugRnC+FfIH24aHmHktbgEA+/MGeF1RqXj6
om07QLglXEVagK/oyR9xgJNcjokVnwA=
=zVtS
-----END PGP SIGNATURE-----

--Cj+2FTDLsk6UdrLf--


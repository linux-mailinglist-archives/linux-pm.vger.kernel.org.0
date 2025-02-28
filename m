Return-Path: <linux-pm+bounces-23192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16AA4A25A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72AF1658B5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704F1F4CAA;
	Fri, 28 Feb 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tShjH7cE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E281C54B3;
	Fri, 28 Feb 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769392; cv=none; b=Aj/mPk1CI6+mbckbWLm9EQrb/FjcqiEXYMJofVQ0d/ofdWk7CwEe+ObdGKxxXSE7NEzw1eq5kwl4FVYCWfVzied9ZsdO+qdF58Q9Ok76kqAATFHb/HpYtxd+UiSfU1vUq8LcEGzLjVyhuQwCPqQlljic7ydQ3sdb4sl6ThBY9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769392; c=relaxed/simple;
	bh=fkRwxASTRhK3CZzhXw1baxiK+9kAKBEvfZLUN9AOx1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcS///4MUYSuTVC2XbmQe21jUMpWlN7KEdClLScA1DG9pUFsmFN8Z3+t+2qC2q8wJ7YeeLzk9QzfFddshO0NBzFr12H0ZiP4SkP/Mb43mgxuuhX3K2xH9qGPjg5JfQzZ1y15dlwh1K0ECVX9XTPKEpnUvBSWejR94sMWVA3+Ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tShjH7cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D352C4CED6;
	Fri, 28 Feb 2025 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769391;
	bh=fkRwxASTRhK3CZzhXw1baxiK+9kAKBEvfZLUN9AOx1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tShjH7cEZHyiforgx0ocxgRzr86xXl8LxTLd6sLN4nfpWq2Nvk7kwuu7XSYtuwmmR
	 GeBc4FWAIBs0eaFqOaV8sTR2CN+kOWmNf/AysWKF9bpyDfCYZvHf3RJidF2HlGf3wF
	 Uxi4jVVVQi5fLy1P7P1GhxnLqaa/qeKJIs+dxrgZH36OQRpx/lsVU7q+2K3bgAEW9p
	 s9fVkyUMncr/8YM9Sp4iLbibXI/KQWuuIvAfUImUX4bMiOtecTG5EUPaBUS7xQsbXS
	 /gSteDdJkRGdCwfov7gGInz+mEtxVFjgb0vYgo2/viJLpskpqVGhsMKP4s3N99++ag
	 iWRSGtqrNHeNw==
Date: Fri, 28 Feb 2025 19:03:05 +0000
From: Conor Dooley <conor@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
	sboyd@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250228-shampoo-uprising-44ae0d3bd68b@spud>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VeciV8RQYG2Ieked"
Content-Disposition: inline
In-Reply-To: <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>


--VeciV8RQYG2Ieked
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time temper=
ature
> measurements for thermal management, utilizing a single dedicated channel
> (channel 1) for temperature sensing.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> v1 -> v2:
>  * Fix reg property specifier to get rid of yamlint warnings
>  * Fix IRQ name to reflect TSU expectations
>=20
>  .../thermal/renesas,r9a09g047-tsu.yaml        | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a=
09g047-tsu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-=
tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.=
yaml
> new file mode 100644
> index 000000000000..e786561ddbe3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/renesas,r9a09g047-tsu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G3E Temperature Sensor Unit (TSU)
> +
> +maintainers:
> +  - John Madieu <john.madieu.xa@bp.renesas.com>
> +
> +description:
> +  The Temperature Sensor Unit (TSU) is an integrated thermal sensor that
> +  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU provi=
des
> +  real-time temperature measurements for thermal management.
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a09g047-tsu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Interrupt specifiers for the TSU:
> +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> +      - S12TSUADCMPI1: Comparison result interrupt signal (level)
> +
> +  interrupt-names:
> +    items:
> +      - const: adi
> +      - const: adcmpi
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +  renesas,tsu-calibration-sys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the system controller (sys) that contains the TSU
> +      calibration values used for temperature calculations.
> +
> +  renesas,tsu-operating-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      TSU operating mode:
> +      0: Mode 0 - Conversion started by software
> +      1: Mode 1 - Conversion started by ELC trigger

Can you make this "software" and "elc" or something please, unless
people will genuinely find "0" and 1" to be more informative.
And why doesn't the property have a default?

cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - power-domains
> +  - interrupts
> +  - interrupt-names
> +  - "#thermal-sensor-cells"
> +  - renesas,tsu-operating-mode
> +  - renesas,tsu-calibration-sys
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    tsu: thermal@14002000 {
> +        compatible =3D "renesas,r9a09g047-tsu";
> +        reg =3D <0x14002000 0x1000>;
> +        clocks =3D <&cpg CPG_MOD 0x10a>;
> +        resets =3D <&cpg 0xf8>;
> +        power-domains =3D <&cpg>;
> +        interrupts =3D <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "adi", "adcmpi";
> +        #thermal-sensor-cells =3D <0>;
> +        renesas,tsu-operating-mode =3D <0>;
> +        renesas,tsu-calibration-sys =3D <&sys>;
> +    };
> +
> +    thermal-zones {
> +        cpu-thermal {
> +            polling-delay =3D <1000>;
> +            polling-delay-passive =3D <250>;
> +            thermal-sensors =3D <&tsu>;
> +
> +            cooling-maps {
> +                map0 {
> +                    trip =3D <&target>;
> +                    cooling-device =3D <&cpu0 0 3>, <&cpu1 0 3>,
> +                                     <&cpu2 0 3>, <&cpu3 0 3>;
> +                    contribution =3D <1024>;
> +                };
> +            };
> +
> +            trips {
> +                target: trip-point {
> +                    temperature =3D <95000>;
> +                    hysteresis =3D <1000>;
> +                    type =3D "passive";
> +                };
> +
> +                sensor_crit: sensor-crit {
> +                    temperature =3D <120000>;
> +                    hysteresis =3D <1000>;
> +                    type =3D "critical";
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.25.1
>=20

--VeciV8RQYG2Ieked
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IIaQAKCRB4tDGHoIJi
0h6yAP9mVpIjUx0jaOqOxtaUXN4UN78pR3bAJQoVq1PhhnX9VAD+ILPM3T/hP0Dc
+ShPfuSw2qswD5Gh7yHGz+0ikOGf9w0=
=yvBh
-----END PGP SIGNATURE-----

--VeciV8RQYG2Ieked--


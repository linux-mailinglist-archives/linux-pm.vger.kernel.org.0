Return-Path: <linux-pm+bounces-32754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C46B2E935
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C3A24101
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD01F936;
	Thu, 21 Aug 2025 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZj5otK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376617993;
	Thu, 21 Aug 2025 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734714; cv=none; b=AkIwmF2oDr+6AM4gM1bXY33+nzBRPoHAWBW+8JpvF1t+ZdVhAWerpM7nW8Wak4B9LB3RmbvjGF5or+OcRXgzmiBi5l2HP/bCUpqzBrQpb7ont7PDto/BNkUbitLG3mHMQTbjieJFe+0JmRsB+bv2naooOdtCMtzfCFQbY1ijHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734714; c=relaxed/simple;
	bh=kY59dBGs2b/EU/KUmv+t2CeakTULFTJdXbGvcFE56w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMIAsNeEZNNRPZZge22lH2wF6slVjijAjZEte7wGzatwbn7Tlej4CGZFx8gduzXrhdoyWqZqAH+BfXixDvUE08s4hnoPWOkNFyUaqAx8IwLmj9pZ3MNZB3rJoBrBVzsDSS+Y6+qWp2N//jA68stEBT7SAQHGCviK4tO92DnZzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZj5otK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAADC4CEE7;
	Thu, 21 Aug 2025 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734713;
	bh=kY59dBGs2b/EU/KUmv+t2CeakTULFTJdXbGvcFE56w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnZj5otKrJ1oWJNP2HqcplhNg3fAJgUN6Xf5vVWSCewVBUlryPq/qvhU0os4PPYF1
	 xaTLOuQ7sGjYliC+9MxZwygs2bZvWrAhDUsYhOfbbsaOvODYfWsl5WXNhZV4bnKK1D
	 VOiFhhgefyJzkBJciEj9hstQcso2ldHodQVuFG+iVMzk41bo4Nxzh6hna/ktAUbFf8
	 A8AtuTYoYKYjuLC8Q2OdlGS//MoSyUhCflhQg5Q6264gUprlqbndV6Szhg6nbh+UxD
	 0Yyh5qEFFUvxd3M6l7WDmYQCnV0it9qTjr1rtwlNod1Bi/nF6VI6p/mEmGWz+pBOjb
	 O3Oy2chgxezXw==
Date: Wed, 20 Aug 2025 19:05:12 -0500
From: Rob Herring <robh@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
	sboyd@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	biju.das.jz@bp.renesas.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/6] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250821000512.GA1748772-robh@kernel.org>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
 <20250818162859.9661-3-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818162859.9661-3-john.madieu.xa@bp.renesas.com>

On Mon, Aug 18, 2025 at 06:28:48PM +0200, John Madieu wrote:
> The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing a single
> dedicated channel (channel 1) for temperature sensing.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v1 -> v2:
>  * Fixes reg property specifier to get rid of yamlint warnings
>  * Fixes IRQ name to reflect TSU expectations
> 
> v2 -> v3:
>  * Removees useless 'renesas,tsu-operating-mode' property 
> 
> v3 -> v4:
>  * Fixes commit message
>  * Fixes interrupt description
>  * Removes trip point definition
> 
> v5: no changes
> v6: no changes
> v7: Adds documentation for 'renesas,tsu-trim' and removes Rb tag from Krzysztof
>     due to this change
> 
>  .../thermal/renesas,r9a09g047-tsu.yaml        | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> new file mode 100644
> index 000000000000..70d2af6fcd78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> @@ -0,0 +1,87 @@
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
> +  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU provides
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
> +    items:
> +      - description: Conversion complete interrupt signal (pulse)
> +      - description: Comparison result interrupt signal (level)
> +
> +  interrupt-names:
> +    items:
> +      - const: adi
> +      - const: adcmpi
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +  renesas,tsu-trim:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to system controller
> +          - description: offset of trim registers
> +    description: |

Don't need '|' and wrap at 80 char.

> +      Phandle and offset to the system controller containing the TSU
> +      calibration trim values. The offset points to the first trim
> +      register (OTPTSU1TRMVAL0), with the second trim register
> +      (OTPTSU1TRMVAL1) located at offset + 4.
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
> +  - renesas,tsu-trim
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    tsu: thermal@14002000 {

Drop unused labels.

The prefered node name is 'thermal-sensor'.

With those,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


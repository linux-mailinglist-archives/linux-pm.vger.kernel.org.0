Return-Path: <linux-pm+bounces-24139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0EA6476A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD733A1D0E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B066221F18;
	Mon, 17 Mar 2025 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb7LNp3m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC601221D8B;
	Mon, 17 Mar 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203725; cv=none; b=BR/xzixOSQ5FJemrUNC2uGdVKtgVZFO4CNzjGkKVIbllDHie9w2OGbPgcP3L+ibZ4GDi0bIYkX/YC0+e2/xlQK62z6nzKhBPfQ+oBvDBxZ3RhRnZ/tZMD5Hxec1M2oGCpmNH4hRcyTO9hQEUVh8e4A6/o3wq1drOyNzrx6Ip4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203725; c=relaxed/simple;
	bh=VrQP9zv6me9y/ttzDtGZKAyPHxugPahSMAz9MlLhgD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1hI8N86q0k1H+F00wNp1z7vgd2TTEr6JJAqxjiTndd/0WOEk/noakiW7J027N+/w81VZI4iHl1jNPhyYaux4AqwT37unvxRXyDIy8qWetCVhZoillSjWCx+JVxVHVRvzkVdI57x7XwRS/xID+DRoQk+jyCfCx5ZYKD8Or3YeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb7LNp3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76896C4CEE3;
	Mon, 17 Mar 2025 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742203724;
	bh=VrQP9zv6me9y/ttzDtGZKAyPHxugPahSMAz9MlLhgD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xb7LNp3mg2qW45yC1vAuxlQBRlu8+pLU4uozZMk7dGKtioy+V0XdwhnMKTcRYUkpx
	 NZMdIN208ZPFLSebQbCHAeDgdeJVERGOQtezEBT4/SK5Go5najpMV8408VH+KamDXD
	 FoAs+47VOcJ+Axskkv35IgBxN4aoxGTm/mytrLS82cQ7r8fVSg8J8Y/xH3K2BxF0Xw
	 URzYQCSGteh7QT7P+gdKNlcpGH6X+mvmx4QNdQPa5oKH7t9t3eHlZIjXtGjW3J2XwN
	 hpUJoR5MqepIHT7Q2ns0mC3hToXqinCTJASatIWYsq+T9VWKm93C+pxmTJ9WLrslJt
	 3D4EiSY2hyv0A==
Date: Mon, 17 Mar 2025 10:28:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	magnus.damm@gmail.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	sboyd@kernel.org, biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com
Subject: Re: [PATCH v3 2/6] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250317-ubiquitous-acrid-gorilla-71d726@krzk-bin>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-3-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250315081225.92118-3-john.madieu.xa@bp.renesas.com>

On Sat, Mar 15, 2025 at 09:12:12AM +0100, John Madieu wrote:
> The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time temperature
> measurements for thermal management, utilizing a single dedicated channel
> (channel 1) for temperature sensing.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.

> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> v1 -> v2:
>  * Fix reg property specifier to get rid of yamlint warnings
>  * Fix IRQ name to reflect TSU expectations

... 

> +  interrupts:
> +    description: |
> +      Interrupt specifiers for the TSU:
> +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> +      - S12TSUADCMPI1: Comparison result interrupt signal (level)

Same problems as before - you need to list and describe items to have
constraints. Otherwise why 5 interrupts are allowed but only two
interrupt-names (test this)?

There is no syntax like above in any other bindings. If you found such,
please share the filename so we can fix it.

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
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - power-domains
> +  - interrupts
> +  - interrupt-names
> +  - "#thermal-sensor-cells"
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
> +        compatible = "renesas,r9a09g047-tsu";
> +        reg = <0x14002000 0x1000>;
> +        clocks = <&cpg CPG_MOD 0x10a>;
> +        resets = <&cpg 0xf8>;
> +        power-domains = <&cpg>;
> +        interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "adi", "adcmpi";
> +        #thermal-sensor-cells = <0>;
> +        renesas,tsu-calibration-sys = <&sys>;
> +    };
> +
> +    thermal-zones {

Drop the node, no need to show how to use provider binding.

Best regards,
Krzysztof



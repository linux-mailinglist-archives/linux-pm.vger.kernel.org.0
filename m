Return-Path: <linux-pm+bounces-5154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B588140A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452EAB22D20
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B54AEE9;
	Wed, 20 Mar 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQEvxGcS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA504AEC4;
	Wed, 20 Mar 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946950; cv=none; b=YmXGlkBMBMmxIpFyeIw1DgVjZrGblYSaBxn2vemsrEnJf5SQvukcncQpNFjk/VENGqBjEBPo3MrwFhy/4LNI/Yqs8Vx2K3WUB93Qn5MKL5nutyTRPdUuT+4q8zjm8AdxILQj9dI5M5qAhApF8QOLQhGOf7y5GT8HAASAcxogoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946950; c=relaxed/simple;
	bh=xFMb9nTzM5f7GHI9kIML1UaEuYeBpsEmr2AAulx6QTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcsMY2orP9N0d8pQotpvZR6aSYlr3xt/mLlpyvNSA8OBhCAwPDVSFv/Mc9HYt65TqRtzq/jwIJvIz3+vGWKbFkAwGhfse7P+scMNrioEFSjsvjuaBrBZJZFhPUWOEMd8LetUFFd/DBqB5D7GWGL56Vc2u9MGrkDn9UnvCDz1nLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQEvxGcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2940CC433F1;
	Wed, 20 Mar 2024 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946950;
	bh=xFMb9nTzM5f7GHI9kIML1UaEuYeBpsEmr2AAulx6QTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQEvxGcSs71CdTPbnVAjTm90KV5AD1t/DyVeasJUsZuRHpe4gewe2PNT7tkVc0Uig
	 4605Y6tjyjoIEv4ZgdkLLqC7jmSpII+mguL6LmhIeNiXCPH0ZeIgHFY+7S/HKC7sf7
	 tdIFQqdEU7uYtbe0zWirbZJxM7HR5erX2vgPWd9nAmnStC59uDcCKzRt+yQIj4pwDX
	 D9v/VIFTXy20KzFYyzAntlkggsngEMkiEy3wb0rFJmdFywpsZK5W+XNZ0VKXkzTAOL
	 RYHJDbf+Cx/ckZynxCOXYADcdWh4IBzzy9ojMhLFX17XUBkyN1gTsogzONWGTPef/O
	 g0yV6A20oql7w==
Date: Wed, 20 Mar 2024 10:02:28 -0500
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: opp: Describe H616 OPPs and
 opp-supported-hw
Message-ID: <20240320150228.GA1705913-robh@kernel.org>
References: <20240318011228.2626-1-andre.przywara@arm.com>
 <20240318011228.2626-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318011228.2626-4-andre.przywara@arm.com>

On Mon, Mar 18, 2024 at 01:12:23AM +0000, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> The Allwinner H616 uses a similar NVMEM based mechanism to determine the
> silicon revision, which is required to select the right frequency /
> voltage pair for the OPPs.
> However it limits the maximum frequency for some speedbins, which
> requires to introduce the opp-supported-hw property.
> 
> Add this property to the list of allowed properties, also drop the
> requirement for the revision specific opp-microvolt properties, since
> they won't be needed if using opp-supported-hw. When using this
> property, we also might have multiple OPP nodes per frequency, so relax
> the OPP node naming to allow a single letter suffix.
> 
> Also use to opportunity to adjust some wording, and drop a sentence
> referring to the Linux driver and the OPP subsystem.
> 
> Shorten the existing example and add another example, showcasing the
> opp-supported-hw property.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../allwinner,sun50i-h6-operating-points.yaml | 89 ++++++++++---------
>  1 file changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> index 51f62c3ae1947..d5439a3f696bc 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> @@ -13,25 +13,25 @@ maintainers:
>  description: |
>    For some SoCs, the CPU frequency subset and voltage value of each
>    OPP varies based on the silicon variant in use. Allwinner Process
> -  Voltage Scaling Tables defines the voltage and frequency value based
> -  on the speedbin blown in the efuse combination. The
> -  sun50i-cpufreq-nvmem driver reads the efuse value from the SoC to
> -  provide the OPP framework with required information.
> +  Voltage Scaling Tables define the voltage and frequency values based
> +  on the speedbin blown in the efuse combination.
>  
>  allOf:
>    - $ref: opp-v2-base.yaml#
>  
>  properties:
>    compatible:
> -    const: allwinner,sun50i-h6-operating-points
> +    enum:
> +      - allwinner,sun50i-h6-operating-points
> +      - allwinner,sun50i-h616-operating-points
>  
>    nvmem-cells:
>      description: |
>        A phandle pointing to a nvmem-cells node representing the efuse
> -      registers that has information about the speedbin that is used
> +      register that has information about the speedbin that is used
>        to select the right frequency/voltage value pair. Please refer
> -      the for nvmem-cells bindings
> -      Documentation/devicetree/bindings/nvmem/nvmem.txt and also
> +      to the nvmem-cells bindings in
> +      Documentation/devicetree/bindings/nvmem/nvmem.yaml and also the
>        examples below.
>  
>    opp-shared: true
> @@ -41,21 +41,23 @@ required:
>    - nvmem-cells
>  
>  patternProperties:
> -  "^opp-[0-9]+$":
> +  "^opp-[0-9]+(-[a-z])?$":
>      type: object
>  
>      properties:
>        opp-hz: true
>        clock-latency-ns: true
> +      opp-microvolt: true
> +      opp-supported-hw:
> +        description: |
> +          A single 32 bit bitmap value, representing compatible HW, one
> +          bit per speed bin index.
>  
>      patternProperties:
>        "^opp-microvolt-speed[0-9]$": true
>  
>      required:
>        - opp-hz
> -      - opp-microvolt-speed0
> -      - opp-microvolt-speed1
> -      - opp-microvolt-speed2
>  
>      unevaluatedProperties: false
>  
> @@ -77,58 +79,61 @@ examples:
>              opp-microvolt-speed2 = <800000>;
>          };
>  
> -        opp-720000000 {
> +        opp-1080000000 {
>              clock-latency-ns = <244144>; /* 8 32k periods */
> -            opp-hz = /bits/ 64 <720000000>;
> +            opp-hz = /bits/ 64 <1080000000>;
>  
> -            opp-microvolt-speed0 = <880000>;
> -            opp-microvolt-speed1 = <820000>;
> -            opp-microvolt-speed2 = <800000>;
> +            opp-microvolt-speed0 = <1060000>;
> +            opp-microvolt-speed1 = <880000>;
> +            opp-microvolt-speed2 = <840000>;
>          };
>  
> -        opp-816000000 {
> +        opp-1488000000 {
>              clock-latency-ns = <244144>; /* 8 32k periods */
> -            opp-hz = /bits/ 64 <816000000>;
> +            opp-hz = /bits/ 64 <1488000000>;
>  
> -            opp-microvolt-speed0 = <880000>;
> -            opp-microvolt-speed1 = <820000>;
> -            opp-microvolt-speed2 = <800000>;
> +            opp-microvolt-speed0 = <1160000>;
> +            opp-microvolt-speed1 = <1000000>;
> +            opp-microvolt-speed2 = <960000>;
>          };
> +    };
> +
> +  - |
> +    opp-table {
> +        compatible = "allwinner,sun50i-h616-operating-points";
> +        nvmem-cells = <&speedbin_efuse>;
> +        opp-shared;
>  
> -        opp-888000000 {
> +        opp-480000000 {
>              clock-latency-ns = <244144>; /* 8 32k periods */
> -            opp-hz = /bits/ 64 <888000000>;
> +            opp-hz = /bits/ 64 <480000000>;
>  
> -            opp-microvolt-speed0 = <940000>;
> -            opp-microvolt-speed1 = <820000>;
> -            opp-microvolt-speed2 = <800000>;
> +            opp-microvolt = <900000>;
> +            opp-supported-hw = <0x1f>;
>          };
>  
> -        opp-1080000000 {
> +        opp-792000000-l {
>              clock-latency-ns = <244144>; /* 8 32k periods */
> -            opp-hz = /bits/ 64 <1080000000>;
> +            opp-hz = /bits/ 64 <792000000>;
>  
> -            opp-microvolt-speed0 = <1060000>;
> -            opp-microvolt-speed1 = <880000>;
> -            opp-microvolt-speed2 = <840000>;
> +            opp-microvolt = <900000>;
> +            opp-supported-hw = <0x02>;
>          };
>  
> -        opp-1320000000 {
> +        opp-792000000-h {
>              clock-latency-ns = <244144>; /* 8 32k periods */
> -            opp-hz = /bits/ 64 <1320000000>;
> +            opp-hz = /bits/ 64 <792000000>;
>  
> -            opp-microvolt-speed0 = <1160000>;
> -            opp-microvolt-speed1 = <940000>;
> -            opp-microvolt-speed2 = <900000>;
> +            opp-microvolt = <940000>;
> +            opp-supported-hw = <0x10>;

So far, we've avoided multiple entries for a single frequency. I think 
it would be good to maintain that.

Couldn't you just do:

opp-supported-hw = <0>, <0x10>, <0x02>;

Where the index corresponds to speed0, speed1, speed2.

If not, then I don't understand how multiple entries of opp-supported-hw 
are supposed to work.

Rob


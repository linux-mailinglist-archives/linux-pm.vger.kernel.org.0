Return-Path: <linux-pm+bounces-18482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898949E2437
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DC2287864
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A81F8ADF;
	Tue,  3 Dec 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upjQkMmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBB1DDC24;
	Tue,  3 Dec 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240736; cv=none; b=u9Mm5HqExkDGwdRh2u00aFyuCWjaUOr4daFNF1uLtPI9A/7IccuDVrWxNBU3T61yWIS7nwGCrjwG37831quNDfyysrr+Gn6WcaA5qi7lC/IKElJej0WhFbn5nWsIzi9W+zdgNJuVoDOFH+oX0AbkQ5DvPTYrMhhLRr9/wY7VArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240736; c=relaxed/simple;
	bh=gJLaMBCWG0wnreX4DAS74R8/G1cJslP9O/B4BmtUUGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xvya7OfdIZlSoVfxtiXPu0I0IbEB1/ZzfxXp5mbthAf5HfIpttshol67aNvC7IxcGMjogs8bGoEO74khW672MYN8GuG6RB3V+Gqti5ZYgbno1meyUmDXedAn6vwGncltT2OuVcDkO0pmizU8PUCX08Q4OoXdZvgECnIvFlv1WaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upjQkMmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2824C4CECF;
	Tue,  3 Dec 2024 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733240736;
	bh=gJLaMBCWG0wnreX4DAS74R8/G1cJslP9O/B4BmtUUGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=upjQkMmJOOx4J0Wfa3JbNSb8KeypVj2zz+5Qx+rDSXZIXF/sBKk+Qagsq1vHaFOoN
	 0mw3v+/15/29ZpS/6HtennTCV7fGYa73XxjZtvyi1r4GqAT+OrIZZlSPLbEpOC2JEe
	 xkyPpURpiIfGPs+V48X6KZ/f0R5o8tJoAGUk16mm9pb1Q/Iyjrlf4QRmiyPh5AMEz0
	 kC0krFwX38YCJTIEnx3RomSlX2Dm2N/MS20QoXkCvNmeTCo3VYZ4urJP3+IXfYmQ4g
	 lkUE2qx6OL/ZT9hdzIV9+pCtYU7HrCPkGNYFu+8vAjFCD8GBN599rB+0KHz/OwbYNM
	 z2xnLR7AfJx6g==
Message-ID: <f21ffd12-167b-4d10-9017-33041ec322b0@kernel.org>
Date: Tue, 3 Dec 2024 16:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/14] dt-bindings: clock: thead,th1520: Add
 support for Video Output subsystem
To: Michal Wilczynski <m.wilczynski@samsung.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
 jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
 <CGME20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7@eucas1p1.samsung.com>
 <20241203134137.2114847-6-m.wilczynski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241203134137.2114847-6-m.wilczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2024 14:41, Michal Wilczynski wrote:
> The device tree bindings for the T-Head TH1520 SoC clocks currently
> support only the Application Processor (AP) subsystem. This commit
> extends the bindings to include the Video Output (VO) subsystem clocks.
> 
> Update the YAML schema to define the VO subsystem clocks, allowing the
> clock driver to configure and manage these clocks appropriately. This
> addition is necessary to enable the proper operation of the video output
> features on the TH1520 SoC.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/clock/thead,th1520-clk-ap.yaml   | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> index 4a0806af2bf9..5a8f1041f766 100644
> --- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> +++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> @@ -4,11 +4,13 @@
>  $id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: T-HEAD TH1520 AP sub-system clock controller
> +title: T-HEAD TH1520 sub-systems clock controller
>  
>  description: |
> -  The T-HEAD TH1520 AP sub-system clock controller configures the
> -  CPU, DPU, GMAC and TEE PLLs.
> +  The T-HEAD TH1520 sub-systems clock controller configures the
> +  CPU, DPU, GMAC and TEE PLLs for the AP subsystem. For the VO
> +  subsystem clock gates can be configured for the HDMI, MIPI and
> +  the GPU.
>  
>    SoC reference manual
>    https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> @@ -20,7 +22,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: thead,th1520-clk-ap
> +    enum:
> +      - thead,th1520-clk-ap
> +      - thead,th1520-clk-vo
>  
>    reg:
>      maxItems: 1
> @@ -29,6 +33,17 @@ properties:
>      items:
>        - description: main oscillator (24MHz)
>  
> +  thead,vosys-regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to a syscon node representing the shared register
> +      space of the VO (Video Output) subsystem. This register space
> +      includes both clock control registers and other control
> +      registers used for operations like resetting the GPU. Since


It seems you wanted to implement reset controller...

> +      these registers reside in the same address space, access to
> +      them is coordinated through a shared syscon regmap provided by
> +      the specified syscon node.

Drop last sentence. syscon regmap is a Linux term, not hardware one.

Anyway, this needs to be constrained per variant.

> +
>    "#clock-cells":
>      const: 1
>      description:
> @@ -36,8 +51,6 @@ properties:
>  
>  required:
>    - compatible
> -  - reg

No, that's a clear NAK. You claim you have no address space but in the
same time you have address space via regmap.

> -  - clocks

Nope, not explained, unless you wanted to make it different per variants.

>    - "#clock-cells"
>  
>  additionalProperties: false
> @@ -51,3 +64,9 @@ examples:
>          clocks = <&osc>;
>          #clock-cells = <1>;
>      };
> +
> +    clock-controller-vo {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "thead,th1520-clk-vo";
> +        thead,vosys-regmap = <&vosys_regmap>;

That's a "reg" property. Do not encode address space as something else.


> +        #clock-cells = <1>;
> +    };


Best regards,
Krzysztof


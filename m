Return-Path: <linux-pm+bounces-9146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD89086B8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8718C282AF6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CBA1922D5;
	Fri, 14 Jun 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvsehxwu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1D191493;
	Fri, 14 Jun 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354956; cv=none; b=eIi0icAgcMPWn/PB0fx8mrX7fgn9/JijZkoTpq+Hli8eFfSWTPr0f+egmUmfWOJPev5RJBJBv5fnIJ88ZGPUM/dgBkIcTO3i2CGxP6ZQbsPXirKBg0BLJhde7cYPL3LyQ5N5TFHYCr70EdyLJaOTatbbwoqdYmsFPBIhqGGFWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354956; c=relaxed/simple;
	bh=RTH0ZCUoVW8qlR2oSlZ0Oz37XH6P2imgZDfO/NIGbs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJmaSjbKIxTVj2FXIyzEDadCFhj7iKBPP9nCB2cZ6dWABqAovLtxEFqasFYTVgddjgSAc7NMKdl2WyysNRSoNR9sTZOV6b7d/ti2DZeIBlRwb5NyMwR/ApYfyQ/ZdAPVxFr0wjXYdNU3AF/D9BPOf3Y2U0RhaWu7PEcDIFekPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvsehxwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340C7C2BD10;
	Fri, 14 Jun 2024 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718354955;
	bh=RTH0ZCUoVW8qlR2oSlZ0Oz37XH6P2imgZDfO/NIGbs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvsehxwuXFOz/NeUh1oBN7B5Yfx0y4ponesNfKwFjMNl9iprWFcDAJDVig03XTCay
	 4zoFAmK5D6A29ZHKKnqTc3kebMMu6I5zhVnHT+OBmCUn86UsxMnO+l/txtn1UrIWqU
	 RZFORqlhlKQEPBAHwRzGPKiD9QLVpmUnq38942wWn3o3fZ14CFgt8gUsEgfjhme7KH
	 yRmfMPp41ZDjKZ/9akg6iLkUT2IJ0r2s++xgXYfBkPfqQntwQGMBoI6vXNFW9n0Yac
	 x6ETaDjEqNaVCdmRqGHFVciN05hdOUwVAOTV/yw7A/UPHwoOwwlWgE38ftXKmut7lU
	 h1DlXZLNe9bzQ==
Message-ID: <afb7551e-404e-440b-92c5-6927c61417ab@kernel.org>
Date: Fri, 14 Jun 2024 10:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240613224204.185844-1-abdulrasaqolawani@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240613224204.185844-1-abdulrasaqolawani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 00:42, Abdulrasaq Lawani wrote:
> Convert the hisilicon SoCs tsensor txt bindings to dt-schema
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
> Validated with dtschema and tested against `hi3660-hikey960.dts`
> 


> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml
> new file mode 100644
> index 000000000000..56ded6ebe1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml

Filename: hisilicon,tsensor.yaml

> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/hisilicon-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sensor on hisilicon SoCs
> +
> +maintainers:
> +  - Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> +

Missing $ref to thermal-sensor.yaml#

> +properties:
> +  compatible:
> +    items:

No need for items

> +      - enum:
> +          - hisilicon,tsensor
> +          - hisilicon,hi3660-tsensor
> +
> +  reg:
> +    description: physical base address of thermal sensor and length of memory mapped region.

Drop description, pointless.

> +    minItems: 1
> +    maxItems: 2

Instead you need to list items and describe them. But don't repeat
redundant parts like "physical base address". Just say which block is this.

Or... it's just wrong. Why two items?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: thermal_clk
> +
> +  interrupts:
> +    description:
> +      The interrupt number to the cpu. Defines the interrupt used
> +      by /SOCTHERM/tsensor.

No need for description, it's redudant.

> +    maxItems: 1
> +
> +  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details

Drop

> +  '#thermal-sensor-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false

unevaluatedProperties instead (after adding ref)
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi6220-clock.h>
> +
> +     // for Hi6220:
> +     tsensor: tsensor@0,f7030700 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +     compatible = "hisilicon,tsensor";
> +     reg = <0x0 0xf7030700 0x0 0x1000>;

Oh man...  get this past your mentors first.

1. Messed indentation.
2. 0, unit address looks unnecessary.


> +     interrupts = <0 7 0x4>;

Use proper defines for both common constants. There is a reason you
included arm-gic header, right?

> +     clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
> +     clock-names = "thermal_clk";
> +     #thermal-sensor-cells = <1>;
> +     };
> +
> +     // for Hi3660:
> +     tsensor1: tsensor@fff30000 {

Drop entire node. One example is enough.


Best regards,
Krzysztof



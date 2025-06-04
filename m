Return-Path: <linux-pm+bounces-28089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA99ACD802
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D815317017F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F41FCFF1;
	Wed,  4 Jun 2025 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+UQCwsq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A71F4606;
	Wed,  4 Jun 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749019643; cv=none; b=C4b0Q+tRHdPcqq+UCnWWpnhWtxgAAH54pVzgk0fVUmtJh69lcVOdNYVPt4frVzoTMLJcq8AU0WyXLgUE73souE4jXamOEPygjp1OxkZWxnTB+drFqFcQYVnMVhIxvC+EsvJFYa8vOqQYWa8UWSiM1qLAHFzi3SEcKFzEdN/YVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749019643; c=relaxed/simple;
	bh=SVuq2csc8B+tntGJ/PFd3caemy9vyyP3hUodtswqWwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLLm04oVt6fikgOhtf/GspXEnTHe7jovXLWUkmQ9keoHvkao64xH85lwwDdyCRH5UVzgdaGDhoY7t0FhwkCgi2dHtHaFynOuFxAi+7+VXpZy7/bKgoVLPtclgp4eF1exGrJCZWScEUOipCiFkGhqA7RfQOtDJLN8bFTWanmzDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+UQCwsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD56C4CEE7;
	Wed,  4 Jun 2025 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749019642;
	bh=SVuq2csc8B+tntGJ/PFd3caemy9vyyP3hUodtswqWwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+UQCwsqi2NvZG7jB2mPLYKlfETFtz7e/3kAD/cMMGuNU44cRY75oy2YgXqk1lyFV
	 4hxJIOyrEBYGkX4x9gfE0WoZMhbqrJTDVFWUr1Gibz/QwRqY1IUqhnpZqF9lttalT9
	 1eT1z7/OKBQRHd8xniK5iv41Lk54Lw87gpYyVy5/S3SDsxDrj9hQ6Mo68TJ76Jdynz
	 UDILQx5cQrQG+OAD1DiBNkkmjnClYds1VIAb7oJEqriLg4r5tsPJZurHGMP6pwlWWl
	 rfJXsicBelvHWXc6dTm0ZNjGE/vK3TiFRJGNtHWD+xH72vzIrvs1LEVKYCAcWI/2El
	 YDvcxBvmGfpeA==
Message-ID: <5fb1bcc0-db25-466a-b315-685d8b362245@kernel.org>
Date: Wed, 4 Jun 2025 08:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: mfd: add pf1550
To: samuel.kayode@savoirfairelinux.com, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
 Robin Gong <b38343@freescale.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-1-bfdf51ee59cc@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250603-pf1550-v4-1-bfdf51ee59cc@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2025 20:27, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add a DT binding document for pf1550 PMIC. This describes the core mfd
> device along with its children: regulators, charger and onkey.
> 
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v4:
>  - Address Krzystof's feedback:
>    - Filename changed to nxp,pf1550.yaml
>    - Replace Freescale with NXP
>    - Define include before battery-cell
>    - Drop operating-range-celsius in example since
>      nxp,thermal-regulation-celsisus already exists
>  - Not sure if there is similar binding to thermal-regulation...
>    for regulating temperature on thermal-zones? @Sebastian and @Krzysztof
> v3:
>  - Address Krzysztof's feedback:
>    - Fold charger and onkey objects
>    - Drop compatible for sub-devices: onkey, charger and regulator.
>    - Drop constant voltage property already included in
>      monitored-battery
>    - Fix whitespace warnings
>    - Fix license
> v2:
>  - Add yamls for the PMIC and the sub-devices
> ---
>  .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 139 +++++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..add895311b892a6731f54e47fcaaba8dfdac14b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/nxp,pf1550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PF1550 Power Management IC
> +
> +maintainers:
> +  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +
> +description: |

Drop |, Do not need '|' unless you need to preserve formatting.

> +  PF1550 PMIC provides battery charging and power supply for low power IoT and
> +  wearable applications. This device consists of an i2c controlled MFD that
> +  includes regulators, battery charging and an onkey/power button.
> +
> +$ref: /schemas/power/supply/power-supply.yaml
> +
> +properties:
> +  compatible:
> +    const: nxp,pf1550
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^(ldo[1-3]|sw[1-3]|vrefddr)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml
> +        description:
> +          regulator configuration for ldo1-3, buck converters(sw1-3)
> +          and DDR termination reference voltage (vrefddr)
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false

Please put it after type:object

> +
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Drop, comes from power supply schema

> +    description: |
> +      A phandle to a monitored battery node that contains a valid value
> +      for:
> +      constant-charge-voltage-max-microvolt.
> +
> +  nxp,thermal-regulation-celsius:
> +    description:
> +      Temperature threshold for thermal regulation of charger in celsius.
> +    enum: [ 60, 75, 90, 105 ]
> +
> +  nxp,min-system-microvolt:
> +    description:
> +      System specific lower limit voltage.
> +    enum: [ 3500000, 3700000, 4300000 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

And this becomes unevaluatedProperties: false.

With these changes (and after testing with dt_bindings_check):


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


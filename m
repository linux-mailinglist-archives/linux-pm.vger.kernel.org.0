Return-Path: <linux-pm+bounces-27717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDBAC619E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF08C4A5983
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50952101B3;
	Wed, 28 May 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE0Ma/H0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E120F085;
	Wed, 28 May 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412503; cv=none; b=KpYciTHjIu/O8t/O7ipIib2jTMvB8SIYLFbcOxyOv0OHSuq+hRS9dmUitnzSJPeA/NpGL8AgPyE6R9XPqm/VpcyZhRqWKljYzsP+zQxJBnXVqQwKLvQeUmbZNaE0b0CAQ3eQ7nQmDepSGvyjBUTOGGYpdaxMYoZpP7Yryt4gNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412503; c=relaxed/simple;
	bh=/JC3gGZ8Q9DdKYDyYaEVzxxLkm2Yi35dZsaPUf3NQDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iO//SNwMUEyle9aYu66XZUXiHF3iQt7dQSWeO88Cjxm7cFO/DViCXYnTXfBJBuLWbUvyKbtTOdl6OzxWBlNf47dWCbLLgd+AMdyoB1y1o0q3YpGj9wPIXaGK/KEuKDt6R8RwFfVdMw949/B2CoNvL9ycXelo3kl61TYgCgUPVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE0Ma/H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34826C4CEE7;
	Wed, 28 May 2025 06:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748412503;
	bh=/JC3gGZ8Q9DdKYDyYaEVzxxLkm2Yi35dZsaPUf3NQDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZE0Ma/H0JblFA4ium+PGZRkGBmojq76R93O6Hm+rB6e3Q8iliL8+IL7lJSRpp9g+p
	 yEVamsORm4l/eYQV8VxTFbeNHrKHbQ1dn+LhgvnMG7niB5Wu4IoklUsv2HFYXqIN5N
	 CaMd9uFANvjfT4Z+W3k6OXiyxysdIcppfI6NTw/2Ki7u3hoV4oXcgft+MTFcpZNnXI
	 pxPLG0x2Bpt04kKspcj8PQ+LSL3z6shBsy09EBnpWfN9BuIAIptp9Ww3nE+0CmSr/9
	 IY7kYV5iTQsbfw5kcWGTWNUDH+nBUjyhJn9OijHs6Y/cktniJQEEpTkJ/P2JwEszpG
	 L15qfl5UDEIRg==
Message-ID: <250c9bf7-c958-4383-9b3f-45b4174585c5@kernel.org>
Date: Wed, 28 May 2025 08:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: add pf1550
To: samuel.kayode@savoirfairelinux.com, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, eballetbo@gmail.com,
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com,
 Abel Vesa <abelvesa@kernel.org>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
 <20250527-pf1550-v3-1-45f69453cd51@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250527-pf1550-v3-1-45f69453cd51@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2025 00:25, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add a DT binding document for pf1550 PMIC. This describes the core mfd
> device along with its children: regulators, charger and onkey.
> 
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
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
>  Documentation/devicetree/bindings/mfd/pf1550.yaml | 139 ++++++++++++++++++++++

Filename: nothing improved.


>  1 file changed, 139 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/pf1550.yaml b/Documentation/devicetree/bindings/mfd/pf1550.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7f22cb91eb5542c8aa616525ed1e78efa2a863d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/pf1550.yaml


...

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
> +
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      A phandle to a monitored battery node that contains a valid value
> +      for:
> +      constant-charge-voltage-max-microvolt.
> +
> +  fsl,thermal-regulation:

-celsius or whatever is in standard suffixes:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop

> +    description:
> +      Temperature threshold for thermal regulation of charger in celsius.

But this now makes me wonder whether this should be just part of thermal
zone and get the threshold from there. I assume this is temperature of
CHARGER, not the battery. If battery, you have such properties in
battery.yaml (monitored-batter).

@Sebastian,
Are there existing bindings or devices which regulate temperature based
on thermal-zones in DT?



> +    enum: [ 60, 75, 90, 105 ]
> +
> +  fsl,min-system-microvolt:
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
> +
> +examples:
> +  - |
> +    battery: battery-cell {
> +        compatible = "simple-battery";
> +        constant-charge-voltage-max-microvolt = <4400000>;
> +        operating-range-celsius = <0 75>;

So this looks like duplicating thermal-regulation property.

> +    };

Blank line

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>

Includes go before battery-cell.

> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +



Best regards,
Krzysztof


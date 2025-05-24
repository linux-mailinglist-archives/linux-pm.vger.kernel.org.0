Return-Path: <linux-pm+bounces-27622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B947DAC2DFE
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160961C03782
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CED1BD9CE;
	Sat, 24 May 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpFesYvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DB54918;
	Sat, 24 May 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748068259; cv=none; b=dj1YrFWCxSeltHp94jQeRfgxMjLqEuVmaGwgbY9a0YrGq9LjjxbvUZkR0rXPDrcpry0pBT4R6jBK3n5ihZcsO4PjQ2hySqYYB/CG1+VG6DIctMQ5PgQtot2eIlxuJY+j73rOy7/1CmIny0nBzVSwk4ZFz8f14Va3cqroRONNKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748068259; c=relaxed/simple;
	bh=OSW0a8O6Ua3C9OWukvcF0yxnXBWtC+NYWhxAHl7Wztc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MOgVXBQqltnjrcrPlx8H5+ZU88jKPHRJtQWI8bh0n/cd1g3RRdGg2a0R288LQ6qrDsuj1BJmDpTFxQmeTg4heeb/kGnCG/0gXhJN5tQc7gvem33amEFwfMoW7zJ6Z8+sxYALTXV3gWSGx8kuFANbGpiWsr/flzkvLGsdDivSyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpFesYvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8884C4CEE4;
	Sat, 24 May 2025 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748068258;
	bh=OSW0a8O6Ua3C9OWukvcF0yxnXBWtC+NYWhxAHl7Wztc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OpFesYvKN/KLhXgATBYCI4q4vGnBunLB8OMRrNQr7btbcpD1+sOXwyAGFj8EQAlu0
	 tni57uJKB6QINRKRPcfU2dQtlXpp1blv1muy6foBOrSwffg0VCuocZIs/jiVD25lHT
	 6pGk00a3MAT0PRZZXAidk2SmQnsDJgZvFOn6YXyPMjfE8Y7v/XzAp1Ikb0xZ3TkFGy
	 eP2TQLhEKnbos+TxdcALReBys49nl/svLLJdxjEXGYiH7z18TJq/04GCjDt6hHjzO/
	 /h+RaK86SID+ZhpbVh+We1Zc/zx5kQKZFSb3pj+QDktnaS9gVnt1DSD6eMms5W36xS
	 wA0w2vSnT5dBg==
Message-ID: <e19ee6c5-447e-43ee-bc63-df15ff2f6031@kernel.org>
Date: Sat, 24 May 2025 08:30:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: thermal: airoha: Rename and Document
 AN7583 support
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523182939.30489-1-ansuelsmth@gmail.com>
 <20250523182939.30489-5-ansuelsmth@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250523182939.30489-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2025 20:29, Christian Marangi wrote:
> Rename .yaml to a more generic airoha-thermal and Document support for
> Airoha AN7583 thermal driver.
> 
> Airoha AN7583 follow the same logic of Airoha EN7581 to read the
> temperature but lack all the support for the PTP_THERMAL used to monitor
> and react when trip point are triggered.
> 
> Also the Airoha AN7583 lives entirely under the Chip SCU SoC register
> space.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  ...n7581-thermal.yaml => airoha-thermal.yaml} | 42 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/thermal/{airoha,en7581-thermal.yaml => airoha-thermal.yaml} (52%)

No. I do not see any reason to rename correct filename (how we expect)
to incorrect (wrong format, no vendor prefix, not matching compatible).

> 
> diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
> similarity index 52%
> rename from Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
> rename to Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
> index ca0242ef0378..42f93b095783 100644
> --- a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
> @@ -1,17 +1,19 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
> +$id: http://devicetree.org/schemas/thermal/airoha-thermal.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Airoha EN7581 Thermal Sensor and Monitor
> +title: Airoha Thermal Sensor and Monitor
>  
>  maintainers:
>    - Christian Marangi <ansuelsmth@gmail.com>
>  
>  properties:
>    compatible:
> -    const: airoha,en7581-thermal
> +    enum:
> +      - airoha,en7581-thermal
> +      - airoha,an7583-thermal
>  
>    reg:
>      maxItems: 1
> @@ -28,9 +30,30 @@ properties:
>  
>  required:
>    - compatible
> -  - reg
> -  - interrupts
> -  - airoha,chip-scu
> +  - '#thermal-sensor-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: airoha,en7581-thermal
> +    then:
> +      required:
> +        - reg
> +        - interrupts
> +        - airoha,chip-scu
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: airoha,an7583-thermal
> +    then:
> +      properties:
> +        reg: false

Don't stuff completely different devices into one binding. They are
completely different if they have completely different programming model.


Best regards,
Krzysztof


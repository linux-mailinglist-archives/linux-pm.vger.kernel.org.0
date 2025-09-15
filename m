Return-Path: <linux-pm+bounces-34619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A112AB56F51
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11FC189AE04
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A4275878;
	Mon, 15 Sep 2025 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXvToxPM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DB259CBF;
	Mon, 15 Sep 2025 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910524; cv=none; b=en74GeenyN8pEOFwHdVNscyugAu/39D4u/8uitYV9sToOYzUovz96vU2nBhZE1lu/c33ruREMzgPwNwYQ6JgM0L9vud/OltxpN/cFJmVfinxz93spdGRL0yv58rQ/xtnTfRQSyCUjS8ob6A5BDCDLuZx//gTTUcIv334nxSQLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910524; c=relaxed/simple;
	bh=PX488pT97NE5afEQzWHqJGVvzubHIHjpc9XXtw1a3K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTB1elyhQPpY18arodQmcJEw7SMzNnwWhc3FApOdcA7vLOvqxp96uTsOozFBb7f9OAyyjFEr0beSppS2uK2/S46d2XHJvbPlVZT9bW7h87aTpho2UlowqBTaBFM2ogTuYDo2GBo770ogf8GA6id/afmvM0jtK/rOJwPR86ElLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXvToxPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C58C4CEF1;
	Mon, 15 Sep 2025 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757910524;
	bh=PX488pT97NE5afEQzWHqJGVvzubHIHjpc9XXtw1a3K0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cXvToxPMvt66eSNyEq6Mm+6prusbb58pbwK3/1mjz7V1m33e6C4BApVob/SzQApok
	 yMmfhex9V75YXylBe+/kYvPHRXDR0mEI803Q57TdHwvWpi8D1Y1k7oKKUhFb3y1Wqi
	 UQtScSQk1uc9AUEWiYj4UON8M7DmeiqjVe0gvbRWoVtNp7ajDJSqA8SwYcS+ShDKNS
	 4j8Z/0MlpJ1JLIwMaZuKLYDIQWe4sGO5+GdM3JRYJQY6xgFXUBz0LNE+KzMJSkbmDQ
	 Ygkle5qtL/xQ3Ee0TpP+XClumVwEkKybffUTAnc9M7y7AsRT9+U9VX/s2FOdLHtrHj
	 S1HMvdLL+MSxg==
Message-ID: <b453e64b-b3db-4b8f-ba9d-0da7e55fe057@kernel.org>
Date: Mon, 15 Sep 2025 06:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: samsung: Add a
 hw-sensor-indices property
To: Shin Son <shin.son@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Henrik Grimler <henrik@grimler.se>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250915040715.486733-1-shin.son@samsung.com>
 <CGME20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d@epcas2p4.samsung.com>
 <20250915040715.486733-2-shin.son@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250915040715.486733-2-shin.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2025 06:07, Shin Son wrote:
> The exynosautov920 TMU requires per-sensor interrupt enablement
> for its critical trip points.
> 
> - **samsung,hw-sensor-indices**: List of sensor indices physically
>                                  monitored by this TMU block.
> 				 Indicies not listed exist in the SoC
> 				 register map but are not part of
> 				 this TMU instance

Not much improved here. Same comment as before. That's not even correct
syntax but some oddly formatted code. I asked to drop it and instead
describe hardware. This is not a place to write some **code** or
whatever this paragraph is about to represent.

> 
> Additionally, add myself to the bindings' maintainers list, as I plan
> to actively work on the exynosautov920 TMU support and handle further
> updates in this area.
> I also restrict 'samsung,hw-sensor-indices' to the V920 variant. To
> ensure properties introduced in 'if/then' blocks are recognized, I
> replace 'addtionalProperties: false' with 'unevaluatedProperties: false'.

No, don't do that.

> 
> Signed-off-by: Shin Son <shin.son@samsung.com>
> ---
>  .../thermal/samsung,exynos-thermal.yaml       | 40 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index 29a08b0729ee..448c68986b10 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> @@ -8,6 +8,7 @@ title: Samsung Exynos SoC Thermal Management Unit (TMU)
>  
>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Shin Son <shin.son@samsung.com>
>  
>  description: |
>    For multi-instance tmu each instance should have an alias correctly numbered
> @@ -27,6 +28,7 @@ properties:
>        - samsung,exynos5420-tmu-ext-triminfo
>        - samsung,exynos5433-tmu
>        - samsung,exynos7-tmu
> +      - samsung,exynosautov920-tmu
>  
>    clocks:
>      minItems: 1
> @@ -62,7 +64,7 @@ properties:
>      minItems: 1
>  
>    '#thermal-sensor-cells':
> -    const: 0
> +    enum: [0, 1]
>  
>    vtmu-supply:
>      description: The regulator node supplying voltage to TMU.
> @@ -97,6 +99,8 @@ allOf:
>          reg:
>            minItems: 2
>            maxItems: 2
> +        '#thermal-sensor-cells':
> +          const: 0
>    - if:
>        properties:
>          compatible:
> @@ -119,6 +123,8 @@ allOf:
>          reg:
>            minItems: 1
>            maxItems: 1
> +        '#thermal-sensor-cells':
> +          const: 0
>  
>    - if:
>        properties:
> @@ -139,8 +145,38 @@ allOf:
>          reg:
>            minItems: 1
>            maxItems: 1
> +        '#thermal-sensor-cells':
> +          const: 0
>  
> -additionalProperties: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynosautov920-tmu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 1
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +        '#thermal-sensor-cells':
> +          const: 1
> +        samsung,hw-sensor-indices:
> +          description:
> +            List of thermal sensor indices physically monitored by this TMU instance.
> +            Indices not listed correspond to registers that exist in the SoC
> +            but are not connected to this TMU hardware block.
> +          $ref: /schemas/types.yaml#/definitions/uint32-array

I don't understand what is happening here with this binding. See writing
schema and example-schema.



Best regards,
Krzysztof


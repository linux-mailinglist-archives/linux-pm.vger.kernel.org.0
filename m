Return-Path: <linux-pm+bounces-33459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C5B3C99D
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2FD1C23CAE
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9DA2566F7;
	Sat, 30 Aug 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhbiGsvC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD66253F2A;
	Sat, 30 Aug 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544814; cv=none; b=q4x1Lw5QQ0WlKcgDduM0KCzuwNloRPwoDhdAZPJTNnoohF8m71PwB5NR8thQMkJZfoqNLyruq242u9W9YpmcvH5GOj+tl04An+0Ku+4NAotXUPlyEvZAj9H1CWn92JhmUgc3YHLPHiJAJ/WijnCUNSSDxGC5cU7GsAGvYYOIpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544814; c=relaxed/simple;
	bh=mpWZMBrKYpqukOiHgjuGvad1OfHPQQN9cvi3zmQkyuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLHBUuxIpZrmm6Fr55ISXZBdkvikOnDmOBzN0TNDtzzLDLDRloOUfIJQXRnNR8Q+5l+YWYNGHI1H/GJ0XxcKe9TihCzsrNEiMz9B9+nEr0RdIEEVMCDSBg7TKpnWk92qbcEKtLpjmMCJtHRRSyVBu50baNd9G+5v45Fp3RCzaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhbiGsvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4459C4CEEB;
	Sat, 30 Aug 2025 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756544814;
	bh=mpWZMBrKYpqukOiHgjuGvad1OfHPQQN9cvi3zmQkyuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BhbiGsvCYk30HFN3baBWG0Rf/dD78i+pnexb6GfhtIrmb4NODMXRyfvGtgILT03ND
	 uM0rqUvS6yqPPGlHZTGqGn40aCKDrOy5UI2EGRsmlncrz5mO4FailR656uEeavzDn2
	 pUUu7t8AR08/uUczyjrU+fQeyx3m99XCrDs0Sg9P5qtFETLahqJxxMHgKHn/Sy41B+
	 zvnY8v8XW7xTQCZh1nGG84XSVX0pvB73V3YnHgtOrDonAzwqLG9vMH7qYchfotiueC
	 0G5WJRzGE54tnS4qcyvjKiDwbQIz02EPR39gf6rLj6DkqvGebJ3/RDBM9L3lRk3cQC
	 G6Kp48/oo5x7w==
Message-ID: <f6acdd01-8847-4282-b375-f8e564be81d2@kernel.org>
Date: Sat, 30 Aug 2025 11:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
To: Shin Son <shin.son@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250825064929.188101-1-shin.son@samsung.com>
 <CGME20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002@epcas2p3.samsung.com>
 <20250825064929.188101-2-shin.son@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250825064929.188101-2-shin.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2025 08:49, Shin Son wrote:
> The exynosautov920 TMU requires per-sensor interrupt enablement
> for its critical trip points.
> Add two new DT properties to the Samsung thermal bindings
> to support this requirement:
> 
> - **tmu-name**: an explicit identifier for each TMU,
> 		used to skip specific sensors
> (e.g., sensor 5 is temporarily disabled on the TMU_SUB1 block).
> 
> - **sensor-index-ranges**: defines valid sensor index ranges
> 			   for the driver’s bitmap in private data,
> 			   enabling per-sensor interrupt setup and data access.
> 
> Signed-off-by: Shin Son <shin.son@samsung.com>
> ---
>  .../thermal/samsung,exynos-thermal.yaml       | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index 29a08b0729ee..420fb7a944e3 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> @@ -8,6 +8,7 @@ title: Samsung Exynos SoC Thermal Management Unit (TMU)
>  
>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Shin Son <shin.son@samsung.com>

This needs also explanation in commit msg.

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
> @@ -62,11 +64,29 @@ properties:
>      minItems: 1
>  
>    '#thermal-sensor-cells':
> -    const: 0
> +    enum:
> +      - 0
> +      - 1
>  
>    vtmu-supply:
>      description: The regulator node supplying voltage to TMU.
>  
> +  tmu-name:

Generic property? Where is it defined.

> +    description: The TMU hardware name.

Anyway, you do not get instance IDs. I talked about this at OSSE25.


> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1
> +    maxItems: 1
> +
> +  sensor-index-ranges:

Where is the property defined? You keep adding generic properties.

> +    description: |
> +      Valid Sensor index ranges for the TMU hardware.

I don't understand what is this for.

> +
> +      Note:: On the ExynosautoV920 variant, the fifth sensor in the TMU SUB1 is disabled,
> +      so the driver skips it when matching by tmu-name.

That's not name, so why are you referring to tmu-name? And driver has
nothing to do here. Describe hardware.

None of this is really correct. :/


Best regards,
Krzysztof


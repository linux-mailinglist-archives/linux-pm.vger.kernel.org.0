Return-Path: <linux-pm+bounces-33806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F99B434DB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA83178A02
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E328F2BF00A;
	Thu,  4 Sep 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooXCt7hh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AA2BEC43;
	Thu,  4 Sep 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972779; cv=none; b=ToPSjcyPtagWiTt1+AGXNWWp4HP53GkSFqcuVGvxqjVLVKIcr/s4KXONa/jZRogbx3cWO9pWaOrBPBbqV5ih2FWTuwutVISi7YEOIotlq5Dx0AFDxuiiZKy1o/FyV5Mc2KR577ZrQEkZJLieqOy6J9OlSyL6FL4uocqw/18hk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972779; c=relaxed/simple;
	bh=qr1V071kjlRjsRCmHcuB3ihXSJkt/phuzQie/Q1MiZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaPkD0J4n9X12VPRJHE95URIbdM27rwbUScJ7H2cHb9DOix4E3Rzg2NW4JfYlEa+6XMnwXN0G+QG2f0IODBODhErkFfFDZhRHcG6Pzv9yfKmpboPTdkaTVrRfHenNh3/Tg/KE+1J3FbbbLJVa7DBew6oy/hwOfcF2xGntoLscr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooXCt7hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4AFC4CEF1;
	Thu,  4 Sep 2025 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972779;
	bh=qr1V071kjlRjsRCmHcuB3ihXSJkt/phuzQie/Q1MiZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooXCt7hhW4NMrwAjO7gPOLnLZI7xsHoYmdJepFhj62ONTqa6O7U78jJlEolZJFTeb
	 SEaqRG9H2nu8UH4g1THcNbD90ssj//+E1fGFMVU1/zpzXwtGkbyMt9f30SKIKv0G+3
	 bwG/TLFdU2Ct5JbPvWJEqeuM2eTxyPbKmZdvtwAIvO3SipW7NbdHUt/Nmram6KmbmE
	 LRzJjXoNmF5C3/jukRpA66VKlkLRSGunAExp4E+Ny4nbRS1YgBbbtOGAmG2PcJNCtn
	 wmCQtPGXg32OMvsx1xv1Z7Qyf7rzpArlYodOGDNKfttA/xGG/0iszppNrFryEwsO8M
	 9Vew+ag+ROmfA==
Date: Thu, 4 Sep 2025 09:59:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shin Son <shin.son@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Message-ID: <20250904-chocolate-kangaroo-of-order-2cced3@kuoka>
References: <20250903073634.1898865-1-shin.son@samsung.com>
 <CGME20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91@epcas2p4.samsung.com>
 <20250903073634.1898865-2-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903073634.1898865-2-shin.son@samsung.com>

On Wed, Sep 03, 2025 at 04:36:32PM +0900, Shin Son wrote:
> The exynosautov920 TMU requires per-sensor interrupt enablement
> for its critical trip points.
> Add a DT property to the Samsung thermal bindings
> to support this requirement:

That's pretty redundant sentence.
> 
> - **samsung,hw-sensor-indices**: Defines the sensors currently
>                                  mapped to the TMU hardware.
> 				 Indices not listed are absent or fused off

Don't write here any code, but concise prose dxescribing hardware.

If sensors are fused out, you certainly can read their status from efuse, no?

This is really vague description of hardware. I don't understand why you
are changing sensor-cells, why older variants of tmu gets now cells=1
(missing constraints?).

Why older variants also get that property for sensors? It does not make
sense there, because they have one-to-one mapping between TMU and
sensor.

> 
> Additionally, add myself to the bindings' maintainers list, as I plan
> to actively work on the exynosautov920 TMU support and handle further
> updates in this area.
> 
> Signed-off-by: Shin Son <shin.son@samsung.com>
> ---
>  .../bindings/thermal/samsung,exynos-thermal.yaml | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index 29a08b0729ee..abd89902d33a 100644
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
> @@ -62,11 +64,22 @@ properties:
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
> +  samsung,hw-sensor-indices:
> +    description: |

Drop |

> +      List of hardware sensor indices that are physically present and usable
> +      in this TMU instance. Indices not listed are either unmapped or unused.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 16
> +    uniqueItems: true

Best regards,
Krzysztof



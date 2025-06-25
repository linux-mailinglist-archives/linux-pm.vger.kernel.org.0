Return-Path: <linux-pm+bounces-29465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDA0AE7903
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C1F17A4E3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B581FBEB0;
	Wed, 25 Jun 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eosilbo1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5186338;
	Wed, 25 Jun 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837713; cv=none; b=FN6ssvfoVsiazgQP/2o5oPYLEQlfRtOkuDptJSrZC9tL90VYVs0WzMzgFpHP4siI4oTLJ3Letaa+y65CmQBCuEQ3+PRSPyeq8VbZb82PPG+CohAznwY2eNf5+kbImgm7aavE3sG7DKgyIrT2LT7vRJITE7+0RKIK1RD3UwMShcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837713; c=relaxed/simple;
	bh=wcxbDOO23BZSK9SuEAS8HrjXgynk1/RQtyt2aVRPI9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFoTQbLyvN03EhKUHhfpvExEy8Cgx+Gxcpk9164wF6FIBlhyXQtjL22YaFLvU4ECbzn+w+Y+gkhyb40jHj7M59nZ7LmndD2HQm68OnGPPepkyIYOiUYIHjaIgBKBTYxAUF6DrlKHBKc0PwYOogOVsGB/bXbBoHxRd4dEFNZWjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eosilbo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88541C4CEEA;
	Wed, 25 Jun 2025 07:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837713;
	bh=wcxbDOO23BZSK9SuEAS8HrjXgynk1/RQtyt2aVRPI9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eosilbo1a2u7ZIOph35J9pAazHEt04/+SO+151EwKwNke744IyH4NyXjCLNf60pBS
	 cwvDeXlnq6rLavGYUmVZt1m8j3lpPhrUEx4XSr2wjnwBGntgWaojhZBAd5XROkxjxf
	 ozkxp4dSh5YLUGGTsYAf4noiL1Z38howiQReahs4TWooTvpyRu0EEnR5xiJou9e2mz
	 nefeMarc1jT9Sb9UrYzj6wgR27gvON90TUz4n2Q6TYAysQT2BA9hBBHZGAIpR9Hj8j
	 0grxp/QMPTJDnuaPDJNz/6hDk99NzcxxEHfFbDgmQmP2K94Ejp9jOGuxi/A/3qkxR4
	 4ZidlxkWJc77w==
Date: Wed, 25 Jun 2025 09:48:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
Message-ID: <5qeo2xqjprozcjd553qmozzrmbciuf66gic65tzw7jspoub5n4@5wzkqasisgcz>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
 <20250623162223.184304-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623162223.184304-2-macroalpha82@gmail.com>

On Mon, Jun 23, 2025 at 11:22:19AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Document the Texas instruments BQ25703A series of charger managers/
> buck/boost regulators.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> new file mode 100644
> index 000000000000..0727f24b8e54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BQ25703A Charger Manager/Buck/Boost Converter
> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +allOf:
> +  - $ref: /schemas/power/supply/power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,bq25703a
> +
> +  reg:
> +    const: 0x6b
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-supplies: true

Drop, redundant.

> +
> +  monitored-battery:
> +    description:
> +      The phandle for a simple-battery connected to this gauge.

This part is redundant. It cannot be anything else, according to
power-supply.yaml

> +      A minimum of constant-charge-current-max-microamp,
> +      constant-charge-voltage-max-microvolt, and
> +      voltage-min-design-microvolt are required.

This is fine.

> +
> +  input-current-limit-microamp:
> +    description:
> +      Maximum total input current allowed used for both charging and
> +      powering the device.
> +    minimum: 50000
> +    maximum: 6400000
> +    default: 3250000
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Boost converter regulator output of bq257xx.
> +
> +    properties:
> +      "usb-otg-vbus":

Drop quotes. Is this the name of regulator called in datasheet? To which
pin this corresponds to? I cannot find anything on usb-otg or usb_otg.


> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-min-microamp:
> +            minimum: 0
> +            maximum: 6350000
> +          regulator-max-microamp:
> +            minimum: 0
> +            maximum: 6350000
> +          regulator-min-microvolt:
> +            minimum: 4480000
> +            maximum: 20800000
> +          regulator-max-microvolt:
> +            minimum: 4480000
> +            maximum: 20800000
> +          enable-gpios:
> +            description:
> +              The BQ25703 may require both a register write and a GPIO
> +              toggle to enable the boost regulator.
> +
> +        additionalProperties: false

Please place it after $ref.

> +
> +        required:
> +          - regulator-name
> +          - regulator-min-microamp
> +          - regulator-max-microamp
> +          - regulator-min-microvolt
> +          - regulator-max-microvolt
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - input-current-limit-microamp
> +  - monitored-battery
> +  - power-supplies

Keep the same order as in properties.

Best regards,
Krzysztof



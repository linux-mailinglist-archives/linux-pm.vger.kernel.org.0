Return-Path: <linux-pm+bounces-22518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD7A3CD1E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300317A8412
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1C25C704;
	Wed, 19 Feb 2025 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssGYmnJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9225A334;
	Wed, 19 Feb 2025 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006638; cv=none; b=FQGw3yfvm6wNqJ4ZuD6LQ6fyudaPmnOnq00g/W6l5YZSvOYeXj+DD9JrZ6UFAWamKE9Hnmp0oKT1xoMTDj03IBXlw3F88y5CKw0Iyrp7M+cWvt7lBu1zk5lH+Qhg4ARQJttKKFD7ZSAIovwzqseL/Ffmx8sB5/ZMoUBTvLCm5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006638; c=relaxed/simple;
	bh=CYLczoHD6qvbYSNlRY5igolvyzZvd2e9ewBvJXOSbIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4EcFv9klRyyDuVV0XcPBjZuj7m0EEMb/3fDZduONNGKjLsYNmDjo62iGu34HYTeXxFcUfJwg+MlVPOHdG4Q376f4LL9eiiqS4ogpJQgywGyKJCMvmEu03E0cWEWkCzAKf60iEviRP3RqZOHz6OOp8sfnELfjBuZwdwTavhwblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssGYmnJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA85C4CED1;
	Wed, 19 Feb 2025 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006637;
	bh=CYLczoHD6qvbYSNlRY5igolvyzZvd2e9ewBvJXOSbIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssGYmnJ9qxwuROAsGnBlSTwZir7tTkewQhMyWzapIUf0BfmMOI2Ju3oj8Vr49jREA
	 lUF4QK8E0rZiO07qAKQLe0etXjkWtMS5tNUHq8pqqbknRdEIOnVI8XmdBSfze0riaJ
	 QmWNOZmUeyzjZtAbiLv7WJLTu+X/breMLqPTt1Z563RcmmbjqUJMTPzpZcTuICsr13
	 gyJYadZesKuK9+AnT7OrceSijZnMd92ubLhHUpUhSN+5jkVVB0NW1sZeFsyqGDr2Qb
	 IxULEIJhGfskmfeCtB9KknZYkDsKvA6jpYULrSeRQ3CnTcVFr4P9ETmWiUq39Zt9+b
	 AU2rl7Sggwogw==
Date: Wed, 19 Feb 2025 17:10:36 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: thermal: rockchip: document otp thermal
 trim
Message-ID: <20250219231036.GA3137058-robh@kernel.org>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
 <20250216-rk3576-tsadc-upstream-v1-4-6ec969322a14@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-4-6ec969322a14@collabora.com>

On Sun, Feb 16, 2025 at 12:34:53AM +0100, Nicolas Frattaroli wrote:
> Several Rockchip SoCs, such as the RK3576, can store calibration trim
> data for thermal sensors in OTP cells. This capability should be
> documented.

Is several most or a minority as this change is enabled for everyone.

> 
> Such a rockchip thermal sensor may reference cell handles that store
> both a chip-wide trim for all the sensors, as well as cell handles
> for each individual sensor channel pointing to that specific sensor's
> trim value.
> 
> Additionally, the thermal sensor may optionally reference cells which
> store the base in terms of degrees celsius and decicelsius that the trim
> is relative to.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/thermal/rockchip-thermal.yaml         | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..8d27ddefcc64e29f0faab059888805802c948b41 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -40,6 +40,21 @@ properties:
>        - const: tsadc
>        - const: apb_pclk
>  
> +  nvmem-cells:
> +    items:
> +      - description: cell handle of the low byte of the chip fallback trim value
> +      - description: cell handle of the high byte of the chip fallback trim value
> +      - description: cell handle to where the trim's base temperature is stored
> +      - description:
> +          cell handle to where the trim's tenths of Celsius base value is stored
> +
> +  nvmem-cell-names:
> +    enum:
> +      - trim_l
> +      - trim_h
> +      - trim_base
> +      - trim_base_frac
> +
>    resets:
>      minItems: 1
>      maxItems: 3
> @@ -51,6 +66,12 @@ properties:
>        - const: tsadc
>        - const: tsadc-phy
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    "#thermal-sensor-cells":
>      const: 1
>  
> @@ -72,6 +93,29 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1]
>  
> +patternProperties:
> +  "^([a-z]+)@[0-9]+$":

If each node is a sensor or channel, then make that the node name.

> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: sensor ID, a.k.a. channel number
> +
> +      nvmem-cells:
> +        items:
> +          - description: handle of cell containing low byte of calibration data
> +          - description: handle of cell containing high byte of calibration data
> +
> +      nvmem-cell-names:
> +        items:
> +          - const: trim_l
> +          - const: trim_h
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> 
> -- 
> 2.48.1
> 


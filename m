Return-Path: <linux-pm+bounces-23005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F73A46368
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037BF3B3C98
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F492236EB;
	Wed, 26 Feb 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7TO8yXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F2223339;
	Wed, 26 Feb 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581151; cv=none; b=QUeGXHd9COGZ3BnT/SNaB91s9wcDpSnp24zceqedgC1YJElCMy05xNXOid+GS7dRt+Dd6FCbTrdv+51IP8lKKVn1Rm/r74nTKfsSOQdnexOJy8RX7bDA2sablF8XRCqsGVgqYe5jaYWh4vF9758r+fDf/q4vyxIytSxDOfdYl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581151; c=relaxed/simple;
	bh=2e8y34nF3WAvOI36M9xs1+jJDib5lSf6jroS4lJKWRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1NkqghlF7m7enkt4XhEhKb+gotDb97TLPVUC9SLnMX7oVBTayxQsZLXb3om4UC67vrV/qHg4x49At/T3BLwKZA4tVv7KHsOyaFntOcgb1SWYj5b2BpHtgIOF36j+zfPcvPcaHFM1GfcgqILXbu+5gTpkp136YDQL5GhiZrWP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7TO8yXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9932AC4AF0B;
	Wed, 26 Feb 2025 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581150;
	bh=2e8y34nF3WAvOI36M9xs1+jJDib5lSf6jroS4lJKWRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7TO8yXxQmiYV0e978xp7cwfIDefmJ7wdXKZEKaEo7couphnmeePegIiWh7rHgAes
	 yi6PFABiCw0C6OnVizzoqwFj1Y+r4yOaPdqWynd0DSSPzQrZQvRC3yOjjyJuTqLWaS
	 X4UNy3p+thTfBpcYIf4iwD14hMFT+Ty9KNpydCaHtMpIzgr3TDoE9kUs66v7opDFWg
	 oplQ8iqVFvQ9CUI6aL7+JfIhPm/vs3pfSN459q0AtlP1xmpXUga85qgQP7CQEBO+2I
	 7Rr1SDzlaQke0cDyIDA8a4JiXHva92wkVVAL7u9MTHNVoT/utxi17F/MZatXawLLWL
	 vEAdgOgR53OLw==
Date: Wed, 26 Feb 2025 08:45:48 -0600
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
Subject: Re: [PATCH v2 4/6] dt-bindings: thermal: rockchip: document otp
 thermal trim
Message-ID: <20250226144548.GA2299551-robh@kernel.org>
References: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
 <20250225-rk3576-tsadc-upstream-v2-4-6eb7b00de89c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-rk3576-tsadc-upstream-v2-4-6eb7b00de89c@collabora.com>

On Tue, Feb 25, 2025 at 01:56:47PM +0100, Nicolas Frattaroli wrote:
> Several Rockchip SoCs, such as the RK3576, can store calibration trim
> data for thermal sensors in OTP cells. This capability should be
> documented.
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
> Each SoC that implements this appears to have a slightly different
> combination of chip-wide trim, base, base fractional part and
> per-channel trim, so which ones do which is documented in the bindings.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/thermal/rockchip-thermal.yaml         | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..eef8d2620b675fe2f871a03aebdaed13278e0884 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -11,6 +11,23 @@ maintainers:
>  
>  $ref: thermal-sensor.yaml#
>  
> +definitions:

'$defs' is preferred over 'definitions'. However, I don't think you need 
either.

> +  channel:

Just make this a pattern property:

'@[0-5]$'

Really, node names should be generic and the type of thing they are, not 
what instance they are. So something like 'sensor' for all the child 
nodes. IOW, node names is not how you should identify what each sensor 
is associated with.

> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: sensor ID, a.k.a. channel number
> +      nvmem-cells:
> +        items:
> +          - description: handle of cell containing the calibration data
> +      nvmem-cell-names:
> +        items:
> +          - const: trim
> +    required:
> +      - reg
> +    unevaluatedProperties: false
> +
>  properties:
>    compatible:
>      enum:
> @@ -51,6 +68,12 @@ properties:
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
> @@ -80,6 +103,47 @@ required:
>    - clock-names
>    - resets
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-tsadc
> +    then:
> +      properties:
> +        nvmem-cells:
> +          items:
> +            - description: cell handle to where the trim's base temperature is stored
> +            - description:
> +                cell handle to where the trim's tenths of Celsius base value is stored
> +        nvmem-cell-names:
> +          items:
> +            - const: trim_base
> +            - const: trim_base_frac

Define all properties at the top-level and then restrict their presence 
in the if/then schema.

> +        cpu@0:
> +          $ref: "#/definitions/channel"
> +        gpu@1:
> +          $ref: "#/definitions/channel"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-tsadc
> +    then:
> +      properties:
> +        soc@0:
> +          $ref: "#/definitions/channel"
> +        bigcores@1:
> +          $ref: "#/definitions/channel"
> +        littlecores@2:
> +          $ref: "#/definitions/channel"
> +        ddr@3:
> +          $ref: "#/definitions/channel"
> +        npu@4:
> +          $ref: "#/definitions/channel"
> +        gpu@5:
> +          $ref: "#/definitions/channel"
> +
>  unevaluatedProperties: false
>  
>  examples:
> 
> -- 
> 2.48.1
> 


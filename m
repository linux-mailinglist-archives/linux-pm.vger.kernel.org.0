Return-Path: <linux-pm+bounces-8266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5738D221A
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0A4B23B38
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816F17333D;
	Tue, 28 May 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E75jmGRU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AA17332A;
	Tue, 28 May 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915601; cv=none; b=m3eeAQ06rn4NiHgKYjrDZldlxieCCfSVMyQpvnrpLm3QW8X8/xkytSJpKRvgRBUEAEnSPdUpCxloqMkIWtWcGqj4k4z4+T3of1CmfI2PRy1ZhTSLax0Cu/S45+E18Aox553+WX/H7vhvrJG0zcWte4LP5VOpHh2+zFeEqw3pADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915601; c=relaxed/simple;
	bh=cl5YyYDBd5xfT01EGmw60ns+GsJMKd9t1oo64zhr9Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZWaWgas+UNMT36yXkyLX59uC3tGb+YeHLY6C8MAm9vDGLbmGULdEXp+f4qQj9DAuXMVfxLypFJASO3NzBByXwjTefNhvPynF5EU2KSSSoa3PLibkUgi1O+nnNesxsm7w+8okGguXVOh0T33zT2E7V4s2OfpxD1czf16nzpvRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E75jmGRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D2EC3277B;
	Tue, 28 May 2024 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716915601;
	bh=cl5YyYDBd5xfT01EGmw60ns+GsJMKd9t1oo64zhr9Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E75jmGRUjy1cXvhLZt6hKwcV9juKJTgLIB7e6c4wWG4E1M+/E2w7jmzGSGw80kAst
	 0mAVFXDu95Q5OnXVDyUs2I8vwj3f9A80MufHZQrfr8dUpRYEzGl95cfbu6W9Wf8TFb
	 Lx3AECbVB7Jc/nlIFWFYEFCBJmMVTqXe8d/wFuFbbVqRPGx3tGWJvcJzdfPGYW7FEg
	 VFTnpygSkBBYpHUuzpIhIiwBQirPb0EeoEBCRYkH6S7DWSjr7WFfMGYLCmS6g/J/8C
	 7PFwFROXItNXGJEo7XW52HWvPWIR6ROhJnUbyCg3arbP5nz5kxTJsetOkH+6b6wHDn
	 sTftttWP65ZHQ==
Date: Tue, 28 May 2024 12:00:00 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Bailon <abailon@baylibre.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: Add a property to select
 the aggregation type
Message-ID: <20240528170000.GA903992-robh@kernel.org>
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-5-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524143150.610949-5-abailon@baylibre.com>

On Fri, May 24, 2024 at 04:31:48PM +0200, Alexandre Bailon wrote:
> This adds a new property named "aggregation" that could be used to
> select the aggregation type when there are multiple sensors assigned
> to a thermal zone.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index fa7a72e2ba44..e6e4b46773e3 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -111,6 +111,14 @@ patternProperties:
>            coefficients are ordered and are matched with sensors by means of the
>            sensor ID. Additional coefficients are interpreted as constant offset.
>  
> +      aggregation:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - avg
> +          - max
> +        description:
> +          Aggregation type to use compute a temperature from multiple sensors.

This is optional, so what's the default? I suppose you could make it 
required if more than 1 sensor.

A boolean could work here as well unless you think there might be a 3rd 
algorithm.

> +
>        sustainable-power:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description:
> -- 
> 2.44.1
> 


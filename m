Return-Path: <linux-pm+bounces-26938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C569AAB147A
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A6016C14C
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1DC29186E;
	Fri,  9 May 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="uQ5AqAXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BC291176
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796340; cv=none; b=hJCAdLVIBD6JgLcUAOtKdZtE/5cNOxWC4wypLlBb72PjDRwZv6cC2nLRh7ImwzFjX6YzNINU0JkhN778YkWr1OnyAA+GCE0V9E7eFbD6LtTzKR6ttcIHvrfzODmVhkTXczq85KUnE4rqsGzDO0uVTMN757HFf/VfAtloSyvBxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796340; c=relaxed/simple;
	bh=ycTXrwCf5dD7v25Dchh11ii5tZH9UbpA8WEp96qqcN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1qQ77PL+UTlfALavpTaayDbTKwTgXlMcY+KiPRUqppEUwYxqQsef3HioJRY49Ce0TA1xGt+IphrCx1FLsKnhAVGzmF0AEWgpb5HgYE2ZjuUTICtjRm4Lx2ZCAitq6nhNehUpXtp4Q4/FSUGZN2NX9rPH6CkZ+8/fuLpY8uW59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=uQ5AqAXF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746796336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlt61GqgvUxq8BPErozdvm0ae/X6SagRe6G13VwOLvM=;
	b=uQ5AqAXFVcmHUb0x+rThTA1wu5GMLar705S4fEHg1OWaqDIn856HhShJkRTS/7xYF/H4uj
	FhOOVgXecAgyMVzJGuz54etH4wDaqgWm7dk8ufkJCbswdg8rMSE0QHhRoChDars1v1X6hK
	r7944Dg7mqTEUUV5vA6whCm1ZerKoR7WI4Wlggw5VoJmBMAOIPAzW0LeiNcziVgEnAVeQX
	+JnYZMrwxbPmeNKCgl0KEOszta9ePIn6Grb6uUXi+irvy2ag+72+YLPcGa9lP+iUk1kps4
	sU/JfEVcgiqlzlAmOEPYXZ4pQ1P5qFeuS6fBHfCbb554nNnOn4ldn2bTrx3e9A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: gpio: Add Apple Mac SMC GPIO block
Message-ID: <aB3_Kw6WDaDAY6Ub@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , May 03, 2025 at 10:06:48AM +0000, Sven Peter via B4 Relay a écrit :
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Add the DT binding for the Apple Mac System Management Controller GPIOs.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../devicetree/bindings/gpio/apple,smc-gpio.yaml   | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..07305eeb2595f59d5c28f6e507295b828dafd4a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/apple,smc-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Mac System Management Controller GPIO
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description:
> +  Apple Mac System Management Controller GPIO block.
> +
> +properties:
> +  compatible:
> +    const: apple,smc-gpio
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio {
> +        compatible = "apple,smc-gpio";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70d79a5f6ae98fc0055f1da20dbecc095ea5c65..7f91f0225133490607ba0d79ad4225892ef31a66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2267,6 +2267,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
>  F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>  F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
> +F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
>  F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
> 
> -- 
> 2.34.1
> 
> 


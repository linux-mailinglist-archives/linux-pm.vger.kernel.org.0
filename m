Return-Path: <linux-pm+bounces-18601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7E49E4EE0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E902F165331
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913701C2323;
	Thu,  5 Dec 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMm/sAIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F481BF7E8;
	Thu,  5 Dec 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384921; cv=none; b=DntzKEdoPu0fPZAqTBVaraloCanJeQOcbH2ftMBItQAks4Ig6udWWtAOltjEZtrYJ2M07rrphas1GXSJnWRxRMM2e6/X+3jfPLnOwVjuYP+W/R6sJH79MYvrT7NOZGHWhoC9sOQ/cBjDNf4MZoCy7PkfsUfsIwAuWXzixypVXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384921; c=relaxed/simple;
	bh=bSj37bmt7ADxZheK3OHEPhQVUUID4mtcZsHj93X0KKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYmEXEWWYygPIZgBZ2DU5qjDO8WeG17JkJAm7mDhYhgS4yYVZEBe080VxlmhCi5QOx2eUWp9F6zjZXKL8+IV9HIzOnqUvPjCCAALTVsxg45jXK6/W8IKawXUcNFR7c6M9Pvkqxsdiq8vW54Lc6uYRyPR3XPaBxkiXh3wPcwKoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMm/sAIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E75BC4CEDE;
	Thu,  5 Dec 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733384920;
	bh=bSj37bmt7ADxZheK3OHEPhQVUUID4mtcZsHj93X0KKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMm/sAIA2nn1qVkJJcLGnmqW5ViC4WlDFo/xtfN5/wDNCbI3LNES25lEC4V8VUq2b
	 PzP+vecfeEsFKt0zg44BPbgmeUhB/44vgdgtKANZ2KaiJPucONJwXEANgIbQwljg+b
	 eET5f9KosB128PDpIvrVv3Qdu3pS7Zmh6Z4AwLvAxUOXZZGIQDfNfRtQ+RqXUJqRX/
	 EZaY8goZhAD8QDF/dY5H0sWtIj3B9fOoAUOn3GhGah7DyIdBI71uHO9ZNGmSM8RcKH
	 9NhKZ5dDtuqXyojYHINlbkQkKlO2H5RZPkyd/hC7z5Q9LkmsZgz5y1OTNLXJe6uPdP
	 dn+0EbxirIM9A==
Date: Thu, 5 Dec 2024 08:48:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v10 3/8] dt-bindings: mfd: add maxim,max77705
Message-ID: <hjrxt3qkzzpda2uqazdse3h263ixb4onezyij4xcgezpaaihqk@ijln25sdyzfr>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
 <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com>

On Wed, Dec 04, 2024 at 11:09:53PM +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 binding.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v10:
> - leds: replace label with color and function properties
> - leds: add support for leds-class-multicolor
> - move fuelgauge node to patternProperties "^fuel-gauge@[0-9a-f]+$"
>   to comply with max17042 binding

You silently added significant change - new address to fuel-gauge.

> 
> Changes in v9:
> - replace max77705 fuel gauge with max17042
> - remove monitored battery because not supported by max17042
> 
> Changes in v8:
> - fix leds compatible
> 
> Changes in v6:
> - unevaluatedProperties must be false
> - drop excessive sentence from description,
>   just describe the device
> - change leds compatible to maxim,max77705-rgb

Your changelog should mention you added review here.

> 
> Changes in v5:
> - formatting changes
> - add unevaluatedProperties: false for nodes referencing
>   common schemas
> - remove additionalProperties on nodes with
>   unevaluatedProperties: false
> - add min and max to led index
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                               |   1 +
>  2 files changed, 193 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> new file mode 100644
> index 000000000000..1bc026a01337
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> @@ -0,0 +1,192 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  The Maxim MAX77705 is a Companion Power Management and Type-C
> +  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> +  Type-C management IC.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Nope, none of children are supposed to have addresses. All nodes are
unit-less.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

...

> +    properties:
> +      compatible:
> +        const: maxim,max77705-rgb
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      multi-led:
> +        type: object
> +        $ref: /schemas/leds/leds-class-multicolor.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          "#address-cells":
> +            const: 1
> +
> +          "#size-cells":
> +            const: 0
> +
> +        patternProperties:
> +          "^led@[0-3]$":
> +            type: object
> +            $ref: /schemas/leds/common.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1
> +
> +            required:
> +              - reg
> +
> +    required:
> +      - compatible
> +
> +patternProperties:
> +  "^fuel-gauge@[0-9a-f]+$":


How unit address appeared here? It was absolutely never reviewed. This
is significant change, so drop the review tag.

It's also a no, drop unit address.

Best regards,
Krzysztof



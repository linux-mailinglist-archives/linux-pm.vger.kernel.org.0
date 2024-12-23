Return-Path: <linux-pm+bounces-19702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6379FB0EA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 16:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E211663B5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518E1AF0AF;
	Mon, 23 Dec 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ndOx/g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E07E76D;
	Mon, 23 Dec 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969176; cv=none; b=V2ZdFcqjhvKFjuZmrjjN/BFPOJbuHiXUH5Z/P3+FvgjxLjfWI8Psz6wQD1fimQWbe/FS6NH+U2v6jz677p1Z1x7IyhDZRK591D9/g2zmee4J/fMS0md6OHfMnHb51tQ99qM+HqYXY7aThUyyu0RwWceeGuwIiJSqkjlFGYkZDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969176; c=relaxed/simple;
	bh=b/GFZM18ZU1dAUY7YW7S8EMtl7LIXJsyC1nGW9dUh8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY0BEbCssNjOzIm0TXujZWxYvsZtqd4GyVKxUHXUSQRWUxHKXEAbIwk89Df9J8uxwEDOZC/gHhaOBj+aXNoAxz1h2IWyrQ6fzZyEXHlAc2bRKKNWWRuOucHp/V0xDMnocFIVk5ZCvcR+Fw2q2Wny3X0FYq+qtpbVWqXJ5Om94Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ndOx/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C03BC4CED4;
	Mon, 23 Dec 2024 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734969176;
	bh=b/GFZM18ZU1dAUY7YW7S8EMtl7LIXJsyC1nGW9dUh8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6ndOx/gwp0rvhSCi6bDDwo6Xp0TodCOWuINaBOxPqqUtnN2OMQiebxtY46DrKUo6
	 I16IhT6Ls/RiSSM+N0XhMSbZVlG8CnFNHnuKGkNIHHVHzvwSLTJEESNKkwyWxu4bzI
	 kORzsgGUv2pptdb/sSuI3/woXxBHsuX3JDkGJOMmZJnCAlM2n3n5qeWb+l5C6MEkLf
	 M5NSXwdh+7wrxfc/uYh685rZm6LC+AuXYxH/M1hSG2Z+FFuoPhAKyl/++QBppA/ceW
	 95jqvgzgd1u1ohEr0wNw8a2XnOXnLItSpDH7o02gF/eKdQLDThT6g0B5UxYdmVWhzb
	 WhyPhcWmyisqg==
Date: Mon, 23 Dec 2024 16:52:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v13 04/10] dt-bindings: mfd: add maxim,max77705
Message-ID: <olmxsr65fdrf7pphcqzjtrrayzfkt7zl4merqz2fkjpu75uqfx@362mo7yd6pcv>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
 <20241223-starqltechn_integration_upstream-v13-4-fbc610c70832@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-4-fbc610c70832@gmail.com>

On Mon, Dec 23, 2024 at 04:59:41PM +0300, Dzmitry Sankouski wrote:
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77705.
> +
> +  Maxim MAX77705 is a Companion Power Management and Type-C
> +  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> +  Type-C management.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705
> +
> +  "#address-cells":
> +    const: 1

Drop property

> +
> +  "#size-cells":

Drop

> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  haptic:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: maxim,max77705-haptic
> +
> +      haptic-supply: true
> +
> +      pwms:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - haptic-supply
> +      - pwms
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Up to 4 LED channels supported.
> +
> +    patternProperties:
> +      "^led@[0-3]$":

0-2? 1-3? Preferred is the first, because we index unit addresses from
0.

Please move "patternProperties" after the "properties:" block.
Compatible should be the first thing visible to the reader.

> +        type: object
> +        $ref: /schemas/leds/common.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +
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

Same - 0-2


> +            type: object
> +            $ref: /schemas/leds/common.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-34611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16FB56D41
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 02:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83123A4F31
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE117BEBF;
	Mon, 15 Sep 2025 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6OOs+Zo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CFDF49;
	Mon, 15 Sep 2025 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895661; cv=none; b=XQdTvAZ7PBoCVNTv9IVq+SRBapvBbiSRFRTwDcktFHeBg7uHYdEvmk+gFbI62AQilfTHraG7fVofa/ncgnRwhxN+7Ge400Et0QJ07B1uuqDkujUL/QyzU3VtN1w2dF3/IPplbTXJNnV80Vt+4hsPBriIUfvhXdq906N+1vXBhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895661; c=relaxed/simple;
	bh=jIKHdqElknDnPTieRU6zG8Uq19qV/zonRqCxBWTWitE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqRe+EuDibhRcrRvEUGIUYxfm7lancgZHD7yueIZDyjB3eSZuxagcRs3bZwzYGzdeBAb8B3sAgFWpYAWX0exk3T2SKy67wr2kJIP6wmqbiN2zeRX6sfvxocR0BZMK+nwkKo9djnea1ba/JJVSsF8DG3KdObuC7YR9S1HDpOQhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6OOs+Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98F0C4CEF0;
	Mon, 15 Sep 2025 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757895660;
	bh=jIKHdqElknDnPTieRU6zG8Uq19qV/zonRqCxBWTWitE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6OOs+Zo/WJvM6d6bPGrcarVIPqo05utsZL+1nJT3L4z/CQkMijenUq294d7SDjJJ
	 n58ow0SYNdrLe/6MtNUZboGBYNQXDZ5CKUrklbhqItdrpqf6fhz/9yJPX3iv+yhW93
	 iKwZvBBGxP2usDJ4efxIftIPBi7XELzXpi95tHDZefVia+Tm/sMAXqBzCtoi+JeKGU
	 XmqwQsbm2CCUS6FCU/LxvcjKmsCjwXVr35y6MehwRgskVoOkpsIV0KBEeisB8uaNlN
	 xiQcJybxjgJM9LWKOKugrckBQdk6Hf0zrbbaClPUtn64eu/sX7zxJbhlHdf6LmHy2U
	 aFowKv4VKbDIg==
Date: Sun, 14 Sep 2025 19:21:00 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: claudiu.beznea@tuxon.dev, sre@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: reset: atmel,sama5d2-shdwc: add
 lpm binding
Message-ID: <20250915002100.GA2297583-robh@kernel.org>
References: <cover.1757519351.git.Ryan.Wanner@microchip.com>
 <71c7d25f64612ca9571aa544be8f2651be8fe33e.1757519351.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c7d25f64612ca9571aa544be8f2651be8fe33e.1757519351.git.Ryan.Wanner@microchip.com>

On Wed, Sep 10, 2025 at 09:20:36AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
> 
> Add microchip,lpm-connection binding which allows to specify the devices
> the SHDWC's LPM pin is connected.

What is LPM? It's not defined anywhere in this patch.

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> [ryan.wanner@microchip.com: Add sam9x7-shdwc SoC to properties check]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../power/reset/atmel,sama5d2-shdwc.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
> index 9c34249b2d6d..b1a8ccd0873d 100644
> --- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
> @@ -56,6 +56,10 @@ properties:
>      description: enable real-time timer wake-up
>      type: boolean
>  
> +  microchip,lpm-connection:
> +    description: list of phandles to devices which are connected to SHDWC's LPM pin
> +    $ref: /schemas/types.yaml#/definitions/phandle

This only allows 1 phandle.

> +
>  patternProperties:
>    "^input@[0-15]$":
>      description:
> @@ -96,6 +100,18 @@ allOf:
>        properties:
>          atmel,wakeup-rtt-timer: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d2-shdwc
> +              - microchip,sam9x60-shdwc
> +              - microchip,sam9x7-shdwc
> +    then:
> +      properties:
> +        microchip,lpm-connection: false
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.43.0
> 


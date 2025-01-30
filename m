Return-Path: <linux-pm+bounces-21165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3DA23817
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31666163E1E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F501C1AD4;
	Thu, 30 Jan 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpRyInyd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4D1898FB;
	Thu, 30 Jan 2025 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738281070; cv=none; b=pe7PyjdELXKG5TIG4pCD0/njQmv0MxiBDKGjmW7nuj9LOA0yQzkyHjiH3zQFNdxvYzooS0HC9vwJC5eDgAfC8iRcLmfgn/bL+5mhcy2Tpbt7CVeTZ+PojNpCw4II2PcgDa95QGc2cifwTIIu6H5KjnETcTc9XyfwlUZIFeX4f2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738281070; c=relaxed/simple;
	bh=CXkPOjcny3vetfrWYsxwyCNypUJvo8NXQtKAtso3d9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVSXT0Ke60NexJiXX0fBJ0A3XCqkslx/4BUhDuSPV8RSNqIypZ05Q22DGZPUug4NjOqHK+4cgIoHHVxM3+eR4FrzkjEiat/HwtmfF6UhLN8Q6cVNT4bFuRMnP3RTkVehUFy59T70Tlf/4HpJBHLWUsr5dr4+1XyEGO0JmcGQ38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpRyInyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047F6C4CED2;
	Thu, 30 Jan 2025 23:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738281069;
	bh=CXkPOjcny3vetfrWYsxwyCNypUJvo8NXQtKAtso3d9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpRyInydaL6BItpyZo9f6LIndF0jEQC1eBbQoOhqQQ6YCIwhO+FNm+BpTrt2IWoeA
	 kmp7qtIV8V5HCHbJ+VthUU21TTnymeXdqqd8DKpFA/G78Lm8h+AEc5dOgcdD3U+k3P
	 ji36Kr4aM6eEX4EGTiTH7Ajskja5LK3zJwirY7rJDDhyEVqGfp+Bdmy4QGVv2opYBk
	 SEgkzTy5YvU1TgqujPhYhd87eiElDS1q1DWH4adVhDBwr+DdWgoBupDB0JIsRkhTvo
	 fjfSp5riCTismgJXk5dUAblbU9E3YI0JY3Y55xJP/i+iuaxGw11M4Ag1EzNgPqqUue
	 TN22vbc2Z7GqQ==
Date: Thu, 30 Jan 2025 17:51:08 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.beznea@tuxon.dev, sre@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 08/16] dt-bindings: at91rm9260-rtt: add
 microchip,sama7d65-rtt
Message-ID: <20250130235108.GA1889615-robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <f5642fad5d7a97772ae22c76840c5c51ee79ec0f.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5642fad5d7a97772ae22c76840c5c51ee79ec0f.1738257860.git.Ryan.Wanner@microchip.com>

On Thu, Jan 30, 2025 at 10:33:48AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTT compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index a7f6c1d1a08ab..078b753f453b4 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -23,6 +23,11 @@ properties:
>                - microchip,sam9x60-rtt
>                - microchip,sam9x7-rtt
>            - const: atmel,at91sam9260-rtt
> +      - items:
> +          - enum:
> +              - microchip,sama7d65-rtt
> +          - const: microchip,sama7g5-rtt
> +          - const: atmel,at91sam9260-rtt

Does being compatible with 7g5 provide something over 9260? If not, 
probably better to just have 9260 as the only fallback.

>        - items:
>            - const: microchip,sama7g5-rtt
>            - const: microchip,sam9x60-rtt
> -- 
> 2.43.0
> 


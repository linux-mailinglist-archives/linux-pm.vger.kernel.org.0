Return-Path: <linux-pm+bounces-21164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2CA23806
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CECF1887EF5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618B1F236A;
	Thu, 30 Jan 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKD2DAFE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B851537C6;
	Thu, 30 Jan 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280586; cv=none; b=EhoPQINglNa5tQO7o8UKtuSdMAa79IhfqR2baxv/hAGrz427GeUkV402lQRRW0odXXe2kt5cMmX1xroOGMCw4CXmyOL4eARDKuhnNjkIXllWdpuwyjeYPkfjaBMF686amFpMIbaVN+rQm3YrdX2FIglpsCqZRSRszxm7wbNmwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280586; c=relaxed/simple;
	bh=kGamlnZuXM/luZYB3EXKEGCyON9TbAXiQo4Ki9RcCIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdNsbDm3HgvBL/XPJFo4IdOJCAT4iGyhcfp5sW63RknP5StEmhuKLLz8sfJ7N56FnJFErXTCxwrbjkjXJxTafz4ivvPG0APMYzy21cXHYcu6EmRFBZLXbMTC/txdJ93w/U6TowrrSopvOa+FduXeF0RpStTleIhbqWHW8OagDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKD2DAFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9C9C4CED2;
	Thu, 30 Jan 2025 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280586;
	bh=kGamlnZuXM/luZYB3EXKEGCyON9TbAXiQo4Ki9RcCIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKD2DAFEHSWmHOxoRZxHSvYGppN4hzv+Kx/waC17L8ORp8M3GS4bjMeTUwa7RJy8E
	 OJ3oNxubfspnI7VFe7H8Fqi8ykSk0sxQ52TRtg1uLuq6oB4vywRMULCNpYDPQquQrf
	 Podu6TF8HqqQvCMhaw6+ex0DKR3HPjfxTaI39qZmkOXTR2yJRwBgfgwwpMRKYBYjxx
	 CHHiBnF3Dlda+nj3UsQo03o6Ps6vF+ZdCYQkPujPGLvngm4D6O4YYdu82208F7jZe7
	 9ODqDwKHqBoapfxrHwSb779mgHCK53ZxiuG6Kwf6D+qvKyNLy1KdxaWmQu85tpNENC
	 5HXcRsFKyvgrg==
Date: Thu, 30 Jan 2025 17:43:05 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.beznea@tuxon.dev, sre@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 06/16] dt-bindings: rtc: at91rm9200: Reorganize
 compatible items
Message-ID: <20250130234305.GA1887365-robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <2846391c5ffab332ad7a4b65aa60aac9c49a3496.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2846391c5ffab332ad7a4b65aa60aac9c49a3496.1738257860.git.Ryan.Wanner@microchip.com>

On Thu, Jan 30, 2025 at 10:33:46AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Reorganize compatible to allow more devices to be added to this enum.

This is doing more than reorganizing. It is changing the binding. Now 
7g5 is compatible with 9x60?

> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> index c8bb2eef442dd..30d87b74c51dc 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> @@ -21,9 +21,10 @@ properties:
>            - atmel,sama5d4-rtc
>            - atmel,sama5d2-rtc
>            - microchip,sam9x60-rtc
> -          - microchip,sama7g5-rtc
>        - items:
> -          - const: microchip,sam9x7-rtc
> +          - enum:
> +              - microchip,sama7g5-rtc
> +              - microchip,sam9x7-rtc
>            - const: microchip,sam9x60-rtc
>  
>    reg:
> -- 
> 2.43.0
> 


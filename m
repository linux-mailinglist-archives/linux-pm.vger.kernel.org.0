Return-Path: <linux-pm+bounces-24551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BDAA72B06
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A8417395D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671F1FF7DB;
	Thu, 27 Mar 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtWAvwZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973463A1BA;
	Thu, 27 Mar 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743062768; cv=none; b=glA0SyiNSUa+v0TTRuK/jAyYUVxEQre65XDYZXqg/Ynkoa3zWFBsSDyrGUAzZS398Q/EkrfR6POpr1vTr6DQp2Y0lj6ODtZZS2aGZpU2D/bKz+cf99ardl6NLPsOuKzZmE+9e1Zxt0OQmLLiCym3C6pFVOIAUxStuXikDYBDrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743062768; c=relaxed/simple;
	bh=B7XsPMUikiiUOfex4giQRc56miOT8KNuSiIxK6PkfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQhcfwS0nL3FdyNiNVSPZ29C2LBq47AN1vFs5gPyccnTAolKHdxIl3d4kSR1RxjOlaj8taVfX9phQnFLO5F9ILHUWarw3w4a6YqGc0xgyDfga4HfJeiVL4VStxRkkVuICQygG7zIXQVjhQtIh6p3J4My5Q3GneFRFUNQvE8NVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtWAvwZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7075DC4CEDD;
	Thu, 27 Mar 2025 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743062768;
	bh=B7XsPMUikiiUOfex4giQRc56miOT8KNuSiIxK6PkfJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtWAvwZ+rVqCvVzCQuIzPIUU+/jhNYMXjCW/Blkl3htiOXOSSTVOdlao0pyRG66SO
	 5hMvSMLo1Tcnn6VnENmX0Xmlip/o4wqIplf8XRp9iyhVn84cF3JC10FztXAUOoXDUA
	 2ZLtaa6+tm60K0tada+x8TddPNA5FboWFkADT5+H+EHmqEzuJkpeTFnpXCzyyV45BT
	 bO3+o8IF00cNju+ZjfqcFmBGevVXhKeTj2aXyevPyte/ZqAcyxSRpnoq+POsmh2Ng1
	 SEZfpp3WOnWrUPCf1mrrI4Y2xd/Ua/p5W0c3J89JEF6Z2to4BskT113b5bvwJLdo9a
	 IXmgE3fmWSlwQ==
Date: Thu, 27 Mar 2025 09:06:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 06/11] dt-bindings: mfd: atmel: Add
 microchip,sama7d65-gpbr
Message-ID: <20250327-muscular-antique-caterpillar-6be7ad@krzk-bin>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
 <57a9f2ef94005bc7bb450fe073fb594fe7d5c2e1.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57a9f2ef94005bc7bb450fe073fb594fe7d5c2e1.1742936082.git.Ryan.Wanner@microchip.com>

On Wed, Mar 26, 2025 at 08:35:39AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
>  Add SAMA7D65 GPBR compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml          | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



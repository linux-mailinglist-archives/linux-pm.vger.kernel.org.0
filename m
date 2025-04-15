Return-Path: <linux-pm+bounces-25434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44EA895E0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DBD189985D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC327B50A;
	Tue, 15 Apr 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNzdiH6/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53527B4FD;
	Tue, 15 Apr 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703977; cv=none; b=BrxF3Eiw2hVBx/4yh267hfFn3CBglx+MYIFSm+e6Sv8cGEGHisuB+F4Y80lV1Uhvh9VZ9TuBfRA7tQy1+s50TEdXo/ER4o1H0c+/qWM22uCYX5aw1BLc8Y34VquuTdfT3Nq41yOGhJWlu+bAnK0zoD2HRL8Tfn5M2gyLIT7uEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703977; c=relaxed/simple;
	bh=apFQ66fRd9xJJsmDFT4fBVyQEd5Nz16mGiKFnHmC7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcWYTsR37SCRxN0mu4w+KNCxpGHqbFgIErdmAVNGbAYLZ4M1AGYmTZu9tDsnUxgawMcy/j9SjPe7p8N55IHCwQj4vkL4VNtL4FuqFavKFkbw6ehJ0aXRzgukxl/vS9NhwQUiZ9o5edo0S0rTWMrLU++dv4loJZAYnJL28ktUwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNzdiH6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B91EC4AF09;
	Tue, 15 Apr 2025 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744703976;
	bh=apFQ66fRd9xJJsmDFT4fBVyQEd5Nz16mGiKFnHmC7co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNzdiH6/EXzWt2LSkm++qPQ5Fi1SmCx/QCDtAtqoxR+0chB6LuqksMS20c/Jc05ND
	 /VIq5F9XibAyFdR50Tk1e4C5vLAE5WqtxCsOvMybpqLNUgjei4jBKgl8hYVIFkRXGl
	 MQpd4WkZhZ7XBeKzr+ImQUKcnOz68m0Exe0L3y5CLzrDfF0msE6Scpb3Dm2kRwasgk
	 +oB0XfNDTk3DipE8933EZD2sk9WODydfZEt6cZMyS5gO+b4Y9Qe+IshU3bLvk463IF
	 ufYm+YoVTKMvwjE+pnRLrKq6RFvrq9mxSRl90+BKFpb1F5C4PE6wHpgHOMi2axBvgB
	 A+34xcNp8Gc/g==
Date: Tue, 15 Apr 2025 09:59:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 02/11] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 Add microchip,sama7d65-shdwc
Message-ID: <20250415-wise-uptight-earwig-31ceca@shite>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
 <24666308604d3eb9f2b8c64d4a466c6fd77120e9.1744666011.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24666308604d3eb9f2b8c64d4a466c6fd77120e9.1744666011.git.Ryan.Wanner@microchip.com>

On Mon, Apr 14, 2025 at 02:41:19PM GMT, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SHDWC compatible to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

You are sending patches which are already applied.

Best regards,
Krzysztof



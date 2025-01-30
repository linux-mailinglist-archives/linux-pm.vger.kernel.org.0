Return-Path: <linux-pm+bounces-21162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B870FA237EF
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB757A23F6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE831F1909;
	Thu, 30 Jan 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtYRywdY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7481F1532;
	Thu, 30 Jan 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280123; cv=none; b=WjK1JcMTReGxsvXcii7OtJj2w4NjUp9a8XSu0457umRWvVOEuTY2Lqva+L8Bpw6wgqrc7Sbuvk99yZ0mJkzjoO9VHh3N909JPOK1Bwh3i+0g5twndWUaotuxI0+o8gX8ESnrlnPUFPH5TS0VXpG34SpWskYYEnxDPGztrcn+Ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280123; c=relaxed/simple;
	bh=3E5QKtM+Za2/lQug8LrWo+EqRDLiLeUrMZcuzmk/oKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVA0Zs1vcklpjCZGhuikFiIu5boi6yPE8ef9hIZyi/G/w4zaf9c8YHb4RpZOdoj1RUTiqaqc3YKMAg20KqYp6zf0IHHqm59qCm2erXikmGU2XeEVhtH3Rd7MCR41OF6nmU8ohbZYDr5+NBnJhgcBjvjXhzl+MhAzuGkCkehu15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtYRywdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F24C4CED2;
	Thu, 30 Jan 2025 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280123;
	bh=3E5QKtM+Za2/lQug8LrWo+EqRDLiLeUrMZcuzmk/oKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtYRywdYWsSNpJXaWTG8mUAvAOiBRUx93VNLI7UhuOEPBzvVZnDMm475DF9mjW3ib
	 PyHWO5ZpDXAI9ahc6UEdd7dKqqXhHENDgJxBrPbdiaBAzijIuj7DRNXlUJZTN52DwQ
	 1vs1L83cmukeS7DePIZjgLWlw0z/uG7tVUWrEu5R01c4+N7Fg2RL/1NIFEkAGVWIW3
	 Ly4okGK74T8CdAZXEoGMGOPLWW1Eyj/ksdGqBdhHm7/Ntg1MYVBpLetqGUC4AWXATW
	 YAlnLvt7m09keEzGJyD9MO19FMV8jJKcbv+ESVnVHo2YZG47IKv++dkMx/xck/t6Ly
	 WZupjL6WsE+vQ==
Date: Thu, 30 Jan 2025 17:35:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org, linux-pm@vger.kernel.org,
	nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, lee@kernel.org,
	claudiu.beznea@tuxon.dev, alexandre.belloni@bootlin.com,
	linux@armlinux.org.uk, krzk+dt@kernel.org, sre@kernel.org,
	p.zabel@pengutronix.de
Subject: Re: [PATCH 04/16] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 Add microchip,sama7d65-shdwc
Message-ID: <173828012142.1872155.6486603054756934476.robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <1e04bd9b667d2831be3c7f6dc6f3d23f07a7d8e6.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e04bd9b667d2831be3c7f6dc6f3d23f07a7d8e6.1738257860.git.Ryan.Wanner@microchip.com>


On Thu, 30 Jan 2025 10:33:44 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SHDWC compatible to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



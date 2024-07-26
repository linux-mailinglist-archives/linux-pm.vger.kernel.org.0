Return-Path: <linux-pm+bounces-11463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527793DA3F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007C81F245BF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF4149E16;
	Fri, 26 Jul 2024 21:42:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6911C83;
	Fri, 26 Jul 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030164; cv=none; b=uSA7pbfD1qFQ6I3JcsTUW/GIaYvu2BDXedkGqeSkPCnPMaED+ZoVOQaHTy0fimRgS8Trl8UgW7jA/NN3fyvRTRH1+Sfbbd9bu3OERneBcgr3a62SpNqHgpcQzjm7QkmuJ4xxKHn+OYbAd54dgfu0AhzRYSux9fAlNJviX7Y7t7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030164; c=relaxed/simple;
	bh=hr3UHgo089N1m2yRD5I8C8JXQOzE4pkrHTHPGkRb8OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaIIwAZ8pnIn/jlHZ7ZVYERwaByKhrnPJLKwMOywiBkF2SPpKL6A9vQ/bWVKrMEOPlC0Thk7aV4MTejQsg/VUq8YnfGlTwo7Zq5RWYSMLGzQlFvaCbqtcrCsLhvztoZM83rPPS1UrdBaVNiiOPuoq+hcLugmq7h6L2teBw8phTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cde.versanet.de ([94.134.12.222] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sXShq-00063F-Ml; Fri, 26 Jul 2024 23:42:30 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, jagan@edgeble.ai,
 andyshrk@163.com, jonas@kwiboo.se, sre@kernel.org, t.schramm@manjaro.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Pull up sdio pins on RK3588
Date: Fri, 26 Jul 2024 23:42:28 +0200
Message-ID: <5127387.e8TTKsaY2g@diego>
In-Reply-To: <20240726194948.109326-4-macroalpha82@gmail.com>
References:
 <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 26. Juli 2024, 21:49:46 CEST schrieb Chris Morgan:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> When using an Ampak derived bcm43456 on an RK3588s based GameForce Ace
> the WiFi failed to work properly until I set the SDIO pins from
> pull-none to pull-up. This matches the vendor kernel located at [1].
> I tested this then on an RK3588s based Indiedroid Nova and did not
> observe any adverse effects.
> 
> [1] https://github.com/rockchip-linux/kernel/commit/b96485b7af46a99c14f3c4818eb18c7836eb809c

As you're essentially duplicating the change by Alex Zhao it might be
nice to keep their authorship?

So, "From" + first Signed-off from Alex, then you add a
[adapted to pinctrl filename change]
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

below that.

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> index 30db12c4fc82..d1368418502a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> @@ -2449,15 +2449,15 @@ sdiom1_pins: sdiom1-pins {
>  				/* sdio_clk_m1 */
>  				<3 RK_PA5 2 &pcfg_pull_none>,
>  				/* sdio_cmd_m1 */
> -				<3 RK_PA4 2 &pcfg_pull_none>,
> +				<3 RK_PA4 2 &pcfg_pull_up>,
>  				/* sdio_d0_m1 */
> -				<3 RK_PA0 2 &pcfg_pull_none>,
> +				<3 RK_PA0 2 &pcfg_pull_up>,
>  				/* sdio_d1_m1 */
> -				<3 RK_PA1 2 &pcfg_pull_none>,
> +				<3 RK_PA1 2 &pcfg_pull_up>,
>  				/* sdio_d2_m1 */
> -				<3 RK_PA2 2 &pcfg_pull_none>,
> +				<3 RK_PA2 2 &pcfg_pull_up>,
>  				/* sdio_d3_m1 */
> -				<3 RK_PA3 2 &pcfg_pull_none>;
> +				<3 RK_PA3 2 &pcfg_pull_up>;
>  		};
>  	};
>  
> 






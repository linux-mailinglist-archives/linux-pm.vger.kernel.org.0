Return-Path: <linux-pm+bounces-16420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7389AF296
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 21:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A71C1C247B0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4EB22B640;
	Thu, 24 Oct 2024 19:22:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636822B64A;
	Thu, 24 Oct 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797770; cv=none; b=Hjd9tCMXpcmrTqSF0f1SZyi+Zy//+eRVLpvLjC5FccX8J4+epXFCyUTE2hFsL5vxzl0yPN/tH1hyD0cghbEKXNoYBySP8x7EsK54ysT9AJkcrkLyK3iiS6rgx40aUxba0I8Wnx1LtDMZKWSRtNWmDFGDWvNseSq5fKSp6snnDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797770; c=relaxed/simple;
	bh=jKh3x40WQHuOT3OY0nTrMeMhafdVjif4nBSUcncQMQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2KQCI1IE8f0ZATsiugIkyn+yW3LTKlkv2Ip4T9pynDyVJRSra9YTmTKy7lq77Jm/MT7l27BGBnvh0AF5Su+nf5+3tQ73nnovqQu26GHsSSEFnRb/SBsDK5eMtk54lY49kdNBBAC2G+jLLNz1R+FPH//8Q6k4ErU/tTYWIt9Xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BC0339;
	Thu, 24 Oct 2024 12:23:16 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E593F528;
	Thu, 24 Oct 2024 12:22:42 -0700 (PDT)
Date: Thu, 24 Oct 2024 20:22:33 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Yangtao
 Li <frank@allwinnertech.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Parthiban <parthiban@linumiz.com>, Linus
 Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Yangtao Li <tiny.windzz@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 06/13] phy: sun4i-usb: add support for A100 USB PHY
Message-ID: <20241024202216.6cded8c4@minigeek.lan>
In-Reply-To: <20241024170540.2721307-7-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
	<20241024170540.2721307-7-masterr3c0rd@epochal.quest>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 14:05:24 -0300
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

Hi,

> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add support for a100's usb phy, which with 2 PHYs.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> [masterr3c0rd@epochal.quest: modified to use quirk flags]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index b0f19e950601..a3942b2ee90b 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -1006,6 +1006,16 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
>  	.phy0_dual_route = true,
>  };
>  
> +static const struct sun4i_usb_phy_cfg sun50i_a100_cfg = {
> +	.num_phys = 2,
> +	.disc_thresh = 3,

This member is never used when .siddq_in_base is true (and yes, this is
wrong for the H616 too), ...

> +	.phyctl_offset = REG_PHYCTL_A33,
> +	.dedicated_clocks = true,
> +	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
> +	.phy0_dual_route = true,
> +	.siddq_in_base = true,

... which makes this whole description identical to the D1 version.
So at the very least we wouldn't this new a100_cfg, but instead just
point to the existing d1_cfg.

> +};
> +
>  static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
>  	.num_phys = 4,
>  	.phyctl_offset = REG_PHYCTL_A33,
> @@ -1040,6 +1050,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun20i-d1-usb-phy", .data = &sun20i_d1_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-usb-phy",
>  	  .data = &sun50i_a64_cfg},
> +	{ .compatible = "allwinner,sun50i-a100-usb-phy", .data = &sun50i_a100_cfg },

And this also brings up the question whether we need a new compatible
string. As it stands now, we could also use:
	compatible = "allwinner,sun50i-a100-usb-phy",
		     "allwinner,sun20i-d1-usb-phy";

and wouldn't need any driver changes at all. Which would have the neat
side effect to make USB work already with v5.18 kernels.

The only downside is the somewhat weird ordering of the compatible
strings, with the much newer chip as the fallback.

What do other people think here?

Cheers,
Andre


>  	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
>  	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
>  	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",



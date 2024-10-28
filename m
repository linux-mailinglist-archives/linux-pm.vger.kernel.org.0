Return-Path: <linux-pm+bounces-16595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E49B363D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9296A1C2520E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2301DB53A;
	Mon, 28 Oct 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="l/wPOq+x"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485662D052;
	Mon, 28 Oct 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132145; cv=none; b=k5UgoXfBnf0C+iUlBVBjwgoz9BP/6baBe051xFoYtIIKztKY3VTHITRLJ2iNUukxRZ201dkdCm1eI045dezVFYSqmEZ9IYpFR5GMVkCH6UPl0VoAuOv5vsPQsUViSB5DU75QkX+WKGlUp+hY+StSp/WCl8A6LCDXjsAlO4GaMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132145; c=relaxed/simple;
	bh=Y5PrnKl+xov67NmWMCJECcieIF0DUv2b3ykYEbx8x5o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KnM5k50P0OWxw2RqcRgqnwPHc0tjtD7lL8tJiqwcGvHjA0tM4VRS+nxM/mB0s/98Nb1uyLaL/UKMEtuQQcD0Sbj059+8uBr8RIa/a8UeUWKK6irZoCuQvhy43YpqAR7ymv0xo8L2aWVWydebDf5yCPdW6FRHuvk8jodYjrh/31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=l/wPOq+x; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730132141;
	bh=Y5PrnKl+xov67NmWMCJECcieIF0DUv2b3ykYEbx8x5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/wPOq+xxyYFedu+WEJ0rZg1JY50dXJpynSAwmxIDynFhkezZOO+4EGB6er+YxY3d
	 Bozt4WRJxIhMId7Ou3Ze2WnSYmIBi0oUJ9mtNxRzI8R5nEaQgq99+oT1VL5h/ev0eb
	 fGGMEyGa29rW0v0D6R3eaULPCTufuZVgBtSycjnvS8rbss8eo44YOe+Kah269xXx2m
	 MSGTScr7CbXYMVPLgnL94QsNizBN1XVZJFflwz/FPV07vjWIr/Adl7oeSvSnhjK2O2
	 kc1MFhviqn9cEoXeus6x0S9V8dtP6idQplQ3Eq/FSZeOCHmTqeVa9QXzx0TogKmASd
	 4N5my0tp/wxYA==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:15:39 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Yangtao Li
 <frank@allwinnertech.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Parthiban
 <parthiban@linumiz.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <treding@nvidia.com>, Maxime Ripard <mripard@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Yangtao Li
 <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
 <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 06/13] phy: sun4i-usb: add support for A100 USB PHY
In-Reply-To: <20241024202216.6cded8c4@minigeek.lan>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-7-masterr3c0rd@epochal.quest>
 <20241024202216.6cded8c4@minigeek.lan>
Message-ID: <eda06e73559c5d12e430cda8f93a0204@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/24 4:22 pm, Andre Przywara wrote:
> On Thu, 24 Oct 2024 14:05:24 -0300
> Cody Eksal <masterr3c0rd@epochal.quest> wrote:
>> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c 
>> b/drivers/phy/allwinner/phy-sun4i-usb.c
>> index b0f19e950601..a3942b2ee90b 100644
>> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
>> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
>> @@ -1006,6 +1006,16 @@ static const struct sun4i_usb_phy_cfg 
>> sun50i_a64_cfg = {
>>  	.phy0_dual_route = true,
>>  };
>> 
>> +static const struct sun4i_usb_phy_cfg sun50i_a100_cfg = {
>> +	.num_phys = 2,
>> +	.disc_thresh = 3,
> 
> This member is never used when .siddq_in_base is true (and yes, this is
> wrong for the H616 too), ...
> 
>> +	.phyctl_offset = REG_PHYCTL_A33,
>> +	.dedicated_clocks = true,
>> +	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
>> +	.phy0_dual_route = true,
>> +	.siddq_in_base = true,
> 
> ... which makes this whole description identical to the D1 version.
> So at the very least we wouldn't this new a100_cfg, but instead just
> point to the existing d1_cfg.
I did test on my board and confirmed simply using a D1 compatible works.
> And this also brings up the question whether we need a new compatible
> string. As it stands now, we could also use:
> 	compatible = "allwinner,sun50i-a100-usb-phy",
> 		     "allwinner,sun20i-d1-usb-phy";
> 
> and wouldn't need any driver changes at all. Which would have the neat
> side effect to make USB work already with v5.18 kernels.
> 
> The only downside is the somewhat weird ordering of the compatible
> strings, with the much newer chip as the fallback.
I plan to drop this patch in V2, in favor of just adding the 
compatible/fallback. Although it's odd ordering, I would think fixing 
the DTS of other device trees to remedy this would probably not be worth 
the hassle.
Thanks for pointing this out!

- Cody
> What do other people think here?
> 
> Cheers,
> Andre


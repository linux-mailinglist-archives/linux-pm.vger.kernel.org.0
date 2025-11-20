Return-Path: <linux-pm+bounces-38245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B169C71A80
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 02:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 03F78296B4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777CA23AE9A;
	Thu, 20 Nov 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TWnhObUu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com [220.197.32.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322C23AB90
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600985; cv=none; b=sTtLkmBM7uDMyRH8nCzjP+K+Og+/g2nFGb9GWycTZSOQMfqPD2ezD+tyiiKTfoaPYdt4tOSrmEzv0AQB9Zu36lllYrfr4+QvTwpEJRaVi/rJTETvVggtykfPYpkdCvqEEwFIpq6qk5KRWyrmbXrhY3yC6PNlzpqiOnoPk3eKank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600985; c=relaxed/simple;
	bh=aROx0TaxL3IqiRhSz6mCGl6EXZALVd+yNEPPajxjxAw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vk6Vbt0TQbXAwB+AupMdV9hVPXY8qAIrO8fe5kSTp2MzPA8PFmJNDFrmoWjQFn34hbH97RTli/xhQrIuwtsrWXQYLvle/NDj2S2s9p2rH5RZu0SSGo7vTOsABR/ckv109VrklqsMVb8Kiehhc8+Kg2zs5rrAMQbG0t7hiOQpI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TWnhObUu; arc=none smtp.client-ip=220.197.32.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a32d8a7d;
	Thu, 20 Nov 2025 08:34:15 +0800 (GMT+08:00)
Message-ID: <1451d8b9-0751-4785-9644-9ce68230ed27@rock-chips.com>
Date: Thu, 20 Nov 2025 08:34:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, jonas@kwiboo.se,
 pgwipeout@gmail.com, finley.xiao@rock-chips.com, kever.yang@rock-chips.com,
 sebastian.reichel@collabora.com, heiko@sntech.de, ulf.hansson@linaro.org,
 Chris Morgan <macromorgan@hotmail.com>, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] pmdomain: rockchip: quiet regulator error on
 -EPROBE_DEFER
To: Chris Morgan <macroalpha82@gmail.com>
References: <20251119161250.60885-1-macroalpha82@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251119161250.60885-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9eaeebd709cckunm0ca1951dff30a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xCGFZOH0NOSE4aS09CQx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TWnhObUuq5hTPEv0Hm+mCMi1NdmVaVmWnXCgINZThojczXFU+8BcgsJoqbwAP0finLYc5zbG1o3XFzk93aLkVrcq6bx38Q+tKqZmuO+jcpXo8li/c6Ns/WO6v0puOyye9TEjtbDjpfsPPORRDOcjYteMYu70/fGOlRZFF54Vlg0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xfUyjh56QuH0slCMrQSdQkVJf8Ne/u1gnZkXmUM8mbQ=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 0:12, Chris Morgan 写道:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
> to prevent errors early in the boot process when the requested
> regulator is not yet available. This converts errors like the following
> to debug messages:
> 
> rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to enable supply: -517
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 1955c6d453e4..3c84a65de1a5 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -688,7 +688,8 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>   
>   	ret = rockchip_pd_regulator_enable(pd);
>   	if (ret) {
> -		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> +		dev_err_probe(pd->pmu->dev, ret,
> +			      "Failed to enable supply: %d\n", ret);
>   		return ret;

return dev_err_probe(pd->pmu->dev, ret, "Failed to enable supply: %d\n", 
ret); ?

>   	}
>   



Return-Path: <linux-pm+bounces-43182-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NJRDC9UnmmmUgQAu9opvQ
	(envelope-from <linux-pm+bounces-43182-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 02:45:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245D18FBF6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 02:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7997030A6E8B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83126463A;
	Wed, 25 Feb 2026 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="a3jgbfYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m104.netease.com (mail-m104.netease.com [154.81.10.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616D24A05D;
	Wed, 25 Feb 2026 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983488; cv=none; b=cw83IVKNLTxykAaivbU0kzgVRn5dWN73iaqGrBZl/AVcJOsWrwgRHmkJYTz+UKe4ZvV/sTippYQHC2I5HsPnEN9S4LNTKDqdiYRE7Bipdtl5zexD/SadhIXQNnmhnjeSYmIbLcQwH1oD4gUi+avI3JymcW6aGhaiSmzQMh4vfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983488; c=relaxed/simple;
	bh=Xhvz82KuGXWOeALClfJbI5e3pUSDttjluv+EbYbhArY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/GeOJ04pAZIebtadczKeAx0vfGSRYXqY46D7BY1m0u+jkL2i8bIka2f3M1wsDY9uQ1EMDnF3K4plqQZV836aulzxllwfSv1xIGwKSuLtFQ+O2Di2sXHV0dwQeOVVyZnnGy7n0B+XmqJioHNp6cjS9O07ummeIwnOZZAphT+RBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=a3jgbfYb; arc=none smtp.client-ip=154.81.10.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34dae9247;
	Wed, 25 Feb 2026 09:37:56 +0800 (GMT+08:00)
Message-ID: <612e44b1-7747-4b47-820c-2262186e6e97@rock-chips.com>
Date: Wed, 25 Feb 2026 09:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: rockchip: Fix rkvdec0/1 and venc0/1 for
 RK3588
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>,
 linux-pm@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <1771904879-243163-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <1771904879-243163-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9c9272153603abkunm013e53b3fa2024
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0aSVZPGhoYS09NSx4aSx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=a3jgbfYbcgq9nzGrEfsmDpAoK143uGrOroM2FZuYhxQgEJOUZ8plknuMdkrK2Kn1c9L489wdzs3W8FAnYaMOgcww4A+CW18/4nPTavOzaf8kQw+MRLG5nGBbkSYyQPZM8oDBxfHkfo3s4Cbhit1VulfnEXh77Aj0GbSljmuKZS4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ZooWjJGThdRe881/8hoL4AfsxTeuU6UCGQsPBmxDADY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43182-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaoyi.chen@rock-chips.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:mid,rock-chips.com:dkim,rock-chips.com:email]
X-Rspamd-Queue-Id: 8245D18FBF6
X-Rspamd-Action: no action

Hi Shawn,

On 2/24/2026 11:47 AM, Shawn Lin wrote:
> Per the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
> PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltages to
> be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support landed[1].
> The panic looks like below:
> 
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec0' on, val=0
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec1' on, val=0
>   ...
>   Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
>   Workqueue: pm genpd_power_off_work_fn
>   Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x40/0x84
>   dump_stack+0x18/0x24
>   vpanic+0x1ec/0x4fc
>   vpanic+0x0/0x4fc
>   check_panic_on_warn+0x0/0x94
>   arm64_serror_panic+0x6c/0x78
>   do_serror+0xc4/0xcc
>   el1h_64_error_handler+0x3c/0x5c
>   el1h_64_error+0x6c/0x70
>   regmap_mmio_read32le+0x18/0x24 (P)
>   regmap_bus_reg_read+0xfc/0x130
>   regmap_read+0x188/0x1ac
>   regmap_read+0x54/0x78
>   rockchip_pd_power+0xcc/0x5f0
>   rockchip_pd_power_off+0x1c/0x4c
>   genpd_power_off+0x84/0x120
>   genpd_power_off+0x1b4/0x260
>   genpd_power_off_work_fn+0x38/0x58
>   process_scheduled_works+0x194/0x2c4
>   worker_thread+0x2ac/0x3d8
>   kthread+0x104/0x124
>   ret_from_fork+0x10/0x20
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x3000000,000e0005,40230521,0400720b
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> 
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2:
> - collect tags
> - correct TRM section(Sebastian)
> 
>  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c..040aa5f 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1315,10 +1315,10 @@ static const struct rockchip_domain_info rk3588_pm_domains[] = {
>  	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>  	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>  	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> -	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
> -	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
> -	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
> -	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
> +	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, true),
> +	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, true),
> +	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, true),
> +	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, true),
>  	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
>  	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
>  	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),

Perhaps you could try modifying only RK3588_PD_VCODEC. 
VCODEC is the parent of these PDs, so you won't need to modify too
much code and devicetree. BTW I have tried it before, but with an 
internal MPP driver. Maybe you can give it another try :)

-- 
Best, 
Chaoyi


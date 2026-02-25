Return-Path: <linux-pm+bounces-43188-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDZZEBqfnmlPWgQAu9opvQ
	(envelope-from <linux-pm+bounces-43188-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:04:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BA192E6A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C47131632C0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F632D29C2;
	Wed, 25 Feb 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hV1fxuBl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0712D248B;
	Wed, 25 Feb 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002623; cv=none; b=iBeAapTRz6TLHr7praOEEktymcQz9UCUNIVKD8phA0Uas7KdJQ+5mE3yc7V70I5H9X1g6cJeVadwDe+q+hT46265YTzDCV8wr0YRczuHXE20LB1XP+/uprL1+Wxv7rXThqh49lajSgkCTqrkYt0CPGcDL4IJwD50zVjfjBB/9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002623; c=relaxed/simple;
	bh=sOvtq8C9c+XL22JKGN7abT0Cm5rWWtboB62+qVnpPlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHHT6JgPaUmApYpQjRkI/dYs4jSmoPuAkR1fFCl21pQXBm9by79qqNIRDA0Ywec/RhPdBkReQfGCRCcngPIIRVNnC4+4+Dk9dJoH+vd3QgByJPJCtFL8LCHaQCTSRJY0bwyPKf7VfEquaL5I24hHHqHavCY9izKPgP9VnAYy/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hV1fxuBl; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34e3ed4ec;
	Wed, 25 Feb 2026 14:51:40 +0800 (GMT+08:00)
Message-ID: <cab6d03b-ac80-427e-ad9a-b810843bd799@rock-chips.com>
Date: Wed, 25 Feb 2026 14:51:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>,
 linux-pm@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9c939152ae03abkunm10db2a44ff4e3b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMaS1YdHxoYSE9NTx9PTUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hV1fxuBl5PKXPMBDCx3/0yAxIU51Xl1kJ0Ou4qWnXfOBkWTKSQyTeaJO6dNYHV8zOb667myoCloTiluAYjX7hzax3LBU/FqQyiS8mBGTMGRIXVbyY49Np7zOWGnmjgH4yKPX8QpP7+G4ESnVjlV7WBH6IwTAK3GG9GE0TX8pwZQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=B2G6fQQyc1a7ftJ4+MnugTUyTCSAbk2IAEWneviu7SE=;
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
	TAGGED_FROM(0.00)[bounces-43188-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:mid,rock-chips.com:dkim,rock-chips.com:email]
X-Rspamd-Queue-Id: C20BA192E6A
X-Rspamd-Action: no action

On 2/25/2026 10:55 AM, Shawn Lin wrote:
> From the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
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
> Chaoyi pointed out the PD_VCODEC is the parent of PD_RKVDEC0/1 and PD_VENC0/1, so checking
> the PD_VCODEC is enough.
> 
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - drop tags
> - rework it for just changing PD_VCODEC(chaoyi)
> 
> Changes in v2:
> - collect tags
> - correct TRM section(Sebastian)
> 
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com> 

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c..44d3484 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1311,7 +1311,7 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
>  	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>  	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
> -	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
> +	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>  	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>  	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>  	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),

-- 
Best, 
Chaoyi


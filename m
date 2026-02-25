Return-Path: <linux-pm+bounces-43183-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPqSI6tdnmmIUwQAu9opvQ
	(envelope-from <linux-pm+bounces-43183-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:25:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB1190DFB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25B6E301FE70
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9F280338;
	Wed, 25 Feb 2026 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XVdfgYdK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF226D4F7;
	Wed, 25 Feb 2026 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986341; cv=none; b=LaHubTHexpe326Ke7RyifBoDP4i7f6/OrBAnqBYS3UagEgf/40ZPq+TLymMdrF24o94pdNY0Ul1WnT3C89spDYhc5yO+5357ey6a3qbCGXKntu9nGUYYN+baW+lbxdaIg4Z3iDmbY+WrvqVgRGyC0xO2C0x7d71jgbtjohAMPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986341; c=relaxed/simple;
	bh=yw6ev51JlU7dVgR7HH3KldsO8BV4QNHx1PLw7bT4wEc=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Lanye7cyuHNB84D29xuFzikGsJaiar4ylalTPzgSS3Gh5SqJOTmpblNUgeUKrN8MSYNtgIH8VSNhYT6+FRjWuX/ioBRYkdB8y0OWB3XUa5+UDqB5R1pq4jOzNhPd8C1/hUtmXWAkZgpDNLF8ghlks67E0vas6RGrxeQTwcipeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XVdfgYdK; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34dc7e637;
	Wed, 25 Feb 2026 10:25:25 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>,
 linux-pm@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] pmdomain: rockchip: Fix rkvdec0/1 and venc0/1 for
 RK3588
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <1771904879-243163-1-git-send-email-shawn.lin@rock-chips.com>
 <612e44b1-7747-4b47-820c-2262186e6e97@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <741f556c-f325-0783-d78b-2976a07628db@rock-chips.com>
Date: Wed, 25 Feb 2026 10:25:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <612e44b1-7747-4b47-820c-2262186e6e97@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c929d916c09cckunm18eb6294aae34a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhKHlZMTE1OS09CTB8fQhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XVdfgYdKOyBDuQOJoYJrgoBnOrP24HcyjRKh65OPFsR2Ek8ug8z7Aoeb/nz1pGqAizAqxqS8+Veo2/AmUTMKnkSN4/G2YJ8dGU3blJkosW4HwGWOvUHzY1qCJBweXpprrSGD5WN8HA1yXyBavJfxgBmlOiN5Y/BAI9YD1tUXH4A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=W71tffjipz9IsOHmoYSHyedNnKPdfXKBp2Yf6wGNbvM=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rock-chips.com,linaro.org,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43183-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 93BB1190DFB
X-Rspamd-Action: no action

Hi Chaoyi

在 2026/02/25 星期三 9:37, Chaoyi Chen 写道:
> Hi Shawn,
> 
> On 2/24/2026 11:47 AM, Shawn Lin wrote:
>> Per the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
>> PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltages to
>> be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support landed[1].
>> The panic looks like below:
>>
>>    rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec0' on, val=0
>>    rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec1' on, val=0
>>    ...
>>    Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
>>    Workqueue: pm genpd_power_off_work_fn
>>    Call trace:
>>    show_stack+0x18/0x24 (C)
>>    dump_stack_lvl+0x40/0x84
>>    dump_stack+0x18/0x24
>>    vpanic+0x1ec/0x4fc
>>    vpanic+0x0/0x4fc
>>    check_panic_on_warn+0x0/0x94
>>    arm64_serror_panic+0x6c/0x78
>>    do_serror+0xc4/0xcc
>>    el1h_64_error_handler+0x3c/0x5c
>>    el1h_64_error+0x6c/0x70
>>    regmap_mmio_read32le+0x18/0x24 (P)
>>    regmap_bus_reg_read+0xfc/0x130
>>    regmap_read+0x188/0x1ac
>>    regmap_read+0x54/0x78
>>    rockchip_pd_power+0xcc/0x5f0
>>    rockchip_pd_power_off+0x1c/0x4c
>>    genpd_power_off+0x84/0x120
>>    genpd_power_off+0x1b4/0x260
>>    genpd_power_off_work_fn+0x38/0x58
>>    process_scheduled_works+0x194/0x2c4
>>    worker_thread+0x2ac/0x3d8
>>    kthread+0x104/0x124
>>    ret_from_fork+0x10/0x20
>>    SMP: stopping secondary CPUs
>>    Kernel Offset: disabled
>>    CPU features: 0x3000000,000e0005,40230521,0400720b
>>    Memory Limit: none
>>    ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>>
>> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
>> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - collect tags
>> - correct TRM section(Sebastian)
>>
>>   drivers/pmdomain/rockchip/pm-domains.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
>> index 997e93c..040aa5f 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -1315,10 +1315,10 @@ static const struct rockchip_domain_info rk3588_pm_domains[] = {
>>   	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>>   	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>>   	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
>> -	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
>> -	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
>> -	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
>> -	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
>> +	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, true),
>> +	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, true),
>> +	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, true),
>> +	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, true),
>>   	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
>>   	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
>>   	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),
> 
> Perhaps you could try modifying only RK3588_PD_VCODEC.
> VCODEC is the parent of these PDs, so you won't need to modify too

Thanks for your suggestion! I once took a quick look at rk3588-base.dtsi
and indeed noticed that these PDs (PD_RKVDEC0/1 and PD_VENC0/1) are all
placed under PD_VCODEC. At that time, I considered PD_VCODEC to be a
"fake" power domain, this was, because all my reference materials came 
from the relevant chapters of the RK3588 TRM, where the structure is 
illustrated as follows:

┌────┬──────┬──────┐
│        │            │BIU_RKVDEC0 │
│        │PD_RKVDEC0  ├──────┤
│        │            │RKVDEC0&CCU │
│        ├──────┼──────┤
│        │            │BIU_RKVDEC1 │
│VD_VCODEC│PD_RKVDEC1 ├──────┤
│        │            │RKVDEC1     │
│        ├──────┼──────┤
│        │            │BIU_VENC0   │
│        │PD_VENC0    ├──────┤
│        │            │RKVENCO     │
│        ├──────┼──────┤
│        │            │BIU_VENC1   │
│        │PD_VENC1    ├──────┤
│        │            │RKVENC1     │
└────┴──────┴──────┘

PD_VCODEC does not show up in any of these diagrams from the TRM. Looks
like the people who wrote the TRM thought PD_VCODEC was a huge secret t
that they just wouldn’t put it in the figure, for fear of being
discovered :)

Of course, you are right, there is some registers called
pd_vcodec_foo..bar which seems it does exist. So I gave it a try
and it worked too. Will update v3, thanks for help.


> much code and devicetree. BTW I have tried it before, but with an
> internal MPP driver. Maybe you can give it another try :)
> 


Return-Path: <linux-pm+bounces-11906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8B9473C5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 05:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789311C209D3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8F13CA8D;
	Mon,  5 Aug 2024 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jGNXpm4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m102.netease.com (mail-m102.netease.com [154.81.10.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0555589B;
	Mon,  5 Aug 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827867; cv=none; b=aWxH2pkCEDGyGUhW8Y20KzPCMW6BuO+nVmnoWZafrQBoQL4Xq+VMUXqw996DYr/U6xP/8wC3WhwPkQPB4e4/ZDQvtBLKIgBeQQiMx6LbZZStjLcm2ASLmD9fJ9nHRkrKeTQWxyiM12cixqXG4ZqnL5LtBoXUzfZxm7RE99SMXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827867; c=relaxed/simple;
	bh=JB9cEamainRQayuIIKP8QoE3Q7NeLpHSyt4ffX47KTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhDYqL+EYhOHHhH71dF+bbjQtIws7RPlp8dLhkDDk5O9U/QqCdmAj+z9JRuYFVTzDRjI+LOLxJm1WMT6MyIb6iVnwm5NplK43YYJX/tSnGooBOuHG5u4HFW9RsOnHKiuhf8a510KhvFiY76n5pYro3/CL76HkZF1/8Icl58SK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jGNXpm4e; arc=none smtp.client-ip=154.81.10.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=jGNXpm4eEJnnDQ6HDu8pM04d2juDsBkM7XBWIfZtoUkA+mR8OtRL3PRtX0meVGgHyblQVEmD3codt64UuOc/UcdNLbcWZeP9PeqEc9bs1ug6QJsHk5zXGfieUq94KbYEf10XOFW1BFCYuvF/dtvtFdRY7mcoFP2H20jEFj0VOLk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Y0/hH3uagaxEC6Xi8wQOFeGwbmyZcR2iigSZoutT6D8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.49] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1FC2FA028F;
	Mon,  5 Aug 2024 09:22:13 +0800 (CST)
Message-ID: <7b0d3bc3-4f23-4139-ac6b-10b6b9f85092@rock-chips.com>
Date: Mon, 5 Aug 2024 09:22:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] soc: rockchip: power-domain: Add power domain support
 for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240802151647.294307-1-detlev.casanova@collabora.com>
 <20240802151647.294307-4-detlev.casanova@collabora.com>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20240802151647.294307-4-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxOQ1ZMThofSBgYHRhKTk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9120213eb903a8kunm1fc2fa028f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6MAw5FzI9MR8zOjAuTlY8
	UUkKCStVSlVKTElJQ0lLQkhOQkhPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpITktINwY+

hi,

This submission is also required for the pd of rk3576.

commit feb16e5db3c5e6ff7f18bc3c850c3758fad87caa
Author: Finley Xiao <finley.xiao@rock-chips.com>
Date:   Tue May 14 17:40:24 2024 +0800

     soc: rockchip: power-domain: Add memory reset support for rk3576

     This fixes panic when pd power on.
     rockchip-pm-domain 27380000.power-management:power-controller: 
failed to set domain 'nputop', target_on= 1, val=0
     Kernel panic - not syncing: panic_on_set_domain set ...
     Call trace:
     dump_backtrace+0xf4/0x114
     show_stack+0x18/0x24
     dump_stack_lvl+0x6c/0x90
     dump_stack+0x18/0x38
     panic+0x14c/0x338
     rockchip_do_pmu_set_power_domain+0x640/0x644
     rockchip_pd_power+0x154/0x350
     rockchip_pd_power_on+0x24/0x30
     genpd_power_on+0x1d4/0x2ec
     genpd_power_on+0x7c/0x2ec
     genpd_runtime_resume+0xb0/0x384
     __rpm_callback+0x7c/0x3c4
     rpm_resume+0x43c/0x678
     __pm_runtime_resume+0x4c/0x90
     rknpu_power_on+0xa0/0x2d8
     __rknpu_action_ioctl+0x54/0x230
     drm_ioctl_kernel+0x80/0xf8
     drm_ioctl+0x2d4/0x554
     __arm64_sys_ioctl+0x90/0xc8
     invoke_syscall+0x40/0x104
     el0_svc_common+0xbc/0x168
     do_el0_svc+0x1c/0x28
     el0_svc+0x1c/0x68
     el0t_64_sync_handler+0x68/0xb4
     el0t_64_sync+0x164/0x168

     Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
     Change-Id: Ic73413d48335ef6bc57f3793ba6e3b39d4ecd100

diff --git a/drivers/soc/rockchip/pm_domains.c 
b/drivers/soc/rockchip/pm_domains.c
index 1bd9b8280667..8bb2a5904f83 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -341,6 +341,7 @@ static void rockchip_pmu_unlock(struct 
rockchip_pm_domain *pd)
         .pwr_w_mask = (pwr) << 16,                      \
         .pwr_mask = (pwr),                              \
         .status_mask = (status),                        \
+       .mem_status_mask = (r_status),                  \
         .repair_status_mask = (r_status),               \
         .req_offset = r_offset,                         \
         .req_w_mask = (req) << 16,                      \
@@ -2287,6 +2288,9 @@ static const struct rockchip_pmu_info rk3568_pmu = {
  static const struct rockchip_pmu_info rk3576_pmu = {
         .pwr_offset = 0x210,
         .status_offset = 0x230,
+       .chain_status_offset = 0x248,
+       .mem_status_offset = 0x250,
+       .mem_pwr_offset = 0x300,
         .req_offset = 0x110,
         .idle_offset = 0x128,
         .ack_offset = 0x120,

在 2024/8/2 23:15, Detlev Casanova 写道:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> This driver is modified to support RK3576 SoCs and lists the power domains.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 69 ++++++++++++++++++++++++--
>   1 file changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 9b76b62869d0d..f0330bb51685f 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -33,6 +33,7 @@
>   #include <dt-bindings/power/rk3368-power.h>
>   #include <dt-bindings/power/rk3399-power.h>
>   #include <dt-bindings/power/rk3568-power.h>
> +#include <dt-bindings/power/rk3576-power.h>
>   #include <dt-bindings/power/rk3588-power.h>
>   
>   struct rockchip_domain_info {
> @@ -50,6 +51,7 @@ struct rockchip_domain_info {
>   	u32 pwr_offset;
>   	u32 mem_offset;
>   	u32 req_offset;
> +	u32 delay_us;
>   };
>   
>   struct rockchip_pmu_info {
> @@ -144,9 +146,26 @@ struct rockchip_pmu {
>   	.active_wakeup = wakeup,			\
>   }
>   
> -#define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup)	\
>   {							\
> -	.name = _name,				\
> +	.name = _name,					\
> +	.pwr_offset = p_offset,				\
> +	.pwr_w_mask = (pwr) << 16,			\
> +	.pwr_mask = (pwr),				\
> +	.status_mask = (status),			\
> +	.repair_status_mask = (r_status),		\
> +	.req_offset = r_offset,				\
> +	.req_w_mask = (req) << 16,			\
> +	.req_mask = (req),				\
> +	.idle_mask = (idle),				\
> +	.ack_mask = (ack),				\
> +	.delay_us = delay,				\
> +	.active_wakeup = wakeup,			\
> +}
> +
> +#define DOMAIN_RK3036(_name, req, ack, idle, wakeup)	\
> +{							\
> +	.name = _name,					\
>   	.req_mask = (req),				\
>   	.req_w_mask = (req) << 16,			\
>   	.ack_mask = (ack),				\
> @@ -175,6 +194,9 @@ struct rockchip_pmu {
>   #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
>   	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>   
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup)
> +
>   /*
>    * Dynamic Memory Controller may need to coordinate with us -- see
>    * rockchip_pmu_block().
> @@ -552,7 +574,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>   			/* if powering up, leave idle mode */
>   			rockchip_pmu_set_idle_request(pd, false);
>   
> -			rockchip_pmu_restore_qos(pd);
> +			if (pd->info->delay_us)
> +				udelay(pd->info->delay_us);
> +			else
> +				rockchip_pmu_restore_qos(pd);
>   		}
>   
>   		clk_bulk_disable(pd->num_clks, pd->clks);
> @@ -1106,6 +1131,28 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
>   	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
>   };
>   
> +static const struct rockchip_domain_info rk3576_pm_domains[] = {
> +	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
> +	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
> +	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
> +	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
> +	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  15,   false),
> +	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
> +	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
> +	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
> +	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
> +	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
> +	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
> +	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
> +	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
> +	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
> +	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    0,    false),
> +	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    0,    false),
> +	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
> +};
> +
>   static const struct rockchip_domain_info rk3588_pm_domains[] = {
>   	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false),
>   	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false),
> @@ -1284,6 +1331,18 @@ static const struct rockchip_pmu_info rk3568_pmu = {
>   	.domain_info = rk3568_pm_domains,
>   };
>   
> +static const struct rockchip_pmu_info rk3576_pmu = {
> +	.pwr_offset = 0x210,
> +	.status_offset = 0x230,
> +	.req_offset = 0x110,
> +	.idle_offset = 0x128,
> +	.ack_offset = 0x120,
> +	.repair_status_offset = 0x570,
> +
> +	.num_domains = ARRAY_SIZE(rk3576_pm_domains),
> +	.domain_info = rk3576_pm_domains,
> +};
> +
>   static const struct rockchip_pmu_info rk3588_pmu = {
>   	.pwr_offset = 0x14c,
>   	.status_offset = 0x180,
> @@ -1359,6 +1418,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>   		.compatible = "rockchip,rk3568-power-controller",
>   		.data = (void *)&rk3568_pmu,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-power-controller",
> +		.data = (void *)&rk3576_pmu,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-power-controller",
>   		.data = (void *)&rk3588_pmu,

-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************



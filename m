Return-Path: <linux-pm+bounces-12243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E59527EC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 04:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3498B2334B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1618622;
	Thu, 15 Aug 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iFWwfDzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com [45.254.49.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BD36124;
	Thu, 15 Aug 2024 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723688881; cv=none; b=eyy4jfgsv+fT6/CHiji5iBpJnXR2Nu99zU+JbCK+fF5S6FMCOuCZdJgrxrbiDzAQKE5A7XCAU0SolRi6FLlJsj4BMmPTenKZsJTJAbQD0W372Icz0Wf3yZt9ksYEZRldvuOWTh9xJMbqJNMI0z2KyWbwOd3a+GewdltEUSYst6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723688881; c=relaxed/simple;
	bh=NNpwkujCV3dX9o/zbWoG9yRatR301Z/EK7T1NjA4l6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpnO9CgIww0iRGP5XpZeMBRzDHvbGQ0YIJo3wBou9t3e7jVAqlGtXnv87bJCH6tlYmphXF/A5vq2TAeuXcHdgP6CXdn53ppxWIi69Zio/pP1bQ3Cj+zVWm9rIdYCTK271lrzW3dXEmgo+f8pQY6B4XymnYMd8aDbu1Wmgsjc12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iFWwfDzg; arc=none smtp.client-ip=45.254.49.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=iFWwfDzgvBIVvfRhzICQsCQhaUA3eeUmU4UL5DdI6HOamO5j2aG4dLSD7wDjP3RTdrQZQghWkqtC61gT9DApLBFjxs+WY6BXjswIjchxgZSdT0/wV6F2lpjAh5p3kujFuzBPYYERLO7FAp22PF08MW0jkqrLCBYUVRfQlmBad3c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ty7+juzHJYUrCpybNJWAGwsjoiQXTva3a6kVoJRyTBw=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E3D5DA021E;
	Thu, 15 Aug 2024 09:09:16 +0800 (CST)
Message-ID: <304213b3-9466-41f9-bcb8-1d32ac9136a8@rock-chips.com>
Date: Thu, 15 Aug 2024 09:09:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pmdomain: rockchip: Add support for RK3576 SoC
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
 Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20240814222824.3170-1-detlev.casanova@collabora.com>
 <20240814222824.3170-3-detlev.casanova@collabora.com>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20240814222824.3170-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8dHlZLGU4aTBpNGEoZQk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a915394f92403a8kunme3d5da021e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6GQw*SjI#F0wrFjIRE0JM
	OjcwCiFVSlVKTElITUNPSk5DSEpMVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNMTk83Bg++

Hi,

Reviewed-by: Elaine Zhang<zhangqing@rock-chips.com>

在 2024/8/15 6:26, Detlev Casanova 写道:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> Add configuration for RK3576 SoC and list the power domains.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 45 ++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 9b76b62869d0d..64b4d7120d832 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -33,6 +33,7 @@
>   #include <dt-bindings/power/rk3368-power.h>
>   #include <dt-bindings/power/rk3399-power.h>
>   #include <dt-bindings/power/rk3568-power.h>
> +#include <dt-bindings/power/rockchip,rk3576-power.h>
>   #include <dt-bindings/power/rk3588-power.h>
>   
>   struct rockchip_domain_info {
> @@ -175,6 +176,9 @@ struct rockchip_pmu {
>   #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
>   	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>   
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, wakeup)	\
> +	DOMAIN_M_O_R(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, wakeup)
> +
>   /*
>    * Dynamic Memory Controller may need to coordinate with us -- see
>    * rockchip_pmu_block().
> @@ -1106,6 +1110,28 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
>   	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
>   };
>   
> +static const struct rockchip_domain_info rk3576_pm_domains[] = {
> +	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       false),
> +	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), false),
> +	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), false),
> +	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), false),
> +	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), false),
> +	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       false),
> +	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  false),
> +	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), false),
> +	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), false),
> +	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), true),
> +	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  false),
> +	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  false),
> +	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  false),
> +	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  false),
> +	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  false),
> +	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    false),
> +	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  false),
> +	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  false),
> +	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  false),
> +};
> +
>   static const struct rockchip_domain_info rk3588_pm_domains[] = {
>   	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false),
>   	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false),
> @@ -1284,6 +1310,21 @@ static const struct rockchip_pmu_info rk3568_pmu = {
>   	.domain_info = rk3568_pm_domains,
>   };
>   
> +static const struct rockchip_pmu_info rk3576_pmu = {
> +	.pwr_offset = 0x210,
> +	.status_offset = 0x230,
> +	.chain_status_offset = 0x248,
> +	.mem_status_offset = 0x250,
> +	.mem_pwr_offset = 0x300,
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
> @@ -1359,6 +1400,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
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



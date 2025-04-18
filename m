Return-Path: <linux-pm+bounces-25683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77121A92F98
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 04:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AE119E6EA2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABC45D477;
	Fri, 18 Apr 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Tk//MLA5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m19731113.qiye.163.com (mail-m19731113.qiye.163.com [220.197.31.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800872641EC;
	Fri, 18 Apr 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941619; cv=none; b=jnwkfe0QtQfP9KPPygbZM+LxUDJrS6+MWOUAtPE2dhimLcwgLbv2IB72+tD3dmLTCYz04ts/LJggbfrq3Qen3XY8KyN54IN3Vy7ETOHC9tCb5bWNTdPxK/d7M4yrfJDPwttd08VCSdPT36+6Js/GUCJQSxZs932TkYdTJPqIORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941619; c=relaxed/simple;
	bh=1+ScBvG+oLMlHepXE4HuFUNDLPQ6s7vDAMcdM2Q9ubE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VqU9kqhKxbQbURvmRDGdwtNRWjJvf1Pqv5iuEVd34kkUb7Rf7wz+m7a2FJURWZJF88HVREm82gDi7mtet4fvcat1GPDmHOeWX7s9KX0Pd8ugswBXLLbl/nChI7IWVIGlor+wqxEVqDmeWLwgkhEiHeCYhFfDD4YPzrXui85lnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Tk//MLA5; arc=none smtp.client-ip=220.197.31.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12477934f;
	Fri, 18 Apr 2025 08:44:31 +0800 (GMT+08:00)
Message-ID: <c70cef1b-9f37-5a73-faf3-4d1cac6bcdde@rock-chips.com>
Date: Fri, 18 Apr 2025 08:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Detlev Casanova
 <detlev.casanova@collabora.com>, linux-pm@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkpITlZNGk9PHRhKT0hNH05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96465ab30c09cckunm12477934f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Tio5GjJNFhU4Mg8fS0ks
	NTUwCRBVSlVKTE9PQkhMS0xJQ09IVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU1KTkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Tk//MLA56Ghww08hBdr9vFuE8XaqrrlB+sMy2CcuqZJ3Ion+u7E9rGD/rlImMVOzl/RJ1cGe5d/e6fGfqh5LKM5ABl2DSUs6liUiPPBhBSXaeBm77NSls+uwEOj4zX9UlsU1xyrp7rIE+06HHojiLnttWKb5J/whbh7OB6+Tfs0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Lcb43dSZS3+Y/L9GUNHVrV5chNZ/V2WVLs/FwGaCc1s=;
	h=date:mime-version:subject:message-id:from;

Hi Nicolas,

在 2025/04/13 星期日 4:45, Nicolas Frattaroli 写道:
> RK3576's power domains have a peculiar problem where the PD_NVM
> power domain, of which the sdhci controller is a part, seemingly does
> not have idempotent disable/enable. The end effect is that if PD_NVM
> gets turned off by the generic power domain logic because all the
> devices depending on it are suspended, then the next time the sdhci
> device is unsuspended, it'll hang the SoC as soon as it tries accessing
> the CQHCI registers.
> 
> RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
> added to the generic power domains API to handle what appears to be a
> similar hardware issue.
> 
> Use this new function to ask for the same treatment in the sdhci
> controller by giving rk3576 its own platform data with its own postinit
> function. The benefit of doing this instead of marking the power domains
> always on in the power domain core is that we only do this if we know
> the platform we're running on actually uses the sdhci controller. For
> others, keeping PD_NVM always on would be a waste, as they won't run
> into this specific issue. The only other IP in PD_NVM that could be
> affected is FSPI0. If it gets a mainline driver, it will probably want
> to do the same thing.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Changes in v2:
> - Rewrite patch to use dev_pm_genpd_rpm_always_on in sdhci driver
>    instead, after Ulf Hansson made me aware of its existence
> - Link to v1: https://lore.kernel.org/r/20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 09b9ab15e4995f0bddf57dd309c010c849be40d9..a00aec05eff2da8197cc64690ba9665be756e54a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -17,6 +17,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/reset.h>
>   #include <linux/sizes.h>
> @@ -745,6 +746,28 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
>   	}
>   }
>   
> +static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	int ret;
> +
> +	/*
> +	 * This works around what appears to be a silicon bug, which makes the

After discussion with Finley, we agree with this patch which is
basically the same way we handle it on vendor tree. But it's not a
silicon bug to us, so maybe the comments need a bit of adjustment.


> +	 * PD_NVM power domain, which the sdhci controller on the RK3576 is in,
> +	 * never come back the same way once it's turned off once. This can
> +	 * happen during early kernel boot if no driver is using either PD_NVM
> +	 * or its child power domain PD_SDGMAC for a short moment, leading to it
> +	 * being turned off to save power. By keeping it on, sdhci suspending
> +	 * won't lead to PD_NVM becoming a candidate for getting turned off.
> +	 */
> +	ret = dev_pm_genpd_rpm_always_on(dev, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
> +			 ERR_PTR(ret));
> +
> +	dwcmshc_rk35xx_postinit(host, dwc_priv);
> +}
> +
>   static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1176,6 +1199,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>   	.postinit = dwcmshc_rk35xx_postinit,
>   };
>   
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_rk35xx_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	},
> +	.init = dwcmshc_rk35xx_init,
> +	.postinit = dwcmshc_rk3576_postinit,
> +};
> +
>   static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>   	.pdata = {
>   		.ops = &sdhci_dwcmshc_th1520_ops,
> @@ -1274,6 +1309,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>   		.compatible = "rockchip,rk3588-dwcmshc",
>   		.data = &sdhci_dwcmshc_rk35xx_pdata,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-dwcmshc",
> +		.data = &sdhci_dwcmshc_rk3576_pdata,
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-dwcmshc",
>   		.data = &sdhci_dwcmshc_rk35xx_pdata,
> 
> ---
> base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
> change-id: 20250317-rk3576-emmc-fix-7dc81a627422
> 
> Best regards,


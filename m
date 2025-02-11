Return-Path: <linux-pm+bounces-21778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0BA30451
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F3163893
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AC1EB192;
	Tue, 11 Feb 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVyj4Onm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8811E5B99
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258329; cv=none; b=Tg6pXeMpremZTpupmwAmPdkm1fjNt1+PPLaST8zPaNXDaLz3TN1y8p+YWtQyS/scMOaimU7Jc+s8RcPl92RMyoiT/EBO/RaBMbwUPCk/uGCl1mr4H9Hju1GMCn+zMOAPOvcaW+ZY21xR8f7sod0EjlZt7DXTuSGx7lQ2Kyn3muI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258329; c=relaxed/simple;
	bh=5wJ0j9keEBxlgTYpQvcjY7TiLeW5dRaQxEj2ECjIty4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJEXjyvUijlO1zC63rgJsDADdHXzUyy4424sd/4xNl+6qqMXAhPElsWwaAkR5lo42ucPekeOLHiBM7ZgNqH1S815AukobftLUrOD55iHOGa/QoJUKlj5KsgWWFG6A7tsrPiy7/DnGXPbZnjSpmQVbvM99IyqtCHdS6csgSdcCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVyj4Onm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f5660c2fdso69295295ad.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739258327; x=1739863127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HyWS8dDD1SA6lPiaCoBbNsY0Cfc1YFFB5MCYHSu5eeQ=;
        b=lVyj4OnmzsS23ha9TUwIs1AkS3Brdu1iSiesZh3P54O/KaOj6cs5SDQ3+ApSQdppOi
         te5aptdX5z1sNAlcn7ZFTg+4RM4GlVX+gJDWKEIKaGGqphJgGxJ/hrjV5tUdcwb4ItWv
         xVVXxDoiAyuHhHgB1ownkolfNECUGGcbbXOipo4fSkzGkjB7UN3XF9otAUjMr9/bFhkU
         qdjQnZ1H/jRjYBbABztMiZKJ1aj2FJvqU1s3WaQQPMQ5krMsj8npbVLY2dQVGPz84RQx
         CGbXj0LY0+I9fGhmKH7z1xeswixQIbXkfXFjCzu8LVk3VWvui5wi67eeLkSBpZkSxxkC
         H4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258327; x=1739863127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyWS8dDD1SA6lPiaCoBbNsY0Cfc1YFFB5MCYHSu5eeQ=;
        b=G4qPFoUFXwlkmnyUVs+tw+GfNJwpy8l9EM3FBe8tDBFU8uuKtowhLdd6dHOYYGY1jr
         LB1g2Jb1L0Y60t2Ok1KbGUgONvmdBgAtisa7Ct0ec31AQ66us3brS/X1Aq/zBxGC9CFv
         L7wymBd6vZ5qn9ZCDVtTW5AiC8yNrCNdGB9Blxpxy2iau4tAuGot3qRU/xRXTv1B0v4c
         wTyqMwuJrKEBXWa3Pmdtlb32DtMX4eE70ci5SDfEqpoU52Cw32qUURTR2qqUqUVc/u4k
         3tpX4Z5ckRNDaCqIc/rVG4OkrYrREoDQ75xryxmA2UOPHto7T75NbxxAj5hbFJCx8BGF
         1Jiw==
X-Forwarded-Encrypted: i=1; AJvYcCUbpI4XI8f+n5e64mn2KpSgF4Oo4FvKgSPCM22G4W2NzuYOI2YGig8jcgYoIS00jZ/41B1I5ROEGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sfo0HVtkdxtqR4jkAIE85CjhrOV3I7R6cXxb1DuGD7ExbMZ9
	fLdYzwRBv5h0k8u23fX+s7yTYHSF6IjkvI1nnwXf4Aibg17rJfbxAY/dXnSG2g==
X-Gm-Gg: ASbGncsxb6YVN5HwtL+kRGYpVK3TY3U5CEnJ3ltAuaP64iAczejTOGwL01W+4kTGC2z
	oT2MQMoX7e6yW5yqJmfem203CimLNeCFOhgA+HxE53hBuAPRR0qChXfZ4AnHy5myMlEkWNcby5l
	kCVX8K9aCxkmfb2I6l0Iv9+boahz2D4HxITUpDg1hF3vj68ItdMGGPDpamJQ7uwPWt+z8vlQGhg
	HaDohLpn+553b7mc7/WXer2LzkZ2qlS7obo0diJpD3sC8frACfqcYRu7z6Pqn+UAZCwQihraqtY
	5EQhJNmAwsQd5olL+NdOWCo0eQ==
X-Google-Smtp-Source: AGHT+IEw9fyPIMovmP/Co7hRC/CbWYPXG2iHnNrexBqJ1wirBqsfnfEzyBC86CxwVlDfLBPOmoxnaw==
X-Received: by 2002:a17:902:ced1:b0:21f:9107:fca3 with SMTP id d9443c01a7336-21f9107ff7dmr132911675ad.30.1739258326864;
        Mon, 10 Feb 2025 23:18:46 -0800 (PST)
Received: from thinkpad ([36.255.17.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5c71csm9863567a91.47.2025.02.10.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:18:46 -0800 (PST)
Date: Tue, 11 Feb 2025 12:48:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 6/7] scsi: ufs: rockchip: initial support for UFS
Message-ID: <20250211071839.zjypv3zjmimpboa4@thinkpad>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-7-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1738736156-119203-7-git-send-email-shawn.lin@rock-chips.com>

On Wed, Feb 05, 2025 at 02:15:55PM +0800, Shawn Lin wrote:
> RK3576 SoC contains a UFS controller, add initial support for it.
> The features are:
> (1) support UFS 2.0 features
> (2) High speed up to HS-G3
> (3) 2RX-2TX lanes
> (4) auto H8 entry and exit
> 
> Software limitation:
> (1) HCE procedure: enable controller->enable intr->dme_reset->dme_enable
> (2) disable unipro timeout values before power mode change
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Changes in v7:
> - add definitions for all kinds of hex values if possible
> - Misc log and comment improvement
> - use udelay for less than 10us cases
> - other improvements suggested by Mani
> 
> Changes in v6:
> - remove UFS_MAX_CLKS
> - improve err log
> - remove hardcoded clocks
> - remove comment from ufs_rockchip_device_reset()
> - remove pm_runtime_* from ufs_rockchip_remove()
> - rebase to scsi/next
> - move ufs_rockchip_set_pm_lvl to ufs_rockchip_rk3576_init()
> - add comments about device_set_awake_path()
> 
> Changes in v5:
> - use device_set_awake_path() and disable ref_out_clk in suspend
> - remove pd_id from header
> - reconstruct ufs_rockchip_hce_enable_notify() to workaround hce enable
>   without using new quirk
> 
> Changes in v4:
> - deal with power domain of rpm and spm suggested by Ulf
> - Fix typo and disable clks in ufs_rockchip_remove
> - remove clk_disable_unprepare(host->ref_out_clk) from
>   ufs_rockchip_remove
> 
> Changes in v3:
> - reword Kconfig description
> - elaborate more about controller in commit msg
> - use rockchip,rk3576-ufshc for compatible
> - remove useless header file
> - remove inline for ufshcd_is_device_present
> - use usleep_range instead
> - remove initialization, reverse Xmas order
> - remove useless varibles
> - check vops for null
> - other small fixes for err path
> - remove pm_runtime_set_active
> - fix the active and inactive reset-gpios logic
> - fix rpm_lvl and spm_lvl to 5 and move to end of probe path
> - remove unnecessary system PM callbacks
> - use UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE instead
>   of UFSHCI_QUIRK_BROKEN_HCE
> 
> Changes in v2: None
> 
>  drivers/ufs/host/Kconfig        |  12 ++
>  drivers/ufs/host/Makefile       |   1 +
>  drivers/ufs/host/ufs-rockchip.c | 353 ++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-rockchip.h |  90 ++++++++++
>  4 files changed, 456 insertions(+)
>  create mode 100644 drivers/ufs/host/ufs-rockchip.c
>  create mode 100644 drivers/ufs/host/ufs-rockchip.h
> 
> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> index 580c8d0..191fbd7 100644
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -142,3 +142,15 @@ config SCSI_UFS_SPRD
>  
>  	  Select this if you have UFS controller on Unisoc chipset.
>  	  If unsure, say N.
> +
> +config SCSI_UFS_ROCKCHIP
> +	tristate "Rockchip UFS host controller driver"
> +	depends on SCSI_UFSHCD_PLATFORM && (ARCH_ROCKCHIP || COMPILE_TEST)
> +	help
> +	  This selects the Rockchip specific additions to UFSHCD platform driver.
> +	  UFS host on Rockchip needs some vendor specific configuration before
> +	  accessing the hardware which includes PHY configuration and vendor
> +	  specific registers.
> +
> +	  Select this if you have UFS controller on Rockchip chipset.
> +	  If unsure, say N.
> diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
> index 4573aea..2f97feb 100644
> --- a/drivers/ufs/host/Makefile
> +++ b/drivers/ufs/host/Makefile
> @@ -10,5 +10,6 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
>  obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
>  obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
>  obj-$(CONFIG_SCSI_UFS_RENESAS) += ufs-renesas.o
> +obj-$(CONFIG_SCSI_UFS_ROCKCHIP) += ufs-rockchip.o
>  obj-$(CONFIG_SCSI_UFS_SPRD) += ufs-sprd.o
>  obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
> diff --git a/drivers/ufs/host/ufs-rockchip.c b/drivers/ufs/host/ufs-rockchip.c
> new file mode 100644
> index 0000000..0f918ba
> --- /dev/null
> +++ b/drivers/ufs/host/ufs-rockchip.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Rockchip UFS Host Controller driver
> + *
> + * Copyright (C) 2025 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <ufs/ufshcd.h>
> +#include <ufs/unipro.h>
> +#include "ufshcd-pltfrm.h"
> +#include "ufs-rockchip.h"
> +
> +static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
> +					 enum ufs_notify_change_status status)
> +{
> +	int err = 0;
> +
> +	if (status == POST_CHANGE) {
> +		err = ufshcd_dme_reset(hba);
> +		if (err)
> +			return err;
> +
> +		err = ufshcd_dme_enable(hba);
> +		if (err)
> +			return err;
> +
> +		return ufshcd_vops_phy_initialization(hba);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ufs_rockchip_set_pm_lvl(struct ufs_hba *hba)
> +{
> +	hba->rpm_lvl = UFS_PM_LVL_5;
> +	hba->spm_lvl = UFS_PM_LVL_5;
> +}
> +
> +static int ufs_rockchip_rk3576_phy_init(struct ufs_hba *hba)
> +{
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(PA_LOCAL_TX_LCC_ENABLE, 0x0), 0x0);
> +	/* enable the mphy DME_SET cfg */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_ENABLE);
> +	for (int i = 0; i < 2; i++) {
> +		/* Configuration M - TX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD, SEL_TX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD_EN, SEL_TX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_VALUE, SEL_TX_LANE0 + i), 0x44);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE1, SEL_TX_LANE0 + i), 0xe6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE2, SEL_TX_LANE0 + i), 0x07);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_TASE_VALUE, SEL_TX_LANE0 + i), 0x93);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_BASE_NVALUE, SEL_TX_LANE0 + i), 0xc9);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_POWER_SAVING_CTRL, SEL_TX_LANE0 + i), 0x00);
> +		/* Configuration M - RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD, SEL_RX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD_EN, SEL_RX_LANE0 + i), 0x00);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE, SEL_RX_LANE0 + i), 0x58);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE1, SEL_RX_LANE0 + i), 0x8c);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE2, SEL_RX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_OPTION, SEL_RX_LANE0 + i), 0xf6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_POWER_SAVING_CTRL, SEL_RX_LANE0 + i), 0x69);
> +	}
> +
> +	/* disable the mphy DME_SET cfg */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_DISABLE);
> +
> +	ufs_sys_writel(host->mphy_base, 0x80, CMN_REG23);
> +	ufs_sys_writel(host->mphy_base, 0xB5, TRSV0_REG14);
> +	ufs_sys_writel(host->mphy_base, 0xB5, TRSV1_REG14);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG15);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG15);
> +
> +	ufs_sys_writel(host->mphy_base, 0x38, TRSV0_REG08);
> +	ufs_sys_writel(host->mphy_base, 0x38, TRSV1_REG08);
> +
> +	ufs_sys_writel(host->mphy_base, 0x50, TRSV0_REG29);
> +	ufs_sys_writel(host->mphy_base, 0x50, TRSV1_REG29);
> +
> +	ufs_sys_writel(host->mphy_base, 0x80, TRSV0_REG2E);
> +	ufs_sys_writel(host->mphy_base, 0x80, TRSV1_REG2E);
> +
> +	ufs_sys_writel(host->mphy_base, 0x18, TRSV0_REG3C);
> +	ufs_sys_writel(host->mphy_base, 0x18, TRSV1_REG3C);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG16);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG16);
> +
> +	ufs_sys_writel(host->mphy_base, 0x20, TRSV0_REG17);
> +	ufs_sys_writel(host->mphy_base, 0x20, TRSV1_REG17);
> +
> +	ufs_sys_writel(host->mphy_base, 0xC0, TRSV0_REG18);
> +	ufs_sys_writel(host->mphy_base, 0xC0, TRSV1_REG18);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, CMN_REG25);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG3D);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG3D);
> +
> +	ufs_sys_writel(host->mphy_base, 0xC0, CMN_REG23);
> +	udelay(1);
> +	ufs_sys_writel(host->mphy_base, 0x00, CMN_REG23);
> +
> +	usleep_range(200, 250);
> +	/* start link up */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_TX_ENDIAN, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_RX_ENDIAN, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID_VALID, 0), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_PEERDEVICEID, 0), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_CONNECTIONSTATE, 0), 0x1);
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_common_init(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ufs_rockchip_host *host;
> +	int err;
> +
> +	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
> +	if (IS_ERR(host->ufs_sys_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(host->ufs_sys_ctrl),
> +				"Failed to map HCI system control registers\n");
> +
> +	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
> +	if (IS_ERR(host->ufs_phy_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
> +				"Failed to map mphy system control registers\n");
> +
> +	host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
> +	if (IS_ERR(host->mphy_base))
> +		return dev_err_probe(dev, PTR_ERR(host->mphy_base),
> +				"Failed to map mphy base registers\n");
> +
> +	host->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(host->rst))
> +		return dev_err_probe(dev, PTR_ERR(host->rst),
> +				"failed to get reset control\n");
> +
> +	reset_control_assert(host->rst);
> +	udelay(1);
> +	reset_control_deassert(host->rst);
> +
> +	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
> +	if (IS_ERR(host->ref_out_clk))
> +		return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
> +				"ref_out clock unavailable\n");
> +
> +	host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(host->rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(host->rst_gpio),
> +				"failed to get reset gpio\n");
> +
> +	err = devm_clk_bulk_get_all_enable(dev, &host->clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to enable clocks\n");
> +
> +	host->hba = hba;
> +
> +	ufshcd_set_variant(hba, host);
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	int ret;
> +
> +	hba->quirks = UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING;
> +
> +	/* Enable BKOPS when suspend */
> +	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
> +	/* Enable putting device into deep sleep */
> +	hba->caps |= UFSHCD_CAP_DEEPSLEEP;
> +	/* Enable devfreq of UFS */
> +	hba->caps |= UFSHCD_CAP_CLK_SCALING;
> +	/* Enable WriteBooster */
> +	hba->caps |= UFSHCD_CAP_WB_EN;
> +
> +	/* Set the default desired pm level in case no users set via sysfs */
> +	ufs_rockchip_set_pm_lvl(hba);
> +
> +	ret = ufs_rockchip_common_init(hba);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "ufs common init fail\n");
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_device_reset(struct ufs_hba *hba)
> +{
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	gpiod_set_value_cansleep(host->rst_gpio, 1);
> +	usleep_range(20, 25);
> +
> +	gpiod_set_value_cansleep(host->rst_gpio, 0);
> +	usleep_range(20, 25);
> +
> +	return 0;
> +}
> +
> +static const struct ufs_hba_variant_ops ufs_hba_rk3576_vops = {
> +	.name = "rk3576",
> +	.init = ufs_rockchip_rk3576_init,
> +	.device_reset = ufs_rockchip_device_reset,
> +	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
> +	.phy_initialization = ufs_rockchip_rk3576_phy_init,
> +};
> +
> +static const struct of_device_id ufs_rockchip_of_match[] = {
> +	{ .compatible = "rockchip,rk3576-ufshc", .data = &ufs_hba_rk3576_vops },
> +};
> +MODULE_DEVICE_TABLE(of, ufs_rockchip_of_match);
> +
> +static int ufs_rockchip_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct ufs_hba_variant_ops *vops;
> +	int err;
> +
> +	vops = device_get_match_data(dev);
> +	if (!vops)
> +		return dev_err_probe(dev, -ENODATA, "ufs_hba_variant_ops not defined.\n");
> +
> +	err = ufshcd_pltfrm_init(pdev, vops);
> +	if (err)
> +		return dev_err_probe(dev, err, "ufshcd_pltfrm_init failed\n");
> +
> +	return 0;
> +}
> +
> +static void ufs_rockchip_remove(struct platform_device *pdev)
> +{
> +	ufshcd_pltfrm_remove(pdev);
> +}
> +
> +#ifdef CONFIG_PM
> +static int ufs_rockchip_runtime_suspend(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	clk_disable_unprepare(host->ref_out_clk);
> +
> +	/* Do not power down the genpd if rpm_lvl is less than level 5 */
> +	dev_pm_genpd_rpm_always_on(dev, hba->rpm_lvl < UFS_PM_LVL_5 ? true : false);
> +
> +	return ufshcd_runtime_suspend(dev);
> +}
> +
> +static int ufs_rockchip_runtime_resume(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +	int err;
> +
> +	err = clk_prepare_enable(host->ref_out_clk);
> +	if (err) {
> +		dev_err(hba->dev, "failed to enable ref_out clock %d\n", err);
> +		return err;
> +	}
> +
> +	reset_control_assert(host->rst);
> +	udelay(1);
> +	reset_control_deassert(host->rst);
> +
> +	return ufshcd_runtime_resume(dev);
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ufs_rockchip_system_suspend(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +	int err;
> +
> +	/*
> +	 * If spm_lvl is less than level 5, it means we need to keep the host
> +	 * controller in powered-on state. So device_set_awake_path() is
> +	 * calling pm core to notify the genpd provider to meet this requirement
> +	 */
> +	if (hba->spm_lvl < UFS_PM_LVL_5)
> +		device_set_awake_path(dev);
> +
> +	err = ufshcd_system_suspend(dev);
> +	if (err) {
> +		dev_err(hba->dev, "UFSHCD system susped failed %d\n", err);
> +		return err;
> +	}
> +
> +	clk_disable_unprepare(host->ref_out_clk);
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_system_resume(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +	int err;
> +
> +	err = clk_prepare_enable(host->ref_out_clk);
> +	if (err) {
> +		dev_err(hba->dev, "failed to enable ref_out clock %d\n", err);
> +		return err;
> +	}
> +
> +	return ufshcd_system_resume(dev);
> +}
> +#endif
> +
> +static const struct dev_pm_ops ufs_rockchip_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_system_suspend, ufs_rockchip_system_resume)
> +	SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
> +	.prepare	 = ufshcd_suspend_prepare,
> +	.complete	 = ufshcd_resume_complete,
> +};
> +
> +static struct platform_driver ufs_rockchip_pltform = {
> +	.probe = ufs_rockchip_probe,
> +	.remove = ufs_rockchip_remove,
> +	.driver = {
> +		.name = "ufshcd-rockchip",
> +		.pm = &ufs_rockchip_pm_ops,
> +		.of_match_table = ufs_rockchip_of_match,
> +	},
> +};
> +module_platform_driver(ufs_rockchip_pltform);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Rockchip UFS Host Driver");
> diff --git a/drivers/ufs/host/ufs-rockchip.h b/drivers/ufs/host/ufs-rockchip.h
> new file mode 100644
> index 0000000..3ba6fb9
> --- /dev/null
> +++ b/drivers/ufs/host/ufs-rockchip.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Rockchip UFS Host Controller driver
> + *
> + * Copyright (C) 2025 Rockchip Electronics Co., Ltd.
> + */
> +
> +#ifndef _UFS_ROCKCHIP_H_
> +#define _UFS_ROCKCHIP_H_
> +
> +#define SEL_TX_LANE0 0x0
> +#define SEL_TX_LANE1 0x1
> +#define SEL_TX_LANE2 0x2
> +#define SEL_TX_LANE3 0x3
> +#define SEL_RX_LANE0 0x4
> +#define SEL_RX_LANE1 0x5
> +#define SEL_RX_LANE2 0x6
> +#define SEL_RX_LANE3 0x7
> +
> +#define VND_TX_CLK_PRD                  0xAA
> +#define VND_TX_CLK_PRD_EN               0xA9
> +#define VND_TX_LINERESET_PVALUE2        0xAB
> +#define VND_TX_LINERESET_PVALUE1        0xAC
> +#define VND_TX_LINERESET_VALUE          0xAD
> +#define VND_TX_BASE_NVALUE              0x93
> +#define VND_TX_TASE_VALUE               0x94
> +#define VND_TX_POWER_SAVING_CTRL        0x7F
> +#define VND_RX_CLK_PRD                  0x12
> +#define VND_RX_CLK_PRD_EN               0x11
> +#define VND_RX_LINERESET_PVALUE2        0x1B
> +#define VND_RX_LINERESET_PVALUE1        0x1C
> +#define VND_RX_LINERESET_VALUE          0x1D
> +#define VND_RX_LINERESET_OPTION         0x25
> +#define VND_RX_POWER_SAVING_CTRL        0x2F
> +#define VND_RX_SAVE_DET_CTRL            0x1E
> +
> +#define CMN_REG23                       0x8C
> +#define CMN_REG25                       0x94
> +#define TRSV0_REG08                     0xE0
> +#define TRSV1_REG08                     0x220
> +#define TRSV0_REG14                     0x110
> +#define TRSV1_REG14                     0x250
> +#define TRSV0_REG15                     0x134
> +#define TRSV1_REG15                     0x274
> +#define TRSV0_REG16                     0x128
> +#define TRSV1_REG16                     0x268
> +#define TRSV0_REG17                     0x12C
> +#define TRSV1_REG17                     0x26c
> +#define TRSV0_REG18                     0x120
> +#define TRSV1_REG18                     0x260
> +#define TRSV0_REG29                     0x164
> +#define TRSV1_REG29                     0x2A4
> +#define TRSV0_REG2E                     0x178
> +#define TRSV1_REG2E                     0x2B8
> +#define TRSV0_REG3C                     0x1B0
> +#define TRSV1_REG3C                     0x2F0
> +#define TRSV0_REG3D                     0x1B4
> +#define TRSV1_REG3D                     0x2F4
> +
> +#define MPHY_CFG                        0x200
> +#define MPHY_CFG_ENABLE                 0x40
> +#define MPHY_CFG_DISABLE                0x0
> +
> +#define MIB_T_DBG_CPORT_TX_ENDIAN       0xc022
> +#define MIB_T_DBG_CPORT_RX_ENDIAN       0xc023
> +
> +struct ufs_rockchip_host {
> +	struct ufs_hba *hba;
> +	void __iomem *ufs_phy_ctrl;
> +	void __iomem *ufs_sys_ctrl;
> +	void __iomem *mphy_base;
> +	struct gpio_desc *rst_gpio;
> +	struct reset_control *rst;
> +	struct clk *ref_out_clk;
> +	struct clk_bulk_data *clks;
> +	uint64_t caps;
> +};
> +
> +#define ufs_sys_writel(base, val, reg)                                    \
> +	writel((val), (base) + (reg))
> +#define ufs_sys_readl(base, reg) readl((base) + (reg))
> +#define ufs_sys_set_bits(base, mask, reg)                                 \
> +	ufs_sys_writel(                                                   \
> +		(base), ((mask) | (ufs_sys_readl((base), (reg)))), (reg))
> +#define ufs_sys_ctrl_clr_bits(base, mask, reg)                                 \
> +	ufs_sys_writel((base),                                            \
> +			    ((~(mask)) & (ufs_sys_readl((base), (reg)))), \
> +			    (reg))
> +
> +#endif /* _UFS_ROCKCHIP_H_ */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்


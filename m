Return-Path: <linux-pm+bounces-21214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B833AA249E3
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62A03A64D5
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE91C3C1B;
	Sat,  1 Feb 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlq1Xel1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63811C242C
	for <linux-pm@vger.kernel.org>; Sat,  1 Feb 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424071; cv=none; b=Clx78d0eX0eQqzooGRbJE+kjfwiIH3GfQP6XShN3eWtpiYMp2wvnJ3qkKsZ1GD0Utz8AQRMU+NX1DU8qfciVq3Lf9ad9soyJ8D0KkJUdLgY2y60I4Ka2EMLKKcIHPbo7SRR8iU4JUA2jh8YHJQwMbO77eDPpID9a2aechkIpBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424071; c=relaxed/simple;
	bh=Rl01kiwwYr8uJHw5f9hkSyAU76ukoAmwIdgGVdom4n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCaF+MSSfDuSA1TPSa370Zya9VpkPuSUc7zU65pftN9k5m3UBYxrkT2ZK8xhdQw3BB7tUTCl40AzeQwVQcuTBSzqENCcC7RZ07A5bSEpoLlAjyl65kCuHPb/4UL0u4kpQyxzGrDeEgSXeBdiP7j4NdMh0Cgp4ZlgLb+s+dOxPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlq1Xel1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21669fd5c7cso51717785ad.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Feb 2025 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738424069; x=1739028869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jd3HO21MNgsfWC8kGSCmtRDzWOk0w1fSCGBi/ui5WkY=;
        b=vlq1Xel1+7BPq4V4mkKKGJidDRoupPIYvmMEQ2EeoG+qia1X/bmzuj8CiZpLcKehD9
         /T1U/DhIRMs3Nw/hLSrT7RhOzfpC7bbGrklyMJONBlpUP2dhpWGCVzSA5nxn6RnLaCp6
         PUSt9ucPBUWNW8O2CC19pg1wWIbZA1KsQGBpAPLQGvnjJeqZaCoNSiDtOJx1q0zo8Cyc
         eWtuaailEF1j9d6UtWOzxwqd6FBggRIij3hSACNNrTdIUPvJEit2CsBRnnmUgUt1NJjE
         h9KFL+uvT9VwWL7BMit5JdPzs+NnJ8Tpr2xKPJS/hM8aW86qs56DqLgy2VhKq6zrBBCB
         GfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424069; x=1739028869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd3HO21MNgsfWC8kGSCmtRDzWOk0w1fSCGBi/ui5WkY=;
        b=O500eDzhQ3KVQRaIMq30+PdAv7MQwmAdKCduXGyhNKoqzGS3iEgMAuvGAkLhcULdho
         xI1pmpKw2wfNPiS5raN/DN5FY6t9BC4baPAMIBkykGhnJnbqVcOOuxaM3jZV7i+kNEvD
         EQwxfm/moFJl1oIXI8h+OB8KmBgjjQ50stdOTv7IbwLqgx29TfYlj5IR9tRL6sQJAKDJ
         sriUF9ulv1wD5G6fTBL/qUbyU6YH4lFuQQ3Lqz1EWomvuHAiLrrp8N91ftHGeCQS1pmt
         rqbNrGkkuphv+OjekSYwj6+qFzGR2X653qCOfODTSZu+mTq/Gl8PNz4p1ScgxavupSx8
         Dprg==
X-Forwarded-Encrypted: i=1; AJvYcCXV+hE5GFaIl0tyR/nfY1SqvQRrBevAXoNBZ6DsHYi+WUEtcFStRjvQAPDO1yXuzWA6KT+3cLMKug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwChS7OIAqyQxvLlBv3iIGat5i2CTtjjS5K7mqsyYMI0OLS2fSv
	jFnQ6J47ftMxAFzzwwDPWteZt3pjfsmg0iNxnQcih6wSR2bf7wFdJgYbFdhIDQ==
X-Gm-Gg: ASbGncsiJPqEm/n9DhtoX4gIbS0tGMWht/IEZEwulBzR5v1teOZU5MtLTVYM4PcYj9Y
	zF6b4NcsRnvGObrl60CG44VnpxJLTFCvsJCOTCfVBWS4TmrWmBPiFydnnqW6YuwrYV6m/1S/UW0
	O+Fmvj6ksmZTQa5VyX+ElEhdDUbrpdi2scgmkbsupxeF5AptgxZ+LKYKG1DL5KyGg3VkdyHq999
	ZqUdv+dqB2DJiPEiVuRhH7GlnbS+jINPTJhcozYR2UG6N/mGAg2BvAjKe4BxczIE0vDYoOMTIbf
	doM0HtFOSufLww1oSeSSGKxBHn4=
X-Google-Smtp-Source: AGHT+IFvHigdCF+bWokfR86BH1c6cWd6or03ijZ+NG8Ig7QvrwdvfoEQTF1wIJcQT6Ll9zEBFcPTWg==
X-Received: by 2002:a05:6a20:841c:b0:1e1:aab8:3887 with SMTP id adf61e73a8af0-1ed7a6e1625mr23889303637.39.1738424068776;
        Sat, 01 Feb 2025 07:34:28 -0800 (PST)
Received: from thinkpad ([120.56.202.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bda9sm5161506b3a.26.2025.02.01.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 07:34:28 -0800 (PST)
Date: Sat, 1 Feb 2025 21:04:14 +0530
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
Subject: Re: [PATCH v6 6/7] scsi: ufs: rockchip: initial support for UFS
Message-ID: <20250201153414.ot66dfn5s77klhfp@thinkpad>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
 <1737428427-32393-7-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1737428427-32393-7-git-send-email-shawn.lin@rock-chips.com>

On Tue, Jan 21, 2025 at 11:00:26AM +0800, Shawn Lin wrote:
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
> 
> ---
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
>  drivers/ufs/host/ufs-rockchip.c | 363 ++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-rockchip.h |  46 +++++
>  4 files changed, 422 insertions(+)
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
> index 0000000..6c38785
> --- /dev/null
> +++ b/drivers/ufs/host/ufs-rockchip.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Rockchip UFS Host Controller driver
> + *
> + * Copyright (C) 2024 Rockchip Electronics Co., Ltd.

2025

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
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x40);

Can you please add definitions for these hex values.

> +	for (int i = 0; i < 2; i++) {
> +		/* Configuration M-TX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xaa, SEL_TX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xa9, SEL_TX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xad, SEL_TX_LANE0 + i), 0x44);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xac, SEL_TX_LANE0 + i), 0xe6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xab, SEL_TX_LANE0 + i), 0x07);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x94, SEL_TX_LANE0 + i), 0x93);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x93, SEL_TX_LANE0 + i), 0xc9);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x7f, SEL_TX_LANE0 + i), 0x00);
> +		/* Configuration M-RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, SEL_RX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x11, SEL_RX_LANE0 + i), 0x00);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1d, SEL_RX_LANE0 + i), 0x58);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1c, SEL_RX_LANE0 + i), 0x8c);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1b, SEL_RX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x25, SEL_RX_LANE0 + i), 0xf6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x2f, SEL_RX_LANE0 + i), 0x69);
> +	}
> +	/* disable the mphy DME_SET cfg */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x00);
> +
> +	ufs_sys_writel(host->mphy_base, 0x80, 0x08C);

Same here and below.

> +	ufs_sys_writel(host->mphy_base, 0xB5, 0x110);
> +	ufs_sys_writel(host->mphy_base, 0xB5, 0x250);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x134);
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x274);
> +
> +	ufs_sys_writel(host->mphy_base, 0x38, 0x0E0);
> +	ufs_sys_writel(host->mphy_base, 0x38, 0x220);
> +
> +	ufs_sys_writel(host->mphy_base, 0x50, 0x164);
> +	ufs_sys_writel(host->mphy_base, 0x50, 0x2A4);
> +
> +	ufs_sys_writel(host->mphy_base, 0x80, 0x178);
> +	ufs_sys_writel(host->mphy_base, 0x80, 0x2B8);
> +
> +	ufs_sys_writel(host->mphy_base, 0x18, 0x1B0);
> +	ufs_sys_writel(host->mphy_base, 0x18, 0x2F0);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x128);
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x268);
> +
> +	ufs_sys_writel(host->mphy_base, 0x20, 0x12C);
> +	ufs_sys_writel(host->mphy_base, 0x20, 0x26C);
> +
> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x120);
> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x260);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x094);
> +
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x1B4);
> +	ufs_sys_writel(host->mphy_base, 0x03, 0x2F4);
> +
> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x08C);
> +	usleep_range(1, 2);
> +	ufs_sys_writel(host->mphy_base, 0x00, 0x08C);
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
> +	/* system control register for hci */
> +	host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
> +	if (IS_ERR(host->ufs_sys_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(host->ufs_sys_ctrl),
> +				"Failed to map HCI system control registers\n");
> +
> +	/* system control register for mphy */

I don't think this comment is right. Moreover, you can get rid of these.

> +	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
> +	if (IS_ERR(host->ufs_phy_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
> +				"Failed to map mphy system control registers\n");
> +
> +	/* mphy base register */
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
> +	usleep_range(1, 2);

For less than 10us delay, it is recommended to use udelay().

> +	reset_control_deassert(host->rst);
> +
> +	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
> +	if (IS_ERR(host->ref_out_clk))
> +		return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
> +				"ref_out unavailable\n");

"ref_cout clock unavailable"

> +
> +	host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(host->rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(host->rst_gpio),
> +				"invalid reset-gpios property in node\n");

"failed to get reset gpio"

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
> +	struct ufs_hba *hba;
> +	int err;
> +
> +	vops = device_get_match_data(dev);
> +	if (!vops)
> +		return dev_err_probe(dev, -EINVAL, "ufs_hba_variant_ops not defined.\n");

-ENODATA

> +
> +	err = ufshcd_pltfrm_init(pdev, vops);
> +	if (err)
> +		return dev_err_probe(dev, err, "ufshcd_pltfrm_init failed\n");
> +
> +	hba = platform_get_drvdata(pdev);

What is this for?

> +
> +	return 0;
> +}
> +
> +static void ufs_rockchip_remove(struct platform_device *pdev)
> +{
> +	struct ufs_hba *hba = platform_get_drvdata(pdev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	ufshcd_pltfrm_remove(pdev);
> +	clk_disable_unprepare(host->ref_out_clk);

You have used devm_ helpers for acquiring the clock.

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
> +	/* Shouldn't power down if rpm_lvl is less than level 5. */

/* Do not power down the genpd if rpm_lvl is less than level 5 */

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
> +		dev_err(hba->dev, "failed to enable ref out clock %d\n", err);

Please use either 'ref_out' or 'ref out' in error messages.

> +		return err;
> +	}
> +
> +	reset_control_assert(host->rst);
> +	usleep_range(1, 2);

udelay()

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
> +	 * If spm_lvl is less than level 5, it means we need to keep
> +	 * the host in powered-on state. So device_set_awake_path()

s/host/host controller

> +	 * is calling pm core to notify the genpd provider to meet
> +	 * this requirement.
> +	 */

Please make use of 80 column width.

> +	if (hba->spm_lvl < UFS_PM_LVL_5)
> +		device_set_awake_path(dev);
> +
> +	err = ufshcd_system_suspend(dev);
> +	if (err) {
> +		dev_err(hba->dev, "system susped failed %d\n", err);

"UFSHCD system suspend failed"

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
> +		dev_err(hba->dev, "failed to enable ref out clock %d\n", err);

Same comment for 'ref out' clock.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


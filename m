Return-Path: <linux-pm+bounces-17290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58B9C35E3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289B7B2173F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D85EAF9;
	Mon, 11 Nov 2024 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K2/5z0mv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m607.netease.com (mail-m607.netease.com [210.79.60.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBB1F61C;
	Mon, 11 Nov 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288374; cv=none; b=a/o1z63AkuLHeLHxpXdCpiP2VTy0ao4vtNlzW/lroicoY6cPvsnYjIEt3UqtjBlXCXvfr6Scijv271b63IM59SbOggH4kJJeMN+6LE9o7GOcWpDzPlrj4lj/OKYLIgADljBvLpux2w4J3nngZhOAvqArGsNyMuoGaCW4ECSMVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288374; c=relaxed/simple;
	bh=f7sH2eW7NTL8/YazqaUwuhUqvhd4cczrTRfuj4FX7pE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dr+7dH2T4+wYnQzEB4+a7Hv3bDLMjMMRIEeLYqPOZ45rfHCwy1m+x9H0p1S9UGFr4pG95g6vjSkNTHtHLxCb3S8oOQpYAXFh8xr9kpx/At3JmUPWeSu9NdUC/Ga/m0N526XsFbIpzZGGeuzvvMCC0YsC9+a5z9XXzTrFT9x8FWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K2/5z0mv; arc=none smtp.client-ip=210.79.60.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 255f4fb1;
	Mon, 11 Nov 2024 09:10:39 +0800 (GMT+08:00)
Message-ID: <13ad21bb-9f5a-4a4b-8b65-55243f6fe817@rock-chips.com>
Date: Mon, 11 Nov 2024 09:10:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] scsi: ufs: rockchip: initial support for UFS
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
 <1730705521-23081-8-git-send-email-shawn.lin@rock-chips.com>
 <20241109121249.vncqbacvpnpf6d34@thinkpad>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241109121249.vncqbacvpnpf6d34@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05KTVYZSE1DT05CTBlKHRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9318c5d91a09cckunm255f4fb1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6NSo4SjIZLCwfDCs#CjEz
	GisaCx1VSlVKTEhKSUNMT09KTkpOVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpNS0xDNwY+
DKIM-Signature:a=rsa-sha256;
	b=K2/5z0mvh5MFIL9hq3jEn5PIdd2p6VguR7Iu+22K2ZYClRJOEr+8zVR+dTuzgS6zwN3wCH2pgQZUe3NCD5S4meGXzRLn4d0Gxt948MhYv9wgILcwNKLwyXmhD5NRnu4TJp2LKETMY5WRfIIY/Nk/Ws+lqePe12rdpoOeMuSgGSc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=zGyXevi51828h+DenpQzWeojCrJCFBSFPaw/0aGhpfE=;
	h=date:mime-version:subject:message-id:from;

Hi Mani,

在 2024/11/9 20:12, Manivannan Sadhasivam 写道:
> On Mon, Nov 04, 2024 at 03:32:01PM +0800, Shawn Lin wrote:
>> RK3576 SoC contains a UFS controller, add initial support for it.
>> The features are:
>> (1) support UFS 2.0 features
>> (2) High speed up to HS-G3
>> (3) 2RX-2TX lanes
>> (4) auto H8 entry and exit
>>
>> Software limitation:
>> (1) HCE procedure: enable controller->enable intr->dme_reset->dme_enable
>> (2) disable unipro timeout values before power mode change
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v4:
>> - deal with power domain of rpm and spm suggested by Ulf
>> - Fix typo and disable clks in ufs_rockchip_remove
>> - remove clk_disable_unprepare(host->ref_out_clk) from
>>    ufs_rockchip_remove
>>
>> Changes in v3:
>> - reword Kconfig description
>> - elaborate more about controller in commit msg
>> - use rockchip,rk3576-ufshc for compatible
>> - remove useless header file
>> - remove inline for ufshcd_is_device_present
>> - use usleep_range instead
>> - remove initialization, reverse Xmas order
>> - remove useless varibles
>> - check vops for null
>> - other small fixes for err path
>> - remove pm_runtime_set_active
>> - fix the active and inactive reset-gpios logic
>> - fix rpm_lvl and spm_lvl to 5 and move to end of probe path
>> - remove unnecessary system PM callbacks
>> - use UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE instead
>>    of UFSHCI_QUIRK_BROKEN_HCE
>>
>> Changes in v2: None
>>
>>   drivers/ufs/host/Kconfig        |  12 ++
>>   drivers/ufs/host/Makefile       |   1 +
>>   drivers/ufs/host/ufs-rockchip.c | 340 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/host/ufs-rockchip.h |  51 ++++++
>>   4 files changed, 404 insertions(+)
>>   create mode 100644 drivers/ufs/host/ufs-rockchip.c
>>   create mode 100644 drivers/ufs/host/ufs-rockchip.h
>>
>> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
>> index 580c8d0..191fbd7 100644
>> --- a/drivers/ufs/host/Kconfig
>> +++ b/drivers/ufs/host/Kconfig
>> @@ -142,3 +142,15 @@ config SCSI_UFS_SPRD
>>   
>>   	  Select this if you have UFS controller on Unisoc chipset.
>>   	  If unsure, say N.
>> +
>> +config SCSI_UFS_ROCKCHIP
>> +	tristate "Rockchip UFS host controller driver"
>> +	depends on SCSI_UFSHCD_PLATFORM && (ARCH_ROCKCHIP || COMPILE_TEST)
>> +	help
>> +	  This selects the Rockchip specific additions to UFSHCD platform driver.
>> +	  UFS host on Rockchip needs some vendor specific configuration before
>> +	  accessing the hardware which includes PHY configuration and vendor
>> +	  specific registers.
>> +
>> +	  Select this if you have UFS controller on Rockchip chipset.
>> +	  If unsure, say N.
>> diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
>> index 4573aea..2f97feb 100644
>> --- a/drivers/ufs/host/Makefile
>> +++ b/drivers/ufs/host/Makefile
>> @@ -10,5 +10,6 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
>>   obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
>>   obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
>>   obj-$(CONFIG_SCSI_UFS_RENESAS) += ufs-renesas.o
>> +obj-$(CONFIG_SCSI_UFS_ROCKCHIP) += ufs-rockchip.o
>>   obj-$(CONFIG_SCSI_UFS_SPRD) += ufs-sprd.o
>>   obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
>> diff --git a/drivers/ufs/host/ufs-rockchip.c b/drivers/ufs/host/ufs-rockchip.c
>> new file mode 100644
>> index 0000000..9c277bc
>> --- /dev/null
>> +++ b/drivers/ufs/host/ufs-rockchip.c
>> @@ -0,0 +1,340 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Rockchip UFS Host Controller driver
>> + *
>> + * Copyright (C) 2024 Rockchip Electronics Co.Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/gpio.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_wakeup.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +
>> +#include <ufs/ufshcd.h>
>> +#include <ufs/unipro.h>
>> +#include "ufshcd-pltfrm.h"
>> +#include "ufs-rockchip.h"
>> +
>> +static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
>> +					 enum ufs_notify_change_status status)
>> +{
>> +	int err = 0;
>> +
>> +	if (status == POST_CHANGE)
>> +		err = ufshcd_vops_phy_initialization(hba);
> 
> return ufshcd_vops_phy_initialization()
> 
>> +
>> +	return err;
> 
> return 0

Will fix this.

> 
>> +}
>> +
>> +static void ufs_rockchip_set_pm_lvl(struct ufs_hba *hba)
>> +{
>> +	hba->rpm_lvl = UFS_PM_LVL_5;
> 
> Are you sure that you want to power down both the device and link during runtime
> suspend?
> 

Yes, this is what we need for our product by default.

>> +	hba->spm_lvl = UFS_PM_LVL_5;
>> +}
>> +
>> +static int ufs_rockchip_rk3576_phy_init(struct ufs_hba *hba)
>> +{
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(PA_LOCAL_TX_LCC_ENABLE, 0x0), 0x0);
>> +	/* enable the mphy DME_SET cfg */
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x40);
>> +	for (int i = 0; i < 2; i++) {
>> +		/* Configuration M-TX */
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xaa, SEL_TX_LANE0 + i), 0x06);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xa9, SEL_TX_LANE0 + i), 0x02);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xad, SEL_TX_LANE0 + i), 0x44);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xac, SEL_TX_LANE0 + i), 0xe6);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xab, SEL_TX_LANE0 + i), 0x07);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x94, SEL_TX_LANE0 + i), 0x93);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x93, SEL_TX_LANE0 + i), 0xc9);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x7f, SEL_TX_LANE0 + i), 0x00);
>> +		/* Configuration M-RX */
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, SEL_RX_LANE0 + i), 0x06);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x11, SEL_RX_LANE0 + i), 0x00);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1d, SEL_RX_LANE0 + i), 0x58);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1c, SEL_RX_LANE0 + i), 0x8c);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1b, SEL_RX_LANE0 + i), 0x02);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x25, SEL_RX_LANE0 + i), 0xf6);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x2f, SEL_RX_LANE0 + i), 0x69);
>> +	}
>> +	/* disable the mphy DME_SET cfg */
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x00);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x80, 0x08C);
>> +	ufs_sys_writel(host->mphy_base, 0xB5, 0x110);
>> +	ufs_sys_writel(host->mphy_base, 0xB5, 0x250);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x134);
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x274);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x38, 0x0E0);
>> +	ufs_sys_writel(host->mphy_base, 0x38, 0x220);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x50, 0x164);
>> +	ufs_sys_writel(host->mphy_base, 0x50, 0x2A4);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x80, 0x178);
>> +	ufs_sys_writel(host->mphy_base, 0x80, 0x2B8);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x18, 0x1B0);
>> +	ufs_sys_writel(host->mphy_base, 0x18, 0x2F0);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x128);
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x268);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x20, 0x12C);
>> +	ufs_sys_writel(host->mphy_base, 0x20, 0x26C);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x120);
>> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x260);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x094);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x1B4);
>> +	ufs_sys_writel(host->mphy_base, 0x03, 0x2F4);
>> +
>> +	ufs_sys_writel(host->mphy_base, 0xC0, 0x08C);
>> +	usleep_range(1, 2);
>> +	ufs_sys_writel(host->mphy_base, 0x00, 0x08C);
>> +
>> +	usleep_range(200, 250);
>> +	/* start link up */
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_TX_ENDIAN, 0), 0x0);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_RX_ENDIAN, 0), 0x0);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID, 0), 0x0);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID_VALID, 0), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_PEERDEVICEID, 0), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_CONNECTIONSTATE, 0), 0x1);
> 
> I assume that the PHY doesn't have any separate resources like clocks and you
> just need to write these registers.
> 

yes.

>> +
>> +	return 0;
>> +}
>> +
>> +static int ufs_rockchip_common_init(struct ufs_hba *hba)
>> +{
>> +	struct device *dev = hba->dev;
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct ufs_rockchip_host *host;
>> +	int err;
> 
> Reverse Xmas tree please (but I don't insist).

Will fix.

> 
>> +
>> +	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
>> +	if (!host)
>> +		return -ENOMEM;
>> +
>> +	/* system control register for hci */
>> +	host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
>> +	if (IS_ERR(host->ufs_sys_ctrl))
>> +		return dev_err_probe(dev, PTR_ERR(host->ufs_sys_ctrl),
>> +					"cannot ioremap for hci system control register\n");
> 
> "Failed to map HCI system control registers"
> 
> Similar for other messages below.
> 
>> +
>> +	/* system control register for mphy */
>> +	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
>> +	if (IS_ERR(host->ufs_phy_ctrl))
>> +		return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
>> +				"cannot ioremap for mphy system control register\n");
>> +
>> +	/* mphy base register */
>> +	host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
>> +	if (IS_ERR(host->mphy_base))
>> +		return dev_err_probe(dev, PTR_ERR(host->mphy_base),
>> +				"cannot ioremap for mphy base register\n");
>> +
>> +	host->rst = devm_reset_control_array_get_exclusive(dev);
>> +	if (IS_ERR(host->rst))
>> +		return dev_err_probe(dev, PTR_ERR(host->rst),
>> +				"failed to get reset control\n");
>> +
>> +	reset_control_assert(host->rst);
>> +	usleep_range(1, 2);
>> +	reset_control_deassert(host->rst);
>> +
>> +	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
>> +	if (IS_ERR(host->ref_out_clk))
>> +		return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
>> +				"ref_out unavailable\n");
>> +
>> +	host->rst_gpio = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(host->rst_gpio))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(host->rst_gpio),
>> +				"invalid reset-gpios property in node\n");
>> +
>> +	host->clks[0].id = "core";
>> +	host->clks[1].id = "pclk";
>> +	host->clks[2].id = "pclk_mphy";
> 
> No need to hardcode clocks in the driver. You can just use clk_bulk_get_all() to
> get the clocks from DT. DT binding should make sure that the clocks are present
> in DT.

Good idea, will fix.

> 
>> +	err = devm_clk_bulk_get_optional(dev, UFS_MAX_CLKS, host->clks);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "failed to get clocks\n");
>> +
>> +	err = clk_bulk_prepare_enable(UFS_MAX_CLKS, host->clks);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "failed to enable clocks\n");
>> +
>> +	host->hba = hba;
>> +
>> +	ufshcd_set_variant(hba, host);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
>> +{
>> +	struct device *dev = hba->dev;
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +	int ret;
>> +
>> +	hba->quirks = UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING |
>> +		      UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE;
>> +
>> +	/* Enable BKOPS when suspend */
>> +	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
>> +	/* Enable putting device into deep sleep */
>> +	hba->caps |= UFSHCD_CAP_DEEPSLEEP;
>> +	/* Enable devfreq of UFS */
>> +	hba->caps |= UFSHCD_CAP_CLK_SCALING;
>> +	/* Enable WriteBooster */
>> +	hba->caps |= UFSHCD_CAP_WB_EN;
>> +
>> +	host->pd_id = RK3576_PD_UFS;
>> +
>> +	ret = ufs_rockchip_common_init(hba);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "ufs common init fail\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int ufs_rockchip_device_reset(struct ufs_hba *hba)
>> +{
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +
>> +	/* Active the reset-gpios */
> 
> No need of this and below comment.

Will remove.

> 
>> +	gpiod_set_value_cansleep(host->rst_gpio, 1);
>> +	usleep_range(20, 25);
>> +
>> +	/* Inactive the reset-gpios */
>> +	gpiod_set_value_cansleep(host->rst_gpio, 0);
>> +	usleep_range(20, 25);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct ufs_hba_variant_ops ufs_hba_rk3576_vops = {
>> +	.name = "rk3576",
> 
> Unless you expect different variant ops for each chipset, you can just use
> "rockchip".

Probably we need a different variant ops, for insatnce, we may seek to
fix the hce process problem, also we probably need a different .init
process.

> 
>> +	.init = ufs_rockchip_rk3576_init,
>> +	.device_reset = ufs_rockchip_device_reset,
>> +	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
>> +	.phy_initialization = ufs_rockchip_rk3576_phy_init,
>> +};
>> +
>> +static const struct of_device_id ufs_rockchip_of_match[] = {
>> +	{ .compatible = "rockchip,rk3576-ufshc", .data = &ufs_hba_rk3576_vops },
>> +};
>> +MODULE_DEVICE_TABLE(of, ufs_rockchip_of_match);
>> +
>> +static int ufs_rockchip_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	const struct ufs_hba_variant_ops *vops;
>> +	struct ufs_hba *hba;
>> +	int err;
>> +
>> +	vops = device_get_match_data(dev);
>> +	if (!vops)
>> +		return dev_err_probe(dev, -EINVAL, "ufs_hba_variant_ops not defined.\n");
>> +
>> +	err = ufshcd_pltfrm_init(pdev, vops);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "ufshcd_pltfrm_init failed\n");
>> +
>> +	hba = platform_get_drvdata(pdev);
>> +	/* Set the default desired pm level in case no users set via sysfs */
>> +	ufs_rockchip_set_pm_lvl(hba);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ufs_rockchip_remove(struct platform_device *pdev)
>> +{
>> +	struct ufs_hba *hba = platform_get_drvdata(pdev);
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +
>> +	pm_runtime_forbid(&pdev->dev);
>> +	pm_runtime_get_noresume(&pdev->dev);
> 
> Why do you need these? You are not incrementing the refcount in probe() and
> there is no auto PM involved.

Oh, it was a leftover from former version I haven't noticed. Will
remove.

> 
>> +	ufshcd_remove(hba);
>> +	ufshcd_dealloc_host(hba);
>> +	clk_bulk_disable_unprepare(UFS_MAX_CLKS, host->clks);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
>> +{
>> +	struct ufs_hba *hba = dev_get_drvdata(dev);
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +
>> +	clk_disable_unprepare(host->ref_out_clk);
>> +
>> +	/* Shouldn't power down if rpm_lvl is less than level 5. */
>> +	dev_pm_genpd_rpm_always_on(dev, hba->rpm_lvl < UFS_PM_LVL_5 ? true : false);
>> +
>> +	return ufshcd_runtime_suspend(dev);
>> +}
>> +
>> +static int ufs_rockchip_runtime_resume(struct device *dev)
>> +{
>> +	struct ufs_hba *hba = dev_get_drvdata(dev);
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +	int err;
>> +
>> +	err = clk_prepare_enable(host->ref_out_clk);
>> +	if (err) {
>> +		dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	reset_control_assert(host->rst);
>> +	usleep_range(1, 2);
>> +	reset_control_deassert(host->rst);
>> +
>> +	return ufshcd_runtime_resume(dev);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int ufs_rockchip_system_suspend(struct device *dev)
>> +{
>> +	struct ufs_hba *hba = dev_get_drvdata(dev);
>> +
>> +	if (hba->spm_lvl < 5)
>> +		device_set_wakeup_path(dev);
>> +	else
>> +		device_clr_wakeup_path(dev);
> 
> This should be taken care by driver core.
> 
> - Mani
> 



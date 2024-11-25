Return-Path: <linux-pm+bounces-18012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D79D7A92
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 04:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF31281E65
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6AA38DD8;
	Mon, 25 Nov 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="P06I1za6"
X-Original-To: linux-pm@vger.kernel.org
Received: from ec2-44-216-146-166.compute-1.amazonaws.com (ec2-44-216-146-166.compute-1.amazonaws.com [44.216.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8E2500C8;
	Mon, 25 Nov 2024 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.146.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507031; cv=none; b=Yimp/4SSyVBwjf8WcFMK+FzV9FPF9RK8BjO5kQN3XTxJ8h6KHcUKu+fIqP8ZqAhhBwf9U9yi5y+cQpHUwIt1ES3nF/4ecLTdK/bUQHKWONkw9QqyAK/D1Eh2b8LdSTBMVlPRLf5QZn8LAVHXSAnR/ufJYALXQllXVbeozwWOmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507031; c=relaxed/simple;
	bh=CQCvcCaf/DEmVA8JZ5C/Q3hjfbanHvOvLcNCX9WWTus=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kpgIUQY2pCYNZ8w3yTg68ClQRBEZBELr2lXRkplPzGmoZj25KgmuEg3ytCkvU7I47L+gxdPL9Xk49S2wYZomr7CtemLhOr4+5USq+8UCp95NIEcaYke0QuvU76PeWcZqnAoo1+vgOjX2QnGvWj6zS5DqLlFblCtcmo3XoY1rwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=P06I1za6; arc=none smtp.client-ip=44.216.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b1cab9c;
	Mon, 25 Nov 2024 11:41:35 +0800 (GMT+08:00)
Message-ID: <d806eb7a-3ad9-4ee1-9681-f2be28882c8a@rock-chips.com>
Date: Mon, 25 Nov 2024 11:41:36 +0800
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
Subject: Re: [PATCH v5 6/7] scsi: ufs: rockchip: initial support for UFS
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
 <1731048987-229149-7-git-send-email-shawn.lin@rock-chips.com>
 <20241123050118.g52fxwdzggsyk6en@thinkpad>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241123050118.g52fxwdzggsyk6en@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhPT1ZLSkpKGUgYHUIYSh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93616910fb09cckunm3b1cab9c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6KBw4CDIaDTErTRoWNjUT
	FzQaFAtVSlVKTEhJTktNS0JMTUhDVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNMSEI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=P06I1za6ziF5dhQt+0I0awvyNGvvhnRarGtPoT2DWRphFOdywbPVa7alTXMbppqm7BnrklAzMp9ldMsPkk/GYVlK8xIxALFQEAgStZDWfB5eBS/ntUQKfsVaW+nG8r0wv//IZ7NB/IjJC37gF3ZdV8pkVzn8bgdemsfO3jRf+EI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=a7sIHQbo5it0LvIWy6bOuOFcXjjrX3CWrnDlJ+wrRI4=;
	h=date:mime-version:subject:message-id:from;

在 2024/11/23 13:01, Manivannan Sadhasivam 写道:
> On Fri, Nov 08, 2024 at 02:56:25PM +0800, Shawn Lin wrote:
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
>> Changes in v5:
>> - use device_set_awake_path() and disable ref_out_clk in suspend
>> - remove pd_id from header
>> - recontruct ufs_rockchip_hce_enable_notify() to workaround hce enable
>>    without using new quirk
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
>>   drivers/ufs/host/ufs-rockchip.c | 368 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/host/ufs-rockchip.h |  48 ++++++
>>   4 files changed, 429 insertions(+)
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
>> index 0000000..b087ce0
>> --- /dev/null
>> +++ b/drivers/ufs/host/ufs-rockchip.c
> 
> [...]
> 
>> +
>> +	host->clks[0].id = "core";
>> +	host->clks[1].id = "pclk";
>> +	host->clks[2].id = "pclk_mphy";
>> +	err = devm_clk_bulk_get_optional(dev, UFS_MAX_CLKS, host->clks);
> 
> Still not using clk_bulk_get_all()? as suggested previously?

I missed the comment, will fix.

> 
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
>> +	int ret;
>> +
>> +	hba->quirks = UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING;
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
> 
> Is it possible to move this to ufs_rockchip_rk3576_init()?

Sure.

> 
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
>> +	ufshcd_remove(hba);
>> +	ufshcd_dealloc_host(hba);
> 
> You wouldn't need these if you rebase this series on top of scsi/for-next.
> 
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
>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +	int err;
>> +
>> +	if (hba->spm_lvl < UFS_PM_LVL_5)
>> +		device_set_awake_path(dev);
> 
> It'd be worth adding a comment here as the API naming is not very clear now.
> 

Will add. Thanks.

> - Mani
> 



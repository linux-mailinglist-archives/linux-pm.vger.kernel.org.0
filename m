Return-Path: <linux-pm+bounces-17976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517DA9D678F
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 06:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A81C282451
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E982485;
	Sat, 23 Nov 2024 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWmAjqPm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2244C76
	for <linux-pm@vger.kernel.org>; Sat, 23 Nov 2024 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732338094; cv=none; b=ch7AtyVM7TZoeYQaZxIBgXtHQQU4sVgYBb0avTBgZM6th7qlpYGHA22bgJKz0+jxEV8vnGKK2GskpQsoemxcoHCJygLmD7BqoETjBcMyVN2qqyjBV8NZyvx4pGUIwt6BhtvyAE1ej7W4b6KrDMWA2tVeqC3tbK6OeRbu8MwG2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732338094; c=relaxed/simple;
	bh=z/w/ztYIED66c9kco/FCKsV8axfLYuNctYlUQNWX8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZSOkohOC2ajx3sNjWlCe40FyH8Wh9kUNmiGL1vzF6GtQtLFsg59Qxgyl5UrP+v4EJIAYyfJENcDUdiQ6O33kk0MMziW35RH5qtxcH7Gm95HAIbhxD6FZwrvK4Vxn7n8Dp4kjsvxZ5DDCYaUd+uKqyHapg441FteNLiVe8HvCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWmAjqPm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21271dc4084so27466905ad.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 21:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732338092; x=1732942892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRhZxdnf68b3VsEoqUMxxKiNnq7Wqv07flN0P13doWw=;
        b=hWmAjqPmgwEWkCDBTHNag9oV3vhO8DqgmpOspyf5EC5g5lqqeMZPqeiX9AbU1708EL
         zwDRjg4sw4dB/IkzeshbSmhrNWJXsFaRH5/mC+yBb2JknTUCpyehBs0/rPiF9h29ZPtJ
         n0HKmCZ2Oz70+pM/cX8u7aG2UWfx6sj8fekuDjKHRRJ2PmFpH5nW2PfD7XUZR+LdewHQ
         yTCn+Yv2upWYqeTn+nnkaUbcUjXzcd4zCFPw0OkvB9buIJTwQFJHWPpOByPmYdbUD73A
         kOANGF+WomVH9hFS4GdBfBG5+AYVeHkjQ9vRJ6CGlyeRNwm0vZj74VE6p5vUd0kHUbR7
         C8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732338092; x=1732942892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRhZxdnf68b3VsEoqUMxxKiNnq7Wqv07flN0P13doWw=;
        b=sUVlJZIIYoTie4K4VNjLb9hQ/BEg5q/R36PSYBvKdtOLbMnCE6SJG/sYC+sv1wktMT
         /ZPJ/dNYkK5f2tnMX0t24IcAwLcCLGzc3T1TEFxmK4zeERmdSy9szIfNNx9FG3HitxfT
         bpglgZl8K5bqpD+KAWvcr4FM0jGAyOpRXJJa6WpQz83vVv7dpGpLbqz8j22JlBylY70N
         f/lmrCqW+pL6n4/ju3pjvASGWd24XuZ4tpeb4eLj3vYQbgSoE57f8o7pV1cK2ziqkahO
         5XYDZna62OF+R63fWxNcavj187Z+3YI2wX49e7Bz4Jww9pZI4p3Zxbj5HCBw6ZzMvKyC
         SH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUF9vICY+AE3mwSVS/XPtYmtmZAjog9p3ZFu32hNUemdyrxsmNakznNeltTTzqwfyGPAj+0UpzkRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0fufSmXh4IIcrdU+INZ/nMqyJpvnDGDF0eHTmnMrhlahtkhI
	KlEVz72l9KtzrrWAyqVpW5IDNGiz9r1KqTutnJ4jzTxu+xaHns8m2qgDigwcBg==
X-Gm-Gg: ASbGncvUufTXwKVBu2zpqCpMAHcM90KqGI/WmUIcVQvZDKL/kH8LS0og9KDKy5XAHyW
	+Xn0YRD4wh0o5v9zZW+DmpKtSofcmTfn3VuIZO2tCiPTuSTAm06CBPGH2EgQkVVq5sgW0oWjKGx
	XicxeVlXVSYzguckRyGuMaetNWe80v51kmiR1UKd0WZpjkwtT+28DVw1bNl6sZSc9+dP3iTcp2W
	1NZ4Z8v02SNg+Tw2t1/QXaoV8TTHJ2QdRw4ORGfAONepPUsIV0WL79QBHQFMusETw==
X-Google-Smtp-Source: AGHT+IGYsyYlJyUW6FgltnPqSi5ulCgwfmePAnggpg17kRbIAxFCCAEp3D4QZGlxfqp4EXy+h9CrHg==
X-Received: by 2002:a17:902:f652:b0:20c:5533:36da with SMTP id d9443c01a7336-2129f68034fmr73499945ad.42.1732338091863;
        Fri, 22 Nov 2024 21:01:31 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db87dc9sm25049555ad.7.2024.11.22.21.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 21:01:31 -0800 (PST)
Date: Sat, 23 Nov 2024 10:31:18 +0530
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
Subject: Re: [PATCH v5 6/7] scsi: ufs: rockchip: initial support for UFS
Message-ID: <20241123050118.g52fxwdzggsyk6en@thinkpad>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
 <1731048987-229149-7-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1731048987-229149-7-git-send-email-shawn.lin@rock-chips.com>

On Fri, Nov 08, 2024 at 02:56:25PM +0800, Shawn Lin wrote:
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
> ---
> 
> Changes in v5:
> - use device_set_awake_path() and disable ref_out_clk in suspend
> - remove pd_id from header
> - recontruct ufs_rockchip_hce_enable_notify() to workaround hce enable
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
>  drivers/ufs/host/ufs-rockchip.c | 368 ++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-rockchip.h |  48 ++++++
>  4 files changed, 429 insertions(+)
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
> index 0000000..b087ce0
> --- /dev/null
> +++ b/drivers/ufs/host/ufs-rockchip.c

[...]

> +
> +	host->clks[0].id = "core";
> +	host->clks[1].id = "pclk";
> +	host->clks[2].id = "pclk_mphy";
> +	err = devm_clk_bulk_get_optional(dev, UFS_MAX_CLKS, host->clks);

Still not using clk_bulk_get_all()? as suggested previously?

> +	if (err)
> +		return dev_err_probe(dev, err, "failed to get clocks\n");
> +
> +	err = clk_bulk_prepare_enable(UFS_MAX_CLKS, host->clks);
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
> +	/* Active the reset-gpios */
> +	gpiod_set_value_cansleep(host->rst_gpio, 1);
> +	usleep_range(20, 25);
> +
> +	/* Inactive the reset-gpios */
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
> +
> +	err = ufshcd_pltfrm_init(pdev, vops);
> +	if (err)
> +		return dev_err_probe(dev, err, "ufshcd_pltfrm_init failed\n");
> +
> +	hba = platform_get_drvdata(pdev);
> +	/* Set the default desired pm level in case no users set via sysfs */
> +	ufs_rockchip_set_pm_lvl(hba);

Is it possible to move this to ufs_rockchip_rk3576_init()?

> +
> +	return 0;
> +}
> +
> +static void ufs_rockchip_remove(struct platform_device *pdev)
> +{
> +	struct ufs_hba *hba = platform_get_drvdata(pdev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	ufshcd_remove(hba);
> +	ufshcd_dealloc_host(hba);

You wouldn't need these if you rebase this series on top of scsi/for-next.

> +	clk_bulk_disable_unprepare(UFS_MAX_CLKS, host->clks);
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
> +		return err;
> +	}
> +
> +	reset_control_assert(host->rst);
> +	usleep_range(1, 2);
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
> +	if (hba->spm_lvl < UFS_PM_LVL_5)
> +		device_set_awake_path(dev);

It'd be worth adding a comment here as the API naming is not very clear now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


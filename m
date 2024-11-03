Return-Path: <linux-pm+bounces-16904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB29BA58D
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 14:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18451C208D3
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9616E895;
	Sun,  3 Nov 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="luModrrd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F823774;
	Sun,  3 Nov 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730639364; cv=none; b=UhMd1xh7NQD9vcgH3yMDb11wf02GVbdISaxWp/d68Gi0B+X0YB7kVZi2nTGXML8082y1NCRG5buUjQAq7brwd4YLw3PNgaTlURh07g0Rortenwte2+5H9z3jaI4yvmhDYOodJO2NzI0AKkiwFy0SOPohn9FB7jpyvgv/+mRdON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730639364; c=relaxed/simple;
	bh=guXELeytpG22NADybLXxugiStFOd+DdhkkVWeTpYpvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiwtcaNoNqmxMoFJskMf0DwQwq+5qK9GXPI0ZNFA+zE628nAYbGBqymYciNmhnmIVe/CU7RXlaOsPeqQRFNwUU2N7XLuZNwq7VQyfQg52MIEA1lz3Nz+yOsL3XgL2xmzsLEmUnfojX3OWaUriOo7PUINhfXnHQCJL1xpxbgOWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=luModrrd; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7aLrtuVZGGfMn7aLrt2ZJd; Sun, 03 Nov 2024 14:09:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730639353;
	bh=pHCYMRyEhUD58GA3IYCTR1CfQUuJWA0GVifKU3o2xlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=luModrrdwcGEIRjb4I/DgierMEI21v2l9+D4OLiHpFiQ/o5mxJZNY5ktBocmR2DxI
	 HF53OlIc+M5352fldvfSHl04LKpI7WpYAq1qQ3HyETKnHfTj1fVvqR/44FRTvnhC43
	 /cXUW4MEuF4/lUqHIs4npnWFJJGMHOg9/5EMw+orXtbbLHi0nA1dw+Uisv/OWT7KUS
	 h6S4slSIV1G/0gMAl6/vfcyw4Kv1Y7uVupPr6ADHCcGP0mni5PY6Gxy+vZnp+pe8Mi
	 4k5nr7vZgwmq+mt3mMSVwCq4OCbW7aMxNzW7PTqOksalYlmKCyhgChkKdMTiTgqi9o
	 KB2RORauQAwyA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 03 Nov 2024 14:09:13 +0100
X-ME-IP: 90.11.132.44
Message-ID: <96938e54-70cf-4e81-9072-8af48883a769@wanadoo.fr>
Date: Sun, 3 Nov 2024 14:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/10/2024 à 08:15, Shawn Lin a écrit :
> RK3576 SoC contains a UFS controller, add initial support fot it.

s/fot/for/

> The features are:
> (1) support UFS 2.0 features
> (2) High speed up to HS-G3
> (3) 2RX-2TX lanes
> (4) auto H8 entry and exit
> 
> Software limitation:
> (1) HCE procedure: enbale controller->enbale intr->dme_reset->dme_enable

s/enbale/enable/ 	x 2

> (2) disable unipro timeout values before power mode change
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 

No need for an extra empty line

> ---

...

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
> +					"cannot ioremap for hci system control register\n");
> +
> +	/* system control register for mphy */
> +	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
> +	if (IS_ERR(host->ufs_phy_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
> +				"cannot ioremap for mphy system control register\n");
> +
> +	/* mphy base register */
> +	host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
> +	if (IS_ERR(host->mphy_base))
> +		return dev_err_probe(dev, PTR_ERR(host->mphy_base),
> +				"cannot ioremap for mphy base register\n");
> +
> +	host->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(host->rst))
> +		return dev_err_probe(dev, PTR_ERR(host->rst),
> +				"failed to get reset control\n");
> +
> +	reset_control_assert(host->rst);
> +	usleep_range(1, 2);
> +	reset_control_deassert(host->rst);
> +
> +	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
> +	if (IS_ERR(host->ref_out_clk))
> +		return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
> +				"ref_out unavailable\n");
> +
> +	host->rst_gpio = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(host->rst_gpio))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(host->rst_gpio),
> +				"invalid reset-gpios property in node\n");
> +
> +	host->clks[0].id = "core";
> +	host->clks[1].id = "pclk";
> +	host->clks[2].id = "pclk_mphy";
> +	err = devm_clk_bulk_get_optional(dev, UFS_MAX_CLKS, host->clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to get clocks\n");
> +
> +	err = clk_bulk_prepare_enable(UFS_MAX_CLKS, host->clks);

This has to be undone somewhere, likely at the end of ufs_rockchip_remove().

> +	if (err)
> +		return dev_err_probe(dev, err, "failed to enable clocks\n");
> +
> +	host->hba = hba;
> +
> +	ufshcd_set_variant(hba, host);
> +
> +	return 0;
> +}

...

> +static const struct ufs_hba_variant_ops ufs_hba_rk3576_vops = {
> +	.name = "rk3576",
> +	.init = ufs_rockchip_rk3576_init,
> +	.device_reset = ufs_rockchip_device_reset,
> +	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
> +	.phy_initialization = ufs_rockchip_rk3576_phy_init,
> +};
> +
> +static const struct of_device_id ufs_rockchip_of_match[] = {
> +	{ .compatible = "rockchip,rk3576-ufshc", .data = &ufs_hba_rk3576_vops},

Missing space before ending }

> +	{},

No need for an extra , here.

> +};
> +MODULE_DEVICE_TABLE(of, ufs_rockchip_of_match);

...

> +static void ufs_rockchip_remove(struct platform_device *pdev)
> +{
> +	struct ufs_hba *hba = platform_get_drvdata(pdev);
> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	ufshcd_remove(hba);
> +	ufshcd_dealloc_host(hba);
> +	clk_disable_unprepare(host->ref_out_clk);

No need for clk_disable_unprepare(), ref_out_clk comes from 
devm_clk_get_enabled(), so the framework will already call 
clk_disable_unprepare().

> +}

...

CJ


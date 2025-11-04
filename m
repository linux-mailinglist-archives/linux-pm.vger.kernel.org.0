Return-Path: <linux-pm+bounces-37330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D894C2EEE9
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0161896891
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06D1AB6F1;
	Tue,  4 Nov 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx6rNFZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F4163;
	Tue,  4 Nov 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222532; cv=none; b=ahn5em2Sbov7XvdaR5DcuDHSs709S9S5Fa32sYXTL4bBygUolcYZ//1F4aH8C+w8/Pn0Fd9WJzpwYCgxIpTZDy3/P7aSsIIb1e3vbkkKnVsovFDJsfh3sx81KWXIU4zDE5iuSmuA50CmIAtKpeCufmxdn8lAYZyxI38wXUOEd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222532; c=relaxed/simple;
	bh=dQ92zW9+3V1WC4s5ZqrNCMVuv35EVa7nxcb9HzrbTiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcjjJiFsJuujdP7HA+5/H5Q0WlifAyDNrHBq1mbxzNR6GA3iCVaSCnMx6k7u9aDTcds7bMZke/skSXQs/gi/6I8MNGTp1/ADDIKN96wybgkl9zWTez5hqOKtmmelaMazegwNjcmf5DmWkBvYLmN8iG5N9omQ9okRo6InFA5eW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx6rNFZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44C0C113D0;
	Tue,  4 Nov 2025 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762222532;
	bh=dQ92zW9+3V1WC4s5ZqrNCMVuv35EVa7nxcb9HzrbTiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx6rNFZXrlCoUJ6Aa/BjGEq9zb2NR98n8+yrg92Jgm5Tkzv2kkrTUXbCFVfHlaWQb
	 KTcxnqeqgqDkdxPAAne4gLrzJ5s0ibON5f8KYG02flsddbtoO33+5S0Bqt2EkUc7z1
	 YA4KbmzX8PBA8X0WN8XAeWAp6sUFe8wG285NsCgztyCiI8u5L2ilJ9kgw+qUYcWbDs
	 V8uN41h+O4k6cdJe9oAW0Cm1VjNZO6fG66MHTiQ0vjlgE8dcUSKSljNlFZdmxal9wn
	 avW4j6DKzYeGaAtSUneomM06Nh/UuWzrA1my9ScpEvOpfV6fCttD3nyrGPUQEBDype
	 LiMsrMGAmqmcQ==
Date: Mon, 3 Nov 2025 20:19:04 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
Message-ID: <qa3njabggj2dczlfwr2fpke57ufjypqvmso445lfeu6gck2ogt@zdkhuka5vpm3>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 07:20:03PM +0100, Loic Poulain wrote:
> This mechanism can be used when firmware lacks proper warm-reset handling,
> for example, when the PSCI SYSTEM_RESET2 function is not implemented.
> It enables the warm reset functionality via the PMIC.
> 
> This fallback is only enabled if qcom,warm-reset property is present.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582..684e9fe9987d 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -19,12 +19,20 @@
>  
>  #define NO_REASON_SHIFT			0
>  
> +#define PON_SW_RESET_S2_CTL				0x62
> +#define		PON_SW_RESET_S2_CTL_WARM_RST	0x01
> +#define PON_SW_RESET_S2_CTL2				0x63
> +#define		PON_SW_RESET_S2_CTL2_RST_EN	BIT(7)
> +#define PON_SW_RESET_GO					0x64
> +#define		PON_SW_RESET_GO_MAGIC		0xa5
> +
>  struct qcom_pon {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	u32 baseaddr;
>  	struct reboot_mode_driver reboot_mode;
>  	long reason_shift;
> +	bool warm_reset;
>  };
>  
>  static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
> @@ -44,6 +52,37 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
>  	return ret;
>  }
>  
> +static int pm8916_pon_reset(struct sys_off_data *data)
> +{
> +	struct qcom_pon *pon = data->cb_data;
> +	int ret;
> +
> +	if (!pon->warm_reset || data->mode != REBOOT_WARM)
> +		return NOTIFY_DONE;
> +
> +	ret = regmap_write(pon->regmap,
> +			   pon->baseaddr + PON_SW_RESET_S2_CTL,
> +			   PON_SW_RESET_S2_CTL_WARM_RST);
> +	if (ret)
> +		return NOTIFY_BAD;
> +
> +	ret = regmap_update_bits(pon->regmap,
> +				 pon->baseaddr + PON_SW_RESET_S2_CTL2,
> +				 PON_SW_RESET_S2_CTL2_RST_EN,
> +				 PON_SW_RESET_S2_CTL2_RST_EN);
> +	if (ret)
> +		return NOTIFY_BAD;
> +
> +	ret = regmap_write(pon->regmap, pon->baseaddr + PON_SW_RESET_GO,
> +			   PON_SW_RESET_GO_MAGIC);
> +	if (ret)
> +		return NOTIFY_BAD;
> +
> +	mdelay(100);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int qcom_pon_probe(struct platform_device *pdev)
>  {
>  	struct qcom_pon *pon;
> @@ -80,8 +119,16 @@ static int qcom_pon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pon->warm_reset = of_property_read_bool(pdev->dev.of_node, "qcom,warm-reset");
> +
>  	platform_set_drvdata(pdev, pon);
>  
> +	/* Higher priority than psci to handle warm-reset properly */
> +	error = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
> +					      pm8916_pon_reset, pon);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error, "reboot registration fail\n");
> +
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>  
> -- 
> 2.34.1
> 


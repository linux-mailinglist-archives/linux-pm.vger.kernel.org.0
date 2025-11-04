Return-Path: <linux-pm+bounces-37366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD7AC3168B
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E053D189A03F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472F32B9A9;
	Tue,  4 Nov 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUXLJ4Zj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35C2F658D;
	Tue,  4 Nov 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265093; cv=none; b=neISC5cAU68CHhWvvbapXUu+Xft/0mxjLEDxpywgM3xjmtM0MCpN0jC14XrAwY4XA3120TmuhMR3d8UcMS6PnU+9tdeTQyqfZt4GpOJCphfelSF58BFXGeE1JtqIXo+VbCDj1LYmi3EHC+Lj6pDwso3FCPo9DHTiS+WJx2Lecfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265093; c=relaxed/simple;
	bh=tCefD0wLZBYGYTrUxDzn9Z0PuVqiT7SpCPGolGJHNnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcdw8zV9BuDBwqqA0FJSPJlgVRQ+ujP+zzuL+XX3wa1NzkFi/4mxtTU5FIAIbmI/o3t/ZCAD3J2ZAPNu1DworDP0oeNsXwl8reKVL/qwFR4hRgqiAV7nqtg+WK/m6/UJYalFi8UJzYKS+kJ3WnuG/0/WnPpnmCDLm93t6rhrf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUXLJ4Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C70FC4CEF7;
	Tue,  4 Nov 2025 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265092;
	bh=tCefD0wLZBYGYTrUxDzn9Z0PuVqiT7SpCPGolGJHNnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUXLJ4ZjnO2InzMM39MwQ6uF1AtjPgnFre/MMy64PFysZoebTkowXiQZwK8rbRbRY
	 XLDwk5oRAxcwRvh+JWy62JPZLL1Fx85ieNxrFVGZDfB53XvQdLwHXn0ejDhLGd0yz9
	 qdHO2nqhHLqJTtryQH+Upvc1cnkxegSN/jpUIT3CF2rawXcrDGxeA4tp+AVlytsoO7
	 SahybARKcChbpDsnpXwaO1X9YrdAFy2BOF6VrjDujM9pKeeiiEk21Ny0Pdi/ZVJRWo
	 zUjPCUqQF9sSjvPt0NhLFj3JCo0448KGBZSEmvhkly2a/Uzx6a+D0CvgCLTwO3ivYx
	 eSEjjuz5DuqAQ==
Date: Tue, 4 Nov 2025 15:04:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
Message-ID: <20251104-kind-invisible-barracuda-1babfa@kuoka>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

And here is proof from the binding - you just tell what the drivers
should do.

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-35335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B1B9F0C5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDA7B2734
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225752FBE1A;
	Thu, 25 Sep 2025 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/Tv/Ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEE25B67D;
	Thu, 25 Sep 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801512; cv=none; b=nmbwq7r+I0FpN68LKQJBKYNd0fHtqI31eS0JogRIiPbGtdwG8MJZY36AK7IYxWdh96J2hBB5sOkBbyvbXMHZiZPs76jApEZ86ExzZVuk3gDDGcZeFRYUBco7UvR9lGyziBRYwFITEJXSDBUC4lPIEg5NtgG7PbXhY8DIDuTZso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801512; c=relaxed/simple;
	bh=PLOJmWe01Uk2xXo1/1N6xdVfBzeJP8kEAvLRKwPnMM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVldvL9AWmbFMnux9pQeo5ZoBww9D+OyEZ0mGEEl9duXCorEQiFmU97wHv7T3pMq+IFXJc/Y1+4VJFOxuNCQ3ZUlik3ufyCm+6OJGCK2K4xsBuME7QVlwJahRmpA/1gcwe6/aiAudcmfIJylYx9fDSblL3+pIqwdG/4CXaPgbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/Tv/Ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273CCC4CEF0;
	Thu, 25 Sep 2025 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758801511;
	bh=PLOJmWe01Uk2xXo1/1N6xdVfBzeJP8kEAvLRKwPnMM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0/Tv/NgPndWjcoNpy0FgCPe6Z1xqwNjVfArEKdjHFIx8Ln0w3nQBsTuJ9mx/aanw
	 XjJHCXFYSp8PgL/CYFCX5FrsdL90aMM29/f1AxGdgTelADZFJR+3gc6OA9/e5+Oiyv
	 Ig+7jRLEslB5LasbhtRag9nKNpYz6a7Zppb3JgkWDpoJtjpwcEpKtivqOHPtx1d/ni
	 IilNUVPhNmYgw9kt74qjG+p7bhvW2PZcTjmy8jFANytKhNW53/VriZMD2w7UZvdjaJ
	 yZp9jUYvtBb/2kjPfSRU6Sflqyj9kkQsLXXSlILYd2rR0FvPeOMexIsoASMX+XkA3C
	 c6xv97tb7CUsw==
Date: Thu, 25 Sep 2025 12:58:27 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/3] mfd: bd71828, bd71815 prepare for power-supply
 support
Message-ID: <20250925115827.GI8757@google.com>
References: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
 <20250918-bd71828-charger-v5-1-851164839c28@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918-bd71828-charger-v5-1-851164839c28@kemnade.info>

On Thu, 18 Sep 2025, Andreas Kemnade wrote:

> From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rohm-bd71828.c       | 44 ++++++++++++++++++++++------
>  include/linux/mfd/rohm-bd71828.h | 63 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index a14b7aa69c3c6..84a64c3b9c9f5 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -45,8 +45,8 @@ static const struct resource bd71828_rtc_irqs[] = {
>  
>  static const struct resource bd71815_power_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_RMV, "bd71815-dcin-rmv"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-clps-out"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-clps-in"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-dcin-clps-out"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-dcin-clps-in"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_RES, "bd71815-dcin-ovp-res"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_DET, "bd71815-dcin-ovp-det"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_MON_RES, "bd71815-dcin-mon-res"),
> @@ -56,7 +56,7 @@ static const struct resource bd71815_power_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_RES, "bd71815-vsys-low-res"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_DET, "bd71815-vsys-low-det"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_DET, "bd71815-vsys-mon-det"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TEMP, "bd71815-chg-wdg-temp"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TIME, "bd71815-chg-wdg"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_RECHARGE_RES, "bd71815-rechg-res"),
> @@ -87,10 +87,10 @@ static const struct resource bd71815_power_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_2_DET, "bd71815-bat-oc2-det"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_RES, "bd71815-bat-oc3-res"),
>  	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_DET, "bd71815-bat-oc3-det"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-bat-low-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-bat-low-det"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-bat-hi-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-bat-hi-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-temp-bat-low-res"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-temp-bat-low-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-temp-bat-hi-res"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-temp-bat-hi-det"),
>  };
>  
>  static const struct mfd_cell bd71815_mfd_cells[] = {
> @@ -109,7 +109,30 @@ static const struct mfd_cell bd71815_mfd_cells[] = {
>  	},
>  };
>  
> -static const struct mfd_cell bd71828_mfd_cells[] = {
> +static const struct resource bd71828_power_irqs[] = {
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_CHG_TOPOFF_TO_DONE,
> +			     "bd71828-chg-done"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_DET, "bd71828-pwr-dcin-in"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_RMV, "bd71828-pwr-dcin-out"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_RES,
> +			     "bd71828-vbat-normal"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_DET, "bd71828-vbat-low"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_DET, "bd71828-btemp-hi"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_RES, "bd71828-btemp-cool"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_DET, "bd71828-btemp-lo"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_RES,
> +			     "bd71828-btemp-warm"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_DET,
> +			     "bd71828-temp-hi"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_RES,
> +			     "bd71828-temp-norm"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_DET,
> +			     "bd71828-temp-125-over"),
> +	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_RES,
> +			     "bd71828-temp-125-under"),

Use 100-chars to make this nicer on the eye.

Everything else is fine.

No need to rush - it's -rc7 already - you have until next cycle.

-- 
Lee Jones [李琼斯]


Return-Path: <linux-pm+bounces-33710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3562B41ED6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23543A4956
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5B2F8BEE;
	Wed,  3 Sep 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqpedU9I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953B23A98E;
	Wed,  3 Sep 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902196; cv=none; b=ttg8DyYDs10bx5gAD2xQqrRM9pOKGG7krnNBUJWrOdOZT+Mxu2h+e3gOi7quJmjDsmdkf53Vik5iy2XcMWM7gvIcXxIxuIao0060mAiAU1L6XWB6CdFral5fg/BP6pfbdaokmbTXHA6rP08GuvM5lgkRJMKL8g/YozAAOWzzRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902196; c=relaxed/simple;
	bh=Z98dAcPclodrALxdxpImMnPWgr4ksADUiqpJIuMidFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzwxCJvCaHCcPSHDrhCRt8+1eZCE0hU0/GwHrVthGvQ4Ri5xm1SistS5OQM5eS2wyWbDjI5FDszs+xwD0hejlQVT+Wq8rkdQfzS91Q8Nc6sD6WEkxf3qGVc0yYMZhBtmMq014mhjzi9rdzvh5qlw5+RmwvtPigbRl5LfRYKkX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqpedU9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C48C4CEF0;
	Wed,  3 Sep 2025 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756902195;
	bh=Z98dAcPclodrALxdxpImMnPWgr4ksADUiqpJIuMidFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqpedU9Ir/TmRShQjnGo6Ne0Erq5RKMe3RvTPklIBVCvawxYoVT2RY2hqhIFbQPmC
	 gtZFu2JQm2nftX8w5CcwYxUQ3spBzotdiy9e5zFoc7Q08xIH5AvEg1SP0vctv5NHGq
	 VB0TXBPDxbrU8AIkwtyeN+T29YQ/gUhWB1ZaZdTfMH+n5Ue/sJhSaIbWPUfqfsHzAH
	 iYxggocFHQeJ3RgJC0qzvLjA1w0uYtZIqqMqQDvEF0dRC6olYWSOo7RvKL3FSBx/Tr
	 zxD3aW8hHMO7v4c6B5YgLYhj5PS33m3OZGyOUaaaD30WdpD7S9rf+Sg3M8vEWclLye
	 Wo2/XbK8ZlvUQ==
Date: Wed, 3 Sep 2025 13:23:11 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/3] mfd: bd71828, bd71815 prepare for power-supply
 support
Message-ID: <20250903122311.GN2163762@google.com>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-1-cc74ac4e0fb9@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821-bd71828-charger-v3-1-cc74ac4e0fb9@kemnade.info>

On Thu, 21 Aug 2025, Andreas Kemnade wrote:

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

Looks okay.

I'm guessing the Power patch depends on this one?

Would this break anything if taken on its own?

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
> +};
> +
> +static struct mfd_cell bd71828_mfd_cells[] = {
>  	{ .name = "bd71828-pmic", },
>  	{ .name = "bd71828-gpio", },
>  	{ .name = "bd71828-led", .of_compatible = "rohm,bd71828-leds" },
> @@ -118,8 +141,11 @@ static const struct mfd_cell bd71828_mfd_cells[] = {
>  	 * BD70528 clock gate are the register address and mask.
>  	 */
>  	{ .name = "bd71828-clk", },
> -	{ .name = "bd71827-power", },
>  	{
> +		.name = "bd71828-power",
> +		.resources = bd71828_power_irqs,
> +		.num_resources = ARRAY_SIZE(bd71828_power_irqs),
> +	}, {
>  		.name = "bd71828-rtc",
>  		.resources = bd71828_rtc_irqs,
>  		.num_resources = ARRAY_SIZE(bd71828_rtc_irqs),
> diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
> index ce786c96404a3..73a71ef691525 100644
> --- a/include/linux/mfd/rohm-bd71828.h
> +++ b/include/linux/mfd/rohm-bd71828.h
> @@ -189,6 +189,69 @@ enum {
>  /* Charger/Battey */
>  #define BD71828_REG_CHG_STATE		0x65
>  #define BD71828_REG_CHG_FULL		0xd2
> +#define BD71828_REG_CHG_EN		0x6F
> +#define BD71828_REG_DCIN_STAT		0x68
> +#define BD71828_MASK_DCIN_DET		0x01
> +#define BD71828_REG_VDCIN_U		0x9c
> +#define BD71828_MASK_CHG_EN		0x01
> +#define BD71828_CHG_MASK_DCIN_U		0x0f
> +#define BD71828_REG_BAT_STAT		0x67
> +#define BD71828_REG_BAT_TEMP		0x6c
> +#define BD71828_MASK_BAT_TEMP		0x07
> +#define BD71828_BAT_TEMP_OPEN		0x07
> +#define BD71828_MASK_BAT_DET		0x20
> +#define BD71828_MASK_BAT_DET_DONE	0x10
> +#define BD71828_REG_CHG_STATE		0x65
> +#define BD71828_REG_VBAT_U		0x8c
> +#define BD71828_MASK_VBAT_U		0x0f
> +#define BD71828_REG_VBAT_REX_AVG_U	0x92
> +
> +#define BD71828_REG_OCV_PWRON_U		0x8A
> +
> +#define BD71828_REG_VBAT_MIN_AVG_U	0x8e
> +#define BD71828_REG_VBAT_MIN_AVG_L	0x8f
> +
> +#define BD71828_REG_CC_CNT3		0xb5
> +#define BD71828_REG_CC_CNT2		0xb6
> +#define BD71828_REG_CC_CNT1		0xb7
> +#define BD71828_REG_CC_CNT0		0xb8
> +#define BD71828_REG_CC_CURCD_AVG_U	0xb2
> +#define BD71828_MASK_CC_CURCD_AVG_U	0x3f
> +#define BD71828_MASK_CC_CUR_DIR		0x80
> +#define BD71828_REG_VM_BTMP_U		0xa1
> +#define BD71828_REG_VM_BTMP_L		0xa2
> +#define BD71828_MASK_VM_BTMP_U		0x0f
> +#define BD71828_REG_COULOMB_CTRL	0xc4
> +#define BD71828_REG_COULOMB_CTRL2	0xd2
> +#define BD71828_MASK_REX_CC_CLR		0x01
> +#define BD71828_MASK_FULL_CC_CLR	0x10
> +#define BD71828_REG_CC_CNT_FULL3	0xbd
> +#define BD71828_REG_CC_CNT_CHG3		0xc1
> +
> +#define BD71828_REG_VBAT_INITIAL1_U	0x86
> +#define BD71828_REG_VBAT_INITIAL1_L	0x87
> +
> +#define BD71828_REG_VBAT_INITIAL2_U	0x88
> +#define BD71828_REG_VBAT_INITIAL2_L	0x89
> +
> +#define BD71828_REG_IBAT_U		0xb0
> +#define BD71828_REG_IBAT_L		0xb1
> +
> +#define BD71828_REG_IBAT_AVG_U		0xb2
> +#define BD71828_REG_IBAT_AVG_L		0xb3
> +
> +#define BD71828_REG_VSYS_AVG_U		0x96
> +#define BD71828_REG_VSYS_AVG_L		0x97
> +#define BD71828_REG_VSYS_MIN_AVG_U	0x98
> +#define BD71828_REG_VSYS_MIN_AVG_L	0x99
> +#define BD71828_REG_CHG_SET1		0x75
> +#define BD71828_REG_ALM_VBAT_LIMIT_U	0xaa
> +#define BD71828_REG_BATCAP_MON_LIMIT_U	0xcc
> +#define BD71828_REG_CONF		0x64
> +
> +#define BD71828_REG_DCIN_CLPS		0x71
> +
> +#define BD71828_REG_MEAS_CLEAR		0xaf
>  
>  /* LEDs */
>  #define BD71828_REG_LED_CTRL		0x4A
> 
> -- 
> 2.39.5
> 

-- 
Lee Jones [李琼斯]


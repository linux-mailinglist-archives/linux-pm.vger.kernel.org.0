Return-Path: <linux-pm+bounces-32491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AEBB29913
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 07:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEFF16A755
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657F2451F3;
	Mon, 18 Aug 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7KHs78T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF307F9D6;
	Mon, 18 Aug 2025 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496172; cv=none; b=MYKlEUFCojExghSfdjC1VfH3ew/E1EqxH+v7SYPSLOm+ZyIhembsxnCKMBhs6qxgsdyoCLV+pHSY/U28D60/HLodBvPrK9vw6D0xEuknAfPcfT70XE0Pvq70jb/YHzxVe+4E7X8Gpd5L4WMlYXlyBpkkHq9dIKOpW5k61AZKjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496172; c=relaxed/simple;
	bh=s4ZVtdWQXFlOMESeQQcGAzANdm695ZVoGuKbaeUm0E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qo8lV0kTWACqQt3IZos+s4eHvNXptEC9RfELCyw4HcttBEtHlqmllX/sGFWU8DjS4zCDu7JQvbHvgRHyJlp8q9jbcUiG3kVr/ztVZfw15ZV/LNZKWqtEmPEOAoTEnukTZjMN1t0pcEsM6jOFA1asBuftRcu+hSSwAP8bGby7tC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7KHs78T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce526ac04so3569185e87.2;
        Sun, 17 Aug 2025 22:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496169; x=1756100969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRUSO5XeEvrbOshq7Av3JAHBHhQf7+u8lkRg+JM5bBY=;
        b=b7KHs78TZ33990ZsNeU7ZeMawgFGNia2yyy3Cvs/70SpP5APp3YhccGXZAW/ITJmUa
         4Y27cEJ+fr0vaZHukpqH8SCG2G1gjdLRpQ8MFhLUvxYbiq0d/nNSbSW3tS/XQvXgzHno
         sJLJAKmO5mKXUpEFAVqQZYBzU40pBDkDOLvHzpG29TWuvXy8lgxPsokzYBeQdbjJhs/3
         21520rdq8MtgMsVx67RAIJzGkdMH5posFUKLEBuouAHDhdLa5MbTMepGa/6usxAyV7QZ
         KLST2B8sSm8/1zVOUrTzvOb9+9gu/kiL+JMLR4OPtXUB0M8bp8QDiVSLEb/xFBT2Ja/g
         EN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496169; x=1756100969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRUSO5XeEvrbOshq7Av3JAHBHhQf7+u8lkRg+JM5bBY=;
        b=B30j2jOO5swRX8jO3lEXEviySv+7Mwy5F7Be03EUZCEs8q6ciEVKPRAhJBkOddJbi3
         pG5vdvLCpbLrVGFe66q7nUBIWY0zbTXiEVMJaK5Ge/xO9ceMwxfxfr29NhKQTpaI0swn
         UguAW/HTIziSOW3Swp0U+aFSVM9upIV8uKBKa8hUfkpSEFzKR1uRFQ9X4qFFCS3EyPW8
         Exa7+0SBRIpCJLOAF3qyfNKTHTtQJ+C/R5HQ607tftHWVEr2Qwhki0YtsDtkY3KMzYaP
         Zz1wNATygdXhvlk/ZUtK42uXR2lhx/B/oxwQr4sjIQKpTg4f8MdFRU9P+XB44VZ4SEST
         XG/A==
X-Forwarded-Encrypted: i=1; AJvYcCVWR2fX0Qg5jlEZ97zpB/L2tTtPiSD1FQlEAGWKh4bAHOn7tovTP3OyNMSJAAonOfULSEErkRqoiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QXMMXB5cAduT14m5H4eRsWC0wSw0UFHjMgcH7DFyubsegMtM
	2rIr9NdF1ZFx2RUiN7EE/r5XbA0altGa63pCUdpfVOx2Xj0zckGIVbvX
X-Gm-Gg: ASbGnctDz5gk8mfrJKGf2+wKVIVYQbH6H9Xiiv/wvOLCOh8O3gmvfSBSBX+UAK9ECjd
	K2SSdWmKXnjpXGUA3A4fh8XoLRiBYgCTmyTBrSqS4HqxEiUozwtFzx8BG0szxp4bhLQ5TX3gSt4
	XBza8juAQYoiHRpTlmxQI/0J0D+h3FsfgAjdeTzzWq2qDbFVnT0x2ULonpnQ1CeMt0/x90iw/qy
	stfENl3lp+dLgAgV1bGJns0reAHCoZGFgOCuNrlUVl4dSK5xw+MLgTaO0TQi1Elyzc0OBajtNGg
	OGgJ92ZFuAWWN1X7fEjOAEl4h0/WBPQ8CdhTV5a7l85SrDY0WaIhWGDq0GelWx2JcinOafRfhdF
	rX9pG1kxutTVcR2KmuDSC1gDv7Jwl/EKBx3rrmXanQVlRUWpljYzseCAp4YNJmewMyxwCPGkS7o
	/HaWSsj2Ha1umFeQ==
X-Google-Smtp-Source: AGHT+IEB34sI0qCJ0Y9x9PsAw/WsRsjdL7Hj+K0oOTk1BmS1Ip/nLCiS1xb8s9lFCbSDjpGXumuOGw==
X-Received: by 2002:a05:6512:3345:b0:55b:89e4:fdfd with SMTP id 2adb3069b0e04-55ceeae3d3cmr2574538e87.14.1755496168679;
        Sun, 17 Aug 2025 22:49:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351384sm1543661e87.35.2025.08.17.22.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:49:28 -0700 (PDT)
Message-ID: <6ebcdc8b-0b8e-489b-9f93-ebfd2d850432@gmail.com>
Date: Mon, 18 Aug 2025 08:49:27 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mfd: bd71828, bd71815 prepare for power-supply
 support
To: "Andreas Kemnade,,," <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-1-71b11bde5c73@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250816-bd71828-charger-v1-1-71b11bde5c73@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks a ton for picking up from where I left it Andreas! :) I _really_ 
do love seeing this proceeding. This has haunted me and I actually still 
have a JIRA item pending for this work - although that's one of those 
items which might never get done - I just couldn't delete it after 
putting quite bit of effort to this :(

I hope that effort benefits someone!

Just one comment:

On 16/08/2025 22:19, Andreas Kemnade,,, wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/mfd/rohm-bd71828.c       | 44 +++++++++++++++++++++------
>   include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/mfd/rohm-generic.h |  2 ++
>   3 files changed, 102 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index a14b7aa69c3c61d51f2aeeae9afdf222310d63e3..84a64c3b9c9f52e663855c89ed78ede9a7c21f55 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -45,8 +45,8 @@ static const struct resource bd71828_rtc_irqs[] = {
>   
>   static const struct resource bd71815_power_irqs[] = {
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_RMV, "bd71815-dcin-rmv"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-clps-out"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-clps-in"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-dcin-clps-out"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-dcin-clps-in"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_RES, "bd71815-dcin-ovp-res"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_DET, "bd71815-dcin-ovp-det"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_MON_RES, "bd71815-dcin-mon-res"),
> @@ -56,7 +56,7 @@ static const struct resource bd71815_power_irqs[] = {
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_RES, "bd71815-vsys-low-res"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_DET, "bd71815-vsys-low-det"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_DET, "bd71815-vsys-mon-det"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TEMP, "bd71815-chg-wdg-temp"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TIME, "bd71815-chg-wdg"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_RECHARGE_RES, "bd71815-rechg-res"),
> @@ -87,10 +87,10 @@ static const struct resource bd71815_power_irqs[] = {
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_2_DET, "bd71815-bat-oc2-det"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_RES, "bd71815-bat-oc3-res"),
>   	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_DET, "bd71815-bat-oc3-det"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-bat-low-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-bat-low-det"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-bat-hi-res"),
> -	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-bat-hi-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-temp-bat-low-res"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-temp-bat-low-det"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-temp-bat-hi-res"),
> +	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-temp-bat-hi-det"),
>   };
>   
>   static const struct mfd_cell bd71815_mfd_cells[] = {
> @@ -109,7 +109,30 @@ static const struct mfd_cell bd71815_mfd_cells[] = {
>   	},
>   };
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
>   	{ .name = "bd71828-pmic", },
>   	{ .name = "bd71828-gpio", },
>   	{ .name = "bd71828-led", .of_compatible = "rohm,bd71828-leds" },
> @@ -118,8 +141,11 @@ static const struct mfd_cell bd71828_mfd_cells[] = {
>   	 * BD70528 clock gate are the register address and mask.
>   	 */
>   	{ .name = "bd71828-clk", },
> -	{ .name = "bd71827-power", },
>   	{
> +		.name = "bd71828-power",
> +		.resources = bd71828_power_irqs,
> +		.num_resources = ARRAY_SIZE(bd71828_power_irqs),
> +	}, {
>   		.name = "bd71828-rtc",
>   		.resources = bd71828_rtc_irqs,
>   		.num_resources = ARRAY_SIZE(bd71828_rtc_irqs),
> diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
> index ce786c96404a3dc9d5124ffbbd507df89ca0e5ba..a34991984caa8724e925f1c59de4bcfa543ae411 100644
> --- a/include/linux/mfd/rohm-bd71828.h
> +++ b/include/linux/mfd/rohm-bd71828.h
> @@ -189,6 +189,71 @@ enum {
>   /* Charger/Battey */
>   #define BD71828_REG_CHG_STATE		0x65
>   #define BD71828_REG_CHG_FULL		0xd2
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
> +
> +
>   
>   /* LEDs */
>   #define BD71828_REG_LED_CTRL		0x4A
> diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
> index 579e8dcfcca41d2680283819684a1014617d0d4b..5e9d0da380ec0fc3245bee998c791a162a34e3fa 100644
> --- a/include/linux/mfd/rohm-generic.h
> +++ b/include/linux/mfd/rohm-generic.h
> @@ -13,9 +13,11 @@ enum rohm_chip_type {
>   	ROHM_CHIP_TYPE_BD9574,
>   	ROHM_CHIP_TYPE_BD9576,
>   	ROHM_CHIP_TYPE_BD71815,
> +	ROHM_CHIP_TYPE_BD71827,

Reading you drop the BD71827 support (which sounds like the right thing 
to do) - do we still need this?

>   	ROHM_CHIP_TYPE_BD71828,
>   	ROHM_CHIP_TYPE_BD71837,
>   	ROHM_CHIP_TYPE_BD71847,
> +	ROHM_CHIP_TYPE_BD71878,
>   	ROHM_CHIP_TYPE_BD96801,
>   	ROHM_CHIP_TYPE_BD96802,
>   	ROHM_CHIP_TYPE_BD96805,
> 

Yours,
	-- Matti



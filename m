Return-Path: <linux-pm+bounces-32773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33732B2EE60
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CBF6817EE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38672853EE;
	Thu, 21 Aug 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEIknj1s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79561255248;
	Thu, 21 Aug 2025 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758298; cv=none; b=hQiPZgG/GcC+iH0TveHMm/7sHdzcve8cpquYqEe1+nupi0VsCPIPYpeQ24OeXhPh2Yrec5LWZdamEY9Vh+OlSP2l8yWizpLvBru8+KF31NdvTH8CS5pM60WQMyJ7OZBXn3oofZlXbdu51evgHKWTyCQSgBbNqIDpJ/DLebyDZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758298; c=relaxed/simple;
	bh=/mDEX3953jp5s/x2KgDhex/rXgURz55E6DtLYrQxu6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StLyfj4wl7gi/87/c7KwK9HTD74TjoNgvppziKoKaIsVVwC6Q15C+hcHxjjTO3SxIqFdKk/GlQDIg548qWAEEn1Ke18Gh5MfEY7c+5eOSp3lYNc7epnCu7iy0k7otUltBuLmQwB7fxQvY88AhG+RDfn28omVLslgmx9pE4BJoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEIknj1s; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce5097493so559486e87.0;
        Wed, 20 Aug 2025 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755758294; x=1756363094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLOdHqr7HlsM4BgbQ8ThvDLMa5W4hZQJapCuK4TPKfk=;
        b=JEIknj1sYSNn60dddyCLuQ9VR+KyDZRWkj2508yimdZLZ4+pXNi4QG68FVloMGHoTP
         WIvLpK508Xh+nBLKDd6faDzPjjWU5iW//bUZh9ILj2nkayrXTOr1CM/xCB+u+X+I3PyM
         53wa5F87QSZiKnQoA6+HaKIXSXGykGG8qimjlBS86zdNweLc2p7duuLvkK0tiJKJIgbK
         Pno3yrvwGWeZC7YRyxDK+3eqHOHIrdZt+5uT4sM5b/VX3Kx8txqmTLeLVW/a0bdTD5IT
         eL+vSpAY4fi2zSWaz/dDN1Dz4bVF7TSLeAKwg3vr0CQ28MTnDYHW//BJc8Wm88SSY3B/
         YBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758294; x=1756363094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLOdHqr7HlsM4BgbQ8ThvDLMa5W4hZQJapCuK4TPKfk=;
        b=hJwfkrjKrl2rmJRlRLd1KhxtmxNqmLJzft9WGzchwAHa4qnCaEgOJBVSW1CNCL5SWm
         gL5sBlF1X8V0r7SOOe9lDKoqlFlVbIemBc7P3NY5wLSGVEfMOl0Uek5lLnYPrQH0+c/s
         StIismpms0b1X/c/ZjyUuoFlbmwwkEEY0Q+1D4GqDfiCVrqrZI2JyyOqiu1RewXU2jmn
         F708Avh6EInz5BkPG9wrZLDAfb6F0FYKVS6m0ih7jlIGG+tAmJILNo10o0LvlGm1CuSY
         fSn0UKtCj8UnuhL2ZAtVBVlzkk+QPhYJ0TOf2ORekKXhTl7ow+C2ic51eLUyU1m6BwHZ
         Akpg==
X-Forwarded-Encrypted: i=1; AJvYcCX0vfe7ugvejki8XvOxA4FZP4uupDUndfQKpXXUfT4r1qu1j0SEvhxAvqH3SuXv16gNNYTYPqzURQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIy5r8n2HLTlkmGLqFkaIPEmlR7g9yFr20f99d9tZd47l/YKlp
	X+EbIkBfzNY/ndTjjPAnwNWaTGOvdGSZvZWq4+qc2SHHmtab0cDKx1q2
X-Gm-Gg: ASbGncvw34e3ZOj4TlnxAbAD0JmsbMxE3Epx1fsy0gP4QJNXnAuFy+op80/FL5zWUPJ
	cxECa6tPYsxX6yovSo2oDKvSmma2ILUQLhI7PJsC+ibj7hS3E0MwhY2mbF5NPj0IJhjT2YVWBKx
	+cxOxWvSsIJsG7GE7KSzDVLJEq6hMR5W39nvuGe2Yb+HB8pEjn6rWY9ftFYO/bMtgLlrjliDM5G
	R85lw/hv3218gJCh/UifNWDLuxjIG7H2Kcm1IdzVdo2MZedRxySrgJdI74KIyE/2g/Ycx/9S8Gf
	QEyYjwQkapAITmKWu+jFQaWuVrzlkoNYam39vvl4/vLGfYL9xjaAFv6rd9s3iWExc0C6PV4VydL
	SCEjwD7POoTwkx8Q2kAAqUWUUTMe804xXp/Byj5wy250ZWVTXz0/SWnLBAAejlOv62gqESMsOpQ
	Ebt1I0PXb0F/R/xA==
X-Google-Smtp-Source: AGHT+IEf8coY3bdZs+IwPg8Zzyq89xlYZs/Ppo54oml9p2iNdqCqLaPFIia1bcI60Gfsca04WVuWuw==
X-Received: by 2002:a05:6512:651a:b0:55b:9444:b15a with SMTP id 2adb3069b0e04-55e0d50b031mr354444e87.20.1755758294067;
        Wed, 20 Aug 2025 23:38:14 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ff472sm2903710e87.130.2025.08.20.23.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 23:38:13 -0700 (PDT)
Message-ID: <d0471494-3f95-44f3-a301-142eb745ae2f@gmail.com>
Date: Thu, 21 Aug 2025 09:38:12 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
 <20250820-bd71828-charger-v2-2-32fc96027e92@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250820-bd71828-charger-v2-2-32fc96027e92@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 23:21, Andreas Kemnade wrote:
> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
> 
> For the ease of review and to do a step-by-step approach remove all the
> coloumb counter related stuff and do not sneak in BD71827 support. That
> also avoids non-trivial rebasing of the above series.
> 
> Changes besides that:
> Replace the custom property by a standard one and do not use megaohms
> for the current sense resistor.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Thanks for doing this Andreas :) Just a question about maintenance and 
one comment. After those are handled:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

I also added couple of styling 'nits', which you can address if you agree.

> ---
>   drivers/power/supply/Kconfig         |    9 +
>   drivers/power/supply/Makefile        |    1 +
>   drivers/power/supply/bd71828-power.c | 1135 ++++++++++++++++++++++++++++++++++
>   3 files changed, 1145 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..16dddb2355d9b89ccf0ad453fb77c189cf36f00f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -974,6 +974,15 @@ config CHARGER_UCS1002
>   	  Say Y to enable support for Microchip UCS1002 Programmable
>   	  USB Port Power Controller with Charger Emulation.
>   
> +config CHARGER_BD71828
> +	tristate "Power-supply driver for ROHM BD71828 and BD71815 PMIC"
> +	depends on MFD_ROHM_BD71828
> +	help
> +	  Say Y here to enable support for charger and battery
> +	  in ROHM BD71815, BD71817, ROHM BD71828 power management
> +	  ICs. This driver gets various bits of information about battery
> +	  and charger states.
> +
>   config CHARGER_BD99954
>   	tristate "ROHM bd99954 charger driver"
>   	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index f943c9150b326d41ff241f82610f70298635eb08..c6520a11f021c872f01250ae54eb4c63018cd428 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
>   obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
>   obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
> +obj-$(CONFIG_CHARGER_BD71828)	+= bd71828-power.o
>   obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
>   obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
>   obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
> new file mode 100644

Do you think you could agree to maintain this? I would like to also be 
listed either as M: or R:

So please, add one more patch bringing in the maintainer info.

> index 0000000000000000000000000000000000000000..f074d7159de1cb832bc0fb5ab494cddeb96a8968
> --- /dev/null
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -0,0 +1,1135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * bd71828-power.c
> + * @file ROHM BD71815, BD71828 and BD71878 Charger driver
> + *
> + * Copyright 2021.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/rohm-bd71815.h>
> +#include <linux/mfd/rohm-bd71828.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +/* common defines */
> +#define BD7182x_MASK_VBAT_U			0x1f
> +#define BD7182x_MASK_VDCIN_U			0x0f
> +#define BD7182x_MASK_IBAT_U			0x3f
> +#define BD7182x_MASK_CURDIR_DISCHG		0x80
> +#define BD7182x_MASK_CC_CCNTD_HI		0x0FFF
> +#define BD7182x_MASK_CC_CCNTD			0x0FFFFFFF

nit: I would still drop the unused defines. They make this look more 
complex than it is and make also reviewing harder. (Same as with the 
unused struct members - I think the defines should be introduced in the 
patch which also uses them. (Well, register address definitions are an 
exception - I'm not against defining all register addresses in initial 
commit. Especially so when we have an MFD device, where register 
addresses tend to live in different subsystem (MFD) tree.

Well, this is just a 'nit(picking)', meaning "fix if you agree". (unless 
someone else thinks this is important). Same with the rest of the 'nit' 
comments.

> +#define BD7182x_MASK_CHG_STATE			0x7f
> +#define BD7182x_MASK_CC_FULL_CLR		0x10
> +#define BD7182x_MASK_BAT_TEMP			0x07
> +#define BD7182x_MASK_DCIN_DET			BIT(0)
> +#define BD7182x_MASK_CONF_PON			BIT(0)
> +#define BD71815_MASK_CONF_XSTB			BIT(1)
> +#define BD7182x_MASK_BAT_STAT			0x3f
> +#define BD7182x_MASK_DCIN_STAT			0x07
 > +> +#define BD7182x_MASK_CCNTRST			0x80
> +#define BD7182x_MASK_CCNTENB			0x40
> +#define BD7182x_MASK_CCCALIB			0x20
> +#define BD7182x_MASK_WDT_AUTO			0x40
> +#define BD7182x_MASK_VBAT_ALM_LIMIT_U		0x01
> +#define BD7182x_MASK_CHG_EN			0x01
> +
> +#define BD7182x_DCIN_COLLAPSE_DEFAULT		0x36
> +
> +/* Measured min and max value clear bits */
> +#define BD718XX_MASK_VSYS_MIN_AVG_CLR		0x10
> +
> +#define MAX_CURRENT_DEFAULT			890000		/* uA */
> +#define AC_NAME					"bd71828_ac"
> +#define BAT_NAME				"bd71828_bat"
> +
> +/*
> + * VBAT Low voltage detection Threshold
> + * 0x00D4*16mV = 212*0.016 = 3.392v
> + */
> +#define VBAT_LOW_TH			0x00D4
> +
> +#define THR_RELAX_CURRENT_DEFAULT		5		/* mA */
> +#define THR_RELAX_TIME_DEFAULT			(60 * 60)	/* sec. */
> +
> +#define DGRD_CYC_CAP_DEFAULT			88	/* 1 micro Ah */
> +
> +#define DGRD_TEMP_H_DEFAULT			450	/* 0.1 degrees C */
> +#define DGRD_TEMP_M_DEFAULT			250	/* 0.1 degrees C */
> +#define DGRD_TEMP_L_DEFAULT			50	/* 0.1 degrees C */
> +#define DGRD_TEMP_VL_DEFAULT			0	/* 0.1 degrees C */
> +
> +#define SOC_EST_MAX_NUM_DEFAULT			5
> +#define PWRCTRL_NORMAL				0x22
> +#define PWRCTRL_RESET				0x23
> +
> +/*
> + * Originally we relied upon a fixed size table of OCV and VDR params.
> + * However the exising linux power-supply batinfo interface for getting the OCV
> + * values from DT does not have fixed amount of OCV values. Thus we use fixed
> + * parameter amount only for values provided as module params - and use this
> + * only as maximum number of parameters when values come from DT.
> + */
> +#define NUM_BAT_PARAMS				23
> +#define MAX_NUM_VDR_VALUES NUM_BAT_PARAMS
> +
> +struct pwr_regs {
> +	int used_init_regs;
> +	u8 vbat_init;
> +	u8 vbat_init2;
> +	u8 vbat_init3;
> +	u8 vbat_avg;
> +	u8 ibat;
> +	u8 ibat_avg;
> +	u8 meas_clear;
> +	u8 vsys_min_avg;
> +	u8 btemp_vth;
> +	u8 chg_state;
> +	u8 coulomb3;
> +	u8 coulomb2;
> +	u8 coulomb1;
> +	u8 coulomb0;
> +	u8 coulomb_ctrl;
> +	u8 vbat_rex_avg;
> +	u8 coulomb_full3;
> +	u8 cc_full_clr;
> +	u8 coulomb_chg3;

'nit': I still think these unused members shouldn't be introduced here. 
They belong to the patch which adds the fuel-gauging. I wouldn't be 
surprized if we saw a clean-up patch removing unused memebers if the 
fuel-gauging is not merged together with this.

> +	u8 bat_temp;
> +	u8 dcin_stat;
> +	u8 dcin_collapse_limit;
> +	u8 chg_set1;
> +	u8 chg_en;
> +	u8 vbat_alm_limit_u;
> +	u8 batcap_mon_limit_u;
> +	u8 conf;
> +	u8 vdcin;
> +};
> +
> +static const struct pwr_regs pwr_regs_bd71828 = {
> +	.vbat_init = BD71828_REG_VBAT_INITIAL1_U,
> +	.vbat_init2 = BD71828_REG_VBAT_INITIAL2_U,
> +	.vbat_init3 = BD71828_REG_OCV_PWRON_U,
> +	.used_init_regs = 3,
> +	.vbat_avg = BD71828_REG_VBAT_U,
> +	.ibat = BD71828_REG_IBAT_U,
> +	.ibat_avg = BD71828_REG_IBAT_AVG_U,
> +	.meas_clear = BD71828_REG_MEAS_CLEAR,
> +	.vsys_min_avg = BD71828_REG_VSYS_MIN_AVG_U,
> +	.btemp_vth = BD71828_REG_VM_BTMP_U,
> +	.chg_state = BD71828_REG_CHG_STATE,
> +	.coulomb3 = BD71828_REG_CC_CNT3,
> +	.coulomb2 = BD71828_REG_CC_CNT2,
> +	.coulomb1 = BD71828_REG_CC_CNT1,
> +	.coulomb0 = BD71828_REG_CC_CNT0,
> +	.coulomb_ctrl = BD71828_REG_COULOMB_CTRL,
> +	.vbat_rex_avg = BD71828_REG_VBAT_REX_AVG_U,
> +	.coulomb_full3 = BD71828_REG_CC_CNT_FULL3,
> +	.cc_full_clr = BD71828_REG_COULOMB_CTRL2,
> +	.coulomb_chg3 = BD71828_REG_CC_CNT_CHG3,
> +	.bat_temp = BD71828_REG_BAT_TEMP,
> +	.dcin_stat = BD71828_REG_DCIN_STAT,
> +	.dcin_collapse_limit = BD71828_REG_DCIN_CLPS,
> +	.chg_set1 = BD71828_REG_CHG_SET1,
> +	.chg_en   = BD71828_REG_CHG_EN,
> +	.vbat_alm_limit_u = BD71828_REG_ALM_VBAT_LIMIT_U,
> +	.batcap_mon_limit_u = BD71828_REG_BATCAP_MON_LIMIT_U,
> +	.conf = BD71828_REG_CONF,
> +	.vdcin = BD71828_REG_VDCIN_U,
> +};
> +
> +static const struct pwr_regs pwr_regs_bd71815 = {
> +	.vbat_init = BD71815_REG_VM_OCV_PRE_U,
> +	.vbat_init2 = BD71815_REG_VM_OCV_PST_U,
> +	.used_init_regs = 2,
> +	.vbat_avg = BD71815_REG_VM_SA_VBAT_U,
> +	/* BD71815 does not have separate current and current avg */
> +	.ibat = BD71815_REG_CC_CURCD_U,
> +	.ibat_avg = BD71815_REG_CC_CURCD_U,
> +
> +	.meas_clear = BD71815_REG_VM_SA_MINMAX_CLR,
> +	.vsys_min_avg = BD71815_REG_VM_SA_VSYS_MIN_U,
> +	.btemp_vth = BD71815_REG_VM_BTMP,
> +	.chg_state = BD71815_REG_CHG_STATE,
> +	.coulomb3 = BD71815_REG_CC_CCNTD_3,
> +	.coulomb2 = BD71815_REG_CC_CCNTD_2,
> +	.coulomb1 = BD71815_REG_CC_CCNTD_1,
> +	.coulomb0 = BD71815_REG_CC_CCNTD_0,
> +	.coulomb_ctrl = BD71815_REG_CC_CTRL,
> +	.vbat_rex_avg = BD71815_REG_REX_SA_VBAT_U,
> +	.coulomb_full3 = BD71815_REG_FULL_CCNTD_3,
> +	.cc_full_clr = BD71815_REG_FULL_CTRL,
> +	.coulomb_chg3 = BD71815_REG_CCNTD_CHG_3,
> +	.bat_temp = BD71815_REG_BAT_TEMP,
> +	.dcin_stat = BD71815_REG_DCIN_STAT,
> +	.dcin_collapse_limit = BD71815_REG_DCIN_CLPS,
> +	.chg_set1 = BD71815_REG_CHG_SET1,
> +	.chg_en   = BD71815_REG_CHG_SET1,
> +	.vbat_alm_limit_u = BD71815_REG_ALM_VBAT_TH_U,
> +	.batcap_mon_limit_u = BD71815_REG_CC_BATCAP1_TH_U,
> +	.conf = BD71815_REG_CONF,
> +
> +	.vdcin = BD71815_REG_VM_DCIN_U,
> +};
> +
> +struct bd71828_power {
> +	struct regmap *regmap;
> +	enum rohm_chip_type chip_type;
> +	struct device *dev;
> +	struct power_supply *ac;
> +	struct power_supply *bat;
> +
> +	const struct pwr_regs *regs;
> +	/* Reg val to uA */
> +	int curr_factor;
> +	int rsens;
> +	int (*get_temp)(struct bd71828_power *pwr, int *temp);
> +	int (*bat_inserted)(struct bd71828_power *pwr);
> +};
> +
> +static int bd7182x_write16(struct bd71828_power *pwr, int reg, u16 val)
> +{
> +	__be16 tmp;
> +
> +	tmp = cpu_to_be16(val);
> +
> +	return regmap_bulk_write(pwr->regmap, reg, &tmp, sizeof(tmp));
> +}
> +
> +static int bd7182x_read16_himask(struct bd71828_power *pwr, int reg, int himask,
> +				 u16 *val)
> +{
> +	struct regmap *regmap = pwr->regmap;
> +	int ret;
> +	__be16 rvals;
> +	u8 *tmp = (u8 *)&rvals;
> +
> +	ret = regmap_bulk_read(regmap, reg, &rvals, sizeof(*val));
> +	if (!ret) {
> +		*tmp &= himask;
> +		*val = be16_to_cpu(rvals);
> +	}

'nit': I'd like to have a line break here.

> +	return ret;
> +}
> +

...

> +
> +static int bd71828_charge_status(struct bd71828_power *pwr,
> +				 int *s, int *h)
> +{
> +	unsigned int state;
> +	int status, health;
> +	int ret = 1;
> +
> +	ret = regmap_read(pwr->regmap, pwr->regs->chg_state, &state);
> +	if (ret)
> +		dev_err(pwr->dev, "charger status reading failed (%d)\n", ret);

Exit here at error instead of using uninitialized state.

> +
> +	state &= BD7182x_MASK_CHG_STATE;
> +
> +	dev_dbg(pwr->dev, "CHG_STATE %d\n", state);
> +
> +	switch (state) {
> +	case 0x00:
> +		ret = 0;
> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
> +		health = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x01:
> +	case 0x02:
> +	case 0x03:
> +	case 0x0E:
> +		status = POWER_SUPPLY_STATUS_CHARGING;
> +		health = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x0F:
> +		ret = 0;
> +		status = POWER_SUPPLY_STATUS_FULL;
> +		health = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x10:
> +	case 0x11:
> +	case 0x12:
> +	case 0x13:
> +	case 0x14:
> +	case 0x20:
> +	case 0x21:
> +	case 0x22:
> +	case 0x23:
> +	case 0x24:
> +		ret = 0;
> +		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		health = POWER_SUPPLY_HEALTH_OVERHEAT;
> +		break;
> +	case 0x30:
> +	case 0x31:
> +	case 0x32:
> +	case 0x40:
> +		ret = 0;
> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
> +		health = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x7f:
> +	default:
> +		ret = 0;
> +		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		health = POWER_SUPPLY_HEALTH_DEAD;
> +		break;
> +	}
> +
> +	if (s)
> +		*s = status;
> +	if (h)
> +		*h = health;
> +
> +	return ret;
> +}
> +

...

> +
> +static irqreturn_t bd71828_vbat_low_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr = (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VBAT LOW Resumed\n");

'nit': I'd like to have a line break here (as the other handlers do). 
And, in general, I like having the linebreak before 'return' to make it 
stand out.

> +	return IRQ_HANDLED;
> +}
> +
> +static int bd7182x_get_rsens(struct bd71828_power *pwr)
> +{
> +	u64 tmp = RSENS_CURR;
> +	int rsens_ohm = RSENS_DEFAULT_30MOHM;
> +	struct fwnode_handle *node = NULL;
> +
> +	if (pwr->dev->parent)
> +		node = dev_fwnode(pwr->dev->parent);
> +
> +	if (node) {
> +		int ret;
> +		u32 rs;
> +
> +		ret = fwnode_property_read_u32(node,
> +					       "rohm,charger-sense-resistor-micro-ohms",
> +					       &rs);
> +		if (ret) {
> +			if (ret == -EINVAL) {
> +				rs = RSENS_DEFAULT_30MOHM;
> +			} else {
> +				dev_err(pwr->dev, "Bad RSENS dt property\n");
> +				return ret;
> +			}
> +		}
> +		if (!rs) {
> +			dev_err(pwr->dev, "Bad RSENS value\n");
> +			return -EINVAL;
> +		}
> +
> +		rsens_ohm = (int)rs;
> +	}
> +
> +	/* Reg val to uA */
> +	do_div(tmp, rsens_ohm);
> +
> +	pwr->curr_factor = tmp;
> +	pwr->rsens = rsens_ohm;
> +	dev_dbg(pwr->dev, "Setting rsens to %u micro ohm\n", pwr->rsens);
> +	dev_dbg(pwr->dev, "Setting curr-factor to %u\n", pwr->curr_factor);

'nit': I'd like to have a line break here.

> +	return 0;
> +}
> +

...

> +MODULE_AUTHOR("Cong Pham <cpham2403@gmail.com>");
> +MODULE_DESCRIPTION("ROHM BD718(15/17/28/78) PMIC Battery Charger driver");

nit: The '17' should be dropped.

> +MODULE_LICENSE("GPL");
> 



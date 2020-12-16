Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454B2DBD07
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLPIyk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 03:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgLPIyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 03:54:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AECCC061793
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 00:53:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e25so1636506wme.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=He/EYCubNcUxa9MFRgH4dYmPQTMYURNpySOlo4kmQlA=;
        b=jVEtNIvVBN2D3bdjy7kSYwKm5JtY+HoM2yAxMdydjdIakKhZbsiURqXdz7hC6Zfjgd
         G0pxKXAn0pXvcUEBo65wAaFDXtCge2cYUH+X2Ld29YD2VqGzY9p2+NXZ5bwxRn2gYToY
         EIY5tjrNeydLl2IpHkRLQV0WfzYurQ5u+oDNi9UT8J8H0lHY3o1b6cKZ610BYcY49K+R
         yAyXhoOBJct2L15FOp+tpF8KZms2yV36jqomXyWEv/WmXpu7VqtF1yEcvD+ztRCmBhnB
         u/Y9FOX9c2C2n1D+AJpFdLyR0CK5TA9s4xWMpkHVd63RhLfxaKKHwkyes1LnVTMuStzz
         3/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=He/EYCubNcUxa9MFRgH4dYmPQTMYURNpySOlo4kmQlA=;
        b=hWPBp2IJudg168voSOKkcR8Q0Nq9DT2K5IbJTBI09MW0+nZA0TOvNRn2aoGR2uzuiM
         CydJa6Yu4hQ6Kqv2YQIYAoZQyMaSj1HRsHbRKGWaLRJVfE673qAHF9KvvYVGozv4WL2U
         TcNp8NvXailHTYiBqzqztm+5xjiA29SUDIOh0CAx29a3t503JMEQp7TUpSios3MxfkvG
         WSj8+zU/BtNbe8y7dkOfAfhBjXvXfPZDFa6rExNGfu5iya/gYUCr9fo++ffTPbHzvNL9
         hfnWjM1hzO8WeX4NYZfDv+n9x1YeakkXHzdwtsA5g+baNmVYksufyMUiu8kEZe2+A0Jh
         MiMQ==
X-Gm-Message-State: AOAM532AGu6tdf8avEyLhY7s3f4zMHcNpNzbL6frebRa3471sD1Dzetn
        Rau0lLenpYXpa7KKU2GJBCVgXw==
X-Google-Smtp-Source: ABdhPJw0U1P77fE7C8nh1AbRReaozMOvys2XHNNnLqTSVhqs1qQ6DQIvUIhjHUU7yls0GXxcdkhADw==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr2221757wmc.147.1608108836117;
        Wed, 16 Dec 2020 00:53:56 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id i8sm1875605wma.32.2020.12.16.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:53:55 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:53:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] mfd: add BD71827 header
Message-ID: <20201216085353.GG4776@dell>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
 <a9b5c999b67213141831bcb9d56d580e31419bec.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b5c999b67213141831bcb9d56d580e31419bec.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 04 Dec 2020, Matti Vaittinen wrote:

> Add BD71827 driver header. For a record - Header is originally
> based on work authored by Cong Pham although not much of original
> work is left now.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> This patch was not in v1. This brings in some charger registers
> for the BD71827 charger which is in following patches.
> 
>  include/linux/mfd/rohm-bd71827.h | 295 +++++++++++++++++++++++++++++++
>  1 file changed, 295 insertions(+)
>  create mode 100644 include/linux/mfd/rohm-bd71827.h
> 
> diff --git a/include/linux/mfd/rohm-bd71827.h b/include/linux/mfd/rohm-bd71827.h
> new file mode 100644
> index 000000000000..0f5a343b10ae
> --- /dev/null
> +++ b/include/linux/mfd/rohm-bd71827.h
> @@ -0,0 +1,295 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2016

Out of date.

> + * @author cpham2403@gmail.com

This is not a proper Author: tag.

> + */
> +
> +#ifndef __LINUX_MFD_BD71827_H
> +#define __LINUX_MFD_BD71827_H

You can drop the LINUX part.

> +#include <linux/regmap.h>
> +
> +#define LDO5VSEL_EQ_H		0
> +
> +#ifndef LDO5VSEL_EQ_H
> +	#error define LDO5VSEL_EQ_H to 1 when connect to High, to 0 when connect to Low
> +#else
> +	#if LDO5VSEL_EQ_H == 1
> +		#define BD71827_REG_LDO5_VOLT	BD71827_REG_LDO5_VOLT_H
> +		#define LDO5_MASK		LDO5_H_MASK
> +	#elif LDO5VSEL_EQ_H == 0
> +		#define BD71827_REG_LDO5_VOLT	BD71827_REG_LDO5_VOLT_L
> +		#define LDO5_MASK		LDO5_L_MASK
> +	#else
> +		#error Define LDO5VSEL_EQ_H only to 0 or 1
> +	#endif
> +#endif

Not a fan of this at all.

What decides which of these to use?

Does this realistically ever change?

> +enum {
> +	BD71827_BUCK1	=	0,

Omit the extra ' 's.

> +	BD71827_BUCK2,
> +	BD71827_BUCK3,
> +	BD71827_BUCK4,
> +	BD71827_BUCK5,
> +	// General Purpose

No C++ comments.

> +	BD71827_LDO1,
> +	BD71827_LDO2,
> +	BD71827_LDO3,
> +	BD71827_LDO4,
> +	BD71827_LDO5,
> +	BD71827_LDO6,
> +	// LDO for Secure Non-Volatile Storage
> +	BD71827_LDOSNVS,
> +	BD71827_REGULATOR_CNT,
> +};
> +
> +#define BD71827_SUPPLY_STATE_ENABLED	0x1
> +
> +#define BD71827_BUCK1_VOLTAGE_NUM	0x3F
> +#define BD71827_BUCK2_VOLTAGE_NUM	0x3F
> +#define BD71827_BUCK3_VOLTAGE_NUM	0x3F
> +#define BD71827_BUCK4_VOLTAGE_NUM	0x1F
> +#define BD71827_BUCK5_VOLTAGE_NUM	0x1F
> +#define BD71827_LDO1_VOLTAGE_NUM	0x3F
> +#define BD71827_LDO2_VOLTAGE_NUM	0x3F
> +#define BD71827_LDO3_VOLTAGE_NUM	0x3F
> +#define BD71827_LDO4_VOLTAGE_NUM	0x3F
> +#define BD71827_LDO5_VOLTAGE_NUM	0x3F
> +#define BD71827_LDO6_VOLTAGE_NUM	0x1
> +#define BD71827_LDOSNVS_VOLTAGE_NUM	0x1

Please pad out these to there are the same amount of digits after the 0x.

> +#define BD71827_GPIO_NUM		2	/* BD71827 have 2 GPO */

"has 2 GPOs"

> +enum {
> +	BD71827_REG_DEVICE		= 0x00,
> +	BD71827_REG_PWRCTRL		= 0x01,
> +	BD71827_REG_BUCK1_MODE		= 0x02,
> +	BD71827_REG_BUCK2_MODE		= 0x03,
> +	BD71827_REG_BUCK3_MODE		= 0x04,
> +	BD71827_REG_BUCK4_MODE		= 0x05,
> +	BD71827_REG_BUCK5_MODE		= 0x06,
> +	BD71827_REG_BUCK1_VOLT_RUN	= 0x07,
> +	BD71827_REG_BUCK1_VOLT_SUSP	= 0x08,
> +	BD71827_REG_BUCK2_VOLT_RUN	= 0x09,
> +	BD71827_REG_BUCK2_VOLT_SUSP	= 0x0A,
> +	BD71827_REG_BUCK3_VOLT		= 0x0B,
> +	BD71827_REG_BUCK4_VOLT		= 0x0C,
> +	BD71827_REG_BUCK5_VOLT		= 0x0D,
> +	BD71827_REG_LED_CTRL		= 0x0E,
> +	BD71827_REG_reserved_0F		= 0x0F,
> +	BD71827_REG_LDO_MODE1		= 0x10,
> +	BD71827_REG_LDO_MODE2		= 0x11,
> +	BD71827_REG_LDO_MODE3		= 0x12,
> +	BD71827_REG_LDO_MODE4		= 0x13,
> +	BD71827_REG_LDO1_VOLT		= 0x14,
> +	BD71827_REG_LDO2_VOLT		= 0x15,
> +	BD71827_REG_LDO3_VOLT		= 0x16,
> +	BD71827_REG_LDO4_VOLT		= 0x17,
> +	BD71827_REG_LDO5_VOLT_H		= 0x18,
> +	BD71827_REG_LDO5_VOLT_L		= 0x19,
> +	BD71827_REG_BUCK_PD_DIS		= 0x1A,
> +	BD71827_REG_LDO_PD_DIS		= 0x1B,
> +	BD71827_REG_GPIO		= 0x1C,
> +	BD71827_REG_OUT32K		= 0x1D,
> +	BD71827_REG_SEC			= 0x1E,
> +	BD71827_REG_MIN			= 0x1F,
> +	BD71827_REG_HOUR		= 0x20,
> +	BD71827_REG_WEEK		= 0x21,
> +	BD71827_REG_DAY			= 0x22,
> +	BD71827_REG_MONTH		= 0x23,
> +	BD71827_REG_YEAR		= 0x24,
> +	BD71827_REG_ALM0_SEC		= 0x25,
> +	BD71827_REG_ALM0_MIN		= 0x26,
> +	BD71827_REG_ALM0_HOUR		= 0x27,
> +	BD71827_REG_ALM0_WEEK		= 0x28,
> +	BD71827_REG_ALM0_DAY		= 0x29,
> +	BD71827_REG_ALM0_MONTH		= 0x2A,
> +	BD71827_REG_ALM0_YEAR		= 0x2B,
> +	BD71827_REG_ALM1_SEC		= 0x2C,
> +	BD71827_REG_ALM1_MIN		= 0x2D,
> +	BD71827_REG_ALM1_HOUR		= 0x2E,
> +	BD71827_REG_ALM1_WEEK		= 0x2F,
> +	BD71827_REG_ALM1_DAY		= 0x30,
> +	BD71827_REG_ALM1_MONTH		= 0x31,
> +	BD71827_REG_ALM1_YEAR		= 0x32,
> +	BD71827_REG_ALM0_MASK		= 0x33,
> +	BD71827_REG_ALM1_MASK		= 0x34,
> +	BD71827_REG_ALM2		= 0x35,
> +	BD71827_REG_TRIM		= 0x36,
> +	BD71827_REG_CONF		= 0x37,
> +	BD71827_REG_SYS_INIT		= 0x38,
> +	BD71827_REG_CHG_STATE		= 0x39,
> +	BD71827_REG_CHG_LAST_STATE	= 0x3A,
> +	BD71827_REG_BAT_STAT		= 0x3B,
> +	BD71827_REG_DCIN_STAT		= 0x3C,
> +	BD71827_REG_VSYS_STAT		= 0x3D,
> +	BD71827_REG_CHG_STAT		= 0x3E,
> +	BD71827_REG_CHG_WDT_STAT	= 0x3F,
> +	BD71827_REG_BAT_TEMP		= 0x40,
> +	BD71827_REG_ILIM_STAT		= 0x41,
> +	BD71827_REG_DCIN_SET		= 0x42,
> +	BD71827_REG_DCIN_CLPS		= 0x43,
> +	BD71827_REG_VSYS_REG		= 0x44,
> +	BD71827_REG_VSYS_MAX		= 0x45,
> +	BD71827_REG_VSYS_MIN		= 0x46,
> +	BD71827_REG_CHG_SET1		= 0x47,
> +	BD71827_REG_CHG_SET2		= 0x48,
> +	BD71827_REG_CHG_WDT_PRE		= 0x49,
> +	BD71827_REG_CHG_WDT_FST		= 0x4A,
> +	BD71827_REG_CHG_IPRE		= 0x4B,
> +	BD71827_REG_CHG_IFST		= 0x4C,
> +	BD71827_REG_CHG_IFST_TERM	= 0x4D,
> +	BD71827_REG_CHG_VPRE		= 0x4E,
> +	BD71827_REG_CHG_VBAT_1		= 0x4F,
> +	BD71827_REG_CHG_VBAT_2		= 0x50,
> +	BD71827_REG_CHG_VBAT_3		= 0x51,
> +	BD71827_REG_CHG_LED_1		= 0x52,
> +	BD71827_REG_VF_TH		= 0x53,
> +	BD71827_REG_BAT_SET_1		= 0x54,
> +	BD71827_REG_BAT_SET_2		= 0x55,
> +	BD71827_REG_BAT_SET_3		= 0x56,
> +	BD71827_REG_ALM_VBAT_TH_U	= 0x57,
> +	BD71827_REG_ALM_VBAT_TH_L	= 0x58,
> +	BD71827_REG_ALM_DCIN_TH		= 0x59,
> +	BD71827_REG_ALM_VSYS_TH		= 0x5A,
> +	BD71827_REG_reserved_5B		= 0x5B,
> +	BD71827_REG_reserved_5C		= 0x5C,
> +	BD71827_REG_VM_VBAT_U		= 0x5D,
> +	BD71827_REG_VM_VBAT_L		= 0x5E,
> +	BD71827_REG_VM_BTMP		= 0x5F,
> +	BD71827_REG_VM_VTH		= 0x60,
> +	BD71827_REG_VM_DCIN_U		= 0x61,
> +	BD71827_REG_VM_DCIN_L		= 0x62,
> +	BD71827_REG_reserved_63		= 0x63,
> +	BD71827_REG_VM_VF		= 0x64,
> +	BD71827_REG_reserved_65		= 0x65,
> +	BD71827_REG_reserved_66		= 0x66,
> +	BD71827_REG_VM_OCV_PRE_U	= 0x67,
> +	BD71827_REG_VM_OCV_PRE_L	= 0x68,
> +	BD71827_REG_reserved_69		= 0x69,
> +	BD71827_REG_reserved_6A		= 0x6A,
> +	BD71827_REG_VM_OCV_PST_U	= 0x6B,
> +	BD71827_REG_VM_OCV_PST_L	= 0x6C,
> +	BD71827_REG_VM_SA_VBAT_U	= 0x6D,
> +	BD71827_REG_VM_SA_VBAT_L	= 0x6E,
> +	BD71827_REG_reserved_6F		= 0x6F,
> +	BD71827_REG_reserved_70		= 0x70,
> +	BD71827_REG_CC_CTRL		= 0x71,
> +	BD71827_REG_CC_BATCAP1_TH_U	= 0x72,
> +	BD71827_REG_CC_BATCAP1_TH_L	= 0x73,
> +	BD71827_REG_CC_BATCAP2_TH_U	= 0x74,
> +	BD71827_REG_CC_BATCAP2_TH_L	= 0x75,
> +	BD71827_REG_CC_BATCAP3_TH_U	= 0x76,
> +	BD71827_REG_CC_BATCAP3_TH_L	= 0x77,
> +	BD71827_REG_CC_STAT		= 0x78,
> +	BD71827_REG_CC_CCNTD_3		= 0x79,
> +	BD71827_REG_CC_CCNTD_2		= 0x7A,
> +	BD71827_REG_CC_CCNTD_1		= 0x7B,
> +	BD71827_REG_CC_CCNTD_0		= 0x7C,
> +	BD71827_REG_CC_CURCD_U		= 0x7D,
> +	BD71827_REG_CC_CURCD_L		= 0x7E,
> +	BD71827_REG_CC_OCUR_THR_1	= 0x7F,
> +	BD71827_REG_CC_OCUR_DUR_1	= 0x80,
> +	BD71827_REG_CC_OCUR_THR_2	= 0x81,
> +	BD71827_REG_CC_OCUR_DUR_2	= 0x82,
> +	BD71827_REG_CC_OCUR_THR_3	= 0x83,
> +	BD71827_REG_CC_OCUR_DUR_3	= 0x84,
> +	BD71827_REG_CC_OCUR_MON		= 0x85,
> +	BD71827_REG_VM_BTMP_OV_THR	= 0x86,
> +	BD71827_REG_VM_BTMP_OV_DUR	= 0x87,
> +	BD71827_REG_VM_BTMP_LO_THR	= 0x88,
> +	BD71827_REG_VM_BTMP_LO_DUR	= 0x89,
> +	BD71827_REG_VM_BTMP_MON		= 0x8A,
> +	BD71827_REG_INT_EN_01		= 0x8B,
> +	BD71827_REG_INT_EN_02		= 0x8C,
> +	BD71827_REG_INT_EN_03		= 0x8D,
> +	BD71827_REG_INT_EN_04		= 0x8E,
> +	BD71827_REG_INT_EN_05		= 0x8F,
> +	BD71827_REG_INT_EN_06		= 0x90,
> +	BD71827_REG_INT_EN_07		= 0x91,
> +	BD71827_REG_INT_EN_08		= 0x92,
> +	BD71827_REG_INT_EN_09		= 0x93,
> +	BD71827_REG_INT_EN_10		= 0x94,
> +	BD71827_REG_INT_EN_11		= 0x95,
> +	BD71827_REG_INT_EN_12		= 0x96,
> +	BD71827_REG_INT_STAT		= 0x97,
> +	BD71827_REG_INT_STAT_01		= 0x98,
> +	BD71827_REG_INT_STAT_02		= 0x99,
> +	BD71827_REG_INT_STAT_03		= 0x9A,
> +	BD71827_REG_INT_STAT_04		= 0x9B,
> +	BD71827_REG_INT_STAT_05		= 0x9C,
> +	BD71827_REG_INT_STAT_06		= 0x9D,
> +	BD71827_REG_INT_STAT_07		= 0x9E,
> +	BD71827_REG_INT_STAT_08		= 0x9F,
> +	BD71827_REG_INT_STAT_09		= 0xA0,
> +	BD71827_REG_INT_STAT_10		= 0xA1,
> +	BD71827_REG_INT_STAT_11		= 0xA2,
> +	BD71827_REG_INT_STAT_12		= 0xA3,
> +	BD71827_REG_INT_UPDATE		= 0xA4,
> +	BD71827_REG_PWRCTRL2		= 0xA8,
> +	BD71827_REG_PWRCTRL3		= 0xA9,
> +	BD71827_REG_SWRESET		= 0xAA,
> +	BD71827_REG_BUCK1_VOLT_IDLE	= 0xAB,
> +	BD71827_REG_BUCK2_VOLT_IDLE	= 0xAC,
> +	BD71827_REG_ONEVNT_MODE_1	= 0xAD,
> +	BD71827_REG_ONEVNT_MODE_2	= 0xAE,
> +	BD71827_REG_RESERVE_0		= 0xB0,
> +	BD71827_REG_RESERVE_1		= 0xB1,
> +	BD71827_REG_RESERVE_2		= 0xB2,
> +	BD71827_REG_RESERVE_3		= 0xB3,
> +	BD71827_REG_RESERVE_4		= 0xB4,
> +	BD71827_REG_RESERVE_5		= 0xB5,
> +	BD71827_REG_RESERVE_6		= 0xB6,
> +	BD71827_REG_RESERVE_7		= 0xB7,
> +	BD71827_REG_RESERVE_8		= 0xB8,
> +	BD71827_REG_RESERVE_9		= 0xB9,
> +	BD71827_REG_RESERVE_A		= 0xBA,
> +	BD71827_REG_RESERVE_B		= 0xBB,
> +	BD71827_REG_RESERVE_C		= 0xBC,
> +	BD71827_REG_RESERVE_D		= 0xBD,
> +	BD71827_REG_RESERVE_E		= 0xBE,
> +	BD71827_REG_RESERVE_F		= 0xBF,
> +	BD71827_REG_VM_VSYS_U		= 0xC0,
> +	BD71827_REG_VM_VSYS_L		= 0xC1,
> +	BD71827_REG_VM_SA_VSYS_U	= 0xC2,
> +	BD71827_REG_VM_SA_VSYS_L	= 0xC3,
> +	BD71827_REG_CC_SA_CURCD_U	= 0xC4,
> +	BD71827_REG_CC_SA_CURCD_L	= 0xC5,
> +	BD71827_REG_BATID		= 0xC6,
> +	BD71827_REG_VM_SA_VBAT_MIN_U	= 0xD4,
> +	BD71827_REG_VM_SA_VBAT_MIN_L	= 0xD5,
> +	BD71827_REG_VM_SA_VBAT_MAX_U	= 0xD6,
> +	BD71827_REG_VM_SA_VBAT_MAX_L	= 0xD7,
> +	BD71827_REG_VM_SA_VSYS_MIN_U	= 0xD8,
> +	BD71827_REG_VM_SA_VSYS_MIN_L	= 0xD9,
> +	BD71827_REG_VM_SA_VSYS_MAX_U	= 0xDA,
> +	BD71827_REG_VM_SA_VSYS_MAX_L	= 0xDB,
> +	BD71827_REG_VM_SA_MINMAX_CLR	= 0xDC,
> +	BD71827_REG_VM_OCV_PWRON_U	= 0xDD,
> +	BD71827_REG_VM_OCV_PWRON_L	= 0xDE,
> +	BD71827_REG_REX_CCNTD_3		= 0xE0,
> +	BD71827_REG_REX_CCNTD_2		= 0xE1,
> +	BD71827_REG_REX_CCNTD_1		= 0xE2,
> +	BD71827_REG_REX_CCNTD_0		= 0xE3,
> +	BD71827_REG_REX_SA_VBAT_U	= 0xE4,
> +	BD71827_REG_REX_SA_VBAT_L	= 0xE5,
> +	BD71827_REG_REX_CTRL_1		= 0xE6,
> +	BD71827_REG_REX_CTRL_2		= 0xE7,
> +	BD71827_REG_FULL_CCNTD_3	= 0xE8,
> +	BD71827_REG_FULL_CCNTD_2	= 0xE9,
> +	BD71827_REG_FULL_CCNTD_1	= 0xEA,
> +	BD71827_REG_FULL_CCNTD_0	= 0xEB,
> +	BD71827_REG_FULL_CTRL		= 0xEC,
> +	BD71827_REG_CCNTD_CHG_3		= 0xF0,
> +	BD71827_REG_CCNTD_CHG_2		= 0xF1,
> +	BD71827_REG_INT_EN_13		= 0xF8,
> +	BD71827_REG_INT_STAT_13		= 0xF9,
> +	BD71827_REG_I2C_MAGIC		= 0xFE,
> +	BD71827_REG_PRODUCT		= 0xFF,
> +	BD71827_MAX_REGISTER		= 0x100,
> +};
> +
> +#define BD71827_REX_CLR_MASK		0x10
> +
> +#endif /* __LINUX_MFD_BD71827_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

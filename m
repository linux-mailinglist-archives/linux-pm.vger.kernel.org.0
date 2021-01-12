Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7F2F2F36
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbhALMf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 07:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbhALMfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 07:35:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E8C061794;
        Tue, 12 Jan 2021 04:35:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so1958632wmg.4;
        Tue, 12 Jan 2021 04:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nFmIcOdZvFegV9PG0DcC5PMknhWf91VbiZim4NVM3Wc=;
        b=vH9rxqtFN69hJnNLcf/TUFb1/dFUcabWcrXHF7QXSS02J/+nGxI402vum8Ze/4c/e9
         2qlQrzS47FdbFlBL0bbkxiB8N6q/IjFvPH1FnA+WrAVvqplyU69tPzkU6TPtzv94jgmE
         BPCn9d/68hmY0PJOa3zhJn5pCCHh55uqjlWcyx+5h5M375bbZNPPbmSo+IMpzJHNnr7X
         IyHRS8U/v6fBaJ9IDP6s6Ao5jiazqHcEMO1Vk5erChRpPm/h7ZV8JNYn/woymATjhziW
         buW6qo7y5FPKyMDYvEBsHbIj4YwCKuZ9aBBsq9Djf7EhvJRnttOU64T57PYfMVjnRtlO
         PheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nFmIcOdZvFegV9PG0DcC5PMknhWf91VbiZim4NVM3Wc=;
        b=o920hHAKWDf0svTxJzoCHTLgYPINs6RKaep/rVU/j/GuqrpWnavHXvKZcSHWpH9RSu
         AijqjrFo+H205TDBe3PUf3NQFJYR1ve5vYp1TX3yU7WgTMvaB10rwb6FKa9I8fh7hepV
         G2r+FkduqM759T2noV6yUpzdJHgepNg+lvUNeSJ3UdVo3fN2+RsIXXLvcS+pM29+cVPc
         2V0vC/BqkGIJbADFWOklHjTDiD2Zag6Q3bjodBUulyrSHxG5iW6NSdc8XdPvRJMrMfjA
         ekqbJtt0u0TJd4wYDE0e5IgSTDY/N+pO0XqKaFtcTehYyM8/n3g+czN3JDX9IS2y8Hxw
         pzCA==
X-Gm-Message-State: AOAM5324yvXVzVq8MtUF7eFydIkhkOqhr6bVMMdjK7PTGV2cVj/JAUz4
        I2O6zfaa3gV1Xn67hTm7xGUWIl7a4EI1sQ==
X-Google-Smtp-Source: ABdhPJwBTbQOKFNcBnctZC1Y7dfGpRZ9285Jhu5y1BFgRFl2IvOgErwNfOULy8m9ihSTVu0zm6anZg==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr3394938wma.60.1610454913517;
        Tue, 12 Jan 2021 04:35:13 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id g5sm5135744wro.60.2021.01.12.04.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 04:35:12 -0800 (PST)
Subject: Re: [PATCH v3 2/2] power: supply: mt6360_charger: add MT6360 charger
 support
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
References: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
 <1608796084-29418-3-git-send-email-gene.chen.richtek@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <aaf7ba78-2da2-0036-f142-9da61bde5fd4@gmail.com>
Date:   Tue, 12 Jan 2021 13:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1608796084-29418-3-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 24/12/2020 08:48, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add basic support for the battery charger for MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |   10 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/mt6360_charger.c | 1054 +++++++++++++++++++++++++++++++++
>  3 files changed, 1065 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c..dd63bed 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -567,6 +567,16 @@ config CHARGER_MP2629
>  	  Battery charger. This driver provides Battery charger power management
>  	  functions on the systems.
>  
> +config CHARGER_MT6360
> +	tristate "Mediatek MT6360 Charger Driver"
> +	depends on MFD_MT6360
> +	depends on REGULATOR
> +	help
> +	  Say Y here to enable MT6360 Charger Part.
> +	  The device supports High-Accuracy Voltage/Current Regulation,
> +	  Average Input Current Regulation, Battery Tempature Sensing,
> +	  Over-Temperature Protection, DPDM Detection for BC1.2
> +
>  config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b863..9bd0804 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
> +obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
> diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
> new file mode 100644
> index 0000000..f1dcb97
> --- /dev/null
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -0,0 +1,1054 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/power_supply.h>
> +#include <linux/regulator/driver.h>
> +
> +#define MT6360_PMU_CHG_CTRL1	0x311
> +#define MT6360_PMU_CHG_CTRL2	0x312
> +#define MT6360_PMU_CHG_CTRL3	0x313
> +#define MT6360_PMU_CHG_CTRL4	0x314
> +#define MT6360_PMU_CHG_CTRL5	0x315
> +#define MT6360_PMU_CHG_CTRL6	0x316
> +#define MT6360_PMU_CHG_CTRL7	0x317
> +#define MT6360_PMU_CHG_CTRL8	0x318
> +#define MT6360_PMU_CHG_CTRL9	0x319
> +#define MT6360_PMU_CHG_CTRL10	0x31A
> +#define MT6360_PMU_CHG_CTRL11	0x31B
> +#define MT6360_PMU_CHG_CTRL12	0x31C
> +#define MT6360_PMU_CHG_CTRL13	0x31D
> +#define MT6360_PMU_DEVICE_TYPE	0x322
> +#define MT6360_PMU_USB_STATUS1	0x327
> +#define MT6360_PMU_CHG_CTRL17	0x32B
> +#define MT6360_PMU_CHG_CTRL18	0x32C
> +#define MT6360_PMU_CHG_STAT	0x34A
> +#define MT6360_PMU_CHG_CTRL19	0x361
> +#define MT6360_PMU_FOD_STAT	0x3E7
> +
> +/* MT6360_PMU_CHG_CTRL1 */
> +#define MT6360_FSLP_SHFT	(3)
> +#define MT6360_FSLP_MASK	BIT(MT6360_FSLP_SHFT)
> +#define MT6360_HIZ_SHFT		(2)
> +#define MT6360_HIZ_MASK		BIT(MT6360_HIZ_SHFT)
> +#define MT6360_OPA_MODE_SHFT	(0)
> +#define MT6360_OPA_MODE_MASK	BIT(MT6360_OPA_MODE_SHFT)
> +/* MT6360_PMU_CHG_CTRL2 */
> +#define MT6360_TE_SHFT		(4)
> +#define MT6360_TE_MASK		BIT(MT6360_TE_SHFT)
> +#define MT6360_IINLMTSEL_SHFT	(2)
> +#define MT6360_IINLMTSEL_MASK	GENMASK(3, 2)
> +#define MT6360_CHG_EN_SHFT	(0)
> +#define MT6360_CHG_EN_MASK	BIT(MT6360_CHG_EN_SHFT)
> +/* MT6360_PMU_CHG_CTRL3 */
> +#define MT6360_IAICR_SHFT	(2)
> +#define MT6360_IAICR_MASK	GENMASK(7, 2)
> +#define MT6360_ILIM_EN_MASK	BIT(0)
> +/* MT6360_PMU_CHG_CTRL4 */
> +#define MT6360_VOREG_SHFT	(1)
> +#define MT6360_VOREG_MASK	GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL5 */
> +#define MT6360_VOBST_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL6 */
> +#define MT6360_VMIVR_SHFT	(1)
> +#define MT6360_VMIVR_MASK	GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL7 */
> +#define MT6360_ICHG_SHFT	(2)
> +#define MT6360_ICHG_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL8 */
> +#define MT6360_IPREC_SHFT	(0)
> +#define MT6360_IPREC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL9 */
> +#define MT6360_IEOC_SHFT	(4)
> +#define MT6360_IEOC_MASK	GENMASK(7, 4)
> +/* MT6360_PMU_CHG_CTRL10 */
> +#define MT6360_LBP_SHFT		(4)
> +#define MT6360_LBP_MASK		GENMASK(7, 4)
> +#define MT6360_OTG_OC_SHFT	(0)
> +#define MT6360_OTG_OC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL11 */
> +#define MT6360_SYSREG_SHFT	(2)
> +#define MT6360_SYSREG_MASK	GENMASK(4, 2)
> +#define MT6360_VREC_SHFT	(0)
> +#define MT6360_VREC_MASK	GENMASK(2, 0)
> +/* MT6360_PMU_CHG_CTRL12 */
> +#define MT6360_WT_FC_SHFT	(5)
> +#define MT6360_WT_FC_MASK	GENMASK(7, 5)
> +/* MT6360_PMU_CHG_CTRL13 */
> +#define MT6360_CHG_WDT_EN_SHFT	(7)
> +#define MT6360_CHG_WDT_EN_MASK	BIT(MT6360_CHG_WDT_EN_SHFT)
> +#define MT6360_CHG_WDT_SHFT	(4)
> +#define MT6360_CHG_WDT_MASK	GENMASK(5, 4)
> +/* MT6360_PMU_DEVICE_TYPE */
> +#define MT6360_USBCHGEN_SHFT	(7)
> +#define MT6360_USBCHGEN_MASK	BIT(MT6360_USBCHGEN_SHFT)
> +/* MT6360_PMU_USB_STATUS1 */
> +#define MT6360_USB_STATUS_SHFT	(4)
> +#define MT6360_USB_STATUS_MASK	GENMASK(6, 4)
> +/* MT6360_PMU_CHG_CTRL18 */
> +#define MT6360_BAT_COMP_SHFT	(3)
> +#define MT6360_BAT_COMP_MASK	GENMASK(5, 3)
> +#define MT6360_VCLAMP_SHFT	(0)
> +#define MT6360_VCLAMP_MASK	GENMASK(2, 0)
> +/* MT6360_PMU_CHG_STAT */
> +#define MT6360_CHG_STAT_SHFT	(6)
> +#define MT6360_CHG_STAT_MASK	GENMASK(7, 6)
> +#define MT6360_VBAT_LVL_MASK	BIT(5)
> +/* MT6360_PMU_CHG_CTRL19 */
> +#define MT6360_VINOVP_SHFT	(5)
> +#define MT6360_VINOVP_MASK	GENMASK(6, 5)
> +/* MT6360_PMU_FOD_STAT */
> +#define MT6360_CHRDET_EXT_SHFT	(4)
> +#define MT6360_CHRDET_EXT_MASK	BIT(4)
> +
> +/* uA */
> +#define MT6360_ICHG_MIN		100000
> +#define MT6360_ICHG_MAX		5000000
> +#define MT6360_ICHG_STEP	100000
> +/* uV */
> +#define MT6360_VOREG_MIN	3900000
> +#define MT6360_VOREG_MAX	4710000
> +#define MT6360_VOREG_STEP	10000
> +/* uA */
> +#define MT6360_AICR_MIN		100000
> +#define MT6360_AICR_MAX		3250000
> +#define MT6360_AICR_STEP	50000
> +/* uA */
> +#define MT6360_IPREC_MIN	100000
> +#define MT6360_IPREC_MAX	850000
> +#define MT6360_IPREC_STEP	50000
> +/* uA */
> +#define MT6360_IEOC_MIN		100000
> +#define MT6360_IEOC_MAX		850000
> +#define MT6360_IEOC_STEP	50000
> +
> +struct mt6360_chg_platform_data {
> +	u32 vinovp;
> +};
> +
> +struct mt6360_chg_info {
> +	struct device *dev;
> +	struct mt6360_chg_platform_data *pdata;
> +	struct regmap *regmap;
> +	struct power_supply_desc psy_desc;
> +	struct power_supply *psy;
> +	struct regulator_dev *otg_rdev;
> +	struct mutex chgdet_lock;
> +	bool pwr_rdy;
> +	bool bc12_en;
> +	int psy_usb_type;
> +	struct work_struct chrdet_work;
> +};
> +
> +static struct mt6360_chg_platform_data def_platform_data = {
> +	.vinovp = 6500000,
> +};
> +
> +enum mt6360_iinlmtsel {
> +	MT6360_IINLMTSEL_AICR_3250 = 0,
> +	MT6360_IINLMTSEL_CHG_TYPE,
> +	MT6360_IINLMTSEL_AICR,
> +	MT6360_IINLMTSEL_LOWER_LEVEL,
> +};
> +
> +enum mt6360_pmu_chg_type {
> +	MT6360_CHG_TYPE_NOVBUS = 0,
> +	MT6360_CHG_TYPE_UNDER_GOING,
> +	MT6360_CHG_TYPE_SDP,
> +	MT6360_CHG_TYPE_SDPNSTD,
> +	MT6360_CHG_TYPE_DCP,
> +	MT6360_CHG_TYPE_CDP,
> +	MT6360_CHG_TYPE_MAX,
> +};
> +
> +static enum power_supply_usb_type mt6360_charger_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
> +};
> +
> +static unsigned int mt6360_map_reg_sel(u32 data, u32 min, u32 max, u32 step)
> +{
> +	u32 target = 0, max_sel;
> +
> +	if (data >= min) {
> +		target = (data - min) / step;
> +		max_sel = (max - min) / step;
> +		if (target > max_sel)
> +			target = max_sel;
> +	}
> +	return target;
> +}
> +
> +static u32 mt6360_map_real_val(u32 sel, u32 min, u32 max, u32 step)
> +{
> +	u32 target = 0;
> +
> +	target = min + (sel * step);
> +	if (target > max)
> +		target = max;
> +	return target;
> +}
> +
> +static int mt6360_get_chrdet_ext_stat(struct mt6360_chg_info *mci,
> +					     bool *pwr_rdy)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_FOD_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +	*pwr_rdy = (regval & MT6360_CHRDET_EXT_MASK) ? true : false;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_online(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	int ret;
> +	bool pwr_rdy;
> +
> +	ret = mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		return ret;
> +	val->intval = pwr_rdy ? true : false;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_status(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	int status, ret;
> +	unsigned int regval;
> +	bool pwr_rdy;
> +
> +	ret = mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		return ret;
> +	if (!pwr_rdy) {
> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
> +		goto out;
> +	}
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval &= MT6360_CHG_STAT_MASK;
> +	regval >>= MT6360_CHG_STAT_SHFT;
> +	switch (regval) {
> +	case 0x0:
> +		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case 0x1:
> +		status = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case 0x2:
> +		status = POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	default:
> +		ret = -EIO;
> +	}
> +out:
> +	if (!ret)
> +		val->intval = status;
> +	return ret;
> +}
> +
> +static int mt6360_charger_get_charge_type(struct mt6360_chg_info *mci,
> +					  union power_supply_propval *val)
> +{
> +	int type, ret;
> +	unsigned int regval;
> +	u8 chg_stat;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	chg_stat = (regval & MT6360_CHG_STAT_MASK) >> MT6360_CHG_STAT_SHFT;
> +	switch (chg_stat) {
> +	case 0x01: /* Charge in Progress */
> +		if (regval & MT6360_VBAT_LVL_MASK)
> +			type = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		else
> +			type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case 0x00: /* Not Charging */
> +	case 0x02: /* Charge Done */
> +	case 0x03: /* Charge Fault */
> +	default:
> +		type = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	}
> +
> +	val->intval = type;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_ICHG_MIN,
> +					  MT6360_ICHG_MAX,
> +					  MT6360_ICHG_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_max_ichg(struct mt6360_chg_info *mci,
> +				       union power_supply_propval *val)
> +{
> +	val->intval = MT6360_ICHG_MAX;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_cv(struct mt6360_chg_info *mci,
> +				 union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL4, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_VOREG_MASK) >> MT6360_VOREG_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_VOREG_MIN,
> +					  MT6360_VOREG_MAX,
> +					  MT6360_VOREG_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_max_cv(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	val->intval = MT6360_VOREG_MAX;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_aicr(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL3, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_IAICR_MASK) >> MT6360_IAICR_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_AICR_MIN,
> +					  MT6360_AICR_MAX,
> +					  MT6360_AICR_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_iprechg(struct mt6360_chg_info *mci,
> +				      union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL8, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_IPREC_MASK) >> MT6360_IPREC_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_IPREC_MIN,
> +					  MT6360_IPREC_MAX,
> +					  MT6360_IPREC_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_ieoc(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL9, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_IEOC_MASK) >> MT6360_IEOC_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_IEOC_MIN,
> +					  MT6360_IEOC_MAX,
> +					  MT6360_IEOC_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_set_online(struct mt6360_chg_info *mci,
> +				     const union power_supply_propval *val)
> +{
> +	u8 force_sleep = val->intval ? 0 : 1;
> +
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL1,
> +				  MT6360_FSLP_MASK,
> +				  force_sleep << MT6360_FSLP_SHFT);
> +}
> +
> +static int mt6360_charger_set_ichg(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_ICHG_MIN,
> +				 MT6360_ICHG_MAX,
> +				 MT6360_ICHG_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL7,
> +				  MT6360_ICHG_MASK,
> +				  sel << MT6360_ICHG_SHFT);
> +}
> +
> +static int mt6360_charger_set_cv(struct mt6360_chg_info *mci,
> +				 const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_VOREG_MIN,
> +				 MT6360_VOREG_MAX,
> +				 MT6360_VOREG_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL4,
> +				  MT6360_VOREG_MASK,
> +				  sel << MT6360_VOREG_SHFT);
> +}
> +
> +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_AICR_MIN,
> +				 MT6360_AICR_MAX,
> +				 MT6360_AICR_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL3,
> +				  MT6360_IAICR_MASK,
> +				  sel << MT6360_IAICR_SHFT);
> +}
> +
> +static int mt6360_charger_set_iprechg(struct mt6360_chg_info *mci,
> +				      const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_IPREC_MIN,
> +				 MT6360_IPREC_MAX,
> +				 MT6360_IPREC_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL8,
> +				  MT6360_IPREC_MASK,
> +				  sel << MT6360_IPREC_SHFT);
> +}
> +
> +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_IEOC_MIN,
> +				 MT6360_IEOC_MAX,
> +				 MT6360_IEOC_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL9,
> +				  MT6360_IEOC_MASK,
> +				  sel << MT6360_IEOC_SHFT);
> +}
> +
> +static int mt6360_charger_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct mt6360_chg_info *mci = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	dev_dbg(mci->dev, "%s: prop = %d\n", __func__, psp);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = mt6360_charger_get_online(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret = mt6360_charger_get_status(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret = mt6360_charger_get_charge_type(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = mt6360_charger_get_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret = mt6360_charger_get_max_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = mt6360_charger_get_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		ret = mt6360_charger_get_max_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = mt6360_charger_get_aicr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = mt6360_charger_get_iprechg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = mt6360_charger_get_ieoc(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval = mci->psy_usb_type;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +	}
> +	return ret;
> +}
> +
> +static int mt6360_charger_set_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       const union power_supply_propval *val)
> +{
> +	struct mt6360_chg_info *mci = power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	dev_dbg(mci->dev, "%s: prop = %d\n", __func__, psp);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = mt6360_charger_set_online(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = mt6360_charger_set_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = mt6360_charger_set_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = mt6360_charger_set_aicr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = mt6360_charger_set_iprechg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = mt6360_charger_set_ieoc(mci, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int mt6360_charger_property_is_writeable(struct power_supply *psy,
> +					       enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static enum power_supply_property mt6360_charger_properties[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static char *mt6360_charger_supplied_to[] = {
> +	"main-battery"
> +};
> +
> +static const struct power_supply_desc mt6360_charger_desc = {
> +	.type			= POWER_SUPPLY_TYPE_USB,
> +	.properties		= mt6360_charger_properties,
> +	.num_properties		= ARRAY_SIZE(mt6360_charger_properties),
> +	.get_property		= mt6360_charger_get_property,
> +	.set_property		= mt6360_charger_set_property,
> +	.property_is_writeable	= mt6360_charger_property_is_writeable,
> +	.usb_types		= mt6360_charger_usb_types,
> +	.num_usb_types		= ARRAY_SIZE(mt6360_charger_usb_types),
> +};
> +
> +static const struct regulator_ops mt6360_chg_otg_ops = {
> +	.list_voltage = regulator_list_voltage_linear,
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_desc mt6360_otg_rdesc = {
> +	.of_match = "usb-otg-vbus",
> +	.name = "usb-otg-vbus",
> +	.ops = &mt6360_chg_otg_ops,
> +	.owner = THIS_MODULE,
> +	.type = REGULATOR_VOLTAGE,
> +	.min_uV = 4425000,
> +	.uV_step = 25000,
> +	.n_voltages = 57,
> +	.vsel_reg = MT6360_PMU_CHG_CTRL5,
> +	.vsel_mask = MT6360_VOBST_MASK,
> +	.enable_reg = MT6360_PMU_CHG_CTRL1,
> +	.enable_mask = MT6360_OPA_MODE_MASK,
> +};
> +
> +static irqreturn_t mt6360_pmu_attach_i_handler(int irq, void *data)
> +{
> +	struct mt6360_chg_info *mci = data;
> +	int ret;
> +	unsigned int usb_status;
> +	int last_usb_type;
> +
> +	dev_dbg(mci->dev, "%s\n", __func__);
> +	mutex_lock(&mci->chgdet_lock);
> +	if (!mci->bc12_en) {
> +		dev_info(mci->dev, "%s: bc12 disabled, ignore irq\n", __func__);
> +		goto out;
> +	}
> +	last_usb_type = mci->psy_usb_type;
> +	/* Plug in */
> +	ret = regmap_read(mci->regmap, MT6360_PMU_USB_STATUS1, &usb_status);
> +	if (ret < 0)
> +		goto out;
> +	usb_status &= MT6360_USB_STATUS_MASK;
> +	usb_status >>= MT6360_USB_STATUS_SHFT;
> +	switch (usb_status) {
> +	case MT6360_CHG_TYPE_UNDER_GOING:
> +		dev_info(mci->dev, "%s: under going...\n", __func__);
> +		goto out;
> +	case MT6360_CHG_TYPE_SDP:
> +		mci->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case MT6360_CHG_TYPE_SDPNSTD:
> +		mci->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case MT6360_CHG_TYPE_CDP:
> +		mci->psy_usb_type = POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	case MT6360_CHG_TYPE_DCP:
> +		mci->psy_usb_type = POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	default:
> +		dev_warn(mci->dev,
> +			 "%s: disconnect or unknown status\n", __func__);
> +		goto out;
> +	}
> +
> +	dev_info(mci->dev, "%s: chg_type = %d\n", __func__, mci->psy_usb_type);
> +	if (last_usb_type != mci->psy_usb_type)
> +		power_supply_changed(mci->psy);
> +out:
> +	mutex_unlock(&mci->chgdet_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static void mt6360_handle_chrdet_ext_evt(struct mt6360_chg_info *mci)
> +{
> +	int ret;
> +	bool pwr_rdy;
> +
> +	mutex_lock(&mci->chgdet_lock);
> +	ret = mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		goto out;
> +	if (mci->pwr_rdy == pwr_rdy) {
> +		dev_info(mci->dev,
> +			 "%s: pwr_rdy is same(%d)\n", __func__, pwr_rdy);
> +		goto out;
> +	}
> +	mci->pwr_rdy = pwr_rdy;
> +	dev_info(mci->dev, "%s: pwr_rdy = %d\n", __func__, pwr_rdy);
> +	if (!pwr_rdy) {
> +		mci->psy_usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		power_supply_changed(mci->psy);
> +
> +	}
> +	ret = regmap_update_bits(mci->regmap,
> +				 MT6360_PMU_DEVICE_TYPE,
> +				 MT6360_USBCHGEN_MASK,
> +				 pwr_rdy ? MT6360_USBCHGEN_MASK : 0);
> +	if (ret < 0)
> +		goto out;
> +	mci->bc12_en = pwr_rdy;
> +out:
> +	mutex_unlock(&mci->chgdet_lock);
> +}
> +
> +static void mt6360_chrdet_work(struct work_struct *work)
> +{
> +	struct mt6360_chg_info *mci = (struct mt6360_chg_info *)container_of(
> +				     work, struct mt6360_chg_info, chrdet_work);
> +
> +	dev_info(mci->dev, "%s\n", __func__);
> +	mt6360_handle_chrdet_ext_evt(mci);
> +}
> +
> +static irqreturn_t mt6360_pmu_chrdet_ext_evt_handler(int irq, void *data)
> +{
> +	struct mt6360_chg_info *mci = data;
> +
> +	dev_info(mci->dev, "%s\n", __func__);
> +	mt6360_handle_chrdet_ext_evt(mci);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mt6360_chg_irq_register(struct platform_device *pdev)
> +{
> +	const struct {
> +		const char *name;
> +		irq_handler_t handler;
> +	} irq_descs[] = {
> +		{ "attach_i", mt6360_pmu_attach_i_handler },
> +		{ "chrdet_ext_evt", mt6360_pmu_chrdet_ext_evt_handler }
> +	};
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(irq_descs); i++) {
> +		ret = platform_get_irq_byname(pdev, irq_descs[i].name);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, ret, NULL,
> +						irq_descs[i].handler,
> +						IRQF_TRIGGER_FALLING,
> +						irq_descs[i].name,
> +						platform_get_drvdata(pdev));
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Failed to request %s irq\n",
> +				irq_descs[i].name);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct mt6360_field_info {
> +	struct device_attribute dev_attr;
> +	u16 reg;
> +	u8 mask;
> +	u8 shft;
> +};
> +
> +static ssize_t mt6360_sysfs_show(struct device *dev,
> +		struct device_attribute *attr, char *buf);
> +static ssize_t mt6360_sysfs_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count);
> +
> +#define MT6360_FIELD_RW(_name, _reg, _nbit)			\
> +{								\
> +	.dev_attr = __ATTR(_name, 0664,				\
> +		       mt6360_sysfs_show, mt6360_sysfs_store),	\
> +	.reg	= MT6360_PMU_##_reg,				\
> +	.mask	= MT6360_##_nbit##_MASK,				\
> +	.shft	= MT6360_##_nbit##_SHFT,				\
> +}
> +
> +#define MT6360_FIELD_RO(_name, _reg, _nbit)			\
> +{								\
> +	.dev_attr = __ATTR(_name, 0444,				\
> +			mt6360_sysfs_show, NULL),		\
> +	.reg	= MT6360_PMU_##_reg,				\
> +	.mask	= MT6360_##_nbit##_MASK,			\
> +	.shft	= MT6360_##_nbit##_SHFT,			\
> +}
> +
> +static struct mt6360_field_info mt6360_field_tbl[] = {
> +	MT6360_FIELD_RW(hiz,		CHG_CTRL1,	HIZ),
> +	MT6360_FIELD_RW(vmivr,		CHG_CTRL6,	VMIVR),
> +	MT6360_FIELD_RW(iaicr,		CHG_CTRL3,	IAICR),
> +	MT6360_FIELD_RW(SYSREG,		CHG_CTRL11,	SYSREG),
> +	MT6360_FIELD_RW(otg_oc,		CHG_CTRL10,	OTG_OC),
> +	MT6360_FIELD_RW(ichg,		CHG_CTRL17,	ICHG),
> +	MT6360_FIELD_RW(iprec,		CHG_CTRL8,	IPREC),
> +	MT6360_FIELD_RW(ieoc,		CHG_CTRL9,	IEOC),
> +	MT6360_FIELD_RW(voreg,		CHG_CTRL4,	VOREG),
> +	MT6360_FIELD_RW(lbp,		CHG_CTRL10,	LBP),
> +	MT6360_FIELD_RW(vrec,		CHG_CTRL11,	VREC),
> +	MT6360_FIELD_RW(te,		CHG_CTRL2,	TE),
> +	MT6360_FIELD_RW(chg_wdt_en,	CHG_CTRL13,	CHG_WDT_EN),
> +	MT6360_FIELD_RW(chg_wdt,	CHG_CTRL13,	CHG_WDT),
> +	MT6360_FIELD_RW(wt_fc,		CHG_CTRL12,	WT_FC),
> +	MT6360_FIELD_RW(bat_comp,	CHG_CTRL18,	BAT_COMP),
> +	MT6360_FIELD_RW(vclamp,		CHG_CTRL18,	VCLAMP),
> +	MT6360_FIELD_RW(usbchgen,	DEVICE_TYPE,	USBCHGEN),
> +	MT6360_FIELD_RW(chg_en,		CHG_CTRL2,	CHG_EN),
> +	MT6360_FIELD_RO(chrdet_ext,	FOD_STAT,	CHRDET_EXT),
> +};
> +
> +static struct attribute *mt6360_attrs[ARRAY_SIZE(mt6360_field_tbl) + 1];
> +
> +static const struct attribute_group mt6360_attr_group = {
> +	.attrs = mt6360_attrs,
> +};
> +
> +static ssize_t mt6360_sysfs_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct mt6360_chg_info *mci = dev_get_drvdata(dev->parent);
> +	struct mt6360_field_info *info = (void *)attr;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(mci->regmap, info->reg, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & info->mask) >> info->shft;
> +	return scnprintf(buf, PAGE_SIZE, "%02x\n", regval);
> +}
> +
> +static ssize_t mt6360_sysfs_store(struct device *dev,
> +		   struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct mt6360_chg_info *mci = dev_get_drvdata(dev->parent);
> +	struct mt6360_field_info *info = (void *)attr;
> +	int ret, tmp;
> +
> +	if (kstrtoint(buf, 10, &tmp) < 0) {
> +		dev_err(dev, "Failed to parse number\n");
> +		return -EINVAL;
> +	}
> +	ret = regmap_update_bits(mci->regmap,
> +				 info->reg, info->mask, tmp << info->shft);
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +
> +static int mt6360_sysfs_create_group(struct mt6360_chg_info *mci)
> +{
> +	int i, tb_size = ARRAY_SIZE(mt6360_field_tbl);
> +
> +	for (i = 0; i < tb_size; i++)
> +		mt6360_attrs[i] = &(mt6360_field_tbl[i].dev_attr.attr);
> +	return devm_device_add_group(&mci->psy->dev, &mt6360_attr_group);
> +}
> +
> +static int mt6360_chg_init_setting(struct mt6360_chg_info *mci)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(mci->regmap, MT6360_PMU_DEVICE_TYPE,
> +				 MT6360_USBCHGEN_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(mci->dev, "%s: Failed to disable bc12\n", __func__);
> +		goto out;
> +	}
> +	ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL2,
> +				 MT6360_IINLMTSEL_MASK,
> +				 MT6360_IINLMTSEL_AICR <<
> +					MT6360_IINLMTSEL_SHFT);
> +	if (ret < 0) {
> +		dev_err(mci->dev,
> +			"%s: Failed to switch iinlmtsel to aicr\n", __func__);
> +		goto out;
> +	}
> +	usleep_range(5000, 6000);
> +	ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL3,
> +				 MT6360_ILIM_EN_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(mci->dev,
> +			"%s: Failed to disable ilim\n", __func__);
> +		goto out;
> +	}
> +	ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL10,
> +				 MT6360_OTG_OC_MASK, MT6360_OTG_OC_MASK);
> +	if (ret < 0) {
> +		dev_err(mci->dev,
> +			"%s: Failed to config otg oc to 3A\n", __func__);
> +	}
> +out:
> +	return ret;
> +}
> +
> +static u32 mt6360_vinovp_trans_to_sel(u32 val)
> +{
> +	u32 vinovp_tbl[] = { 5500000, 6500000, 11000000, 14500000 };
> +	int i;
> +
> +	/* Select the smaller and equal supported value */
> +	for (i = 0; i < ARRAY_SIZE(vinovp_tbl)-1; i++) {
> +		if (val < vinovp_tbl[i+1])
> +			break;
> +	}
> +	return i;
> +}
> +
> +static struct mt6360_chg_platform_data *mt6360_parse_pdata(
> +						   struct platform_device *pdev)
> +{
> +	struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	pdata = kmemdup(&def_platform_data, sizeof(*pdata), GFP_KERNEL);
> +	ret = of_property_read_u32(np, "richtek,vinovp-microvolt",
> +				   &pdata->vinovp);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to parse vinovp in DT\n");
> +		return ERR_PTR(ret);
> +	}
> +	return pdata;
> +}
> +
> +static int mt6360_apply_pdata(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct mt6360_chg_info *mci = dev_get_drvdata(&pdev->dev);
> +	int ret;
> +	u32 sel;
> +
> +	sel = mt6360_vinovp_trans_to_sel(pdata->vinovp);
> +	ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL19,
> +				 MT6360_VINOVP_MASK, sel << MT6360_VINOVP_SHFT);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static int mt6360_charger_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct mt6360_chg_info *mci;
> +	struct power_supply_config charger_cfg = {};
> +	struct regulator_config config = { };
> +	int ret;
> +
> +	mci = devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	pdata = mt6360_parse_pdata(pdev);
> +	if (IS_ERR_OR_NULL(pdata))
> +		return PTR_ERR(pdata);
> +
> +	pdev->dev.platform_data = pdata;
> +
> +	mci->dev = &pdev->dev;
> +	mutex_init(&mci->chgdet_lock);
> +	platform_set_drvdata(pdev, mci);
> +	INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> +
> +	mci->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mci->regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = mt6360_apply_pdata(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to apply pdata\n");
> +		return ret;
> +	}
> +
> +	memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci->psy_desc));
> +	mci->psy_desc.name = dev_name(&pdev->dev);
> +	charger_cfg.drv_data = mci;
> +	charger_cfg.of_node = pdev->dev.of_node;
> +	charger_cfg.supplied_to = mt6360_charger_supplied_to;
> +	charger_cfg.num_supplicants = ARRAY_SIZE(mt6360_charger_supplied_to);
> +	mci->psy = devm_power_supply_register(&pdev->dev,
> +					      &mci->psy_desc, &charger_cfg);
> +	if (IS_ERR(mci->psy)) {
> +		dev_err(&pdev->dev, "Failed to register power supply dev\n");
> +		return PTR_ERR(mci->psy);
> +	}
> +
> +	ret = mt6360_chg_init_setting(mci);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initial setting\n");
> +		return ret;
> +	}
> +
> +	schedule_work(&mci->chrdet_work);
> +
> +	ret = mt6360_chg_irq_register(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register irqs\n");
> +		return ret;
> +	}
> +
> +	config.dev = &pdev->dev;
> +	config.regmap = mci->regmap;
> +	mci->otg_rdev = devm_regulator_register(&pdev->dev, &mt6360_otg_rdesc,
> +						&config);
> +	if (IS_ERR(mci->otg_rdev))
> +		return PTR_ERR(mci->otg_rdev);
> +
> +	ret = mt6360_sysfs_create_group(mci);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"%s: Failed to create sysfs attrs\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused mt6360_charger_of_id[] = {
> +	{ .compatible = "mediatek,mt6360-chg", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_charger_of_id);
> +

I think we should fix MFD code to not need to use a DT binding here. See [1].

Regards,
Matthias

[1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/

> +static const struct platform_device_id mt6360_charger_id[] = {
> +	{ "mt6360-chg", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, mt6360_charger_id);
> +
> +static struct platform_driver mt6360_charger_driver = {
> +	.driver = {
> +		.name = "mt6360-chg",
> +		.of_match_table = of_match_ptr(mt6360_charger_of_id),
> +	},
> +	.probe = mt6360_charger_probe,
> +	.id_table = mt6360_charger_id,
> +};
> +module_platform_driver(mt6360_charger_driver);
> +
> +MODULE_AUTHOR("CY_Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 Charger Driver");
> +MODULE_LICENSE("GPL");
> 

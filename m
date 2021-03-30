Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07934E6DB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhC3LtB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 07:49:01 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42794 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhC3LsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 07:48:17 -0400
Received: by mail-lj1-f172.google.com with SMTP id 184so19501647ljf.9;
        Tue, 30 Mar 2021 04:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=ZCsq71iHmso1XAOt42lydFFOyhVFeiKpy6GIPK3K4eQ=;
        b=sr3aivuTvhbEk9Da74NWs9btmnI8uZTCYlfuurEc/SBBcs2Jjqlv/wTmEK+1cHUG7y
         u+VAF7X1UAcTKp2stJhZSn5cBPnuoSRCLiz5/emzBiGQrlhvJPg1OeEEYVA1+jQh+BJm
         8W3HkdZ2x3ftaK7VIJ3N1onyqZz6/aXhe8yWpTnf8rnmF97czcQ4Pd4Y4mstBvEr10Hx
         b9BVaqEyN/z1VSV37V1jDCM39614NqQaxND0mWzRIZlZOKB1qIU4JBNM4LFPffM7QdYI
         40jNuM2YC+zBMj1S2G7XNcZJuUmleB89/MUjPHjD5khLHFsLQ1GI8oKGu1XqAaG0pxOA
         hhJA==
X-Gm-Message-State: AOAM5337hTEn4Kl3RfhnXoxqc5Wfe0rghjT2bhhYj1Op4QCPHzS9oNAs
        AB8zZEqET5m1dc9hVj6ClAzH6uZV2k1FbQ==
X-Google-Smtp-Source: ABdhPJxsbikjvT/1UC/7RBiFI/y40feTCRCejzHpSOLOsSPsMQIsn9j4H3rpVrCjsAAFqKObZuVdnA==
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr20093868ljg.168.1617104895689;
        Tue, 30 Mar 2021 04:48:15 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id f10sm2154167lfm.194.2021.03.30.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:48:15 -0700 (PDT)
Message-ID: <771c7da0584cf37da6ba370207a89a7401a20c33.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/2] power: supply: mt6360_charger: add MT6360
 charger support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
In-Reply-To: <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
         <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 30 Mar 2021 14:48:05 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 2021-01-18 at 20:41 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add basic support for the battery charger for MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |  10 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/mt6360_charger.c | 914
> ++++++++++++++++++++++++++++++++++
>  3 files changed, 925 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
> 

Thanks for the contribution :)

Few comments which I am not demanding to be 'fixed' - but which might
be good to be checked. Eg, please consider my comments as 'nit's.

...

> +static unsigned int mt6360_map_reg_sel(u32 data, u32 min, u32 max,
> u32 step)
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

lib/linear_ranges.c might already implement this ...

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

...and this.

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

linear_ranges?

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

linear_ranges?

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

linear_ranges?

> +	return 0;
> +}
> +
> +static int mt6360_charger_get_mivr(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL6, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval = (regval & MT6360_VMIVR_MASK) >> MT6360_VMIVR_SHFT;
> +	val->intval = mt6360_map_real_val(regval,
> +					  MT6360_VMIVR_MIN,
> +					  MT6360_VMIVR_MAX,
> +					  MT6360_VMIVR_STEP);

linear_ranges?

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

linear_ranges?

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

linear_ranges?

> +	return 0;
> +}
> +
> +static int mt6360_charger_set_online(struct mt6360_chg_info *mci,
> +				     const union power_supply_propval
> *val)
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
> +				   const union power_supply_propval
> *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_ICHG_MIN,
> +				 MT6360_ICHG_MAX,
> +				 MT6360_ICHG_STEP);

linear_ranges?

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

linear_ranges?

> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL4,
> +				  MT6360_VOREG_MASK,
> +				  sel << MT6360_VOREG_SHFT);
> +}
> +
> +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval
> *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_AICR_MIN,
> +				 MT6360_AICR_MAX,
> +				 MT6360_AICR_STEP);

linear_ranges?

> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL3,
> +				  MT6360_IAICR_MASK,
> +				  sel << MT6360_IAICR_SHFT);
> +}
> +
> +static int mt6360_charger_set_mivr(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval
> *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_VMIVR_MIN,
> +				 MT6360_VMIVR_MAX,
> +				 MT6360_VMIVR_STEP);

linear_ranges?

> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL3,
> +				  MT6360_VMIVR_MASK,
> +				  sel << MT6360_VMIVR_SHFT);
> +}
> +
> +static int mt6360_charger_set_iprechg(struct mt6360_chg_info *mci,
> +				      const union power_supply_propval
> *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_IPREC_MIN,
> +				 MT6360_IPREC_MAX,
> +				 MT6360_IPREC_STEP);

linear_ranges?

> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL8,
> +				  MT6360_IPREC_MASK,
> +				  sel << MT6360_IPREC_SHFT);
> +}
> +
> +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval
> *val)
> +{
> +	u8 sel;
> +
> +	sel = mt6360_map_reg_sel(val->intval,
> +				 MT6360_IEOC_MIN,
> +				 MT6360_IEOC_MAX,
> +				 MT6360_IEOC_STEP);

linear_ranges?

> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL9,
> +				  MT6360_IEOC_MASK,
> +				  sel << MT6360_IEOC_SHFT);
> +}
> +
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

Any particular reason why these are here and not in a regulator driver?

...

> +static int mt6360_charger_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci;
> +	struct power_supply_config charger_cfg = {};
> +	struct regulator_config config = { };
> +	int ret;
> +
> +	mci = devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	ret = mt6360_parse_dt(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to parse
> dt\n");
> +
> +	mci->dev = &pdev->dev;
> +	mci->vinovp = 6500000;
> +	mutex_init(&mci->chgdet_lock);
> +	platform_set_drvdata(pdev, mci);
> +	INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> +
> +	mci->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mci->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to
> get parent regmap\n");
> +
> +	ret = mt6360_apply_dt(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to apply
> dt\n");
> +
> +	memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci-
> >psy_desc));
> +	mci->psy_desc.name = dev_name(&pdev->dev);
> +	charger_cfg.drv_data = mci;
> +	charger_cfg.of_node = pdev->dev.of_node;
> +	mci->psy = devm_power_supply_register(&pdev->dev,
> +					      &mci->psy_desc,
> &charger_cfg);
> +	if (IS_ERR(mci->psy))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(mci->psy),
> +				     "Failed to register power supply
> dev\n");
> +
> +	ret = mt6360_chg_init_setting(mci);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to
> initial setting\n");
> +
> +	schedule_work(&mci->chrdet_work);

Is this work scheduled anywhere else? If not - why doing this in wq
context? If yes - does this wq need cancellation upon exit?

> +
> +	ret = mt6360_chg_irq_register(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to
> register irqs\n");
> +
> +	config.dev = &pdev->dev;
> +	config.regmap = mci->regmap;
> +	mci->otg_rdev = devm_regulator_register(&pdev->dev,
> &mt6360_otg_rdesc,
> +						&config);
> +	if (IS_ERR(mci->otg_rdev))
> +		return PTR_ERR(mci->otg_rdev);
> +
> +	return 0;
> +}
> +

Best Regards
	Matti Vaittinen


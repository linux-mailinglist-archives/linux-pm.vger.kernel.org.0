Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008039264B
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 06:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhE0E1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 00:27:03 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41789 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhE0E1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 00:27:02 -0400
Received: by mail-lf1-f53.google.com with SMTP id v8so5939473lft.8;
        Wed, 26 May 2021 21:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=A6XihYnFlzkPCNtWSOzgmDAQCKSQJKNmgxsmJVVZWVM=;
        b=nu0AjmQuxvuH0wLOpTz6gKsMyJVgVh56NtxdUPFBHdOMuW4+Ku0MOpDyqmUdiaYN6J
         AoFo/fCX1EnkM2I11fPGexClw+zRaLfmoLu2139Et2uQ8rgkPcS4O8iM6Ac+xtE8ddRR
         HNtTU8UtZZo/zWcTQFkPJwyPcS3RkN6q0u8mWHNCKHVmfsY/zRnPfbmrvtbcllIpqqdN
         qYaRBZxVwCbaiKp6AB2rA9hkgMb7KhQy9jKEiZ4AYntWtKSc2PgFHFvGYG/Pt+K3Z4Z9
         jK2WgOb0j874euFGihq0JHzH6ilBOW6nqNumsPTYAUhfiw8I4G68mfPcxUhuzMRptL1X
         1NjQ==
X-Gm-Message-State: AOAM532Ldlf/8BA6SB0NGNg+vQWrQ66kYPcdjR+9c4oZ0xs6jb7msps2
        yzBYpkdErpg1Fw6z1emlP+s=
X-Google-Smtp-Source: ABdhPJwJxFL6OPBSBceAf1/A3GKP+8c6zIFJgxtpiodXPQEqw7TRWb3i275/uKEd3oZ7ftEiOfb55g==
X-Received: by 2002:a05:6512:220c:: with SMTP id h12mr1055097lfu.374.1622089527390;
        Wed, 26 May 2021 21:25:27 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id t15sm112148ljk.99.2021.05.26.21.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 21:25:26 -0700 (PDT)
Message-ID: <a4646a277d692f4b4a04382b7367b641b2ff0fc6.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/2] power: supply: mt6360_charger: add MT6360
 charger support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
In-Reply-To: <CAE+NS35BOC6rr4U9rtBkNph8mZCVV=5MGbh0VQXBvhLRkBaAvQ@mail.gmail.com>
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
         <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
         <771c7da0584cf37da6ba370207a89a7401a20c33.camel@fi.rohmeurope.com>
         <CAE+NS35BOC6rr4U9rtBkNph8mZCVV=5MGbh0VQXBvhLRkBaAvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 27 May 2021 07:25:20 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 2021-05-26 at 17:40 +0800, Gene Chen wrote:
> Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> 於 2021年3月30日 週二
> 下午7:48寫道：
> > 
> > On Mon, 2021-01-18 at 20:41 +0800, Gene Chen wrote:
> > > From: Gene Chen <gene_chen@richtek.com>
> > > 
> > > Add basic support for the battery charger for MT6360 PMIC
> > > 
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/power/supply/Kconfig          |  10 +
> > >  drivers/power/supply/Makefile         |   1 +
> > >  drivers/power/supply/mt6360_charger.c | 914
> > > ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 925 insertions(+)
> > >  create mode 100644 drivers/power/supply/mt6360_charger.c
> > > 
> > 
> > Thanks for the contribution :)
> > 
> > Few comments which I am not demanding to be 'fixed' - but which
> > might
> > be good to be checked. Eg, please consider my comments as 'nit's.
> > 
> > ...
> > 
> > > +static unsigned int mt6360_map_reg_sel(u32 data, u32 min, u32
> > > max,
> > > u32 step)
> > > +{
> > > +     u32 target = 0, max_sel;
> > > +
> > > +     if (data >= min) {
> > > +             target = (data - min) / step;
> > > +             max_sel = (max - min) / step;
> > > +             if (target > max_sel)
> > > +                     target = max_sel;
> > > +     }
> > > +     return target;
> > > +}
> > 
> > lib/linear_ranges.c might already implement this ...
> > 
> 
> I found we are neither linear_range_get_selector_high or
> linear_range_get_selector_low.
> When value lower than min_value, choose min_sel. If higher than
> max_value, choose max_sel.

Ah, correct.

> Should I create linear_range_get_selector() for this?

My suggestion would be yes, but I am not insisting on it.

> 
> > > +
> > > +static u32 mt6360_map_real_val(u32 sel, u32 min, u32 max, u32
> > > step)
> > > +{
> > > +     u32 target = 0;
> > > +
> > > +     target = min + (sel * step);
> > > +     if (target > max)
> > > +             target = max;
> > > +     return target;
> > > +}
> > 
> > ...and this.
> > 
> 
> ACK, We can use "linear_range_get_value", but maybe wait for reply
> about "mt6360_map_reg_sel"
> 
> > > +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> > > +                                union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_ICHG_MIN,
> > > +                                       MT6360_ICHG_MAX,
> > > +                                       MT6360_ICHG_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_max_ichg(struct mt6360_chg_info
> > > *mci,
> > > +                                    union power_supply_propval
> > > *val)
> > > +{
> > > +     val->intval = MT6360_ICHG_MAX;
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_cv(struct mt6360_chg_info *mci,
> > > +                              union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL4,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_VOREG_MASK) >> MT6360_VOREG_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_VOREG_MIN,
> > > +                                       MT6360_VOREG_MAX,
> > > +                                       MT6360_VOREG_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_max_cv(struct mt6360_chg_info
> > > *mci,
> > > +                                  union power_supply_propval
> > > *val)
> > > +{
> > > +     val->intval = MT6360_VOREG_MAX;
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_aicr(struct mt6360_chg_info *mci,
> > > +                                union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL3,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_IAICR_MASK) >> MT6360_IAICR_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_AICR_MIN,
> > > +                                       MT6360_AICR_MAX,
> > > +                                       MT6360_AICR_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_mivr(struct mt6360_chg_info *mci,
> > > +                                union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL6,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_VMIVR_MASK) >> MT6360_VMIVR_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_VMIVR_MIN,
> > > +                                       MT6360_VMIVR_MAX,
> > > +                                       MT6360_VMIVR_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_iprechg(struct mt6360_chg_info
> > > *mci,
> > > +                                   union power_supply_propval
> > > *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL8,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_IPREC_MASK) >> MT6360_IPREC_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_IPREC_MIN,
> > > +                                       MT6360_IPREC_MAX,
> > > +                                       MT6360_IPREC_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_get_ieoc(struct mt6360_chg_info *mci,
> > > +                                union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret = regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL9,
> > > &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & MT6360_IEOC_MASK) >> MT6360_IEOC_SHFT;
> > > +     val->intval = mt6360_map_real_val(regval,
> > > +                                       MT6360_IEOC_MIN,
> > > +                                       MT6360_IEOC_MAX,
> > > +                                       MT6360_IEOC_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_set_online(struct mt6360_chg_info
> > > *mci,
> > > +                                  const union
> > > power_supply_propval
> > > *val)
> > > +{
> > > +     u8 force_sleep = val->intval ? 0 : 1;
> > > +
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL1,
> > > +                               MT6360_FSLP_MASK,
> > > +                               force_sleep << MT6360_FSLP_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_ichg(struct mt6360_chg_info *mci,
> > > +                                const union power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_ICHG_MIN,
> > > +                              MT6360_ICHG_MAX,
> > > +                              MT6360_ICHG_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL7,
> > > +                               MT6360_ICHG_MASK,
> > > +                               sel << MT6360_ICHG_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_cv(struct mt6360_chg_info *mci,
> > > +                              const union power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_VOREG_MIN,
> > > +                              MT6360_VOREG_MAX,
> > > +                              MT6360_VOREG_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL4,
> > > +                               MT6360_VOREG_MASK,
> > > +                               sel << MT6360_VOREG_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> > > +                                const union power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_AICR_MIN,
> > > +                              MT6360_AICR_MAX,
> > > +                              MT6360_AICR_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL3,
> > > +                               MT6360_IAICR_MASK,
> > > +                               sel << MT6360_IAICR_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_mivr(struct mt6360_chg_info *mci,
> > > +                                const union power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_VMIVR_MIN,
> > > +                              MT6360_VMIVR_MAX,
> > > +                              MT6360_VMIVR_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL3,
> > > +                               MT6360_VMIVR_MASK,
> > > +                               sel << MT6360_VMIVR_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_iprechg(struct mt6360_chg_info
> > > *mci,
> > > +                                   const union
> > > power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_IPREC_MIN,
> > > +                              MT6360_IPREC_MAX,
> > > +                              MT6360_IPREC_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL8,
> > > +                               MT6360_IPREC_MASK,
> > > +                               sel << MT6360_IPREC_SHFT);
> > > +}
> > > +
> > > +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> > > +                                const union power_supply_propval
> > > *val)
> > > +{
> > > +     u8 sel;
> > > +
> > > +     sel = mt6360_map_reg_sel(val->intval,
> > > +                              MT6360_IEOC_MIN,
> > > +                              MT6360_IEOC_MAX,
> > > +                              MT6360_IEOC_STEP);
> > 
> > linear_ranges?
> > 
> > > +     return regmap_update_bits(mci->regmap,
> > > +                               MT6360_PMU_CHG_CTRL9,
> > > +                               MT6360_IEOC_MASK,
> > > +                               sel << MT6360_IEOC_SHFT);
> > > +}
> > > +
> > > +
> > 
> > 
> > > +static const struct regulator_ops mt6360_chg_otg_ops = {
> > > +     .list_voltage = regulator_list_voltage_linear,
> > > +     .enable = regulator_enable_regmap,
> > > +     .disable = regulator_disable_regmap,
> > > +     .is_enabled = regulator_is_enabled_regmap,
> > > +     .set_voltage_sel = regulator_set_voltage_sel_regmap,
> > > +     .get_voltage_sel = regulator_get_voltage_sel_regmap,
> > > +};
> > > +
> > > +static const struct regulator_desc mt6360_otg_rdesc = {
> > > +     .of_match = "usb-otg-vbus",
> > > +     .name = "usb-otg-vbus",
> > > +     .ops = &mt6360_chg_otg_ops,
> > > +     .owner = THIS_MODULE,
> > > +     .type = REGULATOR_VOLTAGE,
> > > +     .min_uV = 4425000,
> > > +     .uV_step = 25000,
> > > +     .n_voltages = 57,
> > > +     .vsel_reg = MT6360_PMU_CHG_CTRL5,
> > > +     .vsel_mask = MT6360_VOBST_MASK,
> > > +     .enable_reg = MT6360_PMU_CHG_CTRL1,
> > > +     .enable_mask = MT6360_OPA_MODE_MASK,
> > > +};
> > 
> > Any particular reason why these are here and not in a regulator
> > driver?
> > 
> 
> MT6360 charger is a switching charger which can charging or boost OTG
> VBUS.
> 

I see. It was just strange for me to see the regulators being set-up in
the charger driver. I would have expected to see separate regulator
driver for this, I guess this is MFD in any case, right? So I would
have expected seeing a sub-device for regulators.

I however see we have couple of other charger drivers here doing the
same thing (setting up regulators in charger driver) - so if this is
normal then I for sure have no objections :)

> > ...
> > 
> > > +static int mt6360_charger_probe(struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_chg_info *mci;
> > > +     struct power_supply_config charger_cfg = {};
> > > +     struct regulator_config config = { };
> > > +     int ret;
> > > +
> > > +     mci = devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> > > +     if (!mci)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = mt6360_parse_dt(pdev);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > > parse
> > > dt\n");
> > > +
> > > +     mci->dev = &pdev->dev;
> > > +     mci->vinovp = 6500000;
> > > +     mutex_init(&mci->chgdet_lock);
> > > +     platform_set_drvdata(pdev, mci);
> > > +     INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> > > +
> > > +     mci->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +     if (!mci->regmap)
> > > +             return dev_err_probe(&pdev->dev, -ENODEV, "Failed
> > > to
> > > get parent regmap\n");
> > > +
> > > +     ret = mt6360_apply_dt(pdev);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > > apply
> > > dt\n");
> > > +
> > > +     memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci-
> > > > psy_desc));
> > > +     mci->psy_desc.name = dev_name(&pdev->dev);
> > > +     charger_cfg.drv_data = mci;
> > > +     charger_cfg.of_node = pdev->dev.of_node;
> > > +     mci->psy = devm_power_supply_register(&pdev->dev,
> > > +                                           &mci->psy_desc,
> > > &charger_cfg);
> > > +     if (IS_ERR(mci->psy))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(mci->psy),
> > > +                                  "Failed to register power
> > > supply
> > > dev\n");
> > > +
> > > +     ret = mt6360_chg_init_setting(mci);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > > initial setting\n");
> > > +
> > > +     schedule_work(&mci->chrdet_work);
> > 
> > Is this work scheduled anywhere else? If not - why doing this in wq
> > context? If yes - does this wq need cancellation upon exit?
> > 
> 
> MT6360 MFD driver probe will clear all interrupts then add charger
> device.
> We need to schedule work for handling boot-up vbus is always exist,
> because irq is already cleared.
> 

Thank you for the explanation. I was just wondering why not checking
charger status right here? I didn't understand why the checking was
pushed to a WQ. You probably have a valid reason. I assume it's just me
who is not understanding this :) Additionally I was wondering what
happens if for example the IRQ registration below fails and we detach
the driver - I don't see work-queue being flushed. Thanks for all the
explanations!

> > > +
> > > +     ret = mt6360_chg_irq_register(pdev);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > > register irqs\n");
> > > +
> > > +     config.dev = &pdev->dev;
> > > +     config.regmap = mci->regmap;
> > > +     mci->otg_rdev = devm_regulator_register(&pdev->dev,
> > > &mt6360_otg_rdesc,
> > > +                                             &config);
> > > +     if (IS_ERR(mci->otg_rdev))
> > > +             return PTR_ERR(mci->otg_rdev);
> > > +
> > > +     return 0;
> > > +}
> > > +


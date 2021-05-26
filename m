Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB33913E2
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 11:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhEZJlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhEZJlt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 05:41:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313BC061574;
        Wed, 26 May 2021 02:40:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z3so895699oib.5;
        Wed, 26 May 2021 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GabZeTtpZL3JqUUthscu+MLUoyWKNc+vu/IuoGbuKUA=;
        b=c7/m3uK35FyMES8a73FeV8aW+CDP2g5wKHjWIrKSGELMgXsCh7q6qW+LWImNge+fJn
         mIp/mBADbXRv6QzIa31T+hpvb8Byc8BPtmf3nnY6MQsCOBnQg95gWTY+F1aJHfDzD+zO
         xCbRPzdoimShFce9YEOMA5IaAqgHEFUuLKegK/L08dslej3fZ7lJtNc1Pi8TwXmR4xi5
         VbRQwBidTLhkKGWemclfL0xhppBLRjTX9ofuLBeu6xRDsQvGzj9iCLwEO+IXV52xO095
         3yic0FAmaXe8jdXdzHoA/RIt/QJW893DpRogHM6aFZ+bhepZsOi18fbAkwgfdtkHKgqD
         E1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GabZeTtpZL3JqUUthscu+MLUoyWKNc+vu/IuoGbuKUA=;
        b=KsrwlUxLI4JM7u65B0jcMgY5fOqNdEQnrnD8c7d2LiE9WZwwU0CPRHxbEfGBjWtfxo
         1mPzunXOdgqSAMqOiTzPCExs3Zene7dSSNr6hdMAlOcFphKh7+bWUl08BVe7rZXiT8eX
         gYedwB4vz4zgIQXYzgh5HEqFz5Da8k2/UbAFBilwQEMo7yP2rjadJeD4kWzO9Lbd7b77
         X297FhWivqBS+Z2mp9vFq9xGeOUmMaXbE70kqlPCnIiOCGCnCYs6J9q+OJQsMyT5VmRk
         ZPie3etc3fKQ95tkTENZEw1W+KjUP6OTBwLyd39//KqQu9fi/tkHN4NTN6e9INc7Js+Y
         TyJg==
X-Gm-Message-State: AOAM532h4YkE1B/tAQw7Ek2ptFTV5XZAwwKjOY+FFgGXj3qJpLnjOITR
        VTAodnvGELDS6dZm9V75OeAkw41E//kUWBdCWQE=
X-Google-Smtp-Source: ABdhPJwFd4ppBY0ln/41ZlQXkpC9PACNFr6moUswHFrSYjSboftQjIl0ply9Mg5pHsW1H5gkL52MO3Ho4FTPZYN9eEY=
X-Received: by 2002:aca:3197:: with SMTP id x145mr1206670oix.23.1622022017421;
 Wed, 26 May 2021 02:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
 <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com> <771c7da0584cf37da6ba370207a89a7401a20c33.camel@fi.rohmeurope.com>
In-Reply-To: <771c7da0584cf37da6ba370207a89a7401a20c33.camel@fi.rohmeurope.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Wed, 26 May 2021 17:40:06 +0800
Message-ID: <CAE+NS35BOC6rr4U9rtBkNph8mZCVV=5MGbh0VQXBvhLRkBaAvQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] power: supply: mt6360_charger: add MT6360 charger support
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> =E6=96=BC 2021=E5=B9=B4=
3=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:48=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
>
> On Mon, 2021-01-18 at 20:41 +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add basic support for the battery charger for MT6360 PMIC
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/power/supply/Kconfig          |  10 +
> >  drivers/power/supply/Makefile         |   1 +
> >  drivers/power/supply/mt6360_charger.c | 914
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 925 insertions(+)
> >  create mode 100644 drivers/power/supply/mt6360_charger.c
> >
>
> Thanks for the contribution :)
>
> Few comments which I am not demanding to be 'fixed' - but which might
> be good to be checked. Eg, please consider my comments as 'nit's.
>
> ...
>
> > +static unsigned int mt6360_map_reg_sel(u32 data, u32 min, u32 max,
> > u32 step)
> > +{
> > +     u32 target =3D 0, max_sel;
> > +
> > +     if (data >=3D min) {
> > +             target =3D (data - min) / step;
> > +             max_sel =3D (max - min) / step;
> > +             if (target > max_sel)
> > +                     target =3D max_sel;
> > +     }
> > +     return target;
> > +}
>
> lib/linear_ranges.c might already implement this ...
>

I found we are neither linear_range_get_selector_high or
linear_range_get_selector_low.
When value lower than min_value, choose min_sel. If higher than
max_value, choose max_sel.
Should I create linear_range_get_selector() for this?

> > +
> > +static u32 mt6360_map_real_val(u32 sel, u32 min, u32 max, u32 step)
> > +{
> > +     u32 target =3D 0;
> > +
> > +     target =3D min + (sel * step);
> > +     if (target > max)
> > +             target =3D max;
> > +     return target;
> > +}
>
> ...and this.
>

ACK, We can use "linear_range_get_value", but maybe wait for reply
about "mt6360_map_reg_sel"

> > +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> > +                                union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_ICHG_MIN,
> > +                                       MT6360_ICHG_MAX,
> > +                                       MT6360_ICHG_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_max_ichg(struct mt6360_chg_info *mci,
> > +                                    union power_supply_propval *val)
> > +{
> > +     val->intval =3D MT6360_ICHG_MAX;
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_cv(struct mt6360_chg_info *mci,
> > +                              union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL4, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_VOREG_MASK) >> MT6360_VOREG_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_VOREG_MIN,
> > +                                       MT6360_VOREG_MAX,
> > +                                       MT6360_VOREG_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_max_cv(struct mt6360_chg_info *mci,
> > +                                  union power_supply_propval *val)
> > +{
> > +     val->intval =3D MT6360_VOREG_MAX;
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_aicr(struct mt6360_chg_info *mci,
> > +                                union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL3, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_IAICR_MASK) >> MT6360_IAICR_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_AICR_MIN,
> > +                                       MT6360_AICR_MAX,
> > +                                       MT6360_AICR_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_mivr(struct mt6360_chg_info *mci,
> > +                                union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL6, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_VMIVR_MASK) >> MT6360_VMIVR_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_VMIVR_MIN,
> > +                                       MT6360_VMIVR_MAX,
> > +                                       MT6360_VMIVR_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_iprechg(struct mt6360_chg_info *mci,
> > +                                   union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL8, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_IPREC_MASK) >> MT6360_IPREC_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_IPREC_MIN,
> > +                                       MT6360_IPREC_MAX,
> > +                                       MT6360_IPREC_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_get_ieoc(struct mt6360_chg_info *mci,
> > +                                union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL9, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +     regval =3D (regval & MT6360_IEOC_MASK) >> MT6360_IEOC_SHFT;
> > +     val->intval =3D mt6360_map_real_val(regval,
> > +                                       MT6360_IEOC_MIN,
> > +                                       MT6360_IEOC_MAX,
> > +                                       MT6360_IEOC_STEP);
>
> linear_ranges?
>
> > +     return 0;
> > +}
> > +
> > +static int mt6360_charger_set_online(struct mt6360_chg_info *mci,
> > +                                  const union power_supply_propval
> > *val)
> > +{
> > +     u8 force_sleep =3D val->intval ? 0 : 1;
> > +
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL1,
> > +                               MT6360_FSLP_MASK,
> > +                               force_sleep << MT6360_FSLP_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_ichg(struct mt6360_chg_info *mci,
> > +                                const union power_supply_propval
> > *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_ICHG_MIN,
> > +                              MT6360_ICHG_MAX,
> > +                              MT6360_ICHG_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL7,
> > +                               MT6360_ICHG_MASK,
> > +                               sel << MT6360_ICHG_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_cv(struct mt6360_chg_info *mci,
> > +                              const union power_supply_propval *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_VOREG_MIN,
> > +                              MT6360_VOREG_MAX,
> > +                              MT6360_VOREG_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL4,
> > +                               MT6360_VOREG_MASK,
> > +                               sel << MT6360_VOREG_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> > +                                const union power_supply_propval
> > *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_AICR_MIN,
> > +                              MT6360_AICR_MAX,
> > +                              MT6360_AICR_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL3,
> > +                               MT6360_IAICR_MASK,
> > +                               sel << MT6360_IAICR_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_mivr(struct mt6360_chg_info *mci,
> > +                                const union power_supply_propval
> > *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_VMIVR_MIN,
> > +                              MT6360_VMIVR_MAX,
> > +                              MT6360_VMIVR_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL3,
> > +                               MT6360_VMIVR_MASK,
> > +                               sel << MT6360_VMIVR_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_iprechg(struct mt6360_chg_info *mci,
> > +                                   const union power_supply_propval
> > *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_IPREC_MIN,
> > +                              MT6360_IPREC_MAX,
> > +                              MT6360_IPREC_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL8,
> > +                               MT6360_IPREC_MASK,
> > +                               sel << MT6360_IPREC_SHFT);
> > +}
> > +
> > +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> > +                                const union power_supply_propval
> > *val)
> > +{
> > +     u8 sel;
> > +
> > +     sel =3D mt6360_map_reg_sel(val->intval,
> > +                              MT6360_IEOC_MIN,
> > +                              MT6360_IEOC_MAX,
> > +                              MT6360_IEOC_STEP);
>
> linear_ranges?
>
> > +     return regmap_update_bits(mci->regmap,
> > +                               MT6360_PMU_CHG_CTRL9,
> > +                               MT6360_IEOC_MASK,
> > +                               sel << MT6360_IEOC_SHFT);
> > +}
> > +
> > +
>
>
>
> > +static const struct regulator_ops mt6360_chg_otg_ops =3D {
> > +     .list_voltage =3D regulator_list_voltage_linear,
> > +     .enable =3D regulator_enable_regmap,
> > +     .disable =3D regulator_disable_regmap,
> > +     .is_enabled =3D regulator_is_enabled_regmap,
> > +     .set_voltage_sel =3D regulator_set_voltage_sel_regmap,
> > +     .get_voltage_sel =3D regulator_get_voltage_sel_regmap,
> > +};
> > +
> > +static const struct regulator_desc mt6360_otg_rdesc =3D {
> > +     .of_match =3D "usb-otg-vbus",
> > +     .name =3D "usb-otg-vbus",
> > +     .ops =3D &mt6360_chg_otg_ops,
> > +     .owner =3D THIS_MODULE,
> > +     .type =3D REGULATOR_VOLTAGE,
> > +     .min_uV =3D 4425000,
> > +     .uV_step =3D 25000,
> > +     .n_voltages =3D 57,
> > +     .vsel_reg =3D MT6360_PMU_CHG_CTRL5,
> > +     .vsel_mask =3D MT6360_VOBST_MASK,
> > +     .enable_reg =3D MT6360_PMU_CHG_CTRL1,
> > +     .enable_mask =3D MT6360_OPA_MODE_MASK,
> > +};
>
> Any particular reason why these are here and not in a regulator driver?
>

MT6360 charger is a switching charger which can charging or boost OTG VBUS.

> ...
>
> > +static int mt6360_charger_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6360_chg_info *mci;
> > +     struct power_supply_config charger_cfg =3D {};
> > +     struct regulator_config config =3D { };
> > +     int ret;
> > +
> > +     mci =3D devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> > +     if (!mci)
> > +             return -ENOMEM;
> > +
> > +     ret =3D mt6360_parse_dt(pdev);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret, "Failed to parse
> > dt\n");
> > +
> > +     mci->dev =3D &pdev->dev;
> > +     mci->vinovp =3D 6500000;
> > +     mutex_init(&mci->chgdet_lock);
> > +     platform_set_drvdata(pdev, mci);
> > +     INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> > +
> > +     mci->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!mci->regmap)
> > +             return dev_err_probe(&pdev->dev, -ENODEV, "Failed to
> > get parent regmap\n");
> > +
> > +     ret =3D mt6360_apply_dt(pdev);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret, "Failed to apply
> > dt\n");
> > +
> > +     memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci-
> > >psy_desc));
> > +     mci->psy_desc.name =3D dev_name(&pdev->dev);
> > +     charger_cfg.drv_data =3D mci;
> > +     charger_cfg.of_node =3D pdev->dev.of_node;
> > +     mci->psy =3D devm_power_supply_register(&pdev->dev,
> > +                                           &mci->psy_desc,
> > &charger_cfg);
> > +     if (IS_ERR(mci->psy))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(mci->psy),
> > +                                  "Failed to register power supply
> > dev\n");
> > +
> > +     ret =3D mt6360_chg_init_setting(mci);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > initial setting\n");
> > +
> > +     schedule_work(&mci->chrdet_work);
>
> Is this work scheduled anywhere else? If not - why doing this in wq
> context? If yes - does this wq need cancellation upon exit?
>

MT6360 MFD driver probe will clear all interrupts then add charger device.
We need to schedule work for handling boot-up vbus is always exist,
because irq is already cleared.

> > +
> > +     ret =3D mt6360_chg_irq_register(pdev);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret, "Failed to
> > register irqs\n");
> > +
> > +     config.dev =3D &pdev->dev;
> > +     config.regmap =3D mci->regmap;
> > +     mci->otg_rdev =3D devm_regulator_register(&pdev->dev,
> > &mt6360_otg_rdesc,
> > +                                             &config);
> > +     if (IS_ERR(mci->otg_rdev))
> > +             return PTR_ERR(mci->otg_rdev);
> > +
> > +     return 0;
> > +}
> > +
>
> Best Regards
>         Matti Vaittinen
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EA29C9DB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830973AbgJ0UNM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 16:13:12 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44044 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbgJ0UNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:13:11 -0400
Received: by mail-ej1-f67.google.com with SMTP id j24so438641ejc.11;
        Tue, 27 Oct 2020 13:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HqJmJCDPovYzugndA/OMAMO1DYv3EvZsetrZulAFRJo=;
        b=XNjJs5AzOegBZJJBjJem3T87m+EQEguZU2+rGU4XU32A58MrCbfojG6+pZlGoftB9Y
         Si7nNr/1OUqNNYuScUqq7xTdHHWKmBqu/Qji9Bk77g+nrP/oQpBulc//7na99M0HS17U
         20jAlpAMKPLZAVHzyl+t/wMF/sbrNTWWj9nKhSgJdUqmgodB03umbiCBtnZrolvTESyL
         UCTQw4j9jwkVMZOirv7CPa9Dhj7sbaaMk0U3pqbdVHmTJT/gSR9hJNBWRgtbYSxuvlIG
         8K2fLAA6HATpUQWXOoOpLWQwkODWPxuL8m1AgDalRMChctkRBGZ0NKeDU0aHpWPAoN10
         bRbQ==
X-Gm-Message-State: AOAM532oc4ZYu1/JwYSYwue1fWHYhp+e+VbvDRlvKV2+PCv79lOA6PoK
        CunJso4YvLCqQ9fc79kZI4Sg0ZlIrZTejcXB
X-Google-Smtp-Source: ABdhPJyxK5jb4+SSk0aVsGdjabxNWjpMoCztjBqVDZCFX5oikJ0sRp4orCdpmh6hLK6tm2a1tCG9/Q==
X-Received: by 2002:a17:906:1411:: with SMTP id p17mr4377404ejc.102.1603829587542;
        Tue, 27 Oct 2020 13:13:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id u24sm1548170edo.92.2020.10.27.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:13:06 -0700 (PDT)
Date:   Tue, 27 Oct 2020 21:13:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, cy_huang@richtek.com,
        shufan_lee@richtek.com
Subject: Re: [PATCH 2/2] power: supply: mt6360_charger: add MT6360 charger
 support
Message-ID: <20201027201304.GA142632@kozik-lap>
References: <1600859910-15855-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600859910-15855-2-git-send-email-gene.chen.richtek@gmail.com>
 <20201016155227.GB9890@kozik-lap>
 <CAE+NS37LE69rko0RyMjNHdTJWeaHJA7LZYqb6RHoz=Fi8jPdug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAE+NS37LE69rko0RyMjNHdTJWeaHJA7LZYqb6RHoz=Fi8jPdug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 02:45:12PM +0800, Gene Chen wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 於 2020年10月16日 週五 下午11:52寫道：
> >
 
> No, I will remove it.
> 
> > > +             irq = platform_get_irq_byname(pdev, irq_desc->name);
> >
> > Interrupts were not described in the bindings.
> >
> 
> I add resource when MFD driver add sub-device. Should I add something
> in dt-binding?

I think I missed the part that you are taking here interrupts from
parent MFD device. Bindings are fine then.

> 
>        ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> mt6360_devs,
>                                    ARRAY_SIZE(mt6360_devs), NULL, 0,
>                                    regmap_irq_get_domain(ddata->irq_data));
> 
> static const struct resource mt6360_chg_resources[] = {
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_TREG_EVT, "chg_treg_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_PWR_RDY_EVT, "pwr_rdy_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_BATSYSUV_EVT,
> "chg_batsysuv_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSUV_EVT, "chg_vsysuv_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSOV_EVT, "chg_vsysov_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBATOV_EVT, "chg_vbatov_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBUSOV_EVT, "chg_vbusov_evt"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_AICCMEASL, "chg_aiccmeasl"),
>         DEFINE_RES_IRQ_NAMED(MT6360_WDTMRI, "wdtmri"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_RECHGI, "chg_rechgi"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_TERMI, "chg_termi"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHG_IEOCI, "chg_ieoci"),
>         DEFINE_RES_IRQ_NAMED(MT6360_PUMPX_DONEI, "pumpx_donei"),
>         DEFINE_RES_IRQ_NAMED(MT6360_ATTACH_I, "attach_i"),
>         DEFINE_RES_IRQ_NAMED(MT6360_CHRDET_EXT_EVT, "chrdet_ext_evt"),
> 
> > > +             if (irq < 0)
> > > +                     continue;
> > > +             ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > > +                                             irq_desc->irq_handler,
> > > +                                             IRQF_TRIGGER_FALLING,
> > > +                                             irq_desc->name,
> > > +                                             platform_get_drvdata(pdev));
> >
> > Why you use handler thread per each interrupt? This should be rather one
> > handler. Especially that most of your handlers do nothing.
> >
> 
> I will remove serveral irqs which is do nothing, and only keep
> chrdet_ext for power ready and attachi for bc12 done.
> I add serveral resources in MFD device.
> Do you mean I use IRQF_SHARED to reduce irq?

I meant to use on thread_fn for most of them. I think, if you were using
regmap_irq_chip and virtual IRQ here (see regmap_irq_get_virq), you
could entirely skip the non-important interrupts. Just ignore them.
Should be less code.

> 
> > > +             if (ret < 0) {
> > > +                     dev_err(&pdev->dev,
> > > +                             "request %s irq fail\n", irq_desc->name);
> > > +                     return ret;
> > > +             }
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +struct mt6360_field_info {
> > > +     struct device_attribute dev_attr;
> > > +     u8 reg;
> > > +     u8 mask;
> > > +     u8 shft;
> > > +};
> > > +
> > > +static ssize_t mt6360_sysfs_show(struct device *dev,
> > > +             struct device_attribute *attr, char *buf);
> > > +static ssize_t mt6360_sysfs_store(struct device *dev,
> > > +             struct device_attribute *attr, const char *buf, size_t count);
> > > +
> > > +#define MT6360_FIELD_RW(_name, _reg, _nbit)                  \
> > > +{                                                            \
> > > +     .dev_attr = __ATTR(_name, 0664,                         \
> > > +                    mt6360_sysfs_show, mt6360_sysfs_store),  \
> > > +     .reg    = MT6360_PMU_##_reg,                            \
> > > +     .mask   = MT6360_MASK_##_nbit,                          \
> > > +     .shft   = MT6360_SHFT_##_nbit,                          \
> > > +}
> > > +
> > > +#define MT6360_FIELD_RO(_name, _reg, _nbit)                  \
> > > +{                                                            \
> > > +     .dev_attr = __ATTR(_name, 0444,                         \
> > > +                     mt6360_sysfs_show, NULL),               \
> > > +     .reg    = MT6360_PMU_##_reg,                            \
> > > +     .mask   = MT6360_MASK_##_nbit,                          \
> > > +     .shft   = MT6360_SHFT_##_nbit,                          \
> > > +}
> > > +
> > > +static struct mt6360_field_info mt6360_field_tbl[] = {
> > > +     MT6360_FIELD_RW(hiz,            CHG_CTRL1,      HIZ),
> > > +     MT6360_FIELD_RW(vmivr,          CHG_CTRL6,      VMIVR),
> > > +     MT6360_FIELD_RW(iaicr,          CHG_CTRL3,      IAICR),
> > > +     MT6360_FIELD_RW(SYSREG,         CHG_CTRL11,     SYSREG),
> > > +     MT6360_FIELD_RW(otg_oc,         CHG_CTRL10,     OTG_OC),
> > > +     MT6360_FIELD_RW(ichg,           CHG_CTRL17,     ICHG),
> > > +     MT6360_FIELD_RW(iprec,          CHG_CTRL8,      IPREC),
> > > +     MT6360_FIELD_RW(ieoc,           CHG_CTRL9,      IEOC),
> > > +     MT6360_FIELD_RW(voreg,          CHG_CTRL4,      VOREG),
> > > +     MT6360_FIELD_RW(lbp,            CHG_CTRL10,     LBP),
> > > +     MT6360_FIELD_RW(vrec,           CHG_CTRL11,     VREC),
> > > +     MT6360_FIELD_RW(te,             CHG_CTRL2,      TE),
> > > +     MT6360_FIELD_RW(chg_wdt_en,     CHG_CTRL13,     CHG_WDT_EN),
> > > +     MT6360_FIELD_RW(chg_wdt,        CHG_CTRL13,     CHG_WDT),
> > > +     MT6360_FIELD_RW(wt_fc,          CHG_CTRL12,     WT_FC),
> > > +     MT6360_FIELD_RW(bat_comp,       CHG_CTRL18,     BAT_COMP),
> > > +     MT6360_FIELD_RW(vclamp,         CHG_CTRL18,     VCLAMP),
> > > +     MT6360_FIELD_RW(usbchgen,       DEVICE_TYPE,    USBCHGEN),
> > > +     MT6360_FIELD_RW(chg_en,         CHG_CTRL2,      CHG_EN),
> > > +     MT6360_FIELD_RO(chrdet_ext,     FOD_STAT,       CHRDET_EXT),
> > > +};
> > > +
> > > +static struct attribute *mt6360_attrs[ARRAY_SIZE(mt6360_field_tbl) + 1];
> > > +
> > > +static const struct attribute_group mt6360_attr_group = {
> > > +     .attrs = mt6360_attrs,
> > > +};
> > > +
> > > +static ssize_t mt6360_sysfs_show(struct device *dev,
> > > +                              struct device_attribute *attr, char *buf)
> > > +{
> > > +     struct mt6360_chg_info *mci = dev_get_drvdata(dev->parent);
> > > +     struct mt6360_field_info *info = (void *)attr;
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     ret = regmap_read(mci->regmap, info->reg, &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval = (regval & info->mask) >> info->shft;
> > > +     return scnprintf(buf, PAGE_SIZE, "%02x\n", regval);
> > > +}
> > > +
> > > +static ssize_t mt6360_sysfs_store(struct device *dev,
> > > +                struct device_attribute *attr, const char *buf, size_t count)
> > > +{
> > > +     struct mt6360_chg_info *mci = dev_get_drvdata(dev->parent);
> > > +     struct mt6360_field_info *info = (void *)attr;
> > > +     int ret, tmp;
> > > +
> > > +     if (kstrtoint(buf, 10, &tmp) < 0) {
> > > +             dev_err(dev, "failed to parsing number\n");
> > > +             return -EINVAL;
> > > +     }
> > > +     ret = regmap_update_bits(mci->regmap,
> > > +                              info->reg, info->mask, tmp << info->shft);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     return count;
> > > +}
> > > +
> > > +static int mt6360_sysfs_create_group(struct mt6360_chg_info *mci)
> > > +{
> > > +     int i, tb_size = ARRAY_SIZE(mt6360_field_tbl);
> > > +
> > > +     for (i = 0; i < tb_size; i++)
> > > +             mt6360_attrs[i] = &(mt6360_field_tbl[i].dev_attr.attr);
> > > +     return devm_device_add_group(&mci->psy->dev, &mt6360_attr_group);
> > > +}
> > > +
> > > +static int mt6360_chg_init_setting(struct mt6360_chg_info *mci)
> > > +{
> > > +     int ret;
> > > +
> > > +     /* Disable bc12 */
> > > +     ret = regmap_update_bits(mci->regmap, MT6360_PMU_DEVICE_TYPE,
> > > +                              MT6360_MASK_USBCHGEN, 0);
> > > +     if (ret < 0) {
> > > +             dev_err(mci->dev, "%s: disable bc12 fail\n", __func__);
> > > +             goto out;
> > > +     }
> > > +     /* Set input current limit select by AICR */
> > > +     ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL2,
> > > +                              MT6360_MASK_IINLMTSEL,
> > > +                              MT6360_IINLMTSEL_AICR <<
> > > +                                     MT6360_SHFT_IINLMTSEL);
> > > +     if (ret < 0) {
> > > +             dev_err(mci->dev,
> > > +                     "%s: switch iinlmtsel to aicr fail\n", __func__);
> > > +             goto out;
> > > +     }
> > > +     usleep_range(5000, 6000);
> > > +     /* Disable ilim */
> > > +     ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL3,
> > > +                              MT6360_MASK_ILIM_EN, 0);
> > > +     if (ret < 0) {
> > > +             dev_err(mci->dev,
> > > +                     "%s: switch iinlmtsel to aicr fail\n", __func__);
> > > +             goto out;
> > > +     }
> > > +     /* Enlarge OTG_OC to max 3A */
> > > +     ret = regmap_update_bits(mci->regmap,
> > > +                              MT6360_PMU_CHG_CTRL10, 0x07, 0x07);
> > > +     if (ret < 0) {
> > > +             dev_err(mci->dev,
> > > +                     "%s: faled config otg oc to maximum\n", __func__);
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static u32 mt6360_vinovp_trans_to_sel(u32 val)
> > > +{
> > > +     u32 vinovp_tbl[] = { 5500000, 6500000, 11000000, 14500000 };
> > > +     int i;
> > > +
> > > +     /* Select the smaller and equal supported value */
> > > +     for (i = 0; i < ARRAY_SIZE(vinovp_tbl)-1; i++) {
> > > +             if (val < vinovp_tbl[i+1])
> > > +                     break;
> > > +     }
> > > +     return i;
> > > +}
> > > +
> > > +static struct mt6360_chg_platform_data *mt6360_parse_pdata(
> > > +                                                struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > +     struct device_node *np = pdev->dev.of_node;
> > > +     int ret;
> > > +
> > > +     pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> > > +     if (!pdata)
> > > +             return ERR_PTR(-ENOMEM);
> > > +     memcpy(pdata, &def_platform_data, sizeof(*pdata));
> >
> > Use kmemdup or something similar.
> >
> 
> ACK
> 
> > > +     ret = of_property_read_u32(np, "vinovp", &pdata->vinovp);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "failed to parse vinovp in DT\n");
> > > +             return ERR_PTR(ret);
> > > +     }
> > > +     return pdata;
> > > +}
> > > +
> > > +static int mt6360_apply_pdata(struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > +     struct mt6360_chg_info *mci = dev_get_drvdata(&pdev->dev);
> > > +     int ret;
> > > +     u32 sel;
> > > +
> > > +     sel = mt6360_vinovp_trans_to_sel(pdata->vinovp);
> > > +     ret = regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL19,
> > > +                              MT6360_MASK_VINOVP, sel << MT6360_SHFT_VINOVP);
> > > +     if (ret)
> > > +             return ret;
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_charger_probe(struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_chg_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > +     struct mt6360_chg_info *mci;
> > > +     struct power_supply_config charger_cfg = {};
> > > +     struct regulator_config config = { };
> > > +     int ret;
> > > +
> > > +     mci = devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> > > +     if (!mci)
> > > +             return -ENOMEM;
> > > +
> > > +     pdata = mt6360_parse_pdata(pdev);
> > > +     if (IS_ERR_OR_NULL(pdata))
> > > +             return PTR_ERR(pdata);
> > > +
> > > +     pdev->dev.platform_data = pdata;
> > > +
> > > +     mci->dev = &pdev->dev;
> > > +     mutex_init(&mci->chgdet_lock);
> > > +     platform_set_drvdata(pdev, mci);
> > > +     INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> > > +
> > > +     mci->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +     if (!mci->regmap) {
> > > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret = mt6360_apply_pdata(pdev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to apply pdata\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     mci->edev = devm_extcon_dev_allocate(&pdev->dev, mt6360_extcon_cable);
> > > +     if (IS_ERR(mci->edev)) {
> > > +             dev_err(&pdev->dev, "Failed to allocate memory for extcon\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     ret = devm_extcon_dev_register(&pdev->dev, mci->edev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to register extcon dev\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci->psy_desc));
> > > +     mci->psy_desc.name = dev_name(&pdev->dev);
> > > +     charger_cfg.drv_data = mci;
> > > +     charger_cfg.of_node = pdev->dev.of_node;
> > > +     charger_cfg.supplied_to = mt6360_charger_supplied_to;
> > > +     charger_cfg.num_supplicants = ARRAY_SIZE(mt6360_charger_supplied_to);
> > > +     mci->psy = devm_power_supply_register(&pdev->dev,
> > > +                                           &mci->psy_desc, &charger_cfg);
> > > +     if (IS_ERR(mci->psy)) {
> > > +             dev_err(&pdev->dev, "Failed to register power supply dev\n");
> > > +             return PTR_ERR(mci->psy);
> > > +     }
> > > +
> > > +     ret = mt6360_chg_init_setting(mci);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to initial setting\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     schedule_work(&mci->chrdet_work);
> > > +
> > > +     ret = mt6360_chg_irq_register(pdev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to register irqs\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     config.dev = &pdev->dev;
> > > +     config.regmap = mci->regmap;
> > > +     mci->otg_rdev = devm_regulator_register(&pdev->dev, &mt6360_otg_rdesc,
> > > +                                             &config);
> > > +     if (IS_ERR(mci->otg_rdev))
> > > +             return PTR_ERR(mci->otg_rdev);
> > > +
> > > +     ret = mt6360_sysfs_create_group(mci);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev,
> > > +                     "%s: create sysfs attrs fail\n", __func__);
> > > +             return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id __maybe_unused mt6360_charger_of_id[] = {
> > > +     { .compatible = "mediatek,mt6360-chg", },
> > > +     {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mt6360_charger_of_id);
> > > +
> > > +static const struct platform_device_id mt6360_charger_id[] = {
> > > +     { "mt6360-chg", 0 },
> > > +     {},
> > > +};
> > > +MODULE_DEVICE_TABLE(platform, mt6360_charger_id);
> > > +
> > > +static struct platform_driver mt6360_charger_driver = {
> > > +     .driver = {
> > > +             .name = "mt6360-chg",
> > > +             .owner = THIS_MODULE,
> >
> > Not needed. You did not run coccinelle, right?
> >
> > > +             .of_match_table = of_match_ptr(mt6360_charger_of_id),
> > > +     },
> > > +     .probe = mt6360_charger_probe,
> > > +     .id_table = mt6360_charger_id,
> > > +};
> > > +module_platform_driver(mt6360_charger_driver);
> > > +
> > > +MODULE_AUTHOR("CY_Huang <cy_huang@richtek.com>");
> > > +MODULE_DESCRIPTION("MT6360 Charger Driver");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_VERSION("1.0.0");
> >
> > Skip version.
> >
> >
> 
> ACK
> 
> > All these comments were after looking briefly - I did not perform a
> > thorough review.  I am surprised that you combined regulator and charger
> > driver in one. It is doable but makes driver bigger and more difficult
> > to maintain. Consider splitting them.
> >
> 
> MT6360 charger is switching charger, Can I keep regulator for boost
> OTG like bq24190?

It's ok.

Best regards,
Krzysztof

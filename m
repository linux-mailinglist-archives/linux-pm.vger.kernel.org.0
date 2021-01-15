Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107032F73BB
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbhAOHd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 02:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbhAOHd0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 02:33:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF3C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 23:32:45 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so6465052wmz.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 23:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dg3fcenP6YIm0aYs5w4I6Adx/SFGTjlnu+FOvTsHu6s=;
        b=gxUveA9YGhNb2E0mZMUvTHI+xbr056FxLZgftfCZZGeNOF+yJ9kajtQExO+pdJR3qx
         BLnTtJDuM10lTPfSe/TNs/D6zWrnF+RDifagNGXkh9NzzEPnWLATnD41wIUUXTU3msTk
         Mq5Tkcpzrr9Y/X/lAsccBF2PsbSF/xuTcOOOXSl82oWcuDtlv73iVqwrlUF4P462WsPR
         w/UjHkhGsQJK0QC1WuIzsvDRmaanz15SvGJXwYOm7R/MSO4PtmnYA8Ix054Ghw5VnjW7
         74nqHDrKqAVyPcPhYjEAHt9B+qR2m+wBK6xmMz4DkHGOntE0rS6A6mbthBP1uMf2rFdk
         cOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dg3fcenP6YIm0aYs5w4I6Adx/SFGTjlnu+FOvTsHu6s=;
        b=LxXeIjiriLcbklzKxpP9RyZirahKUbp6XIa5JDJk9Nw4gPdI+qxqHUuUM4qtBWnogN
         UGAk/Hp+dMt+s1x0ro+e6c669LXugTPWiArgY81AhQMeJWD9eWWmhSl7TDGhJQYEC4uA
         b3IMayN145lzwEkOPPMsjyDbxPQvNaq2Pc8+lY0hFJeBzIJMrPuLvmwEyjRpXpF9rB2o
         ZYshh1AU0Mv8iigx4ZJ53zo0XscSNZXeNkjDDPKba8LwqHtG7ZdG9qXLfeukTlKWpmpf
         0Ad5+oOqSZTCngx5AcAumIdS/cNfbbbiWU0pWMMSY61oEYGoBqtdv3kIQ6RxMQ7I/thL
         arhw==
X-Gm-Message-State: AOAM532dl25wyeD6jAi4nYBHUuD68dYfn5ujYt9vVhWefeCfSp/40XHx
        8AHxPvwyLiMF8GOjP83l2iQ9OQ==
X-Google-Smtp-Source: ABdhPJyDsyZ0WWe8TcdEBpHT5umYuSY/TkSm8W+40uVNy+0csJt6A1ZznlatODu7M7D5wl3RVsB1vQ==
X-Received: by 2002:a1c:df85:: with SMTP id w127mr7535799wmg.166.1610695964629;
        Thu, 14 Jan 2021 23:32:44 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id w13sm13281029wrt.52.2021.01.14.23.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:32:43 -0800 (PST)
Date:   Fri, 15 Jan 2021 07:32:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sre@kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
Message-ID: <20210115073241.GC3975472@dell>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
 <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Jan 2021, Gene Chen wrote:

> Matthias Brugger <matthias.bgg@gmail.com> 於 2021年1月12日 週二 下午8:32寫道：
> >
> >
> >
> > On 12/11/2020 11:39, Gene Chen wrote:
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > > to simplify the similar resources object.
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index 692e47b..5119e51 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
> > >  };
> > >
> > > -static const struct resource mt6360_pmic_resources[] = {
> > > +static const struct resource mt6360_regulator_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > -};
> > > -
> > > -static const struct resource mt6360_ldo_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
> > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> >
> > As discussed with the MFD maintainer [1], the regulator (and probably all cells)
> > shouldn't have a DT binding.
> >
> > So please send a new version which fixes that.
> >
> > Regards,
> > Matthias
> >
> > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/

I don't think Mark is correct here.

We usually do implement compatible strings for sub-devices and they do
tend to have their own device nodes.

It's a very long time ago since I coded this up myself, but from
memory, you can't have 2 devices share a compatible string.

> Should I use parent's device to find sub-devices of_node if without
> compatible name?
> I trace the function mfd_add_device,
> 
> if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
>     .....
>     ret = mfd_match_of_node_to_dev(pdev, np, cell);
>     .....
> }
> 
> which is binding mfd sub-device with compatible. Does it be removed in
> the feature?
> 
> > >       OF_MFD_CELL("mt6360-tcpc", NULL,
> > >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> > >  };
> > >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

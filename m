Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0337B606
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 08:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhELGZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhELGZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 02:25:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34301C061760
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 23:24:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s8so22383006wrw.10
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t7gDJaqgoZsHb6DiIXvZKpSg+LB+FrrnWDOpfg5m9L8=;
        b=WO34k/7Bk2+xQd/jUD6S9ebWfCkyB6ieU4Ksl96o0Jdyk/ZifZVp+9xmgXEFZAvFDL
         DRyFrzDiZliI6/m1dDyzahGZxG/N1wOPkEEm7p6OXE2u6lJRGWKQxhlGNQFFTb9s7tjO
         hu2jvDjE93nyvARnR+BTfs6ROwqkhuCsu+SwEBiH1TaUvvibri4tk0deYUVsP8w8Vuyq
         8yWmrSq3uBnW5DOA7CE2BGExecvSagvWHNpKvjE+980YXT3zPKQqNgtjsGXhNjsENAHb
         uC2VECmmSHdTnO9fdeeU3znOI/8PmOZ6sUUvOhox4smOi9sqfKRtSOZJcGOOIEN0OrIT
         j++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t7gDJaqgoZsHb6DiIXvZKpSg+LB+FrrnWDOpfg5m9L8=;
        b=t4QVHk4nzZmI+ykKV2OXzDWvpl9XywXM690eNWxtIFTErvLEtHYrh6cRPoH75+ikez
         65z0fYnnr9dx1aguQ5DoCriAP623J7q6OP6lnCHFzQD45hvSCmQ/hmNylsoAiHdgHbgl
         pBF/QkbCWkx2m8gKRVk42044VW3D7quHKkgjwlH4LpQYpOYxEHKR/nG8JL8pDruXV4pU
         Tahyy938OxZhtkTfyCLTCH8NbqGy7ipAjkESILDmhMQCZD3MWksnlll5/YBNT9uqYSn8
         xqNry+V244ucPNkrNhBr/nvSlcWH9smWoTr8yZkvBqQK6zd52MeeYdemNmYC8Ru09hu+
         OIQw==
X-Gm-Message-State: AOAM531aA4qrn67h+xobUy0x3CIK36+H4EINQI/l5eD3hqqDMSuS/jEG
        JovILHADH6qc7i+oKIwmoAe10g==
X-Google-Smtp-Source: ABdhPJyXUCtio5iJ3s1PQFdvFz5rXvEBSNTrEg78ueKFXw5VVxcuzOCeqYEf2Kds9CfywK/Zy3FcBw==
X-Received: by 2002:adf:facf:: with SMTP id a15mr43701962wrs.53.1620800674099;
        Tue, 11 May 2021 23:24:34 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id z5sm324183wrn.69.2021.05.11.23.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:24:33 -0700 (PDT)
Date:   Wed, 12 May 2021 07:24:31 +0100
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
Message-ID: <20210512062431.GB805368@dell>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
 <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell>
 <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
 <20210323093806.GR2916463@dell>
 <CAE+NS37jmcyr2w9Z22-m5Ug7rF3Twq20poOLjptDX6E9E_7NLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS37jmcyr2w9Z22-m5Ug7rF3Twq20poOLjptDX6E9E_7NLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 May 2021, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2021年3月23日 週二 下午5:38寫道：
> >
> > On Tue, 02 Mar 2021, Gene Chen wrote:
> >
> > > Lee Jones <lee.jones@linaro.org> 於 2021年1月15日 週五 下午3:32寫道：
> > > >
> > > > On Fri, 15 Jan 2021, Gene Chen wrote:
> > > >
> > > > > Matthias Brugger <matthias.bgg@gmail.com> 於 2021年1月12日 週二 下午8:32寫道：
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 12/11/2020 11:39, Gene Chen wrote:
> > > > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > > > >
> > > > > > > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > > > > > > to simplify the similar resources object.
> > > > > > >
> > > > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > > > > index 692e47b..5119e51 100644
> > > > > > > --- a/drivers/mfd/mt6360-core.c
> > > > > > > +++ b/drivers/mfd/mt6360-core.c
> > > > > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
> > > > > > >  };
> > > > > > >
> > > > > > > -static const struct resource mt6360_pmic_resources[] = {
> > > > > > > +static const struct resource mt6360_regulator_resources[] = {
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > > > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > > > > > -};
> > > > > > > -
> > > > > > > -static const struct resource mt6360_ldo_resources[] = {
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
> > > > > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > > > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > > > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > > > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > > > > >
> > > > > > As discussed with the MFD maintainer [1], the regulator (and probably all cells)
> > > > > > shouldn't have a DT binding.
> > > > > >
> > > > > > So please send a new version which fixes that.
> > > > > >
> > > > > > Regards,
> > > > > > Matthias
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/
> > > >
> > > > I don't think Mark is correct here.
> > > >
> > > > We usually do implement compatible strings for sub-devices and they do
> > > > tend to have their own device nodes.
> > > >
> > > > It's a very long time ago since I coded this up myself, but from
> > > > memory, you can't have 2 devices share a compatible string.
> > > >
> > >
> > > Either Mark or Lee suggestion is work.
> > > Is there a conclusion that we can apply it?
> > > If MFD is already supported of_compatible, we prefer use of_compatible mapping.
> >
> > I would resubmit the set.  We can start afresh from there.
> 
> Dear Jones,
> 
>     Should I send fixed patch about adding regulator node directly can
> make easier for you to re-submit new patch?

Don't worry about me.  Do what's best for you.

I look forward to receiving the new set soon.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

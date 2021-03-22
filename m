Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B48343EB8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCVLBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCVLAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 07:00:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5910C061574;
        Mon, 22 Mar 2021 04:00:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so15488110oto.2;
        Mon, 22 Mar 2021 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MswKZYYZouzZ/DJU9aD32Wwz0ahxahnd05UPrcoeNOA=;
        b=bHl2ngaRSyHYtV22hVZZ6s070a52j+vhIZRPFwlNBJqUV5RHtpgQ1313zSO07TYVfP
         q48jTzvA9OhsPj4xm2oaAfgBkQM7uezv6rSrsOZhh8Ow7pKoARb6djnaedWViqL3DSNA
         InS6OsrgcmVMkcmH5XB4xOZV4G0kcANkF+qWP1ulnSbU7ATHbIDjhDNayAKQuemobgeX
         QnGfZ6ZYefAx6BrzVf/DZYwj7UYb3bv1jMh+59XMrDbJDZLt0L80g25H+GfkrjyeHmwg
         ptyFHv+X/8pFjU/X0jZ6lC0QtkQrKhjpUj0wYKcfHHul+5Pz5GkSsMl85cgp3e3QomgC
         e7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MswKZYYZouzZ/DJU9aD32Wwz0ahxahnd05UPrcoeNOA=;
        b=ZkT2FFZyBL4EmunRPpWA33dzUV20fNmRWoxc5uxMTsb6aBpH//yZPLC4Bve1mfJ1U7
         bVzikHfKmSiUrsBHdh6svXlVNTvrEYy08go38vz2/w9V1jN/TphNybF5l4JQH8ejLl8A
         RgZSQ9SbRMfu5yT7lI0AroMyjabrDHzHbieF++fNhXlHTMtwAKW/vcTsiqkiZYlL4rm9
         zCOzTamx0MOTk86QUimF9DDjGV+grt6XvmjntWWeYVJKeuzhyGBLSHjuUi9vG0o70Ndu
         3ntQCpceD1LakHWCO6H4DzTGEMUx4z8iPmlb5QVkwdAJ2SLeo6n4TA9wjlmDguD9yD8O
         grGg==
X-Gm-Message-State: AOAM531JIgcIyyvuQhn4nsvBv2F+qOzhR+GOBMaaqEzGjs6pUzNdQOL/
        R7Zm3KTHvMv8euYWE7ubujE1YoLM8laJxdQuF6E=
X-Google-Smtp-Source: ABdhPJzYWNIUnBRsr9jYj9MV52giagykpnsYjr14zOl/4YFf/K65sxbnlRqoSwlT4Hvbw7E4/QTnbwFn6qCYx5b35eg=
X-Received: by 2002:a9d:370:: with SMTP id 103mr10793042otv.232.1616410845129;
 Mon, 22 Mar 2021 04:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com> <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell> <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
In-Reply-To: <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 22 Mar 2021 19:00:34 +0800
Message-ID: <CAE+NS35R3y=mLcZWXtWbWrmoZLVfXc31a-xMqGuDD+CNbfqitA@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
To:     Lee Jones <lee.jones@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=882=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:32=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, 15 Jan 2021, Gene Chen wrote:
> >
> > > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2021=E5=B9=B41=E6=
=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:32=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > >
> > > >
> > > >
> > > > On 12/11/2020 11:39, Gene Chen wrote:
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > > > > to simplify the similar resources object.
> > > > >
> > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.=
c
> > > > > index 692e47b..5119e51 100644
> > > > > --- a/drivers/mfd/mt6360-core.c
> > > > > +++ b/drivers/mfd/mt6360-core.c
> > > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resou=
rces[] =3D {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_=
to_evt"),
> > > > >  };
> > > > >
> > > > > -static const struct resource mt6360_pmic_resources[] =3D {
> > > > > +static const struct resource mt6360_regulator_resources[] =3D {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt")=
,
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_reso=
urces[] =3D {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > > > -};
> > > > > -
> > > > > -static const struct resource mt6360_ldo_resources[] =3D {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] =
=3D {
> > > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > > >
> > > > As discussed with the MFD maintainer [1], the regulator (and probab=
ly all cells)
> > > > shouldn't have a DT binding.
> > > >
> > > > So please send a new version which fixes that.
> > > >
> > > > Regards,
> > > > Matthias
> > > >
> > > > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@si=
rena.org.uk/
> >
> > I don't think Mark is correct here.
> >
> > We usually do implement compatible strings for sub-devices and they do
> > tend to have their own device nodes.
> >
> > It's a very long time ago since I coded this up myself, but from
> > memory, you can't have 2 devices share a compatible string.
> >
>
> Either Mark or Lee suggestion is work.
> Is there a conclusion that we can apply it?
> If MFD is already supported of_compatible, we prefer use of_compatible ma=
pping.
>

Is there any update?

> > > Should I use parent's device to find sub-devices of_node if without
> > > compatible name?
> > > I trace the function mfd_add_device,
> > >
> > > if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) =
{
> > >     .....
> > >     ret =3D mfd_match_of_node_to_dev(pdev, np, cell);
> > >     .....
> > > }
> > >
> > > which is binding mfd sub-device with compatible. Does it be removed i=
n
> > > the feature?
> > >
> > > > >       OF_MFD_CELL("mt6360-tcpc", NULL,
> > > > >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> > > > >  };
> > > > >
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Senior Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog

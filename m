Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2738C32A2AE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376896AbhCBIRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379154AbhCBHRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 02:17:25 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73BC0617A9;
        Mon,  1 Mar 2021 23:16:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b8so19077925oti.7;
        Mon, 01 Mar 2021 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvv8ZYn5o9fAfH88FdY8LKHoCI4AuWaKRHSz9HOIfo4=;
        b=vI8VnN1HjfU5ubeo7oar9dcdw1FjnOapzOUa/JjKEJraWJy9ZQU6i4W0TkH/AdUQpt
         7UwZM9RLL2RxaPjfvrniGkjDOXP/GCypNlutbjhLaWYvn21EnvR1WyK7216zGRG3LTxG
         k8RRzr82MnRXdExbacTsojVsNRUeI74IOedc1laMQqIP2rQkDprVmTxG+3v9B27PTOFT
         kGuOQ9mNaJVC7QN4aCkSay4XLodac4r7pb/D6RJWY+tFPVNf0OTDrhuHHVIIkzDwx2rF
         Wys6Rpbl/k53nXWjn5ZlLLSTmoXhe7mwdgsRyz+OPVZG8KVpE9xWjRKNso+QevBxvWjL
         AioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvv8ZYn5o9fAfH88FdY8LKHoCI4AuWaKRHSz9HOIfo4=;
        b=qYf+VodDGDyqVUOrFFOJn+ZI066lLvXCwqWwzakqJW/2Ay+Zph9VnCEV6O/75jjZXH
         swFMecPiKMu3mlk+hsiAp58eywl9vu8RiTc3nc/1OrpTzZselSwp067GE80XlIsKCnHR
         htqg7yiHQUH+FKLyvcXKVvtBkCv1taQp4b6oq3jVJ9FaBDzEJ8H2fhCaYyDhGVFeqhjw
         R8uDpV8WB66Rr8EojJu+jze6WsYJHKOJJcgpsMJxEe0P8JAzdNch6Xjvid9ca1XzfDhk
         QWf1qg+RhB97hwrystkRpF1mZt6S7lQAbRgKFQi4tqCDkY6+iXjWVxCbH2WPeX4AGopN
         6DWQ==
X-Gm-Message-State: AOAM533OD48rROe02ChlrelRF5bGMvrpAf0ai75i2KkOxekeaqSir8sQ
        YDO/oY1hwzNBC6cBmevzP4Tf8JoM8FyriFVvsJQ=
X-Google-Smtp-Source: ABdhPJzbn+DmG8b0+YAooZV+sW8jO+BCSIm8/zqlbYXznrB9TaRejeGUUFs9CqxMhBQNv9z4O2KzuD0odgsc7iwM9wA=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr16608843otf.327.1614669404078;
 Mon, 01 Mar 2021 23:16:44 -0800 (PST)
MIME-Version: 1.0
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com> <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell>
In-Reply-To: <20210115073241.GC3975472@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 2 Mar 2021 15:16:34 +0800
Message-ID: <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8815=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 15 Jan 2021, Gene Chen wrote:
>
> > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2021=E5=B9=B41=E6=
=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:32=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > >
> > >
> > > On 12/11/2020 11:39, Gene Chen wrote:
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > > > to simplify the similar resources object.
> > > >
> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > index 692e47b..5119e51 100644
> > > > --- a/drivers/mfd/mt6360-core.c
> > > > +++ b/drivers/mfd/mt6360-core.c
> > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resourc=
es[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to=
_evt"),
> > > >  };
> > > >
> > > > -static const struct resource mt6360_pmic_resources[] =3D {
> > > > +static const struct resource mt6360_regulator_resources[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resour=
ces[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > > -};
> > > > -
> > > > -static const struct resource mt6360_ldo_resources[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] =3D=
 {
> > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > >
> > > As discussed with the MFD maintainer [1], the regulator (and probably=
 all cells)
> > > shouldn't have a DT binding.
> > >
> > > So please send a new version which fixes that.
> > >
> > > Regards,
> > > Matthias
> > >
> > > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sire=
na.org.uk/
>
> I don't think Mark is correct here.
>
> We usually do implement compatible strings for sub-devices and they do
> tend to have their own device nodes.
>
> It's a very long time ago since I coded this up myself, but from
> memory, you can't have 2 devices share a compatible string.
>

Either Mark or Lee suggestion is work.
Is there a conclusion that we can apply it?
If MFD is already supported of_compatible, we prefer use of_compatible mapp=
ing.

> > Should I use parent's device to find sub-devices of_node if without
> > compatible name?
> > I trace the function mfd_add_device,
> >
> > if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> >     .....
> >     ret =3D mfd_match_of_node_to_dev(pdev, np, cell);
> >     .....
> > }
> >
> > which is binding mfd sub-device with compatible. Does it be removed in
> > the feature?
> >
> > > >       OF_MFD_CELL("mt6360-tcpc", NULL,
> > > >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> > > >  };
> > > >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

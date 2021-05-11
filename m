Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4237A65F
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEKMPt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhEKMPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 08:15:48 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2FC061574;
        Tue, 11 May 2021 05:14:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v22so13935535oic.2;
        Tue, 11 May 2021 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wa5zxC12LevybTjgPskMwjNjFrqR4wunX6KrAZQ3xWM=;
        b=rngm6j0BTRFq+wHKWTfYYo1vpeqCpapMNcPXRp8InTyDMTP4gD5OY4QMvESFvlyh4P
         XAWi2uGvOM+OBdu+Td9l4Q7DGwI4mjiNq1mVc7PCLdQ+tnrKUDyw7I28oF/F4Ie1Bslp
         g5aERFMEZQy/Y4imeO58JcMqmCn1RhpB5ZMEQUgZvTLSrBPlJSzVeabndA8EJmeE8HQD
         8wLhVBdxP2afAq1Q2+yELu8fB7WKFRrNYWDGVzF1OCtj8a20itfpEKF1AqOtsKl2cK7S
         tV7/QyXuRjF8HTYaFp5LAIaJlCJtTUxXe/pA/ihVT9iNkNKbh0hr/COcab75eWjAncvs
         IfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wa5zxC12LevybTjgPskMwjNjFrqR4wunX6KrAZQ3xWM=;
        b=aeO4MGpwPjUJu/aLGpSPnFYA9ajjOSknJgaY4gwqyMLKdnSASF6KUfj34N/RDCn4jY
         TjhxvLei2yrKIu/iIvVzHMsmikbJVvG9EuuSE2oLLwc8dkwVeQxsAQVOW9faFkltKCDh
         KeH2iZc29gLEOODgTQbNIhzJRGYa5Bw9TRn3KBlr6g7w8aiH6vdNDLtsQPGRMtmOGfGy
         E3kdnZBOrP+09I/LgiLmIl8WxRltduzVUcaWsuYxxVVLCql0fYPihHWOgR9kPP1gBDuU
         oK46mA7j7YQhDD9UjKuhzZ2YTEvqeNN4jDxciclXbxyh1FXEMYcrZaGNDRPBbKCnEVFx
         4S7g==
X-Gm-Message-State: AOAM533lvPf+YTGq7NZyCAzW6GfFvkiLEyXfLTmMOcT+Tbw0yPANMvoF
        OlCL6FcTKjRgWw7YW3eI13Oh9zRmzls5ZImnxTs=
X-Google-Smtp-Source: ABdhPJwWA8mgD0ksaPPC7Or1KQ4PViyixmEDpe1wLUYXMhkBD1mm/ns6E6t1wwOaiKKIclHnmgflCsHlXXt+h9tZolg=
X-Received: by 2002:a05:6808:14c8:: with SMTP id f8mr3344139oiw.55.1620735281302;
 Tue, 11 May 2021 05:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com> <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell> <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
 <20210323093806.GR2916463@dell>
In-Reply-To: <20210323093806.GR2916463@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 11 May 2021 20:14:30 +0800
Message-ID: <CAE+NS37jmcyr2w9Z22-m5Ug7rF3Twq20poOLjptDX6E9E_7NLg@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 02 Mar 2021, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:32=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, 15 Jan 2021, Gene Chen wrote:
> > >
> > > > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2021=E5=B9=B41=
=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:32=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > >
> > > > >
> > > > >
> > > > > On 12/11/2020 11:39, Gene Chen wrote:
> > > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > > >
> > > > > > Combine mt6360 pmic/ldo resources into mt6360 regulator resourc=
es
> > > > > > to simplify the similar resources object.
> > > > > >
> > > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-cor=
e.c
> > > > > > index 692e47b..5119e51 100644
> > > > > > --- a/drivers/mfd/mt6360-core.c
> > > > > > +++ b/drivers/mfd/mt6360-core.c
> > > > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_res=
ources[] =3D {
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_str=
b_to_evt"),
> > > > > >  };
> > > > > >
> > > > > > -static const struct resource mt6360_pmic_resources[] =3D {
> > > > > > +static const struct resource mt6360_regulator_resources[] =3D =
{
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt=
"),
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt")=
,
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt")=
,
> > > > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_re=
sources[] =3D {
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt")=
,
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt")=
,
> > > > > > -};
> > > > > > -
> > > > > > -static const struct resource mt6360_ldo_resources[] =3D {
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[]=
 =3D {
> > > > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resource=
s,
> > > > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > > > >
> > > > > As discussed with the MFD maintainer [1], the regulator (and prob=
ably all cells)
> > > > > shouldn't have a DT binding.
> > > > >
> > > > > So please send a new version which fixes that.
> > > > >
> > > > > Regards,
> > > > > Matthias
> > > > >
> > > > > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@=
sirena.org.uk/
> > >
> > > I don't think Mark is correct here.
> > >
> > > We usually do implement compatible strings for sub-devices and they d=
o
> > > tend to have their own device nodes.
> > >
> > > It's a very long time ago since I coded this up myself, but from
> > > memory, you can't have 2 devices share a compatible string.
> > >
> >
> > Either Mark or Lee suggestion is work.
> > Is there a conclusion that we can apply it?
> > If MFD is already supported of_compatible, we prefer use of_compatible =
mapping.
>
> I would resubmit the set.  We can start afresh from there.
>

Dear Jones,

    Should I send fixed patch about adding regulator node directly can
make easier for you to re-submit new patch?

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

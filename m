Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920682F7147
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 04:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbhAODz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 22:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbhAODzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 22:55:52 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30998C061575;
        Thu, 14 Jan 2021 19:55:12 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j12so7363044ota.7;
        Thu, 14 Jan 2021 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1pE3SlC44ai1ckIdueI94VlVgFy9zu5zhNWEKBjxuQ=;
        b=Tg1Uvl8gK/EKXgNwP6EqowAB4+ptGN9J8bRToi75GZ9OVHhY+DNTjWDgSnLve60V1W
         p4SBj67qBAcI5V7c1ECEXI9BADrVtA/kqdWUZ8wrmvkZLq80wPK1P9aOcxi9jP+t1o1Y
         KJr9TmA3Emi2eYjvaTNmfYa78wa2J7E/MtSKH1w0D1ZFiY9+trEAB+Lk/sB78j34+U6Q
         QByhUNBgx9QoaEVsdVJXJ9oc7L+Wzpj2rRZf3GGKLUd6e994kaH+aTmFouM/T+5YkMor
         B9vA+ZyssFr4nIV+q9jMInF47uDkXYY8FgOjmCO1Gda/s+Pg2GpJG7kq0nmsH76Du8lk
         AUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1pE3SlC44ai1ckIdueI94VlVgFy9zu5zhNWEKBjxuQ=;
        b=Tg65Etht3bOsVE/Da3JOQpYk0/09e/TZQZMEK6ek8+oFckRW8X02NsmShSOrpKU6FV
         C6FqnJVdlKoD0PRou93UijGp3/StuMDVF/igVl+byxm+BqW6/I2IeVN7F47tDDlhfcyM
         OjLP9g8oozujm28Ssq8BkgBYMC+PuwLMu4M4xkrCHHIXkE4CaLa1xM+H5K0zcId4uJ/R
         8xhCEKPB8J//xxNmHfl7wNZoygR4Gj0Frb/GyThPnEzar7MX5BZQ/27KtnqWd1HxZAxI
         7hxEzypZRRrlHqhDSiG/K3B/tuPu6DwH76DVPabWb7wlZzVOtCw3afJSnXP08uu7tfBc
         8e3A==
X-Gm-Message-State: AOAM530BoLtC4msCNF1bt/55JOfBPWDvARhjAiFrjhFKg2D+TxPw4/qQ
        C6GNqfkqAabeOB31U6S2iFmF5vZk+DENy6RcJSA=
X-Google-Smtp-Source: ABdhPJycmwChvFy+e4H9mlLdITjI5zgt1vFrzcRWChV7FXDg5tJwdGl+uV3O3z94glc+CC6FWc8S3nIDWhJ/O4Ph/I0=
X-Received: by 2002:a05:6830:160f:: with SMTP id g15mr6975275otr.129.1610682911620;
 Thu, 14 Jan 2021 19:55:11 -0800 (PST)
MIME-Version: 1.0
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com> <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
In-Reply-To: <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 15 Jan 2021 11:55:00 +0800
Message-ID: <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     sre@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
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

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=88=
12=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:32=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 12/11/2020 11:39, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > to simplify the similar resources object.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/mt6360-core.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 692e47b..5119e51 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[]=
 =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt=
"),
> >  };
> >
> > -static const struct resource mt6360_pmic_resources[] =3D {
> > +static const struct resource mt6360_regulator_resources[] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[=
] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > -};
> > -
> > -static const struct resource mt6360_ldo_resources[] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] =3D {
> >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
>
> As discussed with the MFD maintainer [1], the regulator (and probably all=
 cells)
> shouldn't have a DT binding.
>
> So please send a new version which fixes that.
>
> Regards,
> Matthias
>
> [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.o=
rg.uk/
>

Should I use parent's device to find sub-devices of_node if without
compatible name?
I trace the function mfd_add_device,

if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
    .....
    ret =3D mfd_match_of_node_to_dev(pdev, np, cell);
    .....
}

which is binding mfd sub-device with compatible. Does it be removed in
the feature?

> >       OF_MFD_CELL("mt6360-tcpc", NULL,
> >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> >  };
> >

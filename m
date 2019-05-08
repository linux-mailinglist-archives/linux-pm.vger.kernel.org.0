Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171BE17168
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEHGXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 02:23:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42800 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEHGXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 02:23:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id f23so17328186otl.9;
        Tue, 07 May 2019 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T+tyGbMaopKmWkanLnS4vwc4EFD/12DJf9lYYTnMcYE=;
        b=JY3mDGTZh8Q1FegBs0pUtECemyuGZ9OJAlygaaiKwl/V3/xj8jvOWla0h5oLDIksI4
         MxypC2FsA2aBkSOCZGCjef3haoNERra1PMiZ7MocJaapFyguEWSLID/HdBjVAXF0R15D
         +iP6EmSUq9Lb9SvynJtNWnK+zXAupVXFm0g4QFbN3ZWJOWD9C/RBL0ZfqzDZstmRZbg5
         KyCGWsCBPyWrk5ilRJS2JJuumrjayjAa9EhZN0nfl/RUCT0OWmWAkjNZ0WnEXHcyiuVL
         BZUOYs+W4AFCpVtXYRprGhWVivnU+86RcXji1C1g+lWGSa+1smE2P20yAMiwmctw50cM
         /U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T+tyGbMaopKmWkanLnS4vwc4EFD/12DJf9lYYTnMcYE=;
        b=rAR1vZTpwDh+3/3lxygWPUyMfEmo9gpiVW0OPlFyeVk6Sv7VeCzhx48goSlebrUdak
         lHKv/woWV58xbzRRIOPo9iIVWWDVRiDRT06QRNz9AGeSGLdwvDy6qCVz/BK9yO55vH9y
         YUtALuyuR/1UgZ364Ku2tL9yUVrvZ1qaX4H0bZ6Y7xnHCUsQztGKvpA4Uco85eR46NsB
         UgPV8rlwlfkANBquthqcI1rd5YiKzBCUpVzQA7NGW1F1zWC8DFcyeb21LG77YcO8VeoL
         XsoDUW21fTUj8eV0tGeFwBMMmfWDmZmSjzr9HVZa8LZbV55CmY9+Xe8ettk4XrWV5hyp
         Rxig==
X-Gm-Message-State: APjAAAWLjdVxgVvlWU1uR5MiC+mRlb5SMoRAlBGc8cI2Jw17olgoSumZ
        0BbLOqISR/RAmq9LFg8qB+ZawvWnur4ccGjkO+w=
X-Google-Smtp-Source: APXvYqyQCWU0DIRe43TcFErDvvvlTRxCFSSpHvwCuXDpeSEuQzaRP5Hm16iwYjtfGjNMWyFfk91jhpBRyKxgqlaXPms=
X-Received: by 2002:a9d:760b:: with SMTP id k11mr8228968otl.135.1557296594435;
 Tue, 07 May 2019 23:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com> <20190418084041.GW28515@bigcity.dyn.berto.se>
In-Reply-To: <20190418084041.GW28515@bigcity.dyn.berto.se>
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date:   Wed, 8 May 2019 15:23:03 +0900
Message-ID: <CAH1o70JBD4j_jpH9_FkkUvHivuUMMvB1Nfgum2MWeySVP=d_pg@mail.gmail.com>
Subject: Re: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of Tj_1
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas-san,

Thanks for your review!

2019=E5=B9=B44=E6=9C=8818=E6=97=A5(=E6=9C=A8) 17:40 Niklas S=C3=B6derlund <=
niklas.soderlund@ragnatech.se>:
>
> Hi Kaneko-san,
>
> Thanks for your work.
>
> On 2019-04-17 02:44:13 +0900, Yoshihiro Kaneko wrote:
> > As evaluation of hardware team, temperature calculation formula
> > of M3-W is difference from all other SoCs as below:
> > - M3-W: Tj_1: 116 (so Tj_1 - Tj_3 =3D 157)
> > - Others: Tj_1: 126 (so Tj_1 - Tj_3 =3D 167)
> >
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++++++++++++++++++++++--=
--------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar=
_gen3_thermal.c
> > index 88fa41c..a2fd0fd 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -124,11 +124,11 @@ static inline void rcar_gen3_thermal_write(struct=
 rcar_gen3_thermal_tsc *tsc,
> >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> >
> >  /* no idea where these constants come from */
> > -#define TJ_1 116
> >  #define TJ_3 -41
> >
> >  static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
> > -                                      int *ptat, int *thcode)
> > +                                      int *ptat, int *thcode,
> > +                                      unsigned int ths_tj_1)
>
> I would move tj_1 inside struce rcar_gen3_thermal_tsc as you in 2/3 move
> tj_2 there. You could still keep the value in .data but init the tj_1 in
> the struct at probe instead of passing it as an argument.

This function is a simple subroutine, is not called back.
Therefore, I think that it is not necessary to move tj_1 into
rcar_gen3_thermal_tsc.

Thanks,
Kaneko

>
> >  {
> >       int tj_2;
> >
> > @@ -139,15 +139,15 @@ static void rcar_gen3_thermal_calc_coefs(struct e=
quation_coefs *coef,
> >        * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
> >        */
> >       tj_2 =3D (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> > -             / (ptat[0] - ptat[2])) - FIXPT_INT(41);
> > +             / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> >
> >       coef->a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> >                            tj_2 - FIXPT_INT(TJ_3));
> >       coef->b1 =3D FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
> >
> >       coef->a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> > -                          tj_2 - FIXPT_INT(TJ_1));
> > -     coef->b2 =3D FIXPT_INT(thcode[0]) - coef->a2 * TJ_1;
> > +                          tj_2 - FIXPT_INT(ths_tj_1));
> > +     coef->b2 =3D FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
> >  }
> >
> >  static int rcar_gen3_thermal_round(int temp)
> > @@ -318,12 +318,29 @@ static void rcar_gen3_thermal_init(struct rcar_ge=
n3_thermal_tsc *tsc)
> >       usleep_range(1000, 2000);
> >  }
> >
> > +static const unsigned int rcar_gen3_ths_tj_1 =3D 126;
> > +static const unsigned int rcar_gen3_ths_tj_1_m3_w =3D 116;
> >  static const struct of_device_id rcar_gen3_thermal_dt_ids[] =3D {
> > -     { .compatible =3D "renesas,r8a774a1-thermal", },
> > -     { .compatible =3D "renesas,r8a7795-thermal", },
> > -     { .compatible =3D "renesas,r8a7796-thermal", },
> > -     { .compatible =3D "renesas,r8a77965-thermal", },
> > -     { .compatible =3D "renesas,r8a77980-thermal", },
> > +     {
> > +             .compatible =3D "renesas,r8a774a1-thermal",
> > +             .data =3D &rcar_gen3_ths_tj_1_m3_w,
> > +     },
> > +     {
> > +             .compatible =3D "renesas,r8a7795-thermal",
> > +             .data =3D &rcar_gen3_ths_tj_1,
> > +     },
> > +     {
> > +             .compatible =3D "renesas,r8a7796-thermal",
> > +             .data =3D &rcar_gen3_ths_tj_1_m3_w,
> > +     },
> > +     {
> > +             .compatible =3D "renesas,r8a77965-thermal",
> > +             .data =3D &rcar_gen3_ths_tj_1,
> > +     },
> > +     {
> > +             .compatible =3D "renesas,r8a77980-thermal",
> > +             .data =3D &rcar_gen3_ths_tj_1,
> > +     },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> > @@ -349,6 +366,7 @@ static int rcar_gen3_thermal_probe(struct platform_=
device *pdev)
> >  {
> >       struct rcar_gen3_thermal_priv *priv;
> >       struct device *dev =3D &pdev->dev;
> > +     const unsigned int *rcar_gen3_ths_tj_1 =3D of_device_get_match_da=
ta(dev);
> >       struct resource *res;
> >       struct thermal_zone_device *zone;
> >       int ret, irq, i;
> > @@ -422,7 +440,8 @@ static int rcar_gen3_thermal_probe(struct platform_=
device *pdev)
> >               priv->tscs[i] =3D tsc;
> >
> >               priv->thermal_init(tsc);
> > -             rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i])=
;
> > +             rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
> > +                                          *rcar_gen3_ths_tj_1);
> >
> >               zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc=
,
> >                                                           &rcar_gen3_tz=
_of_ops);
> > --
> > 1.9.1
> >
>
> --
> Regards,
> Niklas S=C3=B6derlund

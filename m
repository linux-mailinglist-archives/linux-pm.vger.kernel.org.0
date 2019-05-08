Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16E8171BC
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEHGgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 02:36:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37946 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfEHGgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 02:36:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id s19so535933otq.5;
        Tue, 07 May 2019 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ILPuJKMpXz/TGJ/DYJE8UvDmgrstn7HuFsyVscBxQKI=;
        b=vg58rsxfD7QT/9v+ibEUjFSC4lO/J1HR0o9RuN46D/rH6h5o+AWVFWfwey6tERVRqK
         qzidJUHLcyMa+ZRrth3RdKSzIJwva8HJpvPg85B7qjhEC1AVjYIWJaf5wRblNgtDdNbN
         OxiYPcHbkU4BbbeA8ltyn1YQyq0fdBYvCJ8Sb75MjMq+s2ib6/m/xOA/ZtZTTPnRSheQ
         TWdpdZDijQuti1TpAv5QoQ2Flf7Wnp/Xk1sYuebqS92uymgaofS8hd79DTGLZjc5Vp4g
         P1tgQsI2sFxImxVwzNKJTeJBG2G8KOc34Xe/b2/whAKWRRfgUYTjmUNe4TRB/8wfrDQ+
         Xc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ILPuJKMpXz/TGJ/DYJE8UvDmgrstn7HuFsyVscBxQKI=;
        b=qXjgV1xeMYaUkO0ynyPwV5lFCJBGe4cgTgBVY/LQRD8VfMq2QqkTwXdUmf6Yi49JLC
         Q7gXjU7idBQos5/wgVkuM9trx94CATMLwWNw0haZianUftJLQ7ykZUq5sOcgGnchA8UV
         R8VVu5lZMjcOIcpJ/cIDuGZpyJt5T+nRA5bsAlhzwZDYsvhPyKoTaRiWp+7EzE+B3djB
         YE+aogoC1bajKn7nkHHY5VA1bVrj7JaHN3oQFRQtppmZkouA8hA0SxPpl8d7wp3M/fxY
         zekAQFquYi9Hvs3WX3hciwsMI+8qN/MPcH14VjBQuJq9KCP7vQ7CnigcQfAc2d0BSNvl
         xjOQ==
X-Gm-Message-State: APjAAAUOSRPZQLPxEav7Ozk25fC2ByEYaisVMtrbkUzJ6FLvHTr2I6Uo
        +4UPOtiFuRQSbbo3KM1rSYHuCPxuUXCa4SY6hVs=
X-Google-Smtp-Source: APXvYqwn9YSQzZtyDIXdJHxE8L14ytklZxVHuRaMizk4VYOAQ6RMvWUrBJ5P6UO58k9kYjJMQtihpRiQS463wlJBck8=
X-Received: by 2002:a9d:6209:: with SMTP id g9mr4584183otj.153.1557297407525;
 Tue, 07 May 2019 23:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com> <20190424145436.camftb32c7v2ya2f@verge.net.au>
In-Reply-To: <20190424145436.camftb32c7v2ya2f@verge.net.au>
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date:   Wed, 8 May 2019 15:36:36 +0900
Message-ID: <CAH1o70LX97ir=T1R5SjBnsTQmnbUdN8LadByTH_-4eRgp27PzQ@mail.gmail.com>
Subject: Re: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of Tj_1
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Simon-san,

Thanks for testing this patch!

2019=E5=B9=B44=E6=9C=8824=E6=97=A5(=E6=B0=B4) 23:54 Simon Horman <horms@ver=
ge.net.au>:
>
> Hi Kaneko-san,
>
> On Wed, Apr 17, 2019 at 02:44:13AM +0900, Yoshihiro Kaneko wrote:
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
> While testing I found that the type of ths_tj_1 needs to be int
> rather than unsigned int, in order for the FIXPT logic to work correctly.
>
> And with that change in place the entire series appears to work correctly=
.
>
> My suggestion is to change the types of ths_tj_1 here, rcar_gen3_ths_tj_1
> in rcar_gen3_thermal_probe(), and rcar_gen3_ths_tj_1 and
> rcar_gen3_ths_tj_1_m3_w, which are gloabl to this file accordingly.

I understood. Why did I decide to use unsigned?
I will fix it in v3.

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

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8014E1C33F9
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEDIEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgEDIEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:04:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E621C061A0E;
        Mon,  4 May 2020 01:04:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id f12so12701188edn.12;
        Mon, 04 May 2020 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0Wo6vmSbri8U9kC6pe1XiL0TL6H2jlma6FaWSj8O4Q=;
        b=LZskB9FqybWHb+eV93vXm28XWtfwXMtiwZL/1+z7s0ZmjZj0OBTtcNcGgv2V43ROGz
         HkJQOX4aziHF1Su2R82dyPPxgOtqbNgsDx7UD0s8Q8CGhDOKiQ6q5zCfPlPaSj48VBiX
         yGqSHEb6IiZN3xWBKmVoxdl0aosgJwMc2hejsp5RCaux5fveeasQPH7SFcyFWPSSf5Bo
         AMJJopIjghVtTKr+/+cocb5WtwMIqbP+XYS3kXXtnQooTTsef/pLUYYA9zSLWY0wcQpv
         fBcD+DL/wa5vZfiNdMj/km/1qACzdE/CSvJxBInlzn5DaZoCCmNpPEHL+XPzTDKE+aBo
         Ot9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0Wo6vmSbri8U9kC6pe1XiL0TL6H2jlma6FaWSj8O4Q=;
        b=qmYQ6TTpbtizPSh7iQ/s4YBkVTSzjmOULd6+7g55VKtov+qJ7NgSAidc6PiDFbD1x6
         K9YXqjDhux0NLadJIM/nXF3GA1xNmsVGnibB5LDoGEtHitF9FkRN0Zqwlp/jNJqhrmxp
         SIRcxEsC3IM/HwahhMzKR3U5FDhGCh0Q1rwe5sc6uEX0AOWYh7wQyz6u7GMGXhy9ruJ9
         hHT1dBjbwet1FduZfFbVG+Q49AmvphVBeGt6b/AWWe039nUEFXhUoQ0FcdnxQMk49HDo
         Wmm8yFDLn6kNBCc7x39EOBpgaiFU/AEMcdQs7aTW3bLHzOL86fwlZWljf59JxQCxXDIL
         0RMA==
X-Gm-Message-State: AGi0PuYFDSWGEbysGzVMsSytSyLVTUYDLi1c2otC4XA5rifo4EqFfVi/
        Pk/Tgo/6rayavakvSA7UEDR9wpGBl51ihplVFos=
X-Google-Smtp-Source: APiQypLvGhp/jZH8bUH+mkNOvXgUOAEl58T3yRSgCIF8JZ+gAN+WuBYFDHc6KIliNvqUdWYZvAqWvATFJGsgc5LmUuE=
X-Received: by 2002:aa7:dcc3:: with SMTP id w3mr12803208edu.231.1588579491120;
 Mon, 04 May 2020 01:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200501203311.143934-1-konradybcio@gmail.com>
 <20200501203311.143934-2-konradybcio@gmail.com> <CAP245DUOcsort1B1ftWW251Bzxp8=SuaGdZuZBmUubO9tw78cw@mail.gmail.com>
In-Reply-To: <CAP245DUOcsort1B1ftWW251Bzxp8=SuaGdZuZBmUubO9tw78cw@mail.gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Mon, 4 May 2020 10:04:14 +0200
Message-ID: <CAMS8qEXAPTcCYTKSA1VYnHtqT1zuUdYNNskRfgPiFykdKdqsKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your review. I'll hopefully send a v2 later today.

As for the sensor count, I don't know how many there actually are. I'm
an independent dev and don't have access to any documentation and I'm
solely basing on what I find in downstream, and I think it's 10,
unless mainline expects the _0_4 and _5 to be counted separately.. [1]

I will also make sure to test it again before sending and will give
you the results in the v2 cover letter.

[1] https://github.com/konradybcio/android_kernel_asus_msm8916-1/blob/minim=
al/drivers/thermal/msm8974-tsens.c#L396


pon., 4 maj 2020 o 08:31 Amit Kucheria <amit.kucheria@linaro.org> napisa=C5=
=82(a):
>
> On Sat, May 2, 2020 at 2:03 AM Konrad Dybcio <konradybcio@gmail.com> wrot=
e:
> >
> > Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens-v0_1.c | 142 +++++++++++++++++++++++++++++-
> >  drivers/thermal/qcom/tsens.c      |   3 +
> >  drivers/thermal/qcom/tsens.h      |   2 +-
> >  3 files changed, 145 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/t=
sens-v0_1.c
> > index 959a9371d205c..29b95886273b7 100644
> > --- a/drivers/thermal/qcom/tsens-v0_1.c
> > +++ b/drivers/thermal/qcom/tsens-v0_1.c
> > @@ -48,6 +48,64 @@
> >  #define MSM8916_CAL_SEL_MASK   0xe0000000
> >  #define MSM8916_CAL_SEL_SHIFT  29
> >
> > +/* eeprom layout data for 8939 */
> > +#define MSM8939_BASE0_MASK           0x000000ff
> > +#define MSM8939_BASE1_MASK           0xff000000
> > +#define MSM8939_BASE0_SHIFT
>
> Use 0?
>
> > +#define MSM8939_BASE1_SHIFT          24
> > +
> > +#define MSM8939_S0_P1_MASK         0x000001f8
> > +#define MSM8939_S1_P1_MASK         0x001f8000
> > +#define MSM8939_S2_P1_MASK_0_4     0xf8000000
> > +#define MSM8939_S2_P1_MASK_5       0x00000001
> > +#define MSM8939_S3_P1_MASK         0x00001f80
> > +#define MSM8939_S4_P1_MASK         0x01f80000
> > +#define MSM8939_S5_P1_MASK         0x00003f00
> > +#define MSM8939_S6_P1_MASK         0x03f00000
> > +#define MSM8939_S7_P1_MASK         0x0000003f
> > +#define MSM8939_S8_P1_MASK         0x0003f000
> > +#define MSM8939_S9_P1_MASK         0x07e00000
> > +
> > +#define MSM8939_S0_P2_MASK         0x00007e00
> > +#define MSM8939_S1_P2_MASK         0x07e00000
> > +#define MSM8939_S2_P2_MASK         0x0000007e
> > +#define MSM8939_S3_P2_MASK         0x0007e000
> > +#define MSM8939_S4_P2_MASK         0x7e000000
> > +#define MSM8939_S5_P2_MASK         0x000fc000
> > +#define MSM8939_S6_P2_MASK         0xfc000000
> > +#define MSM8939_S7_P2_MASK         0x00000fc0
> > +#define MSM8939_S8_P2_MASK         0x00fc0000
> > +#define MSM8939_S9_P2_MASK_0_4     0xf8000000
> > +#define MSM8939_S9_P2_MASK_5       0x00002000
> > +
> > +#define MSM8939_CAL_SEL_MASK   0xc0000000
> > +#define MSM8939_CAL_SEL_SHIFT  0
> > +
> > +
>
> Get rid of extra line.
>
> > +#define MSM8939_S0_P1_SHIFT        3
> > +#define MSM8939_S1_P1_SHIFT        15
> > +#define MSM8939_S2_P1_SHIFT_0_4    27
> > +#define MSM8939_S2_P1_SHIFT_5      5
> > +#define MSM8939_S3_P1_SHIFT        7
> > +#define MSM8939_S4_P1_SHIFT        19
> > +#define MSM8939_S5_P1_SHIFT        8
> > +#define MSM8939_S6_P1_SHIFT        20
> > +//yes, 7 is missing in downstream
>
> Use C style comments.
>
> > +#define MSM8939_S8_P1_SHIFT        12
> > +#define MSM8939_S9_P1_SHIFT        21
> > +
> > +#define MSM8939_S0_P2_SHIFT        9
> > +#define MSM8939_S1_P2_SHIFT        21
> > +#define MSM8939_S2_P2_SHIFT        1
> > +#define MSM8939_S3_P2_SHIFT        13
> > +#define MSM8939_S4_P2_SHIFT        25
> > +#define MSM8939_S5_P2_SHIFT        14
> > +#define MSM8939_S6_P2_SHIFT        26
> > +#define MSM8939_S7_P2_SHIFT        6
> > +#define MSM8939_S8_P2_SHIFT        18
> > +#define MSM8939_S9_P2_SHIFT_0_4    27
> > +#define MSM8939_S9_P2_SHIFT_5      8
> > +
> >  /* eeprom layout data for 8974 */
> >  #define BASE1_MASK             0xff
> >  #define S0_P1_MASK             0x3f00
> > @@ -189,6 +247,73 @@ static int calibrate_8916(struct tsens_priv *priv)
> >         return 0;
> >  }
> >
> > +static int calibrate_8939(struct tsens_priv *priv)
> > +{
> > +       int base0 =3D 0, base1 =3D 0, i;
> > +       u32 p1[11], p2[11];
> > +       int mode =3D 0;
> > +       u32 *qfprom_cdata, *qfprom_csel;
> > +
> > +       qfprom_cdata =3D (u32 *)qfprom_read(priv->dev, "calib");
> > +       if (IS_ERR(qfprom_cdata))
> > +               return PTR_ERR(qfprom_cdata);
> > +
> > +       qfprom_csel =3D (u32 *)qfprom_read(priv->dev, "calib_sel");
> > +       if (IS_ERR(qfprom_csel)) {
> > +               kfree(qfprom_cdata);
> > +               return PTR_ERR(qfprom_csel);
> > +       }
> > +
> > +       mode =3D (qfprom_csel[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL=
_SEL_SHIFT;
> > +       dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>
> Add an extra line here.
>
> > +       switch (mode) {
> > +       case TWO_PT_CALIB:
> > +               base1 =3D (qfprom_cdata[1] & MSM8939_BASE1_MASK) >> MSM=
8939_BASE1_SHIFT;
> > +               p2[0] =3D (qfprom_cdata[0] & MSM8939_S0_P2_MASK) >> MSM=
8939_S0_P2_SHIFT;
> > +               p2[1] =3D (qfprom_cdata[0] & MSM8939_S1_P2_MASK) >> MSM=
8939_S1_P2_SHIFT;
> > +               p2[2] =3D (qfprom_cdata[1] & MSM8939_S2_P2_MASK) >> MSM=
8939_S2_P2_SHIFT;
> > +               p2[3] =3D (qfprom_cdata[1] & MSM8939_S3_P2_MASK) >> MSM=
8939_S3_P2_SHIFT;
> > +               p2[4] =3D (qfprom_cdata[1] & MSM8939_S4_P2_MASK) >> MSM=
8939_S4_P2_SHIFT;
> > +               p2[5] =3D (qfprom_cdata[1] & MSM8939_S5_P2_MASK) >> MSM=
8939_S5_P2_SHIFT;
> > +               p2[6] =3D (qfprom_cdata[1] & MSM8939_S6_P2_MASK) >> MSM=
8939_S6_P2_SHIFT;
> > +               p2[7] =3D (qfprom_cdata[1] & MSM8939_S7_P2_MASK) >> MSM=
8939_S7_P2_SHIFT;
> > +               p2[8] =3D (qfprom_cdata[1] & MSM8939_S8_P2_MASK) >> MSM=
8939_S8_P2_SHIFT;
> > +               p2[9] =3D (qfprom_cdata[1] & MSM8939_S9_P2_MASK_0_4) >>=
 MSM8939_S9_P2_SHIFT_0_4;
> > +               p2[10] =3D (qfprom_cdata[1] & MSM8939_S9_P2_MASK_5) >> =
MSM8939_S9_P2_SHIFT_5;
> > +               for (i =3D 0; i < priv->num_sensors; i++)
> > +                       p2[i] =3D ((base1 + p2[i]) << 3);
> > +               /* Fall through */
> > +       case ONE_PT_CALIB2:
> > +               base0 =3D (qfprom_cdata[0] & MSM8939_BASE0_MASK);
> > +               p1[0] =3D (qfprom_cdata[0] & MSM8939_S0_P1_MASK) >> MSM=
8939_S0_P1_SHIFT;
> > +               p1[1] =3D (qfprom_cdata[0] & MSM8939_S1_P1_MASK) >> MSM=
8939_S1_P1_SHIFT;
> > +               p1[2] =3D (qfprom_cdata[0] & MSM8939_S2_P1_MASK_0_4) >>=
 MSM8939_S2_P1_SHIFT_0_4;
> > +               p1[3] =3D (qfprom_cdata[0] & MSM8939_S2_P1_MASK_5) >> M=
SM8939_S2_P1_SHIFT_5;
> > +               p1[4] =3D (qfprom_cdata[1] & MSM8939_S3_P1_MASK) >> MSM=
8939_S3_P1_SHIFT;
> > +               p1[5] =3D (qfprom_cdata[1] & MSM8939_S4_P1_MASK) >> MSM=
8939_S4_P1_SHIFT;
> > +               p1[6] =3D (qfprom_cdata[1] & MSM8939_S5_P1_MASK) >> MSM=
8939_S5_P1_SHIFT;
> > +               p1[7] =3D (qfprom_cdata[1] & MSM8939_S6_P1_MASK) >> MSM=
8939_S6_P1_SHIFT;
> > +               //yes, 7 is missing in downstream
>
> Use C comment style. Might this be a bug?
>
> > +               p1[8] =3D (qfprom_cdata[1] & MSM8939_S8_P1_MASK) >> MSM=
8939_S8_P1_SHIFT;
> > +               p1[9] =3D (qfprom_cdata[1] & MSM8939_S9_P1_MASK) >> MSM=
8939_S9_P1_SHIFT;
> > +               for (i =3D 0; i < priv->num_sensors; i++)
> > +                       p1[i] =3D (((base0) + p1[i]) << 3);
> > +               break;
> > +       default:
> > +               for (i =3D 0; i < priv->num_sensors; i++) {
> > +                       p1[i] =3D 500;
> > +                       p2[i] =3D 780;
> > +               }
> > +               break;
> > +       }
> > +
> > +       compute_intercept_slope(priv, p1, p2, mode);
> > +       kfree(qfprom_cdata);
> > +       kfree(qfprom_csel);
> > +
> > +       return 0;
> > +}
> > +
> >  static int calibrate_8974(struct tsens_priv *priv)
> >  {
> >         int base1 =3D 0, base2 =3D 0, i;
> > @@ -325,7 +450,7 @@ static int calibrate_8974(struct tsens_priv *priv)
> >         return 0;
> >  }
> >
> > -/* v0.1: 8916, 8974 */
> > +/* v0.1: 8916, 8939, 8974 */
> >
> >  static struct tsens_features tsens_v0_1_feat =3D {
> >         .ver_major      =3D VER_0_1,
> > @@ -386,6 +511,21 @@ struct tsens_plat_data data_8916 =3D {
> >         .fields =3D tsens_v0_1_regfields,
> >  };
> >
> > +static const struct tsens_ops ops_8939 =3D {
> > +       .init           =3D init_common,
> > +       .calibrate      =3D calibrate_8939,
> > +       .get_temp       =3D get_temp_common,
> > +};
> > +
> > +struct tsens_plat_data data_8939 =3D {
> > +       .num_sensors    =3D 10,
>
> I think 8939 has 11 sensors. Can you confirm?
>
> > +       .ops            =3D &ops_8939,
> > +       .hw_ids         =3D (unsigned int []){0, 1, 2, 4, 5, 6, 7, 8, 9=
 },
>
> And this should be equal to the number of sensors
>
>
> > +
> > +       .feat           =3D &tsens_v0_1_feat,
> > +       .fields =3D tsens_v0_1_regfields,
> > +};
> > +
> >  static const struct tsens_ops ops_8974 =3D {
> >         .init           =3D init_common,
> >         .calibrate      =3D calibrate_8974,
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.=
c
> > index 2f77d235cf735..f654057e96ae1 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -59,6 +59,9 @@ static const struct of_device_id tsens_table[] =3D {
> >         {
> >                 .compatible =3D "qcom,msm8916-tsens",
> >                 .data =3D &data_8916,
> > +       }, {
> > +               .compatible =3D "qcom,msm8939-tsens",
> > +               .data =3D &data_8939,
> >         }, {
> >                 .compatible =3D "qcom,msm8974-tsens",
> >                 .data =3D &data_8974,
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.=
h
> > index 502acf0e68285..403b15546f648 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -590,7 +590,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void=
 *data);
> >  extern struct tsens_plat_data data_8960;
> >
> >  /* TSENS v0.1 targets */
> > -extern struct tsens_plat_data data_8916, data_8974;
> > +extern struct tsens_plat_data data_8916, data_8939, data_8974;
> >
> >  /* TSENS v1 targets */
> >  extern struct tsens_plat_data data_tsens_v1, data_8976;
> > --
> > 2.26.1
> >

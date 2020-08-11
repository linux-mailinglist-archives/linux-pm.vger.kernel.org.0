Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9528D241B7F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHKNSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgHKNSb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 09:18:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108BC06174A;
        Tue, 11 Aug 2020 06:18:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so9047651edy.0;
        Tue, 11 Aug 2020 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=W5iOejFeyAzx27jgA2oOvpFrXtNAFhaALxxI5F1Hsgw=;
        b=AwA10PQpaDwcE9nvZ9RiDgi32a6h8O0rF083wvAGv5ujUa1eEp1+HbtXxXdjIJUnoE
         TBgN8H2FVSu2ydLCUSZBhvL+54JONG3dxIpApq97p8ZbUM9Lx9akg/rrHJ6c/rvb0pbp
         oYbvIAwAiZCfuAU7fzth5aCD/yZbec+VB9gUKZQwoVEmA/EvTd7sJGC9BC0AgtasY8RE
         HnORFFqJ+Bc7XnpgNJbG02GShl3Ly1dYVThtd+xxfogGfcuzc0BatwqEjlJ6WxIHeLyD
         dukTZnpJIJB+Jg8A70Vd+/HQrattbbmIJI1053IRotYNW2jFwBq7NuQvNtv5LNeY71gp
         YNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=W5iOejFeyAzx27jgA2oOvpFrXtNAFhaALxxI5F1Hsgw=;
        b=jODGD71RdpGkJn3+/Dr5ngOvuZbxtyrzFMmC7ebxIMQbv6eRg3UaZGlL3mbZ8f0HrR
         s8i96P2FR11xB5d5ihwP9FzjhYAiELNu+mH+A0T5A7pm+4GF+/3t5RQOp8q05KukJfFA
         2J9u6of54lgDBUO+Q1ePn+RiN9HOi9BIbwai2FQ3aXpcQIy93Q5lGK1bmyzakH7LNGTU
         C0XJ6kPO010gnLrtW3Opz5CKnaQ/KU0D0mWX7kPZa4IzdYz8GaetZM6m/hVBpyr8GMTH
         L9C3DhH/psCq0K0yDWP5ZewGYjrz5FLdZXVLFOB2H3wX0kHf1q7xaSaRUNpST5Y+KoAy
         p3Qw==
X-Gm-Message-State: AOAM530xuUDtepCJyOSOBdarsnyLz8jXlyvvYO3wDG2sBZKVUaw/4kfj
        DAfABAZgsg9cjtIbDBTArNE=
X-Google-Smtp-Source: ABdhPJxIAbQcDsVwkE1KpIP6RQ4dxSBImHxMcqU7LHOEj1m4v8YTxIBmUFXEH6LcuarZyJ+U/69dyA==
X-Received: by 2002:aa7:c88f:: with SMTP id p15mr26407024eds.33.1597151909815;
        Tue, 11 Aug 2020 06:18:29 -0700 (PDT)
Received: from AnsuelXPS (host-79-13-255-165.retail.telecomitalia.it. [79.13.255.165])
        by smtp.gmail.com with ESMTPSA id j7sm15002436ejb.64.2020.08.11.06.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 06:18:29 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Amit Kucheria'" <amit.kucheria@linaro.org>
Cc:     "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Linux PM list'" <linux-pm@vger.kernel.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <20200725181404.18951-1-ansuelsmth@gmail.com> <20200725181404.18951-2-ansuelsmth@gmail.com> <CAHLCerMc8yUjh9qwUCa=jMZHs18GC4qeS3rqT1_6K90QJd=nVA@mail.gmail.com>
In-Reply-To: <CAHLCerMc8yUjh9qwUCa=jMZHs18GC4qeS3rqT1_6K90QJd=nVA@mail.gmail.com>
Subject: R: [RFC PATCH v5 1/7] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Tue, 11 Aug 2020 15:18:26 +0200
Message-ID: <006f01d66fe1$e6c0d450$b4427cf0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIHwNE3nie9dhNXaD2KJaeS4Nq0bgGUtuftAgyN+QSoszW24A==
Content-Language: it
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: Amit Kucheria <amit.kucheria@linaro.org>
> Inviato: marted=C3=AC 11 agosto 2020 14:58
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Andy Gross <agross@kernel.org>; Bjorn Andersson
> <bjorn.andersson@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Rob Herring <robh+dt@kernel.org>;
> Linux PM list <linux-pm@vger.kernel.org>; linux-arm-msm <linux-arm-
> msm@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS <devicetree@vger.kernel.org>; LKML <linux-
> kernel@vger.kernel.org>
> Oggetto: Re: [RFC PATCH v5 1/7] drivers: thermal: tsens: Add VER_0 =
tsens
> version
>=20
> On Sat, Jul 25, 2020 at 11:44 PM Ansuel Smith <ansuelsmth@gmail.com>
> wrote:
> >
> > VER_0 is used to describe device based on tsens version before v0.1.
> > These device are devices based on msm8960 for example apq8064 or
> > ipq806x.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 160 +++++++++++++++++++++++++++--
> ------
> >  drivers/thermal/qcom/tsens.h |   7 +-
> >  2 files changed, 132 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c =
b/drivers/thermal/qcom/tsens.c
> > index 9fe9a2b26705..78840c1bc5d2 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -516,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, =
void
> *data)
> >                         dev_dbg(priv->dev, "[%u] %s: no violation:  =
%d\n",
> >                                 hw_id, __func__, temp);
> >                 }
> > +
> > +               if (tsens_version(priv) < VER_0_1) {
> > +                       /* Constraint: There is only 1 interrupt =
control register for
> all
> > +                        * 11 temperature sensor. So monitoring more =
than 1
> sensor based
> > +                        * on interrupts will yield inconsistent =
result. To overcome
> this
> > +                        * issue we will monitor only sensor 0 which =
is the master
> sensor.
> > +                        */
> > +                       break;
> > +               }
> >         }
> >
> >         return IRQ_HANDLED;
> > @@ -531,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int =
low,
> int high)
> >         int high_val, low_val, cl_high, cl_low;
> >         u32 hw_id =3D s->hw_id;
> >
> > +       if (tsens_version(priv) < VER_0_1) {
> > +               /* Pre v0.1 IP had a single register for each type =
of interrupt
> > +                * and thresholds
> > +                */
> > +               hw_id =3D 0;
> > +       }
> > +
> >         dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
> >                 hw_id, __func__, low, high);
> >
> > @@ -550,6 +566,12 @@ static int tsens_set_trips(void *_sensor, int =
low,
> int high)
> >         tsens_set_interrupt(priv, hw_id, LOWER, true);
> >         tsens_set_interrupt(priv, hw_id, UPPER, true);
> >
> > +       /* VER_0 require to set MIN and MAX THRESH */
> > +       if (tsens_version(priv) < VER_0_1) {
> > +               regmap_field_write(priv->rf[MIN_THRESH_0], 0);
> > +               regmap_field_write(priv->rf[MAX_THRESH_0], 120000);
>=20
> Since MIN_THRESH_0 and MAX_THRESH_0 are the only two threshold on
> pre
> 0.1 IP, just (mis)use the already predefined LOW_THRESH_0 and
> UP_THRESH_0 in regfield_ids in init_common() below? Then we won't need
> this special casing here. All the special casing ugliness can then
> stay in init_common() with comments.
>=20
> > +       }
> > +
> >         spin_unlock_irqrestore(&priv->ul_lock, flags);
> >
> >         dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> > @@ -584,18 +606,21 @@ int get_temp_tsens_valid(const struct
> tsens_sensor *s, int *temp)
> >         u32 valid;
> >         int ret;
> >
> > -       ret =3D regmap_field_read(priv->rf[valid_idx], &valid);
> > -       if (ret)
> > -               return ret;
> > -       while (!valid) {
> > -               /* Valid bit is 0 for 6 AHB clock cycles.
> > -                * At 19.2MHz, 1 AHB clock is ~60ns.
> > -                * We should enter this loop very, very rarely.
> > -                */
> > -               ndelay(400);
> > +       /* VER_0 doesn't have VALID bit */
> > +       if (tsens_version(priv) >=3D VER_0_1) {
>=20
> Since 8960 needs a custom get_temp function, is this change really
> needed?
>=20

The get_temp_tsens_valid function is used to setup interrupt, think this =
is
the best way instead of add an if and call get_temp in the setup =
interrupt
function (instead of using get_temp_valid)

> >                 ret =3D regmap_field_read(priv->rf[valid_idx], =
&valid);
> >                 if (ret)
> >                         return ret;
> > +               while (!valid) {
> > +                       /* Valid bit is 0 for 6 AHB clock cycles.
> > +                        * At 19.2MHz, 1 AHB clock is ~60ns.
> > +                        * We should enter this loop very, very =
rarely.
> > +                        */
> > +                       ndelay(400);
> > +                       ret =3D =
regmap_field_read(priv->rf[valid_idx], &valid);
> > +                       if (ret)
> > +                               return ret;
> > +               }
> >         }
> >
> >         /* Valid bit is set, OK to read the temperature */
> > @@ -765,8 +790,8 @@ int __init init_common(struct tsens_priv *priv)
> >
> >         if (tsens_version(priv) > VER_0_1) {
> >                 for (i =3D VER_MAJOR; i <=3D VER_STEP; i++) {
> > -                       priv->rf[i] =3D devm_regmap_field_alloc(dev, =
priv->srot_map,
> > -                                                             =
priv->fields[i]);
> > +                       priv->rf[i] =3D devm_regmap_field_alloc(
> > +                               dev, priv->srot_map, =
priv->fields[i]);
>=20
> This doesn't change any code, simply reformats the code to 80 columns.
> Avoid adding such lines to other features, makes it harder to review
> changes.
>=20
> Please ignore the 80 column warning here and elsewhere below when it
> is only going over by a few characters. Run checkpatch on your patches
> which has now increased the number of columns to 100 now.
>=20
>=20
> >                         if (IS_ERR(priv->rf[i]))
> >                                 return PTR_ERR(priv->rf[i]);
> >                 }
> > @@ -775,12 +800,80 @@ int __init init_common(struct tsens_priv
> *priv)
> >                         goto err_put_device;
> >         }
> >
> > -       priv->rf[TSENS_EN] =3D devm_regmap_field_alloc(dev, =
priv->srot_map,
> > -                                                    =
priv->fields[TSENS_EN]);
> > -       if (IS_ERR(priv->rf[TSENS_EN])) {
> > -               ret =3D PTR_ERR(priv->rf[TSENS_EN]);
> > -               goto err_put_device;
> > +       if (tsens_version(priv) >=3D VER_0_1) {
> > +               priv->rf[TSENS_EN] =3D devm_regmap_field_alloc(
> > +                       dev, priv->srot_map, =
priv->fields[TSENS_EN]);
> > +               if (IS_ERR(priv->rf[TSENS_EN])) {
> > +                       ret =3D PTR_ERR(priv->rf[TSENS_EN]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[SENSOR_EN] =3D devm_regmap_field_alloc(
> > +                       dev, priv->srot_map, =
priv->fields[SENSOR_EN]);
> > +               if (IS_ERR(priv->rf[SENSOR_EN])) {
> > +                       ret =3D PTR_ERR(priv->rf[SENSOR_EN]);
> > +                       goto err_put_device;
> > +               }
> > +               priv->rf[INT_EN] =3D devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, priv->fields[INT_EN]);
> > +               if (IS_ERR(priv->rf[INT_EN])) {
> > +                       ret =3D PTR_ERR(priv->rf[INT_EN]);
> > +                       goto err_put_device;
> > +               }
> > +       } else {
>=20
> Let's not create two big sections with if-else for 8960 and everything
> else. For example, what is wrong with using common code for TSENS_EN?
>=20
> If the concern is memory wasted trying to allocate fields not present
> on this older platform, perhaps consider adding a check in the loop to
> break early in case of 8960?
>=20

About TSENS_EN the old platform doesn't have SROT so I need to use =
TM_MAP.
Should I set the srot map to match the tm map so we can use the common =
function?
Aside from this problem, I will try to remove the big if-else.

> > +               priv->rf[TSENS_EN] =3D devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, priv->fields[TSENS_EN]);
> > +               if (IS_ERR(priv->rf[TSENS_EN])) {
> > +                       ret =3D PTR_ERR(priv->rf[TSENS_EN]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[TSENS_SW_RST] =3D devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, priv->fields[TSENS_EN]);
> > +               if (IS_ERR(priv->rf[TSENS_EN])) {
> > +                       ret =3D PTR_ERR(priv->rf[TSENS_EN]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               /* enable TSENS */
> > +               regmap_field_write(priv->rf[TSENS_EN], 1);
> > +
> > +               priv->rf[LOW_INT_CLEAR_0] =3D =
devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, =
priv->fields[LOW_INT_CLEAR_0]);
> > +               if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
> > +                       ret =3D PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[UP_INT_CLEAR_0] =3D =
devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, =
priv->fields[UP_INT_CLEAR_0]);
> > +               if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
> > +                       ret =3D PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[MIN_THRESH_0] =3D devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, =
priv->fields[MIN_THRESH_0]);
> > +               if (IS_ERR(priv->rf[MIN_THRESH_0])) {
> > +                       ret =3D PTR_ERR(priv->rf[MIN_THRESH_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[MAX_THRESH_0] =3D devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, =
priv->fields[MAX_THRESH_0]);
> > +               if (IS_ERR(priv->rf[MAX_THRESH_0])) {
> > +                       ret =3D PTR_ERR(priv->rf[MAX_THRESH_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[TRDY] =3D devm_regmap_field_alloc(dev, =
priv->tm_map,
> > +                                                        =
priv->fields[TRDY]);
> > +               if (IS_ERR(priv->rf[TRDY])) {
> > +                       ret =3D PTR_ERR(priv->rf[TRDY]);
> > +                       goto err_put_device;
> > +               }
> >         }
> > +
> >         ret =3D regmap_field_read(priv->rf[TSENS_EN], &enabled);
> >         if (ret)
> >                 goto err_put_device;
> > @@ -790,19 +883,6 @@ int __init init_common(struct tsens_priv *priv)
> >                 goto err_put_device;
> >         }
> >
> > -       priv->rf[SENSOR_EN] =3D devm_regmap_field_alloc(dev, priv-
> >srot_map,
> > -                                                     =
priv->fields[SENSOR_EN]);
> > -       if (IS_ERR(priv->rf[SENSOR_EN])) {
> > -               ret =3D PTR_ERR(priv->rf[SENSOR_EN]);
> > -               goto err_put_device;
> > -       }
> > -       priv->rf[INT_EN] =3D devm_regmap_field_alloc(dev, =
priv->tm_map,
> > -                                                  =
priv->fields[INT_EN]);
> > -       if (IS_ERR(priv->rf[INT_EN])) {
> > -               ret =3D PTR_ERR(priv->rf[INT_EN]);
> > -               goto err_put_device;
> > -       }
> > -
> >         /* This loop might need changes if enum regfield_ids is =
reordered */
> >         for (j =3D LAST_TEMP_0; j <=3D UP_THRESH_15; j +=3D 16) {
> >                 for (i =3D 0; i < priv->feat->max_sensors; i++) {
> > @@ -856,7 +936,11 @@ int __init init_common(struct tsens_priv *priv)
> >         }
> >
> >         spin_lock_init(&priv->ul_lock);
> > -       tsens_enable_irq(priv);
> > +
> > +       /* VER_0 interrupt doesn't need to be enabled */
> > +       if (tsens_version(priv) >=3D VER_0_1)
> > +               tsens_enable_irq(priv);
> > +
> >         tsens_debug_init(op);
> >
> >  err_put_device:
> > @@ -952,10 +1036,18 @@ static int tsens_register_irq(struct =
tsens_priv
> *priv, char *irqname,
> >                 if (irq =3D=3D -ENXIO)
> >                         ret =3D 0;
> >         } else {
> > -               ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > -                                               NULL, thread_fn,
> > -                                               IRQF_ONESHOT,
> > -                                               =
dev_name(&pdev->dev), priv);
> > +               /* VER_0 have a different interrupt type */
>=20
> Say how it is different.
>=20
>=20
> > +               if (tsens_version(priv) > VER_0)
> > +                       ret =3D =
devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +                                                       thread_fn, =
IRQF_ONESHOT,
> > +                                                       =
dev_name(&pdev->dev),
> > +                                                       priv);
> > +               else
> > +                       ret =3D =
devm_request_threaded_irq(&pdev->dev, irq,
> > +                                                       thread_fn, =
NULL,
> > +                                                       =
IRQF_TRIGGER_RISING,
> > +                                                       =
dev_name(&pdev->dev),
> > +                                                       priv);
> >                 if (ret)
> >                         dev_err(&pdev->dev, "%s: failed to get =
irq\n",
> >                                 __func__);
> > diff --git a/drivers/thermal/qcom/tsens.h
> b/drivers/thermal/qcom/tsens.h
> > index 59d01162c66a..f1120791737c 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -25,7 +25,8 @@ struct tsens_priv;
> >
> >  /* IP version numbers in ascending order */
> >  enum tsens_ver {
> > -       VER_0_1 =3D 0,
> > +       VER_0 =3D 0,
> > +       VER_0_1,
> >         VER_1_X,
> >         VER_2_X,
> >  };
> > @@ -441,6 +442,10 @@ enum regfield_ids {
> >         CRIT_THRESH_14,
> >         CRIT_THRESH_15,
> >
> > +       /* VER_0 MIN MAX THRESH */
> > +       MIN_THRESH_0,
> > +       MAX_THRESH_0,
> > +
> >         /* WATCHDOG */
> >         WDOG_BARK_STATUS,
> >         WDOG_BARK_CLEAR,
> > --
> > 2.27.0
> >


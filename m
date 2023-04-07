Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C516DAA5E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDGIqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjDGIqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 04:46:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F98A5B
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 01:46:06 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id i3so1722074uag.12
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680857166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YieoR9GFXBDpW/S/rPrqFewasba9YLxVMGUvduFkZVA=;
        b=gM5FWyyuaDU8IMah6LdVlCrfJr+DR2GXlJvbSlGJUaoRKyPLg8kLBmt1akuM21vwVf
         c1rOXa6jiZ2SZtSDhsCUZ0zU8Y1zl4BpYCvGwFmD2TMZR+ZNxr7rtlh3kSlfA6ptRT5y
         xqtU2MkXcQUzBzT59zUkuV3IOep2gmE+VFSiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YieoR9GFXBDpW/S/rPrqFewasba9YLxVMGUvduFkZVA=;
        b=vdOYAztzBdlsdbjw//alf5FzqRC5QeJWhjQ5aG70ycOnfSUDp/BJlzlo6802hFMinc
         aBt8q+7NSRkphrcgYg7hEhsmiBq4na0AS57KeAXO+BpfUZIlqR8wmcRXOLAua9jm+KHo
         fRmvWn/lw1zqrJ89qNiGm8Jh2RbRvAK6zbTd2ie8qVoFm8G/RTTc5r69MEYYBXUSox/z
         mWkrGiO/QK4pg+sDgUrAm8bnc9eTgZWNz3X3RREfhR7B2ZZHc0ezAzT9b8DDUq2Ro7pN
         6G4gsqkxz7TsK4QzVNmniYCU0MCLBEb+HyEsqL0mEr/MzAkozRmQGlyhHgcfH4DGAb7f
         PjnQ==
X-Gm-Message-State: AAQBX9fvcL9cgoP3VKL4/OXczXzahTBysE6Ghf5KAMpdN6fBIopnS/Md
        r6R04YiDId+Tl36yMLZY+yGmYlZUH1KuUtu7EtVFwSoJ/3EWx12n
X-Google-Smtp-Source: AKy350ZOOBmSxsKL7GOH768+6XTswkcSHxuK2zOLiz0MKREMKOgQK0H6K8Ydycm9M3k+WwLYZcZYqhXiE5O4Eing4lk=
X-Received: by 2002:a1f:9f85:0:b0:435:56e:154e with SMTP id
 i127-20020a1f9f85000000b00435056e154emr726664vke.1.1680857166037; Fri, 07 Apr
 2023 01:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230328031037.1361048-1-wenst@chromium.org> <9ab8d176-378c-9720-3794-c710e2bd6272@linaro.org>
In-Reply-To: <9ab8d176-378c-9720-3794-c710e2bd6272@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Apr 2023 16:45:55 +0800
Message-ID: <CAGXv+5H7QdNJ0Pj4xS_Ce=N63Csd1rCc+BoFJALyETLsA521NQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: only update
 registered thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 2, 2023 at 4:34=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 28/03/2023 05:10, Chen-Yu Tsai wrote:
> > It's possible for some sensors or thermal zones to not be registered,
> > either because they are unused or not fully declared in the device tree=
.
> > Nevertheless the driver enables interrupts for all sensors. If an
> > interrupt happens for an not-registered sensor, the driver would end up
> > updating a non-existent thermal zone, which leads to a NULL pointer
> > dereference.
> >
> > Change it so that only registered thermal zones get updated.
>
> Why not change the interrupt initialization ?

I'll send another patch for that.

However I think the part in this patch should still be fixed?

ChenYu

> > Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage The=
rmal Sensor driver")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/=
mediatek/lvts_thermal.c
> > index d87d3847c7d0..bf59174e18d3 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -415,9 +415,14 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lv=
ts_ctrl *lvts_ctrl)
> >               if (!(value & masks[i]))
> >                       continue;
> >
> > +             iret =3D IRQ_HANDLED;
> > +
> > +             /* sensor might not exist (bogus interrupt) or not be reg=
istered */
> > +             if (!lvts_ctrl->sensors[i].tz)
> > +                     continue;
> > +
> >               thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
> >                                          THERMAL_TRIP_VIOLATED);
> > -             iret =3D IRQ_HANDLED;
> >       }
> >
> >       /*
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

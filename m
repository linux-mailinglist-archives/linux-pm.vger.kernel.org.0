Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBF131DDD
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAGDPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 22:15:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35805 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGDPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 22:15:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so5635320edv.2;
        Mon, 06 Jan 2020 19:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwYzJpEY0xHNICmPe/YVUqO8DBJUmW8ge7lSsx3XN8c=;
        b=lUs2wTekElsiMukFGGFxbOAM40oeY8zHubtZKA+9FcZwulK98OGmLQNZV4C+fbkwjp
         1TAXpFQqbINWHsq8Uzb2YMjuu9Vs9nGwggwboFigGb6QOcAft0qCZXVFmBZ3Zwl/SXA1
         +hrHAPlk3SZQ9asAo9GPVvw+fMlg3wzgJp+KCYhY9iCehpNJTj82zWEU71WECytuGkfw
         Gkxb4lC32K0ugglzbgsTuV/jL/1ziNPx2Knk3lLTCK0ogS8iWM1n5/2jOI6Dnmc/7moa
         5jTTXZVfrKpQlSGq/6JaRl6FfJhSQh1gpstPX/aTxMpFJLJBi1gd6lFDhY2SKGWLAbQU
         J24g==
X-Gm-Message-State: APjAAAVDC8Ny9BMnOzjRvfPTNxj51YzC9zCBz5Q5jYGRuJgzXo9HeDZU
        9HCEr034AMlLofcjz9wl8Ui35MmwplE=
X-Google-Smtp-Source: APXvYqw4r5I9/jxWbaWc2wj612MjM59cL5ggP5M5yhw2YW6JyInCoE8uUdLtKa+UzxWJDCcsEs1e3w==
X-Received: by 2002:a05:6402:168c:: with SMTP id a12mr97883092edv.43.1578366916168;
        Mon, 06 Jan 2020 19:15:16 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id n10sm7925456ejc.58.2020.01.06.19.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 19:15:15 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id z3so52304683wru.3;
        Mon, 06 Jan 2020 19:15:15 -0800 (PST)
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr108514108wrx.178.1578366915409;
 Mon, 06 Jan 2020 19:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20191228171904.24618-1-tiny.windzz@gmail.com> <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
 <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com>
In-Reply-To: <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Jan 2020 11:15:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com>
Message-ID: <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Add hwmon support
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 12:14 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> HI Chen-Yu.
>
> On Mon, Jan 6, 2020 at 12:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > Expose sun8i thermal as a HWMON device.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/thermal/sun8i_thermal.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > index 23a5f4aa4be4..619e75cb41b0 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -20,6 +20,8 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/thermal.h>
> > >
> > > +#include "thermal_hwmon.h"
> > > +
> > >  #define MAX_SENSOR_NUM 4
> > >
> > >  #define FT_TEMP_MASK                           GENMASK(11, 0)
> > > @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> > >                                                              &ths_ops);
> > >                 if (IS_ERR(tmdev->sensor[i].tzd))
> > >                         return PTR_ERR(tmdev->sensor[i].tzd);
> > > +
> > > +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> > > +                       dev_warn(tmdev->dev,
> > > +                                "Failed to add hwmon sysfs attributes\n");
> >
> > Maybe you want a hard failure instead?
>
> I don't quite understand what you mean.
> What do you think should be done?

Return an error instead of just printing a warning.

ChenYu

> MBR,
> Yangtao
>
> >
> > ChenYu
> >
> > >         }
> > >
> > >         return 0;
> > > --
> > > 2.17.1
> > >

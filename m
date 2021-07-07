Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869B43BF145
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 23:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhGGVPD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 7 Jul 2021 17:15:03 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:41490 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGGVPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 17:15:02 -0400
Received: by mail-vs1-f42.google.com with SMTP id m12so2368185vst.8;
        Wed, 07 Jul 2021 14:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a0pHH7YFqYf6mvTW+xVsPFQZiAL7vgbf5rSQhrCg33s=;
        b=Wgb2nUgaCw4JBZ70T/B3ETgmJa6wsZpwCC7+DNo9G3UfFGB3LRIJJZJpgud1cQ2vVt
         zbvs4B7N/xpGl9UunqgjqTZ+Y1XSqV90ALwVVvFP2FKeefgok8WFWp6uo2i6GYnxCGeP
         vfMaKE1/ot8lbZTy+JNhKrE2H1SNtXKbwS0r1QxnTL7CWMdUzKz8fuJRKGPcG7su7dAJ
         EJ2l+j9ilHd1yZhj2iJXZFudvYCKDjjFIno8oQ9KB+u3G76r/2p8LNHKEdEE9Kuy9H5C
         hNgnvH44fGHQNzPUUctEdmel0Couls7FuStL4aVHKQoIgFenMFrRwfHkM/hUDp3v1Z15
         u7LQ==
X-Gm-Message-State: AOAM5336jZLJvBjW/MkuXtxA1x16cqiYaQ4sbNHd+j3FxOJ4mPa+Qz9F
        i/ufW2Wekud5SsGftQCzIGUm9SB2zq/VQKGGGf1AMXTG
X-Google-Smtp-Source: ABdhPJwSM3XBNpocc2f7Y3sP4DR7AVFiZu9N6UVcTWWuhGU1FsopdJzYoYn5a0zO3humfy29cd4PS2iduDhHGJ9ig9s=
X-Received: by 2002:a67:f98c:: with SMTP id b12mr23898767vsq.40.1625692341486;
 Wed, 07 Jul 2021 14:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
 <20210707131306.4098443-4-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdUx19uGTX3nddkODwdzLeSGuZbuyac7VMitZv=1tgyPSg@mail.gmail.com> <YOX4vulWqmtjrn14@oden.dyn.berto.se>
In-Reply-To: <YOX4vulWqmtjrn14@oden.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jul 2021 23:12:09 +0200
Message-ID: <CAMuHMdWqebdXqawBn=aGAt6HW4sHB=+U3jAP14tbnTUyXB3xzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: rcar_gen3_thermal: Fix datatype for loop counter
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Wed, Jul 7, 2021 at 8:56 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> On 2021-07-07 16:42:10 +0200, Geert Uytterhoeven wrote:
> > On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
> > <niklas.soderlund+renesas@ragnatech.se> wrote:
> > > The loop counter 'i' should be unsigned int to match struct
> > > rcar_gen3_thermal_priv num_tscs where it's stored.
> >
> > It is also stored in rcar_gen3_thermal_tsc.id, which is still (signed) int.
>
> Thanks.
>
> >
> > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -423,7 +423,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> > >         struct device *dev = &pdev->dev;
> > >         struct resource *res;
> > >         struct thermal_zone_device *zone;
> > > -       int ret, i;
> > > +       unsigned int i;
> > > +       int ret;
> > >
> > >         /* default values if FUSEs are missing */
> > >         /* TODO: Read values from hardware on supported platforms */
> >
> > And perhaps:
> >
> > -                dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
> > +                dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> >
> > ?
>
> Good catch, why do my compiler not warn for this? Did you catch this by

Because the types are (somewhat) compatible.

> review or have you some compiler magic I'm missing?

Review. You changed the type of a variable, I checked all places where
the variable is used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0681D3BEFDF
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGGS4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhGGS4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 14:56:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934EC061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 11:53:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t17so6760624lfq.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3lOVuztTd4DUBlnj2mt1Xu6lwx5QbdbS+W7LVC0F+PM=;
        b=AdMcVstUyoZuuVVvDZR6+OqphL3J98YZaIwsmloxwNvb51X+U6CZMCFv/6B/0Gwg4O
         XvdDC9FFmem9lmRKjI0gjcrw5ZTXrQsQBT1l/49rLK1//d64OetBR5sPiayV/dGsLVU/
         rV7cGKgUK4T0CUt7douSN1Wy1Cbhcv4w2iPkG41xTxPiXhfYs9nttvptls7MPFITdBSi
         df3uuJW4jdfp5qWxbdW9/54X7DFCuirw0AEYTEx8NB1/ZZuhoqkD3hJWGaGhgE6+bE/N
         wx9e5sQAar8NchxCq2VzXdgx7OWdSU6LKR9zXxKzVSA+jYqGbxpz/Bg/P31iMlICjMkI
         2Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3lOVuztTd4DUBlnj2mt1Xu6lwx5QbdbS+W7LVC0F+PM=;
        b=egwX25yPKP4u+4bmkUNzCHWrNCC8gMkrxEKyB6SQBuNoAzSdGnF52WozA4gIS0OPzW
         Hci0ZRB7j0urbVVXHPDfGD5uMH1mTZXcGskNMPZ89w7Plv1c6O3JBZzz5Y2Ao9D+7RVI
         lonnAeuqPOMOlFSYZ/7wPlHcg1PjtmaxoLOIUs7z/Wf+jtsZMT1hUaEpZ5wZMNx1mmcc
         v2dN/XzpBcu/5G514S+Jf7UR+W6sQtswjKcPwwOAEHY9tI8/5hSC9PbEsj7nqbgU6Bfr
         4i88GKjWszTldpVYwCo5YvOOK5XgOhdf827zRh03SlgopHEV1KQqsYIS4RgzbrRcMYTB
         vhmw==
X-Gm-Message-State: AOAM531lXrchk2D95aOIp8N4qjeHt59x6LY14C4r/lygobjPvEdhq//4
        +lFjMYDTaxM16B7qn8LMRxFLbzx4cMcN2Vpk
X-Google-Smtp-Source: ABdhPJzTiydQaXafX7Ot3he3ks+7RYNPvqbgFecojSBp5RRNcmbu2NVah4y1a+yVML7HGPd3EljR3g==
X-Received: by 2002:a05:6512:e8f:: with SMTP id bi15mr20255821lfb.80.1625684011162;
        Wed, 07 Jul 2021 11:53:31 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id o14sm549955lfd.144.2021.07.07.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:53:30 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:53:29 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] thermal: rcar_gen3_thermal: Add support for hardware
 trip points
Message-ID: <YOX4KVR3pfnr0tH4@oden.dyn.berto.se>
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
 <20210707131306.4098443-3-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdWTm79PXOgvuwDuFb8_LhvQxcR4wGsVKmP1vCbHN-3Mhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWTm79PXOgvuwDuFb8_LhvQxcR4wGsVKmP1vCbHN-3Mhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your feedback.

On 2021-07-07 16:58:33 +0200, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > All supported hardware except V3U is capable of generating interrupts
> > to the CPU when the temperature go below or above a set value. Use this
> > to implement support for the set_trip() feature of the thermal core on
> > supported hardware.
> >
> > The V3U have its interrupts routed to the ECM module and therefore can
> > not be used to implement set_trip() as the driver can't be made aware of
> > when the interrupt triggers.
> >
> > Each TSC is capable of tracking up-to three different temperatures while
> > only two are needed to implement the tracking of the thermal window.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -81,6 +81,7 @@ struct equation_coefs {
> >
> >  struct rcar_gen3_thermal_info {
> >         int ths_tj_1;
> > +       bool have_irq;
> 
> Do you need this flag? See below.
> 
> >  };
> >
> >  struct rcar_gen3_thermal_tsc {
> > @@ -95,7 +96,8 @@ struct rcar_gen3_thermal_priv {
> >         const struct rcar_gen3_thermal_info *info;
> >         struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
> >         unsigned int num_tscs;
> > -       void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
> > +       void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
> 
> Do you need priv? See below.
> 
> > +                            struct rcar_gen3_thermal_tsc *tsc);
> >  };
> >
> >  static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
> > @@ -195,16 +197,75 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> 
> >  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> >         .get_temp       = rcar_gen3_thermal_get_temp,
> > +       .set_trips      = rcar_gen3_thermal_set_trips,
> >  };
> >
> > +static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops_no_irq = {
> > +       .get_temp       = rcar_gen3_thermal_get_temp,
> > +};
> 
> What about having a single non-const thermal_zone_of_device_ops,
> and filling in .set_trip when interrupts are present?

I could, for some reason I like ops structs to be cost. It prevents me 
from modifying it's members after they have been used in a framework 
init function somewhere which judged the driver capabilities on its 
populated members ;-)

But this is a simple thing in this driver, I will give it a try for v2.

> 
> > @@ -240,6 +305,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> >
> >         rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
> >         rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> > +       if (priv->info->have_irq)
> 
> I think you can check for the presence of tsc->zone->ops->set_trips instead.

Good idea!

> 
> > +               rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
> > +                                       IRQ_TEMPD1 | IRQ_TEMP2);
> >
> >         reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
> >         reg_val |= THCTR_THSST;
> 
> > @@ -314,8 +388,37 @@ static void rcar_gen3_hwmon_action(void *data)
> >         thermal_remove_hwmon_sysfs(zone);
> >  }
> >
> > +static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
> > +                                         struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       unsigned int i;
> > +       char *irqname;
> > +       int ret, irq;
> > +
> > +       for (i = 0; i < 2; i++) {
> > +               irq = platform_get_irq(pdev, i);
> 
> Would it make sense to use platform_get_irq_optional() instead,
> to auto-detect variants with and without interrupt support?

The bindings require interrupts be present for all variants but V3U. But 
since auto-detect is a good thing and with the method you describe it's 
easy to add, will give it a try for a v2.

> 
> > +               if (irq < 0)
> > +                       return irq;
> > +
> > +               irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> > +                                        dev_name(dev), i);
> > +               if (!irqname)
> > +                       return -ENOMEM;
> > +
> > +               ret = devm_request_threaded_irq(dev, irq, NULL,
> > +                                               rcar_gen3_thermal_irq,
> > +                                               IRQF_ONESHOT, irqname, priv);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Niklas Söderlund

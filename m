Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF4249DB3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHSMVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHSMVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 08:21:21 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF7C061757;
        Wed, 19 Aug 2020 05:21:21 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so24355058iow.11;
        Wed, 19 Aug 2020 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDXvGIgO4qr56J5pc+T+Ke6IzH5SYLMXSn24/sPplxw=;
        b=pZLYSCTL7Cu78WmtherjVYFOkJMi+wdtF9ZcyUieW0OPhIjZcPNeB/VVYR+RFQ4DD2
         0jFOWYb6dfTxXH5DDzxukA9J3ocPNKzuymsVG3cUBJH/2STXL6DK9hfBBszPl/Tw5J2C
         yz/QuHxtWzmBFkpQvnmZHvRANLz+ODAOe9zREz39LNjHl9wIAjM7K2vhB4dEm8sLvAb1
         Iyc/FA2df5B8l1zp9X5cSmzY6djuP2gTr8d57itnmEbGkJt+rOt0WtVLwbN48GnUewS2
         chR5727ntKoKEzRyqPiEf8LR1cwOkSzC2huFN/y2KejdeLXo/gvvrSKF8Ijetav7Ia2e
         6+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDXvGIgO4qr56J5pc+T+Ke6IzH5SYLMXSn24/sPplxw=;
        b=sfMi9n5sgELrxBC3iOJwHwlqFPC4+5nCt/tqbsP9SinxjpYB/ryvxudG1iONq0eeX8
         cpUdR6v5IB4TusujWvsL4ZxGBg8ghalaS/U3Oku66reE40/OWGR9QxcEmBgwiiC8CPuz
         qsqdjIWKO81/OZtbNoiK+ttXbF+dQ+43WUy1NbdlSqlHw1yH2ETxosClOXV9HvBh/Dg4
         iq+jU2kzby0XgslvjSE8hFydYsxIJGKL5KsW46yif1IqW9y33ZDl4cbq9q7ENHTPKHqN
         l26VcBLrYil7mUQMer3CIBlfLhy+Cd69c+Am0mtqO+njOwg01MiC6ruutZeexqQZC8r3
         ZeBg==
X-Gm-Message-State: AOAM53134IXqTWxC3zSo3dKEwPBqj7wVVUiQSgo5MFU1BPH8OwB2jXON
        eDsNKqpDsn54bdFRH41oTcAvoLhsgO5yYsNGtKU=
X-Google-Smtp-Source: ABdhPJxnurhXiQvzQfUbCrg4tnJkVP5y3QBbi20nLK+kb1MEy6AkyYCqs56cIeXNtREnXzd0q/nennp+xvMEYGSFBFA=
X-Received: by 2002:a6b:e002:: with SMTP id z2mr19868369iog.178.1597839678885;
 Wed, 19 Aug 2020 05:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818154633.5421-1-aford173@gmail.com> <20200819045914.GS2994@atomide.com>
In-Reply-To: <20200819045914.GS2994@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 19 Aug 2020 07:21:07 -0500
Message-ID: <CAHCN7xKBzRfByvdYBPS=uWF2QvECAOf5zGZE0-pxjJ6A2-d95g@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: ti-soc-thermal: Enable addition power management
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 11:58 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [200818 15:46]:
> > @@ -1153,6 +1166,38 @@ static int ti_bandgap_suspend(struct device *dev)
> >       return err;
> >  }
> >
> > +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> > +                               unsigned long cmd, void *v)
> > +{
> > +     struct ti_bandgap *bgp;
> > +
> > +     bgp = container_of(nb, struct ti_bandgap, nb);
> > +
> > +     spin_lock(&bgp->lock);
> > +     switch (cmd) {
> > +     case CPU_CLUSTER_PM_ENTER:
> > +             if (bgp->is_suspended)
> > +                     break;
> > +             ti_bandgap_save_ctxt(bgp);
> > +             ti_bandgap_power(bgp, false);
> > +             if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> > +                     clk_disable(bgp->fclock);
> > +             break;
> > +     case CPU_CLUSTER_PM_ENTER_FAILED:
> > +     case CPU_CLUSTER_PM_EXIT:
> > +             if (bgp->is_suspended)
> > +                     break;
> > +             if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> > +                     clk_enable(bgp->fclock);
> > +             ti_bandgap_power(bgp, true);
> > +             ti_bandgap_restore_ctxt(bgp);
> > +             break;
> > +     }
> > +     spin_unlock(&bgp->lock);
> > +
> > +     return NOTIFY_OK;
> > +}
>
> Hmm to me it looks like is_suspended is not used right now?
> I guess you want to set it in ti_bandgap_suspend() and clear
> it in ti_bandgap_resume()?
>
> Otherwise looks good to me, I can't test the power consumption
> right now though so you may want to check it to make sure
> device still hits off mode during idle.

I have a V2.  Do you want me to re-post 2/2 with V2 as no change, or
should I just submit this patch alone?

adam
>
> Regards,
>
> Tony

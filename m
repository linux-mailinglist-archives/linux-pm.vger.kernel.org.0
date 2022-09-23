Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4A5E7C63
	for <lists+linux-pm@lfdr.de>; Fri, 23 Sep 2022 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiIWN4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Sep 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiIWN4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 09:56:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F513D1F7
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 06:56:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s14so214548wro.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S/p8TvXlsMGXG51CkXeBekBV47MmYMaNjH+nwQik6mo=;
        b=pesQIkJa1x9mg8LE7c1BamUwx4uzYPg0MQOvF7vkEfvtp0xDXdNWK4UsxwdeYxqP1G
         f5lXAOWWPOITHbY2gdNkFN7/IsH5pu+axiN8GES5mepjN+IAWBGkMYSkXFG9h2d3hgME
         T+UOpQi4Vvp9qxmkK3+IXptPL8pBBH782k8y6fTghfF7kPK2muCQfKu9ox11hKgvVm8j
         vBOqaOiTKtiiE0ekdqBpg6AB407tl+GtSV30SyWW7CsJBiYWtGtGKitpIu8NG7tZ7gHW
         O1a2s8TQS1Tc4zC7PaGuTjDzgY2V3EWfF14CTgQb6abAp9h2DDbR7Z00ljb01PAm8n11
         LDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S/p8TvXlsMGXG51CkXeBekBV47MmYMaNjH+nwQik6mo=;
        b=MRpEp6ZIDlJnRNo17HTl9tnJmV2U8uFIuOccG5adfo5iXshOtLyCMFpqRIuDAQlWnc
         a7fioalwAzhCUlGe6TLWsfrk9VfhStaxFbv/X/yGFW1kzaS4PAebcNIARaHvheRRqI6i
         TreUJewHb4vgJNgvqBjAqcvbl4JZPxnGPu2xaXYKhPeVJaWWTFnUox7e4dCGgQwVXyHE
         cGi2nFHaREnvbr50PSJ6nlVPoEQ6Tdw30K5wfsVMWsXCK56YuiOlFnFPdlX1Yjp45lo2
         J8b9iLcUcpTYwAwBWG9BIaR4tnTbs+xKTEP5i/r//Eid6PfjIZ/qDjILok8RAMNYhUqM
         8LJA==
X-Gm-Message-State: ACrzQf3vt6ttTu+IIFdTQb/qbT7AhpG9xxjlrumJacJAwGxj5XLtApaB
        Xg5wBVbTYbdRf2tyC3Z4F4qO793Yab001CCH60rhHQ==
X-Google-Smtp-Source: AMsMyM5JD0LHLzdgiPuW93f49BMsTWiW6nyvuGbZbM+xrf5PUIHPYMm+BgwIrZTLBwTvkItjALXG7xZhx/Y05gOiULI=
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id
 n15-20020a5d588f000000b0022b05cce1d3mr5073130wrf.142.1663941358489; Fri, 23
 Sep 2022 06:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
 <20220726083257.1730630-2-martin.kepplinger@puri.sm> <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
 <d1db07c8ca57c72b4f0820fcb6832dd7e4501055.camel@puri.sm> <CAPDyKFpz0HG_AzCkj8LkyisO1fjJiiyX2QjKTWDTLng2O7PDgA@mail.gmail.com>
 <77baacb930bf2ba1a65cb1515e6795b48d2d4ed5.camel@puri.sm> <CAPDyKFoS=E3c9XWWCaG2byMm-3nvvW5jXS0X7Bh-NK_msTUykQ@mail.gmail.com>
 <3bbba64dc4fd9ef37fb937f5176b1ef50b8b2d73.camel@puri.sm>
In-Reply-To: <3bbba64dc4fd9ef37fb937f5176b1ef50b8b2d73.camel@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Sep 2022 15:55:21 +0200
Message-ID: <CAPDyKFqRAo+r0kW3H1ipu0trX0FC6EnG-PpFvXD7c1WmfPhtSA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Aug 2022 at 09:06, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Mittwoch, dem 24.08.2022 um 15:30 +0200 schrieb Ulf Hansson:
> > On Mon, 22 Aug 2022 at 10:38, Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > Am Freitag, dem 19.08.2022 um 16:53 +0200 schrieb Ulf Hansson:
> > > > On Fri, 19 Aug 2022 at 11:17, Martin Kepplinger
> > > > <martin.kepplinger@puri.sm> wrote:
> > > > >
> > > > > Am Dienstag, dem 26.07.2022 um 17:07 +0200 schrieb Ulf Hansson:
> > > > > > On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> > > > > > <martin.kepplinger@puri.sm> wrote:
> > > > > > >
> > > > > > > If for example the power-domains' power-supply node
> > > > > > > (regulator)
> > > > > > > needs
> > > > > > > interrupts to work, the current setup with noirq callbacks
> > > > > > > cannot
> > > > > > > work; for example a pmic regulator on i2c, when suspending,
> > > > > > > usually
> > > > > > > already
> > > > > > > times out during suspend_noirq:
> > > > > > >
> > > > > > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > > > > > >
> > > > > > > So fix system suspend and resume for these power-domains by
> > > > > > > using
> > > > > > > the
> > > > > > > "outer" suspend/resume callbacks instead. Tested on the
> > > > > > > imx8mq-
> > > > > > > librem5 board,
> > > > > > > but by looking at the dts, this will fix imx8mq-evk and
> > > > > > > possibly
> > > > > > > many other
> > > > > > > boards too.
> > > > > > >
> > > > > > > This is designed so that genpd providers just say "this
> > > > > > > genpd
> > > > > > > needs
> > > > > > > interrupts" (by setting the flag) - without implying an
> > > > > > > implementation.
> > > > > > >
> > > > > > > Initially system suspend problems had been discussed at
> > > > > > > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > > > > > > which led to discussing the pmic that contains the
> > > > > > > regulators
> > > > > > > which
> > > > > > > serve as power-domain power-supplies:
> > > > > > > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > > > > > >
> > > > > > > Signed-off-by: Martin Kepplinger
> > > > > > > <martin.kepplinger@puri.sm>
> > > > > > > ---
> > > > > > >  drivers/base/power/domain.c | 13 +++++++++++--
> > > > > > >  include/linux/pm_domain.h   |  5 +++++
> > > > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/domain.c
> > > > > > > b/drivers/base/power/domain.c
> > > > > > > index 5a2e0232862e..58376752a4de 100644
> > > > > > > --- a/drivers/base/power/domain.c
> > > > > > > +++ b/drivers/base/power/domain.c
> > > > > > > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops
> > > > > > > genpd_spin_ops = {
> > > > > > >  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> > > > > > > GENPD_FLAG_ACTIVE_WAKEUP)
> > > > > > >  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> > > > > > > GENPD_FLAG_CPU_DOMAIN)
> > > > > > >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> > > > > > > GENPD_FLAG_RPM_ALWAYS_ON)
> > > > > > > +#define genpd_irq_on(genpd)            (genpd->flags &
> > > > > > > GENPD_FLAG_IRQ_ON)
> > > > > > >
> > > > > > >  static inline bool irq_safe_dev_in_sleep_domain(struct
> > > > > > > device
> > > > > > > *dev,
> > > > > > >                 const struct generic_pm_domain *genpd)
> > > > > > > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct
> > > > > > > generic_pm_domain
> > > > > > > *genpd,
> > > > > > >         genpd->domain.ops.runtime_suspend =
> > > > > > > genpd_runtime_suspend;
> > > > > > >         genpd->domain.ops.runtime_resume =
> > > > > > > genpd_runtime_resume;
> > > > > > >         genpd->domain.ops.prepare = genpd_prepare;
> > > > > > > -       genpd->domain.ops.suspend_noirq =
> > > > > > > genpd_suspend_noirq;
> > > > > > > -       genpd->domain.ops.resume_noirq =
> > > > > > > genpd_resume_noirq;
> > > > > > > +
> > > > > > > +       if (genpd_irq_on(genpd)) {
> > > > > > > +               genpd->domain.ops.suspend =
> > > > > > > genpd_suspend_noirq;
> > > > > > > +               genpd->domain.ops.resume =
> > > > > > > genpd_resume_noirq;
> > > > > > > +       } else {
> > > > > > > +               genpd->domain.ops.suspend_noirq =
> > > > > > > genpd_suspend_noirq;
> > > > > > > +               genpd->domain.ops.resume_noirq =
> > > > > > > genpd_resume_noirq;
> > > > > >
> > > > > > As we discussed previously, I am thinking that it may be
> > > > > > better
> > > > > > to
> > > > > > move to using genpd->domain.ops.suspend_late and
> > > > > > genpd->domain.ops.resume_early instead.
> > > > >
> > > > > Wouldn't that better be a separate patch (on top)? Do you
> > > > > really
> > > > > want
> > > > > me to change the current behaviour (default case) to from noirq
> > > > > to
> > > > > late? Then I'll resend this series with such a patch added.
> > > >
> > > > Sorry, I wasn't clear enough, the default behaviour should remain
> > > > as
> > > > is.
> > > >
> > > > What I meant was, when genpd_irq_on() is true, we should use the
> > > > genpd->domain.ops.suspend_late and genpd-
> > > > >domain.ops.resume_early.
> > >
> > > Testing that shows that this isn't working. I can provide the logs
> > > later, but suspend fails and I think it makes sense: "suspend_late"
> > > is
> > > simply already too late when i2c (or any needed driver) uses
> > > "suspend".
> >
> > Okay, I see.
> >
> > The reason why I suggested moving the callbacks to "suspend_late",
> > was
> > that I was worried that some of the attached devices to genpd could
> > use "suspend_late" themselves. This is the case for some drivers for
> > DMA/clock/gpio/pinctrl-controllers, for example. That said, I am
> > curious to look at the DT files for the platform you are running,
> > would you mind giving me a pointer?
>
> I'm running
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> with these (small) patches on top:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commits/5.19.3/librem5

Thanks for sharing the information!

>
> >
> > So, this made me think about this a bit more. In the end, just using
> > different levels (suspend, suspend_late, suspend_noirq) of callbacks
> > are just papering over the real *dependency* problem.
>
> true, it doesn't feel like a stable solution.
>
> >
> > What we need for the genpd provider driver, is to be asked to be
> > suspended under the following conditions:
> > 1. All consumer devices (and child-domains) for its corresponding PM
> > domain have been suspended.
> > 2. All its supplier devices supplies must remain resumed, until the
> > genpd provider has been suspended.
> >
> > Please allow me a few more days to think in more detail about this.
>
> Thanks a lot for thinking about this!

I have made some more thinking, but it's been a busy period for me, so
unfortunately I need some additional time (another week). It seems
like I also need to do some prototyping, to convince myself about the
approach.

So, my apologies for the delay!

Kind regards
Uffe

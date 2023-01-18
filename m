Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCD671DC8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjARNbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjARNbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 08:31:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4655C0C0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 04:56:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2065530pjf.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 04:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbR02xUHy7WVqssq47nSZQ5+B/tt/M1wYgffH/OeUgY=;
        b=Y8SHSxzy1y95wxAE57ze1MY3KCpGcIg3qo8ZVv/hQmTBEiG4khJVaeA2smM0kZwdia
         cdHQyI1huXe9H/4YFpvXD+ysC3itYmO/s7sNfm8GRTqk38B6m818TR4nZIivB0RMrURq
         pzAqbTWnt+bUWRi+mOPL3au1o7blyiRs1QAt244UUBPZO+J/xSUcj3XH5m6XJGMSJ7fG
         SlL5+CVNvJWIQ3su9tSI2kzjMSx1sy3xQfIAD90B96uRug+cqxGcozLSi0nmUcfzZJN4
         Iv1ZajFKTIxgiRUaBM9LW/lHURTKHXZymxfwLLLk+IZ80IchEClYS/ZcGndwaUmDgTJw
         DoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbR02xUHy7WVqssq47nSZQ5+B/tt/M1wYgffH/OeUgY=;
        b=Wh6RO9vl/gYpx12qPpVY0Vg6iaKQsiOo0+WcDOIPKoznFd0wijV0LiCzXg3HvyGUzG
         DDfL1h+IT52xVy+2UzWnJ6O6+AVtpjL1DHS5flofqgIWyqL3eH9+6C17W1JIYTkO5aHT
         s/tz60A38irIp2herWPu9VTcjCXViSgrdvUrRDDklU/Nt08biDKPPxfzWgoUSc3j2ilM
         bljRH+iFaYwRVCLgKzppTb/oLMoMpVEGxdSEjvU6YmiXBsuzfbsIf2Lol4YFLD/LrHX6
         6VEMVV/nmzPhsDhhWeHbSRGkX8B4bLzRFqcQWSeQxUS0ESFlaPr2d3r5BcNV8K5R8apz
         5UKw==
X-Gm-Message-State: AFqh2kr68weX3L+IO0D5YyFqEChSeAE0t1LaOKTJa3Pxx2bSkBsfcCRR
        hFlmedqmlwgJz38g3T0uo4M1CoeqO08ZNqWgNR5qkQ==
X-Google-Smtp-Source: AMrXdXtctAClOLU+Sbh8Fft0yGLg2pqfEWfg84vZDr/tymguVOke1sp3m2dJ3QqqLgEJRbSwy437I+bL9q1ykYZIMOc=
X-Received: by 2002:a17:90a:d784:b0:229:4394:ab86 with SMTP id
 z4-20020a17090ad78400b002294394ab86mr734775pju.164.1674046585833; Wed, 18 Jan
 2023 04:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20221108013517.749665-1-marex@denx.de> <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
 <52578b45-cf4c-e949-b2b1-a0f251815337@denx.de> <CAPDyKFrQ0Uvhsa2AXwTdzOC1xhQ6qjRP=1TzVXC3StLv5FOoBA@mail.gmail.com>
 <cf304d09c26416eb286f03bfe1e292aa8399b349.camel@pengutronix.de>
 <CAPDyKFqONWFj86FbhhGXmxVTMvdwdwWUNLDqEK5gg2-bDitmxg@mail.gmail.com> <6d1f2a1a-437e-01b7-cf25-af1a09ce7f3f@oss.nxp.com>
In-Reply-To: <6d1f2a1a-437e-01b7-cf25-af1a09ce7f3f@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Jan 2023 13:55:49 +0100
Message-ID: <CAPDyKFo8ekN3e8kzbtftKuyYY1wv0=gn3L=oz5zBjTebRT84+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off callbacks
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Stephen Boyd <swboyd@chromium.org>
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

On Wed, 4 Jan 2023 at 09:38, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Ulf,
>
> On 11/17/2022 12:30 AM, Ulf Hansson wrote:
> > On Wed, 16 Nov 2022 at 14:25, Lucas Stach <l.stach@pengutronix.de> wrote:
> >>
> >> Hi Ulf,
> >>
> >> Am Mittwoch, dem 16.11.2022 um 13:41 +0100 schrieb Ulf Hansson:
> >>> + Stephen Boyd
> >>>
> >>> On Mon, 14 Nov 2022 at 21:32, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 11/14/22 20:40, Ulf Hansson wrote:
> >>>>> On Tue, 8 Nov 2022 at 02:35, Marek Vasut <marex@denx.de> wrote:
> >>>>>>
> >>>>>> Currently it is possible that a power domain power on or off would claim
> >>>>>> the genpd lock first and clock core prepare_lock second, while another
> >>>>>> thread could do the reverse, and this would trigger lockdep warning.
> >>>>>
> >>>>> I am not quite sure I fully understand. In this case is the lockdep
> >>>>> warning relevant or just something that we want to silence?
> >>>>
> >>>> This is a valid problem, see patches 2/3 and 3/3 for details too.
> >>>>
> >>>>>> Introduce new callbacks, .power_pre/post_on() and .power_off_pre/post(), which
> >>>>>> are triggered before the genpd_lock() and after genpd_unlock() respectively in
> >>>>>> case the domain is powered on and off. Those are meant to let drivers claim
> >>>>>> clock core prepare_lock via clk_*prepare() call and release the lock via
> >>>>>> clk_*unprepare() call to always assure that the clock and genpd lock ordering
> >>>>>> is correct.
> >>>>>
> >>>>> To me, this sounds like a problem that may be better fixed by trying
> >>>>> to model the parent/child-domains in a more strict way, through genpd.
> >>>>>
> >>>>> There is a comment in the code in imx8mp_blk_ctrl_probe() that seems
> >>>>> to be pointing in this direction too.
> >>>>>
> >>>>> "* We use runtime PM to trigger power on/off of the upstream GPC
> >>>>>     * domain, as a strict hierarchical parent/child power domain
> >>>>>     * setup doesn't allow us to meet the sequencing requirements......"
> >>>>>
> >>>>> I am wondering about what those "sequencing requirements" are - and
> >>>>> whether it could make better sense to fix these issues instead?
> >>>>
> >>>> Here is the lockdep splat:
> >>>>
> >>>> https://lore.kernel.org/all/Y1cs++TV2GCuh4tS@pendragon.ideasonboard.com/
> >>>
> >>> Yes, that certainly helped!
> >>>
> >>>>
> >>>> It really is a problem between the clock and genpd subsystem locks, they
> >>>> can be claimed in arbitrary order, see patch 2/3 and 3/3.
> >>>>
> >>>> I think that might clarify what I am attempting to solve here.
> >>>
> >>> Let me try to put some more words behind this, to make sure I have
> >>> understood correctly, but also to easier allow more people to chim in.
> >>>
> >>> Note that, in your commit messages in patch2 and patch3, you are
> >>> mentioning clk_disable_unused(), but that's not what the lockdep splat
> >>> above is pointing at. Although, it seems the clk_disable_unused()
> >>> thingy, would trigger a similar problem for this configuration for the
> >>> imx8mp platform.
> >>>
> >>> Case #1:
> >>> Triggered from the workqueue, the genpd_power_off_work_fn() ends up
> >>> calling clk_bulk_unprepare(), from a genpd's ->power_off() callback(),
> >>> which has been assigned to imx8mp_blk_ctrl_power_off(). Before genpd's
> >>> ->power_off() is called, the genpd-lock(s) have been acquired, thus we
> >>> are trying to acquire the global clk-prepare lock via
> >>> clk_bulk_unprepare() while holding the genpd-lock(s).
> >>>
> >>> Case #0:
> >>> The "drm driver" calls clk_set_rate(), thus we start by acquiring the
> >>> global clk-prepare lock. Internally in the clock frameworks, the
> >>> clk_set_rate() path continues to call clk_pm_runtime_get(). In this
> >>> case, the corresponding clock provider's struct *device, seems to be
> >>> attached to a genpd too. This means the call to clk_pm_runtime_get()
> >>> ends up in genpd_runtime_resume(), which needs to acquire the
> >>> genpd-lock(s) before it continues to call genpd_power_on() to power-on
> >>> the PM domain. In other words, we try to acquire genpd-lock(s) while
> >>> holding the global clk-prepare lock.
> >>>
> >>> The solution to fix these problems that you suggest in the $subject
> >>> patch, isn't the direction I want this to take. The new callbacks are
> >>> prone to be abused and it would also require genpd provider specific
> >>> code to fix the problems. Of course, we need things to work, but let's
> >>> look at a couple of options first. See below.
> >>>
> >>> 1)
> >>> In a way, it looks like we have a circular description in DT of the
> >>> hierarchy of the clock- and genpd providers, which is a bit awkward in
> >>> my opinion. I was browsing the imx8mp DTS files to find this, but I
> >>> couldn't. Can you perhaps point me to the DTS file(s) you are using? I
> >>> can try to have a look so see if this could be arranged differently.
> >>
> >> The dependency chain isn't circular, it just happens to converge in the
> >> clock framework and its single big hammer lock. The chain looks some
> >> thing like this:
> >>
> >> 1. DRM driver request pixel clock (clk_prepare_enable ->
> >> clk_prepare_mutex)
> >> 2. Pixel clock is supplied from the PHY, which is in a power domain, so
> >> in order to supply the clock it needs to runtime resume
> >> 3. genpd powers up the PHY blk-ctrl domain, which again is inside a
> >> GPCv2 power domain
> >> 4. genpd powers up GPCv2 domain, which needs a specific clock to be
> >> running in order to power up the domain, so it does a
> >> clk_prepare_enable, which now happens to hit the clk_prepare_mutex
> >> taken in step 1.
> >>
> >> As the runtime resume/suspend for the PHY may go through a workqueue we
> >> have two different contexts trying to take the clk_prepare_mutex, which
> >> is what lockdep complains about.
> >
> > I see. Thanks for bringing some more clarity in this.
> >
> > So the above is described in some of the in-kernel DTS(i) files too?
> >
> >>
> >>>
> >>> 2)
> >>> What we have seen from other use cases [1], is that calling
> >>> pm_runtime_get|put*(), while holding subsystem specific locks (like
> >>> the genpd-lock(s) and clk-prepare lock), isn't working very well. So,
> >>> I am thinking that we could have a look at the runtime PM deployment
> >>> in the clock framework, to see if we can avoid holding the global
> >>> clk-prepare lock, while calling into runtime PM. I believe that should
> >>> fix these problems too.
> >>
> >> I don't see any straight forward way to avoid the clock framework calls
> >> in the chain laid out above. I would be happy if anyone has some good
> >> suggestions.
> >
> > I think you misunderstood what I proposed above. What I was suggesting
> > is that we could re-work the runtime PM deployment in the clock
> > framework.
> >
> > In this way, we would not be holding the global clk-prepare lock while
> > trying to power-on the phy and its PM domain. Wouldn't that work?
>
>
> Do you have time to give a look at NXP downstream patch to address the
> lock issue in genpd side [1]?

Thanks for sharing this! I had a look and the approach seems like it
could work for you. However, I am still not sure it's the correct
thing to do.

>
> Honestly I not have idea on how to rework the clk part to avoid holding
> the clk-prepare lock when power on the phy and its power domain.

I understand. Let me try to prepare a hackish patch that we can use to
run some tests.

Unfortunately, I can't make any promises for when, but I will do my best.

>
> [1]https://github.com/nxp-imx/linux-imx/commit/c85126180a10439a8c7db1800529b4857d91c609
>
> Thanks,
> Peng.
> >
> > Kind regards
> > Uffe

Kind regards
Uffe

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B07063ABA1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiK1Oy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 09:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiK1Oy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 09:54:57 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A691F9D5;
        Mon, 28 Nov 2022 06:54:56 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id u10so1917246qvp.4;
        Mon, 28 Nov 2022 06:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8qjZ4omGnU5DnQH4BCfbC89EUQkek2vUjISomuBZQg=;
        b=vPGOYCyI7KzjrNx2nXGa9UZ6CviGdaLEmWhFfCzkWOePnj/2gW0mbRkbsODNMUit9C
         ss3udjKQeIe9G7x1iDQSFL9CYUdJzZoxUyeJmmI9zgqgDjiaNiDBpHup5bluFULimGrH
         VKPqEgLSdMvzYngNTqDxLODoQMUiH3y7N2fXGcX81/QzbDMFHdqYhobNr3ays7ovU810
         Hg9rtGA7vMnPu4Y2HHYtzQMYEOjX43ukiF3rpPblDyTmrj7gb/HHWN18SzwLzhRc5BF6
         dGKJHrQotOJpiMWCMSPzyAZ6wXTtFgiMLTC7UrZ9B+fKciBsU404tufB51vi/jgjw2jk
         AtZQ==
X-Gm-Message-State: ANoB5pmCAWBQ+bnpHPEOvV0NpwIrv3yIEoEjO0xlHrVKBbi2ekFqdECL
        /y4/Odfsy8K0I2EQ3C+l5My27HMoeLLvc3VHQ5Y=
X-Google-Smtp-Source: AA0mqf6ZQvmOxdAviiU0IzzdPXCRx3Ywx6XUyHrEQ+1tFKgUa5uXCyna99yIXy7uLof+eMX99XEFnqKGVIMqeKaE1Fo=
X-Received: by 2002:a0c:c582:0:b0:4af:b750:b569 with SMTP id
 a2-20020a0cc582000000b004afb750b569mr31255377qvj.83.1669647295522; Mon, 28
 Nov 2022 06:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com>
 <20221031121314.1381472-3-kajetan.puchalski@arm.com> <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
 <Y4TGbK+AhzRdiPA6@e126311.manchester.arm.com>
In-Reply-To: <Y4TGbK+AhzRdiPA6@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Nov 2022 15:54:44 +0100
Message-ID: <CAJZ5v0idJTYR4+gooLnEV=kX_dDCgEdP1mgp81AEcFCcjeNoDw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 28, 2022 at 3:33 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> On Fri, Nov 25, 2022 at 07:27:13PM +0100, Rafael J. Wysocki wrote:
> > > +/*
> > > + * The number of bits to shift the cpu's capacity by in order to determine
> > > + * the utilized threshold
> > > + */
> > > +#define UTIL_THRESHOLD_SHIFT 6
> >
> > Why is this particular number regarded as the best one?
>
> Based on my testing this number achieved the best balance of power and
> performance on average. It also makes sense from looking at the util
> plots. The resulting threshold is high enough to not be triggered by
> background noise and low enough to react quickly when activity starts
> ramping up.

It would be good to put some of this information (or maybe even all of
it) into the comment above the symbol definition.

> > > +static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
> > > +{
> > > +       unsigned long util = sched_cpu_util(dev->cpu);
> > > +
> > > +       cpu_data->utilized = util > cpu_data->util_threshold;
> >
> > Why exactly do you need the local variable here?
>
> It's not necessarily needed, I can replace it with comparing the result
> of the call directly.
>
> > Then, if there's only one caller, maybe this could be folded into it?
>
> I do think it's nicer to have it separated in its own helper function, that
> way if anything more has to be done with the util it'll all be
> self-contained. Having only one caller shouldn't be a big issue, it's
> also the case for teo_middle_of_bin and teo_find_shallower_state in the
> current TEO implementation.

OK

> > > +               /* don't update metrics if the cpu was utilized during the last sleep */
> >
> > Why?
> >
> > The metrics are related to idle duration and cpu_data->utilized
> > indicates whether or not latency should be reduced.  These are
> > different things.
> >
> > Moreover, this is just one data point and there may not be any direct
> > connection between it and the decision made in this particular cycle.
>
> Agreed, v4 already has this part removed.
>
> > > +               if (!cpu_data->utilized)
> > > +                       teo_update(drv, dev);
> > >                 dev->last_state_idx = -1;
> > >         }
> > >
> > > @@ -323,6 +381,21 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >                         goto end;
> > >         }
> > >
> > > +       teo_get_util(dev, cpu_data);
> > > +       /* the cpu is being utilized and there's only 2 states to choose from */
> > > +       /* no need to consider metrics, choose the shallowest non-polling state and exit */
> >
> > A proper kernel-coding-style 2-line comment, please!
> >
> > Also I would say "utilized beyond the threshold" instead of just
> > "utilized" and "there are only 2 states" (plural).
>
> Both good points, I'll fix that.
>
> > > +       if (drv->state_count < 3 && cpu_data->utilized) {
> > > +               for (i = 0; i < drv->state_count; ++i) {
> > > +                       if (dev->states_usage[i].disable ||
> > > +                                       drv->states[i].flags & CPUIDLE_FLAG_POLLING)
> > > +                               continue;
> > > +                       break;
> >
> > This looks odd.  It would be more straightforward to do
> >
> > if (!dev->states_usage[i].disable && !(drv->states[i].flags &
> > CPUIDLE_FLAG_POLLING)) {
> >         idx = i;
> >         goto end;
> > }
> >
> > without the "break" and "continue".
>
> Fair enough, this works as well.
>
> > I've changed my mind with respect to adding the idx == 1 check to
> > this.  If the goal is to reduce latency for the "loaded" CPUs, this
> > applies to deeper idle states too.
>
> I see, this has no effect on arm devices one way or the other so I don't
> mind, it's completely up to you. In light of Doug's test results
> regarding this change, should I remove the check in v5?

Yes, please.

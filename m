Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019961B1FE4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDUHbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUHbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 03:31:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A902C061A0F;
        Tue, 21 Apr 2020 00:31:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so15222155wrs.6;
        Tue, 21 Apr 2020 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9m3MRy8x+o4H1EEycml0VyqSiaYH7kBtrQzXfBUS8w=;
        b=GlKRZFFyQs7kZycqIc8kmWXH6Ud4+HQlXs3tT/pPSNZiMX9h8VVS8uJ4YjqPe9VH8K
         VOsgHdZHB+X8w3fU84GRwWmtLSlcVzqJK7F/LoKjnYTtGYgq3XlXvWec2jF5yMlqXgqT
         DMgM1TfcX2lja1KJLWe7ISkMNWMptDaq+uRd0auhbWqgVgW1EPpuWXmJWENaC70cqkHl
         W1OAI+RQF3UbWRsqpDAk3GeJKKu0TXTiXcokuG6Qfw9gi4uhUhhkh/njN+XgNpd68M6p
         4MIsTwBlPzPF6/fdkxJpNRxasCq6hiJzXqMxnl+6c6ccJiiwVjHBSMjSmK14iNLpPdBh
         8oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9m3MRy8x+o4H1EEycml0VyqSiaYH7kBtrQzXfBUS8w=;
        b=bY/MPHcON/9Cyl0dJG7ZISbjSsW7j3kyWOXuAeo8mOG2BGNVF26/Eg6TZ0cWQS0V37
         VrcMTPEoyxsYGMxEJKCcJNfrqQ2sxqW6ZpO+P9XGb/nAnhzmE4IBnRekH+CsFbUJyKYe
         9J/faFROUifUSEPa8sVsCh1jygNKPqistxBtW/5aCkrdCoVmtSacHypaNroSpH7IKP8C
         s97ILkCDoguJ1AM495ZMeHYQ+kmoQWTS88c4eLWct3++ERwaCF30gWG2+4mlH3m2wos/
         sJgC/FhMMaMQnSfHe4CAhT1KkfRLYl6dY88CtLJ1httWDvvyQ+fQKQipLEZozbr70/pa
         huvA==
X-Gm-Message-State: AGi0PuZVzIQHCFRDKr3qm5t0izjp7hRL8ZxIaG8qS824WxDHt9Z8Sj6w
        U8SkI3bI123jpTG4qtfi2KvwxX/w4LaXFXrjKNQOHFjp
X-Google-Smtp-Source: APiQypIBhAroyKy7dbi8XsEqmZkN6GmZp54F8mQFxWhAQGQ6iOUSPlckooO9rwUr3eRUH0h46LenNWSVw4928Sfzm+M=
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr22239047wra.196.1587454299040;
 Tue, 21 Apr 2020 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200413070014.12960-1-zhang.lyra@gmail.com> <20200413070014.12960-2-zhang.lyra@gmail.com>
 <20200420114222.GA14343@lakrids.cambridge.arm.com>
In-Reply-To: <20200420114222.GA14343@lakrids.cambridge.arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 21 Apr 2020 15:31:02 +0800
Message-ID: <CAAfSe-u+wraKLWFK2+oKed_ZzkckP0sFRhMkA5LB-b30CGawOw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] cpuidle: allow idle state to be found as
 deepest state for s2idle only
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

Many thanks for your comments.

On Mon, 20 Apr 2020 at 19:42, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 13, 2020 at 03:00:13PM +0800, zhang.lyra@gmail.com wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add a new flag CPUIDLE_FLAG_S2IDLE to allow c-state to be found as
> > deepest state for s2idle only, so that users can add a new c-state
> > for using s2idle and don't worry disturbing other use cases such as
> > play_idle() which probably don't want to enter into so much deep
> > idle state since devices are not suspended for that kind of cases.
>
> Can you please elaborate on this?

Ok.

The thing was, I added a new c-state (named DOMAIN_PD for example) in
DT for using s2idle, and the target power level indicated in DOMAIN_PD
would be deeper than the level for regular cpuidle (for example
level-0 is for regular cpuidle; level-1 is for system suspend and
power domain would be shutdown as well as all cores , DOMAIN_PD uses
level-1). I worried that would cause the deeper power domain to be
shutdown if DOMAIN_PD was selected by play_idle().

But after have another look at PSCI in ATF, I consider that it
probably is not a problem which would really happen. Since play_idle()
wouldn't occur on all cpus at the same time, although play_idle()
could use DOMAIN_PD, the system wouldn't enter into that so deep power
level.

Hope I've explained the things clearly :)

In a word, this patch seems not needed for now.


Thanks again,
Chunyan


>
> Why exactly are these states not suited for regular cpu idle? What
> problems do they cause? e.g. long wakeup latency?
>
> The flag and the for-s2-idle-only DT property are encoding a policy
> rarher than a property, and as such I don't think this is the right way
> to describe this in the DT. However, if there might be porperties of the
> idle state that we could describe so that the OS can come to the same
> conclusion.
>
> Thanks,
> Mark.
>
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/cpuidle/cpuidle.c        | 3 ++-
> >  drivers/cpuidle/dt_idle_states.c | 3 +++
> >  include/linux/cpuidle.h          | 1 +
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index de81298051b3..bb61f0c271d2 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -89,7 +89,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
> >                   s->exit_latency_ns <= latency_req ||
> >                   s->exit_latency_ns > max_latency_ns ||
> >                   (s->flags & forbidden_flags) ||
> > -                 (s2idle && !s->enter_s2idle))
> > +                 (s2idle && !s->enter_s2idle) ||
> > +                 (!s2idle && (s->flags & CPUIDLE_FLAG_S2ILDE)))
> >                       continue;
> >
> >               latency_req = s->exit_latency_ns;
> > diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> > index 252f2a9686a6..530db2726c05 100644
> > --- a/drivers/cpuidle/dt_idle_states.c
> > +++ b/drivers/cpuidle/dt_idle_states.c
> > @@ -80,6 +80,9 @@ static int init_state_node(struct cpuidle_state *idle_state,
> >       idle_state->flags = 0;
> >       if (of_property_read_bool(state_node, "local-timer-stop"))
> >               idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +
> > +     if (of_property_read_bool(state_node, "for-s2idle-only"))
> > +             idle_state->flags |= CPUIDLE_FLAG_S2ILDE;
> >       /*
> >        * TODO:
> >        *      replace with kstrdup and pointer assignment when name
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index ec2ef63771f0..08da701f74cd 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -78,6 +78,7 @@ struct cpuidle_state {
> >  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> >  #define CPUIDLE_FLAG_UNUSABLE        BIT(3) /* avoid using this state */
> >  #define CPUIDLE_FLAG_OFF     BIT(4) /* disable this state by default */
> > +#define CPUIDLE_FLAG_S2ILDE  BIT(5) /* state is used for s2idle only */
> >
> >  struct cpuidle_device_kobj;
> >  struct cpuidle_state_kobj;
> > --
> > 2.20.1
> >

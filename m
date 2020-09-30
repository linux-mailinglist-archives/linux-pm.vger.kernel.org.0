Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E527EDAD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgI3PoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 11:44:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39786 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3PoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 11:44:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id u25so2261239otq.6
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 08:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjeC5rpY3ogtYfbRV5nQV9QBqwwYTMX7A0W2mjHYHbI=;
        b=dOisB5kVbJLmhGAYctRDSmQiQOi7GFkyB8uuqLYYGmQjUnGYZ+w5xLKhFBAvBoVMX1
         vHuU0gJNN4J/uaIYPE5tn6xNe8OyDsKUGIigcZzJnUqmIa28U5T5PmJdHjVUgpQYhp3c
         dqttKC4uA+9FD7+mbyBvMBYCFXLT+M9HSRKewt45ZjmPmpwtz2HPETzcTPOtyt0uRWhv
         V8lydCP1jt/MUjkIemWNVn4xSqmQkAjN2jyhIHTvXM1KK6+tmBzmW+O5EumSC8Fg4q+e
         yaeUPsJIg+TJX/yHLOgzb74ENCVQqRQU7PnBLra1HkvbF3oPbOo8Ta8teJs6RaQkPMLp
         b2qw==
X-Gm-Message-State: AOAM5311M5w76Uj+su77X0PRxC0S8UYs1+t/yLvUg4wi2UyjpCe+vQRF
        yc8gRYJqk2/lCo/nV+sx4oBki3kW4TogvrMYdOw=
X-Google-Smtp-Source: ABdhPJwyUkCU9l67+54wed74H514qvvOHHcQdnUig8q9sb34USr+toT4z43h9wvod6Jcwq4j37hxxSlO/4UOWnWq/1s=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr1864228otg.118.1601480659995;
 Wed, 30 Sep 2020 08:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200930112023.121821-1-ulf.hansson@linaro.org> <20200930113325.GA2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930113325.GA2628@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:44:09 +0200
Message-ID: <CAJZ5v0g0oOwZfARXfWVcWvv33rWGBhGcHZdJxL1WGPTWOEqPDg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx6q: Fixup RCU usage for cpuidle
To:     Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 30, 2020 at 1:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 30, 2020 at 01:20:23PM +0200, Ulf Hansson wrote:
> > The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
> > expose us for tracepoints. For imx6q cpuidle, this leads to an RCU splat
> > according to below.
> >
> > [6.870684] [<c0db7690>] (_raw_spin_lock) from [<c011f6a4>] (imx6q_enter_wait+0x18/0x9c)
> > [6.878846] [<c011f6a4>] (imx6q_enter_wait) from [<c09abfb0>] (cpuidle_enter_state+0x168/0x5e4)
> >
> > To fix the problem, let's assign the corresponding idlestate->flags the
> > CPUIDLE_FLAG_RCU_IDLE bit, which enables us to call rcu_idle_enter|exit()
> > at the proper point.
> >
> > Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Yep, that looks about right.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6q.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> > index 24dd5bbe60e4..094337dc1bc7 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> > @@ -24,7 +24,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
> >               imx6_set_lpm(WAIT_UNCLOCKED);
> >       raw_spin_unlock(&cpuidle_lock);
> >
> > +     rcu_idle_enter();
> >       cpu_do_idle();
> > +     rcu_idle_exit();
> >
> >       raw_spin_lock(&cpuidle_lock);
> >       if (num_idle_cpus-- == num_online_cpus())
> > @@ -44,7 +46,7 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
> >               {
> >                       .exit_latency = 50,
> >                       .target_residency = 75,
> > -                     .flags = CPUIDLE_FLAG_TIMER_STOP,
> > +                     .flags = CPUIDLE_FLAG_TIMER_STOP | CPUIDLE_FLAG_RCU_IDLE,
> >                       .enter = imx6q_enter_wait,
> >                       .name = "WAIT",
> >                       .desc = "Clock off",
> > --

Applied as 5.9-rc8 material, thanks!

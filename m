Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE9D6B7B7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGQHzW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 03:55:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37362 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGQHzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 03:55:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so24042227otp.4;
        Wed, 17 Jul 2019 00:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH2k1ar00PKs26usVcgRsgrZEYhcLBd9ajfdFKToAbs=;
        b=HMDvr3Drdvp27hXOI4aeLQULbhmqhaaLWZ7EQc7bGlVA688Awzrb07rRd2ZwJ9EjMj
         nV1VGlfPpdFpSAVvYiZLPKdNjr0EY9PlB+iSlxNDTwHcNdxk9aqiO4OBbi2lZ4OsLNfM
         tenghIOn0jutRC3GlQWdM8Mx3FMrgCLKpIK6K3pPSWKrtugNudynRWeH4FsU+atBCIFA
         egCp/JBd/dOMP35N8JtRNHJLDWm/yn2DNxLNXZx6RPIWl/eiRFR7fvNGB9QUQv8z/O6k
         ZyJvTgGCSZIT2bVxThJfEc9rrLzYoPt7sZrR27Q4V/5rmbJQT3XvAUIiL4j8FF1UzldR
         7hYQ==
X-Gm-Message-State: APjAAAUxrTtow8rZPzZ+dQrnOHzYbNBqimQXBcQMmRLd4ER0J7Dobz4d
        cBjamEaYO40BDQfvd8SJ7iZ3srB4+8p/Iq0Si3EnuaJm
X-Google-Smtp-Source: APXvYqzlEtNuhiNzoPrvm4HvombJYRRJCzTTWi3ikgXV0m5bQF2sSaq8Fk7kIkbnac3+vka5gV1vMHciU+mlh4RjJaY=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr29016349otq.262.1563350121302;
 Wed, 17 Jul 2019 00:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <6254683.2O5gIZElE2@kreacher> <20190716214024.GA8345@lenoir>
In-Reply-To: <20190716214024.GA8345@lenoir>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Jul 2019 09:55:08 +0200
Message-ID: <CAJZ5v0gB0AHTebjpp87YKA1wmE+tCw5V=eaRE2XDM3nyQYndnA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 11:40 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Tue, Jul 16, 2019 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Running the scheduler tick on idle adaptive-tick CPUs is not useful
>
> Judging by the below change, you mean full dynticks, right?

Right.

> > and it may also be not expected by users (as reported by Thomas), so
> > add a check to cpuidle_idle_call() to always stop the tick on them
> > regardless of the idle duration predicted by the governor.
> >
> > Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
> > Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/idle.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
> >                */
> >               next_state = cpuidle_select(drv, dev, &stop_tick);
> >
> > -             if (stop_tick || tick_nohz_tick_stopped())
> > +             if (stop_tick || tick_nohz_tick_stopped() ||
> > +                 !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
>
> But tick_nohz_tick_stopped() also works on full dynticks CPUs. If the
> tick isn't stopped on a full dynticks CPU by the time we reach this path,
> it means that the conditions for the tick to be stopped are not met anyway
> (eg: more than one task and sched tick is needed, perf event requires the tick,
> posix CPU timer, etc...)

First of all, according to Thomas, the patch does make a difference,
so evidently on his system(s) the full dynticks CPUs enter the idle
loop with running tick.

This means that, indeed, the conditions for the tick to be stopped
have not been met up to that point, but if the (full dynticks) CPU
becomes idle, that's because it has been made idle on purpose
(presumably by a user-space "orchestrator" or the sysadmin), so the
kernel can assume that it will remain idle indefinitely.  That, in
turn, is when the tick would be stopped on it regardless of everything
else (even if it wasn't a full dynticks CPU).

I guess I should add the above to the changelog.

> Or am I missing something else?

Well, if full dynticks CPUs are expected to always enter the idle loop
with stopped tick, then something appears to be amiss, but I'm not
sure if that expectation is entirely realistic.

Cheers!

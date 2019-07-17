Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667516C32B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfGQW1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:27:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45656 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfGQW1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:27:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so19854164oib.12;
        Wed, 17 Jul 2019 15:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKdCh/T0TvCjAVMnS0S/bH9S/vTC4w+CAFYfC32nDW8=;
        b=mIhmNY8OOmwtMFNU6RpTk6OQ2bxRPWaHGEoYM6ZeeChFB8EPoLmmSQksz7WYM6uBI5
         8ZEUjIDNIM+0UvXGkMjqAN5ezqlWUFOlvCaSsz3ipUWKPCaNulv3Dv0AGS165zzojj3S
         fLXCSnTVcNff2I4BqEmTr8RNdWBEbNHMl9UyxD+mtgRbsiaIRkJUbTUcUWRwvLmqi46m
         1QTM6AtPHy6p9wYsnSD5tWSUwZWZOdsvOVCUq/02KzvJnmmQfyN48TclShPXbygr1cAX
         FEumu/fwVZgSaniXZCKlbzzN8lRx/CIcnN7aQaNZWcqpAXXoMuEk6eyhhI9KYvwz72Sb
         /pww==
X-Gm-Message-State: APjAAAUzqY/mrwjEH1g80wF3vsZHauBbdEZENBYZ3GNDIuC1f+HF8bO6
        4yaV0qfaWnSi4cVNbQtKcA4oC9Sy1QxxtOk0ZaQ=
X-Google-Smtp-Source: APXvYqxjF6AUD3helldHpsLA2ynZmGMJJif5IvIahrbl69j2lcbFNCAcru7gRAkBWEUHYm+zLKJK8RxSzHAFHKW/TCg=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr20926358oih.103.1563402441139;
 Wed, 17 Jul 2019 15:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <6254683.2O5gIZElE2@kreacher> <20190716214024.GA8345@lenoir>
 <CAJZ5v0gB0AHTebjpp87YKA1wmE+tCw5V=eaRE2XDM3nyQYndnA@mail.gmail.com> <20190717132115.GB8345@lenoir>
In-Reply-To: <20190717132115.GB8345@lenoir>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Jul 2019 00:27:09 +0200
Message-ID: <CAJZ5v0icfumJc7E4+LgWpi3+UNpTsH4usAJOg4FEeCBptYYzUQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 3:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Jul 17, 2019 at 09:55:08AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2019 at 11:40 PM Frederic Weisbecker
> > <frederic@kernel.org> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Running the scheduler tick on idle adaptive-tick CPUs is not useful
> > >
> > > Judging by the below change, you mean full dynticks, right?
> >
> > Right.
> >
> > > > and it may also be not expected by users (as reported by Thomas), so
> > > > add a check to cpuidle_idle_call() to always stop the tick on them
> > > > regardless of the idle duration predicted by the governor.
> > > >
> > > > Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
> > > > Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > > > Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  kernel/sched/idle.c |    3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > Index: linux-pm/kernel/sched/idle.c
> > > > ===================================================================
> > > > --- linux-pm.orig/kernel/sched/idle.c
> > > > +++ linux-pm/kernel/sched/idle.c
> > > > @@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
> > > >                */
> > > >               next_state = cpuidle_select(drv, dev, &stop_tick);
> > > >
> > > > -             if (stop_tick || tick_nohz_tick_stopped())
> > > > +             if (stop_tick || tick_nohz_tick_stopped() ||
> > > > +                 !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
> > >
> > > But tick_nohz_tick_stopped() also works on full dynticks CPUs. If the
> > > tick isn't stopped on a full dynticks CPU by the time we reach this path,
> > > it means that the conditions for the tick to be stopped are not met anyway
> > > (eg: more than one task and sched tick is needed, perf event requires the tick,
> > > posix CPU timer, etc...)
> >
> > First of all, according to Thomas, the patch does make a difference,
> > so evidently on his system(s) the full dynticks CPUs enter the idle
> > loop with running tick.
> >
> > This means that, indeed, the conditions for the tick to be stopped
> > have not been met up to that point, but if the (full dynticks) CPU
> > becomes idle, that's because it has been made idle on purpose
> > (presumably by a user-space "orchestrator" or the sysadmin), so the
> > kernel can assume that it will remain idle indefinitely.  That, in
> > turn, is when the tick would be stopped on it regardless of everything
> > else (even if it wasn't a full dynticks CPU).
>
> Well I think we disagree on that assumption that if a nohz_full CPU is put
> idle, it will remain there indefinitely. Nohz_full CPUs aren't really special
> in this regard, they can sleep on an IO, wait for a short event just like
> any other CPU.

Fair enough.

This means that the governor (or rather governors) will need to be
modified to address the issue reported by Thomas.

Fortunately, I have a patch going in that direction too. :-)

Cheers!

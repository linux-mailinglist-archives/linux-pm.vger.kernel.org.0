Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AFC1CF244
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELKZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 06:25:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39355 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELKZb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 06:25:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id b18so17770891oic.6;
        Tue, 12 May 2020 03:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJA+CSUUeulPKUWaZTIkg+AKeXhyhy6/pqCXSNlbPQk=;
        b=n4wodyKwBxlAStQfR46jgVrGm4T92JBdztQ5wU7wYB8+Y96WyML1EufPRZLozGWeMI
         XyzIjad1nHLmUlAyXxoS1VpaCWxPFs/E10eddzt3wS734Mjx4AGMt3/F1QQvJK4gSwb9
         jTK1ldZXR8qIYI99mMyjn1gLjDoqMAa8e8BEj69l1ZeIonE+P5O3iIl3HV86sJfAaBn4
         QhMN4dgX1FnJu6EOmHUkaBraw+FhbVB4n9p4vO3Vpn01eA+y27YdGMdL/FpDdspmnuK1
         tg4UwAizfjIWJRDylSPqZbww7HnYq94+j/6ZINsDRY2Zn3+yeShBcjmwC/xZLIGmqR2A
         sQ8Q==
X-Gm-Message-State: AGi0PuZVFmahwTOAe6gyZv6GXaKR4Skm/IABkOVkNRfUN37rtWxwTC0R
        +gyyD1bRNh8mfZx95mGUafZ/2PpjHTVwdabTous=
X-Google-Smtp-Source: APiQypIFgb8NNQyeYQ0k1Vg8pPKIj+36cBweV8fqY7PA9w8/4A0Q2u+zI9TbnrUsrezSgvRPvU80DO4waoJJXgmXphs=
X-Received: by 2002:aca:c441:: with SMTP id u62mr23686655oif.110.1589279128346;
 Tue, 12 May 2020 03:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com> <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com> <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net> <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com> <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
In-Reply-To: <20200512092102.GA16151@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 May 2020 12:25:17 +0200
Message-ID: <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 11:21 AM Quentin Perret <qperret@google.com> wrote:
>
> Hi Rafael,
>
> On Monday 11 May 2020 at 17:26:26 (+0200), Rafael J. Wysocki wrote:
> > On Mon, May 11, 2020 at 11:00 AM Quentin Perret <qperret@google.com> wrote:
> > > The base idea is, anything that we know from experience is used by
> > > everybody can be built in, anything else will need investigation. And as
> > > you've understood, schedutil falls in that second category.
> >
> > The fact that the vendor sets up a different governor by default
> > doesn't mean that there should be no way to switch over to schedutil
> > IMO.
>
> Well, there will always be the option to load the schedutil module ;-)

Yeah, fair enough.

> <snip>
> > > the reason that dependency was added originally was
> > >    because sugov was the only place where util clamps where taken into
> > >    accounts. But that is no longer true -- we check them in the capacity
> > >    aware wake-up path as well, which is entirely independent from the
> > >    currently running governor;
> >
> > But this is done under the assumption that the governor will also take
> > the clamps into account, isn't it?
>
> Even if that was correct, it's not clear a compile-time dependency makes
> that assumption true, right?

It indicates that the functional dependency is there if you will.

Otherwise it would be kind of hidden and likely to become confusing.

> For governors and the like, if the option is =n, then you can hard-rely
> on it not being used. But if it is =y, you cannot assume anything
> what-so-ever. EAS does a run-time check for that exact reason -- a
> sole Kconfig dependency typically doesn't work for that.

Obviously Kconfig dependencies cannot replace runtime checks, but OTOH
the latter are guaranteed to fail if the given piece of code is not
there in the kernel even.

> > Otherwise you can see your "low util" tasks running at high
> > frequencies and "high util" ones running slowly.  Surely, that's not
> > desirable?
> >
> > IIUC, the task placement needs to be consistent with the governor's
> > decisions for things to work as expected.
>
> Sure, but, say, the 'performance' governor could give you some of that too.

Well, kind of, and the 'powersave' governor can do that too in theory.

> That is, you could use uclamp.min on some tasks to ensure they are
> biased to bigger CPUs, and just stick the frequency to max. I wouldn't
> be surprised to see setups like that on non-battery-powered devices for
> instance. And yes, there are non-battery-powered devices that use big
> little out there (TVs and such, often because the only SOCs matching
> their requirements are mobile SOCs).

I would not conflate the use cases for uclamps and big-little.

Anyway, there are some cases in which using uclamps without schedutil
might make theoretical sense, but I'm not sure how useful that would
be in practice.

> > >  - because of the above, it is (now) largely useless: a compile time
> > >    dependency doesn't guarantee we are actually running with schedutil
> > >    at all;
> > >  - it is artificial: there are no actual compilation dependencies
> > >    between sugov and uclamp, everything will compile just fine without
> > >    that 'depends on';
> >
> > That actually is the case, but it doesn't mean that there is no
> > dependency in there.
>
> Sure, and the dependency did make sense when uclamp was first introduced.
> At the time, the clamp values where used _only_ in schedutil. So, it
> was fair to say "if schedutil is =n, there is no way the clamps will ever
> be useful to anything else, so the uclamp code can be safely compiled
> out". That is no longer true, and if you want to make uclamp work only
> with schedutil (which I would advise against for the above reason), then
> a Kconfig dependency doesn't seem to be the right tool for that anyway.

Still, IMO it would be fair to say that if uclamps are used, schedutil
is very likely to be preferred.

Kconfig can be made select schedutil when enabling uclamps or similar
to express that preference.

> > > Or maybe you were thinking of something else?
> > >
> > > > > That of course is only true if we can
> > > > > agree on a reasonable set of exported symbols, so I'll give others some
> > > > > time to complain and see if I can post a v2 addressing these issues!
> > > >
> > > > This isn't just about exported symbols, it is about what is regarded
> > > > as essential and what isn't.
> > >
> > > Right, the exported symbols are, IMO, quite interesting because they
> > > show how 'core' the governor is. But what exactly do you mean by
> > > 'essential' here? Essential in what sense?
> >
> > IMO the question is how much value there is in making it possible to
> > avoid loading a particular piece of kernel code into memory.
> >
> > You've demonstrated that it can be done with schedutil, but does that
> > matter that it needs to be done?
> >
> > I thought that the original idea was to make it closely integrated
> > with the scheduler, so it could access the scheduler's data structures
> > (that we specifically didn't want to expose to the *other* governors)
> > and so as to avoid forgetting about any dependencies when making
> > changes to either the scheduler or schedutil.  Allowing it to be build
> > as a module would make make us have to worry about those things again,
> > so is it really worth it?
>
> Right, so, if there is a strong technical reason to keep schedutil a
> bool option (such as accessing data structures we really don't want to
> export),

The bool option is the status quo and there needs to be a strong
technical reason to allow it to be modular (as that would cause the
complexity to increase).

> then sure, I'll have no choice but to accept it. Now, assuming
> that I fix the usage of 'runqueues', is there anything in particular
> that you think is wrong in the series?

Well, define "wrong". :-)

Some pieces of the series look like general improvements, but some of
them don't.

And the fact that something can be done alone should not be regarded
as a good enough reason for doing it in my view.

> Note that if one day keeping schedutil modular becomes a blocker for a
> new feature, then we'll have the option to make it bool again. But is
> there something like that already?

Putting it this way isn't entirely fair IMO.

What you are proposing is basically to add complexity and the reason
for doing that seems to be convenience (and that's not the users'
convenience for that matter) which is not really super-convincing.

Cheers!

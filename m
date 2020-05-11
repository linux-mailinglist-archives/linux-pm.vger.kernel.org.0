Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1A1CDEF0
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgEKP0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 11:26:39 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:36977 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEKP0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 11:26:38 -0400
Received: by mail-oo1-f67.google.com with SMTP id v6so2014419oou.4;
        Mon, 11 May 2020 08:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqxtbamSYrDjCiG2Sa6OgrEIPkjy0PKI+7BZGr9gIXA=;
        b=dSJWE3o7H3iyfv2Y+1fp/rjzUXH5SEiIwtE+bblrmTVtKZ4vG2ITnohZjUNPAMmvq/
         nx+z6ZF18pIbx29+/XGM5n1JCc1MpkC7Tpm2A/2FjmimEA3jT+tWXmIjYk/9kxe0t6EU
         dPFTQtlujbEcDWFGdtE71DwY0hoj01SH6NiESXwTQ2RrDZDgdJ1G2AyeJIvwBRvIPbUr
         WOfcuFIV2E4DhACbCrDsxDuLwQz0CdJ9fdGQerHbHt+UBhLNmgOzIjQL4RONYGb+50CJ
         jySh7we8uPp9qz7TRPYc/s4pQ7oPhdzFIp73p7zifFOfrerNn6huHDomr6nrt3Q3oLu/
         0hOA==
X-Gm-Message-State: AGi0PuYwZjXxNf4/krVwsqLdEQUQ4sPoMGqnIrxEY7GgL1mRxJETeoZW
        c238JVb20C96Di/F9D2M5FbTsDhAqhSCcGZqhTY=
X-Google-Smtp-Source: APiQypLq5jwWsqunJB5ifvHoh9oneaKxF7zKbKuAepuLszChzT3ZWyMlvRfbS+itaggAC9KM0ZNU+FCjePlLSSduPko=
X-Received: by 2002:a4a:d204:: with SMTP id c4mr2387438oos.1.1589210797413;
 Mon, 11 May 2020 08:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com> <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com> <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net> <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com> <20200511090049.GA229633@google.com>
In-Reply-To: <20200511090049.GA229633@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 May 2020 17:26:26 +0200
Message-ID: <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
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

On Mon, May 11, 2020 at 11:00 AM Quentin Perret <qperret@google.com> wrote:
>
> Hi Rafael,
>
> On Friday 08 May 2020 at 15:40:34 (+0200), Rafael J. Wysocki wrote:
> > On Fri, May 8, 2020 at 3:05 PM Quentin Perret <qperret@google.com> wrote:
> > >
> > > On Friday 08 May 2020 at 13:31:41 (+0200), Peter Zijlstra wrote:
> > > > On Fri, May 08, 2020 at 12:16:12PM +0100, Quentin Perret wrote:
> > > > > However, the point I tried to make here is orthogonal to that. As of
> > > > > today using another governor than schedutil is fully supported upstream,
> > > > > and in fact it isn't even enabled by default for most archs. If vendors
> > > > > feel like using something else makes their product better, then I don't
> > > > > see why I need to argue with them about that. And frankly I don't see
> > > > > that support being removed from upstream any time soon.
> > > >
> > > > Right, it'll take a while to get there. But that doesn't mean we
> > > > shouldn't encourage schedutil usage wherever and whenever possible. That
> > > > includes not making it easier to not use it.
> > > >
> > > > In that respect making it modular goes against our ultimate goal (world
> > > > domination, <mad giggles here>).
> > >
> > > Right, I definitely understand the sentiment. OTOH, things like that
> > > give vendors weapons against GKI ('you-force-us-to-build-in-things-we-dont't-want'
> > > etc etc). That _is_ true to some extent, but it's important we make sure
> > > to keep this to an absolute minimum, otherwise GKI just won't happen
> > > (and I really think that'd be a shame, GKI _is_ a good thing for
> > > upstream).
> > >
> > > And sure, schedutil isn't that big, and we can make an exception. But
> > > I'm sure you know what happens when you starting making exceptions ;)
> >
> > This is a very weak argument, if it can be regarded as an argument at all.
>
> Well, fair enough :)
>
> > You will have to make exceptions, the question is how many and on what
> > criteria and you really need to figure that out for the GKI plan.
>
> The base idea is, anything that we know from experience is used by
> everybody can be built in, anything else will need investigation. And as
> you've understood, schedutil falls in that second category.

The fact that the vendor sets up a different governor by default
doesn't mean that there should be no way to switch over to schedutil
IMO.

> > > So, all in all, I don't think the series actively makes schedutil worse
> > > by adding out-of-line calls in the hot path or anything like that, and
> > > having it as a module helps with GKI which I'm arguing is a good thing
> > > in the grand scheme of things.
> >
> > Frankly, I'm not sure if it really helps.
>
> Oh, why not?
>
> > The idea of making schedutil modular seems to be based on the
> > observation that it is not part of the core kernel, which I don't
> > agree with.
>
> Right, so that I think is the core of the discussion.
>
> > Arguably, things like util clamps need it to work as
> > expected.
>
> Sure, but loading sugov dynamically as a module doesn't change much does
> it?
>
> If you are referring to the Kconfig dependency of uclamp on schedutil,
> then that is a good point and I will argue that it should be removed.
> In fact I'll add a patch to v2 that does just that, with the following
> rationale:

Which isn't correct AFAICS.

>  - it is obsolete:

No, it isn't IMO.

> the reason that dependency was added originally was
>    because sugov was the only place where util clamps where taken into
>    accounts. But that is no longer true -- we check them in the capacity
>    aware wake-up path as well, which is entirely independent from the
>    currently running governor;

But this is done under the assumption that the governor will also take
the clamps into account, isn't it?

Otherwise you can see your "low util" tasks running at high
frequencies and "high util" ones running slowly.  Surely, that's not
desirable?

IIUC, the task placement needs to be consistent with the governor's
decisions for things to work as expected.

>  - because of the above, it is (now) largely useless: a compile time
>    dependency doesn't guarantee we are actually running with schedutil
>    at all;
>  - it is artificial: there are no actual compilation dependencies
>    between sugov and uclamp, everything will compile just fine without
>    that 'depends on';

That actually is the case, but it doesn't mean that there is no
dependency in there.

> Or maybe you were thinking of something else?
>
> > > That of course is only true if we can
> > > agree on a reasonable set of exported symbols, so I'll give others some
> > > time to complain and see if I can post a v2 addressing these issues!
> >
> > This isn't just about exported symbols, it is about what is regarded
> > as essential and what isn't.
>
> Right, the exported symbols are, IMO, quite interesting because they
> show how 'core' the governor is. But what exactly do you mean by
> 'essential' here? Essential in what sense?

IMO the question is how much value there is in making it possible to
avoid loading a particular piece of kernel code into memory.

You've demonstrated that it can be done with schedutil, but does that
matter that it needs to be done?

I thought that the original idea was to make it closely integrated
with the scheduler, so it could access the scheduler's data structures
(that we specifically didn't want to expose to the *other* governors)
and so as to avoid forgetting about any dependencies when making
changes to either the scheduler or schedutil.  Allowing it to be build
as a module would make make us have to worry about those things again,
so is it really worth it?

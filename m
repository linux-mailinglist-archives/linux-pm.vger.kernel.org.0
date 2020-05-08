Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F351CB0A1
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEHNks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:40:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41849 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHNks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:40:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so1447160otp.8;
        Fri, 08 May 2020 06:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQ5rrPXnNsDJ/WKPpWYcGWcn8h/Vyzx3Fiwbz3aL0Q8=;
        b=fA2acA0tM3srqwRoEXpufC16AGCSpBIhRttPafUm6kGMtEadey4WmWxZLNv+3y1TWx
         lncYQMLAWA6APEnIMRfVJAlHeO3BWajb6dzBUf0JafjFTdcsuYBNagKITfrVQrWu9834
         1tQ7Mn/AbewUTTsLES89M64AyKZhLB3erzlxOu5vF2JySRN/4kGo86C0OMyIRHw7z+Ft
         77oF5A6JwAyMSLTL4jll7VIOo6HLRrmoL4uPAIp1HQEPl74syGDkF6tt5RzCGe4CKiYC
         Gg0lLKERE8XcN0YP+NjtralTCALbaRH4+JZfA9sE3gF/gp8MCfer6YTZfEeHhcciJxt4
         ja/A==
X-Gm-Message-State: AGi0PuZ4+BGDClNBHjDELHY/WOi3WwZ8GULWAm09MvBSbOOsDkoGhfWa
        CWgaS9Qy5HvEm6e7ikJsozVfviffJau8l7muDYo=
X-Google-Smtp-Source: APiQypJA9IMsK7mzrP/u+Y+Xp7AHp33aTr3EgQFh9Cr4gJdviGfw3LhQPhNVdfcnqN/5ainRzCGCDcapJqzzJ7MJVqA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr2125697oto.118.1588945246489;
 Fri, 08 May 2020 06:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com> <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com> <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net> <20200508130507.GA10541@google.com>
In-Reply-To: <20200508130507.GA10541@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 May 2020 15:40:34 +0200
Message-ID: <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
To:     Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, yzaikin@google.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 8, 2020 at 3:05 PM Quentin Perret <qperret@google.com> wrote:
>
> On Friday 08 May 2020 at 13:31:41 (+0200), Peter Zijlstra wrote:
> > On Fri, May 08, 2020 at 12:16:12PM +0100, Quentin Perret wrote:
> > > However, the point I tried to make here is orthogonal to that. As of
> > > today using another governor than schedutil is fully supported upstream,
> > > and in fact it isn't even enabled by default for most archs. If vendors
> > > feel like using something else makes their product better, then I don't
> > > see why I need to argue with them about that. And frankly I don't see
> > > that support being removed from upstream any time soon.
> >
> > Right, it'll take a while to get there. But that doesn't mean we
> > shouldn't encourage schedutil usage wherever and whenever possible. That
> > includes not making it easier to not use it.
> >
> > In that respect making it modular goes against our ultimate goal (world
> > domination, <mad giggles here>).
>
> Right, I definitely understand the sentiment. OTOH, things like that
> give vendors weapons against GKI ('you-force-us-to-build-in-things-we-dont't-want'
> etc etc). That _is_ true to some extent, but it's important we make sure
> to keep this to an absolute minimum, otherwise GKI just won't happen
> (and I really think that'd be a shame, GKI _is_ a good thing for
> upstream).
>
> And sure, schedutil isn't that big, and we can make an exception. But
> I'm sure you know what happens when you starting making exceptions ;)

This is a very weak argument, if it can be regarded as an argument at all.

You will have to make exceptions, the question is how many and on what
criteria and you really need to figure that out for the GKI plan.

> So, all in all, I don't think the series actively makes schedutil worse
> by adding out-of-line calls in the hot path or anything like that, and
> having it as a module helps with GKI which I'm arguing is a good thing
> in the grand scheme of things.

Frankly, I'm not sure if it really helps.

The idea of making schedutil modular seems to be based on the
observation that it is not part of the core kernel, which I don't
agree with.  Arguably, things like util clamps need it to work as
expected.

> That of course is only true if we can
> agree on a reasonable set of exported symbols, so I'll give others some
> time to complain and see if I can post a v2 addressing these issues!

This isn't just about exported symbols, it is about what is regarded
as essential and what isn't.

Cheers!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634581CF67D
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgELOJL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 10:09:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43257 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELOJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 10:09:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id a68so2069586otb.10;
        Tue, 12 May 2020 07:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlLg66om9qePZXeASi6fwsBTwuJ8dfQeSI2ucy4Tfaw=;
        b=i9SaClcqX8A0nYi/p1xB3lptVwUFTpWevNUsQwd2d2M4MvDWFweIyh/QEZIUpUmiQQ
         O6RQcNqFwDc9nG2JLtjIEcQSTwZGHtekKXOz37LH9VXKBZoJV0gxnyxIExW6ABCJkJHb
         jYmh+DelMCS0UdilEcr2DSlY4HaQX+n4q5fZTA3C5gDjAVg/ZzFscZjJc4RSm34Oj0G+
         mWz0mYyTVLg5r2KgqF8Ze4LCWqJXJRYq15ghnDD4r1FATqDasDTvCeTWfdTqfS3yDPN4
         UotzLWAVoJMkXdDsFSlEEnUX/0+8vc/mKM7PzxF3aqIqJp9rsko9wcvqFdPmBJEAYV5I
         VT9g==
X-Gm-Message-State: AGi0Pubvq3rpq9Tlky6liYyQksOqOmNRE7F4Gh1BgHQ8/70nQtmno4Hv
        Yv7MLvVRXUPvEu1QlHEQkwMY9nWjjoXuKzXuGWo=
X-Google-Smtp-Source: APiQypLSjiwX7PHp/boQvrrT9A2LLBsxN4GgnX7T8BCX5CQ4Qti5EIdMckwEZSBnSBOrvY/RjAqINo6HDSkgtHeujTs=
X-Received: by 2002:a9d:6356:: with SMTP id y22mr3701328otk.167.1589292548150;
 Tue, 12 May 2020 07:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com> <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net> <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com> <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com> <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
In-Reply-To: <20200512135813.GA101124@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 May 2020 16:08:56 +0200
Message-ID: <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
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

On Tue, May 12, 2020 at 3:58 PM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 12 May 2020 at 12:25:17 (+0200), Rafael J. Wysocki wrote:
> > Still, IMO it would be fair to say that if uclamps are used, schedutil
> > is very likely to be preferred.
> >
> > Kconfig can be made select schedutil when enabling uclamps or similar
> > to express that preference.
>
> Right, fair enough. Making schedutil default to y when uclamp is
> compiled in should do the trick (and avoid using 'select'). Would that
> work for you?

I think so.

> > What you are proposing is basically to add complexity and the reason
> > for doing that seems to be convenience (and that's not the users'
> > convenience for that matter) which is not really super-convincing.
>
> Forcing our users to build in their products something they don't want
> to use tends to be a very real problem for what we're trying to achieve,
> so it's certainly not just convenience from our perspective. I can
> understand that yours might be different, though.

I would like to understand the nature of the problem here.

If some piece of kernel code is modular, it still needs to be build.
The difference is when and how it gets loaded, so can you possibly
elaborate here?

Cheers!

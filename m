Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA02667A5
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgIKMRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 08:17:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40509 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgIKMQp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 08:16:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id t76so9215746oif.7;
        Fri, 11 Sep 2020 05:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBfOLxbTh4kTcMU0r+KJNNeHONrOwn+AtKnHRK+5TXU=;
        b=IwwZ9mW6Cg8dMSfG6X/YyXcgLl7O0heJkrmFSl9C+xWrLeS0aienU/aXSCDdpJpjW0
         veBTIMMvjrkbZFUI9mg0ywFNHaD3LpUFOlGSVlhV1mIGGG/bWmg46qUmYzHM0vNDKZYU
         moYXkzR0R/YRye678xqGTsg1KN//L6fQA8iU/oEZdkYnJ7TgAgcBaGZPJO5h6QlrmflL
         b0ksbW8nb4AAiOoD+ijAB9HOv5i/Gt94X0ZZqdcnhqUESEBbo1OS7LsiRJSnkxOeZdyJ
         GsQt+1D+9zzFgvHRvNv9LAFcP3td4oKPpdbB0VeW2onvUaWX47d0E9/IcAYF/AAB2JqM
         EqGw==
X-Gm-Message-State: AOAM533a2HdOP61SN1NBLlsfbihdAsGxMF1xr5+WfEENvHqs2H0//VfK
        ooPQL0TwhOg/1L855oVo9xZOjf3baHwU625QuT8=
X-Google-Smtp-Source: ABdhPJyCIAiCP8bbq24FgT0dntTldnj2QIOFwDjxpv+NiUuYcZ7IoSH6KvhpsQgj7qzed9PFFnbzWoMXH4Nd1Uy3JcE=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr1136907oia.110.1599826604003;
 Fri, 11 Sep 2020 05:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599031227.git.viresh.kumar@linaro.org> <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
 <20200911101132.GC165568@hirez.programming.kicks-ass.net> <20200911113532.zq2bou4swixb2ymk@vireshk-i7>
In-Reply-To: <20200911113532.zq2bou4swixb2ymk@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Sep 2020 14:16:33 +0200
Message-ID: <CAJZ5v0jt2ZyXB=2QAB0snC2XQ1N2TUjZGZjJ9vCDdAQHQ+3DpA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-09-20, 12:11, peterz@infradead.org wrote:
> > On Wed, Sep 02, 2020 at 12:54:41PM +0530, Viresh Kumar wrote:
> > > +   atomic_t reset_pending;
> >
> > > +   atomic_set(&stats->reset_pending, 0);
> > > +   if (atomic_read(&stats->reset_pending))
> > > +   bool pending = atomic_read(&stats->reset_pending);
> > > +   atomic_set(&stats->reset_pending, 1);
> > > +   bool pending = atomic_read(&stats->reset_pending);
> > > +   if (atomic_read(&stats->reset_pending))
> >
> > What do you think atomic_t is doing for you?
>
> I was trying to avoid races while two writes are going in parallel,
> but obviously as this isn't a RMW operation, it won't result in
> anything for me.
>
> Maybe what I should be doing is just READ_ONCE()/WRITE_ONCE()? So the
> other side doesn't see any intermediate value that was never meant to
> be set/read ?

If the value in question is a pointer or an int (or equivalent),
READ_ONCE()/WRITE_ONCE() should be sufficient, and should be used at
least as a matter of annotation of the sensitive code IMO.

IIRC, atomic_set() and atomic_read() are pretty much the same as
WRITE_ONCE() and READ_ONCE(), respectively, anyway.

Cheers!

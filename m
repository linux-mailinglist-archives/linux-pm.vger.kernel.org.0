Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFF39B75E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDLAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFDLAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:00:23 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD378C06174A
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 03:58:36 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f1so5018554uaj.10
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4Bnxcztr/Z2l0QnP3ZcryrS+HQHmbGidA9Jx0n1Vxs=;
        b=Ai5C1JCPZZ75LG50Zxt7M0rUuIMYWFOC2aCjMkIO0zcK7ZvHKZU+LS0FqMnhN4V/Lw
         b6mDFiRhlcpzn4uGt+RJ4jFv0GVaSs81Z4tRMR327F3Dpw5NDSYRU/vcrvnM24ZdfSQf
         1DHz3Md9jYrIigOeYuHFMqJWW826MTL08FWLXNyMTCBfFMJ3wy3CSJ1rG6/i+xT5r1uW
         08cfzm+PjhworC4lPZ6DbeePRjJcv6xZO+GoSVqPVFQHVwbWTU8ROMfMZBZ9i0X9KkCi
         P/zrG8/Nj+WvsYImoBp7LmXWKH5xuQYPtB7G8TtkE7D9t0aq2xQaXd+c3/2nEgCeoF/W
         BBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4Bnxcztr/Z2l0QnP3ZcryrS+HQHmbGidA9Jx0n1Vxs=;
        b=qiI6+aO6Xzm8A1sNw9ym5TIwuZ8R07ytV/Axu74QU2ncs8NjBxzbzEOCb+U9RHqsQn
         9QDOVqj6t00nTzsiX5Ni8D9bXG7vS23s5ZZJWhKlVWz3Hk6UlCNqD1w2xnGcIALIUWCU
         AEi7YvllEElReiYvGa4KMwUyk3qlEAv+Yggk579IEfBzKeGjMVVS85Dd9DHiAQU7Iu8k
         Luq7L93tO7x9yxVTuuS3qAsdzRsrIUe7uTq3comj1+rtfy53+C30S6QujL0u3xUDzsBm
         uP+/hzBFqe7GlylPV9NkvxcIyJZK3kJcdSc+D1sJ30I8QKS8c7lkALNUbgAwJSTMqsk3
         cbsA==
X-Gm-Message-State: AOAM531stlO9CNoM9xBoWwugj3JV1nt4LCHfRxN4KsDLg9UW2wGm73iu
        HmLoltACPhzTjlM8Cj5eRc2jzHZZ2hH90wWeRHBgQg==
X-Google-Smtp-Source: ABdhPJw/iEJNXHnMZLMWHaMDYBDuRCRgkGAcG6MmcbbIIpvdDWQ4Lq4CYbL+i2S5DM/0UJugwNi3LG4vdjI3zNGS0rI=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr2525376uak.104.1622804315738;
 Fri, 04 Jun 2021 03:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <YLi5N06Qs+gYHgYg@gerhold.net> <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
 <YLkOAyydZMnxkEy+@gerhold.net> <CAPDyKFpaKkeyOpP7iW8-WG7DLs6Gd1eD2KO3pDYrVQ3z88zFJQ@mail.gmail.com>
 <YLni830rOJWy1NRU@gerhold.net>
In-Reply-To: <YLni830rOJWy1NRU@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 12:57:59 +0200
Message-ID: <CAPDyKFr7iRA+FmrJuDJVPVLcC7j=3LU7VdBwqZqxWEc25SssMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in subsystem/drivers
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 4 Jun 2021 at 10:23, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Fri, Jun 04, 2021 at 09:18:45AM +0200, Ulf Hansson wrote:
> > On Thu, 3 Jun 2021 at 19:16, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > On Thu, Jun 03, 2021 at 05:27:30PM +0200, Ulf Hansson wrote:
> > > > On Thu, 3 Jun 2021 at 13:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > > I think this might also go into the direction of my problem with the OPP
> > > > > core for CPU DVFS [1] since the OPP core currently does not "power-on"
> > > > > the power domains, it just sets a performance state. I got kind of stuck
> > > > > with all the complexity of power domains in Linux so I think we never
> > > > > solved that.
> > > >
> > > > Hmm, that issue is in a way related.
> > > >
> > > > Although, if I understand correctly, that was rather about at what
> > > > layer it makes best sense to activate the device (from runtime PM
> > > > point of view). And this was needed due to the fact that the
> > > > corresponding genpd provider, requires the PM domain to be power on to
> > > > allow changing a performance state for it. Did I get that correct?
> > > >
> > >
> > > Yes, mostly. But I guess I keep coming back to the same question:
> > >
> > > When/why does it make sense to vote for a "performance state" of
> > > a power domain that is or might be powered off?
> > >
> > > "Powered off" sounds like the absolutely lowest possible performance
> > > state to me, it's just not on at all. And if suddenly a device comes and
> > > says "I want performance state X", nothing can change until the power
> > > domain is also "powered on".
> > >
> > > I think my "CPU DVFS" problem only exists because in many other
> > > situations it's possible to rely on one of the following side effects:
> > >
> > >   1. The genpd provider does not care if it's powered on or not.
> > >      (i.e. it's always-on or implicitly powers on if state > 0).
> > >   2. There is some other device that votes to keep the power domain on.
> > >
> > > And that's how the problem relates to my comment for this patch series ...
> > >
> > > >
> > > > >
> > > > > Do I understand your patch set correctly that you basically make the
> > > > > performance state votes conditional to the "power-on" vote of the device
> > > > > (which is automatically toggled during runtime/system PM)?
> > > >
> > > > The series can be considered as a step in that direction, but no, this
> > > > series doesn't change that behaviour.
> > > >
> > > > Users of dev_pm_genpd_set_performance_state() are still free to set a
> > > > performance state, orthogonally to whether the PM domain is powered on
> > > > or off.
> > > >
> > > > >
> > > > > If yes, I think that's a good thing. It was always really confusing to me
> > > > > that a device can make performance state votes if it doesn't actually
> > > > > want the power domain to be powered on.
> > > >
> > > > I share your view, it's a bit confusing.
> > > >
> > > > Just adding the condition internally to genpd to prevent the caller of
> > > > dev_pm_genpd_set_performance() from succeeding to set a new state,
> > > > unless the genpd is powered on, should be a rather simple thing to
> > > > add.
> > > >
> > > > However, to change this, we first need to double check that all the
> > > > callers are making sure they have turned on the PM domain (typically
> > > > via runtime PM).
> > > >
> > >
> > > ... because if performance state votes would be conditional to the
> > > "power-on" vote of the device, it would no longer be possible
> > > to rely on the side effects mentioned above. So this would most
> > > certainly break some code that (incorrectly?) relies on these side
> > > effects, but would also prevent such code.
> >
> > Right. I understand your point and I am open to discuss an
> > implementation. Although, I suggest we continue that separately from
> > the $subject series.
> >
> > >
> > > My (personal) feeling so far is that just dropping performance votes
> > > during runtime/system suspend just makes the entire situation even more
> > > confusing.
> >
> > Well, that's what most subsystems/drivers need to do.
> >
> > Moreover, we have specific devices that only use one default OPP [1].
> >
> > >
> > > > >
> > > > > What happens if a driver calls dev_pm_genpd_set_performance_state(...)
> > > > > while the device is suspended? Will that mess up the performance state
> > > > > when the device resumes?
> > > >
> > > > Good question. The idea is:
> > > >
> > > > If genpd in genpd_runtime_suspend() are able to drop an existing vote
> > > > for a performance state, it should restore the vote in
> > > > genpd_runtime_resume(). This also means, if there is no vote to drop
> > > > in genpd_runtime_suspend(), genpd should just leave the vote as is in
> > > > genpd_runtime_resume().
> > > >
> > >
> > > But the next time the device enters runtime suspend that vote would be
> > > dropped, wouldn't it? That feels kind of strange to me.
> >
> > What do you mean by "next time"?
> >
>
> Basically just like:
>
>   <device runtime-suspended>
>   driver does dev_pm_genpd_set_performance_state(...)
>     - performance state is applied immediately, even though device does
>       apparently not actually want the power domain to be powered on
>   <device runtime resumes>
>     - performance state is kept
>   <device runtime suspends>
>     - performance state is dropped

Yep, this is what would happen.

>   ...
>
> I'm not saying this example makes sense (it doesn't for me). It doesn't
> make sense to vote for a performance state while runtime suspended.
>
> But with this patch series we still allow that, and it will kind of
> produce inconsistent behavior that the performance state is applied
> immediately, even though the device is currently runtime-suspended.
> But once it runtime suspends again, suddenly it is dropped.

Yes.

Note that, I have been looking at the existing callers of
dev_pm_genpd_set_performance_state() in the kernel as of today. It
should not be an issue, at least as far as I can tell.

>
> And when you say:
>
> > My main point is, if the device enters runtime suspend state, why
> > should we keep the vote for an OPP for the device? I mean, the device
> > isn't going to be used anyway.
> >
>
> A very similar point would be: "If the device *is* in runtime suspend
> state, why should we take a vote for an OPP for the device?"
>
> But I understand that this might be something we should address
> separately in a follow-up patch/discussion. Don't get me wrong, I agree
> this patch set is good, I just think we should go one step further and
> finally make this consistent and less prone to side effects.

I agree. We should look into how to change the behaviour. I intend to
have a look at it in a while.

>
> A good first step might be something like a WARN_ON_ONCE(...) if a
> device tries to vote for a performance state while runtime suspended.
> Then we might get a clearer picture which drivers do that currently.

That's an idea we could try, even if the number of users are quite
limited today. I can try the "git grep" analyze-method, I will
probably find most of them.

>
> Stephan

That said, are you okay that we move forward with the $subject series
(except patch4)?

Kind regards
Uffe

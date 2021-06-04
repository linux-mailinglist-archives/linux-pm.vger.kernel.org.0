Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDC39B848
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFDLww (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:52:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:20162 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFDLwv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622807453; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NYeOrEjOT4LX0GYdKX5tlVFBklD3lBVpylbUYApZMayb7wrfI9Ruptrqsmgcz/oeUk
    jCbgeMBbx584H8gNGBHNPA5jpytuQgtpLZHpqhp4dNq5YVVHAYS7PYhqm3F+QNfAm5Df
    gkClQCGIU99q4FW4a/Zyo31D+owWx5o1e5Irl1iowsVqIyJTScpTb2k7rKMkt27AqrCM
    J+DgSpXuQwovogRSucNl2dV3qDgyia1PRLHsDwqFiuvXzLpcq7ZNBVlhddZrvk9esuQE
    eX4vvEWF3f3doA5EH+wbvYd7CUBc3rQQsWNZe246BSGzVVk3SE1nF9AfGXpIIGp+btv+
    FUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622807453;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=z3JS23F7DFsYrJ/4zwkr/KTzw2MviMdAxvVpSAdTQP0=;
    b=UTu0IDWdwcNJDEtvjGSqF8n4HvT4+ni2Y+lwDfg7eh9uogQfpv7V4SVa4JTHrFG2w1
    uc8yv4tu79rEvOvPf9RiJYwmmdRdFxZW73aYvncImh43SUx8J5GxXrpgTmKLTxwJ5PgI
    tsNOzt97hqb2oetH5/9Y0fx59hGdeN+ncdH2o9tQZOWiNEkOEm3EH/dnTZFUb9BmqggR
    bC6pPDjIIHa3/WSs9rc3wd61+TCov4Ymg0zMm53qJrReqFNigDicVS4fa3VtSrzvD1dT
    ANxhctP19ZCQI3JN4V3TzBtLET0Ixh2j5ZFWoAnPcyKdbjovMQ30NtdlzufjsuqTztFi
    /OqQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622807453;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=z3JS23F7DFsYrJ/4zwkr/KTzw2MviMdAxvVpSAdTQP0=;
    b=EKgliLLZU2uTO/C9eHitNc4GAf4UmUkSHR6SFOzJ0pL8puVr217tXTRtyCHn9XW0MH
    p19t6IbujoNeEeRQ/ttuVueUhJn6Uj7GDYhHnpnPOCaCphfpd5hQXqTsHjh4YkuTO2yd
    fjJ/kRmsJrXS3khy2F0ss1PfOM0gJfMENcFni03NbcYWLMkbWiy5pqm1MHqRhRioKoed
    0FK3mY0011zHnEpgqZt2VfLa2/tJtepE8i1ZC5p+9VVOS91smUV9D0HEJsmZVfer+XOt
    Y4oZDxVL91w0NvpU1rxoMWAilDpb571Bxwmm/7tZkaDV5uLew4AtS0Bux7L8Dy66F9y6
    C9iQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8Ic3NBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x54BorEQV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 4 Jun 2021 13:50:53 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:50:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in
 subsystem/drivers
Message-ID: <YLoTl7MfMfq2g10h@gerhold.net>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <YLi5N06Qs+gYHgYg@gerhold.net>
 <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
 <YLkOAyydZMnxkEy+@gerhold.net>
 <CAPDyKFpaKkeyOpP7iW8-WG7DLs6Gd1eD2KO3pDYrVQ3z88zFJQ@mail.gmail.com>
 <YLni830rOJWy1NRU@gerhold.net>
 <CAPDyKFr7iRA+FmrJuDJVPVLcC7j=3LU7VdBwqZqxWEc25SssMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7iRA+FmrJuDJVPVLcC7j=3LU7VdBwqZqxWEc25SssMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:57:59PM +0200, Ulf Hansson wrote:
> On Fri, 4 Jun 2021 at 10:23, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Fri, Jun 04, 2021 at 09:18:45AM +0200, Ulf Hansson wrote:
> > > On Thu, 3 Jun 2021 at 19:16, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > >
> > > > On Thu, Jun 03, 2021 at 05:27:30PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 3 Jun 2021 at 13:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > > > I think this might also go into the direction of my problem with the OPP
> > > > > > core for CPU DVFS [1] since the OPP core currently does not "power-on"
> > > > > > the power domains, it just sets a performance state. I got kind of stuck
> > > > > > with all the complexity of power domains in Linux so I think we never
> > > > > > solved that.
> > > > >
> > > > > Hmm, that issue is in a way related.
> > > > >
> > > > > Although, if I understand correctly, that was rather about at what
> > > > > layer it makes best sense to activate the device (from runtime PM
> > > > > point of view). And this was needed due to the fact that the
> > > > > corresponding genpd provider, requires the PM domain to be power on to
> > > > > allow changing a performance state for it. Did I get that correct?
> > > > >
> > > >
> > > > Yes, mostly. But I guess I keep coming back to the same question:
> > > >
> > > > When/why does it make sense to vote for a "performance state" of
> > > > a power domain that is or might be powered off?
> > > >
> > > > "Powered off" sounds like the absolutely lowest possible performance
> > > > state to me, it's just not on at all. And if suddenly a device comes and
> > > > says "I want performance state X", nothing can change until the power
> > > > domain is also "powered on".
> > > >
> > > > I think my "CPU DVFS" problem only exists because in many other
> > > > situations it's possible to rely on one of the following side effects:
> > > >
> > > >   1. The genpd provider does not care if it's powered on or not.
> > > >      (i.e. it's always-on or implicitly powers on if state > 0).
> > > >   2. There is some other device that votes to keep the power domain on.
> > > >
> > > > And that's how the problem relates to my comment for this patch series ...
> > > >
> > > > >
> > > > > >
> > > > > > Do I understand your patch set correctly that you basically make the
> > > > > > performance state votes conditional to the "power-on" vote of the device
> > > > > > (which is automatically toggled during runtime/system PM)?
> > > > >
> > > > > The series can be considered as a step in that direction, but no, this
> > > > > series doesn't change that behaviour.
> > > > >
> > > > > Users of dev_pm_genpd_set_performance_state() are still free to set a
> > > > > performance state, orthogonally to whether the PM domain is powered on
> > > > > or off.
> > > > >
> > > > > >
> > > > > > If yes, I think that's a good thing. It was always really confusing to me
> > > > > > that a device can make performance state votes if it doesn't actually
> > > > > > want the power domain to be powered on.
> > > > >
> > > > > I share your view, it's a bit confusing.
> > > > >
> > > > > Just adding the condition internally to genpd to prevent the caller of
> > > > > dev_pm_genpd_set_performance() from succeeding to set a new state,
> > > > > unless the genpd is powered on, should be a rather simple thing to
> > > > > add.
> > > > >
> > > > > However, to change this, we first need to double check that all the
> > > > > callers are making sure they have turned on the PM domain (typically
> > > > > via runtime PM).
> > > > >
> > > >
> > > > ... because if performance state votes would be conditional to the
> > > > "power-on" vote of the device, it would no longer be possible
> > > > to rely on the side effects mentioned above. So this would most
> > > > certainly break some code that (incorrectly?) relies on these side
> > > > effects, but would also prevent such code.
> > >
> > > Right. I understand your point and I am open to discuss an
> > > implementation. Although, I suggest we continue that separately from
> > > the $subject series.
> > >
> > > >
> > > > My (personal) feeling so far is that just dropping performance votes
> > > > during runtime/system suspend just makes the entire situation even more
> > > > confusing.
> > >
> > > Well, that's what most subsystems/drivers need to do.
> > >
> > > Moreover, we have specific devices that only use one default OPP [1].
> > >
> > > >
> > > > > >
> > > > > > What happens if a driver calls dev_pm_genpd_set_performance_state(...)
> > > > > > while the device is suspended? Will that mess up the performance state
> > > > > > when the device resumes?
> > > > >
> > > > > Good question. The idea is:
> > > > >
> > > > > If genpd in genpd_runtime_suspend() are able to drop an existing vote
> > > > > for a performance state, it should restore the vote in
> > > > > genpd_runtime_resume(). This also means, if there is no vote to drop
> > > > > in genpd_runtime_suspend(), genpd should just leave the vote as is in
> > > > > genpd_runtime_resume().
> > > > >
> > > >
> > > > But the next time the device enters runtime suspend that vote would be
> > > > dropped, wouldn't it? That feels kind of strange to me.
> > >
> > > What do you mean by "next time"?
> > >
> >
> > Basically just like:
> >
> >   <device runtime-suspended>
> >   driver does dev_pm_genpd_set_performance_state(...)
> >     - performance state is applied immediately, even though device does
> >       apparently not actually want the power domain to be powered on
> >   <device runtime resumes>
> >     - performance state is kept
> >   <device runtime suspends>
> >     - performance state is dropped
> 
> Yep, this is what would happen.
> 
> >   ...
> >
> > I'm not saying this example makes sense (it doesn't for me). It doesn't
> > make sense to vote for a performance state while runtime suspended.
> >
> > But with this patch series we still allow that, and it will kind of
> > produce inconsistent behavior that the performance state is applied
> > immediately, even though the device is currently runtime-suspended.
> > But once it runtime suspends again, suddenly it is dropped.
> 
> Yes.
> 
> Note that, I have been looking at the existing callers of
> dev_pm_genpd_set_performance_state() in the kernel as of today. It
> should not be an issue, at least as far as I can tell.
> 
> >
> > And when you say:
> >
> > > My main point is, if the device enters runtime suspend state, why
> > > should we keep the vote for an OPP for the device? I mean, the device
> > > isn't going to be used anyway.
> > >
> >
> > A very similar point would be: "If the device *is* in runtime suspend
> > state, why should we take a vote for an OPP for the device?"
> >
> > But I understand that this might be something we should address
> > separately in a follow-up patch/discussion. Don't get me wrong, I agree
> > this patch set is good, I just think we should go one step further and
> > finally make this consistent and less prone to side effects.
> 
> I agree. We should look into how to change the behaviour. I intend to
> have a look at it in a while.
> 

Great, thanks!

> >
> > A good first step might be something like a WARN_ON_ONCE(...) if a
> > device tries to vote for a performance state while runtime suspended.
> > Then we might get a clearer picture which drivers do that currently.
> 
> That's an idea we could try, even if the number of users are quite
> limited today. I can try the "git grep" analyze-method, I will
> probably find most of them.
> 

The current user of "required-opps" for CPU DVFS (just qcom/qcs404.dtsi
with qcom/cpr.c I think?) is definitely broken (never votes to turn on
the power domain). So one requirement for making that change of behavior
is figuring out how to deal with enabling power domains at the OPP core
(or whereever else).

> 
> That said, are you okay that we move forward with the $subject series
> (except patch4)?
> 

It sounds fine to me. My system doesn't have power domain performance
states set up properly yet (due to various open questions), so I can't
test it properly though. Also, I'm not sure if it's a good idea to omit
patch 4, doesn't that mean drivers that currently drop the performance
states themselves can be only partially cleaned up?

I do have some thoughts about the "regulator-fixed-domain". Not exactly
a solution for the problem you mentioned, just some related thoughts.
Will try to reply there later.

Thanks!
Stephan

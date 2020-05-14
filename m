Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A551D3829
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgENR2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 13:28:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENR2Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 13:28:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB8031042;
        Thu, 14 May 2020 10:28:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2663A3F71E;
        Thu, 14 May 2020 10:28:22 -0700 (PDT)
Date:   Thu, 14 May 2020 18:28:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
Message-ID: <20200514172816.GA42669@bogus>
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
 <20200514142015.GA23401@bogus>
 <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 05:41:37PM +0200, Ulf Hansson wrote:
> On Thu, 14 May 2020 at 16:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 11, 2020 at 03:33:46PM +0200, Ulf Hansson wrote:
> > > Moving forward, platforms are going to need to execute specific "last-man"
> > > operations before a domain idle state can be entered.
> >
> > I need to dig the thread details, but I remember commenting on one of
> > the similar discussion. It was something to do with voting which wasn't
> > necessary at all. I am interested in the details here.
> >
> > > In one way or the other, these operations needs to be triggered while
> > > walking the  hierarchical topology via runtime PM and genpd, as it's at that
> > > point the last-man becomes known.
> > >
> > > Moreover, executing last-man operations needs to be done after the CPU PM
> > > notifications are sent through cpu_pm_enter(), as otherwise it's likely
> > > that some notifications would fail. Therefore, let's re-order the sequence
> > > in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
> > > pm_runtime_put_sync().
> > >
> >
> > More details on why notifications fail ?
>
> Well, at this moment this is more of a hypothetical issue as there is
> no last-man notification sent/used yet.
>

Ah OK.

> However, typically we would call cpu_cluster_pm_enter() in the path as
> when the psci_pd_power_off() is called (for psci PM domains), when a
> valid domain state has been found.
>

Please don't use cpu_cluster_pm_enter. I thought the whole idea of genpd
will remove the notion of cluster and we will never need to use
cpu_cluster_pm_*

> This means, we would violate the cpu_cluster_pm_enter() API, as it's
> clearly stated in its corresponding function header, that
> cpu_pm_enter() needs to be called first (and that's also how others
> are currently using it).
>

Ah so, it was just for use of cpu_cluster_pm_* which I would like to
avoid. That was one of the motivation for using genpd I thought.

> Note that, I am currently exploring whether we shall call
> cpu_cluster_pm_enter|exit() at all, or whether we can use some other
> new genpd mechanism to accomplish the similar thing.
>

Good, you do think so.

> >
> > > Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
> > > Reported-by: Lina Iyer <ilina@codeaurora.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > index bae9140a65a5..d0fb585073c6 100644
> > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > @@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > >       u32 state;
> > >       int ret;
> > >
> > > +     ret = cpu_pm_enter();
> > > +     if (ret)
> > > +             return -1;
> > > +
> >
> > This change is ignoring the retention case psci_enter_state handles and
> > this may affect performance by doing unnecessary save/restore.
>
> This was already the case before. CPU_PM_CPU_IDLE_ENTER_PARAM() ends
> up always setting "is_retention" to 0, when __CPU_PM_CPU_IDLE_ENTER()
> is called.
>

Ah OK, I recall now, sorry for the noise.

--
Regards,
Sudeep

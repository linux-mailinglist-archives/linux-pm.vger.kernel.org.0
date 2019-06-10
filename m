Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FFB3B3B6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbfFJLC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 07:02:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbfFJLC4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 07:02:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC8F6337;
        Mon, 10 Jun 2019 04:02:55 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2553F557;
        Mon, 10 Jun 2019 04:04:34 -0700 (PDT)
Date:   Mon, 10 Jun 2019 12:02:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/18] drivers: firmware: psci: Support CPU hotplug for
 the hierarchical model
Message-ID: <20190610110250.GD26602@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-16-ulf.hansson@linaro.org>
 <20190607153114.GI15577@e107155-lin>
 <CAPDyKFqooMww0B6vGL56BnG-L=13C3oWeDFx4v1cO9=W9QPwVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqooMww0B6vGL56BnG-L=13C3oWeDFx4v1cO9=W9QPwVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 12:21:47PM +0200, Ulf Hansson wrote:
> On Fri, 7 Jun 2019 at 17:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 09:22:57PM +0200, Ulf Hansson wrote:
> > > When the hierarchical CPU topology is used and when a CPU has been put
> > > offline (hotplug), that same CPU prevents its PM domain and thus also
> > > potential master PM domains, from being powered off. This is because genpd
> > > observes the CPU's attached device as being active from a runtime PM point
> > > of view.
> > >
> > > To deal with this, let's decrease the runtime PM usage count by calling
> > > pm_runtime_put_sync_suspend() of the attached struct device when putting
> > > the CPU offline. Consequentially, we must then increase the runtime PM
> > > usage count, while putting the CPU online again.
> > >
> >
> > Why is this firmware/driver specific ? Why can't this be dealt in core
> > pm-domain ? I am concerned that if any other architectures or firmware
> > method decides to use this feature, this need to be duplicated there.
>
> What is the core pm-domain? Do you refer to the generic PM domain (genpd), no?
>

Sorry for my bad choice of names. I just wrote names as I understand
rather than looking for exact match. But yes, I meant generic place
where such ref-counting is done currently for other things.

> In such case, this is not the job of genpd, but rather the opposite
> (to *monitor* the reference count).
>

OK, I need to understand that then.

> >
> > The way I see this is pure reference counting and is hardware/firmware/
> > driver agnostic and can be made generic.
>
> As stated in the another reply, I would rather start with having more
> things driver specific rather than generic. Later on we can always
> consider to move/split things, when there are more users.
>
> In this particular case, the runtime PM reference counting is done on
> the struct device*, that genpd returned via
> dev_pm_domain_attach_by_name(). And because
> dev_pm_domain_attach_by_name() is called from PSCI code, I decided to
> keep this struct device* internal to PSCI.

Sure, I understand your intent. I have just mentioned my thoughts/comments
as I reviewed.

--
Regards,
Sudeep

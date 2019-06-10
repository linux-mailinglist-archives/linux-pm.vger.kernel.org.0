Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF98A3B368
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbfFJKm7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:42:59 -0400
Received: from foss.arm.com ([217.140.110.172]:40384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389426AbfFJKm7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 06:42:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FE5337;
        Mon, 10 Jun 2019 03:42:58 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CE23F557;
        Mon, 10 Jun 2019 03:44:37 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:42:53 +0100
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
Message-ID: <20190610104253.GB26602@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-8-ulf.hansson@linaro.org>
 <20190607151716.GF15577@e107155-lin>
 <CAPDyKFoKNLqLzVx8uj_-iuWAHGCvty28mVKnipFVgjKD8oDNkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoKNLqLzVx8uj_-iuWAHGCvty28mVKnipFVgjKD8oDNkQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 12:21:10PM +0200, Ulf Hansson wrote:
> On Fri, 7 Jun 2019 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 09:22:49PM +0200, Ulf Hansson wrote:
> > > The per CPU variable psci_power_state, contains an array of fixed values,
> > > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > > each of the available CPU idle states.
> > >
> > > This isn't sufficient when using the hierarchical CPU topology in DT in
> > > combination with having PSCI OS initiated (OSI) mode enabled. More
> > > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > > state of the cluster.
> > >
> > > For this reason, let's introduce an additional per CPU variable called
> > > domain_state and implement two helper functions to read/write its values.
> > > Following patches, which implements PM domain support for PSCI, will use
> > > the domain_state variable and set it to corresponding bits that represents
> > > the selected idle state for the cluster.
> > >
> > > Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
> > > take into account the values in the domain_state, as to get the complete
> > > suspend parameter.
> > >
> >
> > I understand it was split to ease review, but this patch also does
> > nothing as domain_state = 0 always. I was trying hard to find where it's
> > set, but I assume it will be done in later patches. Again may be this
> > can be squashed into the first caller of psci_set_domain_state
> 
> You have a point, but I am worried that it would look like this series
> is solely needed to support OSI mode. This is not the case. Let me
> explain.
> 
> Having $subject patch separate shows the specific changes needed to
> support OSI mode. The first caller of psci_set_domain_state() is added
> in patch9, however, patch9 is useful no matter of OSI or PC mode.
> 
> Moreover, if I squash $subject patch with patch9, I would have to
> squash also the subsequent patch (patch8), as it depends on $subject
> patch.
> 
> So, to conclude, are you happy with this as is or do you want me to
> squash the patches?
> 

Yes I am fine either way. As I put the comments in the same flow as I
did review, I thought it's worth mentioning if someone else get similar
thoughts. I am fine if you prefer to keep it the same way unless someone
else raise the same point.

--
Regards,
Sudeep

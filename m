Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3A17B9C6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 11:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCFKEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 05:04:41 -0500
Received: from foss.arm.com ([217.140.110.172]:58854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgCFKEl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 05:04:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5298C31B;
        Fri,  6 Mar 2020 02:04:40 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16CB3F6C4;
        Fri,  6 Mar 2020 02:04:38 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:04:31 +0000
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
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200306100431.GA16541@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org>
 <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus>
 <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 10:28:10AM +0100, Ulf Hansson wrote:
> On Thu, 5 Mar 2020 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >

[...]

> > OK. The only state that cluster can enter when CPUs are in WFI are
> > cluster WFI and most hardware can handle it automatically. I don't see
> > the need to do any extra work for that.
>
> This isn't about cluster WFI, but about deeper cluster states, such as
> a cluster-clock-gated-state and a cluster-power-off-state. It's an ST
> platform, which Benjamin is working on.
>

Then definitely something is completely wrong. You can't enter deeper
cluster states(clock-gated and power-off to be specific) with CPU in
just WFI state. So, if the attempt here is to enter those states, I
disagree with the change.

Benjamin, please share the complete hierarchical topology for your platform.

> >
> > > Then, after we have called pm_runtime_put_sync_suspend() a few lines
> > > above, we may potentially have a "domain state" to use, instead of the
> > > WFI state.
> > >
> >
> > Are they any platforms with this potential "domain state" to use with
> > CPU WFI. I want to understand this better.
> >
> > > In this case, if we would have called psci_enter_state(), that would
> > > lead us to calling cpu_do_idle() from the __CPU_PM_CPU_IDLE_ENTER()
> > > macro, becuase idx is zero. In other words, the domain state would
> > > become unused.
> > >
> >
> > For a domain state to become unused with WFI, it needs to be available
> > and I am not 100% sure of that.
>
> With these changes from the series, we can fully conform to the
> hierarchical DT bindings for PSCI.
>

Theoretically may be, but may not confirm to the hardware states.

> I am not sure I understand your concern, is there a cost involved by
> applying this?
>

Yes as mentioned above.

--
Regards,
Sudeep

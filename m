Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99E10774F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKVS0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 13:26:32 -0500
Received: from foss.arm.com ([217.140.110.172]:50858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKVS0c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 13:26:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34203328;
        Fri, 22 Nov 2019 10:26:31 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377293F6C4;
        Fri, 22 Nov 2019 10:26:29 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:26:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191122182623.GA8290@e121166-lin.cambridge.arm.com>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-11-ulf.hansson@linaro.org>
 <20191115173053.GE27170@bogus>
 <CAPDyKFraEhFVm27YG0fVkjT0-oBBxFpfiBY4zS+1TMy=0F6GRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFraEhFVm27YG0fVkjT0-oBBxFpfiBY4zS+1TMy=0F6GRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 18, 2019 at 02:37:41PM +0100, Ulf Hansson wrote:
> On Fri, 15 Nov 2019 at 18:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Oct 29, 2019 at 05:44:35PM +0100, Ulf Hansson wrote:
> > > The per CPU variable psci_power_state, contains an array of fixed values,
> > > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > > each of the available CPU idle states.
> > >
> > > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > > combination with having PSCI OS initiated (OSI) mode enabled. More
> > > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > > state of the cluster.
> > >
> > > For this reason, introduce a per CPU variable called domain_state and
> > > implement two helper functions to read/write its value. Then let the
> > > domain_state take precedence over the regular selected state, when entering
> > > and idle state.
> > >
> > > Finally, let's also avoid sprinkling the existing non-OSI path with
> > > operations being specific for OSI.
> > >
> >
> > Mostly looks good.
> 
> Thanks!
> 
> 
> > I am still wondering if we can keep all OSI related
> > info in the newly created structure and have psci_states outside it as
> > before. And I was think psci_enter_idle_state_pc and psci_enter_idle_state_osi
> > instead of single psci_enter_idle_state and assign/initialise state->enter
> > based on the mode chosen. I had to closer look now and looks like enter
> > is initialised in generic dt_idle_states. That said, what you have in this
> > patch also looks OK to me, was just trying to avoid access to the new
> > structure all together and keep the PC mode patch almost same as before
> > when suspending. I will see what Lorenzo thinks about this.
> 
> I did explore that approach a bit, but found it easier to go with what
> I propose here. The most important point, in my view, is that in this
> suggested approach only one if-check, "if (!data->dev)", is added to
> the PC mode path compared to the original path. I think this should be
> fine, right!?

I don't see why we should use data->dev at runtime when we can
have two separate idle enter functions and the detection can
be done at probe once for all instead of every idle entry.

The overhead is close to nought but the point is that it is
really not needed.

Thanks,
Lorenzo

> In any case, if you prefer any other solution, just tell me and I adapt to it.
> 
> Now, I am looking forward to hear from Lorenzo.
> 
> Kind regards
> Uffe

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0F6CEDB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 15:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGRNbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 09:31:06 -0400
Received: from foss.arm.com ([217.140.110.172]:58428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRNbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jul 2019 09:31:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B6A344;
        Thu, 18 Jul 2019 06:31:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D753F71F;
        Thu, 18 Jul 2019 06:31:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:30:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
Message-ID: <20190718133053.GA27222@e121166-lin.cambridge.arm.com>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
 <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 12:35:07PM +0200, Ulf Hansson wrote:
> On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> > > When the hierarchical CPU topology layout is used in DT, let's allow the
> > > CPU to be power managed through its PM domain, via deploying runtime PM
> > > support.
> > >
> > > To know for which idle states runtime PM reference counting is needed,
> > > let's store the index of deepest idle state for the CPU, in a per CPU
> > > variable. This allows psci_cpu_suspend_enter() to compare this index with
> > > the requested idle state index and then act accordingly.
> >
> > I do not see why a system with two CPU CPUidle states, say CPU retention
> > and CPU shutdown, should not be calling runtime PM on CPU retention
> > entry.
> 
> If the CPU idle governor did select the CPU retention for the CPU, it
> was probably because the target residency for the CPU shutdown state
> could not be met.

The kernel does not know what those cpu states represent, so, this is an
assumption you are making and it must be made clear that this code works
as long as your assumption is valid.

If eg a "cluster" retention state has lower target_residency than
the deepest CPU idle state this assumption is wrong.

And CPUidle and genPD governor decisions are not synced anyway so,
again, this is an assumption, not a certainty.

> In this case, there is no point in allowing any other deeper idle
> states for cluster/package/system, since those have even greater
> residencies, hence calling runtime PM doesn't make sense.

On the systems you are testing on.

Lorenzo

> > The question then is what cluster/package/system states
> > are allowed for a given CPU idle state, to understand
> > what idle states can be actually entered at any hierarchy
> > level given the choice made for the CPU idle state.
> >
> > In the case above, a CPU entering retention state should prevent
> > runtime PM selecting a cluster shutdown state; most likely firmware
> > would demote the request to cluster retention but still, we should
> > find a way to describe these dependencies.
> 
> See above.
> 
> [...]
> 
> Kind regards
> Uffe

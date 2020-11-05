Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52952A828B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgKEPqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 10:46:15 -0500
Received: from foss.arm.com ([217.140.110.172]:35914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730721AbgKEPqP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 10:46:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A71C14BF;
        Thu,  5 Nov 2020 07:46:14 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA483F718;
        Thu,  5 Nov 2020 07:46:14 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:46:12 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v3 0/3] CPUFreq: Add support for cpu performance
 dependencies
Message-ID: <20201105154612.GA17891@arm.com>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201103101840.yrgwmcjrnjn7n5q6@vireshk-i7>
 <87558fa9-a4c6-38c9-bcc5-f736c0229f56@arm.com>
 <CAKfTPtDvDqHjSFCmjc_D_8Tx0kosBneDxmDZRpG6XkgAnWE3nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDvDqHjSFCmjc_D_8Tx0kosBneDxmDZRpG6XkgAnWE3nw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Thursday 05 Nov 2020 at 15:25:53 (+0100), Vincent Guittot wrote:
[..]
> > > - Because of hardware co-ordination of otherwise co-ordinated CPUs,
> > >   few things break. Thermal and EAS are some of the examples and so
> > >   you are trying to fix them here by proving them the missing
> > >   information again.
> >
> > Correct. And for this I have proposed two ways.
> >
> > >
> > > - One other thing that breaks with this is freq-invariance in the
> > >   scheduler, as the scheduler won't see the real frequencies the
> > >   various CPUs are running at. Most of the hardware we have today
> > >   doesn't have counters, like AMUs, not sure if all future ones based
> > >   on SCMI will have that too, so how are they gong to be fixed ?
> > >
> >
> > Correct. freq-invariance without counters is trying to do its best based on the
> > information it has available. It definitely relies on the knowledge of the v/f
> > domains to work at its best so I think in the case of per-cpu it will follow the
> > same approach as others being affected (EAS, thermal).
> 
> As frequency invariance has same problem as EAS and Thermal it would
> be good to see the solution as part of this proposal like EAS and
> Thermal
> 

I think I was waiting for a consensus on patch 3/3, although I believe the
discussion at [1] tended towards option 2: "each driver to store
internally the performance dependencies and let the driver directly
provide the correct cpumask for any consumer."
The alternative was option 1: "add a new dependent_cpus cpumaks in
cpufreq_policy", as Nicola mentioned in the commit message for 3/3.

If the choice is clear, I'm happy to take the FIE fixes in a separate
set.

Thanks,
Ionela.

[1] https://lore.kernel.org/linux-arm-kernel/20200924095347.32148-3-nicola.mazzucato@arm.com/

> >
> > >   And if we even have to fix this (freq invariance), what's hardware
> > >   coordination giving us that makes all this worth it ?
> >
> > I suppose this is more a generic question for all the platforms running with h/w
> > coordination, but for our case is that the f/w will take care of the performance
> > optimizations for us :)
> >
> > >
> > > Sorry about the long list :)
> >
> > No problem at all. Thank you for your time on this and I hope I have made bits
> > clearer.
> >
> > Nicola
> >
> > >

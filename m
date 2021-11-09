Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AF44AEAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhKIN03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 08:26:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:54047 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKIN02 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 08:26:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="213171935"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="213171935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 05:23:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="451912478"
Received: from na1-mobl.gar.corp.intel.com ([10.213.108.242])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 05:23:35 -0800
Message-ID: <e244e3aa9fc323973d7da8d3ebc3e1fad1fdb731.camel@linux.intel.com>
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Nov 2021 05:23:31 -0800
In-Reply-To: <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
         <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Tue, 2021-11-09 at 12:39 +0000, Lukasz Luba wrote:
> Hi Ricardo,
> 
> 
> On 11/6/21 1:33 AM, Ricardo Neri wrote:
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > Add a new netlink event to notify change in CPU capabilities in
> > terms of
> > performance and efficiency.
> 
> Is this going to be handled by some 'generic' tools? If yes, maybe
> the values for 'performance' might be aligned with capacity
> [0,1024] ? Or are they completely not related so the mapping is
> simply impossible?
> 

That would have been very useful.

The problem is that we may not know the maximum performance as system
may be booting with few CPUs (using maxcpus kernel command line) and
then user hot adding them. So we may need to rescale when we get a new
maximum performance CPU and send to user space.

We can't just use max from HFI table at in instance as it is not
necessary that HFI table contains data for all CPUs.

If HFI max performance value of 255 is a scaled value to max
performance CPU value in the system, then this conversion would have
been easy. But that is not.



> > 
> > Firmware may change CPU capabilities as a result of thermal events
> > in the
> > system or to account for changes in the TDP (thermal design power)
> > level.
> > 
> > This notification type will allow user space to avoid running
> > workloads
> > on certain CPUs or proactively adjust power limits to avoid future
> > events.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Srinivas Pandruvada <  
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >   drivers/thermal/thermal_netlink.c | 52
> > +++++++++++++++++++++++++++++++
> >   drivers/thermal/thermal_netlink.h | 13 ++++++++
> >   include/uapi/linux/thermal.h      |  6 +++-
> >   3 files changed, 70 insertions(+), 1 deletion(-)
> 
> [snip]
> 
> >   
> > +struct cpu_capability {
> > +       int cpu;
> > +       int perf;
> > +       int eff;

Good idea.

Thanks,
Srinivas

> 
> Why not use the full names, instead of thse shortcuts? We use full
> naming e.g. in cpufreq framework such as 'frequency' not 'freq'.
> The 'eff' is really not meaningful ('perf' a bit less but it has
> to meanings in kernel).
> 
> Regards,
> Lukasz



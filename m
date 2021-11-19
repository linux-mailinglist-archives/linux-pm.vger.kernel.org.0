Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC50E456F95
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhKSNbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 08:31:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:8560 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhKSNbH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 08:31:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="231893535"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="231893535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:28:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="737059327"
Received: from taoki-mobl3.gar.corp.intel.com ([10.254.64.179])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:28:01 -0800
Message-ID: <aaa08cd0912576c3848eaacccc9d09273ddc73f9.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: ITMT support for overclocked
 system
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Michael Larabel <Michael@MichaelLarabel.com>, lenb@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ricardo.neri@intel.com, tim.c.chen@intel.com, peterz@infradead.org,
        arjan@linux.intel.com
Date:   Fri, 19 Nov 2021 05:27:57 -0800
In-Reply-To: <a2a18288-fa7c-02fb-6376-730777823637@MichaelLarabel.com>
References: <20211119051801.1432724-1-srinivas.pandruvada@linux.intel.com>
         <a2a18288-fa7c-02fb-6376-730777823637@MichaelLarabel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-11-19 at 05:19 -0600, Michael Larabel wrote:
> On 11/18/21 23:18, Srinivas Pandruvada wrote:
> > On systems with overclocking enabled, CPPC Highest Performance can
> > be
> > hard coded to 0xff. In this case even if we have cores with
> > different
> > highest performance, ITMT can't be enabled as the current
> > implementation
> > depends on CPPC Highest Performance.
> > 
> > On such systems we can use MSR_HWP_CAPABILITIES maximum performance
> > field
> > when CPPC.Highest Performance is 0xff.
> > 
> > Due to legacy reasons, we can't solely depend on
> > MSR_HWP_CAPABILITIES as
> > in some older systems CPPC Highest Performance is the only way to
> > identify
> > different performing cores.
> > 
> > Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
> > Signed-off-by: Srinivas Pandruvada < 
> > srinivas.pandruvada@linux.intel.com>
> > ---
> > This patch was tested on one Alder Lake system by enabling
> > Overclocking.
> > Once overclocking is enabled, we see
> > $cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
> > 255 (P-Cores)
> > 255 (P-Cores
> > ...
> > ...
> > 255 (E-Cores)
> > 255 (E-Cores)
> > The real max performance for CPUs on this system was
> > 0x40 for P-cores and 0x26 for E-cores.
> > With this change applied we will see
> > $cat /proc/sys/kernel/sched_itmt_enabled
> > 1
> > The resultant ITMT priorities
> > for P-core 0x40, P-core HT sibling 0x10 and E-core 0x26
> 
> 
> With this patch I can confirm that now sched_itmt_enabled = 1 and 
> correct highest_perf with the ASUS ROG STRIX Z690-E GAMING WIFI board
> on 
> the latest BIOS. Thanks.
> 
> Tested-by: Michael Larabel <Michael@MichaelLarabel.com>
> 

Thanks Michael for confirming.

-Srinivas

> Michael
> 
> 
> > 
> >   drivers/cpufreq/intel_pstate.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 815df3daae9d..3106e62ffb25 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -338,6 +338,8 @@ static void
> > intel_pstste_sched_itmt_work_fn(struct work_struct *work)
> >   
> >   static DECLARE_WORK(sched_itmt_work,
> > intel_pstste_sched_itmt_work_fn);
> >   
> > +#define CPPC_MAX_PERF  U8_MAX
> > +
> >   static void intel_pstate_set_itmt_prio(int cpu)
> >   {
> >         struct cppc_perf_caps cppc_perf;
> > @@ -348,6 +350,14 @@ static void intel_pstate_set_itmt_prio(int
> > cpu)
> >         if (ret)
> >                 return;
> >   
> > +       /*
> > +        * On some systems with overclocking enabled,
> > CPPC.highest_perf is hardcoded to 0xff.
> > +        * In this case we can't use CPPC.highest_perf to enable
> > ITMT.
> > +        * In this case we can look at MSR_HWP_CAPABILITIES bits
> > [8:0] to decide.
> > +        */
> > +       if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> > +               cppc_perf.highest_perf =
> > HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> > +
> >         /*
> >          * The priorities can be set regardless of whether or not
> >          * sched_set_itmt_support(true) has been called and it is
> > valid to



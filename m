Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D344552F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhKDOVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 10:21:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:43088 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231395AbhKDOUp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 10:20:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="292545743"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="292545743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 07:15:49 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="489973630"
Received: from rabentle-desk1.amr.corp.intel.com ([10.255.230.52])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 07:15:46 -0700
Message-ID: <a6ed700a76a03eefceca0ce735ab6fd3cab19841.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix unchecked MSR 0x773 access
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, lenb@kernel.org
Date:   Thu, 04 Nov 2021 07:15:42 -0700
In-Reply-To: <20211104093019.60c0e157@gandalf.local.home>
References: <20211104051925.119941-1-srinivas.pandruvada@linux.intel.com>
         <20211104093019.60c0e157@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-11-04 at 09:30 -0400, Steven Rostedt wrote:
> On Wed,  3 Nov 2021 22:19:25 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > It is possible that on some platforms HWP interrupts are disabled.
> > In
> > that case accessing MSR 0x773 will result in warning.
> > 
> > So check X86_FEATURE_HWP_NOTIFY feature to access MSR 0x773. The
> > other
> > places in code where this MSR is accessed, already checks this
> > feature
> > except during disable path called during cpufreq offline and
> > suspend
> > callbacks.
> > 
> > Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed
> > change notification")
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> 
> I added this patch on top of the above commit and I verified that the
> issue
> goes away. And just to confirm, I removed the patch, and the issue
> reappeared.
> 
> Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
Thanks for the test.
Sorry again for the mess up.

-Srinivas

> -- Steve
> 
> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 349ddbaef796..1e6898dc76b6 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1620,6 +1620,9 @@ static void
> > intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> >  {
> >         unsigned long flags;
> >  
> > +       if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> > +               return;
> > +
> >         /* wrmsrl_on_cpu has to be outside spinlock as this can
> > result in IPC */
> >         wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> >  
> 



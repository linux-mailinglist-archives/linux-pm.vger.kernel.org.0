Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E4178707
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 01:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCDA3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 19:29:10 -0500
Received: from foss.arm.com ([217.140.110.172]:54252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbgCDA3K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 19:29:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605DE30E;
        Tue,  3 Mar 2020 16:29:09 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9173F6CF;
        Tue,  3 Mar 2020 16:29:08 -0800 (PST)
Date:   Wed, 4 Mar 2020 00:29:07 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        pkondeti@codeaurora.org, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH v5 2/7] arm64: trap to EL1 accesses to AMU counters from
 EL0
Message-ID: <20200304002907.GB29652@arm.com>
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-3-ionela.voinescu@arm.com>
 <206c1a87-12aa-a4d4-8fc3-0b03c6125897@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206c1a87-12aa-a4d4-8fc3-0b03c6125897@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi James,

On Friday 28 Feb 2020 at 16:44:53 (+0000), James Morse wrote:
> Hi Ionela,
> 
> On 26/02/2020 13:29, Ionela Voinescu wrote:
> > The activity monitors extension is an optional extension introduced
> > by the ARMv8.4 CPU architecture. In order to access the activity
> > monitors counters safely, if desired, the kernel should detect the
> > presence of the extension through the feature register, and mediate
> > the access.
> > 
> > Therefore, disable direct accesses to activity monitors counters
> > from EL0 (userspace) and trap them to EL1 (kernel).
> > 
> > To be noted that the ARM64_AMU_EXTN kernel config and the disable_amu
> > kernel parameter do not have an effect on this code. Given that the
> > amuserenr_el0 resets to an UNKNOWN value, setting the trap of EL0
> > accesses to EL1 is always attempted for safety and security
> > considerations.
> 
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index aafed6902411..7103027b4e64 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> 
> > @@ -131,6 +131,7 @@ alternative_endif
> >  	ubfx	x11, x11, #1, #1
> >  	msr	oslar_el1, x11
> >  	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
> > +	reset_amuserenr_el0 x0			// Disable AMU access from EL0
> >  
> >  alternative_if ARM64_HAS_RAS_EXTN
> >  	msr_s	SYS_DISR_EL1, xzr
> 
> (This above hunk is in: cpu_do_resume, and this next one is __cpu_setup,)
> 
> > @@ -423,6 +424,8 @@ SYM_FUNC_START(__cpu_setup)
> >  	isb					// Unmask debug exceptions now,
> >  	enable_dbg				// since this is per-cpu
> >  	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
> > +	reset_amuserenr_el0 x0			// Disable AMU access from EL0
> 
> I think you only need this in __cpu_setup. The entry-point from cpu-idle calls:
> | cpu_resume
> | ->__cpu_setup
> | -->reset_amuserenr_el0
> | ->_cpu_resume
> | -->cpu_do_resume
> | --->reset_amuserenr_el0
> 
> (Which means the PMU reset call is redundant too).
> 

Thanks, that seems to be so. I'll submit a separate fix for both amu
and pmu, if you don't mind, after this set, so it will be a specific
cleanup patch.

> Its harmless, and needs cleaning up already, so regardless:
> Reviewed-by: James Morse <james.morse@arm.com>
> 

Thank you very much for the review,
Ionela.

> 
> 
> Thanks,
> 
> James

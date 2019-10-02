Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336C2C8837
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfJBMU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 08:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbfJBMUZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 08:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6591AD09;
        Wed,  2 Oct 2019 12:20:22 +0000 (UTC)
Message-ID: <1570019152.22393.0.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Date:   Wed, 02 Oct 2019 14:25:52 +0200
In-Reply-To: <20190924163053.GA4519@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <20190924163053.GA4519@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Peter,

late replies as I wasn't in the office last week.

On Tue, 2019-09-24 at 18:30 +0200, Peter Zijlstra wrote:
> On Mon, Sep 09, 2019 at 04:42:15AM +0200, Giovanni Gherdovich wrote:
> > +static const struct x86_cpu_id has_turbo_ratio_group_limits[] = {
> > +   ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> > +   ICPU(INTEL_FAM6_ATOM_GOLDMONT_X),
> 
> That's GOLDMONT_D in recent tip kernels.

Right, I saw that now.

> 
> > +   ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
> > +   ICPU(INTEL_FAM6_SKYLAKE_X),
> 
> What about KABYLAKE_X and ICELAKE_X ?

KABYLAKE_X: does it exist? I couldn't find it in
arch/x86/include/asm/intel-family.h (the tip tree), I only see KABYLAKE_L and
KABYLAKE.

ICELAKE_X: well, I don't know really. Does this model have the same semantic
for MSR_TURBO_RATIO_LIMIT as SKYLAKE_X (which is family = 0x6, model = 0x55)?
This is for Len B. and Srinivas P. (in CC).

The latest Software Developer's Manual (SDM) from May 2019 (volume 4, section
2.17.3, "MSRs Specific to Intel Xeon Processor Scalable Family") mentions only
"CPUID DisplayFamily_DisplayModel = 06_55H", which is SKYLAKE_X, as having the
semantic I'm looking for here (in addition to Atom Goldmont's).

The semantic I'm referring to is that MSR_TURBO_RATIO_LIMIT doesn't contain
turbo levels for the fixed group sizes 1-2-3-4-... cores, the group sizes are
specified in a different MSR (and could be 2-4-8-12-... for example).

If the SDM is outdated and ICELAKE_X is also in that category, then the
turbostat source code is outdated too as it has this function to detect this
feature:

    int has_turbo_ratio_group_limits(int family, int model)
    {

            if (!genuine_intel)
                    return 0;

            switch (model) {
            case INTEL_FAM6_ATOM_GOLDMONT:
            case INTEL_FAM6_SKYLAKE_X:
            case INTEL_FAM6_ATOM_GOLDMONT_X:
                    return 1;
            }
            return 0;
    }

(from the tree lenb/linux.git, branch "turbostat", turbostat version 19.08.31
not yet merged into mainline)


Giovanni

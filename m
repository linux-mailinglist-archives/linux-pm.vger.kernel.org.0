Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9790D15B1AF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLUTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 15:19:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLUTo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 15:19:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4AB328;
        Wed, 12 Feb 2020 12:19:44 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2DB03F68E;
        Wed, 12 Feb 2020 12:19:43 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:19:42 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
Message-ID: <20200212201942.GA12970@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-2-ionela.voinescu@arm.com>
 <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
 <20200212161045.GA7475@arm.com>
 <133890f7-59bb-63b9-0ca8-2294e3596058@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133890f7-59bb-63b9-0ca8-2294e3596058@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Wednesday 12 Feb 2020 at 16:20:56 (+0000), Suzuki Kuruppassery Poulose wrote:
> > For better handling I could have a cpumask_available check before the
> > allocation just in case the capability type changes in the future, or to
> > at least not rely on assumptions based on the type of the capability.
> > 
> > The reason this is dynamic is that I wanted to avoid the memory being
> > allocated when disable_amu is true - as Valentin mentioned in a comment
> > in the meantime "the static allocation is done against NR_CPUS whereas
> > the dynamic one is done against nr_cpu_ids".
> > 
> > Would this be alright?
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 182e05ca3410..4cee6b147ddd 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1222,7 +1222,11 @@ static bool has_amu(const struct arm64_cpu_capabilities *cap,
> >           * The enable function will also print a detection message.
> >           */
> > -       if (!disable_amu && !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
> > +       if (disable_amu)
> > +               return false;
> > +
> > +       if (!cpumask_available(amu_cpus) &&
> > +           !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
> >                  pr_err("Activity Monitors Unit (AMU): fail to allocate memory");
> >                  disable_amu = true;
> >          }

Going down the rabbit hole in regards to this section, it seems it's
actually not fine. When CONFIG_CPUMASK_OFFSTACK==y it fails to
allocate memory because zalloc_cpumask_var cannot be used before
initializing the slub allocator (mm_init) to allocate a cpumask.

The alternative alloc_bootmem_cpumask_var is an __init function that
can be used only during the initialization phase, which is not the case
for has_amu that can be called later (for hotplugged CPUs). Therefore,
dynamic allocation is not an option here.

Thanks,
Ionela.

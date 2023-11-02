Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A57DF035
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbjKBKbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346112AbjKBKbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 06:31:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43373112;
        Thu,  2 Nov 2023 03:31:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1803B2F4;
        Thu,  2 Nov 2023 03:31:46 -0700 (PDT)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8044E3F67D;
        Thu,  2 Nov 2023 03:30:56 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:30:03 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v4 7/7] arm64/amu: use capacity_ref_freq to set AMU ratio
Message-ID: <ZUN6K4d9FD31phbs@e129154.nice.arm.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-8-vincent.guittot@linaro.org>
 <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
 <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

On Wed, Nov 01, 2023 at 10:04:27AM +0100, Vincent Guittot wrote:
> Hi Beata,
> 
> On Wed, 1 Nov 2023 at 00:59, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 10:04:00AM +0200, Vincent Guittot wrote:
> > > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > > computing the arch_scale_freq_capacity().
> > > This helps to keep everything aligned using the same reference for
> > > computing CPUs capacity.
> > >
> 
> [..]
> 
> > > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> > >       }
> > >
> > >       for_each_possible_cpu(cpu) {
> > > +             freq_inv_set_max_ratio(cpu,
> > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > +
> > The capacity_ref_freq set earlier will still lead to units mismatch,
> > as at the point of calling topology_init_cpu_capacity_cppc the lowest & nominal
> > frequencies will be provided in MHz (unless I have missed smth).
> 
> I don't get your point:
> the unit of per_cpu(capacity_freq_ref, cpu) is Khz
> 
> For cppc, we have
> per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps,
> raw_capacity[cpu]);
> 
> freq_inv_set_max_ratio() uses
> arch_timer_get_rate() which returns a freq in Hz
> and
> per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ. to get a freq in Hz too.
> 
Apologies, I should have been more verbose here.
Before the change made in [1] the cppc_perf_to_khz was indeed operating on
lowest & nominal frequency values expressed in kHZ, as those were appropriately
amended:
cppc_cpufreq_cpu_init
	|__> cppc_cpufreq_get_cpu_data:
		|__> 	...
			/* Convert the lowest and nominal freq from MHz to KHz */
			cpu_data->perf_caps.lowest_freq *= 1000;
			cpu_data->perf_caps.nominal_freq *= 1000;

So far cppc_perf_to_khz (previously cppc_cpufreq_perf_to_khz) was being called
with the post-processed CPC data (through cppc_cpufreq_get_cpu_data) and thus
guaranteed to be operating on values in kHz.
With the new changes the cppc_perf_to_khz will operate on raw CPC data,
which are expressed in MHz.(as per acpi spec)

---
Best Regards
B.
> > This means that use of both, the capacity_ref_freq and the arch_freq_scale
> > will generate unexpected results, so I guess this should get amended in the
> > preceding patch (?) [1]
> >
> > ---
> > BR
> > B.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20231027080400.56703-4-vincent.guittot@linaro.org/T/#m42daa167097edc190b1cfc05382c385ed801d909
> >
> > >               capacity = raw_capacity[cpu];
> > >               capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> > >                                    capacity_scale);
> > > @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> > >
> > >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> > >
> > > -     for_each_cpu(cpu, policy->related_cpus)
> > > +     for_each_cpu(cpu, policy->related_cpus) {
> > >               per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> > > +             freq_inv_set_max_ratio(cpu,
> > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > +     }
> > >
> > >       if (cpumask_empty(cpus_to_visit)) {
> > >               topology_normalize_cpu_scale();
> > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > > index 38ca6c76af56..ffdf0b7c55fa 100644
> > > --- a/include/linux/arch_topology.h
> > > +++ b/include/linux/arch_topology.h
> > > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> > >  void remove_cpu_topology(unsigned int cpuid);
> > >  void reset_cpu_topology(void);
> > >  int parse_acpi_topology(void);
> > > +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
> > >  #endif
> > >
> > >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > > --
> > > 2.34.1
> > >

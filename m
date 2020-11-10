Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F005C2ADCC1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKJRU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJRU2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 12:20:28 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89055206F1;
        Tue, 10 Nov 2020 17:20:25 +0000 (UTC)
Date:   Tue, 10 Nov 2020 17:20:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        will@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/3] arm64: rebuild sched domains on invariance
 status changes
Message-ID: <X6rL1zv/JuqOVBQu@trantor>
References: <20201027180713.7642-1-ionela.voinescu@arm.com>
 <20201027180713.7642-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027180713.7642-3-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 06:07:12PM +0000, Ionela Voinescu wrote:
> Task scheduler behavior depends on frequency invariance (FI) support and
> the resulting invariant load tracking signals. For example, in order to
> make accurate predictions across CPUs for all performance states, Energy
> Aware Scheduling (EAS) needs frequency-invariant load tracking signals
> and therefore it has a direct dependency on FI. This dependency is known,
> but EAS enablement is not yet conditioned on the presence of FI during
> the built of the scheduling domain hierarchy.
> 
> Before this is done, the following must be considered: while
> arch_scale_freq_invariant() will see changes in FI support and could
> be used to condition the use of EAS, it could return different values
> during system initialisation.
> 
> For arm64, such a scenario will happen for a system that does not support
> cpufreq driven FI, but does support counter-driven FI. For such a system,
> arch_scale_freq_invariant() will return false if called before counter
> based FI initialisation, but change its status to true after it.
> If EAS becomes explicitly dependent on FI this would affect the task
> scheduler behavior which builds its scheduling domain hierarchy well
> before the late counter-based FI init. During that process, EAS would be
> disabled due to its dependency on FI.
> 
> Two points of future early calls to arch_scale_freq_invariant() which
> would determine EAS enablement are:
>  - (1) drivers/base/arch_topology.c:126 <<update_topology_flags_workfn>>
> 		rebuild_sched_domains();
>        This will happen after CPU capacity initialisation.
>  - (2) kernel/sched/cpufreq_schedutil.c:917 <<rebuild_sd_workfn>>
> 		rebuild_sched_domains_energy();
> 		-->rebuild_sched_domains();
>        This will happen during sched_cpufreq_governor_change() for the
>        schedutil cpufreq governor.
> 
> Therefore, before enforcing the presence of FI support for the use of EAS,
> ensure the following: if there is a change in FI support status after
> counter init, use the existing rebuild_sched_domains_energy() function to
> trigger a rebuild of the scheduling and performance domains that in turn
> will determine the enablement of EAS.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

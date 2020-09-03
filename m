Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA99025C404
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgICPBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:01:43 -0400
Received: from foss.arm.com ([217.140.110.172]:34346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgICOFq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 10:05:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953441045;
        Thu,  3 Sep 2020 06:32:05 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363963F66F;
        Thu,  3 Sep 2020 06:32:05 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:32:03 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] cpufreq: improve frequency invariance support
Message-ID: <20200903133203.GA29370@arm.com>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-1-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael, Viresh,

Would it be okay for you to apply this series, as the majority of
changes are in cpufreq? For arch_topology and arm64 changes, they have
been reviewed and acked-by Catalin and Sudeep.

Also, please let me know if I should send v6 with Sudeep's Reviewed-by/s
applied.

Thank you,
Ionela.


On Tuesday 01 Sep 2020 at 21:55:44 (+0100), Ionela Voinescu wrote:
> Hi,
> 
> v4->v5
>  - I've applied Viresh's remaining suggestion and Acked-by/s
>  - v4 can be found at [4]
>  - v5 is based on linux-next 20200828
> 
> Thank you,
> Ionela.
> 
> ---
> v3->v4:
>  - addressing Viresh's comments on patches 1/5 and 3/5, and
>  - with his Acked-by applied for the rest of the patches;
>  - v3 can be found at [3], and
>  - this is based on linux-next 20200827.
> 
> v2->v3
>  - v2 can be found at [2]
>  - 1/5 was introduced to check input frequencies to
>    arch_set_freq_scale() as recommended by Rafael
>  - The previous 2/7 was squashed into 1/7 - now 2/5, with additions to
>    the changelog as suggested by Rafael.
>  - The previous 3/7 (BL_SWITCHER handling) was dropped to be handled
>    in a separate patch. This does not change the current functionality.
>  - The previous 4/7 - now 3/5 is simplified as suggested by Viresh.
>  - 3/5 - cpufreq_supports_freq_invariance() replaces
>    cpufreq_sets_freq_scale(). The meaning chosen for
>    cpufreq_supports_freq_invariance() is whether it can set the frequency
>    scale factor, not whether arch_set_freq_scale() actually does.
>  - 4/5 - Change after Catalin's Ack: The changes to
>    arch_set_thermal_pressure() were dropped as they were done in a separate
>    patch. Therefore this patch now has a subset of the previous changes
>    at 5/7
>  - 5/5 - Change after Catalin's Ack:
>    s/cpufreq_sets_freq_scale/cpufreq_supports_freq_invariance
>  - v3 is based on linux-next 20200814
> 
> 
> v1 -> v2:
>  - v1 can be found at [1]
>  - No cpufreq flags are introduced
>  - Previous patches 2/8 and 3/8 were squashed in this series under 1/7,
>    to ensure bisection.
>  - 2/7 was introduced as a proposal for Viresh's suggestion to use
>    policy->cur in the call to arch_set_freq_scale() and is extended to
>    support drivers that implement the target() callback as well
>  - Additional commit message changes are added to 1/7 and 2/7, to
>    clarify that the definition of arch_set_freq_scale() will filter 
>    settings of the scale factor, if unwanted
>  - 3/7 disables setting of the scale factor for
>    CONFIG_BL_SWITCHER, as Dietmar suggested
>  - Small change introduced in 4/7 to disable cpufreq-based frequency
>    invariance for the users of the default arch_set_freq_scale() call
>    which will not actually set a scale factor
>  - build issue solved (reported by 0day test)
>  - v2 is based on linux-next 20200716
>  - all functional tests in v1 were repeated for v2
> 
> 
> [1] https://lore.kernel.org/lkml/20200701090751.7543-1-ionela.voinescu@arm.com/
> [2] https://lore.kernel.org/lkml/20200722093732.14297-1-ionela.voinescu@arm.com/
> [3] https://lore.kernel.org/lkml/20200824210252.27486-1-ionela.voinescu@arm.com/
> [4] https://lore.kernel.org/lkml/20200828173303.11939-1-ionela.voinescu@arm.com/
> 
> Ionela Voinescu (3):
>   arch_topology: validate input frequencies to arch_set_freq_scale()
>   cpufreq: move invariance setter calls in cpufreq core
>   cpufreq: report whether cpufreq supports Frequency Invariance (FI)
> 
> Valentin Schneider (2):
>   arch_topology, cpufreq: constify arch_* cpumasks
>   arch_topology, arm, arm64: define arch_scale_freq_invariant()
> 
>  arch/arm/include/asm/topology.h        |  1 +
>  arch/arm64/include/asm/topology.h      |  1 +
>  arch/arm64/kernel/topology.c           |  9 ++++++-
>  drivers/base/arch_topology.c           | 13 ++++++++--
>  drivers/cpufreq/cpufreq-dt.c           | 10 +-------
>  drivers/cpufreq/cpufreq.c              | 33 +++++++++++++++++++++++---
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +------
>  drivers/cpufreq/scmi-cpufreq.c         | 12 ++--------
>  drivers/cpufreq/scpi-cpufreq.c         |  6 +----
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++--------
>  include/linux/arch_topology.h          |  4 +++-
>  include/linux/cpufreq.h                |  8 ++++++-
>  12 files changed, 68 insertions(+), 50 deletions(-)
> 
> 
> base-commit: b36c969764ab12faebb74711c942fa3e6eaf1e96
> -- 
> 2.17.1
> 

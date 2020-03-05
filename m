Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15D417A1E2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 10:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCEJGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 04:06:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEJGm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Mar 2020 04:06:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180DE31B;
        Thu,  5 Mar 2020 01:06:41 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2E613F534;
        Thu,  5 Mar 2020 01:06:38 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        pkondeti@codeaurora.org, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 0/7] arm64: ARMv8.4 Activity Monitors support
Date:   Thu,  5 Mar 2020 09:06:20 +0000
Message-Id: <20200305090627.31908-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These patches introduce support for the Activity Monitors Unit (AMU)
CPU extension, an optional extension in ARMv8.4 CPUs. This provides
performance counters intended for system management use. Two of these
counters are then used to compute the frequency scale correction
factor needed to achieve frequency invariance.

With the CONFIG_ARM64_AMU_EXTN enabled the kernel is able to safely
run a mix of CPUs with and without support for the AMU extension.
The AMU capability is unconditionally enabled in the kernel as to
allow any late CPU to use the feature: the cpu_enable function will
be called for all CPUs that match the criteria, including secondary
and hotplugged CPUs, marking this feature as present on that
respective CPU.

To be noted that firmware must implement AMU support when running on
CPUs that present the activity monitors extension: allow access to
the registers from lower exception levels, enable the counters,
implement save and restore functionality. More details can be found
in the documentation.

Given that the activity counters inform on activity on the CPUs, and 
that not all CPUs might implement the extension, for functional and 
security reasons, it's best to disable access to the AMU registers
from userspace (EL0) and KVM guests.

In patch 6/7, two of the AMU counters are used to compute the frequency
scale factor needed to achieve frequency invariance of signals in the
scheduler, based on an interface added to support counter-based
frequency invariance - arch_scale_freq_tick. The interface and update
point for the counter-based frequency scale factor is based on the
similar approach in the patch that introduces frequency invariance
for x86 [1]. 

Testing:
 - Build tested for multiple architectures and defconfigs.
 - AMU feature detection, EL0 and KVM guest access to AMU registers,
   feature support in firmware (version 1.5 and later of the ARM 
   Trusted Firmware) was tested on an Armv8-A Base Platform FVP:
   Architecture Envelope Model [2] (supports version 8.0 to 8.5),
   with the following configurations:

   cluster0.has_arm_v8-4=1
   cluster1.has_arm_v8-4=1
   cluster0.has_amu=1
   cluster1.has_amu=1

v5 -> v6
 - v5 can be found at [7]
 - The current series is based on arm64/master [8]. To be noted that
   the use of counters for frequency invariance is dependent on a patch
   in tip/sched/core [9] - it will build successfully without it but
   counters will not be used for frequency invariance. This series
   applies without issues on both [8] and [9] (or a merge of them)
 - [1/7] kernel parameter removed as Catalin recommended
 - [2/7, 4/7] changelog and documentation changed to remove information
   about the removed kernel parameter
 - [2/7, 3/7, 6/7] collected reviewed-by and acked-by from James,
   Marc and Lukasz.


v4 -> v5:
 - v4 can be found at [6]
 - [1/7] rebased on top of latest tip/sched/core and fixed conflicts;
   applied Reviewed-by from Valentin;
 - [5/7] applied Reviewed-by from Valentin
 - [6/7] applied Valentin and Pavan's suggested fixes; reworked
   arch_cpu_freq_counters (now arch_freq_counters_available) and
   confined it to the arch topology driver as recommended by Valentin
   and Lukasz;

v3 -> v4:
 - v3 can be found at [5]
 - [1/7] renamed and changed format for disable_amu - now amu=<val> as
   Suzuki and Vladimir recommended; removed dynamic allocation for
   amu_cpus as Suzuki recommended;
 - [2-4/7] collected Reviewed-by
 - [5/7] modified changelog and collected Acked-by
 - [6/7] removed cpu_get_max_freq as Lukasz recommended; improved debug
   messages, warnings, and comments, added use of static key, replaced
   validation for possible cpus with filterning of present CPUs - as per
   Valentin's comments.
 - [7/7] modified changelog to avoid confusion related to impact on
   activity monitors use and collected Acked-by

v2 -> v3:
 - v2 can be found at [4]
 - [1/7] used cpumask instead of per-cpu variable to flag AMU presence
   as; introduced disable_amu kernel parameter; removed ftr_id_pfr0 AMU
   bits - recommended by Suzuki.
 - [2/7] replaced obscure label as recommended by Valentin.
 - [3/7] clarified activate_traps_vhe comment
 - [4/7] dropped changes in arm64/cpu-feature-registers.txt; removed
   use of variable names - recommended by Suzuki
 - previous [5/6] - dropped as [1] as added to tip/sched/core
 - [5/7] new patch introduced to cleanly obtain maximum hardware
   frequency from cpufreq
 - [6/7] (previously [6/6]):
   - Removed use of workqueues by limiting the validation work done on
     each cpu to the setting of the reference per-cpu counter variables.
     This is now called directly from cpu_enable (cpufeature.c). Also,
     further CPU, policy and system validation is done in a
     late_initcall_sync function - waits for deferred probe work to
     finish as well to ensure the maximum frequency is set by either
     cpufreq drivers or platform drivers - recommended by Lukasz.
   - Improved AMU use detection for CPUs in arch_set_freq_scale -
     recommended by Lukasz.
   - Properly validated arch_max_freq_scale and added detailed
     documentation for how arch_max_freq_scale and freq_scale are
     obtained based on counters - recommended by Valentin.
   - Overall - limited tight coupling between AMU use and cpufreq
     (use of maximum frequency information and policy validation).
 - [7/7] introduced patch to warn if arch_timer_rate is too low
   - functionality provided by Valentin.

v1 -> v2:
 - v1 can be found at [3]
 - Added patches that use the counters for the scheduler's frequency
   invariance engine
 - In patch arm64: add support for the AMU extension v1 - 
    - Defined an accessor function cpu_has_amu_feat to allow a read
      of amu_feat only from the current CPU, to ensure the safe use
      of the per-cpu variable for the current user (arm64 topology
      driver) and future users.
    - Modified type of amu_feat from bool to u8 to satisfy sparse
      checker's warning 'expression using sizeof _Bool [sparse]',
      as the size of bool is compiler dependent.

[1] https://lore.kernel.org/lkml/20200122151617.531-1-ggherdovich@suse.cz/
[2] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms
[3] https://lore.kernel.org/lkml/20190917134228.5369-1-ionela.voinescu@arm.com/
[4] https://lore.kernel.org/lkml/20191218182607.21607-1-ionela.voinescu@arm.com/
[5] https://lore.kernel.org/lkml/20200211184542.29585-1-ionela.voinescu@arm.com/
[6] https://lore.kernel.org/lkml/20200224141142.25445-1-ionela.voinescu@arm.com/
[7] https://lore.kernel.org/lkml/20200226132947.29738-1-ionela.voinescu@arm.com/
[8] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=bfdc6d91a25f4545bcd1b12e3219af4838142ef1
[9] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=a0f03b617c3b2644d3d47bf7d9e60aed01bd5b10

Ionela Voinescu (7):
  arm64: add support for the AMU extension v1
  arm64: trap to EL1 accesses to AMU counters from EL0
  arm64/kvm: disable access to AMU registers from kvm guests
  Documentation: arm64: document support for the AMU extension
  cpufreq: add function to get the hardware max frequency
  arm64: use activity monitors for frequency invariance
  clocksource/drivers/arm_arch_timer: validate arch_timer_rate

 Documentation/arm64/amu.rst          | 112 +++++++++++++++++
 Documentation/arm64/booting.rst      |  14 +++
 Documentation/arm64/index.rst        |   1 +
 arch/arm64/Kconfig                   |  27 ++++
 arch/arm64/include/asm/assembler.h   |  10 ++
 arch/arm64/include/asm/cpucaps.h     |   3 +-
 arch/arm64/include/asm/cpufeature.h  |   5 +
 arch/arm64/include/asm/kvm_arm.h     |   1 +
 arch/arm64/include/asm/sysreg.h      |  38 ++++++
 arch/arm64/include/asm/topology.h    |   9 ++
 arch/arm64/kernel/cpufeature.c       |  70 +++++++++++
 arch/arm64/kernel/topology.c         | 180 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c          |  14 ++-
 arch/arm64/kvm/sys_regs.c            |  93 +++++++++++++-
 arch/arm64/mm/proc.S                 |   3 +
 drivers/base/arch_topology.c         |  12 ++
 drivers/clocksource/arm_arch_timer.c |  18 ++-
 drivers/cpufreq/cpufreq.c            |  20 +++
 include/linux/arch_topology.h        |   2 +
 include/linux/cpufreq.h              |   5 +
 20 files changed, 630 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/arm64/amu.rst


base-commit: bfdc6d91a25f4545bcd1b12e3219af4838142ef1
-- 
2.17.1


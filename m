Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A1321079B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGAJJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgGAJJF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0E331B;
        Wed,  1 Jul 2020 02:09:04 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 619D23F68F;
        Wed,  1 Jul 2020 02:09:02 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] cpufreq: improve frequency invariance support
Date:   Wed,  1 Jul 2020 10:07:43 +0100
Message-Id: <20200701090751.7543-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

I've combined in this series some recent work on Frequency Invariance
(FI) from Valentin and myself to create what we believe to be some nice
improvements which also enable the adoption of schedutil as the default
cpufreq governor for arm and arm64.

Therefore, the series is structured as follows:
  - (1) patches 1-3 move the frequency scaling updates from the cpufreq
    drivers to the cpufreq core,
  - (2) patch 4 fixes the FI scale factor setting for the vexpress-spc
    driver, also showing that this driver is atypical,
  - (3) patches 5-7 enable proper reporting on whether the system
    supports frequency invariance (either cpufreq or counter-driven),
  - (4) patch 8 makes schedutil the default governor for arm and arm64
    systems.

Additionally, I will submit separately patches that condition Energy
Aware Scheduling (EAS) enablement on FI support. For now I've kept them
out of this series to keep it focused mostly on cpufreq.

The need for (1) is two-fold: 
 - First of all, the call to arch_set_freq_scale(), the update function
   for the Frequency Invariance Enging (FIE) scale factor, is often
   forgotten by cpufreq drivers as this link to the scheduler does not
   seem as a logical step to consider in its implementation.
   (for example 
    commit ada54f35b227 ("cpufreq: qcom-hw: invoke frequency-invariance
     setter function"))

   Therefore, given that a majority of drivers already provide the
   information needed by this function call back to the cpufreq core,
   moving it there provides by default the functionality that the
   scheduler's FIE needs.

 - Secondly, this enables cpufreq to report support for FI (3).

The patch at (2) provides a fix for the vexpress-spc driver, when the
big.LITTLE switcher is enabled, also showing that this case is atypical
and cannot benefit from the move of the FI scale setting to the cpufreq
core. For this reason, a new flag is introduced to allow drivers to
flag custom support for FI. While other drivers could benefit from the
presence of this flag as described in patch 2/8, it would be good to
reflect on whether this old functionality deserves us to introduce an
additional flag in cpufreq. Until this is discussed, I've chosen to
handle and fix this driver in this series as well.

The functionality at (3) fixes a silent issue for arm and arm64 systems:
if we look at the definition of arch_scale_freq_invariant(), schedutil
considers these systems frequency invariant because they #define
arch_scale_freq_capacity(), even for cases where the cpufreq driver in
use doesn't drive the frequency invariance engine (FIE), i.e. calls
arch_set_freq_scale().

Therefore the patches at (3) are necessary to be able to switch to
schedutil as the default governor (4) and to later condition EAS
enablement, with the confidence that arch_scale_freq_invariant() now
properly reports FI support.

Given that this functionality touches multiple cpufreq drivers, I've
tested on a range of platforms to ensure that functionality is
maintained.

This series applies on linux-next-20200629.

Testing:

Preliminary tests on all patches: build tests for multiple architectures,
sparse static analysis, LTP tests, LISA synthetics (test suite detailed
at [1]).

Other tests on affected platforms:

 - Juno (R0) - scpi-cpufreq
   root@buildroot:~# dmesg | grep -i invariance
   [    5.376523] cpufreq: cpufreq_register_driver: Driver scpi-cpufreq can provide frequency invariance
   root@buildroot:~# cd /sys/devices/system/cpu/cpufreq/policy0
   root@buildroot:~# cat scaling_governor
   userspace
   root@buildroot:~# cat scaling_available_frequencies
   450000 575000 700000 775000 850000
   root@buildroot:~# echo 450000 > scaling_setspeed
   [  953.861317] Scale for cpus 0,3-5: 542
   root@buildroot:~# echo 850000 > scaling_setspeed
   [  971.780739] Scale for cpus 0,3-5: 1024
   root@buildroot:~# cd ../policy1
   root@buildroot:~# cat scaling_available_frequencies
   450000 625000 800000 950000 1100000
   root@buildroot:~# echo 450000 > scaling_setspeed
   [ 1084.867760] Scale for cpus 1-2: 418
   root@buildroot:~# echo 1100000 > scaling_setspeed
   [ 1094.447724] Scale for cpus 1-2: 1024

 - Juno (R2) - scmi (cpufreq driver)
   root@buildroot:~# dmesg | grep scmi
   [    5.707341] arm-scmi firmware:scmi: SCMI Protocol v1.0 'arm:arm' Firmware version 0x2060000
   [    5.987594] cpufreq: cpufreq_register_driver: Driver scmi can provide frequency invariance
   root@buildroot:~# dmesg | grep -i invariance
   [    5.987594] cpufreq: cpufreq_register_driver: Driver scmi can provide frequency invariance
   root@buildroot:~# cd /sys/devices/system/cpu/cpufreq/policy0
   root@buildroot:~# cat scaling_available_frequencies
   450000 800000 950000
   root@buildroot:~# echo 450000 > scaling_setspeed
   [   65.691303] Scale for cpus 0,3-5: 485
   root@buildroot:~# echo 850000 > scaling_setspeed
   [  697.538250] Scale for cpus 0,3-5: 1024
   root@buildroot:~# cd ../policy1
   root@buildroot:~# cat scaling_available_frequencies
   600000 1000000 1200000
   root@buildroot:~# echo 600000 > scaling_setspeed
   [  711.874918] Scale for cpus 1-2: 512
   root@buildroot:~# echo 1200000 > scaling_setspeed
   [  715.955159] Scale for cpus 1-2: 1024

 - DB845c - qcom-cpufreq-hw
   root@buildroot:~# dmesg | grep -i invariance
   [    5.136076] cpufreq: cpufreq_register_driver: Driver qcom-cpufreq-hw can provide frequency invariance
   root@buildroot:~# cd /sys/devices/system/cpu/cpufreq/policy0
   root@buildroot:~# cat scaling_available_frequencies
   300000 403200 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 1228800 1324800 1420800 1516800 1612800 1689600 1766400
   root@buildroot:~# echo 300000 > scaling_setspeed
   [   94.027825] Scale for cpus 0-3: 173
   root@buildroot:~# echo 1766400 > scaling_setspeed
   [  119.680565] Scale for cpus 0-3: 1024
   root@buildroot:~# cd ../policy4/
   root@buildroot:~# cat scaling_available_frequencies
   825600 902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 2400000 2476800 2553600 2649600
   root@buildroot:~# echo 825600 > scaling_setspeed
   [  158.759343] Scale for cpus 4-7: 319
   root@buildroot:~# echo 2649600 > scaling_setspeed
   [  160.766545] Scale for cpus 4-7: 1024

 - Hikey960 - cpufreq-dt
   root@buildroot:~# dmesg | grep -i invariance
   [    4.706909] cpufreq: cpufreq_register_driver: Driver cpufreq-dt can provide frequency invariance
   root@buildroot:~# cd /sys/devices/system/cpu/cpufreq/policy0
   root@buildroot:~# cat scaling_available_frequencies
   533000 999000 1402000 1709000 1844000
   root@buildroot:~# echo 533000 > scaling_setspeed
   [   56.732673] Scale for cpus 0-3: 295
   root@buildroot:~# echo 1844000 > scaling_setspeed
   [   64.657238] Scale for cpus 0-3: 1024
   root@buildroot:~# cd ../policy4/
   root@buildroot:~# cat scaling_available_frequencies
   903000 1421000 1805000 2112000 2362000
   root@buildroot:~# echo 903000 > scaling_setspeed
   [   79.847937] Scale for cpus 4-7: 391
   root@buildroot:~# echo 2362000 > scaling_setspeed
   [   90.545476] Scale for cpus 4-7: 1024

 - TC2 - vexpress-spc (!bL switcher enabled)
   root@buildroot:~# dmesg | grep -i invariance
   [    9.250942] cpufreq: cpufreq_register_driver: Driver vexpress-spc can provide frequency invariance
   root@buildroot:~# cd /sys/devices/system/cpu/cpufreq/policy0
   root@buildroot:~# cat scaling_governor
   userspace
   root@buildroot:~# cat scaling_available_frequencies
   350000 400000 500000 600000 700000 800000 900000 1000000
   root@buildroot:~# echo 350000 > scaling_setspeed
   [  809.254517] Scale for cpus 0,3-4: 358
   root@buildroot:~# echo 1000000 > scaling_setspeed
   [  818.744782] Scale for cpus 0,3-4: 1024
   root@buildroot:~# cd ../policy1/
   root@buildroot:~# cat scaling_available_frequencies
   500000 600000 700000 800000 900000 1000000 1100000 1200000
   root@buildroot:~# echo 500000 > scaling_setspeed
   [ 1173.785907] Scale for cpus 1-2: 426
   root@buildroot:~# echo 1200000 > scaling_setspeed
   [ 1180.177035] Scale for cpus 1-2: 1024

 - TC2 - vexpress-spc (bL switcher enabled)

   before patches:
    root@buster-armhf:~# echo 175000 > policy0/scaling_setspeed
    [  376.515629] vexpress_spc_cpufreq: Setting freq scale 0: 175000*1024/1200000=149 (when it should be 350000*1024/1000000=358)
    --> still using the little CPU from the pair (0 - LITTLE, 1 - big)

    root@buster-armhf:~# echo 175000 > policy3/scaling_setspeed
    [  400.765352] vexpress_spc_cpufreq: Setting freq scale 3: 175000*1024/1200000=149 (when it should be 350000*1024/1000000=358)
    --> still using the little CPU in the pair (3 - LITTLE, 2 - big)

    root@buster-armhf:~# echo 300000 > policy0/scaling_setspeed
    [  456.155104] vexpress_spc_cpufreq: Setting freq scale 0: 300000*1024/1200000=256 (when it should be 600000*1024/1000000=614)
    --> Still using the little CPU in the pair (0 - LITTLE, 1 - big)
    --> Now policy 0 requested 300000 while policy1 requested 175000.
    The rate in the clock domain is now virtual-300000 = 600000.

    root@buster-armhf:~# echo 700000 > policy0/scaling_setspeed
    [  506.617496] vexpress_spc_cpufreq: Setting freq scale 0: 700000*1024/1200000 - correct.
    --> Switch to using the big CPU in the pair. The virtual frequency
    is equal to the actual frequency and the scale factor is correct.
    --> But, the request of virtual-300000 from this group on the
    little clock domain goes away, so the rate should reduce to
    virtual-175000 = 350000.
    [  506.578275] vexpress_spc_cpufreq: ve_spc_cpufreq_set_rate recalc: clk_set_rate DONE: 0, new_cluster 0 old cluster: 1 rate 700000 new_rate 350000.
    --> arch_set_freq_scale() should be called here to reduce
    the scale of pair (0, 1) but it is not.

   after patches:
    root@buildroot:~# echo 175000 > policy0/scaling_setspeed
    [  520.078181] Scale changed for CPU 0 to 358
    [  520.130559] Scale changed for CPU 3 to 853
    --> Default was 1000000/1200000 which is why CPU 3 is at 853
    root@buildroot:~# echo 175000 > policy3/scaling_setspeed
    [  577.250912] Scale changed for CPU 3 to 358
    root@buildroot:~# echo 300000 > policy0/scaling_setspeed
    [  670.716195] Scale changed for CPU 0 to 614
    [  670.747971] Scale changed for CPU 3 to 614
    root@buildroot:~# echo 700000 > policy0/scaling_setspeed
    [  710.746860] Scale changed for CPU 0 to 597
    [  710.836288] Scale changed for CPU 3 to 358


[1] https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development

Ionela Voinescu (4):
  cpufreq: allow drivers to flag custom support for freq invariance
  cpufreq,drivers: remove setting of frequency scale factor
  cpufreq,vexpress-spc: fix Frequency Invariance (FI) for bL switching
  cpufreq: report whether cpufreq supports Frequency Invariance (FI)

Valentin Schneider (4):
  cpufreq: move invariance setter calls in cpufreq core
  arch_topology,cpufreq,sched/core: constify arch_* cpumasks
  arch_topology,arm64: define arch_scale_freq_invariant()
  cpufreq: make schedutil the default for arm and arm64

 arch/arm64/kernel/topology.c           |  9 ++++-
 drivers/base/arch_topology.c           | 10 ++++-
 drivers/cpufreq/Kconfig                |  2 +-
 drivers/cpufreq/cpufreq-dt.c           | 10 +----
 drivers/cpufreq/cpufreq.c              | 51 +++++++++++++++++++++++---
 drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +----
 drivers/cpufreq/scmi-cpufreq.c         | 18 +++------
 drivers/cpufreq/scpi-cpufreq.c         |  3 --
 drivers/cpufreq/vexpress-spc-cpufreq.c | 26 ++++++++++++-
 include/linux/arch_topology.h          |  8 +++-
 include/linux/cpufreq.h                | 18 ++++++++-
 kernel/sched/core.c                    |  2 +-
 12 files changed, 117 insertions(+), 49 deletions(-)


base-commit: c28e58ee9dadc99f79cf16ca805221feddd432ad
-- 
2.17.1


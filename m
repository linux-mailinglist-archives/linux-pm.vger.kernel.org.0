Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E63BD790
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGFNVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:42098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhGFNVS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F95D1FB;
        Tue,  6 Jul 2021 06:18:39 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 233EE3F73B;
        Tue,  6 Jul 2021 06:18:36 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 0/6] Introduce Active Stats framework with CPU performance statistics
Date:   Tue,  6 Jul 2021 14:18:22 +0100
Message-Id: <20210706131828.22309-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set introduces a new mechanism: Active Stats framework (ASF), which
gathers and maintains statistics of CPU performance - time residency at each
performance state.

The ASF tracks all the frequency transitions as well as CPU
idle entry/exit events for all CPUs. Based on that it accounts the active
(non-idle) residency time for each CPU at each frequency. This information can
be used by some other subsystems (like thermal governor) to enhance their
estimations about CPU usage at a given period.

Does it fix something in mainline?
Yes, there is thermal governor Intelligent Power Allocation (IPA), which
estimates the CPUs power used in the past. IPA is sampling the CPU utilization
and frequency and relies on the info available at the time of sampling
and this imposes the estimation errors.
The use of ASF solve the issue and enables IPA to make better estimates.

Why it couldn't be done using existing frameworks?
The CPUFreq and CPUIdle statistics are not combined, so it is not possible
to derive the information on how long exactly the CPU was running with a given
frequency. This new framework combines that information and provides
it in a handy way. IMHO it has to be implemented as a new framework, next to
CPUFreq and CPUIdle, due to a clean design and not just hooks from thermal
governor into the frequency change and idle code paths.

Tha patch 4/6 introduces a new API for cooling devices, which allows to
stop tracking the freq and idle statistics.

The patch set contains also a patches 5/6 6/6 which adds the new power model
based on ASF into the cpufreq cooling (used by thermal governor IPA).
It is added as ifdef option, since Active Stats might be not compiled in.
The ASF is a compile time option, but that might be changed and IPA could
select it, which would allow to remove some redundant code from
cpufreq_cooling.c.

Comments and suggestions are very welcome.

Changelog:
v2:
- added interface for cooling devices to support custom setup used
  by IPA, which requires Active Stats alocated and running; when IPA
  is not working Active Stats are deactivated
- added mechanism to stop tracking CPU freq and idle changes in Active Stats
  when there are no clients of this information
- removed spinlock in idle path (and hotplug) and redesigned how Active Stats
  Monitor (ASM) tracks the changed performance; ASM no longer can update
  local ASM stats in periodic check; only CPU entering/exiting idle can do that
v1:
- basic implementation which can be found at [1]


Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20210622075925.16189-1-lukasz.luba@arm.com/

Lukasz Luba (6):
  PM: Introduce Active Stats framework
  cpuidle: Add Active Stats calls tracking idle entry/exit
  cpufreq: Add Active Stats calls tracking frequency changes
  thermal: Add interface to cooling devices to handle governor change
  thermal/core/power allocator: Prepare power actors and calm down when
    not used
  thermal: cpufreq_cooling: Improve power estimation based on Active
    Stats framework

 Documentation/power/active_stats.rst  | 128 ++++
 Documentation/power/index.rst         |   1 +
 MAINTAINERS                           |   8 +
 drivers/cpufreq/cpufreq.c             |   5 +
 drivers/cpuidle/cpuidle.c             |   5 +
 drivers/thermal/cpufreq_cooling.c     | 132 ++++
 drivers/thermal/gov_power_allocator.c |  71 ++
 include/linux/active_stats.h          | 131 ++++
 include/linux/thermal.h               |   1 +
 kernel/power/Kconfig                  |   9 +
 kernel/power/Makefile                 |   1 +
 kernel/power/active_stats.c           | 921 ++++++++++++++++++++++++++
 12 files changed, 1413 insertions(+)
 create mode 100644 Documentation/power/active_stats.rst
 create mode 100644 include/linux/active_stats.h
 create mode 100644 kernel/power/active_stats.c

-- 
2.17.1


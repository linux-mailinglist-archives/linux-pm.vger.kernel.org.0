Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA993AFE8F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFVIBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 04:01:55 -0400
Received: from foss.arm.com ([217.140.110.172]:44076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFVIBy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 04:01:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B0CD6E;
        Tue, 22 Jun 2021 00:59:36 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55A323F718;
        Tue, 22 Jun 2021 00:59:34 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH 0/4] Introduce Active Stats framework with CPU performance statistics
Date:   Tue, 22 Jun 2021 08:59:21 +0100
Message-Id: <20210622075925.16189-1-lukasz.luba@arm.com>
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

The patch set contains also a patch 4/4 which adds the new power model based
on ASF into the cpufreq cooling (used by thermal governor IPA).
It is added as ifdef option, since Active Stats might be not compiled in.
The ASF is a compile time option, but that might be changed and IPA could
select it, which would allow to remove some redundant code from
cpufreq_cooling.c.

Comments and suggestions are very welcome.

Regards,
Lukasz Luba

Lukasz Luba (4):
  PM: Introduce Active Stats framework
  cpuidle: Add Active Stats calls tracking idle entry/exit
  cpufreq: Add Active Stats calls tracking frequency changes
  thermal: cpufreq_cooling: Improve power estimation based on Active
    Stats framework

 Documentation/power/active_stats.rst | 128 +++++
 Documentation/power/index.rst        |   1 +
 MAINTAINERS                          |   8 +
 drivers/cpufreq/cpufreq.c            |   5 +
 drivers/cpuidle/cpuidle.c            |   5 +
 drivers/thermal/cpufreq_cooling.c    | 120 ++++-
 include/linux/active_stats.h         | 119 +++++
 kernel/power/Kconfig                 |   9 +
 kernel/power/Makefile                |   1 +
 kernel/power/active_stats.c          | 751 +++++++++++++++++++++++++++
 10 files changed, 1146 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/power/active_stats.rst
 create mode 100644 include/linux/active_stats.h
 create mode 100644 kernel/power/active_stats.c

-- 
2.17.1


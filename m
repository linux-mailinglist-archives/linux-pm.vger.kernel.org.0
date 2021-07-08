Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4679B3BF807
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhGHKMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 06:12:03 -0400
Received: from foss.arm.com ([217.140.110.172]:55276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhGHKMC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990A2ED1;
        Thu,  8 Jul 2021 03:09:20 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C4C63F5A1;
        Thu,  8 Jul 2021 03:09:19 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v4 0/9] Inefficient OPPs
Date:   Thu,  8 Jul 2021 11:08:57 +0100
Message-Id: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here's the new patch-set version that brings support for skipping
inefficiencies found by the Energy Model. This version doesn't bring
changes for all the drivers that could benefit from this work at the
moment. I'll do that in the next version or in a separated patch-set.
Also, it's been discussed that enabling RELATION_E should be a driver
flag. This sadly needs to be read in functions that do not have access to
cpufreq_driver. Hence, I created a new policy flag instead.

A bit of context:

We (Power team in Arm) are working with an experimental kernel for the
Google's Pixel4 to evaluate and improve the current mainline performance
and energy consumption on a real life device with Android.

The SD855 SoC found in this phone has several OPPs that are inefficient.
I.e. despite a lower frequency, they have a greater cost. (That cost being
fmax * OPP power / OPP freq). This issue is twofold. First of course,
running a specific workload at an inefficient OPP is counterproductive
since it wastes wasting energy. But also, inefficient OPPs make a
performance domain less appealing for task placement than it really is.

We evaluated the change presented here by running 30 iterations of Android
PCMark "Work 2.0 Performance". While we did not see any statistically
significant performance impact, this change allowed to drastically improve
the idle time residency.


                           |   Running   |  WFI [1]  |    Idle   |
   ------------------------+-------------+-----------+-----------+
   Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
   ------------------------+-------------+-----------+-----------+
   Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
   ------------------------+-------------+-----------+-----------+
   Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
   ------------------------+-------------+-----------+-----------+

On the SD855, the inefficient OPPs are found on the little cluster. By
removing them from the Energy Model, we make the most efficient CPUs more
appealing for task placement, helping to reduce the running time for the
medium and big CPUs. Increasing idle time is crucial for this platform due
to the substantial energy cost differences among the clusters. Also,
despite not appearing in the statistics (the idle driver used here doesn't
report it), we can speculate that we also improve the cluster idle time.

[1] WFI: Wait for interrupt.

Changelog since v3:
  - New freq-table relation CPUFREQ_RELATION_E.
  - New CPUFreq driver flag CPUFREQ_READ_ENERGY_MODEL.
  - EM flag to skip or not inefficiencies (driven by CPUFreq).
  - Fix infinite loop in set_freq_table_efficiencies().

Changelog since v2:
  - Add separated support for inefficiencies into CPUFreq.
  - Collect Reviewed-by for the first patch.

Changelog since v1:
  - Remove the Look-up table as the numbers weren't strong enough to
    justify the implementation.
  - Split the patch.

Vincent Donnefort (9):
  PM / EM: Fix inefficient states detection
  PM / EM: Mark inefficient states
  PM / EM: Extend em_perf_domain with a flag field
  PM / EM: Allow skipping inefficient states
  cpufreq: Add an interface to mark inefficient frequencies
  cpufreq: Add a new freq-table relation CPUFREQ_RELATION_E
  cpufreq: CPUFREQ_RELATION_E in schedutil ondemand and conservative
  cpufreq: Add driver flag CPUFREQ_READ_ENERGY_MODEL
  cpufreq: dt: Add CPUFREQ_READ_ENERGY_MODEL

 drivers/cpufreq/cpufreq-dt.c           |  2 +-
 drivers/cpufreq/cpufreq.c              | 67 ++++++++++++++++++++++++++++++++-
 drivers/cpufreq/cpufreq_conservative.c |  2 +-
 drivers/cpufreq/cpufreq_ondemand.c     |  4 +-
 drivers/cpufreq/freq_table.c           | 57 +++++++++++++++++++++++++++-
 include/linux/cpufreq.h                | 50 +++++++++++++++++++++++--
 include/linux/energy_model.h           | 68 +++++++++++++++++++++++++++++-----
 kernel/power/energy_model.c            | 46 ++++++++++++++---------
 kernel/sched/cpufreq_schedutil.c       |  2 +-
 9 files changed, 260 insertions(+), 38 deletions(-)

-- 
2.7.4


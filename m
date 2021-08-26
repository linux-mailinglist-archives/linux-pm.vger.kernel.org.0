Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBA3F83C8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHZIhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:08 -0400
Received: from foss.arm.com ([217.140.110.172]:41500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240351AbhHZIhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CD1D6E;
        Thu, 26 Aug 2021 01:36:17 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BE563F5A1;
        Thu, 26 Aug 2021 01:36:16 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 0/8] inefficient OPPs
Date:   Thu, 26 Aug 2021 09:35:36 +0100
Message-Id: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here's the new version for the inefficient OPPs. This patch-set is based on the
following series from Viresh:

  [PATCH V3 0/9] Add callback to register with energy model
  https://lore.kernel.org/linux-arm-msm/cover.1628742634.git.viresh.kumar@linaro.org/

The main changes are:

 1. The EM inefficiencies reading is now done in the .register_em callback,
    introduced by the patch-set above.

 2. Inefficiencies will be skipped for all governors declaring
    CPUFREQ_GOV_DYNAMIC_SWITCHING, no matter the relation.

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

Changelog since v4:
  - Remove CPUFREQ_RELATION_E.
  - Skip inefficient OPPs for all governors with CPUFREQ_GOV_DYNAMIC_SWITCHING
  - Remove CPUFREQ_READ_ENERGY_MODEL in favor of the register_em callback.

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

Vincent Donnefort (8):
  PM / EM: Fix inefficient states detection
  PM / EM: Mark inefficient states
  PM / EM: Extend em_perf_domain with a flag field
  PM / EM: Allow skipping inefficient states
  cpufreq: Add an interface to mark inefficient frequencies
  cpufreq: Skip inefficient frequencies
  cpufreq: Read inefficiencies from EM
  cpufreq: scmi: Read inefficiencies from EM

 drivers/cpufreq/cpufreq.c      | 13 ++++++
 drivers/cpufreq/freq_table.c   | 46 +++++++++++++++++++++
 drivers/cpufreq/scmi-cpufreq.c |  7 ++--
 include/linux/cpufreq.h        | 90 +++++++++++++++++++++++++++++++++++++++---
 include/linux/energy_model.h   | 68 ++++++++++++++++++++++++++-----
 kernel/power/energy_model.c    | 46 ++++++++++++---------
 6 files changed, 234 insertions(+), 36 deletions(-)

-- 
2.7.4


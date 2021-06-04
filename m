Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C295C39B789
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhFDLIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:08:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhFDLIJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EE512FC;
        Fri,  4 Jun 2021 04:06:23 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F37333F73D;
        Fri,  4 Jun 2021 04:06:21 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 0/6] EM / PM: Inefficient OPPs
Date:   Fri,  4 Jun 2021 12:05:55 +0100
Message-Id: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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


Changelog since v2:
  - Add separated support for inefficiencies into CPUFreq.
  - Collect Reviewed-by for the first patch.

Changelog since v1:
  - Remove the Look-up table as the numbers weren't strong enough to justify the
    implementation.
  - Split the patch.

Vincent Donnefort (6):
  PM / EM: Fix inefficient states detection
  PM / EM: Mark inefficient states
  cpufreq: Add an interface to mark inefficient frequencies
  cpufreq: Skip inefficient frequencies in cpufreq_driver_resolve_freq()
  cpufreq: Mark inefficient frequencies using the Energy Model
  PM / EM: Skip inefficient states

 drivers/cpufreq/cpufreq.c    | 36 +++++++++++++++++++++++++++++
 drivers/cpufreq/freq_table.c | 55 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/cpufreq.h      | 15 +++++++++++-
 include/linux/energy_model.h | 50 +++++++++++++++++++++++++++++++++++-----
 kernel/power/energy_model.c  | 27 +++++++++-------------
 5 files changed, 159 insertions(+), 24 deletions(-)

-- 
2.7.4


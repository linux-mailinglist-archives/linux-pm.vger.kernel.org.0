Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8717F38
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEHRnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:09 -0400
Received: from foss.arm.com ([217.140.101.70]:41780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHRnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E7580D;
        Wed,  8 May 2019 10:43:08 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD4353F575;
        Wed,  8 May 2019 10:43:06 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 0/7] sched/cpufreq: Make schedutil energy aware
Date:   Wed,  8 May 2019 18:42:54 +0100
Message-Id: <20190508174301.4828-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Make schedutil cpufreq governor energy-aware.

- patch 1 introduces a function to retrieve a frequency given a base
  frequency and an energy cost margin.
- patch 2 links Energy Model perf_domain to sugov_policy.
- patch 3 updates get_next_freq() to make use of the Energy Model.
- patch 4 moves a static function around in cpufreq_schedutil.c to make
  it available for subsequent patch.
- patch 5 updates sugov_cpu_is_busy() to make it useable for shared
  cpufreq policies.
- patch 6 improves sugov_cpu_is_busy() to avoid some pitfalls when used
  from shared policies.
- patch 7 makes use of sugov_cpu_is_busy() for frequency selection of
  shared cpufreq policies.

The benefits of using the EM in schedutil are twofold:

1) Selecting the highest possible frequency for a given cost. Some
   platforms can have lower frequencies that are less efficient than
   higher ones, in which case they should be skipped for most purposes.
   They can still be useful to give more freedom to thermal throttling
   mechanisms, but not under normal circumstances.
   note: the EM framework will warn about such OPPs "hertz/watts ratio
   non-monotonically decreasing"

2) Drive the frequency selection with power in mind, in addition to
   maximizing the utilization of the non-idle CPUs in the system.

Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
enabled in schedutil by
"sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".

Point 2) is enabled in
"sched/cpufreq: Boost schedutil frequency ramp up". It allows using
higher frequencies when a CPU is "busy" in the policy, reusing the
existing sugov_cpu_is_busy() schedutil heuristic.  "busy" is defined
here as not having any idle time since the last increase in frequency.
The benefits of that are:

* Boosting the frequency when it (seems) needed by a CPU to finish its
  allocated work. That shortens the frequency ramp up duration, which in
  turns allows the utilization signal to reach stable values quicker.
  Since the allowed frequency boost is bounded in energy, it will behave
  consistently across platforms, regardless of the OPP cost range.

* The boost is only transient, and should not impact a lot the energy
  consumed of workloads with very stable utilization signals.


This has been ligthly tested with a rtapp task ramping from 10% to 75%
utilisation on a big core. Improvements in frequency ramp-up time are
somehow diminished by the shape of the utilisation signal, which gives a
big oscillation to the signal after a fast ramp up with idle time. It
however improves the time it takes to reach the final frequency, but
some activations are still missed due to strong frequency decrease right
after ramping up.

Douglas RAILLARD (7):
  PM: Introduce em_pd_get_higher_freq()
  sched/cpufreq: Attach perf domain to sugov policy
  sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
  sched/cpufreq: Move up sugov_cpu_is_busy()
  sched/cpufreq: sugov_cpu_is_busy for shared policy
  sched/cpufreq: Improve sugov_cpu_is_busy accuracy
  sched/cpufreq: Boost schedutil frequency ramp up

 include/linux/energy_model.h     |  48 +++++++++++
 kernel/sched/cpufreq_schedutil.c | 136 +++++++++++++++++++++++++++----
 2 files changed, 166 insertions(+), 18 deletions(-)

-- 
2.21.0

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17A6145AE2
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVRgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:07 -0500
Received: from foss.arm.com ([217.140.110.172]:58962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55FE71FB;
        Wed, 22 Jan 2020 09:36:06 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06B633F6C4;
        Wed, 22 Jan 2020 09:36:04 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Date:   Wed, 22 Jan 2020 17:35:32 +0000
Message-Id: <20200122173538.1142069-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make schedutil cpufreq governor energy-aware.

- patch 1 introduces a function to retrieve a frequency given a base
  frequency and an energy cost margin.
- patch 2 links Energy Model perf_domain to sugov_policy.
- patch 3 updates get_next_freq() to make use of the Energy Model.
- patch 4 adds sugov_cpu_ramp_boost() function.
- patch 5 updates sugov_update_(single|shared)() to make use of
  sugov_cpu_ramp_boost().
- patch 6 introduces a tracepoint in get_next_freq() for
  testing/debugging. Since it's not a trace event, it's not exposed to
  userspace in a directly usable way, allowing for painless future
  updates/removal.

The benefits of using the EM in schedutil are twofold:

1) Selecting the highest possible frequency for a given cost. Some
   platforms can have lower frequencies that are less efficient than
   higher ones, in which case they should be skipped for most purposes.
   They can still be useful to give more freedom to thermal throttling
   mechanisms, but not under normal circumstances.
   note: the EM framework will warn about such OPPs "hertz/watts ratio
   non-monotonically decreasing"

2) Driving the frequency selection with power in mind, in addition to
   maximizing the utilization of the non-idle CPUs in the system.

Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
enabled in schedutil by
"sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".

Point 2) is enabled in
"sched/cpufreq: Boost schedutil frequency ramp up". It allows using
higher frequencies when it is known that the true utilization of
currently running tasks is exceeding their previous stable point.
The benefits are:

* Boosting the frequency when the behavior of a runnable task changes,
  leading to an increase in utilization. That shortens the frequency
  ramp up duration, which in turns allows the utilization signal to
  reach stable values quicker.  Since the allowed frequency boost is
  bounded in energy, it will behave consistently across platforms,
  regardless of the OPP cost range.

* The boost is only transient, and should not impact a lot the energy
  consumed of workloads with very stable utilization signals.

This has been ligthly tested with a rtapp task ramping from 10% to 75%
utilisation on a big core.

v1 -> v2:

  * Split the new sugov_cpu_ramp_boost() from the existing
    sugov_cpu_is_busy() as they seem to seek a different goal.

  * Implement sugov_cpu_ramp_boost() based on CFS util_avg and
    util_est_enqueued signals, rather than using idle calls count.
    This makes the ramp boost much more accurate in finding boost
    opportunities, and give a "continuous" output rather than a boolean.

  * Add EM_COST_MARGIN_SCALE=1024 to represent the
    margin values of em_pd_get_higher_freq().

v2 -> v3:

  * Check util_avg >= sg_cpu->util_avg in sugov_cpu_ramp_boost_update()
    to avoid boosting when the utilization is decreasing.

  * Add a tracepoint for testing. 

v3 -> v4:

  * em_pd_get_higher_freq() now interprets the margin as absolute,
    rather than relative to the cost of the base frequency.

  * Modify misleading comment in em_pd_get_higher_freq() since min_freq
    can actually be higher than the max available frequency in normal
    operations.

Douglas RAILLARD (6):
  PM: Introduce em_pd_get_higher_freq()
  sched/cpufreq: Attach perf domain to sugov policy
  sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
  sched/cpufreq: Introduce sugov_cpu_ramp_boost
  sched/cpufreq: Boost schedutil frequency ramp up
  sched/cpufreq: Add schedutil_em_tp tracepoint

 include/linux/energy_model.h     |  56 ++++++++++++++
 include/trace/events/power.h     |   9 +++
 kernel/sched/cpufreq_schedutil.c | 124 +++++++++++++++++++++++++++++--
 3 files changed, 182 insertions(+), 7 deletions(-)

-- 
2.24.1


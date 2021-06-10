Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4C3A2EF1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 17:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFJPFd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 11:05:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFJPFc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 11:05:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CC2D106F;
        Thu, 10 Jun 2021 08:03:36 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80C2B3F719;
        Thu, 10 Jun 2021 08:03:32 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 0/3] Add allowed CPU capacity knowledge to EAS
Date:   Thu, 10 Jun 2021 16:03:21 +0100
Message-Id: <20210610150324.22919-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The patch set v3 aims to add knowledge about reduced CPU capacity
into the Energy Model (EM) and Energy Aware Scheduler (EAS). Currently the
issue is that SchedUtil CPU frequency and EM frequency are not aligned,
when there is a CPU thermal capping. This causes an estimation error.
This patch set provides the information about allowed CPU capacity
into the EM (thanks to thermal pressure information). This improves the
energy estimation. More info about this mechanism can be found in the
patches comments.

There is a new patch 1/3 in this v3, addressing an issue triggered for
hotplugged out CPU. The offline CPUs don't have proper value stored by
thermal framework in their per-cpu thermal_pressure. Thus, the thermal
pressure geometric series machinery reads 'stale' value when the CPU
is back online. The patch fixes it, so all mechanisms like
load balance, not only EAS, would have more accurate CPU capacity
information for those 'returning online' CPUs. I've added also related
cpu cooling maintainers to the CC of this patch set.

Changelog:
v3:
- switched to 'raw' per-cpu thermal pressure instead of thermal pressure
  geometric series signal, since it more suited for purpose of
  this use case: predicting SchedUtil frequency (Vincent, Dietmar)
- added more comment in the patch 2/3 header for use case when thermal
  capping might be applied even the CPUs are not over-utilized
  (Dietmar)
- added ACK tag from Rafael for SchedUtil part
- added a fix patch for offline CPUs in cpufreq_cooling and per-cpu
  thermal_pressure missing update
v2 [2]:
- clamp the returned value from effective_cpu_util() and avoid irq
  util scaling issues (Quentin)
v1 is available at [1]

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20210602135609.10867-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/lkml/20210604080954.13915-1-lukasz.luba@arm.com/

Lukasz Luba (3):
  thermal: cpufreq_cooling: Update also offline CPUs per-cpu
    thermal_pressure
  sched/fair: Take thermal pressure into account while estimating energy
  sched/cpufreq: Consider reduced CPU capacity in energy calculation

 drivers/thermal/cpufreq_cooling.c |  2 +-
 include/linux/energy_model.h      | 16 +++++++++++++---
 include/linux/sched/cpufreq.h     |  2 +-
 kernel/sched/cpufreq_schedutil.c  |  1 +
 kernel/sched/fair.c               | 14 ++++++++++----
 5 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.17.1


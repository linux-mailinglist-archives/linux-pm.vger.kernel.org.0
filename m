Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC11C229520
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgGVJin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 05:38:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVJim (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jul 2020 05:38:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F920106F;
        Wed, 22 Jul 2020 02:38:42 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 744AB3F66F;
        Wed, 22 Jul 2020 02:38:40 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, linux@armlinux.org.uk
Cc:     mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 3/7] arch_topology: disable frequency invariance for CONFIG_BL_SWITCHER
Date:   Wed, 22 Jul 2020 10:37:28 +0100
Message-Id: <20200722093732.14297-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722093732.14297-1-ionela.voinescu@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

big.LITTLE switching complicates the setting of a correct cpufreq-based
frequency invariance scale factor due to (as observed in
drivers/cpufreq/vexpress-spc-cpufreq.c):
 - Incorrect current and maximum frequencies as a result of the
   exposure of a virtual frequency table to the cpufreq core,
 - Missed updates as a result of asynchronous frequency adjustments
   caused by frequency changes in other CPU pairs.

Given that its functionality is atypical in regards to frequency
invariance and this is an old technology, disable frequency
invariance for when big.LITTLE switching is configured in to prevent
incorrect scale setting.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..708768f528dc 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
 }
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
+#ifndef CONFIG_BL_SWITCHER
 void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 			 unsigned long max_freq)
 {
@@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 	for_each_cpu(i, cpus)
 		per_cpu(freq_scale, i) = scale;
 }
+#endif
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
-- 
2.17.1


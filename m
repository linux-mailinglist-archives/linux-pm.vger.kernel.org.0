Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2678F1A43C1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDJInb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 04:43:31 -0400
Received: from foss.arm.com ([217.140.110.172]:59090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJInb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 04:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B247FA;
        Fri, 10 Apr 2020 01:43:31 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 356113F68F;
        Fri, 10 Apr 2020 01:43:21 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, lukasz.luba@arm.com,
        patrick.bellasi@matbug.net, orjan.eide@arm.com,
        rdunlap@infradead.org, mka@chromium.org
Subject: [PATCH v6 06/10] PM / EM: change name of em_pd_energy to em_cpu_energy
Date:   Fri, 10 Apr 2020 09:42:06 +0100
Message-Id: <20200410084210.24932-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410084210.24932-1-lukasz.luba@arm.com>
References: <20200410084210.24932-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Energy Model framework supports now other devices than CPUs. Refactor some
of the functions in order to prevent wrong usage. The old function
em_pd_energy has to generic name. It must not be used without proper
cpumask pointer, which is possible only for CPU devices. Thus, rename it
and add proper description to warn of potential wrong usage for other
devices.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 ++++++++---
 kernel/sched/fair.c          |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 73c43e4c8a3b..1790199aa24f 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -83,15 +83,20 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
- * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
+ * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
+		performance domain
  * @pd		: performance domain for which energy has to be estimated
  * @max_util	: highest utilization among CPUs of the domain
  * @sum_util	: sum of the utilization of all CPUs in the domain
  *
+ * This function must be used only for CPU devices. There is no validation,
+ * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
+ * the scheduler code quite frequently and that is why there is not checks.
+ *
  * Return: the sum of the energy consumed by the CPUs of the domain assuming
  * a capacity state satisfying the max utilization of the domain.
  */
-static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
+static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util)
 {
 	unsigned long freq, scale_cpu;
@@ -199,7 +204,7 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 static inline void em_pd_put(struct device *dev)
 {
 }
-static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
+static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util)
 {
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..30f6392f628c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6464,7 +6464,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		max_util = max(max_util, cpu_util);
 	}
 
-	return em_pd_energy(pd->em_pd, max_util, sum_util);
+	return em_cpu_energy(pd->em_pd, max_util, sum_util);
 }
 
 /*
-- 
2.17.1


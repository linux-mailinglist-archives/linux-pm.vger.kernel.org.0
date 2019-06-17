Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0048672
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfFQPBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 11:01:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfFQPBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 11:01:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so9625044wme.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Wqsnkrqxuzj4H7GgqM3V2IbbAn/b8Sl0ywChnZlDzVw=;
        b=rMdY7twpWhnHa4cxiVRG0sqvzqelh8jEW8qKBC9Mh3yio6324k7HmjwwEtXpTvNr2R
         +DFsBk4LHWIuDOoZoyzJCTgdyTygIsC4sdUVAV0qxgi4AMRXiwo8weMPCwLqGJkFVlku
         yaMKp1gJiqKlRPFlNh2gaKeFazEqU/fYwAiafOz36gao+DsYGbEBLFN2p4+AgxOKgoe3
         N+sOGCF4y0CdIDfvSGtFSLeS7kNh2falxhVU2bpft01H2HZWnxsVkgJGhmKQkgihIlOK
         J4vPnksJJNIvaVrpeMy4oNDLffgqqHt+4ikCveP52pi7iuEQQgKmInwtNKyJJANIrgbc
         t6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wqsnkrqxuzj4H7GgqM3V2IbbAn/b8Sl0ywChnZlDzVw=;
        b=De5uzp6F0LxonTGgEBWTsGcH4PTzdE3YZRHzVFpImckAA+DG5nIfDxc0uGpl7ZJPD+
         8lvhHYNF/knFfIYAZZKL7ExGq4Xl4csPTcvF45tpKoSeR3A4J9UEgXqh8fcwoelpBHrL
         uQb/yWIvdyiqxamml394H8bJ15/dyeOTZv+feIoBGgYPYhJG+mkzUi8n9xUzVk5baDRi
         RS4caQdyv/ZKznFzGCZTEl8gU5Xy66Bx2T6bBCpBuO8G+cPgW2ycRcwnIRvh5H75jFfw
         Re0rdnrDW6dxQH3k8FxtWVhKoe6YC1AmRRenYNJlF1j2QK1VkmfP36oeB9svWosHOMc7
         Bajg==
X-Gm-Message-State: APjAAAUHNKxjhpIkhd/KkKNGSPv3Ul6OgYl4YTgNLpGFVyVZLyal9BmS
        yOAWqIKzvfOifQ1lEh/+v50HPNYxFJ8=
X-Google-Smtp-Source: APXvYqx0Vpq43qQXCS96ZNcRfKpgn1FVlYwTD2lRr7UkryQBhX1Ha0iT13M9dJRgn/4mVsxYWYK73A==
X-Received: by 2002:a1c:407:: with SMTP id 7mr20501193wme.113.1560783702741;
        Mon, 17 Jun 2019 08:01:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:100d:4d23:a79e:7684])
        by smtp.gmail.com with ESMTPSA id v24sm9045185wmj.26.2019.06.17.08.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 08:01:42 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org
Cc:     quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/topology: remove unused sd param from arch_scale_cpu_capacity()
Date:   Mon, 17 Jun 2019 17:00:17 +0200
Message-Id: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

struct sched_domain *sd parameter is not used anymore in
arch_scale_cpu_capacity() so we can remove it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/topology.c       |  2 +-
 drivers/base/arch_topology.c     |  6 +++---
 include/linux/arch_topology.h    |  2 +-
 include/linux/energy_model.h     |  2 +-
 include/linux/sched/topology.h   | 14 +++-----------
 kernel/power/energy_model.c      |  2 +-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/deadline.c          |  2 +-
 kernel/sched/fair.c              |  6 +++---
 kernel/sched/pelt.c              |  2 +-
 kernel/sched/pelt.h              |  2 +-
 kernel/sched/sched.h             |  2 +-
 kernel/sched/topology.c          |  8 ++++----
 13 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 60e375c..d17cb1e 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -169,7 +169,7 @@ static void update_cpu_capacity(unsigned int cpu)
 	topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
-		cpu, topology_get_cpu_scale(NULL, cpu));
+		cpu, topology_get_cpu_scale(cpu));
 }
 
 #else
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1739d7e..9b09e31 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -43,7 +43,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
 }
 
 static void update_topology_flags_workfn(struct work_struct *work);
@@ -116,7 +116,7 @@ void topology_normalize_cpu_scale(void)
 			/ capacity_scale;
 		topology_set_cpu_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, topology_get_cpu_scale(NULL, cpu));
+			cpu, topology_get_cpu_scale(cpu));
 	}
 }
 
@@ -185,7 +185,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
+		raw_capacity[cpu] = topology_get_cpu_scale(cpu) *
 				    policy->cpuinfo.max_freq / 1000UL;
 		capacity_scale = max(raw_capacity[cpu], capacity_scale);
 	}
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d9bdc1a..1cfe05e 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU(unsigned long, cpu_scale);
 
 struct sched_domain;
 static inline
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+unsigned long topology_get_cpu_scale(int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7..73f8c3c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -89,7 +89,7 @@ static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
 	 * like schedutil.
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
-	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+	scale_cpu = arch_scale_cpu_capacity(cpu);
 	cs = &pd->table[pd->nr_cap_states - 1];
 	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 53afbe0..e445d37 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -196,14 +196,6 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -219,16 +211,16 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#endif	/* !CONFIG_SMP */
+
 #ifndef arch_scale_cpu_capacity
 static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+unsigned long arch_scale_cpu_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
 
-#endif	/* !CONFIG_SMP */
-
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7d66ee6..0a9326f 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -223,7 +223,7 @@ int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
 		 * All CPUs of a domain must have the same micro-architecture
 		 * since they all share the same table.
 		 */
-		cap = arch_scale_cpu_capacity(NULL, cpu);
+		cap = arch_scale_cpu_capacity(cpu);
 		if (prev_cap && prev_cap != cap) {
 			pr_err("CPUs of %*pbl must have the same capacity\n",
 							cpumask_pr_args(span));
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 962cf343..7c4ce69 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -276,7 +276,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util = cpu_util_cfs(rq);
-	unsigned long max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c1ef308..8b5bb2a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1195,7 +1195,7 @@ static void update_curr_dl(struct rq *rq)
 						 &curr->dl);
 	} else {
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
-		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
 		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f8d477..1c151a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -764,7 +764,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
@@ -7633,7 +7633,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(sd, cpu);
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7658,7 +7658,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29..42ea66b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -366,7 +366,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 * reflect the real amount of computation
 	 */
 	running = cap_scale(running, arch_scale_freq_capacity(cpu_of(rq)));
-	running = cap_scale(running, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+	running = cap_scale(running, arch_scale_cpu_capacity(cpu_of(rq)));
 
 	/*
 	 * We know the time that has been used by interrupt since last update
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 7489d5f..afff644 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -79,7 +79,7 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	 * Scale the elapsed time to reflect the real amount of
 	 * computation
 	 */
-	delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+	delta = cap_scale(delta, arch_scale_cpu_capacity(cpu_of(rq)));
 	delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
 
 	rq->clock_pelt += delta;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 607859a..7a50391 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2248,7 +2248,7 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 
 static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
 {
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 
 	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63184cf..f751ce0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1874,10 +1874,10 @@ static struct sched_domain_topology_level
 	unsigned long cap;
 
 	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(NULL, cpumask_first(cpu_map));
+	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
 
 	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(NULL, i) != cap) {
+		if (arch_scale_cpu_capacity(i) != cap) {
 			asym = true;
 			break;
 		}
@@ -1892,7 +1892,7 @@ static struct sched_domain_topology_level
 	 * to everyone.
 	 */
 	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(NULL, i);
+		unsigned long max_capacity = arch_scale_cpu_capacity(i);
 		int tl_id = 0;
 
 		for_each_sd_topology(tl) {
@@ -1902,7 +1902,7 @@ static struct sched_domain_topology_level
 			for_each_cpu_and(j, tl->mask(i), cpu_map) {
 				unsigned long capacity;
 
-				capacity = arch_scale_cpu_capacity(NULL, j);
+				capacity = arch_scale_cpu_capacity(j);
 
 				if (capacity <= max_capacity)
 					continue;
-- 
2.7.4


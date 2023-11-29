Return-Path: <linux-pm+bounces-455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CED7FD506
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D1328332A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C61C289;
	Wed, 29 Nov 2023 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 185EE170B;
	Wed, 29 Nov 2023 03:08:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0F9AC15;
	Wed, 29 Nov 2023 03:09:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63D073F5A1;
	Wed, 29 Nov 2023 03:08:42 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH v5 16/23] powercap/dtpm_cpu: Use new Energy Model interface to get table
Date: Wed, 29 Nov 2023 11:08:46 +0000
Message-Id: <20231129110853.94344-17-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Energy Model framework support modifications at runtime of the power
values. Use the new EM table API which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 8a2f18fa3faf..45bb7e2849d7 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -42,6 +42,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	unsigned long freq;
 	u64 power;
@@ -50,20 +51,21 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
+	table = em_get_table(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		power = pd->table[i].power * nr_cpus;
+		power = table[i].power * nr_cpus;
 
 		if (power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
+	power_limit = table[i - 1].power * nr_cpus;
+	em_put_table();
 
 	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * nr_cpus;
-
 	return power_limit;
 }
 
@@ -87,9 +89,11 @@ static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	struct cpumask *pd_mask;
 	unsigned long freq;
+	u64 power = 0;
 	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
@@ -98,33 +102,41 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
+	table = em_get_table(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		return scale_pd_power_uw(pd_mask, pd->table[i].power);
+		power = scale_pd_power_uw(pd_mask, table[i].power);
+		break;
 	}
+	em_put_table();
 
-	return 0;
+	return power;
 }
 
 static int update_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	int nr_cpus;
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
-	dtpm->power_min = em->table[0].power;
+	table = em_get_table(em);
+
+	dtpm->power_min = table[0].power;
 	dtpm->power_min *= nr_cpus;
 
-	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
+	dtpm->power_max = table[em->nr_perf_states - 1].power;
 	dtpm->power_max *= nr_cpus;
 
+	em_put_table();
+
 	return 0;
 }
 
@@ -178,6 +190,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
@@ -210,9 +223,11 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
+	table = em_get_table(pd);
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
-				   pd->table[pd->nr_perf_states - 1].frequency);
+				   table[pd->nr_perf_states - 1].frequency);
+	em_put_table();
 	if (ret)
 		goto out_dtpm_unregister;
 
-- 
2.25.1



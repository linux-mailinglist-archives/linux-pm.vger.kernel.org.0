Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B650E083
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 14:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiDYMl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbiDYMl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 08:41:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B02B1A9C;
        Mon, 25 Apr 2022 05:38:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853C71FB;
        Mon, 25 Apr 2022 05:38:16 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.43.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 197D43F5A1;
        Mon, 25 Apr 2022 05:38:11 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, maz@kernel.org,
        daniel.lezcano@linaro.org, Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Phil Auld <pauld@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] cpufreq: CPPC: Register EM based on efficiency class information
Date:   Mon, 25 Apr 2022 14:38:08 +0200
Message-Id: <20220425123819.137735-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425123819.137735-1-pierre.gondois@arm.com>
References: <20220425123819.137735-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

Performance states and energy consumption values are not advertised
in ACPI. In the GicC structure of the MADT table, the "Processor
Power Efficiency Class field" (called efficiency class from now)
allows to describe the relative energy efficiency of CPUs.

To leverage the EM and EAS, the CPPC driver creates a set of
artificial performance states and registers them in the Energy Model
(EM), such as:
- Every 20 capacity unit, a performance state is created.
- The energy cost of each performance state gradually increases.
No power value is generated as only the cost is used in the EM.

During task placement, a task can raise the frequency of its whole
pd. This can make EAS place a task on a pd with CPUs that are
individually less energy efficient.
As cost values are artificial, and to place tasks on CPUs with the
lower efficiency class, a gap in cost values is generated for adjacent
efficiency classes.
E.g.:
- efficiency class = 0, capacity is in [0-1024], so cost values
  are in [0: 51] (one performance state every 20 capacity unit)
- efficiency class = 1, capacity is in [0-1024], cost values
  are in [1*gap+0: 1*gap+51].

The value of the cost gap is chosen to absorb a the energy of 4 CPUs
at their maximum capacity. This means that between:
1- a pd of 4 CPUs, each of them being used at almost their full
   capacity. Their efficiency class is N.
2- a CPU using almost none of its capacity. Its efficiency class is
   N+1
EAS will choose the first option.

This patch also populates the (struct cpufreq_driver).register_em
callback if the valid efficiency_class ACPI values are provided.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 144 +++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3cd05651707d..3eaa23d1aaf5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -421,6 +421,134 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 }
 
 static DEFINE_PER_CPU(unsigned int, efficiency_class);
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
+
+/* Create an artificial performance state every CPPC_EM_CAP_STEP capacity unit. */
+#define CPPC_EM_CAP_STEP	(20)
+/* Increase the cost value by CPPC_EM_COST_STEP every performance state. */
+#define CPPC_EM_COST_STEP	(1)
+/* Add a cost gap correspnding to the energy of 4 CPUs. */
+#define CPPC_EM_COST_GAP	(4 * SCHED_CAPACITY_SCALE * CPPC_EM_COST_STEP \
+				/ CPPC_EM_CAP_STEP)
+
+static unsigned int get_perf_level_count(struct cpufreq_policy *policy)
+{
+	struct cppc_perf_caps *perf_caps;
+	unsigned int min_cap, max_cap;
+	struct cppc_cpudata *cpu_data;
+	int cpu = policy->cpu;
+
+	cpu_data = policy->driver_data;
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu);
+	min_cap = div_u64(max_cap * perf_caps->lowest_perf, perf_caps->highest_perf);
+	if ((min_cap == 0) || (max_cap < min_cap))
+		return 0;
+	return 1 + max_cap / CPPC_EM_CAP_STEP - min_cap / CPPC_EM_CAP_STEP;
+}
+
+/*
+ * The cost is defined as:
+ *   cost = power * max_frequency / frequency
+ */
+static inline unsigned long compute_cost(int cpu, int step)
+{
+	return CPPC_EM_COST_GAP * per_cpu(efficiency_class, cpu) +
+			step * CPPC_EM_COST_STEP;
+}
+
+static int cppc_get_cpu_power(struct device *cpu_dev,
+		unsigned long *power, unsigned long *KHz)
+{
+	unsigned long perf_step, perf_prev, perf, perf_check;
+	unsigned int min_step, max_step, step, step_check;
+	unsigned long prev_freq = *KHz;
+	unsigned int min_cap, max_cap;
+	struct cpufreq_policy *policy;
+
+	struct cppc_perf_caps *perf_caps;
+	struct cppc_cpudata *cpu_data;
+
+	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	cpu_data = policy->driver_data;
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
+	min_cap = div_u64(max_cap * perf_caps->lowest_perf,
+			perf_caps->highest_perf);
+
+	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
+	min_step = min_cap / CPPC_EM_CAP_STEP;
+	max_step = max_cap / CPPC_EM_CAP_STEP;
+
+	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	step = perf_prev / perf_step;
+
+	if (step > max_step)
+		return -EINVAL;
+
+	if (min_step == max_step) {
+		step = max_step;
+		perf = perf_caps->highest_perf;
+	} else if (step < min_step) {
+		step = min_step;
+		perf = perf_caps->lowest_perf;
+	} else {
+		step++;
+		if (step == max_step)
+			perf = perf_caps->highest_perf;
+		else
+			perf = step * perf_step;
+	}
+
+	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
+	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	step_check = perf_check / perf_step;
+
+	/*
+	 * To avoid bad integer approximation, check that new frequency value
+	 * increased and that the new frequency will be converted to the
+	 * desired step value.
+	 */
+	while ((*KHz == prev_freq) || (step_check != step)) {
+		perf++;
+		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
+		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+		step_check = perf_check / perf_step;
+	}
+
+	/*
+	 * With an artificial EM, only the cost value is used. Still the power
+	 * is populated such as 0 < power < EM_MAX_POWER. This allows to add
+	 * more sense to the artificial performance states.
+	 */
+	*power = compute_cost(cpu_dev->id, step);
+
+	return 0;
+}
+
+static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
+		unsigned long *cost)
+{
+	unsigned long perf_step, perf_prev;
+	struct cppc_perf_caps *perf_caps;
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	unsigned int max_cap;
+	int step;
+
+	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	cpu_data = policy->driver_data;
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
+
+	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
+	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
+	step = perf_prev / perf_step;
+
+	*cost = compute_cost(cpu_dev->id, step);
+
+	return 0;
+}
 
 static int populate_efficiency_class(void)
 {
@@ -453,10 +581,23 @@ static int populate_efficiency_class(void)
 		}
 		index++;
 	}
+	cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
 
 	return 0;
 }
 
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data;
+	struct em_data_callback em_cb =
+		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
+
+	cpu_data = policy->driver_data;
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
+			get_perf_level_count(policy), &em_cb,
+			cpu_data->shared_cpu_map, 0);
+}
+
 #else
 
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
@@ -467,6 +608,9 @@ static int populate_efficiency_class(void)
 {
 	return 0;
 }
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+}
 #endif
 
 
-- 
2.25.1


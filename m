Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED9E2B6DB0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKQStv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 13:49:51 -0500
Received: from foss.arm.com ([217.140.110.172]:34986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgKQStv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 13:49:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED8D101E;
        Tue, 17 Nov 2020 10:49:50 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12D453F718;
        Tue, 17 Nov 2020 10:49:48 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH] cppc_cpufreq: optimise memory allocation for HW and NONE coordination
Date:   Tue, 17 Nov 2020 18:49:20 +0000
Message-Id: <20201117184920.17036-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While the current domain and cpu lists are appropriate for ALL and ANY
coordination types where single structures are kept for the domain and
CPU data, they can be inefficient for NONE and HW coordination types,
where domain information can end up being allocated either for a single
CPU or a small number of CPUs.

Therefore remove the psd_data structure and maintain a single CPU list.
The cppc_cpudata structure will contain information about the PSD domain
of the CPU: the ACPI coordination type and CPU content. This does result
in the duplication of domain information in the cppc_cpudata structure
(type and map), but it is more memory efficient for all coordination
types, compared to allocating separate structures.

In order to accommodate the struct list_head node in the cppc_cpudata
structure, the now unused cpu and cur_policy variables are removed.

This change affects all ACPI coordination types, with the greatest
savings obtained for HW and NONE coordination, when the number of CPUs
is large.

For example, on a arm64 Juno platform with 6 CPUs:
 - (0) 0, 1, 2, 3, 4, 5 - NONE coordination
 - (1) (0, 1, 2, 3) in PSD1, (4, 5) in PSD2 - ANY coordination

memory allocation comparison shows:

Before patch: psd_data and cppc_cpudata structures are allocated for each
              CPU (0) or domain (1).

 - (0) NONE coordination:
    total    slack      req alloc/free  caller
       0        0        0     0/6     _kernel_size_le_hi32+0x0xffff800008ff7958
     768      336      432     6/0     _kernel_size_le_hi32+0x0xffff800008ff7444
       0        0        0     0/6     _kernel_size_le_hi32+0x0xffff800008ff7990
     768       96      672     6/0     _kernel_size_le_hi32+0x0xffff800008ff7604

 - (1) ANY coordination:
    total    slack      req alloc/free  caller
       0        0        0     0/2     _kernel_size_le_hi32+0x0xffff800008fe7990
     256      112      144     2/0     _kernel_size_le_hi32+0x0xffff800008fe7444
     256       32      224     2/0     _kernel_size_le_hi32+0x0xffff800008fe7604
       0        0        0     0/2     _kernel_size_le_hi32+0x0xffff800008fe7958

After patch: only cppc_cpudata is allocated for each CPU (0) or domain (1).

 - (0) NONE coordination:
    total    slack      req alloc/free  caller
     768        0      768     6/0     _kernel_size_le_hi32+0x0xffff800008ffd410
       0        0        0     0/6     _kernel_size_le_hi32+0x0xffff800008ffd274

 - (1) ANY coordination:
    total    slack      req alloc/free  caller
     256        0      256     2/0     _kernel_size_le_hi32+0x0xffff800008fed410
       0        0        0     0/2     _kernel_size_le_hi32+0x0xffff800008fed274

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---

Hi guys,

This is an optimisation/fix for the inefficient allocation that Jeremy
mentioned for patch 4/8 in the series at [1]. This reverts the use of a
separate psd_data structure and some of the changes done in cppc_cpudata,
while adding the list_head needed to maintain a cpu list and removing the
unused cpu and cur_policy variables.

This patch is based on v5.10-rc4.

Thanks,
Ionela.

[1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/


 drivers/acpi/cppc_acpi.c       |  20 ++---
 drivers/cpufreq/cppc_cpufreq.c | 131 +++++++++++----------------------
 include/acpi/cppc_acpi.h       |  15 +---
 3 files changed, 54 insertions(+), 112 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e1e46cc66eeb..4e478f751ff7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -416,11 +416,11 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
 /**
  * acpi_get_psd_map - Map the CPUs in the freq domain of a given cpu
  * @cpu: Find all CPUs that share a domain with cpu.
- * @domain: Pointer to given domain data storage
+ * @cpu_data: Pointer to CPU specific CPPC data including PSD info.
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
+int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 {
 	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
 	struct acpi_psd_package *match_pdomain;
@@ -436,18 +436,18 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
 		return -EFAULT;
 
 	pdomain = &(cpc_ptr->domain_info);
-	cpumask_set_cpu(cpu, domain->shared_cpu_map);
+	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
 	if (pdomain->num_processors <= 1)
 		return 0;
 
 	/* Validate the Domain info */
 	count_target = pdomain->num_processors;
 	if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
-		domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
-		domain->shared_type = CPUFREQ_SHARED_TYPE_HW;
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_HW;
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
-		domain->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
 	for_each_possible_cpu(i) {
 		if (i == cpu)
@@ -468,16 +468,16 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
 		if (pdomain->coord_type != match_pdomain->coord_type)
 			goto err_fault;
 
-		cpumask_set_cpu(i, domain->shared_cpu_map);
+		cpumask_set_cpu(i, cpu_data->shared_cpu_map);
 	}
 
 	return 0;
 
 err_fault:
 	/* Assume no coordination on any error parsing domain info */
-	cpumask_clear(domain->shared_cpu_map);
-	cpumask_set_cpu(cpu, domain->shared_cpu_map);
-	domain->shared_type = CPUFREQ_SHARED_TYPE_NONE;
+	cpumask_clear(cpu_data->shared_cpu_map);
+	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
+	cpu_data->shared_type = CPUFREQ_SHARED_TYPE_NONE;
 
 	return -EFAULT;
 }
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b4edeeb57d04..bb4c068601db 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -31,10 +31,11 @@
 
 /*
  * This list contains information parsed from per CPU ACPI _CPC and _PSD
- * structures: this is a list of domain data which in turn contains a list
- * of cpus with their controls and capabilities, belonging to the domain.
+ * structures: e.g. the highest and lowest supported performance, capabilities,
+ * desired performance, level requested etc. Depending on the share_type, not
+ * all CPUs will have an entry in the list.
  */
-static LIST_HEAD(domain_list);
+static LIST_HEAD(cpu_data_list);
 
 static bool boost_supported;
 
@@ -194,6 +195,12 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
+
+	/* Remove CPU node from list and free driver data for policy */
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	list_del(&cpu_data->node);
+	kfree(policy->driver_data);
+	policy->driver_data = NULL;
 }
 
 /*
@@ -239,105 +246,59 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 }
 #endif
 
-static struct psd_data *cppc_cpufreq_get_domain(unsigned int cpu)
-{
-	struct psd_data *domain;
-	int ret;
-
-	list_for_each_entry(domain, &domain_list, node) {
-		if (cpumask_test_cpu(cpu, domain->shared_cpu_map))
-			return domain;
-	}
-
-	domain = kzalloc(sizeof(struct psd_data), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-	if (!zalloc_cpumask_var(&domain->shared_cpu_map, GFP_KERNEL))
-		goto free_domain;
-	INIT_LIST_HEAD(&domain->cpu_list);
-
-	ret = acpi_get_psd_map(cpu, domain);
-	if (ret) {
-		pr_err("Error parsing PSD data for CPU%d.\n", cpu);
-		goto free_mask;
-	}
-
-	list_add(&domain->node, &domain_list);
-
-	return domain;
-
-free_mask:
-	free_cpumask_var(domain->shared_cpu_map);
-free_domain:
-	kfree(domain);
-
-	return NULL;
-}
 
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
-	struct psd_data *domain;
 	int ret;
 
-	domain = cppc_cpufreq_get_domain(cpu);
-	if (!domain) {
-		pr_err("Error acquiring domain for CPU.\n");
-		return NULL;
-	}
-
-	list_for_each_entry(cpu_data, &domain->cpu_list, node) {
-		if (cpu_data->cpu == cpu)
-			return cpu_data;
-	}
-
-	if ((domain->shared_type == CPUFREQ_SHARED_TYPE_ANY) &&
-	    !list_empty(&domain->cpu_list))
-		return list_first_entry(&domain->cpu_list,
-					struct cppc_cpudata,
-					node);
-
 	cpu_data = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
 	if (!cpu_data)
-		return NULL;
+		goto out;
+
+	if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
+		goto free_cpu;
 
-	cpu_data->cpu = cpu;
-	cpu_data->domain = domain;
+	ret = acpi_get_psd_map(cpu, cpu_data);
+	if (ret) {
+		pr_debug("Err parsing CPU%d PSD data: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
 
 	ret = cppc_get_perf_caps(cpu, &cpu_data->perf_caps);
 	if (ret) {
-		pr_err("Err reading CPU%d perf capabilities. ret:%d\n",
-			cpu, ret);
-		goto free;
+		pr_debug("Err reading CPU%d perf caps: ret:%d\n", cpu, ret);
+		goto free_mask;
 	}
+
 	/* Convert the lowest and nominal freq from MHz to KHz */
 	cpu_data->perf_caps.lowest_freq *= 1000;
 	cpu_data->perf_caps.nominal_freq *= 1000;
 
-	list_add(&cpu_data->node, &domain->cpu_list);
+	list_add(&cpu_data->node, &cpu_data_list);
 
 	return cpu_data;
-free:
-	kfree(cpu_data);
 
+free_mask:
+	free_cpumask_var(cpu_data->shared_cpu_map);
+free_cpu:
+	kfree(cpu_data);
+out:
 	return NULL;
 }
 
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = NULL;
-	struct psd_data *domain = NULL;
 	unsigned int cpu = policy->cpu;
+	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
-	int ret = 0;
+	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
 	if (!cpu_data) {
-		pr_err("Error in acquiring _CPC/_PSD data for CPU.\n");
+		pr_err("Error in acquiring _CPC/_PSD data for CPU%d.\n", cpu);
 		return -ENODEV;
 	}
-
-	domain = cpu_data->domain;
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
@@ -361,7 +322,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 							    caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
-	policy->shared_type = domain->shared_type;
+	policy->shared_type = cpu_data->shared_type;
 
 	switch (policy->shared_type) {
 	case CPUFREQ_SHARED_TYPE_HW:
@@ -374,7 +335,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		 * operations will use a single cppc_cpudata structure stored
 		 * in policy->driver_data.
 		 */
-		cpumask_copy(policy->cpus, domain->shared_cpu_map);
+		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
 		break;
 	default:
 		pr_info("Unsupported cpufreq CPU co-ord type: %d\n",
@@ -382,8 +343,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -EFAULT;
 	}
 
-	cpu_data->cur_policy = policy;
-
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
@@ -487,7 +446,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 
-	return cpufreq_show_cpus(cpu_data->domain->shared_cpu_map, buf);
+	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
 cpufreq_freq_attr_ro(freqdomain_cpus);
 
@@ -558,38 +517,30 @@ static int __init cppc_cpufreq_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
+	INIT_LIST_HEAD(&cpu_data_list);
+
 	cppc_check_hisi_workaround();
 
 	return cpufreq_register_driver(&cppc_cpufreq_driver);
 }
 
-static inline void free_cpu_data(struct psd_data *domain)
+static inline void free_cpu_data(void)
 {
 	struct cppc_cpudata *iter, *tmp;
 
-	list_for_each_entry_safe(iter, tmp, &domain->cpu_list, node) {
+	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
+		free_cpumask_var(iter->shared_cpu_map);
 		list_del(&iter->node);
 		kfree(iter);
 	}
-}
-
-static inline void free_domain_data(void)
-{
-	struct psd_data *iter, *tmp;
 
-	list_for_each_entry_safe(iter, tmp, &domain_list, node) {
-		list_del(&iter->node);
-		if (!list_empty(&iter->cpu_list))
-			free_cpu_data(iter);
-		free_cpumask_var(iter->shared_cpu_map);
-		kfree(iter);
-	}
 }
+
 static void __exit cppc_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
-	free_domain_data();
+	free_cpu_data();
 }
 
 module_exit(cppc_cpufreq_exit);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c0081fb6032e..dab6b3b4e315 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -122,30 +122,21 @@ struct cppc_perf_fb_ctrs {
 	u64 wraparound_time;
 };
 
-/* Container of performance state domain data */
-struct psd_data {
-	struct list_head node;
-	unsigned int shared_type;
-	struct list_head cpu_list;
-	cpumask_var_t shared_cpu_map;
-};
-
 /* Per CPU container for runtime CPPC management. */
 struct cppc_cpudata {
-	int cpu;
 	struct list_head node;
-	struct psd_data *domain;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
-	struct cpufreq_policy *cur_policy;
+	unsigned int shared_type;
+	cpumask_var_t shared_cpu_map;
 };
 
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-extern int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain);
+extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
-- 
2.17.1


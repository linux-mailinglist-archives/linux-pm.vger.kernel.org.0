Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41CD2A7F46
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgKEM4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:51 -0500
Received: from foss.arm.com ([217.140.110.172]:60014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbgKEM4r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7729E142F;
        Thu,  5 Nov 2020 04:56:46 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27C003F719;
        Thu,  5 Nov 2020 04:56:45 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
Date:   Thu,  5 Nov 2020 12:55:20 +0000
Message-Id: <20201105125524.4409-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cppc_cpudata per-cpu storage was inefficient (1) additional to causing
functional issues (2) when CPUs are hotplugged out, due to per-cpu data
being improperly initialised.

(1) The amount of information needed for CPPC performance control in its
    cpufreq driver depends on the domain (PSD) coordination type:

    ANY:    One set of CPPC control and capability data (e.g desired
            performance, highest/lowest performance, etc) applies to all
            CPUs in the domain.

    ALL:    Same as ANY. To be noted that this type is not currently
            supported. When supported, information about which CPUs
            belong to a domain is needed in order for frequency change
            requests to be sent to each of them.

    HW:     It's necessary to store CPPC control and capability
            information for all the CPUs. HW will then coordinate the
            performance state based on their limitations and requests.

    NONE:   Same as HW. No HW coordination is expected.

    Despite this, the previous initialisation code would indiscriminately
    allocate memory for all CPUs (all_cpu_data) and unnecessarily
    duplicate performance capabilities and the domain sharing mask and type
    for each possible CPU.

(2) With the current per-cpu structure, when having ANY coordination,
    the cppc_cpudata cpu information is not initialised (will remain 0)
    for all CPUs in a policy, other than policy->cpu. When policy->cpu is
    hotplugged out, the driver will incorrectly use the uninitialised (0)
    value of the other CPUs when making frequency changes. Additionally,
    the previous values stored in the perf_ctrls.desired_perf will be
    lost when policy->cpu changes.

Due to the current storage of driver data not being fit for purpose,
replace the per-cpu CPPC/PSD data with a list of domains which in turn
will point to a list of CPUs with their controls and capabilities,
belonging to the domain.

This new structure has the following benefits:
 - Clearly separates PSD (domain) data from CPPC (performance monitoring
   and control) data and stores one mask of CPUs belonging to a domain
   and its type in a single structure, for each domain.

 - For ANY domain coordination, a single cppc_cpudata set of capabilities
   and controls are stored, for policy->cpu, and used for describing
   performance controls and capabilities even when policy->cpu changes as
   a result of hotplug. All the CPUs in the domain will belong to the
   same policy.

 - For HW or lack of coordination, a full map of domains and CPUs is
   obtained. Each CPU will have its own policy, but for HW, as a result
   of PSD information, a shared_cpu_map mask could be used to identify
   the domain CPU content.

Additional changes:

 - A pointer to the policy's cppc_cpudata is stored in policy->driver_data

 - All data allocation is done from the driver's init function. At that
   point the domain is either created or retrieved. For this purpose
   acpi_get_psd_map() was changed to create a map of the domain of a
   single CPU, rather than the full system domain map.

 - When CPU's are hotplugged out and in, old information can be retrieved.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/acpi/cppc_acpi.c       | 126 +++++++------------
 drivers/cpufreq/cppc_cpufreq.c | 217 ++++++++++++++++++++-------------
 include/acpi/cppc_acpi.h       |  14 ++-
 3 files changed, 190 insertions(+), 167 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7a99b19bb893..75e36b909ae6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -414,108 +414,72 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
 }
 
 /**
- * acpi_get_psd_map - Map the CPUs in a common freq domain.
- * @all_cpu_data: Ptrs to CPU specific CPPC data including PSD info.
+ * acpi_get_psd_map - Map the CPUs in the freq domain of a given cpu
+ * @cpu: Find all CPUs that share a domain with cpu.
+ * @domain: Pointer to given domain data storage
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
+int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
 {
-	int count_target;
-	int retval = 0;
-	unsigned int i, j;
-	cpumask_var_t covered_cpus;
-	struct cppc_cpudata *pr, *match_pr;
-	struct acpi_psd_package *pdomain;
-	struct acpi_psd_package *match_pdomain;
 	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
-
-	if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
-		return -ENOMEM;
+	struct acpi_psd_package *match_pdomain;
+	struct acpi_psd_package *pdomain;
+	int count_target, i;
 
 	/*
 	 * Now that we have _PSD data from all CPUs, let's setup P-state
 	 * domain info.
 	 */
-	for_each_possible_cpu(i) {
-		if (cpumask_test_cpu(i, covered_cpus))
-			continue;
+	cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+	if (!cpc_ptr)
+		return -EFAULT;
 
-		pr = all_cpu_data[i];
-		cpc_ptr = per_cpu(cpc_desc_ptr, i);
-		if (!cpc_ptr) {
-			retval = -EFAULT;
-			goto err_ret;
-		}
+	pdomain = &(cpc_ptr->domain_info);
+	cpumask_set_cpu(cpu, domain->shared_cpu_map);
+	if (pdomain->num_processors <= 1)
+		return 0;
 
-		pdomain = &(cpc_ptr->domain_info);
-		cpumask_set_cpu(i, pr->shared_cpu_map);
-		cpumask_set_cpu(i, covered_cpus);
-		if (pdomain->num_processors <= 1)
-			continue;
+	/* Validate the Domain info */
+	count_target = pdomain->num_processors;
+	if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
+		domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
+		domain->shared_type = CPUFREQ_SHARED_TYPE_HW;
+	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
+		domain->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
-		/* Validate the Domain info */
-		count_target = pdomain->num_processors;
-		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_HW;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_ANY;
-
-		for_each_possible_cpu(j) {
-			if (i == j)
-				continue;
-
-			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
-			if (!match_cpc_ptr) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
-
-			match_pdomain = &(match_cpc_ptr->domain_info);
-			if (match_pdomain->domain != pdomain->domain)
-				continue;
+	for_each_possible_cpu(i) {
+		if (i == cpu)
+			continue;
 
-			/* Here i and j are in the same domain */
-			if (match_pdomain->num_processors != count_target) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
+		match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
+		if (!match_cpc_ptr)
+			goto err_fault;
 
-			if (pdomain->coord_type != match_pdomain->coord_type) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
+		match_pdomain = &(match_cpc_ptr->domain_info);
+		if (match_pdomain->domain != pdomain->domain)
+			continue;
 
-			cpumask_set_cpu(j, covered_cpus);
-			cpumask_set_cpu(j, pr->shared_cpu_map);
-		}
+		/* Here i and cpu are in the same domain */
+		if (match_pdomain->num_processors != count_target)
+			goto err_fault;
 
-		for_each_cpu(j, pr->shared_cpu_map) {
-			if (i == j)
-				continue;
+		if (pdomain->coord_type != match_pdomain->coord_type)
+			goto err_fault;
 
-			match_pr = all_cpu_data[j];
-			match_pr->shared_type = pr->shared_type;
-			cpumask_copy(match_pr->shared_cpu_map,
-				     pr->shared_cpu_map);
-		}
+		cpumask_set_cpu(i, domain->shared_cpu_map);
 	}
-	goto out;
 
-err_ret:
-	for_each_possible_cpu(i) {
-		pr = all_cpu_data[i];
+	return 0;
 
-		/* Assume no coordination on any error parsing domain info */
-		cpumask_clear(pr->shared_cpu_map);
-		cpumask_set_cpu(i, pr->shared_cpu_map);
-		pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-	}
-out:
-	free_cpumask_var(covered_cpus);
-	return retval;
+err_fault:
+	/* Assume no coordination on any error parsing domain info */
+	cpumask_clear(domain->shared_cpu_map);
+	cpumask_set_cpu(cpu, domain->shared_cpu_map);
+	domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+
+	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(acpi_get_psd_map);
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7cc9bd8568de..ac95b4424a2e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -30,13 +30,12 @@
 #define DMI_PROCESSOR_MAX_SPEED		0x14
 
 /*
- * These structs contain information parsed from per CPU
- * ACPI _CPC structures.
- * e.g. For each CPU the highest, lowest supported
- * performance capabilities, desired performance level
- * requested etc.
+ * This list contains information parsed from per CPU ACPI _CPC and _PSD
+ * structures: this is a list of domain data which in turn contains a list
+ * of cpus with their controls and capabilities, belonging to the domain.
  */
-static struct cppc_cpudata **all_cpu_data;
+static LIST_HEAD(domain_list);
+
 static bool boost_supported;
 
 struct cppc_workaround_oem_info {
@@ -148,8 +147,9 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
+
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cpufreq_freqs freqs;
 	u32 desired_perf;
 	int ret = 0;
@@ -182,7 +182,7 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 
 static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
 	int ret;
@@ -238,25 +238,107 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 }
 #endif
 
-static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static struct psd_data *cppc_cpufreq_get_domain(unsigned int cpu)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	unsigned int cpu = policy->cpu;
-	int ret = 0;
+	struct psd_data *domain;
+	int ret;
 
-	cpu_data->cpu = cpu;
-	ret = cppc_get_perf_caps(cpu, caps);
+	list_for_each_entry(domain, &domain_list, node) {
+		if (cpumask_test_cpu(cpu, domain->shared_cpu_map))
+			return domain;
+	}
 
+	domain = kzalloc(sizeof(struct psd_data), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	if (!zalloc_cpumask_var(&domain->shared_cpu_map, GFP_KERNEL))
+		goto free_domain;
+	INIT_LIST_HEAD(&domain->cpu_list);
+
+	ret = acpi_get_psd_map(cpu, domain);
 	if (ret) {
-		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
-			 cpu, ret);
-		return ret;
+		pr_err("Error parsing PSD data for CPU%d.\n", cpu);
+		goto free_mask;
+	}
+
+	list_add(&domain->node, &domain_list);
+
+	return domain;
+
+free_mask:
+	free_cpumask_var(domain->shared_cpu_map);
+free_domain:
+	kfree(domain);
+
+	return NULL;
+}
+
+static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
+{
+	struct cppc_cpudata *cpu_data;
+	struct psd_data *domain;
+	int ret;
+
+	domain = cppc_cpufreq_get_domain(cpu);
+	if (!domain) {
+		pr_err("Error acquiring domain for CPU.\n");
+		return NULL;
 	}
 
+	list_for_each_entry(cpu_data, &domain->cpu_list, node) {
+		if (cpu_data->cpu == cpu)
+			return cpu_data;
+	}
+
+	if ((domain->shared_type == CPUFREQ_SHARED_TYPE_ANY) &&
+	    !list_empty(&domain->cpu_list))
+		return list_first_entry(&domain->cpu_list,
+					struct cppc_cpudata,
+					node);
+
+	cpu_data = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
+	if (!cpu_data)
+		return NULL;
+
+	cpu_data->cpu = cpu;
+	cpu_data->domain = domain;
+
+	ret = cppc_get_perf_caps(cpu, &cpu_data->perf_caps);
+	if (ret) {
+		pr_err("Err reading CPU%d perf capabilities. ret:%d\n",
+			cpu, ret);
+		goto free;
+	}
 	/* Convert the lowest and nominal freq from MHz to KHz */
-	caps->lowest_freq *= 1000;
-	caps->nominal_freq *= 1000;
+	cpu_data->perf_caps.lowest_freq *= 1000;
+	cpu_data->perf_caps.nominal_freq *= 1000;
+
+	list_add(&cpu_data->node, &domain->cpu_list);
+
+	return cpu_data;
+free:
+	kfree(cpu_data);
+
+	return NULL;
+}
+
+static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = NULL;
+	struct psd_data *domain = NULL;
+	unsigned int cpu = policy->cpu;
+	struct cppc_perf_caps *caps;
+	int ret = 0;
+
+	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
+	if (!cpu_data) {
+		pr_err("Error in acquiring _CPC/_PSD data for CPU.\n");
+		return -ENODEV;
+	}
+
+	domain = cpu_data->domain;
+	caps = &cpu_data->perf_caps;
+	policy->driver_data = cpu_data;
 
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
@@ -278,20 +360,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 							    caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
-	policy->shared_type = cpu_data->shared_type;
+	policy->shared_type = domain->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
-		int i;
-
-		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
-
-		for_each_cpu(i, policy->cpus) {
-			if (unlikely(i == cpu))
-				continue;
-
-			memcpy(&all_cpu_data[i]->perf_caps, caps,
-			       sizeof(cpu_data->perf_caps));
-		}
+		cpumask_copy(policy->cpus, domain->shared_cpu_map);
 	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
 		pr_debug("Unsupported CPU co-ord type\n");
@@ -354,9 +426,12 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
-	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	int ret;
 
+	cpufreq_cpu_put(policy);
+
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -372,7 +447,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	int ret;
 
@@ -415,10 +490,13 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
  */
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 desired_perf;
 	int ret;
 
+	cpufreq_cpu_put(policy);
+
 	ret = cppc_get_desired_perf(cpu, &desired_perf);
 	if (ret < 0)
 		return -EIO;
@@ -451,68 +529,41 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
-	struct cppc_cpudata *cpu_data;
-	int i, ret = 0;
-
 	if (acpi_disabled)
 		return -ENODEV;
 
-	all_cpu_data = kcalloc(num_possible_cpus(), sizeof(void *),
-			       GFP_KERNEL);
-	if (!all_cpu_data)
-		return -ENOMEM;
-
-	for_each_possible_cpu(i) {
-		all_cpu_data[i] = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
-		if (!all_cpu_data[i])
-			goto out;
-
-		cpu_data = all_cpu_data[i];
-		if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
-			goto out;
-	}
-
-	ret = acpi_get_psd_map(all_cpu_data);
-	if (ret) {
-		pr_debug("Error parsing PSD data. Aborting cpufreq registration.\n");
-		goto out;
-	}
-
 	cppc_check_hisi_workaround();
 
-	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-	if (ret)
-		goto out;
+	return cpufreq_register_driver(&cppc_cpufreq_driver);
+}
 
-	return ret;
+static inline void free_cpu_data(struct psd_data *domain)
+{
+	struct cppc_cpudata *iter, *tmp;
 
-out:
-	for_each_possible_cpu(i) {
-		cpu_data = all_cpu_data[i];
-		if (!cpu_data)
-			break;
-		free_cpumask_var(cpu_data->shared_cpu_map);
-		kfree(cpu_data);
+	list_for_each_entry_safe(iter, tmp, &domain->cpu_list, node) {
+		list_del(&iter->node);
+		kfree(iter);
 	}
-
-	kfree(all_cpu_data);
-	return -ENODEV;
 }
 
+static inline void free_domain_data(void)
+{
+	struct psd_data *iter, *tmp;
+
+	list_for_each_entry_safe(iter, tmp, &domain_list, node) {
+		list_del(&iter->node);
+		if (!list_empty(&iter->cpu_list))
+			free_cpu_data(iter);
+		free_cpumask_var(iter->shared_cpu_map);
+		kfree(iter);
+	}
+}
 static void __exit cppc_cpufreq_exit(void)
 {
-	struct cppc_cpudata *cpu_data;
-	int i;
-
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
-	for_each_possible_cpu(i) {
-		cpu_data = all_cpu_data[i];
-		free_cpumask_var(cpu_data->shared_cpu_map);
-		kfree(cpu_data);
-	}
-
-	kfree(all_cpu_data);
+	free_domain_data();
 }
 
 module_exit(cppc_cpufreq_exit);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a6a9373ab863..c0081fb6032e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -122,22 +122,30 @@ struct cppc_perf_fb_ctrs {
 	u64 wraparound_time;
 };
 
+/* Container of performance state domain data */
+struct psd_data {
+	struct list_head node;
+	unsigned int shared_type;
+	struct list_head cpu_list;
+	cpumask_var_t shared_cpu_map;
+};
+
 /* Per CPU container for runtime CPPC management. */
 struct cppc_cpudata {
 	int cpu;
+	struct list_head node;
+	struct psd_data *domain;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	struct cpufreq_policy *cur_policy;
-	unsigned int shared_type;
-	cpumask_var_t shared_cpu_map;
 };
 
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-extern int acpi_get_psd_map(struct cppc_cpudata **);
+extern int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
-- 
2.17.1


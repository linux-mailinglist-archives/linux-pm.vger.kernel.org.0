Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60F01434C3
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 01:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUAkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 19:40:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUAkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 19:40:11 -0500
Received: from 79.184.255.84.ipv4.supernova.orange.pl (79.184.255.84) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 2a957c78ed836c5f; Tue, 21 Jan 2020 01:40:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: drivers/acpi/processor_thermal.c:66:1: warning: the frame size of 2160 bytes is larger than 2048 bytes
Date:   Tue, 21 Jan 2020 01:40:04 +0100
Message-ID: <22577568.Kaohy42qHH@kreacher>
In-Reply-To: <CAJZ5v0i4nezntZJRSpv-LOwE_ZkE5Vr+YHkwJ8tX5GgG64gB=Q@mail.gmail.com>
References: <201911151357.A9MjGImg%lkp@intel.com> <CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com> <CAJZ5v0i4nezntZJRSpv-LOwE_ZkE5Vr+YHkwJ8tX5GgG64gB=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, January 20, 2020 11:16:12 AM CET Rafael J. Wysocki wrote:
> On Fri, Jan 17, 2020 at 4:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Rafael, Viresh,
> >
> > On Fri, Nov 15, 2019 at 6:23 AM kbuild test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   96b95eff4a591dbac582c2590d067e356a18aacb
> > > commit: 3000ce3c52f8b8db093e4dc649cd172390f71137 cpufreq: Use per-policy frequency QoS
> > > date:   4 weeks ago
> > > config: ia64-randconfig-a001-20191115 (attached as .config)
> > > compiler: ia64-linux-gcc (GCC) 7.4.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout 3000ce3c52f8b8db093e4dc649cd172390f71137
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=7.4.0 make.cross ARCH=ia64
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > Seeing similar warnings on arm64, so this triggered my attention.
> >
> > > --
> > >    drivers/cpufreq/cpufreq.c: In function 'refresh_frequency_limits.part.33':
> > > >> drivers/cpufreq/cpufreq.c:1116:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >
> > |       struct cpufreq_policy new_policy;
> >
> > That's a large struct on the stack...
> >
> > |       if (!policy_is_inactive(policy)) {
> > |               new_policy = *policy;
> >
> > Let's make a copy?
> > How well does this work, given struct cpufreq_policy contains a
> > work_struct, list_head, kobject, completion, semaphore, spinlock_t,
> > wait_queue_head_t, and two notifier_blocks, which are all objects you
> > cannot just copy and reuse?
> >
> > |               pr_debug("updating policy for CPU %u\n", policy->cpu);
> > |
> > |               cpufreq_set_policy(policy, &new_policy);
> >
> > If cpufreq_set_policy() uses only a few fields from new_policy,
> 
> That's really the case.
> 
> > it might be a good idea to extract those into its own structure.
> 
> Or organize the code differently.
> 
> This is old code that hasn't been change, but I'll look at it since it
> is problematic.

So what about the patch below (untested)?

It should be mostly self-explanatory, and the point is basically that
cpufreq_set_policy() gets the limits values from freq QoS, so it only
needs to get the new governor/policy value from the caller and more
data need to be passed to the driver's ->verify() callback.

---
 drivers/cpufreq/cppc_cpufreq.c     |    2 
 drivers/cpufreq/cpufreq-nforce2.c  |    2 
 drivers/cpufreq/cpufreq.c          |  148 +++++++++++++++++--------------------
 drivers/cpufreq/freq_table.c       |    4 -
 drivers/cpufreq/gx-suspmod.c       |    2 
 drivers/cpufreq/intel_pstate.c     |   34 ++++----
 drivers/cpufreq/longrun.c          |    2 
 drivers/cpufreq/pcc-cpufreq.c      |    2 
 drivers/cpufreq/sh-cpufreq.c       |    2 
 drivers/cpufreq/unicore2-cpufreq.c |    2 
 include/linux/cpufreq.h            |   33 ++++++--
 11 files changed, 121 insertions(+), 112 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -148,6 +148,21 @@ struct cpufreq_policy {
 	struct notifier_block nb_max;
 };
 
+/*
+ * Used for passing new cpufreq policy data to the cpufreq driver's ->verify()
+ * callback for sanitization.  That callback is only expected to modify the min
+ * and max values, if necessary, and specifically it must not update the
+ * frequency table.
+ */
+struct cpufreq_policy_data {
+	struct cpufreq_cpuinfo		cpuinfo;
+	struct cpufreq_frequency_table	*freq_table;
+	unsigned int			cpu;
+	unsigned int			policy;
+	unsigned int			min;    /* in kHz */
+	unsigned int			max;    /* in kHz */
+};
+
 struct cpufreq_freqs {
 	struct cpufreq_policy *policy;
 	unsigned int old;
@@ -201,8 +216,6 @@ u64 get_cpu_idle_time(unsigned int cpu,
 struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu);
 void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
-int cpufreq_set_policy(struct cpufreq_policy *policy,
-		       struct cpufreq_policy *new_policy);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
@@ -284,7 +297,7 @@ struct cpufreq_driver {
 
 	/* needed by all drivers */
 	int		(*init)(struct cpufreq_policy *policy);
-	int		(*verify)(struct cpufreq_policy *policy);
+	int		(*verify)(struct cpufreq_policy_data *policy);
 
 	/* define one out of two */
 	int		(*setpolicy)(struct cpufreq_policy *policy);
@@ -415,8 +428,9 @@ static inline int cpufreq_thermal_contro
 		(drv->flags & CPUFREQ_IS_COOLING_DEV);
 }
 
-static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
-		unsigned int min, unsigned int max)
+static inline void cpufreq_verify_within_limits(struct cpufreq_policy_data *policy,
+						unsigned int min,
+						unsigned int max)
 {
 	if (policy->min < min)
 		policy->min = min;
@@ -432,10 +446,10 @@ static inline void cpufreq_verify_within
 }
 
 static inline void
-cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
+cpufreq_verify_within_cpu_limits(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-			policy->cpuinfo.max_freq);
+				     policy->cpuinfo.max_freq);
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -513,6 +527,7 @@ static inline unsigned long cpufreq_scal
  *                          CPUFREQ GOVERNORS                        *
  *********************************************************************/
 
+#define CPUFREQ_POLICY_UNKNOWN		(0)
 /*
  * If (cpufreq_driver->target) exists, the ->governor decides what frequency
  * within the limits is used. If (cpufreq_driver->setpolicy> exists, these
@@ -684,9 +699,9 @@ static inline void dev_pm_opp_free_cpufr
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
 
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
+int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 				   struct cpufreq_frequency_table *table);
-int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -74,6 +74,9 @@ static void cpufreq_exit_governor(struct
 static int cpufreq_start_governor(struct cpufreq_policy *policy);
 static void cpufreq_stop_governor(struct cpufreq_policy *policy);
 static void cpufreq_governor_limits(struct cpufreq_policy *policy);
+static int cpufreq_set_policy(struct cpufreq_policy *policy,
+			      struct cpufreq_governor *new_gov,
+			      unsigned int new_pol);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -616,25 +619,22 @@ static struct cpufreq_governor *find_gov
 	return NULL;
 }
 
-static int cpufreq_parse_policy(char *str_governor,
-				struct cpufreq_policy *policy)
+static unsigned int cpufreq_parse_policy(char *str_governor)
 {
-	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
-		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-		return 0;
-	}
-	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-		return 0;
-	}
-	return -EINVAL;
+	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
+		return CPUFREQ_POLICY_PERFORMANCE;
+
+	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN))
+		return CPUFREQ_POLICY_POWERSAVE;
+
+	return CPUFREQ_POLICY_UNKNOWN;
 }
 
 /**
  * cpufreq_parse_governor - parse a governor string only for has_target()
+ * @str_governor: Governor name.
  */
-static int cpufreq_parse_governor(char *str_governor,
-				  struct cpufreq_policy *policy)
+static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 {
 	struct cpufreq_governor *t;
 
@@ -648,7 +648,7 @@ static int cpufreq_parse_governor(char *
 
 		ret = request_module("cpufreq_%s", str_governor);
 		if (ret)
-			return -EINVAL;
+			return NULL;
 
 		mutex_lock(&cpufreq_governor_mutex);
 
@@ -659,12 +659,7 @@ static int cpufreq_parse_governor(char *
 
 	mutex_unlock(&cpufreq_governor_mutex);
 
-	if (t) {
-		policy->governor = t;
-		return 0;
-	}
-
-	return -EINVAL;
+	return t;
 }
 
 /**
@@ -765,28 +760,33 @@ static ssize_t show_scaling_governor(str
 static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
+	char str_governor[16];
 	int ret;
-	char	str_governor[16];
-	struct cpufreq_policy new_policy;
-
-	memcpy(&new_policy, policy, sizeof(*policy));
 
 	ret = sscanf(buf, "%15s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
 
 	if (cpufreq_driver->setpolicy) {
-		if (cpufreq_parse_policy(str_governor, &new_policy))
+		unsigned int new_pol;
+
+		new_pol = cpufreq_parse_policy(str_governor);
+		if (!new_pol)
 			return -EINVAL;
+
+		ret = cpufreq_set_policy(policy, NULL, new_pol);
 	} else {
-		if (cpufreq_parse_governor(str_governor, &new_policy))
+		struct cpufreq_governor *new_gov;
+
+		new_gov = cpufreq_parse_governor(str_governor);
+		if (!new_gov)
 			return -EINVAL;
-	}
 
-	ret = cpufreq_set_policy(policy, &new_policy);
+		ret = cpufreq_set_policy(policy, new_gov,
+					 CPUFREQ_POLICY_UNKNOWN);
 
-	if (new_policy.governor)
-		module_put(new_policy.governor->owner);
+		module_put(new_gov->owner);
+	}
 
 	return ret ? ret : count;
 }
@@ -1053,40 +1053,33 @@ __weak struct cpufreq_governor *cpufreq_
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
-	struct cpufreq_governor *gov = NULL, *def_gov = NULL;
-	struct cpufreq_policy new_policy;
-
-	memcpy(&new_policy, policy, sizeof(*policy));
-
-	def_gov = cpufreq_default_governor();
+	struct cpufreq_governor *def_gov = cpufreq_default_governor();
+	struct cpufreq_governor *gov = NULL;
+	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
 
 	if (has_target()) {
-		/*
-		 * Update governor of new_policy to the governor used before
-		 * hotplug
-		 */
+		/* Update policy governor to the one used before hotplug. */
 		gov = find_governor(policy->last_governor);
 		if (gov) {
 			pr_debug("Restoring governor %s for cpu %d\n",
-				policy->governor->name, policy->cpu);
-		} else {
-			if (!def_gov)
-				return -ENODATA;
+				 policy->governor->name, policy->cpu);
+		} else if (def_gov) {
 			gov = def_gov;
+		} else {
+			return -ENODATA;
 		}
-		new_policy.governor = gov;
 	} else {
 		/* Use the default policy if there is no last_policy. */
 		if (policy->last_policy) {
-			new_policy.policy = policy->last_policy;
+			pol = policy->last_policy;
+		} else if (def_gov) {
+			pol = cpufreq_parse_policy(def_gov->name);
 		} else {
-			if (!def_gov)
-				return -ENODATA;
-			cpufreq_parse_policy(def_gov->name, &new_policy);
+			return -ENODATA;
 		}
 	}
 
-	return cpufreq_set_policy(policy, &new_policy);
+	return cpufreq_set_policy(policy, gov, pol);
 }
 
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
@@ -1114,13 +1107,10 @@ static int cpufreq_add_policy_cpu(struct
 
 void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy new_policy;
-
 	if (!policy_is_inactive(policy)) {
-		new_policy = *policy;
 		pr_debug("updating policy for CPU %u\n", policy->cpu);
 
-		cpufreq_set_policy(policy, &new_policy);
+		cpufreq_set_policy(policy, policy->governor, policy->policy);
 	}
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
@@ -2364,46 +2354,50 @@ EXPORT_SYMBOL(cpufreq_get_policy);
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
- * @new_policy: New policy data.
+ * @new_gov: Policy governor pointer.
+ * @new_pol: Policy value (for drivers with built-in governors).
  *
- * Pass @new_policy to the cpufreq driver's ->verify() callback. Next, copy the
- * min and max parameters of @new_policy to @policy and either invoke the
- * driver's ->setpolicy() callback (if present) or carry out a governor update
- * for @policy.  That is, run the current governor's ->limits() callback (if the
- * governor field in @new_policy points to the same object as the one in
- * @policy) or replace the governor for @policy with the new one stored in
- * @new_policy.
+ * Invoke the cpufreq driver's ->verify() callback to sanity-check the frequency
+ * limits to be set for the policy, update @policy with the verified limits
+ * values and either invoke the driver's ->setpolicy() callback (if present) or
+ * carry out a governor update for @policy.  That is, run the current governor's
+ * ->limits() callback (if @new_gov points to the same object as the one in
+ * @policy) or replace the governor for @policy with @new_gov.
  *
  * The cpuinfo part of @policy is not updated by this function.
  */
-int cpufreq_set_policy(struct cpufreq_policy *policy,
-		       struct cpufreq_policy *new_policy)
+static int cpufreq_set_policy(struct cpufreq_policy *policy,
+			      struct cpufreq_governor *new_gov,
+			      unsigned int new_pol)
 {
+	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
 	int ret;
 
-	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
-		 new_policy->cpu, new_policy->min, new_policy->max);
-
-	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
-
+	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
+	new_data.freq_table = policy->freq_table;
+	new_data.cpu = policy->cpu;
+	new_data.policy = new_pol;
 	/*
 	 * PM QoS framework collects all the requests from users and provide us
 	 * the final aggregated value here.
 	 */
-	new_policy->min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
-	new_policy->max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
+	new_data.min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
+	new_data.max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
+
+	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
+		 new_data.cpu, new_data.min, new_data.max);
 
 	/*
 	 * Verify that the CPU speed can be set within these limits and make sure
 	 * that min <= max.
 	 */
-	ret = cpufreq_driver->verify(new_policy);
+	ret = cpufreq_driver->verify(&new_data);
 	if (ret)
 		return ret;
 
-	policy->min = new_policy->min;
-	policy->max = new_policy->max;
+	policy->min = new_data.min;
+	policy->max = new_data.max;
 	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
@@ -2412,12 +2406,12 @@ int cpufreq_set_policy(struct cpufreq_po
 		 policy->min, policy->max);
 
 	if (cpufreq_driver->setpolicy) {
-		policy->policy = new_policy->policy;
+		policy->policy = new_pol;
 		pr_debug("setting range\n");
 		return cpufreq_driver->setpolicy(policy);
 	}
 
-	if (new_policy->governor == policy->governor) {
+	if (new_gov == policy->governor) {
 		pr_debug("governor limits update\n");
 		cpufreq_governor_limits(policy);
 		return 0;
@@ -2434,7 +2428,7 @@ int cpufreq_set_policy(struct cpufreq_po
 	}
 
 	/* start new governor */
-	policy->governor = new_policy->governor;
+	policy->governor = new_gov;
 	ret = cpufreq_init_governor(policy);
 	if (!ret) {
 		ret = cpufreq_start_governor(policy);
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2036,8 +2036,9 @@ static int intel_pstate_get_max_freq(str
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 }
 
-static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
-					    struct cpudata *cpu)
+static void intel_pstate_update_perf_limits(struct cpudata *cpu,
+					    unsigned int policy_min,
+					    unsigned int policy_max)
 {
 	int max_freq = intel_pstate_get_max_freq(cpu);
 	int32_t max_policy_perf, min_policy_perf;
@@ -2056,18 +2057,17 @@ static void intel_pstate_update_perf_lim
 		turbo_max = cpu->pstate.turbo_pstate;
 	}
 
-	max_policy_perf = max_state * policy->max / max_freq;
-	if (policy->max == policy->min) {
+	max_policy_perf = max_state * policy_max / max_freq;
+	if (policy_max == policy_min) {
 		min_policy_perf = max_policy_perf;
 	} else {
-		min_policy_perf = max_state * policy->min / max_freq;
+		min_policy_perf = max_state * policy_min / max_freq;
 		min_policy_perf = clamp_t(int32_t, min_policy_perf,
 					  0, max_policy_perf);
 	}
 
 	pr_debug("cpu:%d max_state %d min_policy_perf:%d max_policy_perf:%d\n",
-		 policy->cpu, max_state,
-		 min_policy_perf, max_policy_perf);
+		 cpu->cpu, max_state, min_policy_perf, max_policy_perf);
 
 	/* Normalize user input to [min_perf, max_perf] */
 	if (per_cpu_limits) {
@@ -2081,7 +2081,7 @@ static void intel_pstate_update_perf_lim
 		global_min = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
 		global_min = clamp_t(int32_t, global_min, 0, global_max);
 
-		pr_debug("cpu:%d global_min:%d global_max:%d\n", policy->cpu,
+		pr_debug("cpu:%d global_min:%d global_max:%d\n", cpu->cpu,
 			 global_min, global_max);
 
 		cpu->min_perf_ratio = max(min_policy_perf, global_min);
@@ -2094,7 +2094,7 @@ static void intel_pstate_update_perf_lim
 					  cpu->max_perf_ratio);
 
 	}
-	pr_debug("cpu:%d max_perf_ratio:%d min_perf_ratio:%d\n", policy->cpu,
+	pr_debug("cpu:%d max_perf_ratio:%d min_perf_ratio:%d\n", cpu->cpu,
 		 cpu->max_perf_ratio,
 		 cpu->min_perf_ratio);
 }
@@ -2114,7 +2114,7 @@ static int intel_pstate_set_policy(struc
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	intel_pstate_update_perf_limits(policy, cpu);
+	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
@@ -2143,8 +2143,8 @@ static int intel_pstate_set_policy(struc
 	return 0;
 }
 
-static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
-					 struct cpudata *cpu)
+static void intel_pstate_adjust_policy_max(struct cpudata *cpu,
+					   struct cpufreq_policy_data *policy)
 {
 	if (!hwp_active &&
 	    cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
@@ -2155,7 +2155,7 @@ static void intel_pstate_adjust_policy_m
 	}
 }
 
-static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
+static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
@@ -2167,7 +2167,7 @@ static int intel_pstate_verify_policy(st
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
-	intel_pstate_adjust_policy_max(policy, cpu);
+	intel_pstate_adjust_policy_max(cpu, policy);
 
 	return 0;
 }
@@ -2268,7 +2268,7 @@ static struct cpufreq_driver intel_pstat
 	.name		= "intel_pstate",
 };
 
-static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
+static int intel_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
@@ -2276,9 +2276,9 @@ static int intel_cpufreq_verify_policy(s
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     intel_pstate_get_max_freq(cpu));
 
-	intel_pstate_adjust_policy_max(policy, cpu);
+	intel_pstate_adjust_policy_max(cpu, policy);
 
-	intel_pstate_update_perf_limits(policy, cpu);
+	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	return 0;
 }
Index: linux-pm/drivers/cpufreq/freq_table.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/freq_table.c
+++ linux-pm/drivers/cpufreq/freq_table.c
@@ -60,7 +60,7 @@ int cpufreq_frequency_table_cpuinfo(stru
 		return 0;
 }
 
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
+int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 				   struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_tabl
  * Generic routine to verify policy & frequency table, requires driver to set
  * policy->freq_table prior to it.
  */
-int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
 {
 	if (!policy->freq_table)
 		return -ENODEV;
Index: linux-pm/drivers/cpufreq/sh-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/sh-cpufreq.c
+++ linux-pm/drivers/cpufreq/sh-cpufreq.c
@@ -87,7 +87,7 @@ static int sh_cpufreq_target(struct cpuf
 	return work_on_cpu(policy->cpu, __sh_cpufreq_target, &data);
 }
 
-static int sh_cpufreq_verify(struct cpufreq_policy *policy)
+static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
 {
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
 	struct cpufreq_frequency_table *freq_table;
Index: linux-pm/drivers/cpufreq/cppc_cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cppc_cpufreq.c
+++ linux-pm/drivers/cpufreq/cppc_cpufreq.c
@@ -221,7 +221,7 @@ static int cppc_cpufreq_set_target(struc
 	return ret;
 }
 
-static int cppc_verify_policy(struct cpufreq_policy *policy)
+static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
 	return 0;
Index: linux-pm/drivers/cpufreq/cpufreq-nforce2.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq-nforce2.c
+++ linux-pm/drivers/cpufreq/cpufreq-nforce2.c
@@ -291,7 +291,7 @@ static int nforce2_target(struct cpufreq
  * nforce2_verify - verifies a new CPUFreq policy
  * @policy: new policy
  */
-static int nforce2_verify(struct cpufreq_policy *policy)
+static int nforce2_verify(struct cpufreq_policy_data *policy)
 {
 	unsigned int fsb_pol_max;
 
Index: linux-pm/drivers/cpufreq/gx-suspmod.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/gx-suspmod.c
+++ linux-pm/drivers/cpufreq/gx-suspmod.c
@@ -328,7 +328,7 @@ static void gx_set_cpuspeed(struct cpufr
  *      for the hardware supported by the driver.
  */
 
-static int cpufreq_gx_verify(struct cpufreq_policy *policy)
+static int cpufreq_gx_verify(struct cpufreq_policy_data *policy)
 {
 	unsigned int tmp_freq = 0;
 	u8 tmp1, tmp2;
Index: linux-pm/drivers/cpufreq/longrun.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/longrun.c
+++ linux-pm/drivers/cpufreq/longrun.c
@@ -122,7 +122,7 @@ static int longrun_set_policy(struct cpu
  * Validates a new CPUFreq policy. This function has to be called with
  * cpufreq_driver locked.
  */
-static int longrun_verify_policy(struct cpufreq_policy *policy)
+static int longrun_verify_policy(struct cpufreq_policy_data *policy)
 {
 	if (!policy)
 		return -EINVAL;
Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
+++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
@@ -109,7 +109,7 @@ struct pcc_cpu {
 
 static struct pcc_cpu __percpu *pcc_cpu_info;
 
-static int pcc_cpufreq_verify(struct cpufreq_policy *policy)
+static int pcc_cpufreq_verify(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
 	return 0;
Index: linux-pm/drivers/cpufreq/unicore2-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/unicore2-cpufreq.c
+++ linux-pm/drivers/cpufreq/unicore2-cpufreq.c
@@ -22,7 +22,7 @@ static struct cpufreq_driver ucv2_driver
 /* make sure that only the "userspace" governor is run
  * -- anything else wouldn't make sense on this platform, anyway.
  */
-static int ucv2_verify_speed(struct cpufreq_policy *policy)
+static int ucv2_verify_speed(struct cpufreq_policy_data *policy)
 {
 	if (policy->cpu)
 		return -EINVAL;




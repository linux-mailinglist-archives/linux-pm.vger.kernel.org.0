Return-Path: <linux-pm+bounces-24589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE9A751D8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEABD1698BB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6D1EB5EE;
	Fri, 28 Mar 2025 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="A6Z0qiU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F01E8356;
	Fri, 28 Mar 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196014; cv=none; b=iEQiXsiSfEwgT+Lj/34sdUnjuD3uExUsjGM7VqBrH0Td9B92+rmgaW/eRkhyfTal7nVSQGMFerI+cSEsLkkujvRXpjE2jNf4829l7bDin3goy15DPTjewMCl46PsnOpofBqFkHs5RgMBQpQYSjKnCpxQsR/PmDINzqEIyFWZ9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196014; c=relaxed/simple;
	bh=dWj5WtUNWGBAuoTSLlTcYZ9NFO1Id/V8tpllggZZt8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTxrBOjBlt3Yp3Bv0SNBy8RMsRc+IYsr2jAjsscA7XJDnxg4Vk8gZv3KQTrj3f5zxbDcmLxoen/MfCDOg/XJyq4Ukvea50LKw2c3S/wOw/erthx/X8X5EI7vS1qnKhEKFKUzFvLmGj/YaxupAk+49evfdoraGdKuF5MZ60znET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=A6Z0qiU/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id e2f9d5478d8e7019; Fri, 28 Mar 2025 22:06:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D4BBE7F0283;
	Fri, 28 Mar 2025 22:06:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743196010;
	bh=dWj5WtUNWGBAuoTSLlTcYZ9NFO1Id/V8tpllggZZt8c=;
	h=From:Subject:Date;
	b=A6Z0qiU/TbMbjskv2bL818G3Od8ETUACKtNi+AHIXvvtzO7n0CRwsVvj+2E1Ui/Vr
	 ixERKIHkJ+tyjjyKYI4C+lQZRjtMTVKJ7iuhAo8XaUqu6zDqyuQzyignyMtKMJwz3T
	 9K4fCJU7NbnNLZRjKLw/qJmosziGvAcochzNW5XbCTncx7YfPVFSzk6JHaTah9ESZ4
	 lL39wNpVZXjtSio39y7fk/nYVbbIKVD27yWhGlSkmt5Wb48UaGwPPjHYczo3/z4s+3
	 az+w8Nop2q08h3olEu0bfnP7sQoIuW3/cCZK4ghEROqn/osKSRXeJQfjirWaK5zuZ6
	 XvKIjXHoXl8qw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 04/10] cpufreq: Add and use cpufreq policy locking guards
Date: Fri, 28 Mar 2025 21:42:48 +0100
Message-ID: <8518682.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=54 Fuz1=54 Fuz2=54

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce "read" and "write" locking guards for cpufreq policies and use
them where applicable in the cpufreq core.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |  121 ++++++++++++++++++++--------------------------
 include/linux/cpufreq.h   |    6 ++
 2 files changed, 60 insertions(+), 67 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -987,17 +987,16 @@
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EBUSY;
 
 	if (!fattr->show)
 		return -EIO;
 
-	down_read(&policy->rwsem);
+	guard(cpufreq_policy_read)(policy);
+
 	if (likely(!policy_is_inactive(policy)))
-		ret = fattr->show(policy, buf);
-	up_read(&policy->rwsem);
+		return fattr->show(policy, buf);
 
-	return ret;
+	return -EBUSY;
 }
 
 static ssize_t store(struct kobject *kobj, struct attribute *attr,
@@ -1005,17 +1004,16 @@
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EBUSY;
 
 	if (!fattr->store)
 		return -EIO;
 
-	down_write(&policy->rwsem);
+	guard(cpufreq_policy_write)(policy);
+
 	if (likely(!policy_is_inactive(policy)))
-		ret = fattr->store(policy, buf, count);
-	up_write(&policy->rwsem);
+		return fattr->store(policy, buf, count);
 
-	return ret;
+	return -EBUSY;
 }
 
 static void cpufreq_sysfs_release(struct kobject *kobj)
@@ -1167,7 +1165,8 @@
 	if (cpumask_test_cpu(cpu, policy->cpus))
 		return 0;
 
-	down_write(&policy->rwsem);
+	guard(cpufreq_policy_write)(policy);
+
 	if (has_target())
 		cpufreq_stop_governor(policy);
 
@@ -1178,7 +1177,7 @@
 		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
 	}
-	up_write(&policy->rwsem);
+
 	return ret;
 }
 
@@ -1198,9 +1197,10 @@
 		container_of(work, struct cpufreq_policy, update);
 
 	pr_debug("handle_update for cpu %u called\n", policy->cpu);
-	down_write(&policy->rwsem);
+
+	guard(cpufreq_policy_write)(policy);
+
 	refresh_frequency_limits(policy);
-	up_write(&policy->rwsem);
 }
 
 static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
@@ -1226,11 +1226,11 @@
 	struct kobject *kobj;
 	struct completion *cmp;
 
-	down_write(&policy->rwsem);
-	cpufreq_stats_free_table(policy);
-	kobj = &policy->kobj;
-	cmp = &policy->kobj_unregister;
-	up_write(&policy->rwsem);
+	scoped_guard(cpufreq_policy_write, policy) {
+		cpufreq_stats_free_table(policy);
+		kobj = &policy->kobj;
+		cmp = &policy->kobj_unregister;
+	}
 	kobject_put(kobj);
 
 	/*
@@ -1381,7 +1381,7 @@
 	unsigned int j;
 	int ret;
 
-	down_write(&policy->rwsem);
+	guard(cpufreq_policy_write)(policy);
 
 	policy->cpu = cpu;
 	policy->governor = NULL;
@@ -1558,10 +1558,7 @@
 		goto out_destroy_policy;
 	}
 
-out_unlock:
-	up_write(&policy->rwsem);
-
-	return ret;
+	return 0;
 
 out_destroy_policy:
 	for_each_cpu(j, policy->real_cpus)
@@ -1578,7 +1575,7 @@
 out_clear_policy:
 	cpumask_clear(policy->cpus);
 
-	goto out_unlock;
+	return ret;
 }
 
 static int cpufreq_online(unsigned int cpu)
@@ -1726,11 +1723,10 @@
 		return 0;
 	}
 
-	down_write(&policy->rwsem);
+	guard(cpufreq_policy_write)(policy);
 
 	__cpufreq_offline(cpu, policy);
 
-	up_write(&policy->rwsem);
 	return 0;
 }
 
@@ -1747,33 +1743,29 @@
 	if (!policy)
 		return;
 
-	down_write(&policy->rwsem);
+	scoped_guard(cpufreq_policy_write, policy) {
+		if (cpu_online(cpu))
+			__cpufreq_offline(cpu, policy);
 
-	if (cpu_online(cpu))
-		__cpufreq_offline(cpu, policy);
+		remove_cpu_dev_symlink(policy, cpu, dev);
 
-	remove_cpu_dev_symlink(policy, cpu, dev);
+		if (!cpumask_empty(policy->real_cpus))
+			return;
 
-	if (!cpumask_empty(policy->real_cpus)) {
-		up_write(&policy->rwsem);
-		return;
-	}
+		/*
+		 * Unregister cpufreq cooling once all the CPUs of the policy
+		 * are removed.
+		 */
+		if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+			cpufreq_cooling_unregister(policy->cdev);
+			policy->cdev = NULL;
+		}
 
-	/*
-	 * Unregister cpufreq cooling once all the CPUs of the policy are
-	 * removed.
-	 */
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
+		/* We did light-weight exit earlier, do full tear down now */
+		if (cpufreq_driver->offline && cpufreq_driver->exit)
+			cpufreq_driver->exit(policy);
 	}
 
-	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline && cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
-
-	up_write(&policy->rwsem);
-
 	cpufreq_policy_free(policy);
 }
 
@@ -1926,15 +1918,16 @@
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	unsigned int ret_freq = 0;
 
-	if (policy) {
-		down_read(&policy->rwsem);
+	if (!policy)
+		return 0;
+
+	scoped_guard(cpufreq_policy_read, policy) {
 		if (cpufreq_driver->get)
 			ret_freq = __cpufreq_get(policy);
-		up_read(&policy->rwsem);
-
-		cpufreq_cpu_put(policy);
 	}
 
+	cpufreq_cpu_put(policy);
+
 	return ret_freq;
 }
 EXPORT_SYMBOL(cpufreq_get);
@@ -1994,9 +1987,9 @@
 
 	for_each_active_policy(policy) {
 		if (has_target()) {
-			down_write(&policy->rwsem);
-			cpufreq_stop_governor(policy);
-			up_write(&policy->rwsem);
+			scoped_guard(cpufreq_policy_write, policy) {
+				cpufreq_stop_governor(policy);
+			}
 		}
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
@@ -2037,9 +2030,9 @@
 			pr_err("%s: Failed to resume driver: %s\n", __func__,
 				cpufreq_driver->name);
 		} else if (has_target()) {
-			down_write(&policy->rwsem);
-			ret = cpufreq_start_governor(policy);
-			up_write(&policy->rwsem);
+			scoped_guard(cpufreq_policy_write, policy) {
+				ret = cpufreq_start_governor(policy);
+			}
 
 			if (ret)
 				pr_err("%s: Failed to start governor for CPU%u's policy\n",
@@ -2406,15 +2399,9 @@
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
-	int ret;
+	guard(cpufreq_policy_write)(policy);
 
-	down_write(&policy->rwsem);
-
-	ret = __cpufreq_driver_target(policy, target_freq, relation);
-
-	up_write(&policy->rwsem);
-
-	return ret;
+	return __cpufreq_driver_target(policy, target_freq, relation);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -170,6 +170,12 @@
 	struct notifier_block nb_max;
 };
 
+DEFINE_GUARD(cpufreq_policy_write, struct cpufreq_policy *,
+	     down_write(&_T->rwsem), up_write(&_T->rwsem))
+
+DEFINE_GUARD(cpufreq_policy_read, struct cpufreq_policy *,
+	     down_read(&_T->rwsem), up_read(&_T->rwsem))
+
 /*
  * Used for passing new cpufreq policy data to the cpufreq driver's ->verify()
  * callback for sanitization.  That callback is only expected to modify the min





Return-Path: <linux-pm+bounces-37633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E17C4142F
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7CC4F17C5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19118339717;
	Fri,  7 Nov 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmhrtoES"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBD332ED7;
	Fri,  7 Nov 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539510; cv=none; b=RZ+wXpu7IVumRs9W9K+eMgYchFShr5wLYvjXTp/ecDJGePHCKCYKVyHmY4UpcXLu/bOaoNyfTQN94apn3cEDBIe4AMiUhAe8DxkYyOlQNVnaErvbJBdhtDMXQ7gdBDsqnkJRaQt4nO8btvO8mIOWc3eFMmNm3hxKU3j13KOe3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539510; c=relaxed/simple;
	bh=xQVzgD7GVp4/BOHYm5HSOOyNHFn2GczjN+HJaZNJ9rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRACWw0MQU3q4uR8A+FJzvswaekEcZ+iCMPFI7tG7+ydQGidNwRL7e8XO9Xmh/OO4oZ8CK3FhaBLKz0fYS+QyFdOUuKpFUO4GNn0CXJvlDwkguxXreJFPfTJ2XkoniriuDb4Z3QHlJWpekf3Fo36s1p7ci4MSeiZ8a6r0Ilz88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmhrtoES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B850C16AAE;
	Fri,  7 Nov 2025 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539509;
	bh=xQVzgD7GVp4/BOHYm5HSOOyNHFn2GczjN+HJaZNJ9rQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YmhrtoESWEncfjf37tPDWCHbtqdtyJtTEOJEqtkkEAauFWUX5ULRZkT9eLRQ0+4dp
	 3M/tvhxVIj1iehJavPfUh7hgLbUloLRzK1pqAHoKX3GaIPSn4dsFK34mt6RErMJ286
	 7ImXSLjsGBmoDdVOPXiPAgJXn4Arrg3SQN6C492dB8IM7VYlphzbC+1oICTkjL5kX4
	 GxzuimQEEoatcFbkHPMhJ75gJjRjKqE5LkSOF1JlEnsU+LGx7DWUO3mCu2dnTijI+1
	 ZbjqtE+L+ODG8SJHtiHUGBRT2nGyeloXigNuNo//szQCVZ5RMkz1356I7ETmM3R4SW
	 5OsiGa1L3uxzg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Use mutex guard for driver locking
Date: Fri, 07 Nov 2025 19:18:26 +0100
Message-ID: <2807232.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use guard(mutex)(&intel_pstate_driver_lock), or the scoped variant of
it, wherever intel_pstate_driver_lock needs to be held.

This allows some local variables and goto statements to be dropped as
they are not necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   99 +++++++++++++----------------------------
 1 file changed, 33 insertions(+), 66 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1467,7 +1467,8 @@ static void set_power_ctl_ee_state(bool
 {
 	u64 power_ctl;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
+
 	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
 	if (input) {
 		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
@@ -1477,7 +1478,6 @@ static void set_power_ctl_ee_state(bool
 		power_ctl_ee_state = POWER_CTL_EE_DISABLE;
 	}
 	wrmsrq(MSR_IA32_POWER_CTL, power_ctl);
-	mutex_unlock(&intel_pstate_driver_lock);
 }
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
@@ -1599,13 +1599,9 @@ static int intel_pstate_update_status(co
 static ssize_t show_status(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
-	ssize_t ret;
-
-	mutex_lock(&intel_pstate_driver_lock);
-	ret = intel_pstate_show_status(buf);
-	mutex_unlock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	return ret;
+	return intel_pstate_show_status(buf);
 }
 
 static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
@@ -1614,11 +1610,13 @@ static ssize_t store_status(struct kobje
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
+
 	ret = intel_pstate_update_status(buf, p ? p - buf : count);
-	mutex_unlock(&intel_pstate_driver_lock);
+	if (ret < 0)
+		return ret;
 
-	return ret < 0 ? ret : count;
+	return count;
 }
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
@@ -1628,12 +1626,10 @@ static ssize_t show_turbo_pct(struct kob
 	int total, no_turbo, turbo_pct;
 	uint32_t turbo_fp;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
+	if (!intel_pstate_driver)
 		return -EAGAIN;
-	}
 
 	cpu = all_cpu_data[0];
 
@@ -1642,8 +1638,6 @@ static ssize_t show_turbo_pct(struct kob
 	turbo_fp = div_fp(no_turbo, total);
 	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
 
-	mutex_unlock(&intel_pstate_driver_lock);
-
 	return sprintf(buf, "%u\n", turbo_pct);
 }
 
@@ -1653,38 +1647,26 @@ static ssize_t show_num_pstates(struct k
 	struct cpudata *cpu;
 	int total;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
+	if (!intel_pstate_driver)
 		return -EAGAIN;
-	}
 
 	cpu = all_cpu_data[0];
 	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
 
-	mutex_unlock(&intel_pstate_driver_lock);
-
 	return sprintf(buf, "%u\n", total);
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *buf)
 {
-	ssize_t ret;
-
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
+	if (!intel_pstate_driver)
 		return -EAGAIN;
-	}
-
-	ret = sprintf(buf, "%u\n", global.no_turbo);
-
-	mutex_unlock(&intel_pstate_driver_lock);
 
-	return ret;
+	return sprintf(buf, "%u\n", global.no_turbo);
 }
 
 static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
@@ -1696,29 +1678,25 @@ static ssize_t store_no_turbo(struct kob
 	if (sscanf(buf, "%u", &input) != 1)
 		return -EINVAL;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		count = -EAGAIN;
-		goto unlock_driver;
-	}
+	if (!intel_pstate_driver)
+		return -EAGAIN;
 
 	no_turbo = !!clamp_t(int, input, 0, 1);
 
 	WRITE_ONCE(global.turbo_disabled, turbo_is_disabled());
 	if (global.turbo_disabled && !no_turbo) {
 		pr_notice("Turbo disabled by BIOS or unavailable on processor\n");
-		count = -EPERM;
 		if (global.no_turbo)
-			goto unlock_driver;
-		else
-			no_turbo = 1;
-	}
+			return -EPERM;
 
-	if (no_turbo == global.no_turbo) {
-		goto unlock_driver;
+		no_turbo = 1;
 	}
 
+	if (no_turbo == global.no_turbo)
+		return count;
+
 	WRITE_ONCE(global.no_turbo, no_turbo);
 
 	mutex_lock(&intel_pstate_limits_lock);
@@ -1737,9 +1715,6 @@ static ssize_t store_no_turbo(struct kob
 	intel_pstate_update_limits_for_all();
 	arch_set_max_freq_ratio(no_turbo);
 
-unlock_driver:
-	mutex_unlock(&intel_pstate_driver_lock);
-
 	return count;
 }
 
@@ -1789,12 +1764,10 @@ static ssize_t store_max_perf_pct(struct
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
+	if (!intel_pstate_driver)
 		return -EAGAIN;
-	}
 
 	mutex_lock(&intel_pstate_limits_lock);
 
@@ -1807,8 +1780,6 @@ static ssize_t store_max_perf_pct(struct
 	else
 		update_qos_requests(FREQ_QOS_MAX);
 
-	mutex_unlock(&intel_pstate_driver_lock);
-
 	return count;
 }
 
@@ -1822,12 +1793,10 @@ static ssize_t store_min_perf_pct(struct
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
 
-	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
+	if (!intel_pstate_driver)
 		return -EAGAIN;
-	}
 
 	mutex_lock(&intel_pstate_limits_lock);
 
@@ -1841,8 +1810,6 @@ static ssize_t store_min_perf_pct(struct
 	else
 		update_qos_requests(FREQ_QOS_MIN);
 
-	mutex_unlock(&intel_pstate_driver_lock);
-
 	return count;
 }
 
@@ -1863,10 +1830,10 @@ static ssize_t store_hwp_dynamic_boost(s
 	if (ret)
 		return ret;
 
-	mutex_lock(&intel_pstate_driver_lock);
+	guard(mutex)(&intel_pstate_driver_lock);
+
 	hwp_boost = !!input;
 	intel_pstate_update_policies();
-	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
 }
@@ -3977,9 +3944,9 @@ hwp_cpu_matched:
 
 	}
 
-	mutex_lock(&intel_pstate_driver_lock);
-	rc = intel_pstate_register_driver(default_driver);
-	mutex_unlock(&intel_pstate_driver_lock);
+	scoped_guard(mutex, &intel_pstate_driver_lock) {
+		rc = intel_pstate_register_driver(default_driver);
+	}
 	if (rc) {
 		intel_pstate_sysfs_remove();
 		return rc;





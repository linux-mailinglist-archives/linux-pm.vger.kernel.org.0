Return-Path: <linux-pm+bounces-6279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD38A1823
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 17:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910CA1F245C7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F5DDC4;
	Thu, 11 Apr 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qY5VnNkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D902DF42;
	Thu, 11 Apr 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848008; cv=none; b=P9CW+jlFaUWnYHODc/lfxEQZE+lllLA5sEMJN2WBBZxlmosFBjlXHkLgs/V4b4qNevCStZpF1n36NO2D9nwyTvlpaWBJthKTSctyQhJRrB8IVqYJ+cuE0RxjdA78zvNepf8Emr/CBXezxy+lttWg7nLKvbFAIU+G/ML4J+hAIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848008; c=relaxed/simple;
	bh=C6vXPh7Ldx4KhgbuYgRJZPLELakzOPaiKKdVUBf4PSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9Q3udg4d6DtVhjJT4bTYpqAMRc1+dgtL6n3e1n/qmHTcfJwCNHcYPaK2L48Jse6iCvfSBZ7HIve26GrAd6ouQfiMpXeQexyROTjeti5MD5MMCIGWQ6lE17Tv+W3C2VFDLHZoZK7OwnWnVpkf+Vt1FxSUKH0o7ZULIIrpLub3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qY5VnNkm; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LzweM
	wJIknLqf15S3nYrZOUI8TDHp5K5t8mMB7psTts=; b=qY5VnNkmyXZMIEILoNSzc
	ZDxQEegYk2q4oVFr2wRbgZPHhlC0zTDO9brzt9uoMDH+GC6ZIdWVO5EGMo/RrqRw
	I1Ofnrq9upHfRHoav/SkLds6w5yIYMoano4idFatkbVj7COMkPbmXUIuHT2Ymgiu
	1RW0Wc9nQci9nrfrFYczz4=
Received: from localhost.localdomain (unknown [101.86.127.38])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDHT4dB_BdmjsBKAw--.39632S4;
	Thu, 11 Apr 2024 23:05:59 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: ray.huang@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: Covert to offline callback returning void
Date: Thu, 11 Apr 2024 08:05:27 -0700
Message-Id: <20240411150527.19201-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHT4dB_BdmjsBKAw--.39632S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyUKw13JF1UXw4xXF1kKrg_yoWxGr4fpF
	4UWrWvkr10qFWDt3y7Ca1Dua4a9Fs7A3yUG34xCasYvanrJ3WYg3WDGryUZFWFkrykWF43
	Ar1rtayxGa18JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKBq9q2XAk2EhBAABsX

For the offline() callback function returning an int type value,
this leads many driver authors mistakenly believing that error
handling can be performed by returning an error code, However
the returned value is ignored, and to improve this situation,
it is proposed to modify the return type of the offline() callback
function to void.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/amd-pstate.c       |  4 +---
 drivers/cpufreq/cpufreq.c          |  3 +--
 drivers/cpufreq/intel_pstate.c     | 10 ++++------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  6 ++----
 drivers/cpufreq/tegra194-cpufreq.c | 11 -----------
 include/linux/cpufreq.h            |  2 +-
 6 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..036608935aaa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1530,7 +1530,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	mutex_unlock(&amd_pstate_limits_lock);
 }
 
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+static void amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
@@ -1541,8 +1541,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		amd_pstate_epp_offline(policy);
-
-	return 0;
 }
 
 static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..04d349372de3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1685,7 +1685,7 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	}
 }
 
-static int cpufreq_offline(unsigned int cpu)
+static void cpufreq_offline(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
 
@@ -1702,7 +1702,6 @@ static int cpufreq_offline(unsigned int cpu)
 	__cpufreq_offline(cpu, policy);
 
 	up_write(&policy->rwsem);
-	return 0;
 }
 
 /*
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dbbf299f4219..80dfe1c20210 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2679,14 +2679,14 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+static void intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	pr_debug("CPU %d going offline\n", cpu->cpu);
 
 	if (cpu->suspended)
-		return 0;
+		return;
 
 	/*
 	 * If the CPU is an SMT thread and it goes offline with the performance
@@ -2700,8 +2700,6 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 		intel_pstate_set_min_pstate(cpu);
 
 	intel_pstate_exit_perf_limits(policy);
-
-	return 0;
 }
 
 static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
@@ -2724,11 +2722,11 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
+static void intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
-	return intel_cpufreq_cpu_offline(policy);
+	intel_cpufreq_cpu_offline(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 70b0f21968a0..dc35fa3cc3ce 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -482,12 +482,12 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
+static void qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
 
 	if (data->throttle_irq <= 0)
-		return 0;
+		return;
 
 	mutex_lock(&data->throttle_lock);
 	data->cancel_throttle = true;
@@ -496,8 +496,6 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 	cancel_delayed_work_sync(&data->throttle_work);
 	irq_set_affinity_and_hint(data->throttle_irq, NULL);
 	disable_irq_nosync(data->throttle_irq);
-
-	return 0;
 }
 
 static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 59865ea455a8..8b57dcd43d54 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -541,16 +541,6 @@ static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
-{
-	/*
-	 * Preserve policy->driver_data and don't free resources on light-weight
-	 * tear down.
-	 */
-
-	return 0;
-}
-
 static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
@@ -590,7 +580,6 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.init = tegra194_cpufreq_init,
 	.exit = tegra194_cpufreq_exit,
 	.online = tegra194_cpufreq_online,
-	.offline = tegra194_cpufreq_offline,
 	.attr = cpufreq_generic_attr,
 };
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9956afb9acc2..2472e9fd2df9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -385,7 +385,7 @@ struct cpufreq_driver {
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
 	int		(*online)(struct cpufreq_policy *policy);
-	int		(*offline)(struct cpufreq_policy *policy);
+	void		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
-- 
2.25.1



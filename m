Return-Path: <linux-pm+bounces-26769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E29AAD3FE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 05:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC577AF317
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 03:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1CC1AF0B4;
	Wed,  7 May 2025 03:19:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EF78C9C;
	Wed,  7 May 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587994; cv=none; b=txSxd/R5LAfC8BI4PKZ7JN/GBztqGfpvynsA8gcN33yiF2S3rlyIMwZA1a5AfhZoRiLJQ2Sy5yQywML65VoN4nIuyVpby15VXL0uIWaEDQfbA1lGRUpjvha57ZpAWC9ECTpob9az14P47708V6E4pOXBgUTrP7GVSZ1AM7BIDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587994; c=relaxed/simple;
	bh=gjTSE8TwjXFd7R7STL4/axrDCulEZEZIXFeZ/4lbO6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hr7daHTeVvZUkdw3igne+cPOSKFAB1aCxxzf0733TasS4pZaOr6/6iDvptlf6wFKLidG5V2wDrHHj0FJX/a4ZiEtuKsEqTRk2aofDhi4ZY+zUhitsgPmgO8EVKR5H0ZKhEdzSQ/uUtUr89Sx01yLuDHE/aIeUuSHDsqX1ifZDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZsgTl75PlzsTJb;
	Wed,  7 May 2025 11:19:07 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BDD301A016C;
	Wed,  7 May 2025 11:19:42 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 11:19:41 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <mario.limonciello@amd.com>,
	<yumpusamongus@gmail.com>, <srinivas.pandruvada@linux.intel.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <cenxinghai@h-partners.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>, <hepeng68@huawei.com>
Subject: [PATCH] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
Date: Wed, 7 May 2025 11:19:41 +0800
Message-ID: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
Hi Rafael,

This patch is the 8th patch in [1]. After the discussion in [2], Sumit
is OK with adding sysfs entries under cpufreq sysfs node, so I resend
this patch. He will later send his updated patch after.

Any comments appreciated!

Lifeng

[1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
[2] https://lore.kernel.org/all/20250211103737.447704-1-sumitg@nvidia.com/

 .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..37065e1b8ebc 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
 		This file is only present if the acpi-cpufreq or the cppc-cpufreq
 		drivers are in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_select
+Date:		May 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Autonomous selection enable
+
+		Read/write interface to control autonomous selection enable
+			Read returns autonomous selection status:
+				0: autonomous selection is disabled
+				1: autonomous selection is enabled
+
+			Write 'y' or '1' or 'on' to enable autonomous selection.
+			Write 'n' or '0' or 'off' to disable autonomous selection.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
+Date:		May 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Autonomous activity window
+
+		This file indicates a moving utilization sensitivity window to
+		the platform's autonomous selection policy.
+
+		Read/write an integer represents autonomous activity window (in
+		microseconds) from/to this file. The max value to write is
+		1270000000 but the max significand is 127. This means that if 128
+		is written to this file, 127 will be stored. If the value is
+		greater than 130, only the first two digits will be saved as
+		significand.
+
+		Writing a zero value to this file enable the platform to
+		determine an appropriate Activity Window depending on the workload.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference_val
+Date:		May 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Energy performance preference
+
+		Read/write an 8-bit integer from/to this file. This file
+		represents a range of values from 0 (performance preference) to
+		0xFF (energy efficiency preference) that influences the rate of
+		performance increase/decrease and the result of the hardware's
+		energy efficiency and performance optimization policies.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b3d74f9adcf0..3c3d00cec298 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -808,10 +808,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
+
+static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
+{
+	bool val;
+	int ret;
+
+	ret = cppc_get_auto_sel(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t store_auto_select(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_sel(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_auto_act_window(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
+{
+	u64 usec;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &usec);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_act_window(policy->cpu, usec);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_epp_perf(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
+						       const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_epp(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
+cpufreq_freq_attr_rw(auto_select);
+cpufreq_freq_attr_rw(auto_act_window);
+cpufreq_freq_attr_rw(energy_performance_preference_val);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
+	&auto_select,
+	&auto_act_window,
+	&energy_performance_preference_val,
 	NULL,
 };
 
-- 
2.33.0



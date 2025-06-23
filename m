Return-Path: <linux-pm+bounces-29302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A10AE408C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9998188569C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C49248898;
	Mon, 23 Jun 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="O3nDv+n6"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD3248F5A;
	Mon, 23 Jun 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682021; cv=none; b=YwkSBqcrx9HmPOtpX8465D7rri+0LC7aZAoOwDNBIHkVzxYKwTRb91WXNduZ7Bsco52aQ1qTANhGY2NGXmurEL2py2q+t9imUapTAPIgQsvkVhjkJz9sGJVD5R78BrY9hGnrnvFyFuxBW7aDwHxGTry/AZFV0Z34XSyivj/WEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682021; c=relaxed/simple;
	bh=qQGxvBNHU2dXYiGooG6KN3o2r2CrqViRIjzV889alLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aic9UdhzCdSEY/ZKR38CeirWZXFBchdzOWDAJSfvbgsZVklpwxQ5Rb3z9MlkPuwqPiWe7n9wOnYgOc+6v8rgEXwcEtpFoQPzOrmGxe6Di2WBbLCYeaO6IbRUxNWvQnvkEHCdtyc5GzE1LKUuewrQKQHTl/5WuJV8HkQSkQ4I5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=O3nDv+n6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6B6CD20F94;
	Mon, 23 Jun 2025 14:33:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQVU2dmlLTXP; Mon, 23 Jun 2025 14:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750682013; bh=qQGxvBNHU2dXYiGooG6KN3o2r2CrqViRIjzV889alLE=;
	h=From:To:Cc:Subject:Date;
	b=O3nDv+n6lZs5uITbGm773Kcb6xRXfjZ4DL7lH/qOwPcN63Bv7LZFstAnHhS6vWnP1
	 O99YibXA9S1fkZwK9mkwG+mmO+wIXYK4cyBDJYwOUParZ4+2XBX5sHUmcFjtxVTaH/
	 nvG1gSEDsgFJmKfpqhvezNOJ2O+7jnkM3I9MlJbY2p1snij8jbyCqZB561I8virwPO
	 cDke10AQ/QjMFelicUcEWb6CQswwAuWzewSJdFbq/7Spi5JUpwggnaqHvzziGtuwBI
	 YhS95U4WS7ZGgUZabMBUVXrEb1epjemNxmlvxlCEEFSTxAxNpONpHwuZgRN6XAZCMN
	 Uzyqj7MsddKcA==
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] cpufreq: loongson3: Support older SMC firmware
Date: Mon, 23 Jun 2025 12:33:21 +0000
Message-ID: <20250623123321.5622-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMC firmware found on many on-market LoongArch devices implement a
different ABI than what has been implemented in the current upstream
driver. They significantly differ in the following ways:

- CMD_GET_VERSION returns 0.
- There is no known SMC call to obtain corresponding frequencies for
  each frequency level. The frequency table must therefore be calculated
  with CPU clock frequency from scratch.
- There is no known SMC call to obtain the current frequency level.
- The main processor must determine the set of cores able to run at
  boost frequency and enable boosting manually.
- SMC call response format may vary between commands.

This patch adds support for the SMC firmware found on these devices,
which I denoted as "SMC-0" in the driver. Boost support is omitted,
since determination of cores able to boost requires the driver to couple
tightly with micro-architecture details.

For coexistence, I prefixed all SMC-call constants with their SMC
versions, and introduced "SMC-0"-specific initialization and
frequency-level-setup rountines.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/cpufreq/loongson3_cpufreq.c | 287 ++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 76 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 1e8715ea1b77..b61b2e712694 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -16,10 +16,13 @@
 #include <asm/idle.h>
 #include <asm/loongarch.h>
 #include <asm/loongson.h>
+#include <asm/time.h>
 
 /* Message */
 union smc_message {
 	u32 value;
+
+	/* Generic message type */
 	struct {
 		u32 id		: 4;
 		u32 info	: 4;
@@ -28,6 +31,15 @@ union smc_message {
 		u32 extra	: 1;
 		u32 complete	: 1;
 	};
+
+	/* Returned by SMC0_GET_DVFS_INFO */
+	struct {
+		u32 min_level		: 4;
+		u32 max_level		: 4;
+		u32 boost_freq		: 16;
+		u32 normal_core_limit	: 4;
+		u32 boost_cores		: 4;
+	};
 };
 
 /* Command return values */
@@ -44,136 +56,153 @@ union smc_message {
  */
 #define CMD_GET_VERSION			0x1
 
+/* SMC version 0 service calls */
+/*
+ * SMC0_CMD_SET_FREQ_LEVEL - Set frequency level
+ * Input: CPU ID, level ID
+ * Output: none
+ */
+#define SMC0_CMD_SET_FREQ_LEVEL		0x21
+
+/*
+ * SMC0_CMD_GET_DVFS_INFO - Get DVFS information
+ * Input: CPU ID
+ * Output: DVFS Information
+ */
+#define SMC0_CMD_GET_DVFS_INFO		0x22
+
+/* SMC version 1 service calls */
 /* Feature commands */
 /*
- * CMD_GET_FEATURE - Get feature state
+ * SMC1_CMD_GET_FEATURE - Get feature state
  * Input: feature ID
  * Output: feature flag
  */
-#define CMD_GET_FEATURE			0x2
+#define SMC1_CMD_GET_FEATURE		0x2
 
 /*
- * CMD_SET_FEATURE - Set feature state
+ * SMC1_CMD_SET_FEATURE - Set feature state
  * Input: feature ID, feature flag
  * output: none
  */
-#define CMD_SET_FEATURE			0x3
+#define SMC1_CMD_SET_FEATURE		0x3
 
 /* Feature IDs */
-#define FEATURE_SENSOR			0
-#define FEATURE_FAN			1
-#define FEATURE_DVFS			2
+#define SMC1_FEATURE_SENSOR		0
+#define SMC1_FEATURE_FAN		1
+#define SMC1_FEATURE_DVFS		2
 
 /* Sensor feature flags */
-#define FEATURE_SENSOR_ENABLE		BIT(0)
-#define FEATURE_SENSOR_SAMPLE		BIT(1)
+#define SMC1_FEATURE_SENSOR_ENABLE	BIT(0)
+#define SMC1_FEATURE_SENSOR_SAMPLE	BIT(1)
 
 /* Fan feature flags */
-#define FEATURE_FAN_ENABLE		BIT(0)
-#define FEATURE_FAN_AUTO		BIT(1)
+#define SMC1_FEATURE_FAN_ENABLE		BIT(0)
+#define SMC1_FEATURE_FAN_AUTO		BIT(1)
 
 /* DVFS feature flags */
-#define FEATURE_DVFS_ENABLE		BIT(0)
-#define FEATURE_DVFS_BOOST		BIT(1)
-#define FEATURE_DVFS_AUTO		BIT(2)
-#define FEATURE_DVFS_SINGLE_BOOST	BIT(3)
+#define SMC1_FEATURE_DVFS_ENABLE	BIT(0)
+#define SMC1_FEATURE_DVFS_BOOST		BIT(1)
+#define SMC1_FEATURE_DVFS_AUTO		BIT(2)
+#define SMC1_FEATURE_DVFS_SINGLE_BOOST	BIT(3)
 
 /* Sensor commands */
 /*
- * CMD_GET_SENSOR_NUM - Get number of sensors
+ * SMC1_CMD_GET_SENSOR_NUM - Get number of sensors
  * Input: none
  * Output: number
  */
-#define CMD_GET_SENSOR_NUM		0x4
+#define SMC1_CMD_GET_SENSOR_NUM		0x4
 
 /*
- * CMD_GET_SENSOR_STATUS - Get sensor status
+ * SMC1_CMD_GET_SENSOR_STATUS - Get sensor status
  * Input: sensor ID, type
  * Output: sensor status
  */
-#define CMD_GET_SENSOR_STATUS		0x5
+#define SMC1_CMD_GET_SENSOR_STATUS	0x5
 
 /* Sensor types */
-#define SENSOR_INFO_TYPE		0
-#define SENSOR_INFO_TYPE_TEMP		1
+#define SMC1_SENSOR_INFO_TYPE		0
+#define SMC1_SENSOR_INFO_TYPE_TEMP	1
 
 /* Fan commands */
 /*
- * CMD_GET_FAN_NUM - Get number of fans
+ * SMC1_CMD_GET_FAN_NUM - Get number of fans
  * Input: none
  * Output: number
  */
-#define CMD_GET_FAN_NUM			0x6
+#define SMC1_CMD_GET_FAN_NUM		0x6
 
 /*
- * CMD_GET_FAN_INFO - Get fan status
+ * SMC1_CMD_GET_FAN_INFO - Get fan status
  * Input: fan ID, type
  * Output: fan info
  */
-#define CMD_GET_FAN_INFO		0x7
+#define SMC1_CMD_GET_FAN_INFO		0x7
 
 /*
- * CMD_SET_FAN_INFO - Set fan status
+ * SMC1_CMD_SET_FAN_INFO - Set fan status
  * Input: fan ID, type, value
  * Output: none
  */
-#define CMD_SET_FAN_INFO		0x8
+#define SMC1_CMD_SET_FAN_INFO		0x8
 
 /* Fan types */
-#define FAN_INFO_TYPE_LEVEL		0
+#define SMC1_FAN_INFO_TYPE_LEVEL	0
 
 /* DVFS commands */
 /*
- * CMD_GET_FREQ_LEVEL_NUM - Get number of freq levels
+ * SMC1_CMD_GET_FREQ_LEVEL_NUM - Get number of freq levels
  * Input: CPU ID
  * Output: number
  */
-#define CMD_GET_FREQ_LEVEL_NUM		0x9
+#define SMC1_CMD_GET_FREQ_LEVEL_NUM	0x9
 
 /*
- * CMD_GET_FREQ_BOOST_LEVEL - Get the first boost level
+ * SMC1_CMD_GET_FREQ_BOOST_LEVEL - Get the first boost level
  * Input: CPU ID
  * Output: number
  */
-#define CMD_GET_FREQ_BOOST_LEVEL	0x10
+#define SMC1_CMD_GET_FREQ_BOOST_LEVEL	0x10
 
 /*
- * CMD_GET_FREQ_LEVEL_INFO - Get freq level info
+ * SMC1_CMD_GET_FREQ_LEVEL_INFO - Get freq level info
  * Input: CPU ID, level ID
  * Output: level info
  */
-#define CMD_GET_FREQ_LEVEL_INFO		0x11
+#define SMC1_CMD_GET_FREQ_LEVEL_INFO	0x11
 
 /*
- * CMD_GET_FREQ_INFO - Get freq info
+ * SMC1_CMD_GET_FREQ_INFO - Get freq info
  * Input: CPU ID, type
  * Output: freq info
  */
-#define CMD_GET_FREQ_INFO		0x12
+#define SMC1_CMD_GET_FREQ_INFO		0x12
 
 /*
- * CMD_SET_FREQ_INFO - Set freq info
+ * SMC1_CMD_SET_FREQ_INFO - Set freq info
  * Input: CPU ID, type, value
  * Output: none
  */
-#define CMD_SET_FREQ_INFO		0x13
+#define SMC1_CMD_SET_FREQ_INFO		0x13
 
 /* Freq types */
-#define FREQ_INFO_TYPE_FREQ		0
-#define FREQ_INFO_TYPE_LEVEL		1
+#define SMC1_FREQ_INFO_TYPE_FREQ	0
+#define SMC1_FREQ_INFO_TYPE_LEVEL	1
 
-#define FREQ_MAX_LEVEL			16
+#define SMC1_FREQ_MAX_LEVEL		16
 
 struct loongson3_freq_data {
-	unsigned int def_freq_level;
+	unsigned int min_freq_level, def_freq_level;
 	struct cpufreq_frequency_table table[];
 };
 
 static struct mutex cpufreq_mutex[MAX_PACKAGES];
-static struct cpufreq_driver loongson3_cpufreq_driver;
+static struct cpufreq_driver *loongson3_cpufreq_current_driver;
 static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
 
-static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
+static inline int do_service_request_raw(u32 id, u32 info, u32 cmd, u32 val,
+					 u32 extra, union smc_message *raw)
 {
 	int retries;
 	unsigned int cpu = raw_smp_processor_id();
@@ -214,29 +243,90 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 
 	mutex_unlock(&cpufreq_mutex[package]);
 
+	if (raw)
+		*raw = msg;
+
 	return msg.val;
 }
 
-static unsigned int loongson3_cpufreq_get(unsigned int cpu)
+#define do_service_request(id, info, cmd, val, extra) \
+	do_service_request_raw(id, info, cmd, val, extra, NULL)
+
+static unsigned int loongson3_cpufreq_smc1_get(unsigned int cpu)
 {
 	int ret;
 
-	ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
+	ret = do_service_request(cpu, SMC1_FREQ_INFO_TYPE_FREQ,
+				 SMC1_CMD_GET_FREQ_INFO, 0, 0);
 
 	return ret * KILO;
 }
 
-static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
+static int loongson3_cpufreq_smc0_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	index += per_cpu(freq_data, cpu)->min_freq_level;
+
+	ret = do_service_request(cpu_data[cpu].core, index, SMC0_CMD_SET_FREQ_LEVEL,
+				 0, 0);
+
+	return (ret >= 0) ? 0 : ret;
+}
+
+static int loongson3_cpufreq_smc1_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int ret;
 
 	ret = do_service_request(cpu_data[policy->cpu].core,
-				 FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
+				 SMC1_FREQ_INFO_TYPE_LEVEL, SMC1_CMD_SET_FREQ_INFO, index, 0);
 
 	return (ret >= 0) ? 0 : ret;
 }
 
-static int configure_freq_table(int cpu)
+static int configure_smc0_freq_table(int cpu)
+{
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct loongson3_freq_data *data;
+	int ret, freq_level, i;
+	union smc_message msg;
+
+	if (per_cpu(freq_data, cpu))
+		return 0;
+
+	ret = do_service_request_raw(cpu, 0, SMC0_CMD_GET_DVFS_INFO, 0, 0, &msg);
+	if (ret < 0)
+		return ret;
+
+	freq_level = msg.max_level - msg.min_level + 1;
+	data = devm_kzalloc(&pdev->dev, struct_size(data, table, freq_level + 1),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->def_freq_level = 0;
+	data->min_freq_level = msg.min_level;
+
+	for (i = 0; i < freq_level; i++) {
+		unsigned long frequency;
+
+		frequency = cpu_clock_freq / KILO;
+		frequency = frequency * (freq_level - i) / freq_level;
+
+		data->table[i].frequency = frequency;
+		data->table[i].flags = 0;
+	}
+
+	data->table[freq_level].frequency = CPUFREQ_TABLE_END;
+	data->table[freq_level].flags = 0;
+
+	per_cpu(freq_data, cpu) = data;
+
+	return 0;
+}
+
+static int configure_smc1_freq_table(int cpu)
 {
 	int i, ret, boost_level, max_level, freq_level;
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -245,17 +335,17 @@ static int configure_freq_table(int cpu)
 	if (per_cpu(freq_data, cpu))
 		return 0;
 
-	ret = do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
+	ret = do_service_request(cpu, 0, SMC1_CMD_GET_FREQ_LEVEL_NUM, 0, 0);
 	if (ret < 0)
 		return ret;
 	max_level = ret;
 
-	ret = do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
+	ret = do_service_request(cpu, 0, SMC1_CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
 	if (ret < 0)
 		return ret;
 	boost_level = ret;
 
-	freq_level = min(max_level, FREQ_MAX_LEVEL);
+	freq_level = min(max_level, SMC1_FREQ_MAX_LEVEL);
 	data = devm_kzalloc(&pdev->dev, struct_size(data, table, freq_level + 1), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -263,7 +353,8 @@ static int configure_freq_table(int cpu)
 	data->def_freq_level = boost_level - 1;
 
 	for (i = 0; i < freq_level; i++) {
-		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
+		ret = do_service_request(cpu, SMC1_FREQ_INFO_TYPE_FREQ,
+					 SMC1_CMD_GET_FREQ_LEVEL_INFO, i, 0);
 		if (ret < 0) {
 			devm_kfree(&pdev->dev, data);
 			return ret;
@@ -281,32 +372,56 @@ static int configure_freq_table(int cpu)
 	return 0;
 }
 
-static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static void loongson3_cpufreq_init_data(struct cpufreq_policy *policy)
 {
-	int i, ret, cpu = policy->cpu;
-
-	ret = configure_freq_table(cpu);
-	if (ret < 0)
-		return ret;
+	struct loongson3_freq_data *data;
+	int i, cpu = policy->cpu;
 
+	data = per_cpu(freq_data, cpu);
 	policy->cpuinfo.transition_latency = 10000;
-	policy->freq_table = per_cpu(freq_data, cpu)->table;
-	policy->suspend_freq = policy->freq_table[per_cpu(freq_data, cpu)->def_freq_level].frequency;
+	policy->freq_table = data->table;
+	policy->suspend_freq = data->table[data->def_freq_level].frequency;
 	cpumask_copy(policy->cpus, topology_sibling_cpumask(cpu));
 
 	for_each_cpu(i, policy->cpus) {
 		if (i != cpu)
 			per_cpu(freq_data, i) = per_cpu(freq_data, cpu);
 	}
+}
+
+static int loongson3_cpufreq_cpu_smc0_init(struct cpufreq_policy *policy)
+{
+	int ret, cpu = policy->cpu;
+
+	ret = configure_smc0_freq_table(cpu);
+	if (ret < 0)
+		return ret;
+
+	loongson3_cpufreq_init_data(policy);
+
+	return 0;
+}
+
+static int loongson3_cpufreq_cpu_smc1_init(struct cpufreq_policy *policy)
+{
+	int ret, cpu = policy->cpu;
+
+	ret = configure_smc1_freq_table(cpu);
+	if (ret < 0)
+		return ret;
+
+	loongson3_cpufreq_init_data(policy);
 
 	return 0;
 }
 
 static void loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
+	unsigned int def_freq_level;
 	int cpu = policy->cpu;
 
-	loongson3_cpufreq_target(policy, per_cpu(freq_data, cpu)->def_freq_level);
+	def_freq_level = per_cpu(freq_data, cpu)->def_freq_level;
+	loongson3_cpufreq_current_driver->target_index(policy, def_freq_level);
 }
 
 static int loongson3_cpufreq_cpu_online(struct cpufreq_policy *policy)
@@ -319,15 +434,27 @@ static int loongson3_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct cpufreq_driver loongson3_cpufreq_driver = {
+static struct cpufreq_driver loongson3_cpufreq_smc0_driver = {
 	.name = "loongson3",
 	.flags = CPUFREQ_CONST_LOOPS,
-	.init = loongson3_cpufreq_cpu_init,
+	.init = loongson3_cpufreq_cpu_smc0_init,
 	.exit = loongson3_cpufreq_cpu_exit,
 	.online = loongson3_cpufreq_cpu_online,
 	.offline = loongson3_cpufreq_cpu_offline,
-	.get = loongson3_cpufreq_get,
-	.target_index = loongson3_cpufreq_target,
+	.target_index = loongson3_cpufreq_smc0_target,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.suspend = cpufreq_generic_suspend,
+};
+
+static struct cpufreq_driver loongson3_cpufreq_smc1_driver = {
+	.name = "loongson3",
+	.flags = CPUFREQ_CONST_LOOPS,
+	.init = loongson3_cpufreq_cpu_smc1_init,
+	.exit = loongson3_cpufreq_cpu_exit,
+	.online = loongson3_cpufreq_cpu_online,
+	.offline = loongson3_cpufreq_cpu_offline,
+	.get = loongson3_cpufreq_smc1_get,
+	.target_index = loongson3_cpufreq_smc1_target,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.set_boost = cpufreq_boost_set_sw,
 	.suspend = cpufreq_generic_suspend,
@@ -335,7 +462,7 @@ static struct cpufreq_driver loongson3_cpufreq_driver = {
 
 static int loongson3_cpufreq_probe(struct platform_device *pdev)
 {
-	int i, ret;
+	int i, ret, version;
 
 	for (i = 0; i < MAX_PACKAGES; i++) {
 		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
@@ -343,18 +470,26 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
-	if (ret <= 0)
+	version = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
+	if (version < 0)
 		return -EPERM;
 
-	ret = do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
-				 FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
-	if (ret < 0)
-		return -EPERM;
+	pr_info("loongson3_cpufreq: firmware version %d\n", version);
+
+	if (version == 0) {
+		loongson3_cpufreq_current_driver = &loongson3_cpufreq_smc0_driver;
+	} else {
+		ret = do_service_request(SMC1_FEATURE_DVFS, 0, SMC1_CMD_SET_FEATURE,
+					 SMC1_FEATURE_DVFS_ENABLE | SMC1_FEATURE_DVFS_BOOST, 0);
+		if (ret < 0)
+			return -EPERM;
+
+		loongson3_cpufreq_current_driver = &loongson3_cpufreq_smc1_driver;
+	}
 
-	loongson3_cpufreq_driver.driver_data = pdev;
+	loongson3_cpufreq_current_driver->driver_data = pdev;
 
-	ret = cpufreq_register_driver(&loongson3_cpufreq_driver);
+	ret = cpufreq_register_driver(loongson3_cpufreq_current_driver);
 	if (ret)
 		return ret;
 
@@ -365,7 +500,7 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 
 static void loongson3_cpufreq_remove(struct platform_device *pdev)
 {
-	cpufreq_unregister_driver(&loongson3_cpufreq_driver);
+	cpufreq_unregister_driver(loongson3_cpufreq_current_driver);
 }
 
 static struct platform_device_id cpufreq_id_table[] = {
-- 
2.49.0



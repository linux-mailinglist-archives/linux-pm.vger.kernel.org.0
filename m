Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07525F89F1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Oct 2022 09:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJIHMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJIHLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 03:11:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE63384F;
        Sun,  9 Oct 2022 00:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRxX0joW1WZKq2gK9+iM7N9I8KUmFw/DlJBdPGkCxG9/lHYHdzIgDphLPJ04BwFsjtDedAbJUTHAfD5dYADIH2Efmmk5IQ3W2iN3zuCwLI/jFiLz2JzjcRUACSS0Wn4S3vRztdWvBVFbN3aFaur9kvini9Bm1p8IcRaxSfBi5FADyo+4SvNfovzscINB4OHJVyqJEn+cNGzZ6VThTHIWId3uL5l9D8KE2ZC+oEiMAVbogptuSeyH/ZdBIuVMUdwB357grjGgdz+R361w5Q6UHlvmLZCcTHfVjEcyU97o009gBTaayH0lWQCHdAh8eJQepXGLuVmoZoDVDmz0QR5hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUe8rLv7eX+N6EQlKUR00aPck5ZXZpuuE4ZMUemk3O4=;
 b=eP0ZG/Ez6DXi3i3wRuE/2CjGOm4LCDq0i63w/j4pF9sQjoXhL7B6yE1BuQE+vHBCX7OKiaO54GqJIWvmR9l4GQmrAw/+BfLluOVtSAgk2pp2MRMiQPMMRibPleF3S2z5S6kYsZOdfAWpiJuUS5/2fqaxOnsQ137i9juM1AZ3Vj27x5o7abKDRxau7RoimNac45PV52AlZY8XHLsTUrzpml6aMFdTVV5rNQJIqTW+GxGiqvuHO+3but26ycpYvAoOzD7/MFzCox5xUJhH6DkiFvcvl4LLCz2wkGlc2EXx9Bdmc3I8Abzz3V9R0uxIGn2lJXUWOEuL8BvWy9JXNh9Dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUe8rLv7eX+N6EQlKUR00aPck5ZXZpuuE4ZMUemk3O4=;
 b=nvfB91/NI2KwClArrO4jdP35cCMCObf+nJz6bxrUzrGDEk39CD2eXsvrxi515ljbV1gOUOQFXiAVwWq8Dz0x5RAp0bDikMEXXp9HqOQGPY63PN6UMO+0c8oHmrIp9gZQvH5ZmiZfO822eHcI1BNxCR3McPzUqPY8Gpr4wm0JAv0=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Sun, 9 Oct
 2022 07:11:32 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::a9) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.13 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:32 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:28 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 7/9] cpufreq: amd_pstate: add AMD Pstate EPP support for the MSR based processors
Date:   Sun, 9 Oct 2022 15:10:31 +0800
Message-ID: <20221009071033.21170-8-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cdc7b3-02bb-47be-4f4e-08daa9c57ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cIJF7Yzi0mwJwWblpWMjVv8sbyf8qUk6gSMzS7GBVZMdsxKiNwtLIe4QLch8Oa4xtbIVHFqv/HKomSDwSIIWxN/5wknU/IcxgeM7O6zN26iR6QTSKxi5iG2DPhD9N8tBjaS/CbeEj3TkVf0IxrhmgyZ7WSJelw5K+LlY4LljBBYNVk1FQZmyg7dH78Szj65whePFpjVLG69J2x6j4EiW0uQaeyHIAcsSPHZzG/HYvmr7LDjIFn6MUrCE9sFbvD9Ts1N7bFMEqjvX4Z8LIZpdbZdzm8dFLbDgNTPmApAXUzVP4LOZzwk2H/JHJwKAYlkpmA3V/pnp6lRSACNkoerLjRfBmcWa0DQTQxhq8O8rMMS/gUh+fkFj2B3Gw0gF1OFEm1ZsGLWioAVwxK5qaIkT31OZxaRcbuwMp+q/+ZUJ0/PjGSppDXtet52Z6AjrY2pyckHOlv0cbtpFT3OLBSxk6ZQipu7/68Q7ZkIdXs63/HypqjS4xIAzgTh2TXi11VkxzlJ/8TL9kSrMNH+qbKGSLF/qEsm0vI/YlHesoqbDh8QYs9vVRj1avBcup9igMuTZTed53o1It5Cvac7a4PzrciPK5PfTXLMPDic6N6UO8yE5e5Uc+vvhdihE4UYNIov2YaDig4dIU1ubpkuk4xqgQcQZH+TPhNZaBQ2k0+bswwPf9RzuBmUhGd2AY+PQkTTUcftmHo9n/2ZHCSHaMFfaUbDlutiufqJ5Hr8WtCG6ZoHhOEoAfSuFr5VEcG2n7wAg61qnT26MVlBr/eR5WL3OYiPVSUCJMYazsaSaOPfIj01Bb7rZI340axYV7p2VdT9VjcLOzEaJCoQtjb7yT9UD7FsCZGWqg5e5GnD9igLIgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(26005)(40480700001)(36756003)(40460700003)(81166007)(36860700001)(82740400003)(86362001)(82310400005)(4326008)(8676002)(356005)(316002)(70586007)(70206006)(2906002)(30864003)(54906003)(5660300002)(8936002)(41300700001)(2616005)(47076005)(426003)(1076003)(186003)(336012)(83380400001)(478600001)(16526019)(7696005)(6666004)(110136005)(36900700001)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:32.5839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cdc7b3-02bb-47be-4f4e-08daa9c57ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EPP driver support for those AMD CPUs which has full MSR feature
enabled, The EPP is used in the DPM controller to drive the frequency
that a core is going to operate during short periods of activity.

EPP values will be utilized for different OS profiles (balanced, performance,
power savings). cppc performance can be controlled by the user space interface
sys attributes for min and max frequency limits, when pstate driver is
working under power save policy.

EPP scale is 0 - 255, 0 is the max performance and 255 is min level.
balance_performance (0x80) can provide best balance performance and watt for
most of system, meanwhile user can choose performance policy on needs.

$ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
default performance balance_performance balance_power power

$ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
balance_performance

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h |   4 +
 drivers/cpufreq/amd-pstate.c     | 798 ++++++++++++++++++++++++++++++-
 2 files changed, 794 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e5ea1c9f747b..53cbdb0c522b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -588,6 +588,10 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+#define AMD_CPPC_EPP_PERFORMANCE		0x00
+#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
+#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_POWERSAVE			0xFF
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4c24fe391a55..98fb4a31791e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,9 +65,11 @@ MODULE_PARM_DESC(shared_mem,
 
 static bool epp_enabled = false;
 module_param(epp_enabled, bool, 0444);
-MODULE_PARM_DESC(epp_enabled, "Enable energy performance preference (EPP) control");
+MODULE_PARM_DESC(epp_enabled,
+		"Enable energy performance preference (EPP) control");
 
-static struct cpufreq_driver amd_pstate_driver;
+static struct cpufreq_driver *default_pstate_driver;
+static struct amd_cpudata **all_cpu_data;
 
 /**
  * struct  amd_aperf_mperf
@@ -79,6 +81,7 @@ struct amd_aperf_mperf {
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
+	u64 time;
 };
 
 /**
@@ -101,7 +104,19 @@ struct amd_aperf_mperf {
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
- *
+ * @epp_powersave: Last saved CPPC energy performance preference
+				when policy switched to performance
+ * @epp_policy: Last saved policy used to set energy-performance preference
+ * @epp_cached: Cached CPPC energy-performance preference value
+ * @policy: Cpufreq policy value
+ * @sched_flags: Store scheduler flags for possible cross CPU update
+ * @update_util_set: CPUFreq utility callback is set
+ * @last_update: Time stamp of the last performance state update
+ * @cppc_boost_min: Last CPPC boosted min performance state
+ * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
+ * @update_util: Cpufreq utility callback information
+ * @sample: the stored performance sample
+
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
  */
@@ -126,8 +141,197 @@ struct amd_cpudata {
 
 	u64 	freq;
 	bool	boost_supported;
+	u64	cppc_hw_conf_cached;
+
+	/* EPP feature related attributes*/
+	s16	epp_powersave;
+	s16	epp_policy;
+	s16	epp_cached;
+	u32	policy;
+	u32	sched_flags;
+	bool	update_util_set;
+	u64	last_update;
+	u64	last_io_update;
+	u32	cppc_boost_min;
+	u64	cppc_cap1_cached;
+	struct	update_util_data update_util;
+	struct	amd_aperf_mperf sample;
+};
+
+/**
+ * struct amd_pstate_params - global parameters for the performance control
+ * @ cppc_boost_disabled wheher the core performance boost disabled
+ */
+struct amd_pstate_params {
+	bool cppc_boost_disabled;
+};
+
+/*
+ * AMD Energy Preference Performance (EPP)
+ * The EPP is used in the CCLK DPM controller to drive
+ * the frequency that a core is going to operate during
+ * short periods of activity. EPP values will be utilized for
+ * different OS profiles (balanced, performance, power savings)
+ * display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ */
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+
+static const char * const energy_perf_strings[] = {
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
+	NULL
+};
+
+static unsigned int epp_values[] = {
+	[EPP_INDEX_DEFAULT] = 0,
+	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
+	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
+	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
+	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
 
+static struct amd_pstate_params global_params;
+
+static DEFINE_MUTEX(amd_pstate_limits_lock);
+static DEFINE_MUTEX(amd_pstate_driver_lock);
+static DEFINE_SPINLOCK(amd_pstate_cpu_lock);
+
+static bool cppc_boost __read_mostly;
+struct kobject *amd_pstate_kobj;
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+{
+	s16 epp;
+	struct cppc_perf_caps perf_caps;
+	int ret;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		if (!cppc_req_cached) {
+			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+					    &cppc_req_cached);
+			if (epp)
+				return epp;
+		}
+		epp = (cppc_req_cached >> 24) & 0xFF;
+	} else {
+		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
+		if (ret < 0) {
+			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+			return -EIO;
+		}
+		epp = (s16) perf_caps.energy_perf;
+	}
+
+	return epp;
+}
+#endif
+
+static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata, int *raw_epp)
+{
+	s16 epp;
+	int index = -EINVAL;
+
+	*raw_epp = 0;
+	epp = amd_pstate_get_epp(cpudata, 0);
+	if (epp < 0)
+		return epp;
+
+	switch (epp) {
+	case AMD_CPPC_EPP_PERFORMANCE:
+		index = EPP_INDEX_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
+		index = EPP_INDEX_BALANCE_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
+		index = EPP_INDEX_BALANCE_POWERSAVE;
+		break;
+	case AMD_CPPC_EPP_POWERSAVE:
+		index = EPP_INDEX_POWERSAVE;
+		break;
+	default:
+		*raw_epp = epp;
+		index = 0;
+	}
+
+	return index;
+}
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+{
+	int ret;
+	struct cppc_perf_ctrls perf_ctrls;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 value = READ_ONCE(cpudata->cppc_req_cached);
+
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+		if (!ret)
+			cpudata->epp_cached = epp;
+	} else {
+		perf_ctrls.energy_perf = epp;
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls);
+		if (ret) {
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+		cpudata->epp_cached = epp;
+	}
+
+	return ret;
+}
+
+static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
+					      int pref_index, bool use_raw,
+					      u32 raw_epp)
+{
+	int epp = -EINVAL;
+	int ret;
+
+	if (!pref_index) {
+		pr_debug("EPP pref_index is invalid\n");
+		return -EINVAL;
+	}
+
+	if (use_raw)
+		epp = raw_epp;
+	else if (epp == -EINVAL)
+		epp = epp_values[pref_index];
+
+	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		pr_debug("EPP cannot be set under performance policy\n");
+		return -EBUSY;
+	}
+
+	ret = amd_pstate_set_epp(cpudata, epp);
+
+	return ret;
+}
+#endif
+
 static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
@@ -496,7 +700,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
 		return;
 
 	cpudata->boost_supported = true;
-	amd_pstate_driver.boost_enabled = true;
+	default_pstate_driver->boost_enabled = true;
 }
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
@@ -660,10 +864,108 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sprintf(&buf[0], "%u\n", perf);
 }
 
+static ssize_t show_energy_performance_available_preferences(
+				struct cpufreq_policy *policy, char *buf)
+{
+	int i = 0;
+	int ret = 0;
+
+	while (energy_perf_strings[i] != NULL)
+		ret += sprintf(&buf[ret], "%s ", energy_perf_strings[i++]);
+
+	ret += sprintf(&buf[ret], "\n");
+
+	return ret;
+}
+
+static ssize_t store_energy_performance_preference(
+		struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	char str_preference[21];
+	bool raw = false;
+	ssize_t ret;
+	u32 epp = 0;
+
+	ret = sscanf(buf, "%20s", str_preference);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = match_string(energy_perf_strings, -1, str_preference);
+	if (ret < 0) {
+		ret = kstrtouint(buf, 10, &epp);
+		if (ret)
+			return ret;
+
+		if ((epp > 255) || (epp < 0))
+			return -EINVAL;
+
+		raw = true;
+	}
+
+	mutex_lock(&amd_pstate_limits_lock);
+	ret = amd_pstate_set_energy_pref_index(cpudata, ret, raw, epp);
+	mutex_unlock(&amd_pstate_limits_lock);
+
+	return ret ?: count;
+}
+
+static ssize_t show_energy_performance_preference(
+				struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int preference, raw_epp;
+
+	preference = amd_pstate_get_energy_pref_index(cpudata, &raw_epp);
+	if (preference < 0)
+		return preference;
+
+	if (raw_epp)
+		return  sprintf(buf, "%d\n", raw_epp);
+	else
+		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
+}
+
+static void amd_pstate_update_policies(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
+}
+
+static ssize_t show_pstate_dynamic_boost(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", cppc_boost);
+}
+
+static ssize_t store_pstate_dynamic_boost(struct kobject *a,
+				       struct kobj_attribute *b,
+				       const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	cppc_boost = !!input;
+	amd_pstate_update_policies();
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_rw(energy_performance_preference);
+cpufreq_freq_attr_ro(energy_performance_available_preferences);
+define_one_global_rw(pstate_dynamic_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -672,6 +974,424 @@ static struct freq_attr *amd_pstate_attr[] = {
 	NULL,
 };
 
+static struct freq_attr *amd_pstate_epp_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
+	&energy_performance_preference,
+	&energy_performance_available_preferences,
+	NULL,
+};
+
+static struct attribute *pstate_global_attributes[] = {
+	&pstate_dynamic_boost.attr,
+	NULL
+};
+
+static const struct attribute_group amd_pstate_global_attr_group = {
+	.attrs = pstate_global_attributes,
+};
+
+static inline void update_boost_state(void)
+{
+	u64 misc_en;
+	struct amd_cpudata *cpudata;
+
+	cpudata = all_cpu_data[0];
+	rdmsrl(MSR_AMD_CPPC_HW_CTL, misc_en);
+	global_params.cppc_boost_disabled = misc_en & AMD_CPPC_PRECISION_BOOST_ENABLED;
+}
+
+static int amd_pstate_init_cpu(unsigned int cpunum)
+{
+	struct amd_cpudata *cpudata;
+
+	cpudata = all_cpu_data[cpunum];
+	if (!cpudata) {
+		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
+		if (!cpudata)
+			return -ENOMEM;
+		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
+
+		cpudata->cpu = cpunum;
+	}
+	cpudata->epp_powersave = -EINVAL;
+	cpudata->epp_policy = 0;
+	pr_debug("controlling: cpu %d\n", cpunum);
+	return 0;
+}
+
+static int __amd_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	struct amd_cpudata *cpudata;
+	struct device *dev;
+	int rc;
+	u64 value;
+
+	rc = amd_pstate_init_cpu(policy->cpu);
+	if (rc)
+		return rc;
+
+	cpudata = all_cpu_data[policy->cpu];
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		goto free_cpudata1;
+
+	rc = amd_pstate_init_perf(cpudata);
+	if (rc)
+		goto free_cpudata1;
+
+	min_freq = amd_get_min_freq(cpudata);
+	max_freq = amd_get_max_freq(cpudata);
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
+				min_freq, max_freq);
+		ret = -EINVAL;
+		goto free_cpudata1;
+	}
+
+	policy->min = min_freq;
+	policy->max = max_freq;
+
+	policy->cpuinfo.min_freq = min_freq;
+	policy->cpuinfo.max_freq = max_freq;
+	/* It will be updated by governor */
+	policy->cur = policy->cpuinfo.min_freq;
+
+	/* Initial processor data capability frequencies */
+	cpudata->max_freq = max_freq;
+	cpudata->min_freq = min_freq;
+	cpudata->nominal_freq = nominal_freq;
+	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
+
+	policy->driver_data = cpudata;
+
+	update_boost_state();
+	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+		policy->fast_switch_possible = true;
+
+	if (!shared_mem && boot_cpu_has(X86_FEATURE_CPPC)) {
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
+	}
+	amd_pstate_boost_init(cpudata);
+
+	return 0;
+
+free_cpudata1:
+	kfree(cpudata);
+	return ret;
+}
+
+static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	ret = __amd_pstate_cpu_init(policy);
+	if (ret)
+		return ret;
+	/*
+	 * Set the policy to powersave to provide a valid fallback value in case
+	 * the default cpufreq governor is neither powersave nor performance.
+	 */
+	policy->policy = CPUFREQ_POLICY_POWERSAVE;
+
+	return 0;
+}
+
+static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
+{
+	pr_debug("amd-pstate: CPU %d exiting\n", policy->cpu);
+	policy->fast_switch_possible = false;
+	return 0;
+}
+
+static void amd_pstate_update_max_freq(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+
+	if (!policy)
+		return;
+
+	refresh_frequency_limits(policy);
+	cpufreq_cpu_release(policy);
+}
+
+static void amd_pstate_epp_update_limits(unsigned int cpu)
+{
+	mutex_lock(&amd_pstate_driver_lock);
+	update_boost_state();
+	if (global_params.cppc_boost_disabled) {
+		for_each_possible_cpu(cpu)
+			amd_pstate_update_max_freq(cpu);
+	} else {
+		cpufreq_update_policy(cpu);
+	}
+	mutex_unlock(&amd_pstate_driver_lock);
+}
+
+static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
+
+static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata)
+{
+	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
+	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
+	u32 max_limit = (hwp_req & 0xff);
+	u32 min_limit = (hwp_req & 0xff00) >> 8;
+	u32 boost_level1;
+
+	/* If max and min are equal or already at max, nothing to boost */
+	if (max_limit == min_limit)
+		return;
+
+	/* Set boost max and min to initial value */
+	if (!cpudata->cppc_boost_min)
+		cpudata->cppc_boost_min = min_limit;
+
+	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) + min_limit) >> 1);
+
+	if (cpudata->cppc_boost_min < boost_level1)
+		cpudata->cppc_boost_min = boost_level1;
+	else if (cpudata->cppc_boost_min < AMD_CPPC_NOMINAL_PERF(hwp_cap))
+		cpudata->cppc_boost_min = AMD_CPPC_NOMINAL_PERF(hwp_cap);
+	else if (cpudata->cppc_boost_min == AMD_CPPC_NOMINAL_PERF(hwp_cap))
+		cpudata->cppc_boost_min = max_limit;
+	else
+		return;
+
+	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
+	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
+	wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
+	cpudata->last_update = cpudata->sample.time;
+}
+
+static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
+{
+	bool expired;
+
+	if (cpudata->cppc_boost_min) {
+		expired = time_after64(cpudata->sample.time, cpudata->last_update +
+					cppc_boost_hold_time_ns);
+
+		if (expired) {
+			wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+						cpudata->cppc_req_cached);
+			cpudata->cppc_boost_min = 0;
+		}
+	}
+
+	cpudata->last_update = cpudata->sample.time;
+}
+
+static inline void amd_pstate_boost_update_util(struct amd_cpudata *cpudata,
+						      u64 time)
+{
+	cpudata->sample.time = time;
+	if (smp_processor_id() != cpudata->cpu)
+		return;
+
+	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
+		bool do_io = false;
+
+		cpudata->sched_flags = 0;
+		/*
+		 * Set iowait_boost flag and update time. Since IO WAIT flag
+		 * is set all the time, we can't just conclude that there is
+		 * some IO bound activity is scheduled on this CPU with just
+		 * one occurrence. If we receive at least two in two
+		 * consecutive ticks, then we treat as boost candidate.
+		 * This is leveraged from Intel Pstate driver.
+		 */
+		if (time_before64(time, cpudata->last_io_update + 2 * TICK_NSEC))
+			do_io = true;
+
+		cpudata->last_io_update = time;
+
+		if (do_io)
+			amd_pstate_boost_up(cpudata);
+
+	} else {
+		amd_pstate_boost_down(cpudata);
+	}
+}
+
+static inline void amd_pstate_cppc_update_hook(struct update_util_data *data,
+						u64 time, unsigned int flags)
+{
+	struct amd_cpudata *cpudata = container_of(data,
+				struct amd_cpudata, update_util);
+
+	cpudata->sched_flags |= flags;
+
+	if (smp_processor_id() == cpudata->cpu)
+		amd_pstate_boost_update_util(cpudata, time);
+}
+
+static void amd_pstate_clear_update_util_hook(unsigned int cpu)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu];
+
+	if (!cpudata->update_util_set)
+		return;
+
+	cpufreq_remove_update_util_hook(cpu);
+	cpudata->update_util_set = false;
+	synchronize_rcu();
+}
+
+static void amd_pstate_set_update_util_hook(unsigned int cpu_num)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
+
+	if (!cppc_boost) {
+		if (cpudata->update_util_set)
+			amd_pstate_clear_update_util_hook(cpudata->cpu);
+		return;
+	}
+
+	if (cpudata->update_util_set)
+		return;
+
+	cpudata->sample.time = 0;
+	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
+						amd_pstate_cppc_update_hook);
+	cpudata->update_util_set = true;
+}
+
+static void amd_pstate_epp_init(unsigned int cpu)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu];
+	u32 max_perf, min_perf;
+	u64 value;
+	s16 epp;
+	int ret;
+
+	max_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min_perf = max_perf;
+
+	/* Initial min/max values for CPPC Performance Controls Register */
+	value &= ~AMD_CPPC_MIN_PERF(~0L);
+	value |= AMD_CPPC_MIN_PERF(min_perf);
+
+	value &= ~AMD_CPPC_MAX_PERF(~0L);
+	value |= AMD_CPPC_MAX_PERF(max_perf);
+
+	/* CPPC EPP feature require to set zero to the desire perf bit */
+	value &= ~AMD_CPPC_DES_PERF(~0L);
+	value |= AMD_CPPC_DES_PERF(0);
+
+	if (cpudata->epp_policy == cpudata->policy)
+		goto skip_epp;
+
+	cpudata->epp_policy = cpudata->policy;
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		epp = amd_pstate_get_epp(cpudata, value);
+		cpudata->epp_powersave = epp;
+		if (epp < 0)
+			goto skip_epp;
+		/* force the epp value to be zero for performance policy */
+		epp = 0;
+	} else {
+		if (cpudata->epp_powersave < 0)
+			goto skip_epp;
+		/* Get BIOS pre-defined epp value */
+		epp = amd_pstate_get_epp(cpudata, value);
+		if (epp)
+			goto skip_epp;
+		epp = cpudata->epp_powersave;
+	}
+	/* Set initial EPP value */
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+	}
+
+skip_epp:
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	if (!ret)
+		cpudata->epp_cached = epp;
+}
+
+static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata)
+{
+	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
+	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
+	u32 max_limit = (hwp_cap >> 24) & 0xff;
+
+	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
+	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
+	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
+}
+
+static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata;
+
+	if (!policy->cpuinfo.max_freq)
+		return -ENODEV;
+
+	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
+				policy->cpuinfo.max_freq, policy->max);
+
+	cpudata = all_cpu_data[policy->cpu];
+	cpudata->policy = policy->policy;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+			amd_pstate_clear_update_util_hook(policy->cpu);
+			amd_pstate_set_max_limits(cpudata);
+		} else {
+			amd_pstate_set_update_util_hook(policy->cpu);
+		}
+
+		if (boot_cpu_has(X86_FEATURE_CPPC))
+			amd_pstate_epp_init(policy->cpu);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+	}
+
+	return 0;
+}
+
+static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
+					   struct cpufreq_policy_data *policy)
+{
+	update_boost_state();
+	cpufreq_verify_within_cpu_limits(policy);
+}
+
+static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
+{
+	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
+	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
+	return 0;
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -685,8 +1405,20 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.attr		= amd_pstate_attr,
 };
 
+static struct cpufreq_driver amd_pstate_epp_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.verify		= amd_pstate_epp_verify_policy,
+	.setpolicy	= amd_pstate_epp_set_policy,
+	.init		= amd_pstate_epp_cpu_init,
+	.exit		= amd_pstate_epp_cpu_exit,
+	.update_limits	= amd_pstate_epp_update_limits,
+	.name		= "amd_pstate_epp",
+	.attr		= amd_pstate_epp_attr,
+};
+
 static int __init amd_pstate_init(void)
 {
+	static struct amd_cpudata **cpudata;
 	int ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -701,10 +1433,24 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
+	if (!cpudata)
+		return -ENOMEM;
+	WRITE_ONCE(all_cpu_data, cpudata);
+
+	if (epp_enabled) {
+		pr_info("AMD CPPC loading with amd_pstate_epp driver instance.\n");
+		default_pstate_driver = &amd_pstate_epp_driver;
+	} else {
+		pr_info("AMD CPPC loading with amd_pstate driver instance.\n");
+		default_pstate_driver = &amd_pstate_driver;
+	}
+
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		if (!epp_enabled)
+			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
 	} else if (shared_mem) {
 		static_call_update(amd_pstate_enable, cppc_enable);
 		static_call_update(amd_pstate_init_perf, cppc_init_perf);
@@ -721,19 +1467,55 @@ static int __init amd_pstate_init(void)
 		return ret;
 	}
 
-	ret = cpufreq_register_driver(&amd_pstate_driver);
+	ret = cpufreq_register_driver(default_pstate_driver);
 	if (ret)
-		pr_err("failed to register amd_pstate_driver with return %d\n",
+		pr_err("failed to register amd pstate driver with return %d\n",
 		       ret);
 
+	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
+	if (!amd_pstate_kobj)
+		pr_err("amd-pstate: Global sysfs registration failed.\n");
+
+	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
+	if (ret) {
+		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
+		       ret);
+	}
+
 	return ret;
 }
 
+static inline void amd_pstate_kobj_cleanup(struct kobject *kobj)
+{
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+
 static void __exit amd_pstate_exit(void)
 {
-	cpufreq_unregister_driver(&amd_pstate_driver);
+	unsigned int cpu;
+
+	cpufreq_unregister_driver(default_pstate_driver);
 
 	amd_pstate_enable(false);
+
+	sysfs_remove_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
+	amd_pstate_kobj_cleanup(amd_pstate_kobj);
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (all_cpu_data[cpu]) {
+			if (default_pstate_driver == &amd_pstate_epp_driver)
+				amd_pstate_clear_update_util_hook(cpu);
+
+			spin_lock(&amd_pstate_cpu_lock);
+			kfree(all_cpu_data[cpu]);
+			WRITE_ONCE(all_cpu_data[cpu], NULL);
+			spin_unlock(&amd_pstate_cpu_lock);
+		}
+	}
+	cpus_read_unlock();
+
 }
 
 module_init(amd_pstate_init);
-- 
2.34.1


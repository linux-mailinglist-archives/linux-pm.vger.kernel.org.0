Return-Path: <linux-pm+bounces-43774-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OsRLMOmqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43774-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5379821E68D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C263136892
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FC34F47C;
	Fri,  6 Mar 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SNHReig0"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46E34D4EA;
	Fri,  6 Mar 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791118; cv=fail; b=LWqYEKGp/JbTg8x78eKtp57b8vs5QA7A2ORaf8N955Ba2PcO156bmic0VBOO755WUftXTNmihuyRUnPjnCtj2XxiF02Ikfw64hcUFoAJ9owqbDJIvOZhgakfhwdOA8jd+XG57oewYpBa6aBunlbQqk1B1xb938aF7jNgYIgP84A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791118; c=relaxed/simple;
	bh=/RCr6D/qJU+hSLD0TYfli//axvBTKquVQb+wfedg3bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ser/i8QGMMfFwqtSg4bRpfjxLxO/NYVdpvjnzo/0OfTk5o89zMFWCZgZRvVXfCFvRaC0tpd4X93ThR/Vab1LLmTW9nkR3Nk+Z61CwJBKbm3/6QWZIDVAwhafgCLyulKKRDs7oj7xERGSCV4/PNM5iuhQssS8u53tUoxgzAyOizg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SNHReig0; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG/QQbe8aSpKqNFRyCV1yt4sZmXby3A+BnH0eq1/Hc23Z+rLOjK9ZK1VNC+8Uw+fgdOt6sXb71GYubCNfJPn+6VK9GihS7vzEBKbOyxG4RH9ZWPWqkKsrUJ0jTZYPCPuU70buQQ0y70le4gXOkuQ/tGs78cKr0r31wbNCyXhdoOYm9Ej1pHsqxhVojoNq6Iv95IS3Jiem0m1RveLjKqpzks3XwmioItYzZtvtKtQIqCCWT49AroLZqTaSfA4Rhv+F8INqX+cnAfs/PGNBBV04iGr9pivaXciNdxyBhj4XRHnq818FLOkaHnR3GSzekazIjxFWc6u5UnfpyDFUQF0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ6GIC9EaHMRKIeft9r4Va0MveDQnflH3XMGGbFpNFo=;
 b=I80ys3TnqDWBMxzl9CTo0yYjw9Q+F+qlTbWNUJRDk1FmHc4mGSdMno9UizpJFw8fEUqBI19wrts591+NAMlwU2XmTx+5WOX/Fsg8lSb4HhVD4t5p+7UiexaOpCcAU5oU4NOAmQEBBqHAJve23PVpAK0ix7fvTANZYglLQ9bJCnpOpFpJQiDPh3xUS7XjdWBfw6HUz1U7ENcMWFaogc7pvFbOB7Eizk8Orj5ZHKcyy9OaviFJRHRZhyV6DmjY1689XlKmV+fkRxheGs7q5mBvY83/HrLPV6Rskfo8MGIprfOLvwtWWB/L2CO3WMmUJ/yLFov+vDx4jGz6IK/t7D+wXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ6GIC9EaHMRKIeft9r4Va0MveDQnflH3XMGGbFpNFo=;
 b=SNHReig0AJ0rpf/I6gu67g7gDwh7drXrtk8reyE8EXTkj/nZKxpl2P0x1m1s8BYyPPseleXhs+KS25aOMZs4piUx5oeSKP43DK+mWlACSFGFlxL5oYqWyE+jPq6RYGfJscR/IcvLd5wEHsYn13ngO+V6NLjPkl5GAqebLhJwq2U=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:58:32 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::91) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 09:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:31 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:29 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 5/9] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Date: Fri, 6 Mar 2026 15:27:49 +0530
Message-ID: <20260306095753.17155-6-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306095753.17155-1-gautham.shenoy@amd.com>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b09c043-c218-4c68-ae3e-08de7b66ec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	URjGGezuC3ghq5RTvOGEoLFpyrpfXMzpM+L9xqkz25Qh/BKUH+Wm6gnGoNyUeAyTn13ow6/SxJGtpNo8r8b5L91UBMFkQjcZemYpHDGPQarGe8rxD3IJig5bEdn37iv2HcmU5KrPFMNZwvuTSl3Iijq/5rnSPmv7t+A4G62V138+5zaW6TsEcU853rZtLmf+GLKb1WFgF8EIQXKsguoi9IDqpLq18isMb2zmk86ROXQXiz/1UqwIGeOc+oFwyothjMCa09PoN6HzULUYMQZ0tTckCvKEaQhBn2WUvY6AWHttidkk8wnXHZSe76WHBgT0tVnYdyF6RpKdFnjvtD6PqT6DxP+Tpm/hl85MJxDptyUpZ7iVch38D0I0hERMkW5F4wKSNICfWGrWpRRHgeFS0zpSIPhQ3U6AbDBsXYId50zvOlcbwe6fsqNtAaRNbJS7IPG/UIBp8HE86YduoiecvGDxarlQvI8GAVPhGNCdpB6Fs9srjA8Vg7dgoVvxuH83pT/hXC5zm276/bp6mi+ZtFrVeKqGiiVAWecbOz3s5jNNi0l5Pu6VvnSUbnXc33HIZDVCm2nQEagUIz+q/5rEK3T1IpHx14riOR1SttR9UG+bnv12MBzIMYKmqgTdeyG4zPzx4HOk6x7YZjGQcWWeGl7cGv85owhYKRZfcRCycCQ+vIjlMof74twgjko3nKPlstfz+BBGlILNpBfvGZrNHSCp4EmkRo1jmptE5MeoPNcGAAn0YxSBHYCvlWQV0eIwvYryG4QWFlIVrsYWBicn4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b4w4W0bIVzujojeVZjsdVXVfmt+LUmGPzCwZdRtYVGiYlqOMhchkenokXkQFDewJXLP35FTtCW9lqtLl/7QjuesdbMzO/kcNRFuanj/H/PsOIqOcpb9nH3EFWPnQDH/UVFYtOvGZRhzbbvZ5FZaxUME7+WN+I3zP+MTqW5XFd+eSJiNT4PQBfPq7NGOtaYzw464aZ7EsbYAPs1HOC5dojoPUY7+Ial0zQZGpwkZCdHbX2uGrqd8gkY9yYfs+A3oSlsjING3z+l/y1THnNnkzGulWnZ1Ft5II4gwDruMAtTIYkd17um7W4IIX3Txl0AsnDk1IeXa2+zePGUX0s+FoJlV2SvFdcmVmhvgVmny20P/xJO/gQ2i2iQTTC9pzmxNd7ezVgNJLqWYyQc8EMmzBrfy6ojI4SCZfJMfArnJBqnbDn42kPifiPt0Z5tpldVUK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:31.5205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09c043-c218-4c68-ae3e-08de7b66ec5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Rspamd-Queue-Id: 5379821E68D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43774-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Some future AMD processors have feature named "CPPC Performance
Priority" which lets userspace specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints. The presence of this feature is
indicated by bit 16 of the EDX register for CPUID leaf
0x80000007. More details can be found in AMD Publication titled "AMD64
Collaborative Processor Performance Control (CPPC) Performance
Priority" Revision 1.10.

The number of distinct floor performance levels supported on the
platform will be advertised through the bits 32:39 of the
MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR MSR_AMD_CPPC_REQ2
(0xc00102b5) will be used to specify the desired floor performance
level for that CPU.

Add support for the aforementioned MSR_AMD_CPPC_REQ2, and macros for
parsing and updating the relevant bits from MSR_AMD_CPPC_CAP1 and
MSR_AMD_CPPC_REQ2.

On boot if the default value of the MSR_AMD_CPPC_REQ2[7:0] (Floor
Perf) is lower than CPPC.lowest_perf, and thus invalid, initialize it
to MSR_AMD_CPPC_CAP1.nominal_perf which is a sane default value.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB

 arch/x86/include/asm/msr-index.h |  5 ++
 drivers/cpufreq/amd-pstate.c     | 81 ++++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.h     |  5 ++
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index da5275d8eda63..60547dcf47d0f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -762,12 +762,14 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_REQ2		0xc00102b5
 
 /* Masks for use with MSR_AMD_CPPC_CAP1 */
 #define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
 #define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
 #define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
 #define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
+#define AMD_CPPC_FLOOR_PERF_CNT_MASK	GENMASK(39, 32)
 
 /* Masks for use with MSR_AMD_CPPC_REQ */
 #define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
@@ -775,6 +777,9 @@
 #define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
 #define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
 
+/* Masks for use with MSR_AMD_CPPC_REQ2 */
+#define AMD_CPPC_FLOOR_PERF_MASK	GENMASK(7, 0)
+
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fb5d7bb320c15..fdc1c102a873c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -329,6 +329,74 @@ static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
 	return static_call(amd_pstate_set_epp)(policy, epp);
 }
 
+static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 value, prev;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return 0;
+
+	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
+	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
+
+	if (value == prev)
+		return 0;
+
+	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
+	if (ret) {
+		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
+		return ret;
+	}
+
+	WRITE_ONCE(cpudata->cppc_req2_cached, value);
+
+	return ret;
+}
+
+static int amd_pstate_cache_cppc_req2(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 value;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return 0;
+
+	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
+	if (ret) {
+		pr_err("failed to read CPPC REQ2 value. Error (%d)\n", ret);
+		return ret;
+	}
+
+	WRITE_ONCE(cpudata->cppc_req2_cached, value);
+	return 0;
+}
+
+static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 floor_perf;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return 0;
+
+	ret = amd_pstate_cache_cppc_req2(policy);
+	if (ret)
+		return ret;
+
+	floor_perf = FIELD_GET(AMD_CPPC_FLOOR_PERF_MASK,
+			       cpudata->cppc_req2_cached);
+
+	/* Don't overwrite a sane value initialized by the platform firmware */
+	if (floor_perf > cpudata->perf.lowest_perf)
+		return 0;
+
+	return amd_pstate_set_floor_perf(policy, cpudata->perf.nominal_perf);
+}
+
 static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -426,6 +494,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
+	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
 
 	return 0;
 }
@@ -1036,6 +1105,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
+	ret = amd_pstate_init_floor_perf(policy);
+	if (ret) {
+		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
 	if (ret < 0) {
@@ -1597,6 +1672,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_floor_perf(policy);
+	if (ret) {
+		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
 	current_pstate_driver->adjust_perf = NULL;
 
 	return 0;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cb45fdca27a6c..0c587ca200199 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -62,9 +62,12 @@ struct amd_aperf_mperf {
  * @cpu: CPU number
  * @req: constraint request to apply
  * @cppc_req_cached: cached performance request hints
+ * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
  * @perf: cached performance-related data
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @floor_perf_cnt: Cached value of the number of distinct floor
+ *                  performance levels supported
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
@@ -87,10 +90,12 @@ struct amd_cpudata {
 
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
+	u64	cppc_req2_cached;
 
 	union perf_cached perf;
 
 	u8	prefcore_ranking;
+	u8	floor_perf_cnt;
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
-- 
2.34.1



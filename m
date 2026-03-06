Return-Path: <linux-pm+bounces-43775-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEq+Cv6lqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43775-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:01:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB121E5B2
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05746309554D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A834FF4D;
	Fri,  6 Mar 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtIWgcFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4392DC78C;
	Fri,  6 Mar 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791121; cv=fail; b=AwrEWWm/iVoHyX1imdcegT5v/Fy9QUk8JNetTxylgsh9sfHhktJ/ZwVIh89PTTfh0guGHCa1hJ/gBCv9c8e1FLjtH+mNgSq2mmUZxs6rlWSgmUs1M3VENa6Lpsog5eYzeM5LfbPkXyZjaxNS9i6+VacJ5ioq2UhrHUnYBqZDANE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791121; c=relaxed/simple;
	bh=Jcsmy+KqDldxmxiSGsNmjQWCETXGsmfBlrwrAptvVao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPJNkZeIrkfD8RPNgU4t9Pij8dOKmrKquUeXyKY8RsW0v67xertxBF1xAZ7HILMFxmmS4f4w3zUqIvQzI1+0E6O5Fjji1V71tfcgdmJwjo0yo+g700zNC3MWkyVZy019LGUeG2zX64qt/+2DIHMIeGXhVQEZvM/7MM89Sk6tiTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtIWgcFA; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHHhFjrhIauG8XPRqkV42YMzEMIT8Qw7seoC6371Ief8iY7aYD1SN6sg+LH6f69nT91LUtbu13hvoxsgB3DKolQr6132P+WmBLxafuSQicysX5c3SV8aIpFV7VIytVIkPFNaRk5HcDp/PjRite9/cgOEoHO7kF8CSzoH2Zb/NG42/3m7Bl0M1l6FZpqoAbyR/FpTv4aWxbB72sGxdOx8qyK/ZwdawI80bNR5X9QYbIYTADLk3d/B72sjnW7hgK4SqCXMzXn9s+0NHFq1hRQuleUm0l8LXMdQmi/Yp/NC3VaUDvWalTUjm3bTno2zvq2K8mvDc0GWPSS+aUg2SynwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su9LUWd/BYaVHPaH42WHJbokvHBQojXP2L6+Am6kzNY=;
 b=e6a+zxag7tFpvDjQ/l/tWzvEA+pvSpOmfULyzOPxeXwfCL48EKFSMKjXlg40Kzmr0U/lBTJJyBPKGmWG6uLndvXU1DIheH3C1HXEdem5dV+SmUPwI0WDh/qGFUtIuIazfMqBE0I4eRFmQIxdjV7HQ4EFvlS0Ts+VYb7SJloghpG9rMd1Gia545U0abojbo05C4cZb9rKCz5OahzphwUXg7bSRZsYbw32MfEt3opeaVPyl+SzF4BLQSQcWIfDbJLjEXYNg725GZ13tz9wLc/BwEeYSdXkyRehsyj2ibAGWVbBt7bQ0qA/XDlTzNsLJtFSbQPeotWEZkuE0SgcfOyqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su9LUWd/BYaVHPaH42WHJbokvHBQojXP2L6+Am6kzNY=;
 b=vtIWgcFA4CR9S7KFUW60gImVuQC/LSSjFWXJWf+KBqsZNrI2QLjzhTM1MbwO59LpeKvZyMXnjlDCi6OSGR/5qpw/YD/EZP9rTOW2us8lUpf4KwKfgQYwK9GA7QtWnse7y8bm6aJ6D/pqfpfLdEK+4iBSeWUfZJ14Ul/tUkqGiks=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Fri, 6 Mar 2026 09:58:33 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::66) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 6 Mar 2026 09:58:33 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:31 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 6/9] amd-pstate: Add sysfs support for floor_freq and floor_count
Date: Fri, 6 Mar 2026 15:27:50 +0530
Message-ID: <20260306095753.17155-7-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1f4b25-ea95-4154-9e7c-08de7b66edb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	nQ/gpO0LETwLqlG8XBiq42b0Tl+j2/XZsSWxqRtyhiEXvFrmB0iZVS6T/ux7Zi8+NfvEuHMkGG3ewOEaox02BHx2yadv8cwB4aU5W2+IrHnmRLr+/6AWwI145/QXQ5mtWj9oHyW8ubzyY5MoKYiczTFGrrZB2MCyOWbM6jtmyg7BDMiIvAgwvkCvnFLd85hsLqNv28pV5EmNSBxAYGQe0RLFtCtBTic/bXpJJ25lEtVJXzQiMkEOjrOPbX4njfC8vbzZz0sj5Ny65gPHEBkDiRwZMc6Hz6PfTdZxdPzUYXV/iOx0RtmFJSoHNLKQfPXWHTrMIMMeu12oXzl8H0VhAnNK1M9NEg2mMK/1x3Gss+Gsf0rRNGpcuVzJMKr7KdwE8r/cS0zEDsUudjx4jO0pglIhXtR5lohXsJX+IN8EzvnvnEJo+9CIpeF0dsW2KzH4o6s0q+8EZi+pAPbtN7izOPyA+xhNcOXYs/w8lUqcIWNo6G0ibzpPl0/Nl0tA6NsyL/Fspgrfwm0ACLVNvyQYIRGa7eIXOTbE69ckzXvu9opbkatJz9PZPE1ax+JwuIjjgaj4zi6NijOJRJtdRDWB2g5BpZQu0z9mrxtezG7Fr2FvoiRDgm285L+asRnZc96MYRi7P0avSxhv0O8loKLfIYbMSoddFc6UFvGq7kgYHZx3xUysDMX68mAoFTzlZAM0bKiFnXW+524Yug3NL1FK/s3pH++OljhPkBrxl1VHKlSRYhsuUAwqrpr5RSNbPaDlOP1e3dWJU6RptPXchhpsbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tDEoUsP+AboVvxEe7ec8PFVmK6U94GocRgo0tZQrJBbBwpYzbntEMQoXaM1liWHr5eC5DT//nqRhEg3amUa1DpUteU0QNVQABMrCsYBU+Sa4EVXMRUdF+F3hWRN2xyC4+lLZXG2j6Bds+uRL7T2aG9VQERrwhPpjnSb5CBDONPZ9Dxgbv3aq6ZTPqq9NXeX2te33rRLplxoqJtLynQGBAzBceZ7lFQcDdAHyQAi8bSNVuvOSkYOGtkmjDtblPiHG018k3CGbK5obvrGfoajmfC+HYw04o8WA/NtXopKDQWQe8aoULU7Kj0r1M4IC2Aqo/xyHUuU/QbajHE6q3b0pvsHWMduFZ3DtarIjyqJUX1X5Vi1FEMh+CfaLp5fMN1XlAGP8UGRnHE0wTbD40XoK1oI5e17qMixb8azkdQg6T4aomcF3cihqu6zF2b7+rofK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:33.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f4b25-ea95-4154-9e7c-08de7b66edb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-Rspamd-Queue-Id: 8EAB121E5B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43775-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

When Floor Performance feature is supported by the platform, expose
two sysfs files:

   * amd_pstate_floor_freq to allow userspace to request the floor
     frequency for each CPU.

   * amd_pstate_floor_count which advertises the number of distinct
     levels of floor frequencies supported on this platform.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fdc1c102a873c..a0bc80a7d3f15 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1295,6 +1295,48 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
+					   const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	unsigned int freq;
+	u8 floor_perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq);
+	if (ret)
+		return ret;
+
+	floor_perf = freq_to_perf(perf, cpudata->nominal_freq, freq);
+	ret = amd_pstate_set_floor_perf(policy, floor_perf);
+
+	return ret ?: count;
+}
+
+static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u64 cppc_req2 = READ_ONCE(cpudata->cppc_req2_cached);
+	unsigned int freq;
+	u8 floor_perf;
+
+	floor_perf = FIELD_GET(AMD_CPPC_FLOOR_PERF_MASK, cppc_req2);
+	freq = perf_to_freq(perf, cpudata->nominal_freq, floor_perf);
+
+	return sysfs_emit(buf, "%u\n", freq);
+}
+
+
+static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 count = cpudata->floor_perf_cnt;
+
+	return sysfs_emit(buf, "%u\n", count);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1303,6 +1345,8 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+cpufreq_freq_attr_rw(amd_pstate_floor_freq);
+cpufreq_freq_attr_ro(amd_pstate_floor_count);
 
 struct freq_attr_visibility {
 	struct freq_attr *attr;
@@ -1327,6 +1371,12 @@ static bool epp_visibility(void)
 	return cppc_state == AMD_PSTATE_ACTIVE;
 }
 
+/* Determines whether amd_pstate_floor_freq related attributes should be visible */
+static bool floor_freq_visibility(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
+}
+
 static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_max_freq, always_visible},
 	{&amd_pstate_lowest_nonlinear_freq, always_visible},
@@ -1335,6 +1385,8 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_hw_prefcore, prefcore_visibility},
 	{&energy_performance_preference, epp_visibility},
 	{&energy_performance_available_preferences, epp_visibility},
+	{&amd_pstate_floor_freq, floor_freq_visibility},
+	{&amd_pstate_floor_count, floor_freq_visibility},
 };
 
 static struct freq_attr **get_freq_attrs(void)
-- 
2.34.1



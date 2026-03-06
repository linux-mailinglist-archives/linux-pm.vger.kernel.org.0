Return-Path: <linux-pm+bounces-43776-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A8dMMimqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43776-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F021E694
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD2253021E72
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D235028C;
	Fri,  6 Mar 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Upejq1zB"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252134E774;
	Fri,  6 Mar 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791121; cv=fail; b=Jooqev2NTAz1s2CXAXFYEIXcUmdxreyIc7EjAcqpkggzhZCYwMh7z78dPsCWE863KwedOnugRCWjZ7vIBbHVKzsghcEGKO6V68Fn11YxJZVxAOP5nnmd39y5tEnmTOzzKmOkhbMXBrp2cjhsNemRYntFO4uBJhuLCUk7ah5c6/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791121; c=relaxed/simple;
	bh=0wM50v0UHttvLdspQ9ODHhE5GH8ywheOpk4hmAKfjTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRa9uyGm+OEFP47nkF6Jl0NBHDEkgIgmarr03geTZPm8r3xOQvIuuIKvdA7UvM0oQlAFBziAW1Eg0kURWv0yWAERx8i6usghh4UDyc8ddVcrCLIr9GjB54Xe7nnkAZaaS7+yX0ornzT1ixfdpJ+y77RdsYDv+ma8d4+xdfXZsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Upejq1zB; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBbcktfgyb3mbx+KCD0egBQgyldMrasojA70as0DAH/ZOBclGdWtRFNC67MT6ZfXR58hpKT9L3sUF4EMW0lA/ZkpfDa9qd7CX+Lr2hBwdzBlyd7qAf4iLGMy6G0IQGFNMXbLcA4ZQjTdE7N6iNgPkhwSReULcLpQwT4ABzRMuhj68d+AW/bbr8nUm8T/WhSr2kEFbD9ZTTsjE+oKmiAB4Ja7Iy8ghQDxYdJptC9tAm6JlCMjAVg2Jrqx/jfq8EEbMBPW+28ZpiFSAFDGmxdUJXOos8BkK+hCYeHz9x85bT82gDSNjs9xmIGQERrm79YzBQKXEgKgJ9T5nqhjli5ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLjRio8MWE75N+XGdkoUrfXYz8aO5pRvJhoPg1aFtK4=;
 b=nAKJoQP4UDtrmRkC//mmNe7b7bAACuNjsHzrnyE8MhOHuLTnw43RF+lLbVDtIzOQfFRtFRKiVKXqWssq1bYLA7moI5V9m7htxnPizH1tsSqO6kAN99GdZ/Mv+E7GMwJJcT+J+VyCyWbYUKgXIAjiDbfV4BIyWzbZZgXh53N2oJuzzQcWdY1XiPUc+k9dMJWaWocn/Ikr8I9Qbq8c37/fFnZJuKxjlN/LGre94QkTT6RD2UhfbrUGQVQLlXlT+Wv8P1gyyEVKJCbl8mwGmEHjcjyP4DecRbR+rFPOUca49Amno4X3gDEnMyzA3asbUi3jsUYv2CqRfsSEbAK7QRtAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLjRio8MWE75N+XGdkoUrfXYz8aO5pRvJhoPg1aFtK4=;
 b=Upejq1zBoblwnHb6HJGQOsbp9tPQ2LGY0qGgk3JY4wrb+ktyPXJtnAqogeeW3xwZ9EC2A8xYQryG5BLbEP6u3xudPcpbmIHDh4qABJyR0n72TPbpaXwymGc0F7291c2k7c92g0ydt5QOqq77JkPyKt6EyNxszR4PN5YR11Nsbaw=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.5; Fri, 6 Mar 2026 09:58:36 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::39) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:36 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:33 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 7/9] amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
Date: Fri, 6 Mar 2026 15:27:51 +0530
Message-ID: <20260306095753.17155-8-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: a78c5ebe-67e7-468f-1cf8-08de7b66ef5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	cYstSXAyb4fgdNTCh/J9ELw9bH7zGR8UM3KGEZ8tn5krhjRCzdxKxDx6Zpkf0Ht4Cb3m5X1hDLsJYiT5ecRkR1oRDq9fZI2zghYuaL71HsG3SM1TTfJ98uaIPyNvcWX4bbL/cTDMuFS2Y58ozAcBdRkvrtnba2XO6ycisiMa3j3QFH/8NFBWthYD4gcllXOSBuMP/K+58vbRDe+NFxmcJXoM9G9xeH24q5sFmGnGKtG4iyka8icalMizK5DKld+ZroMxUyiEFQf6dTT9l623ZLjE1cuqDafBsTP57Uc0MrbEAacZ4HMZi0OyE5GNp3lBMyib9woBHQsoA2/FQ5SkBD2leF1nBFR28qyhl0wCv5Bm1uOKO3lKeH/VJDWFAWmoAAVOEiBUVENi0WGhpN+b6Mi8tdyGChmH+vXmTPp0WTHXGSDJY7WFFu1YoGOsLVQ3triUsbdn+T3nNgIj9Snhyyw2ZBfYPxPJMuKUeuN1hjVg9pE57SvXkfCqhFGVMrqNXp7QfkXpbpVe7x6mB5UDY9eJc0IDSP13RAjk7ZGkSSJjsyR5ww4yKCM/lzVxzmPh3Xi2lwuQ3RK3DMMd/QmPq/+sZz77akEAsFCxAwSbxJHG3j1jAJMSTqpDkeks3W0gUi0gtgGav0bmV3Ac+yFbcPxBlZxSvtqoX1qDZngkmyRcsjvqnFDRUN5OtZ+/qy1dG4BgQDefKd6EPi203TD7guesSfKfuQ29LyGLXaMOirGzRr9P/ungqHM6TyBu528ZC1oNvL9npTLGr4WGL83x0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8+wbcdMZoTKO9ZulYTxNBG/sR+meg9x2r3NxVENaXA4zFMMBAHz+H8CcV29WOl1GEF7t+XcXnqXboVjBe6hA2F5sLgOG6A+uE422V1xmFNY263dXEuBtGqQkkr633L9vDOwIuqM+nmGK+WkH3GwaQ5js2WC2WLRM3I8Ge/9QLGfCjp8SV+fFQkotMuk6za/Lq3XD1+GNWcFPbWy82Qj7wrLUfSBe1TfHWjJUQJMeA5XQBAhRh0Vq0KB/ZBVmHdp3JzO7LYOjJ4FLt0Cb466HNVYxccZb+6dY+7xKyMWngg3SCniCSW6fM8uOjehJDQUnIWuHtbpKWJzyQQeCSk1Hv1uYI/07zdZQNjvgPCc5S02U3g9cGpCgXQ4MWC+OWY+RLozfoga0mRsGjBoE1z8y+Dd41hJ3pu//bzfIM3K9erZz5Yp5uoDXOjdOPxfwnylO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:36.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78c5ebe-67e7-468f-1cf8-08de7b66ef5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
X-Rspamd-Queue-Id: 3A7F021E694
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43776-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Introduce a new tracepoint trace_amd_pstate_cppc_req2() to track
updates to MSR_AMD_CPPC_REQ2.

Invoke this while changing the Floor Perf.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h | 35 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       | 14 +++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 32e1bdc588c52..91fa073b2be48 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -133,6 +133,41 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		 )
 );
 
+TRACE_EVENT(amd_pstate_cppc_req2,
+
+	TP_PROTO(unsigned int cpu_id,
+		 u8 floor_perf,
+		 bool changed,
+		 int err_code
+		 ),
+
+	TP_ARGS(cpu_id,
+		floor_perf,
+		changed,
+		err_code),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu_id)
+		__field(u8, floor_perf)
+		__field(bool, changed)
+		__field(int, err_code)
+		),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->floor_perf = floor_perf;
+		__entry->changed = changed;
+		__entry->err_code = err_code;
+		),
+
+	TP_printk("cpu%u: floor_perf=%u, changed=%u (error = %d)",
+		  __entry->cpu_id,
+		  __entry->floor_perf,
+		  __entry->changed,
+		  __entry->err_code
+		 )
+);
+
 #endif /* _AMD_PSTATE_TRACE_H */
 
 /* This part must be outside protection */
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a0bc80a7d3f15..632e87b700b14 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -333,6 +333,7 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value, prev;
+	bool changed;
 	int ret;
 
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
@@ -341,17 +342,24 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
 	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
 
-	if (value == prev)
-		return 0;
+	changed = value != prev;
+	if (!changed) {
+		ret = 0;
+		goto out_trace;
+	}
 
 	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
 	if (ret) {
+		changed = false;
 		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
-		return ret;
+		goto out_trace;
 	}
 
 	WRITE_ONCE(cpudata->cppc_req2_cached, value);
 
+out_trace:
+	if (trace_amd_pstate_cppc_req2_enabled())
+		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
 	return ret;
 }
 
-- 
2.34.1



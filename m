Return-Path: <linux-pm+bounces-18745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFC9E83E4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D574616580D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C985260;
	Sun,  8 Dec 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W6XZirBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65822F11;
	Sun,  8 Dec 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639459; cv=fail; b=nNjucJHv6vmZ/we3eODHZ+YNs+uuogQ1V9Gnq3vuEaDjRuNhfQ/etUEkjs1sG/PGt1GsgxkWrG/ff8dYOj/vZ1XZzfJ+TdbnmUnSmXfjYbV7U8EB+Sstw5exAycHzDZLW1HmCCnyuYqScZ5NoDpLRnO7KzNp3e81cplL/P+lbLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639459; c=relaxed/simple;
	bh=mbGSROJp4wSwquZuym2lRA9xfWQ7OOjejKLhk3ZWCuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6Ik+hdBoZrDhl9Y8PObz8e5AL/FZYC2aCEUdvrxE36H1o0RZh9oowuuWS/6OowGlKfnMxa+xclqUjF7gdSxT3I1Wl+EE/lgHQ3HI0HSiu4MUepiRpc04eHXcjxDQwP4xyYNaSLfN4hS0AS5EyDMWBbXmtvem5kjLoaZaErBK7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W6XZirBs; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ubq5JJ5am7tFSLPyInbpW0t0aG/vF6wJzH9qWLLtMX/BNA3Hm6CVDr0MWrPYuNxowobgAyjsTo0XjWdFtLiLaJHHLEViGZ3bo9ksysPo0kzVxT5+vYAFIYA+LtT0axpcsH7U6swH4rNUhEjiQWkYcMwv+75E3CoX4T31/qUWZkQikt9Lz4XoDlujzSe7I9yne1RTSsz9XLdN5XHU/NP7tl7M+gyOgb/WKL901CAdD4gud6CpNZONl6yEvT78pFskqfdG+Jyya2Ox33kxLaB534SIh8DRVBhPlzm47+y0b44ouydGCMnL6LNAJWib4eyHiNwjjQbv8npGEK4ohPgT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo4tJVtZZmMIBRDMm+wEsoDtzBFcHTiYqL96ys7GfJQ=;
 b=DUMPtrUjhmWNzjdbW/e84chzZRev9ItSc1dmaGSNXU1LwCNvDPuBHr3s8BIJSnu/j2v9T172sH5HzyEDprKKvNKPq9jB4TgOJYJrtPKOwFSGmkkU/5/Iggeul7wLmXJ0k1fzcBXRI4d+/T8S2+FVcqD8IkJdurHCCppUHTNeKJBF17qJrchTJQ1Xnf2pbDubW2w+0FtJrt6w0I1xWg19FmArjc3KxGP20+l3Y9HJkv1+Bpw2EkPIY/G8hJN0+TIJ1edRX4l8+GITu1QSyn4S1TPyB40W25JoOtkqMplnjZXcpw+h9w7D6Q4CRJyLeBGjT50ztn8AVaKb5oBSsbSmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo4tJVtZZmMIBRDMm+wEsoDtzBFcHTiYqL96ys7GfJQ=;
 b=W6XZirBs9hZxyCP2ULDw1CkCCifJwjVuZZT7dkcTB3o0Jmq+ys7zkJS0MPGlurKnPko9Ks9nDHw7xmJ/vWuY6a0mJoAeNpm8H67NUhNxewu4JqPnTGIqoIWn3fr2d6CKhZnRT2QgNcA/fE4O3MF1WJjmSibwuRNmUwUMUYVHGos=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Sun, 8 Dec 2024 06:30:54 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::e8) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 03/16] cpufreq/amd-pstate: Add trace event for EPP perf updates
Date: Sun, 8 Dec 2024 00:30:18 -0600
Message-ID: <20241208063031.3113-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b69f3c-83b1-41d5-aec2-08dd1751de20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NH2cCVF9ajQXUrqDSLry5FGQP+y7+/gTVRcelbvrSkHiOblJWrSsPSt8QorI?=
 =?us-ascii?Q?6kVcf2T/H3eG97PFqKPnZ8qi/YWpyjqn5SgNFFDebybODjd7ufmQ14KP7gRI?=
 =?us-ascii?Q?VA8hjfVB+yDmIAAz0wfSWvOjF0pozpGB7xJ6zN/t+R3wfc5hp6JD67UGouhv?=
 =?us-ascii?Q?jmkKeDCJl9Rc0DCmRMdjrSG5bvR5ewz86cwSU+afQv7qYYjaz8in2H15t2P6?=
 =?us-ascii?Q?B2D6935/kLgmwFT/xna6jJX+30SYBzzYon830nUtwYPnQ8iW50HqJhCcSqWp?=
 =?us-ascii?Q?rZBe4Mt1FiOulw38wiR+Mxymhaozdm87NWnSUch/96Oj6rPsDh2I0+Ixdqjv?=
 =?us-ascii?Q?XFSn+8r6B8TLjgd2ZJ0NBd4bv0cBCg+OWNgfuB1Hzz62tpH07lcKI6BvVeXq?=
 =?us-ascii?Q?NV/jwCHZRArQrax/pEvqZxT8B7Uzs7rxTs/zELZlgh2663Mh90JDgAesAQQu?=
 =?us-ascii?Q?1knT5okI3WSEYPq3rNkxkyuDfBZNOqluUVWIKHuY5McgLHmdUNYLFTaWy7A4?=
 =?us-ascii?Q?S63Z3iWIwYAi8T0NNvQAALXtZabSahMvLsu0JLDecXuZRaDy5yOZCU4jK9aZ?=
 =?us-ascii?Q?3ejvsyvDaeVe0xg6w0BOUbiYdSs5WSV5ld/l9zohsQQ4lOYzxe5ooigHPh21?=
 =?us-ascii?Q?sacjoqCS2RXORmJIHeX3I2kCu/2tvMkcluId2y754Be60E95lhZXNL4y6nyg?=
 =?us-ascii?Q?l3a/bAuHei1WVUyTplwR/ouk4dMH29wdZWTPoASoyORGNNrECw1wV1YZco7G?=
 =?us-ascii?Q?/OhLKx/b5ANOOVJ1sPUqb6mg1tddBtdVniIijyPJGsFUKuHjxq4gR3FUwkiR?=
 =?us-ascii?Q?q3d9RIsGdMFdiukvTtNr/W1iLre3LWGIHNx5+/vcPGhPxD4inVZRkNETPMoV?=
 =?us-ascii?Q?+qlpgIvj106QMUm3jLqDUI3NluG6I6q+QbC6jZwWms8ERS88SY7TWAN+kSGk?=
 =?us-ascii?Q?LpiLqqfMRWfYuJcJMtZPnxB7mh+rFIFVKLBph6uynE/i7QYIMg7WhyY72cDQ?=
 =?us-ascii?Q?H+gwdrKj995jsQzZSrP8zh9RQDmajK+IPv14xNEuddCT5F9QfbS1zPLSN7Wz?=
 =?us-ascii?Q?1HvnWv6hjqZ2fGr1AFjU4wPR7Sj6sZWusJ9UDq8OD4iq/WunjmXrxCb4HQPJ?=
 =?us-ascii?Q?pJ8ABCNXFwtKocX0JXjSSCSDU2NZ8GZWt3wv15DO9uNlmn7foFa6R0y4Ayjw?=
 =?us-ascii?Q?bXWp4i+TA8WykndOpPE/Xse+RlvZuBCTODKO0NYFXxVmpkdi3daNHyu0PpNM?=
 =?us-ascii?Q?orj5B7FccSpU0TgmKQhd69VK4Y1JQ1a33wsGI5+5AS2taAIO1SsH5ABFCX5J?=
 =?us-ascii?Q?cE+vijohjJqWymyvyEflxBrSngiBDgQvtc6YOcs9HRkOJ+qkRGz0WBJxb12b?=
 =?us-ascii?Q?uTW+hy7RDSAAELyrxaO8F4PxAzozWSTr6sLg0zzVFzosj3AD/cHU0VBxV3Qc?=
 =?us-ascii?Q?HC/0CfcaJPvRCGXC3czj00cjzlVe/Xph?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:54.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b69f3c-83b1-41d5-aec2-08dd1751de20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286

In "active" mode the most important thing for debugging whether
an issue is hardware or software based is to look at what was the
last thing written to the CPPC request MSR or shared memory region.

The 'amd_pstate_epp_perf' trace event shows the values being written
for all CPUs.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Fix boost in some calls
---
 drivers/cpufreq/amd-pstate-trace.h | 45 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       | 28 +++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 35f38ae67fb13..e2221a4b6901c 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -88,6 +88,51 @@ TRACE_EVENT(amd_pstate_perf,
 		 )
 );
 
+TRACE_EVENT(amd_pstate_epp_perf,
+
+	TP_PROTO(unsigned int cpu_id,
+		 unsigned int highest_perf,
+		 unsigned int epp,
+		 unsigned int min_perf,
+		 unsigned int max_perf,
+		 bool boost
+		 ),
+
+	TP_ARGS(cpu_id,
+		highest_perf,
+		epp,
+		min_perf,
+		max_perf,
+		boost),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu_id)
+		__field(unsigned int, highest_perf)
+		__field(unsigned int, epp)
+		__field(unsigned int, min_perf)
+		__field(unsigned int, max_perf)
+		__field(bool, boost)
+		),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->highest_perf = highest_perf;
+		__entry->epp = epp;
+		__entry->min_perf = min_perf;
+		__entry->max_perf = max_perf;
+		__entry->boost = boost;
+		),
+
+	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
+		  (unsigned int)__entry->cpu_id,
+		  (unsigned int)__entry->min_perf,
+		  (unsigned int)__entry->max_perf,
+		  (unsigned int)__entry->highest_perf,
+		  (unsigned int)__entry->epp,
+		  (bool)__entry->boost
+		 )
+);
+
 #endif /* _AMD_PSTATE_TRACE_H */
 
 /* This part must be outside protection */
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5e0edb65de32a..a59c897dd59c7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -324,6 +324,14 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 		return -EBUSY;
 	}
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  epp,
+					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
+					  AMD_CPPC_MAX_PERF(cpudata->cppc_req_cached),
+					  cpudata->boost_state);
+	}
+
 	ret = amd_pstate_set_epp(cpudata, epp);
 
 	return ret;
@@ -1598,6 +1606,13 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
+					  cpudata->min_limit_perf,
+					  cpudata->max_limit_perf,
+					  policy->boost_enabled);
+	}
+
 	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
 			       cpudata->max_limit_perf, false);
 
@@ -1641,6 +1656,13 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  cpudata->epp_cached,
+					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
+					  max_perf, cpudata->boost_state);
+	}
+
 	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
 	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
 }
@@ -1669,6 +1691,12 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 
 	mutex_lock(&amd_pstate_limits_lock);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
+					  min_perf, min_perf, policy->boost_enabled);
+	}
+
 	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
-- 
2.43.0



Return-Path: <linux-pm+bounces-18646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BB9E6086
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661FF1651C4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6211CD21C;
	Thu,  5 Dec 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VeONxHNI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC71BBBF1;
	Thu,  5 Dec 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437749; cv=fail; b=ZBhn+ncEp+STjUJ0YcxWukUJON7IbZWAcKeEqSMF7jnDEzkg3k60ZI6z4zPVaStkLhOHg7/cuMdgMD1wCEu2XBLebhvZw4s2NRRrhSJNmZrcFqVX//HquUJGZy7PuxjJBq17zMsFGck0NYib1swe1I0OwFKPRmJsmxcHMiQTCc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437749; c=relaxed/simple;
	bh=rA/0wCJ4tg+aNsVFNFdCGU0Zt6oDuZsPcDV7xaK/KZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zmp7XaHFmlWv8NLondO1HkxXymZBDcEhyPeqDN798anORa3fS5CBgBOvWGU+pU8S5J5cXy9oNYtOc3+4kVHmJAVfz6kzkY9s50xkuSQACubeusF56gOLOuHiDhQ98BhWAJvZoDWGBRbxyp6XnlL1RMGXQ5orrS8hYaKecRdfOI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VeONxHNI; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUkY/OUMWvDVEeJRvB1nndJz0BX1eLjm39izxSnWgca9D4512z0ySUFM7b7JlL/KA/lu3GpxEXo2XMbeHcHYsaRs3IjdzwChPUqcZ0G7fAltEafSEQ5uqMgByhAPY3RO5AMBPwFCWakn7pKl/vXBbD4I2D36vu3Q92dEsKKUgpXxzEwiohCqa4sDbryE1X0Mg60ryN+GmQGTGXnJ67P2clU2C5OG3fsHif/XW+04huuslQ8/RnlGwBXbnbZzuxSMDjhz+nLNitoqaGBLAzp752+1MKBeS8ZtKrqwOEMilkmECcKubCdNR0Sbc88aOO/2uwrHPEqULV7YZALemeodbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qMyCdPonk7jSP9EDxLgHKFrVNx7ZksOYmd8xbL1ziU=;
 b=q9LTTO2YPoON1a5DP3cSMMqoELpj6Z3mW4gp+6Uo3zii+lXHaIYk4z7KbP7eNgSd32cmaJX73h6ehA+wjcWHXwCaFxmtONadfT+lN1caDNwQYF1Lo8QBLOavMPlS2j2F0W9qKtrHzHStACIeed80oETST/U54C6/Q1Ki3YpUskitQOto6OLA+niJRtbnBYmEHgYIMkmPJvCVlSWzCKYzwanMHpzUWFUlk8kj/NaSvqM2DbSC6OtW7M1t6n8c5Sd6i6bKA2I2mlMkYKzeyjNBLLW4fA9ACSvpe+wkSICSS6FpcsaAz0PIVI/vH4E8XCiOWiLqW9inT2LINmt3nR8DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qMyCdPonk7jSP9EDxLgHKFrVNx7ZksOYmd8xbL1ziU=;
 b=VeONxHNIJICXbzpIEOkKJ84Koij6bNxnOUIDIQ0AOgRVSQqVo8kGtEZGX8ItugGRIYv4ttPT6et2Ug/dDMA4szo/JcOINB7I9G2mwpYlRWxTLI8KQFiCVHZSZqV1K2Ocuvla2tLjR1HnySGwHl2Q68FM6q7rLd2mRr1aPep/QAk=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 22:29:04 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::75) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:04 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 01/15] cpufreq/amd-pstate: Add trace event for EPP perf updates
Date: Thu, 5 Dec 2024 16:28:33 -0600
Message-ID: <20241205222847.7889-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa1b303-8fbc-4472-73f7-08dd157c397a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tpazii3HfjdNUEsopnI7wb0CRKokURu7QEprF5Z38Ev4iT4+sXDPLaft9MRA?=
 =?us-ascii?Q?0db8Iut7WrBat1pNzQP41xnSiCpSD8DRR0A9dOHG/hvapbK49EvUhytjM9hk?=
 =?us-ascii?Q?Fgat2CN5PO6hCPZPUQ99y4GHeXbqmJFY3LgtaIj5H0Kwiuu7zfKbEQjXUIbn?=
 =?us-ascii?Q?n4BeRdUWwx40k9aAl5xBcL7ffWIQp1Cf5AZ+SyUn8ZeTOiucw/7pp2MjOxpL?=
 =?us-ascii?Q?K/Iz5ikrIag1FQmOMhVJd5ELx2gMsoWT7gzVQfNZvXcoyZnghIPsDw0pM/vJ?=
 =?us-ascii?Q?Ka7MlMdo68VLhCpqL2fMpPDgSfvtwv4mEtMfdruDIA90l4cUxvgWpkbptN56?=
 =?us-ascii?Q?U+gEC85c+Zbh0Ex8uJDSxzrxzE2x3K/xc+lhsE+WS0f5lzWFz2OsRVcWKwre?=
 =?us-ascii?Q?HaOYpO6dBcO46havZdhrFdWeRWhRhRp47f+jncu1kT8yC4bEJrXPRMbPDnbk?=
 =?us-ascii?Q?li6gSf4Bkmy43MnuYaEBZz58uIU5AKOmk5mj6dty2O89ci6G1JaSaQ3KLhwA?=
 =?us-ascii?Q?YZaiLPhxYDAiJVfSxAzEU1RuSPWwWlrXMXaur+pNZ6zrVFJs3JdLuwkx6qCm?=
 =?us-ascii?Q?Al/q75BEG/n8UzK+cfzHNEAYCVaA7Co8omKkd2tz6XBQgY7GvFix1aCxOiPk?=
 =?us-ascii?Q?91lO9dxB6SHWxM4XTUl6j5fG6Ao0+MPAOjC35XF1WfRCx3YL5afs8xii9tb9?=
 =?us-ascii?Q?Pnju1Jf+oCYbica5EtV7BewoHf2th+q1MEG56fNQeIqgDDlz/us6feLTSAYk?=
 =?us-ascii?Q?SX1mNJ4ilSH2XytYwAn5yB/jIlhRvNPbdh5Qj2OB1XyBx64vjSOC60OrXrxI?=
 =?us-ascii?Q?6lOK45WWDiCQXMphLLN77PQYjScwYWWMsyWPU7EhAKjSrZseuIF1h4ZZKD/1?=
 =?us-ascii?Q?pLcSVj58IGgTpVGifFlZNBcfflAKsrnV41cZ6hMzxeI7yqm/sDXkLUrQ2GFY?=
 =?us-ascii?Q?kCpfnKbZZz1/F5QSoM1aLpUv/VlrD6vWTkPt8ga0o7oZtbDcNjrfRa9H45Zo?=
 =?us-ascii?Q?m6pR1HML4LE27vzBWhUzZrrLCWFWRSFk++6HvybhIJeSEoX2AjfIGZUnA2k+?=
 =?us-ascii?Q?a0kTl9J0X2qnRjQiis2SpG24X/m+SDW9A8+lMlJi2APc9MdsVBK6HZGfIKbz?=
 =?us-ascii?Q?RHBwY66JAmRuMNX9b1b7asHsLChPj83OGMXhD4ECoZxXulELO3aY/IU2Bh4g?=
 =?us-ascii?Q?ev99nXCu2Kjp8zci8Tcq0UYwzxVJ5dNAWZSBwlQJ2B69iFUB2saRxYKm0G/N?=
 =?us-ascii?Q?nW2YLmNvoBsS8+VcI4Z3dg51120lcP6RPjgjKxiv3wnLcmzJClXKEvtPTmd3?=
 =?us-ascii?Q?QYivnKKYOTNbQfb+jna1tsMZgOXpTOhFqzf3M0jp+uq9TFeIx47y96v27MMG?=
 =?us-ascii?Q?EngRt85boMSGohjCAcSwbagp1/yCf8FdpFRdFNjc2QwuNDTZQYIpfYjaaWCl?=
 =?us-ascii?Q?kQqKvC57A0Jwj0ljHKSv7x6GwFXkuDHl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:04.0151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa1b303-8fbc-4472-73f7-08dd157c397a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

In "active" mode the most important thing for debugging whether
an issue is hardware or software based is to look at what was the
last thing written to the CPPC request MSR or shared memory region.

The 'amd_pstate_epp_perf' trace event shows the values being written
for all CPUs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index 66fb7aee95d24..4d1da49d345ec 100644
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
@@ -1596,6 +1604,13 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
+					  cpudata->min_limit_perf,
+					  cpudata->max_limit_perf,
+					  cpudata->boost_state);
+	}
+
 	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
 			       cpudata->max_limit_perf, false);
 
@@ -1639,6 +1654,13 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 
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
@@ -1667,6 +1689,12 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 
 	mutex_lock(&amd_pstate_limits_lock);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
+					  min_perf, min_perf, cpudata->boost_state);
+	}
+
 	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
-- 
2.43.0



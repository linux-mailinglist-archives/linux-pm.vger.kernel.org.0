Return-Path: <linux-pm+bounces-18847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A49E9E5A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73716661C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01AE1917E4;
	Mon,  9 Dec 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ncNgQV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC717B4F6;
	Mon,  9 Dec 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770398; cv=fail; b=Bmnp9mQRIi1XbuojzDj6woXCx1wwMvL66vrSaRg3UFq/2GvHWequhgbj7O/As9hl9FUppqj0Lvzmm0vi1uq1P6DxoBmTamV++iNmbHwVREvxLxg+J5v9KdNxgp9q9DEs57mc1q5Gcb2hdydpCZkACStqmdWLJkhGbtxn31voC/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770398; c=relaxed/simple;
	bh=mbGSROJp4wSwquZuym2lRA9xfWQ7OOjejKLhk3ZWCuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXHJol95XVqv5CVPiicP6JvQZqmTRJcON7t0W1u6J9M6/DEHYtRCHEsT5jkEqS9Xytx/6RHLde3hRsWnJpI08HZTtuh3iit8Gq12x/6FR2N2bY7tKd+CtHxrlH2FEw+pTCWZy4H2vQhGvKr5mBqjaWUbFNS6V4pwYicFatZnWb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ncNgQV+; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lioMm7tfbeIip2XA26pOIgAi/Jf9Zbo8PoSuUsc3CKR1hzsPrxRQ0PLkzHys6uXP0EhC+3onvAZ+vCvT1QwKhtvIOdiVW7N5HPf/E24mRlLBgKRrqFtRsDHRQoYPGBPXXftEQcAo+nOZy2Jbs9LGRIuK3CytZIWL7dOBIpXdm1haMIYplp42sJ2Jrk5RyWwpEXQquuL3kPOP9hQVk07tj+Hf8KcP+6vcHYmEagNRkffs+5jEuLGt6/ya5f/29BLVylQMUythMeRP38lOvgHXAixmlx4cC8KjtnWsP5lK6Boml/gRwHWc5n4exbc6LVry/vWzQyIIHasfURBPwcx8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo4tJVtZZmMIBRDMm+wEsoDtzBFcHTiYqL96ys7GfJQ=;
 b=mx6ly4hF5sExKq6ZnKsJAGY3Ak0YkKJo56Rt1R7lV0FCqpW4UnvqICWoWwaSBAqq8CrgkJqLTR4hgvySaWC/z7vM4pwz2pOiPAKBwhsZQSW0zCCNAn9GAsOvVwc6JX8oSxHJwc1w5PCcru7fycL3y23AkigbsHme/ZAAZINBsE1cFuF0aX8X4hbWrrGIHNpip7ceFLC2H9/r3FNoMrmLrJccZW0X3JT5/Ktb3pQauUbW92i39Vk7lOMsMPPy0HZmqdmmMhfliuFCpGfiDAeuTegk6z5bnlqZNZvTaTDD9fADVSGVNVGr/RNLy+Qm8jpv33u4c8zcwZGUUu99cci1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo4tJVtZZmMIBRDMm+wEsoDtzBFcHTiYqL96ys7GfJQ=;
 b=4ncNgQV+FJe0+uyeInzKvcYsVpbh1RSqARWuLjuU3kH2JbPLPZjtWJnerCN+fb37zANFB8MglZ2bqYbOK2j1LUV6HXODmWwt6WrFxOZRDAX0/gRTa9G42LoARzP/xAXc1zuwx/bsKKPwIjWDaQVhZDQrYDNZCONK6aUUNmSSgQI=
Received: from CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:13 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::88) by CH2PR19CA0027.outlook.office365.com
 (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:10 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 03/15] cpufreq/amd-pstate: Add trace event for EPP perf updates
Date: Mon, 9 Dec 2024 12:52:36 -0600
Message-ID: <20241209185248.16301-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc1c6e2-df0c-4000-2826-08dd1882bbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWJlMvkb1sqYRE7YTCAFl8/dlzd0e/n3tlWmQkmnym0rWycqynaXrOaSBYWZ?=
 =?us-ascii?Q?wM0fQWO3F9KPY4ymBrQslBc+j9aVduEw+iPWiC1Id+N58Xps4CTgOwevznNo?=
 =?us-ascii?Q?bwKABtU/3pCpoQGEMdG5XBUjgte0yOwMR7h3ynwe4uoPM+2j7O2CzUWCu9eb?=
 =?us-ascii?Q?LbhoywsXGyQmJfikFbech75mFmIMfTHSwIgMQVcIA29rYaCqJSaSSnqIil1M?=
 =?us-ascii?Q?bfNIYmtY52aTAM4wmxKdXC1rNDG4B40irFMaDSvGf5nTxQhPjZco4sF8PlP4?=
 =?us-ascii?Q?iVaUcIytdrRUwReC22EfaUZjOnlvOI/fTTpMAnbgjxQlH3X2Z95pwYOhWlgP?=
 =?us-ascii?Q?kVBLDjfnuzOR8qDHZkAFdXP1nzbkSh1NlkqFNgcIBdYrULJJtSCp+/OSbx1G?=
 =?us-ascii?Q?PpoWgROtjvOJzJ9CMi1sxsuH8d05tahMSdX8br4CiZE1qU3Wj6GEwYHTkws6?=
 =?us-ascii?Q?b+LWy8pRNo+Wknopxhr1p9JQepBSrlGc6WFAe738wx9P33Cg8+8g+VWiCYzV?=
 =?us-ascii?Q?6GoURYImnmjtyui29950iC2WPwob25TM35mTcICQPNmeyvgOpbgSHkaQwuos?=
 =?us-ascii?Q?Z4UzkSM9oFgJiJtwjRWx9BBgY0VLucwrxsTEBrt/qzQoBoK3SsHFQ/r7nkZx?=
 =?us-ascii?Q?RwKGlB5FERW26MXzP4eokel+nmBJ59u9M4ALmC4b1WGFe5zOwkmjNIYu92q3?=
 =?us-ascii?Q?4dWXqJBJBtiheJnHqRIlRLFfwVvAyVdQU8FneENwXmGlsIND7A2hZAE00r37?=
 =?us-ascii?Q?4YYFInIvb1OnFiaAdcLXdfpZfqrwPaaDWaOJk7+bs/hnPbkn5s9qbK1xYqnU?=
 =?us-ascii?Q?vISHOo+09wL27piGVTh1hHDnC2ZAcEJcfPLefnZeKTM/4IBPqaHzmsC7VGg1?=
 =?us-ascii?Q?xUtpuYMQzOxjN4DfF4793aoLAuLW8LpFuHLe75Ik/oc/1c8tjWM+eeKNwt5j?=
 =?us-ascii?Q?22Gt6vUEoxFCNp93SGtlaHDlr842dQJwyjITkhVFDt0SAXJeWAT9rUQQbkp4?=
 =?us-ascii?Q?JB6NEDj3+2e6Bs4PXsrjrzHR3zoABAXp7FTgjdvs8qrVW9Dpx+TGmBd53MgL?=
 =?us-ascii?Q?qB6coLlnzd2sk6MYM9Z5aOqTkx1E3uqE0aghaYoovOhqMiwVAhDFuGmhdP5c?=
 =?us-ascii?Q?XaviqfjQghfTItIzkoDM0umOI7MsxaSbwTE5jaJRZwgXFyTxqmdo+p0jQARc?=
 =?us-ascii?Q?51zt/T1MN3jEKm1n63o8QKoORfaJS85tbcw21VNB1M4mSaDHLrAO4cibB/yD?=
 =?us-ascii?Q?KtsRbSBZUKoRsIFjD/xyiJ1aepudKZJhVDWD6PugvWaImxKnH0ACZmmfqWBt?=
 =?us-ascii?Q?sm+QzzaJL4ymUyHJGpwPXiVvcrsEUHsUghXwtEyAftfNw0talbFl9VrmfmBa?=
 =?us-ascii?Q?OkBYbAebS441fUfOrBKi4PmZCEo3g7XUtVofFNMx9mJq80sCHA7SV3OAMLRC?=
 =?us-ascii?Q?ApxR3v36qy2TKl5Q55zirQGRRft/7Dg8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:13.2869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc1c6e2-df0c-4000-2826-08dd1882bbe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

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



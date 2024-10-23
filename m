Return-Path: <linux-pm+bounces-16296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A39AC7D6
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD08C287B4E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201D1A2C0E;
	Wed, 23 Oct 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1kvepVBy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED11A256F;
	Wed, 23 Oct 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679062; cv=fail; b=p0205klYwofWyQY8P4KzK5FXpK5xl5k/EngJBI4cIL3eJJ2QigtQobKkRCD5U0940w1koMOLXMNGkTsgjqtfHU7ZG20GJExeeyBQcB+IJxfr3ioVPIAwhMR+lYEdkHBqtHVK2kNJwLahxkIZy3CQv/bZEd9kJ+J0W0ADJ2uiMcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679062; c=relaxed/simple;
	bh=cSgB4k4JEd65HuE+Z5SkT4e33a0rexeYWvJOXZnNOEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu3lQvZ0CJ0om+9wL078aFO+ekaR/ig3QrcFNzNlAfoKZH3ekGIKsAEzgLqQ9Bhos/pYaJaMLlLe6qMI5o6MsRQdis+NcRnKEeZZByrKqlqlNsPXmFDg3G/aTRsYZvvNMP24qF8szKW33Yyel5GhxBmkFgjriwyFBEzjehd67mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1kvepVBy; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp73LVNHfaV2FkzPjsAwOfm1tLr+kgdkXf4cb4oGgSJnYix1DjcnRyIrGc+5b9A7+0UPp6fBHMIEh/+jvJdsmTRhFmP9C060kv93FUCmPz8NxNmBS3EJ5Q1m+rA1CKwolmrun5CTH0lQ5Olr824ylU7k6UmrgPkB8ezQu2fnSdXChSkMTb1hfvVOk1qesxicmpCePdIl9KwN5D1AuEvmre/SWO8S4YFSK5PJT1RUsJVbpkKxyQiVJXuXLEu4f5E26XUOQuvjL5mXJvaQ9lHklP/NVD2sCyd3N28GgTbQtadW6j4XutA2eBGRk0+iQs9ys/lb4JKq4HyYm3vQFRRpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtrFcFZv53To+Z70TLrpe5VWRQulXsqnvQhzQR4vlIc=;
 b=PZmwi8FPdONbG8iroiA9VwXzU783OHVRkd1uddU2OY9LaPPRUbV6iptjRXUk9B/NAC1mKA2bqxlzktoxxJrX3EAPBQqB6IF2jESloCEhi4eJW6m2enUILMgbcpJvXI70WcnlRgCxnsTzZg2UqWiBnRBhrEQfxGyLSpPEQzrH1ftLPVylxYYQ+0vNmf9zCK5uCxEyjqHLOLmLWR6PRek7WtCN6gs9F/U3/U+zzhJZDKoY0dVoTmJqjE5eZS1Yw0zpO3kyNtJNmsTaC72O6Ko1GrxYTYZJluE3KiP+jy+xwGlHT2s9pMQq+luQ5aIes/SRRWT9mrbdvMIs+glK4X58gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtrFcFZv53To+Z70TLrpe5VWRQulXsqnvQhzQR4vlIc=;
 b=1kvepVByMyMlGfBCoFh0L9v8MXD9rB8/KyuJnT0uyT244Sje7yemZOG+XpmiZds/r/nUKxZ9ShkDMmcOYQ3Lycsv+IJpUI90gfynNmUehF1rH9VYSU9zH4Xd8uZ6L0A5t8/BpUgXR2YvvqtUZ8HEjaJHbsT4dFfv38kdLHw1FjI=
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:24:14 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::7e) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 10:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:24:13 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:24:10 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 3/4] cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
Date: Wed, 23 Oct 2024 10:21:10 +0000
Message-ID: <20241023102108.5980-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5473d8b4-ba3b-4044-12e0-08dcf34cd7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4oLA0afTy9gfF9uldflqlCDCURHTUcBp3++7M1L+UiLYI0r//bfWh7LUjmh4?=
 =?us-ascii?Q?U6Sdf/UAq6EhMBkPkqnxMMPIK3MKdqV59aqohNaXbqD/byC4wxZE77a1PF1l?=
 =?us-ascii?Q?rhPNX8Vm1w6XX1MbfyoXKfKWV0nX9Y++AK7+vCdpq4znZVIqE6RLmvvYY/1e?=
 =?us-ascii?Q?WarU1CQfKKZaD8qNSpOQ/Q/XUIekP8zluIFvvHxJEWndKR4apt3RyusNgHVJ?=
 =?us-ascii?Q?5Q8Nvx+GNHVNCkInsl3idJ7xK4UngscUd1ogs7c0H3AjWdu1A0/YOwyDWqC2?=
 =?us-ascii?Q?a0poFV+35Y8PmETUp/Z3fP2q/oC5fB6HoIDNAviQMEtZti9EWZCY+iEz6/o0?=
 =?us-ascii?Q?2+BInlpUt0WRf2Sr6P4wssbi5/r8QRlbQCFnuEIJPjYqet/NyszOTuemkHBW?=
 =?us-ascii?Q?cBze7igWuz1j5dALkhdKOxjQjvJIp1wxJTIPCtEHATqhuJwMX8I5QjieE3n7?=
 =?us-ascii?Q?yYRE+uPBvUkRugE2JNVYNssmifIddhDPxElyRMVcrYBdoRKGVofZ+rH1LP1x?=
 =?us-ascii?Q?g31bsHPje6eMNYmYAnOx9252CO9fmXGknzMdzOqLSR+bqHmSpCsqytdCmmWL?=
 =?us-ascii?Q?UWBgZGB2nBMyBFCHczc3Q/Ch4x3HbH4F5II0QpSYnpTuqN4fOXy7UT1hvoZm?=
 =?us-ascii?Q?YGVqQlqthRVO1FgYYE+2BN8KM6pbZiTDGI/+pWzOIufBNC6/KF/JIiLkAe8M?=
 =?us-ascii?Q?P6WyZHTzmhMM1WB4W8/mDkzm8GS7dzNKnAQ8qqiuU0qA7A+RmJKXq0HH8tAL?=
 =?us-ascii?Q?lIJQtTDHisayOLVnyEqQmEvtnNl6GhBe/G24/TD4xi3MskBoJAXQAVeLfO1W?=
 =?us-ascii?Q?GhRH94sWq9kPOP0WzMvFweyQsyo+pwGyf+nhhZ43PEUUVQDeWSXDBClNM4u4?=
 =?us-ascii?Q?vHeRS0/ppII1eYwxMCxKaYecDSTbzjASWq7IVRIsVzGjYw7kRY3IPBLQzjaz?=
 =?us-ascii?Q?nHFv+k1aVRS1WMzbX4D6oovArtynJn0VN+VZlW5X5FAELcjP4eSzRO2FlvHZ?=
 =?us-ascii?Q?SAxNa1NyNV87eOhXuedVkaYh/bIa3iDXWBEInyQB1oc6YoCFcaAJvxqoqCp/?=
 =?us-ascii?Q?fFodTlfn06h35PW2CY/eINU90qZ9TopMqgaayCcDVx/pfGgZV/1Rynjskyc7?=
 =?us-ascii?Q?WD/bgR8WEHoIlIvJI5dCK8vsh25aBLf3O8QZIaeQBsvEczfLp1Di692FNIgx?=
 =?us-ascii?Q?TVLonG08UZZTZuX79RPQ/HuiKPXF1ylHfOXK6g2GZP7G/DQbGkKf+eDnI17u?=
 =?us-ascii?Q?PaiCyhHfv2VXXr9ze73kWirLK36Ezbg7XwBGruoUnzAIDtsqZLYYwSzIeMnk?=
 =?us-ascii?Q?WqwOuCODNyO+FNRWDzfRG7KVQXe2woltiDEP5TQWMSyP0kUGQf0yAbhAY3mO?=
 =?us-ascii?Q?ssOeegSmAJZvI8+2zDK2mN5RTKAcS5MVKva5QNRX55mWg1f+1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:24:13.9773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5473d8b4-ba3b-4044-12e0-08dcf34cd7a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

The EPP value being set in perf_ctrls.energy_perf is not being propagated
to the shared memory, fix that.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 576251e61ce0..bbeddce90823 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1616,8 +1616,9 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
 		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
+		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	}
 }
 
@@ -1658,8 +1659,9 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	} else {
 		perf_ctrls.desired_perf = 0;
 		perf_ctrls.max_perf = min_perf;
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
 		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
+		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	}
 	mutex_unlock(&amd_pstate_limits_lock);
 }
-- 
2.34.1



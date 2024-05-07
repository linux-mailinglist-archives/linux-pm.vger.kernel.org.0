Return-Path: <linux-pm+bounces-7562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F05B8BDC4C
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718701C20E50
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D367713D502;
	Tue,  7 May 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rKrCyx1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3F13D2B6;
	Tue,  7 May 2024 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066188; cv=fail; b=s2ORrjbblMItyMG15iqPv8+8soIntoAlhdhkVDgAIUaqnmb4xlySAwTzFXWXhq2Y6Zmt1r3M3w29Wy5ZkVmf6vLumRmUIY5MBuIiyrqwQ7Fc4Uy52iI2eJ9A8Oi6qTYcJ9ce3kT7NITHtEoILpumvymQHn92v2FTaJO96sFi40Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066188; c=relaxed/simple;
	bh=TLoxMH9aFz1cPLVUfCtE2k7PHi6e0ZHCGJ1DkwvgEKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIqiL7RQcqbQa7Jq0eR+q+1KIOC9q4QrPjRQarxLgLO0x1SVthYgS53nQtQi9ZwcLZV5EYnMX/goNAWBdVM7JM9oeK/AAu3+dF6iSUKLrxuXJWCUzawb95N44Yat0GfMrrM91HaGPaUiXuIMNWYltlUeFslG2PGr7M4yCIcv6RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rKrCyx1P; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX9F0n4VZEADgUIo2bO/ZV4hAuOLaCgY6k2shQUMR2uvAX7R0/NuqEVWXdkxs6k6BO5gc1P9Qb9+unZln3IaS7DCEjWkBRF8AB8pCr+7d1X0Jx4qxjIH/IC5cIUIYu47onJoPaJAQ1iAxxuhJ52nFxMlyTyINVOSAryYFQfust4WHna8Cru+DogdS0BmOXKDyjolk5ODt7fXk9nizFtXbM0eNAWbFoH4mSifE1eHWafNzUjrLJjORBdtK2yqS4CMbtt2vTfIOiq7AuL1OnYAEHjj4wb2xHiGKtND8s++/j2ugj2fyK3PqgbBCLW3RDR3KlYVLPCJmF0P16g0cJEJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMPx1cRg8UfwFMcg1y2QFi8lQuWs0j0a/OJAERN8rEc=;
 b=fvVIr5sPTQB78jAHarvgDWjCA0BmPUqDiHa/VNeqHH+AmvIJdTHnwaWtUtReBG662GqUfAXdCNUOHrCCrfFCjWz302zGYEIHRJ31/9A0n7uh6s1vwNeqJbf82lpcbMXREpFgyCqmtEcI2s9v+7Fh3Q3HEEBNMS92wb6iTxS6XAsXW0Pxy3hR9EXME4vvtRdwTrhjs/wGRAyeJRsQKE3/7Fz6Liqydpxd/QfvNlPwXsbroeRpa8fTIkP56ebXIR1slFy3uD7tuDcQ0nD5tQR7PUl5iMcfBR8fR8pFjn7LJDAUQ+HjbC9ljmiRmgKh1U3x6Z0VoHcfCJ5YK3EyhLMT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMPx1cRg8UfwFMcg1y2QFi8lQuWs0j0a/OJAERN8rEc=;
 b=rKrCyx1PfDcufmLgHivj2sYOGin5BYfPdZfb03/pT+ZN4zyFGXFW/U1bt8p/qHUsIi8czPS6XIxBxclqDpHvzt6s27RiEmCaaIAdxellN93j1oDCklhdWWuFcLFBpOlwmA7lzmL2tk/4iS+ZONbs/czPN338VCBJyPJocuFajKc=
Received: from DM6PR07CA0077.namprd07.prod.outlook.com (2603:10b6:5:337::10)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 07:16:23 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::9e) by DM6PR07CA0077.outlook.office365.com
 (2603:10b6:5:337::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 07:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:19 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] cpufreq: amd-pstate: fix the highest frequency issue which limit performance
Date: Tue, 7 May 2024 15:15:26 +0800
Message-ID: <c8feaf14acbe2e8288a5e8e927b8da479819bc71.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eec558-7428-4d0a-51b0-08dc6e6599c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmyP1hIfFpU92Q3YoXJhDyr/Q73DL1qv4L2uU/rM4g4w/aQa221kn0a8P3sj?=
 =?us-ascii?Q?uMZDIecH9MxoFhk4NK6G95Ds6WUZNqok8s+ks8FHR9sIkaVp/8/v3PyVwNBs?=
 =?us-ascii?Q?VooZiZujE/mqWGDdO8fIMsjaKKvvHvwTbcEQapt0WfLJKOyjm0lyYdZMimE3?=
 =?us-ascii?Q?Ep4C42PnxZ2luwYz6Jo4ZBisz1Z4XSv/01eBI8n6DAX7SiPzoOEADIo+SXdw?=
 =?us-ascii?Q?SUkD96mnD801xzEiMbnFCcpcN+qdZ7PjW5oPiDBWbnc2MvbOHUdPTubrG+3Z?=
 =?us-ascii?Q?T+i715c30N9s0Q9Qx9xjwO6qvQ+KCvwbasynmiMJh7n8csMuW/r96zHi4BVd?=
 =?us-ascii?Q?tohWxhiaTbAFEsv3RL2irwHfi/dtnuxR0c7/R2DbHCasfhYjOf8eK8DM6P3p?=
 =?us-ascii?Q?WSsV0dAXvw7vyTX+CQGdtug0xMnJzD4PhBBLpIBJJ0kNqzzotNb0ZfunRhIq?=
 =?us-ascii?Q?drBN0DBbdOBjllHBoMo7q5XjR/BwXCoe5J9wxFyTOBZmIDrT1F4U+bsRB7UC?=
 =?us-ascii?Q?mYDHyIDl+jMAg2B0IIis+KYpWk+zb/FmMEyJK1inV/W1TJShMnDWoiUz38NH?=
 =?us-ascii?Q?jMpN04f/eiBjMDiNuyJXkHtONY44xv+h8wx4zcBtoiHqf2pXXlZkv82nswtX?=
 =?us-ascii?Q?zA9QKCyDfwagqML5FgeyrUCx9PZvhNvQKPgjKcFPUjzBz3BDiFKHfGm6wulv?=
 =?us-ascii?Q?2pEzzMs2/Gpg7gy6yhEXqt35ddxtxnDVTu7cBoPZiHdVuRwfPjEWVVEoGRva?=
 =?us-ascii?Q?JJKNdwOH/ZkD5jBBANSKjR6VVMY0q2KbIokxgz1hSj/UGtJU8HOamfWNIXKH?=
 =?us-ascii?Q?rG93aBM4FTsIp+rMrGuMtA/Xz5Ze0VqRFidcnDW9EL0JXkGoo0pq8igcIT5E?=
 =?us-ascii?Q?ilrlWa7/zZAhzSXiJZkadPESGqoMCWksN+VgB3pauMoQWhsRMOES4agBR85Q?=
 =?us-ascii?Q?HpnBDA2o+QB8GGK1N+NwNP6zCk6gm0ssAtaC2YR6f1YqDFMxwZZ0iV9NT8UQ?=
 =?us-ascii?Q?RTjV5R1IU+Y7aI9B0F3I9RZgls/CGr49XOiVit1GLeNlNn0uaE8mB5p/kxSa?=
 =?us-ascii?Q?S+FENpL6C1Nn2mxxN26G22KyyMbFQhN29Sf1T0BtfWFTlEABGj0RhRkVgArb?=
 =?us-ascii?Q?wUzuLfm+MMMB4wJj1Zg/V1qUejx10yZMjg83ESwMOk/Yj2Tq3VRLOm01QVYu?=
 =?us-ascii?Q?B2HW6oIrVJCbTLiTSmBqa0/p/ePi05cvlMlFx9MplIiqgR6YinLGhbiux65W?=
 =?us-ascii?Q?RYszusUF4486FXsBXmLJnO2BGwApdwFGwHdGWttH9f2EafbH5EdIHnwRncR5?=
 =?us-ascii?Q?D+bXSkBSwonP/rWXJ3KYqLD6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:22.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eec558-7428-4d0a-51b0-08dc6e6599c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680

To address the performance drop issue, an optimization has been implemented.
The incorrect highest performance value previously set by the low-level power
firmware for AMD CPUs with Family ID 0x19 and Model ID ranging from 0x70 to 0x7F
series has been identified as the cause.

To resolve this, a check has been implemented to accurately determine the CPU family
and model ID. The correct highest performance value is now set and the performance
drop caused by the incorrect highest performance value are eliminated.

Before the fix, the highest frequency was set to 4200MHz, now it is set
to 4971MHz which is correct.

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
  3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7fe8a8fc6227..3ff381c4edf7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -348,6 +348,7 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
 {
 	u32 highest_perf;
 	int core_type;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
 	pr_debug("core_type %d found\n", core_type);
@@ -355,6 +356,13 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
 	switch (core_type) {
 	case CPU_CORE_TYPE_NO_HETERO_SUP:
 		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
+		/*
+		 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7F,
+		 * the highest performance level is set to 196.
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+		 */
+		if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7F))
+			highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
 		break;
 	case CPU_CORE_TYPE_PERFORMANCE:
 		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
-- 
2.34.1



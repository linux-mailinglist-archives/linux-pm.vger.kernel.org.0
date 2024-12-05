Return-Path: <linux-pm+bounces-18656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15E9E609A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2348916A808
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809820E701;
	Thu,  5 Dec 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GuktmeLP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DD1DF252;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437758; cv=fail; b=FTF465ylj30VCzuLfRy5hPn6QBItZIuz88bZWDk/yuEbrTEu/cTCueLrtIhi8bk3+69iMco9pmQK3/DIgiA3dZrLVCpRAiED6RIR+8kZFC4bQykdxp+jFSMsJvmV8dlTscxB8Yn8LFhxnLhZtNAqkq3w1EFbd1Av+Wksyw5BUW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437758; c=relaxed/simple;
	bh=KaMelWbW6vaUaLmlXDUf0uKfpVmfizPAWn3yCCjwLrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy0RL0CA142xpq7CULQ4Sp8qJv45IJdyxUyKApjmv2VJCacxbwYXOwIB5999myDLRgQg0xlKIizdsU/gSFfIhrpXqMWZWpCNlQukdXBYRJ9QS+lcene7ioDTHlJkFLWr1bfN9K23x/OMRhnaafPV6A8mSH0GHMMI/5le9lwcUv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GuktmeLP; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehPYbhBMIkjUgUt+NcJWJYFA4XSErSRbaMyUv3hHwq9sdD9FOyCKB9j25rwb8T8aH6/gFfBhqyk0U7z3cmmwyiaXLyLzsAwBXe5qhTdhcpBXtuZoSz5RYnYzGcgcwDsdYk/Fw41Zd2dlsHNiAuFbpveE/e+/gu4gveuY94r6QOKW/TfQB4qtYOlze1FXbXSmYv6gaMTN4OgM0UXCLvREJVy24d9LtjZIk1eWthQIEx9wcNks2WDuI5PmJpbAaodxf4YeBBOweKbLYYZ+0LAGUV/4kf3R55q0Pwp5PrGDy3sZOcBLykNaX+//PTKkPKrYT91qDzVMmiLQMk/awn2nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqip518PAer3B2jc0KWSK6pBvXS3+CthLaREB+k0N7g=;
 b=imakglgFR2ubEiknChUhQOibjQ9GM3vCOkF0Xt5+X1dyA/Ag1HQ+mO/Qur9ozCC2v8iO1lOlOJmVsJ1/GaoEDwaEP4deW4ig0j7mV05m1nqN8ofC/MEcAmg3BmHUbhOIqZL0D71nWMFXuX+E7V6RdAYRmdiYkPpIxsqk27+Y/ZOuh272W/T7QTR2l6+FN/RK0b0WMgnW9obSv4lVsWo5gGOL9TLzFbAlR29LudQtL7Czu3TQH7J34ehNiCDaitKjTcdaOsNgUZ9kSb8S+daRmzs4Yxmr8/UfxE2P7V+SGvqFymTRdyNYYDzS8VVW6eosgpCHrzyHz/6/yBY4+SuPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqip518PAer3B2jc0KWSK6pBvXS3+CthLaREB+k0N7g=;
 b=GuktmeLPfmXAhGBT94BYIKcJeWLkBm46u5OnMhB9zZ3KHLXJHdI9j4QLf/+iTzI9M2le49y39XE2LSzhKNZiNXE4XpP/mik13wG+FB84anPr5rFBSPGXnsDU+Fw/Zgzln+K+OQU56oasURbc8pbj3x4LGN+Qiqy2BpogQbV/1z8=
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 22:29:13 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::85) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 22:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:07 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 14/15] cpufreq/amd-pstate: Drop ret variable from amd_pstate_set_energy_pref_index()
Date: Thu, 5 Dec 2024 16:28:46 -0600
Message-ID: <20241205222847.7889-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c24f16d-0314-4b24-6fb7-08dd157c3ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8FqVJwsEe+Jg3vZNPLVPKsADXK5o8zK7TXe79Tm/O7JK6my3cBVLvbrahwd?=
 =?us-ascii?Q?3jbrbREVKMtUIrY5XR0JVCburanosiga6MXwnb1zG8cc7kuZYyw+5yDo9wAt?=
 =?us-ascii?Q?xrEmvkKJqzuLlqxwGjmo5/m3Vj7GOOjZHH1tqVVQ6CYpkS2BFn4DO4cxqcgm?=
 =?us-ascii?Q?k6tGgKqCAq8ieSOLNTXxudVf/NQ+7HwXz0SW0QAYcLKPyuE8h2fzDrrW28XX?=
 =?us-ascii?Q?vIDsNdtDlk3WGzOjvPBR9nmCzRq86Po9v40S2WVKh2+wBT4BwELFS4ESTyS8?=
 =?us-ascii?Q?J7JVReQ7lmrqmkwyQPZJv7YG8ZfTTsbsHemHmd3KGaoaM7N5fXmfdxglAoaz?=
 =?us-ascii?Q?6JKj91i6SJ72ScqcjcsZhEz3Y9+8/xQzD3vWTt23WGKb0ZWr1hEz4FqPOCI0?=
 =?us-ascii?Q?8W6CzEpQMfc8On2ObWwyTWQdLW4tvk6m3nrSXgPdVMmcPniUS1NjAFMV/37n?=
 =?us-ascii?Q?yogYji/pkIEoV2zpC3My+5jeIEVz0NvOMSc7F2Li5/7n2zmyDW2Enj2EnT9I?=
 =?us-ascii?Q?9tbhSw40gCjCvftUtORfhJYuC0sfebUEGV+hzSQHNEKLaEQZIIlrouhUPGMs?=
 =?us-ascii?Q?yhYd+w5Ni8LIobE7fJJzFj5j/lUYMtePL+uw7BRA2YQ9CU+zLRrjtS3aZI6d?=
 =?us-ascii?Q?BMD2yy37HkR1rzXhEGjdKPEwUBsS7vZq775duSYjamT1G/71/bFkP1QWVFcX?=
 =?us-ascii?Q?d6ZQGDM0odslRUUMXkGQMlcPdU1hHMvlfyqStf/zbqdgsCLOwlq1pDKEgJE2?=
 =?us-ascii?Q?rs5nIWlmSPD2W0bU1gAMOgEw6TK4coCgBn2JbgoZMhCAf5SZ1ljUAaBquiVT?=
 =?us-ascii?Q?l/68iK7y9WpC1abWidQrv0AsKeYrjFDWkCiRJHdCf4sJhezhClLjl39ypohx?=
 =?us-ascii?Q?ZCRvyzm+V9ZSkDfs2ktIlFBTRkye8FjGyFW7VA5o5T+Tx+oo1YPICTWLtzz/?=
 =?us-ascii?Q?Q2zgcPGaotE6KfIn6p9DIDVKITe3YCGntDb5YS/QvhQZSiBl8gRBB/yJnHjq?=
 =?us-ascii?Q?mgli8qDXYUzR9IHvjEUYzkFn5nlKva5zVOzrCzP5C6Sm+cIhGmEM02HUmScn?=
 =?us-ascii?Q?k/QKSa7dyfWZSC8yi4w3HKDC8OSi03TFcSCIrutAiWFS3eKiGl2ur0tW4/ej?=
 =?us-ascii?Q?Mo7Dz6oDCWuQx2Ttm6U/NUNW2oZ7EMzt52CQg14ItPj2ewTgjiwtHdodfLtH?=
 =?us-ascii?Q?j0+18BfsORQcfKB4hnWxfuOBSwQxIpDwnd/EbiHviFUNJ9IiOidGUSNlNcAB?=
 =?us-ascii?Q?CP3WRGRJOb4AHSmc4cA05H8rqc2Ez5t1bv9rgYSy3eBUyMin/GzY8pxImseP?=
 =?us-ascii?Q?riHx5Z6L56rmB2RZyK4BpTLP4+gDthvdII/oP+68T72U/8aRirYDsmINPMD3?=
 =?us-ascii?Q?gFQdU+w8T2mwNidKFb43Py3fqsrxS6stOYNN8fg+89KmAcIzlIQdv3ZacKf3?=
 =?us-ascii?Q?UfKdO6GTvIGMLUKEdEELrJ6zRHkcpyMB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:13.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c24f16d-0314-4b24-6fb7-08dd157c3ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

The ret variable is not necessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 06464e2dd905f..b361e691fd33e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -318,13 +318,11 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
 static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 		int pref_index)
 {
-	int epp = -EINVAL;
-	int ret;
+	int epp;
 
 	if (!pref_index)
 		epp = cpudata->epp_default;
-
-	if (epp == -EINVAL)
+	else
 		epp = epp_values[pref_index];
 
 	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
@@ -340,9 +338,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 					  cpudata->boost_state);
 	}
 
-	ret = amd_pstate_set_epp(cpudata, epp);
-
-	return ret;
+	return amd_pstate_set_epp(cpudata, epp);
 }
 
 static inline int msr_cppc_enable(bool enable)
-- 
2.43.0



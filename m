Return-Path: <linux-pm+bounces-18754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52489E83F8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5C188486A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CE153814;
	Sun,  8 Dec 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xWTspgu2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1914D2B9;
	Sun,  8 Dec 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639469; cv=fail; b=nI+mOVl2IFpvuOURTOAn7Kt8VBy2ivGdAB87j7GHy+eDgElmOG8QrnGnJGF1g9BtCSQsvi3XSgGzmay3s8dp3Kl8MYe/x0WuN/Y9JQe+0O3DyCRVfzFx7s17kXiRU/r65BeUeIYByN3BTF3dTbhvB2cNBU0/OtHxxrdbVB0ikZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639469; c=relaxed/simple;
	bh=vkKo/4s8AJHrxcMAdTwOpCYVCwosLIyVKxM6l/lgozY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR25jquQUmvF5lccy0yN6+Ho1Y0h/pI9UXs0lrZHbeVsKoyqgOfxV8D1ypUOzYRGHD1LN4zHCv0Xngz8Hqafr8kXLAfLzt2GhXAcmJCrNFCmZDXvEYT/gRdsMXWrnNoiBqtYrhN+FIJCe9XgKAfFjE499YJdVSUTb2HpC2nkGaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xWTspgu2; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPhSwuQivcYt3qfzEuHhKFVtxuJFW5R0w/av2hbmzqMaFOb3rQj0wgLRsUYh0FHopISVmIRjr4BMBYBtXV1WddI8SFs7BMDTtKyp2PyqYpfJcQVE6Sg7jmV+l2qtRLRBfkvCd35zXWdLBEmOpFShA0ootTvtE9X7w5cYAzHudm3+QWDjEnU4hqT0S6sxUSNnJwFUqDuFgFgnyzNvo8Frr9RVImS7puS57GUJtaJAvKZZgb9nPxcIqF9SbbV44WoXWXrMYymnGP+grbWFcaZfzpVVa7ChN8iO4ViAKLDYjWBpQUNIYk+GQExknmMZI4D9haUlAopbiuW6HxK06KAINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5ztNw0rCPyoFK32wG2ZAfAIj5nmgIIkK7w1Wa8CnbU=;
 b=GXcXr6T7JOoSzZVTPIouOcP+RNCJp6cFw1k2p0B9CjvRPJ48Zl+WZYfUMTStzclGoEyli7i8fXiEZMyJiC68XjeVTD1YrqUwO5PanmxaolQpbU3I9Fj/IHrRisrqCzzNq5T31xr4t3fcVeCijqYEzDBDz6miHMc1Q3sJPk4/WyjmyQi3c0lA4QxdrNsdUtgAa6g1u2KBvBHDa9YE3Qx4nR6emgTyF7G53zvAihrPIOcDgDpUiDlI9TWjrIku6FX+T4uVAhq1Z6jVsnBQtDBK+ZqrN4VADPtN6WOeu9S/i0jskcsJixsMexAeHg9s9vFswHJAI3dUgvLnEx53K4kx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5ztNw0rCPyoFK32wG2ZAfAIj5nmgIIkK7w1Wa8CnbU=;
 b=xWTspgu2zbmvbwYBS4wr/tEoVS5521B18amZ8LV3oeK7ON+yOo3ZMYHook8kyBHIuGtiKdsegHvpXhZ76brtNubGsGukv1dAzxKiHmYn4qNUR5y1VAO3bCYnNhP0/yAcWyoANeczp/I3uVJBHbkeWdnXpoUlKsp54HhMJ69qog4=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 06:31:03 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::fd) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:31:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Dhananjay Ugwekar
	<dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 14/16] cpufreq/amd-pstate: Drop ret variable from amd_pstate_set_energy_pref_index()
Date: Sun, 8 Dec 2024 00:30:29 -0600
Message-ID: <20241208063031.3113-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: d18da0c1-d7fe-41e3-e4bc-08dd1751e389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbReTEwngUE2gfH7v65sAU5Q+HxAxXpokHnALj+LWV+dAHZbvPiyrujTWu91?=
 =?us-ascii?Q?kwEI7kW48CT916WWJ+QGS3KnoAW2Q/enrqczMXl5jqhogaOhILLnJA9OjuhL?=
 =?us-ascii?Q?QW3oppp8s6NzfZ3buH5aRlxHBQh4reqUN834nN2k9Wzd5j6HZHJX5AtsV//7?=
 =?us-ascii?Q?Od9x0byXPn8CIm00XsxixrBS5EskHDcTQBDebiDcb/FqzhdYXvtkjtm/G9u4?=
 =?us-ascii?Q?bK2KQbS0Zx2AuLK8oBNvVqB+ht6WpYoPKxbEXCPSPSJ1M4sy/p12oocHzaWi?=
 =?us-ascii?Q?9BFe0B20H9DaMVFZ0vLzLU1aMFoE8O+ycVpfmtaNQGEuoeGVZdT/rgb+zdFR?=
 =?us-ascii?Q?6WjHLX8JUR4BkPmlemWlLB8Dp2lUDP6rqM5eXMxXoNt1+lIXTOh38FrQnI0b?=
 =?us-ascii?Q?c2aI/veyU5VwGLhFcrDVkxGDLn16d78BDRTgj8PpiZZRYiO/0643YaaE1cwu?=
 =?us-ascii?Q?i3FGwaX35MZTpKxpWYAiMxCDyn6I7NHM3v4xLhyAybOVJ9ZvOOdEbF4OVs6H?=
 =?us-ascii?Q?rAguEUBGyuW21+qerymMAmdsryV8JGbt79DR+RtU9ctPTxBwaLM7fUOWq/8p?=
 =?us-ascii?Q?8RDYhqQpY7eokNfZyV9k+9Onx9NaCyJwhq2QW1CRo6wQuzbFpEWoG/TAxJgp?=
 =?us-ascii?Q?UI9uM3xxRLk5+q73w84dcxuMjpCVUcMF7xR5LQ57LkWphrdLlnQSRjpJnapb?=
 =?us-ascii?Q?EU6F5sHPugzVvPLV/WcY5DdLMeZgkNYX/OM2x8w6+SngavBFpHTTEr2SBW0B?=
 =?us-ascii?Q?OkqOBf7w5DV0lGnHfpwv6zGNvYAJ6W3Tmp4e1HInVdgoU7IB8qlKYw8sbHk7?=
 =?us-ascii?Q?pgyhnHFPuLuUyXYVbjPgHqYw3eVnI29pvHaMh9Bwp6USEgKJqyEDUyJRaJLK?=
 =?us-ascii?Q?/IPObJQ3K4WA2ULU44Ut3eAFKMmcddtlBpIQJ/CiQGKoVk20qJ6tPqV+O0Du?=
 =?us-ascii?Q?A1VcrImxp89VdXrVSJ/h+eGAUdT1oDM8HDpAalFpRuU31Z+0obPGVkuT+uIZ?=
 =?us-ascii?Q?tZNDvhvd7qVHDMNnRqKFJ6r2c0ZChpniLaLCmAYfnVr2LbdxibNuGbYatttt?=
 =?us-ascii?Q?gr627GDSi7x0qKo5LAuZBUWWO1lNfrHpTpUZWm/8nHfKy8l1Ja2G4od4luUm?=
 =?us-ascii?Q?YQ6amV0t6mcq2BzFKtp+mE6oKFDlAFyE1ZIWjxBlkNzqBvrUjkWT7vcYKjll?=
 =?us-ascii?Q?qcd3K2ZYqgn4DBC5iuKSYhKVZ9BdKvMxUnfXTezURPLWaSOGAqu/VaqKI3FY?=
 =?us-ascii?Q?AlK4ubSf08IC/v5IgBpiOLrui7ZtwRtxKt5pXwwgVphh4td0pPNXNyEIhIKw?=
 =?us-ascii?Q?Y6eNWswhvkaJbz1yWxXMPvNvszKGHN73p4PyLzJAWiuXEL967CExC74Qydp4?=
 =?us-ascii?Q?fXSdlRl1Tp6wvkE/lnx9y1jGBdqbmGWJAPF+EIHAhWrmAc9BpuUCb70Su4S3?=
 =?us-ascii?Q?5VGXG3jlDolPfsod88TpQ3ZUbejs4Rd5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:03.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18da0c1-d7fe-41e3-e4bc-08dd1751e389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850

The ret variable is not necessary.

Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2178931fbf87b..5869bcd287e87 100644
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



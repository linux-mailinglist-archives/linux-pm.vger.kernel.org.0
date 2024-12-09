Return-Path: <linux-pm+bounces-18856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C049B9E9E6A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3981B282921
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276D179972;
	Mon,  9 Dec 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EdRAIwNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065231990AF;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770402; cv=fail; b=eub5WJptYdDnHXfDaaFYrJlr/gI+bUE49bvmmEi/AnYvzBB2g3XmrL0HgM8PXMugE4jhqFf6/zLKjzaH5AmMTa/BD/uJufqE8+x2ptKYiuwh2ZOBYItxzWuVAj1mQLki/OZdIJ55lp+bf78tjswxFLZEwl1CrK7sosaWqTm05iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770402; c=relaxed/simple;
	bh=ybB0OJdHG53wlbveZS9VyjLH/B5ZhWlwyr2BdU5u4Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdNIFDfQ5ZiXGrVyFzdlfyLTap5PNXkDfKzPz1O7DdTJh+yjqtzuR0+M/N2OoI8K8ObNJbfssGjZUXxRPPcGylClEyPkBtfrobTENduNI8/eMzAoWzTeHydSE0+iCII3p4saKqnAqJ6R9XQVsZAYbDPSgxtqHSmSRJGxnmA12GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EdRAIwNz; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSlww3nH1LBPhdGL3KjYvDSJZlJ76tiD1pq3roueFG2M7QtaNBYpaae/vAzjDWe4WdQWNkw7gcLfy9TUKHRMt+n5EfENwzFENCRWVrklGKi2WHKb/dZiHUPV1i/JODjwpsrNqb9uykDoDuY4la8jO8pY6RzSeP6OAL1cXhDrbxX/apD2QSAm90rG55+EoA0gifrClchAE8QvgJKxT6vgyOlDFLixxSWwfBtd1mQeD5YHToKsd4tWHexKQna0sFNHyLBlFwoVSBrCKIkWjztgrDdWVhbnsZkx5X8fVODpz5/LjiqWbQ2UeogzStz2iN5VdqG5imztWUK/6bSzxY0KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKQ7IfoAnp5cuGuPhZSM4V+qRH+o6cleG2QgsnaELyc=;
 b=OnhpUEA1gCHaMVw4Uss16Z3/Wn4fNv2vG6s4a6BAWX4Rsp6ed9VBECFFiq7H+r0mDAFnY98h31Xf1KtOT8+oOFXZORTrc4EOJm1sZMoY+Jj2C+mlEdbsBaCc75vJNqBcaaMYI5HbNWxcgOYBpe48GV9QOcWnXq2WMsU6gsQ+XaJ9vDG5+FHAeMxCejKjd5qFKWEnD6Ios0SdfZB0gc5gddS+GMxejkLW6wgLwMS5L9H/L3wlvUYPUCEr0oYpuWjya0Cz+MSQCltQJVq094AeBHVjZX3choEwXc9Xg9TJMljBbAiHlspQHPeBZmR2AdZRpBIvHM0OAjMHfI9DFLRQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKQ7IfoAnp5cuGuPhZSM4V+qRH+o6cleG2QgsnaELyc=;
 b=EdRAIwNzm7A8Is5TlDqd2+C50DGcW6BxZUkr3yt8OXZLE0d1FtvHdE9EyExOvzA6nV8PHoK4GgK6EyD1Ii6/HE6SbPZt3M/kL9JiqIwP2OKKIp0iVTIcPCZG/NBOhXuIlfQ3SZ7UHWzj0wvUvvOUaGDQ32GkQxKj/4jtVSaXcKQ=
Received: from CH5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610:1f0::9)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:16 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::12) by CH5PR05CA0004.outlook.office365.com
 (2603:10b6:610:1f0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Mon,
 9 Dec 2024 18:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Dhananjay Ugwekar
	<dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 13/15] cpufreq/amd-pstate: Drop ret variable from amd_pstate_set_energy_pref_index()
Date: Mon, 9 Dec 2024 12:52:46 -0600
Message-ID: <20241209185248.16301-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b1901e-c56d-489b-4c54-08dd1882bdcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmndC4mS7RcH9hE60Ov9gQad1jJG56WYdOJUJbEMks2T5VpiphgpsCG5ZztT?=
 =?us-ascii?Q?hJ1Eau450NjYohbOmbSLzWMn8TEqpK/8ER5Y1AlzWvcxVCeVbZ4cHeinao+I?=
 =?us-ascii?Q?gOwKtTZFUOFzC5dM2A2QmJoJpETSluJ5wCEBLoNrrTE36kjpKSCVuJKQyVsp?=
 =?us-ascii?Q?xS/wCP3YYLNxfoviSRck1QYQqD3sOMfGMRW+mTFBapF8rN25u+WlkJb6HRF0?=
 =?us-ascii?Q?Jv+p1ExOE7vNuyFmWYmoQM2FRpI25DO07u9Nl9OPYF5wLARpTTeK7FIb94Jr?=
 =?us-ascii?Q?7amZhquaqwZcYQyoiHnM/T/qFscg630c2cjuCpKJByYX9bpoi9NVsgA3HKwI?=
 =?us-ascii?Q?Nqxqd9wFwXq9Bt/4+4YOq1B9cS91EJk+GOb2clN5dVIJH32UAbJdsIg0N5tE?=
 =?us-ascii?Q?ywQax+guLfFpqoZG0ri+XLrqE0KW80rTN2GKEhLLEhRkBKmo8Gpr9zOvL2ap?=
 =?us-ascii?Q?eAH6WtCPdXpN1W6O4Y3dpmLZyCrQv2PhluRgU/+OxSvd5pcA98613E2N8vJG?=
 =?us-ascii?Q?xwzHtvxITz8n6EF3Dx7056N5e4tqrNtxnPpMa0bkrXvWA1M0nhS5WEcYnmkO?=
 =?us-ascii?Q?myuneSKrJI92pu5u9C5Hg6FyaRkLTx+mwQEtT8+szi1UP1FGukCzUeqsSsOe?=
 =?us-ascii?Q?5+F3HBWoyRam07se3Hb38FTFnGEYd1CKsQkWSdfoetPwdr/VmigeMWi69wbh?=
 =?us-ascii?Q?SwPjyGY2Msa21sO9d3D7ULJjOWclMDV+E5DGQQTxqk2u7LAFKEEg41Ue3rsQ?=
 =?us-ascii?Q?+tZuR0zWYKAXx3c0fm0My/ZiFOZohuLnRjmT9NgWRoqzEfg89cyGeIoGutq6?=
 =?us-ascii?Q?jzTcMumhzgJSSXhJXESM2j8NRyoofP23Y4y7nQk9Tp56vi+YUUeS7eBFvHhO?=
 =?us-ascii?Q?nhcS3mI7T0YeqAJhqVsiOOSVFosi/1njOvhifWfluTNzXZN8FCIWPO6urDSA?=
 =?us-ascii?Q?q+VJaou9slFSQvJnl7p/2Z8kMS8ctjt3Jb0zTC9goB/klUVhaYaVvrA/MDAk?=
 =?us-ascii?Q?pQUdur1f1ybnq1bIoEw72XG5V4Fulo2h14v6duvflYajeUneRPoimFML0ck9?=
 =?us-ascii?Q?bamB3UCJFEspWXdJPWAG5Q4dwU2YIFA3yiPEFvUBHWojfcIwVIJUxPzguave?=
 =?us-ascii?Q?lDoZbYqZ4uLpT1sNErv6vQpAModP0B/FZvEimXtZjKfMBy7mvOZy22t6onRi?=
 =?us-ascii?Q?BQOlM7Pksqhqp8L0BhiSf3Sw8K60LlxSL44R08yKk+XY/KZ0dUWT5pSIjamE?=
 =?us-ascii?Q?r8Lj6xfPoM/9LIivyvf34Lh8wRtL16AJ5R9rBLAC2sLFvh+Sim5MHfNS6WJO?=
 =?us-ascii?Q?q6Bh5uzq56Ql7LiiVctFgiKB/1JKnwefWSpO9LFJSQxz1muNAA16RUjiRPp0?=
 =?us-ascii?Q?Tfz9EwEeuFY75lZHGHcbiF8Q3hWwc5jW4BmfefPDSmj2x3KOv7fLGyTtCt80?=
 =?us-ascii?Q?1olnTBPth/zM6SGvifErNtUC4a8fjnIk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:16.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b1901e-c56d-489b-4c54-08dd1882bdcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

The ret variable is not necessary.

Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fc0eb268c0335..ead3a47570139 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -319,13 +319,11 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
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
@@ -341,9 +339,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
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



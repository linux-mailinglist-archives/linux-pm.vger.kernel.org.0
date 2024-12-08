Return-Path: <linux-pm+bounces-18749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF929E83EE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873642818BA
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABBD146D45;
	Sun,  8 Dec 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eolPT3aH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B513E02E;
	Sun,  8 Dec 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639464; cv=fail; b=U/WdzAHgrdV9nWQHdQ+SnpBmdW/PAPWZqynJpl9XMSwuiQTurARHRKaB640f3ppxtpypVAYxN5a6hXXeRRnPjzLCoyhWajsP2DBN1uoVd1PIjundGkP2wXQldFGxLRShArQrbvKoC3YkIHKYWAuSod6CZ9YCrnT26kAY0iZ8+b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639464; c=relaxed/simple;
	bh=8rrIrjCDFbNsIF6xmI6OBAOMh30oWMQvH3qh+qoEXk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpMdGaqvHZ5MiKJBVCoPMY6iVJv5iZ2mrRn7N99//s3CBc/BPRL93got/FKvVpKliz6lqN+iUa/H+Sv/HJlWZZ+ti3vf5Q9ZQ5sz6qSIfeVXo9V0StoAi2tXboq/iArwqC1w2Zakloh3mGwhYdBiNSHv6AMYDrMGe5ge+AChT4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eolPT3aH; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg+d+Z/0S6zbEvh857jUxE/R/+24fToR47hNVFmR9uEnRnBZ30dpm7QdtPXtuiabgRn5gehw0GIN+0WDCrNfhdd878Nn+S6Bp7S/j6W4hbyK4ookHeLmFbyzWMaC5nw4o7dfJKrOeJRwpc4yC+elmijQboiS/9d/oxxYBEHhAj63Ar+V59sVQ+zy/cjWtabzqzB60/Mu3jxRNrECZnsL9pv/lKYskkG167+OeMwtrjiryoOjsyz7Af8NkfN5mW+7u1NpQMFIVxlZrHQKis5zGtyi2mRTcN6uukRiMLX4fdgXzdh5jNoAlLoOuBGLXFWRe40MC/vdLS88fpl78Rb3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eroh5IEn3WgUrc3OYPL2JcIXey2+LfsFTzzdzmAMo+c=;
 b=k8VVH/PAt5van+7bypJTFjXZgW7dTywE62PvK/wIyi3p8kF3wgm+4fiB52Bjqi8WjC5rMiWBI19er56S20NXIW6oBP7A1fToTmTLcbXfOyQWxWpDh/n9bak7IlLQE+I5SdccWPIXy237A6rmAWu4lRbpToSsx905x2ZeZklOeYIJbXSK9tHrVBA03aoKK0wt6WnH/JgihHQG50+o8SQb/ShH2zh0ZneugnaAc8eov3XX6pE5cemRU4gP12qNI2lIaeNR6prx7b0JxdzLMLxSyyzUdgOjNOS/eST86wszXODL/DIR2LnmW/Q3tyDSx3WnzYPs0eXORUEbWH6IdstVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eroh5IEn3WgUrc3OYPL2JcIXey2+LfsFTzzdzmAMo+c=;
 b=eolPT3aH62bxW8LjaHTF6jgnXVDWfeRMND/dMj0yEnbU44MIihGHrFJ7NWl/3jxAYvapih1/HmKgC+3WDUajMJwAQCYaZX8M6M9a9wJkciBd4kRx6P3xHEbdF/rVUJE67rreVHFM1BrHkDqPIWRYYbta9h4kimx2576jGcY57JY=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.17; Sun, 8 Dec 2024 06:30:58 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::c9) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 07/16] cpufreq/amd-pstate: Only update the cached value in msr_set_epp() on success
Date: Sun, 8 Dec 2024 00:30:22 -0600
Message-ID: <20241208063031.3113-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e78c13-6e81-49f0-4535-08dd1751e05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vE6pUVhptpb+UgpfQ32GjWJN454eXYFXagD77Hbm9FUJEsUPwqQp7Kzj5MKq?=
 =?us-ascii?Q?7HAgR+ZsNY6ljolo114cGIg98WfhQ+ZNgJQ/V1mCDItbgVX8WRPJ2wqznOSG?=
 =?us-ascii?Q?y0C9fTUqaObCWkBoXlsf8co8DVsp6YuMUQkbh2wGLWr32kT33rYayEQImSwr?=
 =?us-ascii?Q?6k1Lh1g3v3W2/yoTnPQcEYCBlmgDaY3ior+o6fvd3aMHYkFFXKjUhTcGAhxG?=
 =?us-ascii?Q?f16nq++J0Tkhdb4NPfMR0t6q00GW8xJF8EnyHeH2ojf3fxbK01E596jc1uGz?=
 =?us-ascii?Q?hbTDDiQSztkvEZRcKCzb43GKu3jSeB1PJun6XiTwcvNhgdtScV3DnhMf/Bw3?=
 =?us-ascii?Q?+LVNJwVr5YsjkfzV3pLY7K18ERqRU+88W3+PQxLhFakmzCsoxMnA8duRoNTc?=
 =?us-ascii?Q?RO8YYH6C5Am12pU0JReiyyRE9rLrfxrfNafw6iYyfLB3Ov7hAt6tanuF8Mmv?=
 =?us-ascii?Q?5Lwq9bvrIIUidwELPz3ioDwDI4dFGtUa1JDvpmJK5Fwa1K/YdfcP0eATCvcD?=
 =?us-ascii?Q?W+hfgSL+6TeduFivjzcslhUbzJPhNJcF/VMa1xoYKeup0LkmUcVHGe4oATcf?=
 =?us-ascii?Q?WKO9hQjPcfpOzi8qWvN5JVlsU3QwWBalOq7tBgKHP/0tp8dMqgcpLM7HgnLP?=
 =?us-ascii?Q?AGrmav7zQJcFgFkvnIu8l77QzADTMuyE0GPfeddUEMO+3V2vAGXiw0bfpDjH?=
 =?us-ascii?Q?yqNHWxA1bYw3VloIZKZnQL6qKr6t6mu0rSILdTUUXz+eC1BCUtijEcztkYvX?=
 =?us-ascii?Q?mphELvbfcfIbgC+XgRYbhCAXaRDYeUrMSFRsi0FD1ETKBS3458mx7AYQaC5b?=
 =?us-ascii?Q?D4z3aZKQ/gS/1eIP87q35T6jDrrbbES4GWKXDyS1/DHENkg4WppLclOEeX4X?=
 =?us-ascii?Q?iCdq1eoGusSVaRSEJnp9QMo6erHuRiuFFliillYAHzwECH6zqRKPuiLQf64q?=
 =?us-ascii?Q?4Oahq2jeNv1jBohM4//4utJWeUjCznIub3X9wtHqVIMkditWK/LwP+YmW4h7?=
 =?us-ascii?Q?TRBWaKcfW9TXayct3aIaglrW1WJj6Ctz2QIbGljGTxVpxA6L2bC8suk6LwSM?=
 =?us-ascii?Q?HwEk5UQmYqVj74lgxZ5LOVI1iJFmwHjP3vSALUnxADj2fbkoyMjZNbS3d/EV?=
 =?us-ascii?Q?qLW8fMd/rXe5/sedMhfVPc1XpZL+i+bf731RyHeL+V4ol/ZurUmITaFdvVGe?=
 =?us-ascii?Q?WpHNCiKpx1FOBMr94ceYGmvHkrRvekwoAKPkDekBs2u/+pyWq+gtXCEw+236?=
 =?us-ascii?Q?7d5g8T0glmBqNwLn/JEzpTqWYkk0C+GfZLfEHt95HwktGuXwuzoMImh4HaFM?=
 =?us-ascii?Q?zGUyK8aw3QCDLRzG2MRWx7kZvWWNJrHHQCuol7gkmrsQG+QXyFaHHl3lhFBu?=
 =?us-ascii?Q?b3pMyKWJAUbIz5IwM89qecwdJVNrKOch4U/ZsEMoHXwjXwgixx++k4TgwoQg?=
 =?us-ascii?Q?jcccXiIzEWr33Np1ZMMI1FKqJxo4/U4w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:57.8889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e78c13-6e81-49f0-4535-08dd1751e05f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

If writing the MSR MSR_AMD_CPPC_REQ fails then the cached value in the
amd_cpudata structure should not be updated.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0ed04316a8d80..263acce2f4b0c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -278,11 +278,15 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	if (!ret)
-		cpudata->epp_cached = epp;
+	if (ret) {
+		pr_err("failed to set energy perf value (%d)\n", ret);
+		return ret;
+	}
+
+	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
 }
-- 
2.43.0



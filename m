Return-Path: <linux-pm+bounces-18660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740939E60A1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092F284E75
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3840211480;
	Thu,  5 Dec 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BeHSDjbE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90245202C25;
	Thu,  5 Dec 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437759; cv=fail; b=OP8qEJJRFg9vznxpU0jWCk0dexVwomDNHbOGlDGeWUchA5TaVHOUpsRRiE5Z9sH2/n9BvWgLuoRrTemAn3N2VjoJRERLjPYHNdYMYjHciGuO9zG13X3GJHJhN6UeZN0HHnZ8jSoNbzpEPXIQwDYxSmc8t09spmUKF1CYawQa0Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437759; c=relaxed/simple;
	bh=FeBJsbEXwJk7sZUSGfiSorVyg1THgjMczg8NBHJMjlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAeqc02La29LXha6PVdOMRe4K3N1pdahhAoctpVWUC40OLUSuzgu/oNsNAIi1Qua9fnmXpQ/cMFtk+yNiLBBSrTYjCUHJMBsh2SoZfPRz54/9xLTH+4qVh3mRBuuwUDZPzI3WSU6BPyuUqR/CUlGOl0pJYSlABMKwBkIdCaTypA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BeHSDjbE; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB5gXIOK4A85cGAyY4k7gJVZfHAdSciaRJkCNgUjbWxVlT5iPg31g6JVDBhBIsSMA9K3FoxB8p2g7u5aedQNRJS2ptAi6tiE+CGEosezMrsDTWdN80VRkBuNXeb5wKNuAX/A0ZeDIHaGDQOCvFY7MJq94iTOT20HPOyHqa7JILcvnPst/cIZPFONH9K1tzMFpJcQZZR5JwtyzyL7r8V09KRcw4cy7/qikLWKtAIJRbcmayg7obIxj8y1TCZCELYHsfr+Z1E0/AvG1Wp9sz3dTRj9hXkp29nrYHRRvomdhWHzXQbgKOO9ww/hYwcer+AQ9icwDGRdDTO1WpcSChpxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+ia0OX/G09377yBEw4BWVsjDfPXSjjaJK0puH1NgpM=;
 b=M8Tt/Y/4vnnuj1Wb6iW3rFf40ml4xH8kOdwBHYdIkiTaRqXZb0EY0YXUIQ1MuvhGQFAbfnUUt9QNwPRJqfGWhUqJ3dA+2G5SAHbAuqNxoER7zeEGRVr47gVgRN0oOEsX8Xcl3tIb6GovkfgLkbUJP5dHurbLmGml3aLee/sVhj88V6RWizrgM+WFiSTBvslsq0TYhYBzkpn97u5OHGXKJ1SyffHTn+APWxq4bv0pOdHUaLCM9Gk1FW3PbJOBGnLQFVXastG9eiWFkO+dQP+Isj7Q/u7xTTvUlrNgoaNCmshS3TVoG1TIZKu9MqxOglC3Xbcb3dm0Etf3+6Go9j3L4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+ia0OX/G09377yBEw4BWVsjDfPXSjjaJK0puH1NgpM=;
 b=BeHSDjbEAJ/V+X03+WSD3s3lg3pnpMPiuvrsMLC7pboZ0f5roHd8A7NKyvEoz75h68j7yU+vpZZmAtyOa/NSeenEsmbzWPhwHDP++j954/EUswXv4WWIhQkr5xES7EfPyODxmS8aiDZReSLjZK9y5lUGpx0eG7gLu1UhHoS7LD8=
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:13 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::94) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:13 +0000
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
	Mario Limonciello <mario.limonciello@amd.com>, "Artem S . Tashkinov"
	<aros@gmx.com>
Subject: [PATCH 15/15] cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen
Date: Thu, 5 Dec 2024 16:28:47 -0600
Message-ID: <20241205222847.7889-16-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 200e15fe-2277-49a3-93e6-08dd157c3f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z32Kn31Z4oA2HO9n440mKw3S7fs6TrY60vDGrgzkXNgrWCClzmrDBoPOFr7Y?=
 =?us-ascii?Q?3Au1UKQXru0U9QPhQwQebZUQvInp6u6kgTQFrMGs2KfeADOnUXI8ke4sduDw?=
 =?us-ascii?Q?mg0yTJHeDKatU4wZlweUUUt3RH5MvQxqxDWxgtKVPdbYpNkCk9TceE2SbuBg?=
 =?us-ascii?Q?Jh1BDQuWUHLhBjjgv72y+RHlBZbwF6nVARthEY5UFgeffb7Cb9JWIdwUk8yk?=
 =?us-ascii?Q?oKkIBOamYCfrC1/tZhLiruECsVi2UNXsPDz3PenSoSi51XZi5fVgZXHnqAaw?=
 =?us-ascii?Q?LED0QlGwAa/90G1hERgSRd9MCB6pnT2pP+Mk5uObryZwJxinos5lYz8xxszG?=
 =?us-ascii?Q?0fA6nOXTKrwZNPk8R/uUaDUIJh53R06+jpL06nalCwOJy1wUXvaNZV/aeEWQ?=
 =?us-ascii?Q?f4G1Ne2zoMdTeXmx2AXn6JVXDGJbbnDFbtTkcchsuFfRP9a1y8HRR4Ht1lh0?=
 =?us-ascii?Q?VzA9AntgCtv+S1DZ8udT0CND0yJNxkNP9qAQQWOUEWvnNWz2tx5PGVc+nH4m?=
 =?us-ascii?Q?lmomYp8P3pu/shBk9goeFs60VyIJUeQ7sqVCS2yYcl69pOI8vi1lF8/pRZZz?=
 =?us-ascii?Q?SsOKuTq3K3gWI1h5BgCvdovwwvEXdn8P+1oIdW+3bzWnbQ39Zsas58d7H+Hq?=
 =?us-ascii?Q?LLTO2aQLMu3eH9E6PHXNIcMbb7f0L1tXPse7nB+ZLnpvTuesH3j0NaqbqSSm?=
 =?us-ascii?Q?SU2jeyD8O5wCm7B8o+HXcxBtFNljZK+qnLAbWSB+u2NVwjs1L8ZLXoHrSI4C?=
 =?us-ascii?Q?rzZ8M3ZwJ4A0rtLfe2+WGHj8SVdkBXnh17K3FqRzuBrKlEpC59RhL4nkJq4J?=
 =?us-ascii?Q?z0xC7GaiZFSWsbrT7t84dWnPBb5BRpenn2gJkqWJivCEZrEEDFlJZdE+3Np9?=
 =?us-ascii?Q?DZJrTLLp8ggdS+1xn3zzYoYIcyJfwjDnpLQQB8+SNa4q6iO13xFrw7jhrkTl?=
 =?us-ascii?Q?mPXrNTKvEMkVfXldd2up8ArJ9pE8YgV9TSdRlgI4NQxOJMiUNyKG7JJQKcCp?=
 =?us-ascii?Q?Zk3zLENhxaQLfdB2yP2mL5Tz4Sv74j0uOEi+yR+TluHOnDWcRu0vq8UqepTF?=
 =?us-ascii?Q?uR+Feh7m2AH2zzOfiVf2D3p1uFT+PLPyCwulJDqcGudEsAk8JkRSj1O5m4l6?=
 =?us-ascii?Q?xaG4v5dWBk2P7wsbTfX8RVlOe1UImTg0h1cVBjfC0U69YjMgcs1IbnTa8gCX?=
 =?us-ascii?Q?+x+N6H1n7idOSeSOFGcbYUQ8tzSzBag0vlPYz1mk8GPEH4di5Ua9/omKQfWO?=
 =?us-ascii?Q?WZlu1PDdCYj9jACGo1Pb36JWskCo5yzDBzA82nsg/2BF2xo+H8rp+Vq+XQXQ?=
 =?us-ascii?Q?gDHxvELl1J0H/J9iWzRdq5sqxVM8x6DrAzHbAGFLnaWPdaZ39XJaUb/2cd9g?=
 =?us-ascii?Q?+PgUO2OYws1jpf8GCdh56T9jSqEn0ZovRY0tgbx3xbQXKe+6G2ZaGDLFwEvJ?=
 =?us-ascii?Q?nh5SPmsDCRO70FxJcIWg8tAc93Kv6nf+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:13.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e15fe-2277-49a3-93e6-08dd157c3f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

For Ryzen systems the EPP policy set by the BIOS is generally configured
to performance as this is the default register value for the CPPC request
MSR.

If a user doesn't use additional software to configure EPP then the system
will default biased towards performance and consume extra battery. Instead
configure the default to "balanced_performance" for this case.

Suggested-by: Artem S. Tashkinov <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219526
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b361e691fd33e..57775839a1c44 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1503,8 +1503,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
-
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 
@@ -1515,10 +1513,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	 * the default cpufreq governor is neither powersave nor performance.
 	 */
 	if (amd_pstate_acpi_pm_profile_server() ||
-	    amd_pstate_acpi_pm_profile_undefined())
+	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	else
+		cpudata->epp_default = amd_pstate_get_epp(cpudata);
+	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
@@ -1531,6 +1532,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
+	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	if (ret)
+		return ret;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.43.0



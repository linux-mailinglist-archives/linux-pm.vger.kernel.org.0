Return-Path: <linux-pm+bounces-10367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869689244E1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DAA1C222F7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3056F1BE23B;
	Tue,  2 Jul 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyIKz9c/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D539847;
	Tue,  2 Jul 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940549; cv=fail; b=XV/TROSUGEXt6Khc9OvDQ2ALxffm8CFhHvIUTFBAtaguoknMP9G6SXe6FO0d9YnecFgZzZN2PsCxsx4n9X092zyf3NN50PDVxNvZhh3LdcTrSp5KjbpuW1QSxYM/KqpK6wUUdWkjJC7wa7+34WdbvYUTHsDzvqrI29Yr+0Y87Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940549; c=relaxed/simple;
	bh=JSyctome7Q/ER7pvpY2HcB90c0i2zzjkO2W50rVd5sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+FKgsVxL4iL1l199X2XeeN5FCf+8N0y7Hix7uZlfIyRzGuBy4Ihj3wwTQFEUwyxqFaiS7ce/LV6WlWoSHCHNJVZyvlhfN1/3n8Yy1Xoa7661xriWGsw0P+g8nG2uAAQSQW65aa+1c+3zUShOGXz8hBhhRxSbBjpjdOmZdSP9r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyIKz9c/; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1YY6OHYusumjr3IjoXuqvcv7wgUT/gD8h47neGSosVWHfd+tiZ9o+YoaHkZI5l9K8galXxgFcScTIJhsXUs5zpfwiFCu2j/11X/sISebBqCnEEz2NIMMB8v/S4y/JZRgrE4GyywqTBM+ZABVlbOT9kCZZ0g/QLIe9H+QjGVCIPbznUABAvJItnjvVzmiQrA2wVnkugIOE6fwmxzxnTtK48NnbIS5l+SAaW1Pypfdb07Zw2Lky2eiTzoLfUrNxYNlG+mD8W7upSTKIbCX/zUMoI4khh3y67LuFdaLYXAkI27B8vKEv1fEtqxSC30Y7lPgJohRubQkgMJmhn8zwZa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akuk/IbNKF9jahPe0O5sO1uw4AsFWK+Z23BCbQlcMtk=;
 b=kK897d3UcVvuI1zJLIF+k63QkCC33HpVHx27FdbPjYc3snLsYdALU/Y2LW9h1NEVKNTFiHaqzYHcr4+q/XrK03l+Lt6bEQ0FAu1aUM7BvnykS9b6r0NaRRMvfiWwxD7HqYqCP5sXccb70GLCHEXPEy3k9EFdVVY3sMeohn9Mu1SvtEn/KMqHD3a7G7MCs+cgCvri+/1flROeMfGVIAzp7DZsSuH+QCkSLMlLo05lZBe8kiOXIy9soZoB8tJJ/7OgZYe5Nho4ZlaKOgxreFlfpiurHnze785hAE07MXBkRNZls5UGOguBFPE3K+Kf4BgWeTSSIqFWaE7Og7/mqisXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akuk/IbNKF9jahPe0O5sO1uw4AsFWK+Z23BCbQlcMtk=;
 b=QyIKz9c/OHAUMkoB42x6AzocdnW5xee1C9YP5UUKZvYUcssh+KZsn8/XDnJfAnXn7rCN+Zyc1ElGrr4ddR3zRJG8VVhGBQn1Ugq2kjWbrxkchx9iMFaNhGvHH3Kl4PG5OA3mJrOz4bul3ejy5PNv4VSWiKr+/M0ywrGFJthIAto=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 17:15:44 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::c4) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 17:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 17:15:42 +0000
Received: from AUS-HP-PV-STX4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 12:15:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Meng Li <li.meng@amd.com>, Perry Yuan <perry.yuan@amd.com>, "open list:AMD
 PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate-ut: Don't fail boost test case if CPB isn't supported
Date: Tue, 2 Jul 2024 12:15:15 -0500
Message-ID: <20240702171515.6780-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702171515.6780-1-mario.limonciello@amd.com>
References: <20240702171515.6780-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c66a99-b6fc-4b0a-6b1c-08dc9aba9a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Co23TOb0hXur0xCfurz9C5C1Ln1OXYG7v8MxVzru4yQrYJRHX4ENKEp1LkwX?=
 =?us-ascii?Q?/GrBb0KEWruiiX1IJye+j8Q6HRvwt9L6iLzAiroMVfu8KFWAow2mYutpkEFA?=
 =?us-ascii?Q?z140WcC6qJ/OAa7VyyfNeMamxTmuDqJIXNNBqC/FBPnrsidJa92eihUcYSHI?=
 =?us-ascii?Q?pWQKD61F04fFK5homZEsN5CL/SbS9A8JEOzcZ4hDH0y6eR4OChuXyH/OgsWk?=
 =?us-ascii?Q?/HjL9AEBHqOiwA5Dozb0f5cBb5rIc2M+L6YS5LELaYdQVY4hHoyhay/mZRzL?=
 =?us-ascii?Q?4PJQowJEoyOk9qTi6PnCfNhwvNzm4CZP87FoxZpB/XEpv8YgBwmI89Myej5p?=
 =?us-ascii?Q?RUFOrEej9gzAteWmsiT91nMpCCUJHIbaSvLSD0waQhiC8TXa8dV1jlVZ+rfo?=
 =?us-ascii?Q?vnxXmHVDzYGfC0TFprWKHdkY4z3HezMWTLS90zSB3Jv3cywUH2VFBpICzxRN?=
 =?us-ascii?Q?b8DpR4r84SjTmyEoLbe+vw50aDV4rrfJ8MOApu9166LclNjUJs8QiyC7VfWl?=
 =?us-ascii?Q?XfR+uMErHj2vhr3QfpzP/XqqdvQqDrn9IsPpLeLOAJxgOaedi9ndD5lHl/Ad?=
 =?us-ascii?Q?Pi01MCUL8xXxFRq+NcttuF8pfLRnBm4ob4Bjq8SwmPXjstx+pHfmWWar2iJL?=
 =?us-ascii?Q?sEEjUT7C4C5tqaVd1RdVRuY79LzGH4I/dmyrh+6KfK95ZS9OINmeLzDWHNRi?=
 =?us-ascii?Q?xXgE8GQyRXoqz9iF4S1W6pXro0NL5JyNKeB1W57wTVfue/khzNkeKb/QPSLA?=
 =?us-ascii?Q?wnGhOgK4fAdUDgZ07onbTEAzcJOUaDfuzfdMm5B2GbGiHvMgDoPpbfgtLZcK?=
 =?us-ascii?Q?OLcO1wwD51vrAI++k74SoCBjQwxTJ7BG9N39moGoeSFa3i5/bIdx3/UQm5re?=
 =?us-ascii?Q?/ofv0CGVhtkY6ju01SH8ob4BW3ttKh4r4KI0tVBBhRfghjEYH38luKm4X3r/?=
 =?us-ascii?Q?2habheYKb5WmqlNcAhPS5O/5NRYi+yB+5UMqeKftE48WZokUmIs/Q+xDpeI/?=
 =?us-ascii?Q?Y2P0FiGPW/O/L9puT1W5rpz9X4Tgg0bdqRzIjbruH6v/PLUy5QAgbtixploj?=
 =?us-ascii?Q?euSB1LUKSFGcfA79DBFzc3VCuJ0lg3f6qJ0Hx13G0BtZWGNtkp1Hhcibj4wn?=
 =?us-ascii?Q?/jqmqmlcIq1rvgcG0/ELRtYLvTORnwrJw2keJpsc6RF5tO4NumruNDNbBhDf?=
 =?us-ascii?Q?Kb3mHDSDxAMiDGFstkOkqXq9gnAeDopUn7E2p+KS5T2mFKJm2Jw0jZvja6VA?=
 =?us-ascii?Q?ux9O1S1QGZSpVrHggcsT4RDZbNOE4HGHa9g4UX0Me7xWTeOX55zDEso47Dqs?=
 =?us-ascii?Q?bYzC2lDf+/zwjuTxZVwYtFJAqzR4DSUzg1mke7kGzYoqFPad0pQPsSCi43I/?=
 =?us-ascii?Q?ic0O0KJTwjg4JMPMNY1pA4i2ZT0HbTvH1lR9uQUWbJiwTlFacqywWzOhVIS3?=
 =?us-ascii?Q?jhgByzbt5c0trAbc/UrYhc5MLsIgDCWH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:15:42.4377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c66a99-b6fc-4b0a-6b1c-08dc9aba9a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

cpudata->boost_supported will only be configured when a CPU actually
supports core performance boost. Add an extra guard into the check
to ensure it only runs when CPB is present.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index b7318669485e..b011c729fcba 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -232,21 +232,21 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
-			if ((policy->max == cpudata->max_freq) ||
-					(policy->max == nominal_freq_khz))
-				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-			else {
+		if (cpu_feature_enabled(X86_FEATURE_CPB)) {
+			if (!cpudata->boost_supported) {
+				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+				pr_err("%s cpu%d must support boost!\n", __func__, cpu);
+				goto skip_test;
+			}
+			if ((policy->max != cpudata->max_freq) &&
+			    (policy->max != nominal_freq_khz)) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, cpudata->max_freq,
 					nominal_freq_khz);
 				goto skip_test;
 			}
-		} else {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
-			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
-			goto skip_test;
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
 		}
 		cpufreq_cpu_put(policy);
 	}
-- 
2.43.0



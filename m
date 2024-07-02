Return-Path: <linux-pm+bounces-10317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEA91F0DE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AE41C21E8B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CD14B950;
	Tue,  2 Jul 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1wL3R+NT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544394CE09;
	Tue,  2 Jul 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908162; cv=fail; b=r5vbBw4K1KBessn0YAqhZ4ObIKNsK2QYHiiB5aXn8fEmEuI/ZY3x0UyTa+HEZEoSE0wwhfPnlL8yen9dGJaD0dyMPtGB+/a+XCrw+sOzB4ykLigUoa4H2iCl0RaXkJBbwTRI4kfJzAQ/h6l74sjkFvLvLQljFlO3pFCjZYCpY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908162; c=relaxed/simple;
	bh=H13dc82WW+Z7MKcMzb4ex0Rb0p7CFJq3+YkkDeneb8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTTL2Yz8iT/NJkc9f9dMWfHz8HjapoLWNoHAry4UKzUa+ks41+BVapC01gbZOd6c46CKcrY2yolHG0D/ttsS7hQs9SE6gMd3RG0HuhlIMpIPog+njsKb9OYcpWpaJdZeSus+KmpDS86MKq5ezVWb0+UsRWdPfW+bwrHXpmu3OxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1wL3R+NT; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw8OkHAaOZJOaHU+zz0umkK2TJvw70ZXLz/FYxEs3ZLdH1/wuvpeTEknPRPBf/KtLRmJfYLmtS2TA1a1gd/GPlCOMiD1Ba4on598yRUns31Q6C2OhInbqNDFAVKQ0BygGwh4G5wDn4hfZ8ITQczU+GpOSzZrIdw44FCA9QTRV547T+qP8h0kqd6wsC6rBgC/9IcfDxL/dbrZ8bCAA+1LTV4Q+qmAXlXQmhTfzNmf1H0iOwXu7PrHy+4xP4P0VB8xy0FhhhUimQ7FT98oD0bZm8QcOoUFk0M4Nz7mpmXVouqwdCGsd6L+UW/GQULTKckMTIMMki6pwN9OVtdcFD/Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CluJrTS3Uz6QUctPwbDYrbMSb+eD0U6x0grFTSEL2l8=;
 b=S+2Wsu95VGv6n9S9ttFgV+/UTgOV0sIZjtDxqdjOErvmQyx5oMu8Pnr2YjZATQrVJIyXd1U+jIx4U2moqgzFkfG8iOqtVEs84+4mrvHEGY88Ab4mMkNWnWiKosa5HaAVwY7TwLscqTamQG2D+oDdEQNUNpxSc4UKmiBrCifRWFjru39/CY8h53N5su2MxJT/eRGtlTpciBVLVPi9t9TfoZk7pvv9O7AOk1+JffFpObBbJhcp8mf5RUWwebdByL+gEiFDO0O9uzGbr5aVXP0KBm475XT+736W0oSfV4+ul3C3Nn7+1/eM6UQuh7/pzuiPROq8tO2thMPY8PnLr36oPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CluJrTS3Uz6QUctPwbDYrbMSb+eD0U6x0grFTSEL2l8=;
 b=1wL3R+NT4xiHT4wfL4SiKcosnCbCRDmePqr2dF78fc13AS/qfQsfxewmnmlf/oNrYkwtQ2g/3U1XISQgHH6pwrLstyqmitVBp248yk/8QUMIKRRnn/NVzbsta4u4h6KRyc2hJw/Ak9O2Wc3OIacm6u9tn97QXA/PFejNovpknPc=
Received: from CH2PR14CA0038.namprd14.prod.outlook.com (2603:10b6:610:56::18)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 08:15:58 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::82) by CH2PR14CA0038.outlook.office365.com
 (2603:10b6:610:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.35 via Frontend
 Transport; Tue, 2 Jul 2024 08:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 08:15:57 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 03:15:53 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, David Arcari <darcari@redhat.com>
Subject: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
Date: Tue, 2 Jul 2024 08:14:14 +0000
Message-ID: <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fdfff2-8eff-4271-d401-08dc9a6f339c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ywqJ0GGjaUNDfZj3aSAZ563SkVM+QsJXgmi/lZfL72MBGTYKMITvlxyzAkw?=
 =?us-ascii?Q?9A92uWyNFPHuribp7a6apdS+rLNrU1TyDX5685QJ2DKrq2gtXzyRGgVVK54u?=
 =?us-ascii?Q?FK9yVsYwcJ+EvtQ2NNsiBq2zYVsFnZ5qiAeUGEtEz1eAqD69C4AJP2WX5gmT?=
 =?us-ascii?Q?PC0p5XHIaYcQ7YbWSU9sD8uR1gfBHIsopw4IPW4Cuw4/06HZX+ARi7H1pHv1?=
 =?us-ascii?Q?Y8FPQdT+6bqH40QtAor2MoaaFq5r3gIuTqK9BpKDSJYhQAXvuCszT8XZldTF?=
 =?us-ascii?Q?XfkuOYINEysWnJBj+oxNGfoMM9DgIOB5jka8GpgEbZC5ES9bigrdp70JEgG8?=
 =?us-ascii?Q?Kj+fwfyBjsKrx21L398fhOCEpqM/DJDSU/5mfUNXO9hf27L9+Fz8U+Vkot4x?=
 =?us-ascii?Q?hnQkcpIesOsB1b/1heCXRvGEnlDPYJJ0d1cmMCdi1LGwurbTG1SOzPkkIXNi?=
 =?us-ascii?Q?Tpzm83QfP6UMPJ8BYynlc2zzuMHRaWxM09+SwezNyhVZAwvx3LBpS8Z9D6UF?=
 =?us-ascii?Q?zJRO2BNlAKsxFYtGxeq7kGymNMs+qxbMtMsp8EXdveeiEUdvvEHHhx2AGKe8?=
 =?us-ascii?Q?LThARibDNkN5j+CUrVHFZNeeJOVJkohKYdcLKJiAzP6SOc0VtF1bSE0ARz/T?=
 =?us-ascii?Q?GjaymEzUzV6F8DsTI0punr37cTnKj58uQhMxZtdFmu9bgwQuhw0pEm6kovoB?=
 =?us-ascii?Q?dp7njtv6CaaqjYkttISLdU9K1U3kxEHm21xmJpAH1G1imm184/RaArKcJeZJ?=
 =?us-ascii?Q?etKBgreoQ1C7UryLlxWj6zEV9r8tkZVHLvcuKb3YmTDET9XM9Phtjv/un5/K?=
 =?us-ascii?Q?e49ti0jZt0SGDwHJHlAyE8kkpPahanoVudGgxlm05w53qJVCU2DMLi7B3ZXU?=
 =?us-ascii?Q?J9IYsVayeCP+NyhDsie0tlpE9wx5IXyiHF/OA0480bUkbzYXqBhIvLU3tkw3?=
 =?us-ascii?Q?3Pjo0cRaSWMTEW1ESrsmcBy+MdLtm2MLkOtayrdlyUSMHohRe6aMqjdLajTn?=
 =?us-ascii?Q?NwdaQmWeTOsiDDVZbEF00wkp2Yj3UvUtGkBjAxnwtIubO6ETnva/6R6QpQxn?=
 =?us-ascii?Q?lXVp0Y7H6agnVJKMwK7KbqdX7fT5RqCeXuauUR3Pzpy1H/6IvKKEEUXzcbry?=
 =?us-ascii?Q?mtI809FIJSUmcNXK/UKbBPPr9gKNPP+XtCWg0oR7lwqxwmRSA8RKr+iOxgoi?=
 =?us-ascii?Q?xPg/sdDE/BpiPPvg+G2jOBnd5PUvvx/kcJ8XPzA/kvI6GrtYfR5kqo4HlFOv?=
 =?us-ascii?Q?HaJ6yisGnZeYeHYR9gchk6kIVnXUvtJk6SUrZ041n5zWcEn23w1gyfrVC81R?=
 =?us-ascii?Q?0j5unq2Q4vqAii7K1BSLVCQRRSSPrHZt/ruPxrwbvAfCMyk7iGS7qwGlx/YK?=
 =?us-ascii?Q?KmafBA/VQg2apy9OmxEVgTOvpiXCp1HVDu4pNlD3ce6R+FCVQu09bptxMxNH?=
 =?us-ascii?Q?owod19WNiBNQrd3fMxviZWmA5GuvoO5z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:15:57.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fdfff2-8eff-4271-d401-08dc9a6f339c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

On shared memory CPPC systems, with amd_pstate=active mode, the change
in scaling_max_freq doesn't get written to the shared memory
region. Due to this, the writes to the scaling_max_freq sysfs file
don't take effect. Fix this by propagating the scaling_max_freq
changes to the shared memory region.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Reported-by: David Arcari <darcari@redhat.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ad62dbe8bfb..a092b13ffbc2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -247,6 +247,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
 	return index;
 }
 
+static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			       u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+	else
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			      READ_ONCE(cpudata->cppc_req_cached));
+}
+
+DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+
+static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+					  u32 min_perf, u32 des_perf,
+					  u32 max_perf, bool fast_switch)
+{
+	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+					    max_perf, fast_switch);
+}
+
 static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
 	int ret;
@@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 		if (!ret)
 			cpudata->epp_cached = epp;
 	} else {
+		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+					     cpudata->max_limit_perf, false);
+
 		perf_ctrls.energy_perf = epp;
 		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 		if (ret) {
@@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			       u32 des_perf, u32 max_perf, bool fast_switch)
-{
-	if (fast_switch)
-		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
-	else
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			      READ_ONCE(cpudata->cppc_req_cached));
-}
-
 static void cppc_update_perf(struct amd_cpudata *cpudata,
 			     u32 min_perf, u32 des_perf,
 			     u32 max_perf, bool fast_switch)
@@ -475,16 +488,6 @@ static void cppc_update_perf(struct amd_cpudata *cpudata,
 	cppc_set_perf(cpudata->cpu, &perf_ctrls);
 }
 
-DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
-
-static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
-					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, bool fast_switch)
-{
-	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-					    max_perf, fast_switch);
-}
-
 static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 {
 	u64 aperf, mperf, tsc;
-- 
2.34.1



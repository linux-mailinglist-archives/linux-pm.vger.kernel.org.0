Return-Path: <linux-pm+bounces-7624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147868BF5B8
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4806BB2401C
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE717557;
	Wed,  8 May 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVEqE/sk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465521758E;
	Wed,  8 May 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147254; cv=fail; b=T88faf61vtp/1DGzD/0UpscASnh04wzN/g3506ndtk7NXrYjqbgWxR+S+GBwHONSOZe8N3U1bpKcG0QwABF1eLNqtdfU6OMSVr0lki80aNHjYFmBUz9kGjfT/VEPQpRLs1hDww5+e7PIRnlxgwU2jq5x11OzgWjiyjwCPdSSzmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147254; c=relaxed/simple;
	bh=lPGRnsawY9E9gPH6BROgU5TVvLcUAsQhwSekPioRTOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMAfPcf5IYh93DCkG7sh9Jx5s/4LmNkPx4T+GjpI/TR/2C9KqsnAc01RQ2tO7hRcLBkS3MJBYO5EBaFazD5FPMDWIEwfBo6mM4uyf+GyWiP69pORswbSKp9s6fUEfCmqAXcExD47Yg7CrhfJlxUi3IVkeaJ5yyvBql22ynjek2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVEqE/sk; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVm1xNrPmbSBenCWjJUdvtowgM4vGuN5H4zFe91Lt2AGt903VyAKcuGwrU5wsrjxq3cfPTh3xpoRcp3WTMOdZc1z34huAzT6MnKnLY5/HUUitztNFUNJ0h+Mjbj/C1ZCI2tvwRyMbFPoaU+MHKDYoAsXxulLrMHUfVnErjwfrASgi4DxqYHKgQAqPQ0uVQGcuuZjZxMOQUxMRVqFeCtiTcWg05apPRsyeh7uX6ufhXNb2Mmd3pgtU0iTX7zY6lQOUiMkxTpagWeLSiY0TiPECEimGVL2CY1s1BaWMmgPR9jk9ywmuXHoerMD7/7C+z/x6c4CKCWyh1j5yi9IjYHNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgYjpO3GWH30dQp4sbqnn3AgduwFrMxEqM+n7Jt30+A=;
 b=Mu/ZJrW+i1/rDXEJ5kcyHf1DR8L0djhdnw2R2tKOSAncw/WGJ3eCB572PXtSYh6HP/JuO96DkuVhj7VmXG/KT/S2ZD/WtdUBdffEQyRuQD11aWtB7wdCWNiYwmcok23ej47Qq7cvpuEyBL70Hc0WCs98/oXdzqjkHNiduuUg7ar2Bv6+ZCeTvT5XuL7KUHykZe+D7RE/RBqgmRJ3RRAledCvJHqgHi5D7klm8/JBOaEDfkVEHzS8QzRrSbZpRLQIfI0t2jiHjfTTMwUXvujkuFm6gh3vmW/XVfYuqb9Tvzj8Tnx7fbVcerXQzGvAsvSa0alHV92kk2KWZHALMhUewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgYjpO3GWH30dQp4sbqnn3AgduwFrMxEqM+n7Jt30+A=;
 b=jVEqE/skmADw+E+w9KjMDAMuW7fxpPhD5rqxoPl/s3qwL+6w1flZClOvhsu/NjamulDV1gPXr/qUxl1Jz2QlLtII6bR3ZHif9m7vXTMMTnu92gxWt7qWlyAst7Q3pp+R3QwDLfhAGacaShWdsOUvaMwft/xOii/S2qLiu63DSO0=
Received: from CH2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:20::21)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 05:47:27 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::a8) by CH2PR07CA0008.outlook.office365.com
 (2603:10b6:610:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 8 May 2024 05:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:47:26 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 00:47:23 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue which limit performance
Date: Wed, 8 May 2024 13:47:03 +0800
Message-ID: <20240508054703.3728337-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5215b864-01de-43dd-8324-08dc6f2257a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cy+3ZDnvAIpgUqdNOFuUBldXgW4PS6xJzSe7bQbfcNrmDpxsO69vLK+iA3oc?=
 =?us-ascii?Q?nee3fG8AxyQbXaNvqpEwqVSdYvrpntDpT8O9UXPyzcpM3KCk6r9G/f16SudP?=
 =?us-ascii?Q?RFZyjIHyINEey+TZldo6T3qxhar2Ai32oTAHMyyfPzPUouiv/PYFB75iqHxV?=
 =?us-ascii?Q?hUavPO95egjrYy6/plRb27DtKNgw9d2wHrA3sU06KyuehzAhzWRxknE3G8GL?=
 =?us-ascii?Q?UHhZDXJaiXfiq2Unr/SqKVT6KXoa7sBlqVgmZUU32GIWPMsxQMV/0ZVOX/LR?=
 =?us-ascii?Q?Z4l9OtZlFTnx/hxcmDEJ8hBVdrywIC2y5XMeJbuJTSB9OXfXaGtkpuM6shEh?=
 =?us-ascii?Q?/mTFXUoQHlpxyisSi5RYqy1vk+MuK0dIS2BxJFA3VrH5BRNjWQvvTzG9lHPL?=
 =?us-ascii?Q?WFsUzLfw/407JAMjHdbK9+MD5EHhuCS8UA29Yh8+eL0whCGupNHQL0XjYwYj?=
 =?us-ascii?Q?zs4aGgxaYfESzXp/x9lxgAxzBenah2zqGkRhQ6k16IaADnKv1IwBpWcNjGdV?=
 =?us-ascii?Q?O3KIOpxapa+FhVF2XmASYJu8jb4u6SzJtTPtv89ah7Zh6mQBqDqrRgm2XHxp?=
 =?us-ascii?Q?BjaP0+yXFsVd7+V4LgZrJQ4OeW9TXGrcFRKgKQYaaN1f5gAu8BAOEmpx8uJn?=
 =?us-ascii?Q?RMiDmTzvkyYC+WitSNfDjVca9NPDK/9BIy2R4+WOMFT3ss+LIfmcPfR/LTL/?=
 =?us-ascii?Q?NLbKvJxOA0lMLdvkFrkKI3YsagKo/+YxuIZsgWxjpsDEPzPFSKIwpVXiTHAO?=
 =?us-ascii?Q?BuO9WQRn8gKin43aEqCai1+Pctcdj0B+IWe8GZHce4jE3kBpBy4iPlBy6TNM?=
 =?us-ascii?Q?1wXLSYVyfgaNi3myQiZJjINmTnndo0J6v62qXN+FTWz00S7p5QNUg+3apev+?=
 =?us-ascii?Q?KHfDyK3AflugFBU0/Lsk6Bep0+ItNk1D9YxkRMt7VJ4kzThd0AlLuICp70E+?=
 =?us-ascii?Q?IFxEFltrRL9tuKyg+H7TMpQq7xrgnafGx0sHt+N6c18rHVhXwTRS77XCCPS+?=
 =?us-ascii?Q?EyCcN+MH5bUlbujwtRDAelc79AWl+p5RvnmBsZNy987RQBn/h9WMkdoL8/IT?=
 =?us-ascii?Q?mSf+RBp1a4YFLWWR3KLhfT60IPAl42cLMgdKfshboEwzDLTPAH80v/KL18NW?=
 =?us-ascii?Q?VCH8XIPBqlNYJB3ijN7jdNAPehf/GTQ1OmG5erCi+z/rwMYdoYZGU9xtQ7vB?=
 =?us-ascii?Q?LeVbwZOfqnR/UyRes5YeSRR2Ev6FpU0maSS9w8WdFaT19JhRsaUmpkFU3NxZ?=
 =?us-ascii?Q?cUEnahibU3eTSMIvLKsaeeTnBw7xwaVW+F/OQX4a6wCs7JEMHkhKpiomo0BC?=
 =?us-ascii?Q?4mwXcoEZ/u1VsApqNMTLUbER?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:47:26.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5215b864-01de-43dd-8324-08dc6f2257a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

To address the performance drop issue, an optimization has been
implemented. The incorrect highest performance value previously set by the
low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
ranging from 0x70 to 0x7F series has been identified as the cause.

To resolve this, a check has been implemented to accurately determine the
CPU family and model ID. The correct highest performance value is now set
and the performance drop caused by the incorrect highest performance value
are eliminated.

Before the fix, the highest frequency was set to 4200MHz, now it is set
to 4971MHz which is correct.

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
  3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000

v1->v2:
 * add test by flag from Gaha Bana

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Gaha Bana <gahabana@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2db095867d03..6a342b0c0140 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,7 +50,8 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define AMD_PSTATE_PREFCORE_THRESHOLD	166
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
+#define CPPC_HIGHEST_PERF_DEFAULT	166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -326,6 +327,21 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
+static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	/*
+	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
+	 * the highest performance level is set to 196.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+	 */
+	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
+		return CPPC_HIGHEST_PERF_PERFORMANCE;
+
+	return CPPC_HIGHEST_PERF_DEFAULT;
+}
+
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
@@ -342,7 +358,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	 * the default max perf.
 	 */
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
@@ -366,7 +382,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = cppc_perf.highest_perf;
 
-- 
2.34.1



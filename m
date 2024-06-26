Return-Path: <linux-pm+bounces-9999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43891773D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CA41C22780
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8313F42D;
	Wed, 26 Jun 2024 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QqKGjISo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4F13B28A;
	Wed, 26 Jun 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375708; cv=fail; b=kzG7TtJO92E1QRhHvyMfsHowf8jDBFYFs9whzWQJkx6oOLfmYO6VtyW5vojEtpgHhhFZ8KMcsPt+nC8Yu6/6EdhjAdQ+AbI1AJctx5ClgRtVGZsb/LgSMzbLrb1UkuNnLDb1/W5yGPFHFj/vwZbsnooto7NghmAQ1B0pZTU/gUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375708; c=relaxed/simple;
	bh=agYvsN2KUfDKuWm73gCHWynyQf/M119G28sFd85Dfws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQr4PkPBAjiPsHA+Ki3DECCPt+QipFf5KQ6NIzPj58W2TgV8fxombIZn7aZeZ7A14rkiNE46WVZqCUxkOPUnaaB52hZ1GAywLXYnjyqo/HDJY4iG6RJDbO8ovTaPp+20BRLPrY1Yir4xpcMO1OazlBqpmB9Am4tjFW2+AMN5ZcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QqKGjISo; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljNw3uyOQlYK91aUQoP5hJ92H+xIN039X+43FOBQjCY+XKbDAIhx/OskjqnUb6ZJZs4koBedquEKUR8dszQWznrbvfJosDW2tzjeVsKn0g4Y56H4EcXeCD8Ch4mLoaQmQP8xIYBU158pd675G3cEIHHL3ZAJJZoU4yMzU0vb43okQDHNoMNulmo3FVHl+DlVCT53tv7wG0c7FudxryYbwsGAZ1k6XUTtDyi6w1Hnokqqid7VoRmb1j+MWDYIWgtKM2z0k5omB3wovsgAtrFnRhtOhpjwTMzoqAE9wa8D4FQuy/ApKOkH7xdX8HFqPU8+Du5NT1wcOUi5Z4jSi+OuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j59IYbrIBn8o5Myze9Rvn6I5GfahjsKZEHdIDCYQPQg=;
 b=LwB9nYLP+KoqAFAexGhQwGWNMgOhZUj0Xt9QidOz1NLbrGiGBjehdoz+IvUvyTt5J+3tLvutlnQhPLutXfsqwH/K4dnx+ZGJAchdUeEkSGGjA8TGU7CWmCoq9ET6kGOQthXnlqwQhmNBO5aGMhQ21tTrhJi81VoJwefOtnyxkAgRlusijBNkaeOzUOUFZLCi0R5e2aAW0GvEy/lgLyfWgBi6jfbZ/ytFE352o0oIrADGxeEW04qrPC0S8ZHdvPVCI5vvFTr+D96Xs+QTdyi67TKInZij/WThqubymrWiH7vJckKKzpfdP+idGiF7XQ0gIeAg07jR4N9dLYBQXO2cAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j59IYbrIBn8o5Myze9Rvn6I5GfahjsKZEHdIDCYQPQg=;
 b=QqKGjISovdPB0rEdEjq9/1OobGHw3uKrg3qCG+JKn9eS5gbypZcm1pYbzlbj/eiw1CnbWLIKyfgjR4Nevguq61H6y+l+tG2DT8233D3GkJvvodjvem+EVp53CajLzcoU1QQSpoNe0Wcdod9q2hNPVPmDQpNRVZd8l17nZMQTSb8=
Received: from SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::25)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:21:43 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::4) by SA1P222CA0155.outlook.office365.com
 (2603:10b6:806:3c3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.39 via Frontend
 Transport; Wed, 26 Jun 2024 04:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:21:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:21:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nikolay Borisov <nik.borisov@suse.com>, Peter
 Zijlstra <peterz@infradead.org>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to lookup perf values
Date: Tue, 25 Jun 2024 23:20:43 -0500
Message-ID: <20240626042043.2410-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626042043.2410-1-mario.limonciello@amd.com>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 740c99dc-6506-4356-ca81-08dc95977c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|376012|7416012|1800799022|36860700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqeRS90STQ4gYinCDtiia5tQI8FY/37vY8zcmK/sAC5pP/VPfTPFs94p4Eqh?=
 =?us-ascii?Q?OOL0WEzy3Pg9Is0keLg+ruJCpPCttnbIirC7xkC7lLt7rbAAWFktcQcTxfq/?=
 =?us-ascii?Q?nZ1sPAMIrsJZBNfnqOVaiCwLkgTtXwMUGyq/iYvc7EIdjsLVaSB9PIdhsOnD?=
 =?us-ascii?Q?kiFDUcdAys7R1BYDKoIQrGrO3n/jjxJfqpZp8G7on+yXCMhYAwZnQwYzltgK?=
 =?us-ascii?Q?Bbeb66G7hg8Zue2TBJ3dJKDVb5UYdoxZfcvou+fqYcy8qyF2ZkUUg7idFSaM?=
 =?us-ascii?Q?lH+Y+r/bg+eOAX61Bqce8GVq3eHS/ZDXmWVOsbeZTl6UtYqI/w88ShyQX7JS?=
 =?us-ascii?Q?Oqut4bPs5YAcU4lzSrab4aOsip1ZZOh+vruPWDewuFTa94HHuTjf+Ju/vCmG?=
 =?us-ascii?Q?yN8VHKQcP5m74H5CMZkSTA9/dQVWKK9cDFSXAFCd3rBDr+p+VwxREMQXJ/AZ?=
 =?us-ascii?Q?fMWdTJv6DDOos5wJHMdRhnUacGgvbzW1muLej+O08YyUEPyCPo1bvHaOsNkJ?=
 =?us-ascii?Q?1VQpdR7FYOzES84VSEJXiecSRImnov/VY60Jg47PbcM5Xs7HoEZkyY1zkBEm?=
 =?us-ascii?Q?g17QQowH9d6YFxxAFFOft1kJvz7qEJOXYXUA+ZFjYR3xyLhXW9TACIdxKyka?=
 =?us-ascii?Q?NYqB2Ub2WePlfkQGq8r2x4nOnTcd3L1/fFAWmgVcytUkujR9j4gnZn7L3s7p?=
 =?us-ascii?Q?bikl+AC60UA/KFJZ+PnT+kvHu/pEBr9G0pzJ6SeVWZnNYxd6lSnSqtlZFVYo?=
 =?us-ascii?Q?LDbAqEriYU3B6WkULEjXt6uIpD9YA1U/bsk9xoG/Q1BFmY5pUL9bi5/Kyi6l?=
 =?us-ascii?Q?Qz8dkQVX3Kb4OBw6mE9fU7kew8xNC3KFgDUxI63BW9y1YuBrAyq/aoeBRxYf?=
 =?us-ascii?Q?G6SQrPDLSlhvoDti2cYcf4tndfm83B5vo8UZx1F2S2EFDTAWe3VMCHq2ZnB3?=
 =?us-ascii?Q?oG9TQrwKEgs+3YdybpTrh0ZNf/hYzpTgpBBBYKjSVCvGbtf+gUHo+DxN5nT0?=
 =?us-ascii?Q?QfBz6hFcHBTrdhi7s6m75UJdMF5a+bRg4mdK25oq9QlgbV6zxJeA2egLbK1j?=
 =?us-ascii?Q?hwVpJ1yD3t3E1szyoqAUVzCVeCmZFXC9dQhylZ9aEyIW4nIUSTpf8BtxxXYd?=
 =?us-ascii?Q?8Vsyi6LVqaDsS9CKULee3XEPTLTNMV9bdFM3DoyC5lHvzSQHUZ33jx8nnGMs?=
 =?us-ascii?Q?LqiX06VFaNzUVXzX5tadRqDI1zCRZzDXLUSB97DYAeTvnGIEIEWo0yhs2zvj?=
 =?us-ascii?Q?zP/4RCZ9EnKG/bFrJ34lJk7hkbUnX058facU+IkxiItfpK+I4R/IJpf6W/10?=
 =?us-ascii?Q?Iw/RQbgO5gB4+UnKZM2b0Scck/R/M1NS5hZnuqmfm+eoHIohIWyiXziLAvDP?=
 =?us-ascii?Q?7mjBPIc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(82310400024)(376012)(7416012)(1800799022)(36860700011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:21:43.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740c99dc-6506-4356-ca81-08dc95977c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

To keep consistency with amd-pstate and acpi-cpufreq behavior, use
amd_get_highest_perf() to find the highest perf value for a given
platform.

This fixes the exact same problem as commit bf202e654bfa ("cpufreq:
amd-pstate: fix the highest frequency issue which limits performance")
from happening on acpi-cpufreq too.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c    | 16 +++++++++++++++-
 drivers/cpufreq/amd-pstate.c | 21 ++-------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8b730193d79e..e69f640cc248 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1218,7 +1218,21 @@ u32 amd_get_highest_perf(void)
 		}
 	}
 
-	return CPPC_HIGHEST_PERF_MAX;
+	/*
+	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
+	 * the highest performance level is set to 196.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+		switch (c->x86_model) {
+		case 0x70 ... 0x7f:
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
+		default:
+			return CPPC_HIGHEST_PERF_DEFAULT;
+		}
+	}
+
+	return CPPC_HIGHEST_PERF_DEFAULT;
 }
 EXPORT_SYMBOL_GPL(amd_get_highest_perf);
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 80eaa58f1405..f468d8562e17 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -52,8 +52,6 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
-#define CPPC_HIGHEST_PERF_PERFORMANCE	196
-#define CPPC_HIGHEST_PERF_DEFAULT	166
 
 #define AMD_CPPC_EPP_PERFORMANCE		0x00
 #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
@@ -349,21 +347,6 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
-static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
-{
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	/*
-	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
-	 * the highest performance level is set to 196.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
-	 */
-	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
-		return CPPC_HIGHEST_PERF_PERFORMANCE;
-
-	return CPPC_HIGHEST_PERF_DEFAULT;
-}
-
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
@@ -380,7 +363,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	 * the default max perf.
 	 */
 	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
+		highest_perf = amd_get_highest_perf();
 	else
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
@@ -404,7 +387,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
+		highest_perf = amd_get_highest_perf();
 	else
 		highest_perf = cppc_perf.highest_perf;
 
-- 
2.43.0



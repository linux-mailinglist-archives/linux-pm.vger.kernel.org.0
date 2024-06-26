Return-Path: <linux-pm+bounces-9998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09B91773C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A8AB23171
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF913D2BB;
	Wed, 26 Jun 2024 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yB1VZENQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628F13AD31;
	Wed, 26 Jun 2024 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375707; cv=fail; b=Bi9jWXlAgB7OyXgwoOe3Xwrsj66vYNE0nIGa/LhtCesZLRu8fFXGMkGz7XHe+DZYtYeqMIDJCT6I9BDMJ6Yk1hAk4/Ga5qRQKqnzPA2ur7jLGcKd/vpfkeuhxlftYorKdanIZqf6r0qfGhYzOCv0EqeXVpf6LCX8nsWr8ztj9+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375707; c=relaxed/simple;
	bh=Z3w4YXh8PHJXV1Y0W1YueaQGBOnHLuvfvHBVDdv+58g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLwKVN3ItpS2xxmbDPw25XBQFwF9v/8cL63+juW3DDCLk+uGGRDRo+SiCuV1N3180rzdFuZCzOJ8D9FIsICj0blDGTa1QOVqae2fcvSRkobdhyfW+jnS0CMe6cN9TiFt62gO1hSwnaDW5qXtNGmqQ3Uu6uOAIpJHVTaIHtEk88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yB1VZENQ; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byW7tLr6D379pHNqe472dy77AQip1j97W8dmt2M694wWruw8BUTFM/w7X1Cq1iwTwWQSsJB27IdwEWy8eNhdV1YDOxEVxaOdlCzYz/vz4sbKSZONn8HNJ3PTd/ZJD8PigQqPYFXAbA3vH1neYC3wQxhxRDnZ5j69VysMGqkeoe9NJfoQu4mLMXUBh/CFQEhI+aDbUSPBZHY7nAuz+78/p63liWxOwqJR3L386NTcLoave/Nq01X3wnoI/nmV7mr5WgyABO8DTlg6Rn+iMKDkmzolWXk+CVWM/yDAzCbjONa9nS5+CKYjImqhbShTjh3rmbyJkGrLFR9BWtbTCL/UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpLf3Tx2LGabFVxEzIKK5KsCwoHTReCoflqSqS/0Kg=;
 b=F0KS7nJtaNeNyTc7Fi+70b3zZKek+LiYbjDjpjVsK2oedca6DFQnFwOsxnlULxY/Ti+g4dM82hHjhDMPGmsxK50edsNtLcEz594cnrJBYm6441m1e2/nFplIIp9RWhss0tirf47iDztw6icBmlCALa+XGbhMIEoITwnDhwllGGkm3fTQL8pSLmPt38oNifKOOyyztAa7eGJLrejof0neKNOv5iPE90e4YmnJ7FMEdp84ck8rVpJdWhyL04gRuprcAhU1QFDRm4diudK5phTHOrf7snM2LLZ0IXSGe53tzi2Z8gROmfLdEojgS3WNyEIyTN71+11OuOtbAd1fwhG4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFpLf3Tx2LGabFVxEzIKK5KsCwoHTReCoflqSqS/0Kg=;
 b=yB1VZENQUs8gtsPh1PPxUkRDxispl/6kyZTkXE/TU94uq/EYp5FwR3Kkn5t9apvLqU1gGEnI7FUEJ5ogdmLTA2wNTh4oi2Gka9rV2Kx3+rpOadA8Ek/IkObUWXCKd4hsy0UG8I4fYyuA6Bbv/+Zol56Ks3g511Y6R3Hy1j4TeT0=
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:21:43 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::3b) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
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
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:21:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:21:40 -0500
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
Subject: [PATCH 1/2] x86/cpu/amd: Clarify amd_get_highest_perf()
Date: Tue, 25 Jun 2024 23:20:42 -0500
Message-ID: <20240626042043.2410-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3e4656-09b0-43f6-d307-08dc95977b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rbfNwuOFhoJKqiWSTVtiUrD1zkCOwa6XeUGw1hoycbMz9rKxZH0lbJbiujLR?=
 =?us-ascii?Q?JUM5egsQiQTQ3l5iau04ZsT09MP5r/FZ1dlx3kdMnfeehQo4UXb0tD1MuzQH?=
 =?us-ascii?Q?EgpVQLRMGL9jickZcoTtBL+M6x+ogRak0QnTJ6wNHNad8EwPjtZHtc5tI2S1?=
 =?us-ascii?Q?72hKv5/s4iV5BKof0IU7mBDv47paZ4HBPYGjexCsvQp7fAqzP9duD0vwa9FQ?=
 =?us-ascii?Q?zYMDu3l3FMt0/3g0a/XSHYH+jsEQ0mZdKm4M8VUnb6gNnIqlDf/V8qjivzxd?=
 =?us-ascii?Q?uZIfcHpzcz3TcXhjM8OrAYy1z1ySjjy1ptZPX7sCCwhev9p+MZFPIWMELsQr?=
 =?us-ascii?Q?R9+rUT/ALRFBtInsORVCkDItJMNSFqpsE2Kt5yPTg1RWwiyGSMNXuTiH2Jnq?=
 =?us-ascii?Q?OzhHpYJpAca+MN9Cq9Weu9n3ma1t7aGSfT44QLUXvNdqP5LeLoZzFv2bZ3M4?=
 =?us-ascii?Q?OPUFRORrcJ+pAvUlfn/SSeRTjQfGjuvzpn2yLAxhlrlOpQW4c4tvT52B+VYS?=
 =?us-ascii?Q?PKG0vkvojrfrFF1IO2PZ2q9+HSyQafGeWg7CeSi8PkNY9wnNrV60tBCRlkRB?=
 =?us-ascii?Q?oIesnK/DuxjVBCBGXfBFiP4VsZlHJX1b0JrLZ/Q3FDL1zxNektg0frOj35ns?=
 =?us-ascii?Q?GtUmgtcmNXUBPaQNVuhT4gVnSpfWhl5G0kfantnmHdyOieI8PMZRPyVs6vcV?=
 =?us-ascii?Q?I12qakCv63SW9BVCWQSPHUCzHdZ8ulAAMZpcptrkf3doXBMVK9I9u5h099rE?=
 =?us-ascii?Q?SI9qRVQpbtWHISUyEejoWn/989TBrfgXWcvrQoPpKVOt7bu2eCvWE3bBj5vg?=
 =?us-ascii?Q?V/FbJpGUenyDDmDiKA3A6YeQgBYiBDjpCXaKMKiMAFVEL5k/Gp9j1byoobKH?=
 =?us-ascii?Q?pr5LTuevhN6WF8Nbala3iKb1vyZLFZ/QnWRrwwFNaNcEf4wcaFE3TcuK+43t?=
 =?us-ascii?Q?tTFTiNTCkAftmp1rbUFc7LR69XHTLGY/f+iqOPkplooa9JU9qcnApM0QFq9s?=
 =?us-ascii?Q?iqz13q+J/oHVo7M+8U7eQ5MdGqlm1um6icE/WuAuUYNk7zrUx2oZmslnd4GE?=
 =?us-ascii?Q?uevaR99xDMKuyLM5cP/dbqCyo1PTgWgFs5ojbiX7idi1n8R922QAvek/xBxW?=
 =?us-ascii?Q?BMbHSapd5ks/xBayQWvo9S9r1OLLkP5Q3PpLBYwL/eIsXfNQll3mK5yNrmpN?=
 =?us-ascii?Q?N2RhE4/8by40L5CojbpRK0zvdTDEeR1mExXm+K5jZ1WZ93VtAjkmOE1UbL2T?=
 =?us-ascii?Q?nl6e2Wll7EDu17KivmqbC8CV7VJIJsBcjSCT6aZyp+nLxhykhPMmho71d7Rx?=
 =?us-ascii?Q?nFuWl3CAvwoLqRAbiJJ8ulJ7yPyB3L3c0N8DP4upiclvsscMwrdEOPEQgejs?=
 =?us-ascii?Q?qiwvX88rtGQgZtithGemuRQJmcwKL8kvHCblKsiEappLyjOMa4h5ML57amBw?=
 =?us-ascii?Q?cO1KdddpEUMQPJkAhjVYFpoNPwT5nk2s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:21:42.2880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3e4656-09b0-43f6-d307-08dc95977b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

Rather than parsing through families and models as an if/else, use
cpu_feature_enabled() and switch/case.

Add definitions aligned with the amd-pstate definition for performance
levels. No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 44df3f11e731..8b730193d79e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,10 @@
 
 #include "cpu.h"
 
+#define CPPC_HIGHEST_PERF_MAX		255
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
+#define CPPC_HIGHEST_PERF_DEFAULT	166
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -1194,15 +1198,27 @@ u32 amd_get_highest_perf(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
-		return 166;
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+		switch (c->x86_model) {
+		case 0x30 ... 0x40:
+		case 0x70 ... 0x80:
+			return CPPC_HIGHEST_PERF_DEFAULT;
+		default:
+			return CPPC_HIGHEST_PERF_MAX;
+		}
+	}
 
-	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
-		return 166;
+	if (cpu_feature_enabled(X86_FEATURE_ZEN3)) {
+		switch (c->x86_model) {
+		case 0x20 ... 0x30:
+		case 0x40 ... 0x70:
+			return CPPC_HIGHEST_PERF_DEFAULT;
+		default:
+			return CPPC_HIGHEST_PERF_MAX;
+		}
+	}
 
-	return 255;
+	return CPPC_HIGHEST_PERF_MAX;
 }
 EXPORT_SYMBOL_GPL(amd_get_highest_perf);
 
-- 
2.43.0



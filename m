Return-Path: <linux-pm+bounces-8069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE98CCC28
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0721F23D11
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBC13B7A1;
	Thu, 23 May 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yCH5aKXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1613B5B5;
	Thu, 23 May 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445064; cv=fail; b=IhvQPDLfv6QJduLlK8hph24OK8hiuGD87EOaUlYQvx8F+BQRnv+OJAmWDetyf2jWklF+MnECdX9JYjJNHg4+sshXNPyJAtjjJIgkqPFVmGVEFL2DRR8VPM6o7ZqS2ues6NpFQIISUra8OM9K02T84H0oAY69MDp2qn9uoSSf4xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445064; c=relaxed/simple;
	bh=lKOjHB47YJQ0aC5CQ1DH8BB3XhUSavRBhKJd9bjmFyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtWMfSTN80uobADZeAvKcYCal3nkUdlzrTkXbQEktznA0kkOz9/zIFYSwRovfe4JNIuzEJMwhduneM4SSgNyOlPhgjm7waKTkHx0pINhTn7uxlMxnXCudfiUBhRqfiHWXrbJPND+RDn6iOUyCKN/990aYq9/V4+Ek0kxt996rMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yCH5aKXQ; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnWbWLnKY8qw1m/+iNOZX3T7dIe0rzwCQiNbmC++MZtzecb0NcI6i2wYuqAkp4hotOod5YgtnUQNn+y+acwBRFYv4Q9WOGzkHETMs+2pBDoVybOUnzu9JtXEYeE/dGDfp/E4i14TykP6EzgBHKJWrwCU8SpNIljZkB7mcrQV65Q5edtrY1PSuxfsMjTmYoe2Krcyd0SuM337X5TYEPEiDdNdD7uURSxV9mspUdUamkuTEsUWoRIeiEDt9B5Kl5C1wCipa0NpJMfWL6vbrWd2tHZXGnJir+gDeWuyp5mBmVqM7DSyVf4EimLEdKY/qT9M92gDjxFvueXG9MMRO8Jv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=T1Pm/4fORrrhCUxxergRrm1GxUb6HgJsrZjggCj/gwmQzUrv6A/SXNGLts4X2eM7Nc2qLtjQbZ+s7Qb+TQTbZCgDbvoynYY0auwUgORy434LsAb7bNy+CnkSrXDWZdVKMQL4cxtUt3DeWUllhRlcspL103YuZcOfRthHDpsgPLArquwH8dlyCRrCkOeFI1WGrZht8+FL45Fo78G5zLZD15I1Rt8YqAqS9zYCdVSbxMfs/xbr6mi0iJvsEcuvsQDs9mYdy5A7U7tKBxTy2jgjYjbvGRX/dLOiSCM2ypHTctxkSz/BTuow2QOHZmprtT2F7eK36vXj3vz7y5KqJSy60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=yCH5aKXQvwDgh9w41sab7IXtwIYmzIlAsjpYvlZl3CG7vd2sdzsvH04uzcnhusUxnrIxMp6ZiatFS4w2MAMvG8fMpCzSbuPtN/zop891cxv8HZTg9FEG1n24VpWq5fW0ob4AGV2sF+keKt0ze+D3iTvIupntxymjykj6N9Rjd1g=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 06:17:39 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::39) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Thu, 23 May 2024 06:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:17:39 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:17:33 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<Perry.Yuan@amd.com>, <gautham.shenoy@amd.com>, <Borislav.Petkov@amd.com>,
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, Xiaojian Du
	<Xiaojian.Du@amd.com>
Subject: [PATCH v3 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Thu, 23 May 2024 14:16:59 +0800
Message-ID: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
References: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f51739-a7e3-41fb-0114-08dc7af00c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ROF4Qf6ObVLvxmVhOnGPSQy6m/F/sPi20+GaqX4Gb1m5Ff6j+vlNHnpkgn+?=
 =?us-ascii?Q?mq9kj44GalJ3CPdBSnEU+LAy0A5VJZllerlv1eHWEN2SUcWx5jpL0N6IVqyi?=
 =?us-ascii?Q?v98UAjwpy0JhH+gx7ALup1JsdhK9WEkfXinD1g20/Jgb4CAg+3WJj3hKJx9y?=
 =?us-ascii?Q?UWILG4xJpEERECjXDh8B4/yxG7YZLNbuCOYbh2Na/cV0+1L1aecOSEVHxfgF?=
 =?us-ascii?Q?M96jeDz5yUHD/Q9BRlz2IsSie6TBJBu2yDXlrJYOlft6PlIeLMDRw1Hgujko?=
 =?us-ascii?Q?fyR9vE2/2auu0y1cFby0A3H/QmXIDt8L/euNQhCvrVPTDzMjjGF4gZqpnFhr?=
 =?us-ascii?Q?TiVHjZIcOfd3dZH/c72c+7yWajXHJgFs6AFsNwb5spgHs/S2m4v6gNFw3he4?=
 =?us-ascii?Q?Sgzhm4vxt0HQOfEigsy9YwDRh4Cr/4QyqPrBUVsq3PeFhwU3jIQ5UEEuJbXO?=
 =?us-ascii?Q?JIekzJlsS2rLaANLyt6uvztIp7U4w7SgFmrb2wae6BdvaeNt4ffjdn/8PJuv?=
 =?us-ascii?Q?/jcZfybJ6r7ptEykAcPqLbX+EeVDDso8utsCOhZfNT5/5ZZT6LBRjHhhjAbb?=
 =?us-ascii?Q?RGf7DWgkmiy3SzOEsBupAyUxYs9+Gm4TS6Ic4rd9I+41LnTIq6FN1RNt93l8?=
 =?us-ascii?Q?UoxQxnjLE2aZYZI6TwU/tO0yA73xZ5fbspwyW+ZMa5zSCDlU6IjnLQJxL55r?=
 =?us-ascii?Q?3OI0K6EzENvn+hGKZrRNrE2WGPkrd516ZSWooWducSppQTye4raSwEuGdFo4?=
 =?us-ascii?Q?ZIoV1aB/BVDokS8KJQ9eR9kstv++9BxInRA2Sc5MzwpP60riGIaW51CxKF6+?=
 =?us-ascii?Q?dP8FivwIN3nQuJpJeM5HnHerV6VuvRc/q6WWnAyy++VJI3frsZJXaAb9HHxg?=
 =?us-ascii?Q?3zKoG1N+DlbpEz80jajPk1x7kYd9VIyGmep2vjd9X+RUFCwJPAm+r2NA0m7Q?=
 =?us-ascii?Q?F789xq95HV9EKTSvWuBjn3DDt/Z6tqf+cgdUpQkelc0SkhRjc/lrVluTLPL7?=
 =?us-ascii?Q?ZNvA3puVoUOXAwtdcSzufaFP8QYBzoXvfh/bvM8KGm/d8sa97lsbLitK1URG?=
 =?us-ascii?Q?yYxBJPoWX76MUrhxVX5tEzs0hO3pX00r8ilBS2k0oi3AtL/2kzaZrD9TQRKI?=
 =?us-ascii?Q?psWNJfEqj2IggbzT6wUMHP9FJVCV3YMWW1qoeZu+HqlbHEyNfvhtaMugKH04?=
 =?us-ascii?Q?DkhARslVbjqd8VlvQeOZldYU6iUAXJndDmDFNhoo1wb/U0TdEVN4BQrr9czy?=
 =?us-ascii?Q?ApzngwN3srVCp99VizzYorXpuPHlXbWMtbi63ZCo0Pp3SnQHoKu5rrjCB1F+?=
 =?us-ascii?Q?5TWz3bFCH2bgsUuCBVaggIzT2RdIhYeIrz5Wsts2VokNmDjlXDAUhBOjKGhL?=
 =?us-ascii?Q?RdXP6Wdy3AsYt/wf2u9/6LpVFtli?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:17:39.2126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f51739-a7e3-41fb-0114-08dc7af00c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

From: Perry Yuan <perry.yuan@amd.com>

Some AMD Zen 4 processors support a new feature FAST CPPC which
allows for a faster CPPC loop due to internal architectual
enhancements. The goal of this faster loop is higher performance
at the same power consumption.

Reference:
See the page 99 of PPR for AMD Family 19h Model 61h rev.B1, docID 56713

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..6c128d463a14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9c273c231f56 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1



Return-Path: <linux-pm+bounces-7754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9A8C3A0E
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE28CB2162B
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BB1384BC;
	Mon, 13 May 2024 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EmhYgqzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02A1384AB;
	Mon, 13 May 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566100; cv=fail; b=X3ZiZDCi/bJVRQSA5DIUraxKDMOKtJWgf3xRi3/xB6YMTgd5vEH9zaDGObUWikG3tiuVL8EYl4S/zx+vUWd4wkkTfb7hhh7UOAZWhdqrL5pWrR5NdWD8w1rPw8fu0blWJ29+KuSB30ujEohqKbOBPrmCWmPVLbRbdGkXO4VNF0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566100; c=relaxed/simple;
	bh=nJ9cx9bDKy29WZBCgELY0XT2ZBaN0k8Q7mQhwVLq4g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7yYnzdJisYrUzTVbqRK24/9q0QTNIou2XcYc15ZO0fDL2zlYVxxurkLQym3C/fTGRHWgtqL+GeL/YuXXWiR4nwA4rMMNaJ80r6WBIQb04jw/PseqbTrCANGFV/prd6ekBtOAheNt+bzQ3v8U0MarJa8W7EixagwGQ5ouDQgLHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EmhYgqzL; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoM87e2nIOW2zcO09ySpm7msEKxCox7F2KKEy8dp8zEvrB18dUd7BQJy2fcotryzgNL8WufJAMu66eJy5tag+bC0wkuMle4msMl2hj4nOpxhvtj0wn9TMZ1quSa1zKfoYO0z3KbmPtc1K6mYrTw1KLR+e4dgKX5EMUkdvyFpuNANYV+A2zfNWb1hFj2rlNbm7ryw9lnTCWjXcaRWj7Rm/ztN/1gSIhtmL1qfms8BDrhzqpimO7HJPTnjZt8gDZitp3uCcWC6prSzXS8G60V/s0meJe0H2wJ7Y3/IcK9AXwA2ZJsf8Wc802KYeW8tM5LlI+FCBqXnnuG3o46515wSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6067HVF+J0DG+ofMoXQG4B7S9A1I2NXiUJHfzJ1YYQ=;
 b=aIwaxNZtEc4aaesfOx154CKqE83F97cv9V/5GPgYuRs7//Sgt+kRMcGeESIkHh2dpr5HX1P8/cz6A/qrdsz/GL6wfkquBOIwvIryyD3FBsLaDD+aVuLqgI6hFXGxTehXdgfz6Q6RpFJMuNxJ2U8/6ENz3gUQyrWSFLcCve2kLkKK+Ysj2KFNKcfYmQrFrnErVZFq1zHKJYzRbfLBVPXaXuREUPJ1MOS0tVWT0thG14P5Vs2O5TJsvBCosgB7ZNboEm7oHcuzIIaUto93xkSKVAMu2SisYtpU++RRMFnSc8xnj5QgMa7pyq6i2z8mPHdhX5MDNNxzAWViYhepdD/law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6067HVF+J0DG+ofMoXQG4B7S9A1I2NXiUJHfzJ1YYQ=;
 b=EmhYgqzLJj9sjT1K/DAFNwaJAPEc1GIk3UBAiJzZcz2GvKVGi5jIoO1tagbTygITAq023MdEESJk0Zow4RYttfpnvVhN3XmKIldCnozhuTpA3AhmH3FEA3NT7HULHm1TrqiP3Ku+9XWKD0cYBJzoEusZDHXZp4bzpYGEzDhkvN8=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:14 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::90) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:13 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:10 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/10] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Mon, 13 May 2024 10:07:26 +0800
Message-ID: <519db1e963f35ca0ad9634b0567d31c332c46c0a.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: aff564cd-b4fd-4684-fa41-08dc72f18bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QuKY6oI9+YDoc6/oCnw50d9pxiUJDK32KLsMRawCOarLpOCLHk6rJiOg/w23?=
 =?us-ascii?Q?/m4zeu3x7H0hiwMNNUbqGQ0CYAOTTDe2iJP3PnwovcwtMR84YDN8VhZ7csGi?=
 =?us-ascii?Q?1B+PL4Vcz4lyOLY50961ClcwSmqjUqWdzGIRKOfC3uYScgu/0sJ8pXITVRw6?=
 =?us-ascii?Q?JzmD0SXV46vKtBRVGvDQOrKR0hAfaZvO0RKWeq+CJyEjeFHWdu2h6Qo79o15?=
 =?us-ascii?Q?7cK18KOEo9vRcC+2UKCFIVAg5FzgEEcnc1Gkdnp9nPNvovd8T4dijQydwV50?=
 =?us-ascii?Q?TNji/hlmUh/7tklgRRpxH5fPuMSBMcTHX8i/3edrsYxSZgncdQMGmTxgyxZx?=
 =?us-ascii?Q?IvYfcoldPgMfDBu5h+qXMpLqrgPJDJ5VdQQGbWodJbTcUWaiKnM8Xht7C2bb?=
 =?us-ascii?Q?HIWVdZlW9g2miCAyD2SRloB25GSAubnKLFzFhwgUa/MZJg69PSKjjVLVGgiD?=
 =?us-ascii?Q?WI003dAA+ET2PVxRBZUlqdUdEqQRA+6RcexDczbaR9GjGyfqN2iBd7H2jEHo?=
 =?us-ascii?Q?oKduVgdkqLRTcOae2/TOfFRz3HzJdgiGyCxEum0T/9YcZwpTItodDMW9/aQM?=
 =?us-ascii?Q?wm2QZGxpvWbqScegtLYqvtOgVJpNOCcvQU4bU1d38oMJWRLEV1IzoHP/0d5X?=
 =?us-ascii?Q?lns+qFglFGpwOqXAvyWuWOCldyuT6317c1yM7tTnR7/1gHTwE8OdHSRPrBSV?=
 =?us-ascii?Q?PxRZoJuKI1bSrUZftP1AKQZzTkTd0T1cSODcF2nK6kudmtuVRdtNFKlFE12v?=
 =?us-ascii?Q?SkpUyzTXowXSxcXWlWCxo5LcTsrZ7n5r8/kzDmLPzj8UO3C+HH7UmY29evOI?=
 =?us-ascii?Q?zaXw4rohqSGf/QXXVXXmlAsrZLgQ7v7OYcnkFsvM8vfctDOw8aPws2kyG+il?=
 =?us-ascii?Q?Hwqf4P9817W6e/4va7maZtGqcEE8E/WAGrqXaaVwdtkrYznoaRuMz37t8cqb?=
 =?us-ascii?Q?F1Oz+7XxGkOHuQEVlVwZ1v+Q//x+Z4MdqJAcmbfqrqdhDs+OLif2iTc0OHoL?=
 =?us-ascii?Q?zL0IohzBplVibjFmUYxUQylpTDeqGczHurWfYobiI9anP9tUIQ//ptllHMdp?=
 =?us-ascii?Q?tZwBHN6VRExuvc2sMBQWF0JX+Mt+GxJzaaE5Xi4BfLysz7ZOMUfP075BlD4o?=
 =?us-ascii?Q?kjEIvarjDooz7mLPJyXc7V4Azyx6hlPvnM1TrL6VVbyqPscSwKTzJS+FnCjv?=
 =?us-ascii?Q?0mTdmALDE50Vu7Fj6tl5GhrJKYx3GSKrJteeZf0vJPMeh+PTOUu46nSTx56R?=
 =?us-ascii?Q?aly/ARWZ+j/57EuH2V7yiTDakGAeqts+EMr6yB123KkN7Rc0fTeJ/5SjmZLp?=
 =?us-ascii?Q?GSQ9r4KNUnUAJ7QwX4o6gbv1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:13.6144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff564cd-b4fd-4684-fa41-08dc72f18bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

CPUID leaf 0x80000026 advertises core types with different efficiency rankings

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

For better utilization of feature words and help to identify core type,
X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
PDF p274
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..39a92338c015 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 5) /* "" Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9e237a3daf7e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1



Return-Path: <linux-pm+bounces-15702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C699FA45
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A6B1F2358F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E82076C1;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="44aw5fxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194B205142;
	Tue, 15 Oct 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028255; cv=fail; b=KXXr8FDGQ0rBQ5/cwsgTaYnIDIUXNGHRPL+e3uXZ5FG0j3EXKsVMwE/2SEIgcGijzpybyL09fIViejwmTWSeZmS2zyANrVdrExFt6tLS2feiCBDdre+1KTG/wpEaODNNee54roV+2f2HXYEDoha4nEkG+Ucr4YiQAgUwnAfYUTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028255; c=relaxed/simple;
	bh=ofBvHPgVw5oIr8IlpOP7+JqexZC7i3ifWbwlvmZ6jFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlIwWJVfDzmEJUdcSoSUd+FhH8HQ5n4QrIsgTRFYmX4fqaBkfmaT8ugjeA/2pMDqUy8jx0jDxVboHhdVsw8T9ZI/YuU+DZE33TCX81yB9jyAGBzwLgWYRpArcKi9qQcdRCoNxRX9bcr96o2R8wJCYcBcwNo2LxqJNyAiMMqN75k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=44aw5fxn; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDwrmRjNRy/E4ptoAEi8QQzr3h8olXF2fdYRpv0FW+JUwhJGAnviDBXpURNT0LF8Mho8FmUFeVHMAtU81EWGU1NoVrZhQVOEIpHq7LFkJH4sU0Bn6dZQXdBFZz0I7mDgVIbi+2GgnMe17/zXfp1xYidjQCcM5TsdeGHnceX15d8k9ToQbrSH3cbkQ+pPKFzCxp1qIXuwJ1wKz7YxQZ5x51oo/caKPPg9wJKKFwPm/xrjCLkwNLMaFWf5dlZbc8hJTZYjCXakyK1uPISXmnHuWmHoMF2OF07G3XyyGFWz23xsrKexULbRMjpbJGmCmODRQOvllficqyeEsMTIToBOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wpo1JAzLUn85517a0rtcIQKRr3tku7gUFu4sVqSGzw=;
 b=lM6T5JkabGM3J0jFAEFlRYCiAwliW+hgUNB4ADTEmv6tVELntmDDy2jdgLdssTYpqd1p2e/FZM8JKaz8Zjyry0/gkTPy/HO9CUsmIJZP6FHtLUYT9n7P7O0St2ggPAu5XX2gpsWBhwEQVYGh86sjterAOxO3+0g2GETDwJCxBGFGawNn4Env0VTPQQ8B2uwUYuwou1mN4JD+CTHziTXwCQaODLguPuPhTIs3s9SJ14VDvCB5r8tymwYC9SNQUPD4m3h8a599fQi2WqRfCm+lV2tij1KTvc3sCF/cxU+ezds1xJ4GxVE4yiQzQw9QNCOd0oy6XFRuP4SWfqJOkSHETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wpo1JAzLUn85517a0rtcIQKRr3tku7gUFu4sVqSGzw=;
 b=44aw5fxnHBiwO6mUA1VegjtQdRJmdWWWqUsOEcnZ4tXupGy/azto5QRJaQBBK8rLNql77VdpoAG/fafgji1zxRGs7fsdDBMKOz8nLJWyz5DojsFEn2Rh9PBgp+7oGmLGy/8SkAO7B6bHVEz+zzhWfs+hPe1gaxYwSprD7qUUVMg=
Received: from MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 21:37:26 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::39) by MN2PR02CA0028.outlook.office365.com
 (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 04/14] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Tue, 15 Oct 2024 16:36:35 -0500
Message-ID: <20241015213645.1476-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: b70d3ea3-9922-4308-eca7-08dced618fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JS9GLUP885qtJnoCmY6BNmmyyHCUs2KgYWsGjpXGhClAfRySkzJp36GpQITz?=
 =?us-ascii?Q?tX9Z43mNmSkSJoQWFYfMoXODmv0TfLJQOY1ekulUB4wp3bYW4ZK06wH1SRJK?=
 =?us-ascii?Q?a8JSo0DsVp25rU2BLDpcuokZa32rwsLF31wp4aAXLvtLEsYxZV/CTUe01bOR?=
 =?us-ascii?Q?hsVemN0MmLwQWtGDMcxN5rAzh0t1HWCC+vr/ed9M61Y8Nk3b/dhLypDvZNet?=
 =?us-ascii?Q?ZzGELBZaQc32Bnkk52vdJZ0RXzAOH11RS9fHBk/3dT58JscPgrslzrkeyRVr?=
 =?us-ascii?Q?dn+BfZd6IfaYcQti3+1MlklItHYUxD8uthiojb3tRmo93jbPG/SvQsS+JPUe?=
 =?us-ascii?Q?/6rWTxR07mrZsjXHAvEDFZEVpsmBo4zXe8pxN5CWdqvFBITVnLeUXB7SHajx?=
 =?us-ascii?Q?xkMBINhE41WrLQGEkwCX0r83/laiHayScVSrs/8D1sx19rme0sxtD4gGgzbj?=
 =?us-ascii?Q?Hx9+diENICkuQZAxAcIXd5SW+dFjc26U+5tDiI53TOWPdU9X2hKf7livUSuO?=
 =?us-ascii?Q?Gt7JrCvdtKsMlt7SfAHxt2Rg7G46GKZ3Sb/d224smcmVShVxBdJpEEmaU5Kw?=
 =?us-ascii?Q?vWe0dZWmGGRaCTZ8hkwBMW/a6ecLjtA7qSGLndLtQqfyN0i9MXLDM20THaQ7?=
 =?us-ascii?Q?DtoOHX0ECctAq24MpBUovqEvhPw1JD6DXzQrNG3gBm33AhWZ2SQlfFzTgUAj?=
 =?us-ascii?Q?34FYV+v6Foswz9PuqkwK7rE1OQOwPDKNdaKhkv3TkdXnfPcmihbpFBB3M8iY?=
 =?us-ascii?Q?9rOnxT24TL3LjjcaLN5J9uD5ouz8kQpwTPsU7nVK7MAhe8qJpBy7nA4XBwUC?=
 =?us-ascii?Q?Bve33ebZAjwcp1qXZiAiMFBOsG7LPer01bOeSYoBdyHMel3/KKr6hCvY0bsJ?=
 =?us-ascii?Q?F581zybc2IWe/dreTdml5jc/bz3O8BBMiX1LfvQ54r3Q8VxuuDin3yIRhTLm?=
 =?us-ascii?Q?NUhg8wJ6eEm31W0TL1XlwewLUqndMwrTCE8+IRHWkJlhW+C0+ethTrF8K1/8?=
 =?us-ascii?Q?vMPRLTW4W4j/iqb8XVtQsqGOSbPsPO/5/QknvZgP/Lnrk8N1XRw77tWKcEMB?=
 =?us-ascii?Q?Q/4eHgVwxDYBJE3dkjpJ2jixqPVQ79MFzdXyfHf1YNs7YuybgAZv4fPjvoEE?=
 =?us-ascii?Q?dlxo6ml4xUP0izsqNFNkPl2HZsVob3/B2XuqHbYWTo/AZZ6YtLTHsur3bAzc?=
 =?us-ascii?Q?AIn5RfQMUG+h5cnHayAkpFCq3fx9NR+p+x58Ij/WhZTufpixO+qpSapgAJ+m?=
 =?us-ascii?Q?1//5IWYFEgmt6R6znYLJwMDWtodU8VYUEVN+qxybz9QoTVUEjJpeEy4Yhff5?=
 =?us-ascii?Q?/0ndjKK1cpBjFAj6qfHJQaYNDrw0a+/R+WCcCK/J1Isu2osFfz9vkAo3+3e4?=
 =?us-ascii?Q?qihILbSpa13pQj1stQb/GsWnTNWl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:25.8382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70d3ea3-9922-4308-eca7-08dced618fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..0cd5ffe50f4a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0



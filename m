Return-Path: <linux-pm+bounces-16536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47B9B225F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1151C20EF6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7C5188CAE;
	Mon, 28 Oct 2024 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i7WWgpyl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C311885BF;
	Mon, 28 Oct 2024 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080998; cv=fail; b=DPYrfhZ0sDG4XTNYHebX+MGBdwCxhxhX6RtXLgY3z0U6R+jicGyo2kEWdJq8AisM75BmWyaELK700WuGud03wcj+0HkxNi7DxTMRJBcJFr6e/2JhqqLkRokCdi0DNR+qXogPXWtKCYAC2WaY9CibyEiPi61FY0u2c31kNLn14xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080998; c=relaxed/simple;
	bh=CCkmceErCb/j2gFvufuZkzoxAkR6JEeyG7gxO5N1uQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhNKphWs23ffqqriUXEUCIzecJ0utkz/ytZqYHpulk/NpRkBbOhWaY3WscvtjKVOTcnH1W09mxOj3KeK7ughhtlgy42He+X8q8FKBk4fnbFH2aVdJ+3nKY4U/h0n1GJqeL9xXvC59BXht+XCMvi5owFfRUkzwmBbSrF8mWaErkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7WWgpyl; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9yJ4RzwuaXHXo2Zn1RD+hbWEu/U4BAm7jt1Uuj6/kCO5BHZGs01cRwgpr0JjLCmvZo0MRKMSxmcQ2NF3zDNhsgwMSd86zCZoKVreK4FjjgzdzOVF6g4DHwX2fHob+PG3Xf2u5ERDMdSY97cb3pbNqbaXA5mTNzLFYBDWjpbt7U9PSMiQ+z5TZXpsuUqvAXDLLE/JOIcHCZwGYOUYFK+9Tf5GIE9S0U7FPzsLj0YcH0qMEK+zEjkk2uZIg40zdyp+AWp+qdCHg5b6FP7/UF8prtAK3AI8qNB1OrQT4YTqeFSrWczZTJJpbtnrMDLeZAbarnv9Xm5x810NmUu/gNcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dtm26VWZsdxgOSbXChHpJAJvwwSusxTcg9XCfWU258=;
 b=Ewmw4DVbySd76y1k+0/MYIML9pMUDoajzZgSU3NIDsZ+oHmQMwYlV54QFWIuOqt5RfSeXIRDk6jYS8DQzTOAV+0wQS5S+AgSe0A9cxlkFjnvnKarLJgN2xqNQjGllFNR/YZhh7hbKCWyCGr5GCAl57Ds7jJVJh7aGqlVJwl/HTCjs+2Yr9G+Tl70iBAvpyOWGqil64z52QTXQOmkwtalfvWu1PvUCDDwQ3pbii71amkw8AgNugYCLUGhTlc3dDL5nN70S49jCDjukHR1gddy2oIyWpjKZ1wluVB/IhumhIRLFOsylBAAReFHpq7svRCnO9LD/3wGM2iOORHmtKlm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dtm26VWZsdxgOSbXChHpJAJvwwSusxTcg9XCfWU258=;
 b=i7WWgpylTF3zcKM9SytN2psS9aMZ6Uwr6BvsJM962kHew8Og6DQjEvGpCDlMWjwHwPiFnqbMF8GD8MtyFKMxBatZFo4PDY6Aiw+hO0Ab1EhgOpwfhalr5BZrKHOIawXvIHX1z2DOYYhOhNyYTeaUu9MOZ11NRlR0dsixXn7XMTU=
Received: from MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:03:14 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::54) by MN2PR06CA0023.outlook.office365.com
 (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 03/13] x86/cpufeatures: add X86_FEATURE_AMD_WORKLOAD_CLASS feature bit
Date: Sun, 27 Oct 2024 21:02:41 -0500
Message-ID: <20241028020251.8085-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4d552b-0209-4085-dc6a-08dcf6f4ae90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xqGrxs/kE32ewap0LALrv5laYvqf8awISVXa85tnAcbmGVC9oK6r6xJtEndl?=
 =?us-ascii?Q?w38EMLYdSUZ+upT9ZYVosrY9+O34p1R+Mqy/iRHYJxTIqEzSqwX8ncKdR4SG?=
 =?us-ascii?Q?s8JFPu3LBxJnE2upHXHJbw6VdQRHNA3CP4209CnMMJHk2nX02XlCISjnYsbi?=
 =?us-ascii?Q?zjreO3hg/SVAzWY2tD6hzggF1w1nObVQxxEBmQhdXnqVF23jYQtZ3PgXVgY0?=
 =?us-ascii?Q?LZ5He/MrOSsMNJ7poBRwSfqOjEwz+Lpiz0+SuTdnaz9BYonbbWVvj73oHWiI?=
 =?us-ascii?Q?iLxfx4CFmtwC0EG3+fNBy5195kpNCI7fTBBdq79hPl3kxK72Rbtpxb8k7vvs?=
 =?us-ascii?Q?OOsLtm3OHkUu1mdEDCZk16COA0TcQr1uRumpnAo/zzRIIIX1JUw+N9iNM3bB?=
 =?us-ascii?Q?OhJoSY+JICV42XDYMmjT0qe7Wt/3FUYbg/5Z6UjX3wTsVp23Ms0gNqlMeBZ7?=
 =?us-ascii?Q?denuPa12omKv2cGeknlNFx/8UlAmxeWRKwcjlLxUPX+3yQ3o8nErfCWnZgH+?=
 =?us-ascii?Q?kMR7HHu9VN/bYX7I3//UuYECQNWfd7+hbxSg3RUhgmMkVTp48KIwcKOF1e9s?=
 =?us-ascii?Q?Zyy0lvZVZeUHTcbhEVBXPxFQYNjDtqHvhWVfuEGjC3fCytsHkLvFRVDCWOX/?=
 =?us-ascii?Q?0HnAsN3cbaDmtgmcKJ/VAOlkMhoEIi9gV1ElpVgqx6+1BSXleMyHiGt+cKaQ?=
 =?us-ascii?Q?1K7Vn+P9hwO/JNAUETVdNo0pUSrtYJa5YhoOtC5cXmh61s91RacVlZxK029r?=
 =?us-ascii?Q?L+RgrZ8C8FGLSQvZ5x7q7aupJOrWyKkItbfkn3EGt/L/iNtYNggwnE2WHZnD?=
 =?us-ascii?Q?dMNTZJNwoxcOkGfpQH07rE3tacNTKpvBpZpFH3++R+mu/3R8jg7aq4uB58mf?=
 =?us-ascii?Q?JqRd+X/9kS3P1YPmBNbbIfxgP6kmvQmmA50tT4mBigvtQ90GM/IUSOLLSn5P?=
 =?us-ascii?Q?4ps8CcnT9q+t60B/rizEAyHHqKzikVShq5M180YC45IrJNPG2uF9NfYFbbAv?=
 =?us-ascii?Q?UaC4nSiOCGxMgq6DoG4qnLr+MTiELv0bSDmYEP/5XsCqROL5cmKcLksGeTDy?=
 =?us-ascii?Q?ja4riaslX4rs9YP3jGsz0SYoynI/fu4fn0vEhZwbqyqJ3rOJXLZNrYms4eHO?=
 =?us-ascii?Q?9GPQ6VgMPoxcNpSihv7MR8oH/9V15PT7Sa4SMdStT/WFZJ4KpnNlNeMV5MRJ?=
 =?us-ascii?Q?iKlw9B749xMJ9UidXhcDIfsxQA4gLzRBOF0U0XXVOi2MkvAXhImVk41rJKgx?=
 =?us-ascii?Q?Vbw7vle/+RkA9KnGdGDF7ZsdtizeCr0I90qvfWaa8wFKZCExpFlRvvf4uN+M?=
 =?us-ascii?Q?ewGZbW7VnqhdiYGosILwXcSAVRh7ZVbtqu4SXDQZIEkjrb/kqLH11ud/VFI4?=
 =?us-ascii?Q?sG43ac65oWp23f66iF09wOpXzNoWo619ERRlTNqCfAYGue4Wrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:14.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4d552b-0209-4085-dc6a-08dcf6f4ae90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

From: Perry Yuan <perry.yuan@amd.com>

Add new feature bit that indicates support for workload based
heuristic feedback to OS for scheduling decisions.
When the bit set, threads are classified during runtime into
enumerated classes. The classes represent thread performance/power
characteristics that may benefit from special scheduling behaviors.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1216a0588ba8e..05e985ce9880d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 307a917415343..1e54332594443 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX,  22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.43.0



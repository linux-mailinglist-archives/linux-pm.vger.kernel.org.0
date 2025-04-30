Return-Path: <linux-pm+bounces-26452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD1AA4A0B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130284E6C92
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325BF25B1E1;
	Wed, 30 Apr 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkziklJF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127025B1D7;
	Wed, 30 Apr 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012675; cv=fail; b=arOxX6PgYytIW6L7NvKGIOHl8kEX/9nSWtrVDvHyGSJhIIdj4GXmD48TwXXbznUS1BGfkEXAKKUHHNXNvQSlXA1MLl7aH5ziae4ULpdx6f995jRKeEmx9j63RAi1mkSjgmOKJRyrhpt8EUOW/KGG0ZI2V8R3NJtAoEGvZMffVDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012675; c=relaxed/simple;
	bh=o/e6yusEPpX5jR30Qzsc8DdV+2NJVtRHm0DQ79zzIKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWhYurnkxLypshMtcsicrCoQQTtCGhR0z1amBNW2Ekur15gM/1UVuzwoJ0JcvJJVIAnAwvqerG5UqB0EWAoL6ZrqRhE35tDOrdzs4Ded3zTdMg+NVOp36RfYMB4DUjXH1SBj84jbF5DAg8U4BEq+DHmh+Zu6P1GmeQskKc1iXxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkziklJF; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXE5pO+RAVSsBcyG8G+H1m2EYGydHwLR0c4Md1iDYKBG3CNeZZ7xEGBNVsTdXZwkym4U+De+niptPuWbH8w2QMH5LVE8e7IUMeCQ8EVmFF691fzXFmwwoQ76tQY+QyTG0bX7Mu3r8YP5nCv7c+QaSIZc3KTA8YNBdsxYK2xLlYHQumfQctQ2IEqvGIguZgTjqZaFBPlH5niWmd72/ExqRJZxjjNUBK5l+pZa7AacTaXd2dPp728L2sYARcb82EPQS9V3U6xErRzgQnyPTgcm31L58C3GBGLhyi4U3wX+usFzJnPWKhL+nP5i0XwgeV46ip5o02JEii6Pyf4fVozTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwQf/Y6LVvVs3hUR+t75InacKHRfvwmIKRARbqkqUvU=;
 b=oX6BDcHhaNjOsnGv2Xkqou1FpUz2fMcslYbIR4Fz+REweyXD+jO/SycVCwbYUWTXivGSQ8FzJ3x5nAoqFYRdJIEoC2hZrWLhgf8oAR6NXXk0JuSdEbggzfkkmuujtc0Qrn9jfcEx8076CH5/T1GbrvXhk+PsYNXGm1mOKsFzDMmUV7vg1iP9bmgPaP36puKNZjndoRXM8HjfZju+hIO6NcfxghqTm6O+YRyqP7uCq5hQA4+ol25KJS+IN7PtOlgrk2M7sWEQzhKmoPYZL3GCufTpx1OYdjbkEENbshZz3hZSARUq+XRQcla8jdItJut5PQ6gfayaZt90GUVqMoH8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.d smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwQf/Y6LVvVs3hUR+t75InacKHRfvwmIKRARbqkqUvU=;
 b=AkziklJFOSKzPA/XU4MuycWr56eQT5CYWilPa5/WpqFxZhVroga03rZznsh1KsOkl8FAl2oEwVhASWXv0n3/QCTHT58jbn1ZPf5muG5ObL144jw6SEwsLdeElqp4yrZyL4Zo4DK8QHUUTD/dm/mfKS7A83gvXd5/UF6Sg0Tr08c=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 11:31:11 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::6c) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 11:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:31:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 06:31:06 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.d>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 3/4] x86/mm/pat: Fix W=1 build kernel-doc warning
Date: Wed, 30 Apr 2025 11:30:01 +0000
Message-ID: <20250430113001.546066-3-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430113001.546066-1-shivankg@amd.com>
References: <20250430113001.546066-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b74d5a-164c-48bd-9b73-08dd87da81f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmtJx5pm72CX30eI3ILyonnBUkmYeC4qWacESlDmoYOdqsuZFp8ZDtT5HiQH?=
 =?us-ascii?Q?hW2gGTFm55yFVSaBhgCb5/pnHkWFTJByGrE4vRU//KFsHlROauHiwrrKYuQZ?=
 =?us-ascii?Q?EZnd2V9bukkbY0F4DM/TmNlDS8kRF98oT34turRm41d+OQxp1ngh4ZQzG+SI?=
 =?us-ascii?Q?1b1oYXZJFG9c6ajRDmx1oZ6VKNdLSaXLf/gmTzl3J4XXU2OAVs8Hc5YzfhsV?=
 =?us-ascii?Q?GyH152lfKLJa4wWKHhqyAVJuTr5cMY1g28vZdb9o5itpjavUqj4u5TRKlcZn?=
 =?us-ascii?Q?lPIFnyzKvFmCDciK0RHRYGFzMwRDdDDvwlyVHs7cP6WqfomTczkF3zm7weQt?=
 =?us-ascii?Q?cN2g1TaJj5UlKs9qikB7IRilc1R0s6QdMIgPZB8R9MyF8DBT1FHp7kxn5ADQ?=
 =?us-ascii?Q?c57biFOWlbn59gi6mhkPL8xbPsLrVnDOsIRaGPOpqN13X9fYQRG2Z9Gla4C8?=
 =?us-ascii?Q?NQrioyOmbO8vZmZEdvPQy27uDjUSMw8maCNqtMBaiA8+VjyuDvN+SD62TrYM?=
 =?us-ascii?Q?qFlLsLtRV01wxKw/CAbd/u2NHBYaKPH1YJ2kq9C04ANKIcv//ij6UVNWf2Uz?=
 =?us-ascii?Q?VR1YA8sBUA/wOU3HyNh2Eq9nULDEPORx/A9vAO2ZkXDSD8p3NXvxmQ7tMA2t?=
 =?us-ascii?Q?67LkWnhwylMYnyeKR3A4jbT+VXFXaYzoXBVeFycRZ+kX+K/o5127ptkZyfzs?=
 =?us-ascii?Q?5bQeARJRp66kV9LURYT/3Nvn537/pUvSqYnLXoy/npLO6xdVAu9VILB7dset?=
 =?us-ascii?Q?r3SSA7DphO2v0zFU4i3DX7aLxsQrGc+MqtgA5c86yGgRjP8sMTD1k+9bZuV4?=
 =?us-ascii?Q?fttg1YemHELo8bYrOKqm4WSRXvX8pr8jdSK4aDpxkXqZJzR13mzH7/KljJ7j?=
 =?us-ascii?Q?5zPCVJa+T1x4vUBdRMgGZlTW+Pm1o8LGbmCrzjO0gtrUWWQkKJGGHqi32Mrr?=
 =?us-ascii?Q?jOQiJBKz6z2XeJzRflV3fxTQOePzxodOqM+PlKIe2cfQ3tv+/TVtbq/wEvrK?=
 =?us-ascii?Q?0CyOED3E979AcOqZOjfkXuOcuuIv+KxGo/mAn9k/cNlueS4ulHic5CIn5yr3?=
 =?us-ascii?Q?US11/7ji1IMEB77dI5C5Br3Xf+Ip8Pv0xU+qB9ttOmT9jzeY6tsAbFLOECEk?=
 =?us-ascii?Q?ZXdgpbmVlpCYejkVWkJl+HceRLaQ4FnRRrVCWjECQS9uyfzpWfmbpFPd05uN?=
 =?us-ascii?Q?qDJUH4IE33f0OJXTyUm77iRrxuvdVYK1X0I/TSKX7dj0Boe7UEB4PC+EO7My?=
 =?us-ascii?Q?pggfwDnlpfD+5NMUpd8eyi/BUllUYYiSQrBgwskWNiunPG9PhP9wkecUxBG3?=
 =?us-ascii?Q?xtHytz52kATN6wCacV9B5FBlHhENBlbxZfX4ciaGMgOJZAAO9PH7Uil2T9QE?=
 =?us-ascii?Q?i3eHSDzBmDUUBnRjViqgkeX9FsFHLLrHR7qwB+fBz3OPhyUALJ99yh9GDhpG?=
 =?us-ascii?Q?+bhStvjbcMgIqZiTap0ujYygHOIs8E19J80LsGMJQ7X9VLB7ONuaxmYOcdBO?=
 =?us-ascii?Q?B6q1bkg40g6qDX7t6d62T7dW4pVHPRYx/fFaHovzprYAGQmnuR40Br5T/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:31:10.8838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b74d5a-164c-48bd-9b73-08dd87da81f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

Building the kernel with W=1 generates the following warning:
arch/x86/mm/pat/memtype.c:692: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'

Add missing parameter documentation to fix the kernel-doc warning.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/mm/pat/memtype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc61158..51635ae1eb7f 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -682,6 +682,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 /**
  * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
  * of @pfn cannot be overridden by UC MTRR memory type.
+ * @pfn: The page frame number to check.
  *
  * Only to be called when PAT is enabled.
  *
-- 
2.34.1



Return-Path: <linux-pm+bounces-26450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79CAA4A09
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB8D981A6B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953C25A32C;
	Wed, 30 Apr 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7BYEisP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665C25A2A9;
	Wed, 30 Apr 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012665; cv=fail; b=lrBqsrlDXvVmbzb0MLx5DZQRX/CKfxmYT/KtafEqAAt+eMm18yg7nhpkzxh61yfPmy29H4AJn64O426Bhn25WM4w/mkbZbw6YbIP8Ulr/XthsOS6hIDhUa4bpK3zfTBzSUeJbqCdg+m1MAqFqGGXsWWVMf6IGPBOHg55Sq2zYbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012665; c=relaxed/simple;
	bh=yw5qBErrF+5bVaYIgN/Oqsjg7MOTaUbWYQI0j6Kc/zE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgs4VSaKTfzw/2Lg+e7fZuLfQdrsQ8hwHJ5w+bUoBl9AQBQHgBeridzZKOnKawRpoV8/VjSaLn8havksAkdm8Yu5Qv7CQPNyqfOknE5MfkK0dBEl47CYsD2wvMDafCHVLjrTX0yGU1v/YeX7MYUiO8KiQKF9IL289nsVInywPAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7BYEisP; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNW1W9VLRhVnp/oaWB2yYBp/Y2+QJV3UJl/znKo5miuczIelfuszkYefQwU3n11d9sxt3GbkzCS2qQhx9MgFBrpgh3HJK0r1Y137oTCUCHVq2c6dKtQ3oho4dNKY5jECL5QY4fGpgO2yUrLuABWOXBYaYMhbaCO8L0EhRCPyygEhK6o8Wq94k7D66o8ZuQled0PIoBDrWg9OYaCRVBJE8ic3JQQl2qeTvTcxz7hM3rs/InigpPPqoV9z1s5VOx8C6IvBak01XKduTT8/iTJ6urp+5AFqtpnsrY4h3Dg8vP9cU0ppFQi98YWS7pn9UHF7DrO97COEkz2rEl97kQiu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB4i9ftNSOvRiEmk6L9KnZpnJww+Pl0ohoKE/JEXnvw=;
 b=prGgC81IhCgKxTg6KE7k+PUjdtHKchUPz7qWAI68WYUDf0Mf/qH/rD5iGybxHY6gMCieewIa3kJNFkBLmvdjVwUvhfZtz7wE/kHDp8Ij4zsXMo5Ipdz+32NwGO7FN/fCJ9SFzHnj/bDB/dAlisQM3ECq8D/1AaXo38Vsmsc1UBQ+v7kSgUKhypDR7U7CuByRmEGub/MLyMEGxhVWWPFySf26BWz/luqZ5wEhefH6kYIlG1OOM3LvOdowNbqNXFEWnOCQn5AwlR0kzJlYkyZseA3OvKCsVYeyOD1jt+izRj0MeGzVI3yJeEEOYAYYv9hOasUBI7FHBEjjAGEd+TddhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.d smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB4i9ftNSOvRiEmk6L9KnZpnJww+Pl0ohoKE/JEXnvw=;
 b=O7BYEisPYLTNnrbhJh4ljZob1hbRgKsAazfnfTG76fh/i4vHJVcP0lS6rtnUGPPQ5Yc/A9H5FNA1AOCFmvWg6L+2lZntm8vg4Oihz5uxY3TztknEAXtRSNc3+6VG6notnh+p2NErB8o44up6CfdelYywLU1oR2sSUoA7EWYrjLc=
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 11:31:01 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::62) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 11:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:31:00 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 06:30:55 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.d>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc warnings
Date: Wed, 30 Apr 2025 11:29:59 +0000
Message-ID: <20250430113001.546066-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5eb123-5d0c-4fda-9202-08dd87da7b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fB1Qu8jcHa6kHRUYwV16Z6VvJCU67TbMjurEddgzoXY1fy811et18cJ9T7qA?=
 =?us-ascii?Q?yrLTeG+cd6flwzAIS5BIHewcc/rXoJTEWSgf4kCLWoema1PZNze0Pu0HJCbw?=
 =?us-ascii?Q?9XF2HfPbqxWcH59BaOB4CWfnV2idOk8BtBQR3bochKtod8+sMbz+oOV3D2ZV?=
 =?us-ascii?Q?xH8MK2BMP69N1O2rGfsLBCImGLwK4kruTIPyR13phfpOSiCAVzKC0yOOnr+2?=
 =?us-ascii?Q?ygqqqUL21000ZC0uuiuSxR92A0zMi6aoGM11auq2Kg/KTEWW/Bif0TqH9ine?=
 =?us-ascii?Q?Xu+4FTCTsKJ+4BtMnMPwZytbtui5H+L17EvIQR7E2GCAp+lhudriUUw355np?=
 =?us-ascii?Q?UYPjeFfOukFIqgsrGmu0/oKyj1zhDFRTwDb7ah5lljzkynrgbSG4bpsm1dEL?=
 =?us-ascii?Q?u9hhtqKwP703uHOazo5d8Nogets06yjsUec6nO8Zi6ytKK2t3SpF9/W7s/CT?=
 =?us-ascii?Q?kZRKVfSNhjtUNz2yYW14Yoqs/rjmZe5u4UnxppQHHgJVgQ9WAZWHjE4SV2e7?=
 =?us-ascii?Q?qSyBjU+PngUnvKooBSmjSD3j3uqrJqbwhM3YBMdKj7Ep/A1tiVtlWq/M6YQR?=
 =?us-ascii?Q?NL8iniLQDDq6YJa6bWUhmk6Mnr4e2tg1spJFijoViYGbby7apdXbpF8v5lc3?=
 =?us-ascii?Q?5p4ZexQ4QD+Q5gh26HgtA9iSS8kWj7nHL43q/FrZ1sGSu5yd6pwCpkLp46Fg?=
 =?us-ascii?Q?Ofts/SIyxqjq0RQkY8r3f2J8pahyZd4LllsWfL6YeGahsok7czEzUMCs+MW3?=
 =?us-ascii?Q?pH7f1PeTNPpSWS3HYt6zPJWDYNUpRjEkTMwBh5PwdODA7HuSdWr9cwibRbDc?=
 =?us-ascii?Q?lLyZEUZOQ5+13LdFRvf+wTDptUmcydj1m8rV1Yg8KJvCDZcQx0KJgBRTA/0L?=
 =?us-ascii?Q?B611SXWjnMVYyPmr2LYHuVMmUdaAlMlKPqRfBEZFouNr9Br+vfpitU71fX+1?=
 =?us-ascii?Q?76/abvXnW8JB5ZQ/yNqw1/B2mc0vaZlJTP7NSAyunmLtSgrC4MoM+3pU19VE?=
 =?us-ascii?Q?O2dQTbJpQ7gcsAd6uneUOyax4fHQy/sboxbA1GE9b+pM4GR4N3vI6yP/E697?=
 =?us-ascii?Q?9WFbJp//eQstyDxJY6TG5QjIk36jkCcXsZMgu6qrp/67Qp1ee33PJ3WRe8Yn?=
 =?us-ascii?Q?9Iw5ELAHkL20KrW0RelKE0NAf4a71q2Ak9cX8Y/pifJl9TJpSw5mUg9KMv8o?=
 =?us-ascii?Q?AxZO5SYN1ipihJHjKV4wMEg6iF/O3A+a/pFJgIY9BZW8zcSuY1SJL1Ogn/rC?=
 =?us-ascii?Q?OOUsecok60L++LpWRIEH92M1AD1JlwTnE4CDp39cUHGDquAqXME+WzXgg/7B?=
 =?us-ascii?Q?Q++nTPjPNeRyW1p/fXF/h2G9snDxP01Wm2jU1/ytSzJbxdtlrEweQ0ZSUOYn?=
 =?us-ascii?Q?psYj3wpdBqbrNK3ZXj7EhEGIFbeVgV7JQDyIZHTmWef+3HImhmZJNmAOCGMj?=
 =?us-ascii?Q?/UxZMk3yVyRRy25MJ7UMjHrhS+4CiwfP+1ekxDmfN+60bV0FUn7eHUdGtyXe?=
 =?us-ascii?Q?CCqRA1aUdys7nkT+vrjTxglwXJro15eKe1KWAx5MvD4DHajjRw7HG+d93Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:31:00.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5eb123-5d0c-4fda-9202-08dd87da7b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

Sample warnings generated with 'make W=1':
arch/x86/mm/pgtable.c:623: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
... so on

Add missing parameter documentation in page table functions to
fix kernel-doc warnings.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/mm/pgtable.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f7ae44d3dd9e..8a5bc4545ad3 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -614,7 +614,7 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
- * @reserve - size of hole to reserve
+ * @reserve: Size of hole to reserve.
  *
  * Can be used to relocate the fixmap area and poke a hole in the top
  * of kernel address space to make room for a hypervisor.
@@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 #ifdef CONFIG_X86_5LEVEL
 /**
  * p4d_set_huge - setup kernel P4D mapping
+ * @p4d: Pointer to a p4d entry.
+ * @addr: Virtual Address associated with p4d.
+ * @prot: Protection bits to use.
  *
  * No 512GB pages yet -- always return 0
  */
@@ -675,8 +678,9 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 
 /**
  * p4d_clear_huge - clear kernel P4D mapping when it is set
+ * @p4d: Pointer to the p4d entry to clear.
  *
- * No 512GB pages yet -- always return 0
+ * No 512GB pages yet -- do nothing
  */
 void p4d_clear_huge(p4d_t *p4d)
 {
@@ -685,6 +689,9 @@ void p4d_clear_huge(p4d_t *p4d)
 
 /**
  * pud_set_huge - setup kernel PUD mapping
+ * @pud: Pointer to a pud entry.
+ * @addr: Virtual Address associated with pud.
+ * @prot: Protection bits to use.
  *
  * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
  * function sets up a huge page only if the complete range has the same MTRR
@@ -716,6 +723,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 
 /**
  * pmd_set_huge - setup kernel PMD mapping
+ * @pmd: Pointer to a pmd entry.
+ * @addr: Virtual Address associated with pmd.
+ * @prot: Protection bits to use.
  *
  * See text over pud_set_huge() above.
  *
@@ -745,6 +755,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 
 /**
  * pud_clear_huge - clear kernel PUD mapping when it is set
+ * @pud: Pointer to the pud entry to clear.
  *
  * Returns 1 on success and 0 on failure (no PUD map is found).
  */
@@ -760,6 +771,7 @@ int pud_clear_huge(pud_t *pud)
 
 /**
  * pmd_clear_huge - clear kernel PMD mapping when it is set
+ * @pmd: Pointer to the pmd entry to clear.
  *
  * Returns 1 on success and 0 on failure (no PMD map is found).
  */
-- 
2.34.1



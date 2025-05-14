Return-Path: <linux-pm+bounces-27113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D47AB630C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821E119E5FFB
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75E1FC7E7;
	Wed, 14 May 2025 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ROzCPoX0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A013D539;
	Wed, 14 May 2025 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204084; cv=fail; b=f5o1VlipL0+ICu5dWOHLwTFNyjawodtg9tMUZSDt7wloKK5JCtSTLUz01jOajj7CIiMYhCZFu0YN8u2nbsxtOTK75Lv0NNRBmshU9kuIi7Z2NscWMpF+I4H39/hNHZWC41/O4NSoKGUg7L7jOCCL33uTvSEB+8m5CG0OD63AJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204084; c=relaxed/simple;
	bh=jkko+dSxlA3vu2foAHJTl6PspEMXghYR7EKmFVggUDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7cuMZ4ype0W4hBHW8c39fmXHM046rpzoW9QuasZnArfoWyTvjdJQYHhOP+iSS0K++mtLBrv3B0mozs6QUK+oYsvbjGas+bg1kOH6e16o9RWyRMnVuLFoddSuSiBwC0ginPgea728qNC0Ud7tnbIaff+F+dqJFaPfLOYpIfkGRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ROzCPoX0; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGCH8uoUZ0aS4Znjt7Ga58OMnySk/4DCAG0l+L92mXfO5p8Soa6xsOc1K8ZXsmVQW4w9zMKw8l0mN2XnaezApAF0CQstXBWD3NSp1V2cZp5OTM4P6dXc3b6Bj/QJUGwwR2y7TYUT2SezSnl4LK2Y+v/DUPxYwxgLba0018jTSQkPfcUYSSDl76BjIIJtZDVofZtWnt5yVxQW2dCwmmfpvsaVhjKOadIXy7PFV/exu9dtVSTKE0Dg9CtIrE6UsAEsfJDC1x+FtErNm/437qoJLjOcNsURQwBa/jzAuG1X7LlYLJ72Ic7ysxl3VYsxjCFWh33NUkCwu4JiFGJbdAULAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNz3cMNZ3ElbEyfvYMkG7IbScQP2YRAHZ/MKAr3/a8M=;
 b=r0qejjBYcMAkZF/MMZZHwkyTjAQBP6TO2y+Qc3YQ6FlLA/rLYOlGG5I6m0P8sAE5jgZVUu2dZ/WJGXwjnp34KvkK5odmM5vJBGJSnTSpePrRwzL2DWrh7iWyoQixu/0kUH6RwThEK8fXVXYtOMeh4jmmiFRPob4R6PEKIpxf/pB3AA/rnjKlo8TuE4XNYRdAvaDUCF0irM5GYeOo9Ko9HCLxeVdC020zywjb8wAjL9JfDR8kkmnNEzSJ6ZXUfx4az4Bj2fBgNTiKaXE/Zi5l3c52X0vzJjE7Nh9nTbVT4cAnlbDfOw4Yh/ajd5iJM32/WQAnqZOK1DWzhMt2t9EkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNz3cMNZ3ElbEyfvYMkG7IbScQP2YRAHZ/MKAr3/a8M=;
 b=ROzCPoX0R+lOYBFAyXTvZTEyiyx8SWfIS9mcxa8IVqEHNutahNHikoJOpegdp9u1M+qaEyRMNNZYQTvIvo2ekAW+vCDZLG/XwxI2JLqT/3hqWWmc9gv1Ys8gZ9ygT4jsOvQaNCCoE5f9op+pFgFOsoquUvY4EUHiAMuMBVL8lxo=
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 06:27:58 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::6d) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 06:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 06:27:58 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 01:27:51 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>, <sohil.mehta@intel.com>, <rui.zhang@intel.com>,
	<yuntao.wang@linux.dev>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterx@redhat.com>, <sandipan.das@amd.com>, <ak@linux.intel.com>,
	<rostedt@goodmis.org>
Subject: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc warnings
Date: Wed, 14 May 2025 06:26:36 +0000
Message-ID: <20250514062637.3287779-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0feb86a3-0b7a-4aba-853f-08dd92b077fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrpqlpFNwEQNGl6mPme+JaUbe9PPn3+qdUfj779afdVhsNJ2tXLwRxaLyo/K?=
 =?us-ascii?Q?PgXPImePmKp3SumsQgyMtjV9AO/UzqGEWJYrd5ud7iqryCs/wpN+4ot/Vhjh?=
 =?us-ascii?Q?Ff522AJUntRZRLF0jT3b3EWOYeh2sK+ClJJxpmFt1vp90cuIKOkBCCruZt4d?=
 =?us-ascii?Q?/3z0wXMGBljhx8NPe9AxVQ5yXna9T3EeNH9WIBvslfqmmoxaBrrNXAVaJw7H?=
 =?us-ascii?Q?KJ3BqXxTGKyiD30wk8nbBgxFrLthiaYU00ukL9IyX0jleu+wIkNWqpwDp/g3?=
 =?us-ascii?Q?PXavD/qS1UXlB0yc+dwjuU8R4HYlaACaSecoWTfBqgx/O3XDgp61ZAcNQSNU?=
 =?us-ascii?Q?KRLMU9kPbuMEXIsHcw7oE+fWwKjIy3t4da8JgSV7nPB0BsOr/+S0BnJtSy1m?=
 =?us-ascii?Q?avIqAEXqv4MM16n/Uval/Wl2yWxuX9xtW2fALzUVgoKpThvYaVDfxY9AjSAE?=
 =?us-ascii?Q?+Xtourk6kf/P3k6VKRiQZk6wjhW2JczEVEKYqKBaJuxNvDfZoJgEf9Dzrubc?=
 =?us-ascii?Q?n1wPbZt9UTaE5RgjgpBcFP3nvSZ6I8RJnnxsTXHqK5mDeS/frUTibbRjyl1x?=
 =?us-ascii?Q?gSAqJcSnUVoVxIM32Y/TncMqD3rYybWjoar41/IIljUbNlsEIGGgNfrA2QCM?=
 =?us-ascii?Q?+up6spFJARi5cWImq7cQMF/lfvgil9r9HHr5c46Okazdx4HU803RDWYzvga5?=
 =?us-ascii?Q?nv0qWUu2P/o1V5GhJCgofE6aTkFBsGNsgqUlCw6e00xmmo7MW22U1KqF3MEK?=
 =?us-ascii?Q?p5KRLiSKwLZx+2cm0Jj2DaZNZBQ43uUT3OKc2zMLMdGfJIVQ4L0QbOP1jOJ0?=
 =?us-ascii?Q?WSn0GfR01DNxLZ92APVVW30ccL+s0Ky17B5u/smoAxFAtfLzJRdLap0RqXuM?=
 =?us-ascii?Q?aBXqdMd47J45Q1pscWXD7KB4lZkKYIXjWDBcHCQR+RUqbdXGg+TgHEYp+0tW?=
 =?us-ascii?Q?7c8nmdoTBBIAwD+uJUCpvbwNNh0zl/jAjjVpDvlCR3PazluFbT8MTXZCJLvS?=
 =?us-ascii?Q?zngfK294f7iGJKvzIphfuP3nrk/l2PGgqk6GOApQXrNISutOnUOok49maKSO?=
 =?us-ascii?Q?giujgcorvNZgObKiaCob6AXdhw7QJ+KovQkILr5ALoIQFHpTby0htJc8hBQF?=
 =?us-ascii?Q?UpfDSPFy3UdiIhtoSatS9oI4m9+5LfaPrABSh1gf285ba0Lg0XNx8rZv38N3?=
 =?us-ascii?Q?NddS31yOfWyTPvnZHZhbY8S+lD3mePrEQJGScgkXMWoLEdMENOxOp3IG+0GW?=
 =?us-ascii?Q?Im1HlRfMtH19P06hAHq+XgIK+H99shamgDYVQI08K6iDXxNdIsKPmYVYFnsH?=
 =?us-ascii?Q?SyL6E9K5WjES4Lx845yh26feKnrnCe2OSC1Dv9KeBuItQIEkdWjIHAZrDj7R?=
 =?us-ascii?Q?8x/y5oEdjDvRqFuK7MOfVFZbrVhKL80DPEe2KnNnhAhE4o2QXwNZ08acVE0V?=
 =?us-ascii?Q?N1CPqcLGAfSfmVgpR9G8g/vAf6jaAY5YwWpnJ8jxSKiE//R9J/wx+Do7IsYE?=
 =?us-ascii?Q?GPVcay7VwX28AMPkO+KPeNAi+G00dt9S//JAggj6+iiru9WCslIOmGJVgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:27:58.0797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feb86a3-0b7a-4aba-853f-08dd92b077fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

Warnings generated with 'make W=1':
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



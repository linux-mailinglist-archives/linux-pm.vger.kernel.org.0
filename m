Return-Path: <linux-pm+bounces-27114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6ECAB6314
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F138633A6
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 06:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B51FECAD;
	Wed, 14 May 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R64Cv5HY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48E1FC7E7;
	Wed, 14 May 2025 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204105; cv=fail; b=sDYM09peTZzbGfuy3aKzOO4BPC3r4lj6ucKmfDo2io/i3SS2Yv3BAVudOlC9p2U5K1sic3Q3LBeu3NjIxUDXhkczuCuLZrjUQJHHzEPZSG+75vCiPuo/Tkp3axsqUqz++rt4F78OsUReIK86x9LASUDaa/Zb6/g/pKe9I5nM/1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204105; c=relaxed/simple;
	bh=Z7xTmHGHmx5BNaLNtoW2diBS4K1Xe6MsfcHLjWg8QuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/FSngXD5r9LMNJnARk88uMZ8Z9fWmAyS8R/FntNc5FfMQGUJWgKWCThkzWNDLBwfYtdXd+ZoKKPPipZ/MsYdqeHrDMZ3WK+NE0Ykqv7rxEtNIeQ2JqwdEmEZ8zbN4HfIFkn4UtZbdQxbYiRRONC+trwCoZwkH6oyZMQtnjeOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R64Cv5HY; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtYmlPdNDxq+H3e2oQZM+LWztxcV4rCSUuIPiKbjHp9gsW8QL1LbdYs5t+NCbX2CVuSTNCiHuDwTxmFJ5e0eAZqH1DKy/3f1gEaa+An4hVoWn4EsxO9KkA+icwNBY0QTJ1G/pvbU7Yl+6/BkYYE7MD7LCKu2Vdu14Zat5GiuvE/gaHiCibWfzinOBwYXd2OAL+JovsPKYfY1zcqGF+qOPdz0/1zX/CViyLL9WZWDer9nVHGj/18iYoFopoGXVIa+6MrTRPIrSsKpv5KdGp+clmjR0RSuUJw4vMUDnNOb7JrUSk2v9qPHj9PmAh5eU5RqtrL4WejO/E+zL1eam8PACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGB+WOQ1w9fra0y8sdOvMFeuhitJp2O92INYOiEp1RM=;
 b=JCoSzgDmTwPGRdHfcgLzG0YXkJI3ZPMtBw8C3ljj60hqAY45FIm3V5Z6mziVBSBsuWEuJaDXRw1Dn4Af4G7lW0vJntcHyhmwZ6Xm6rf15TS/u2tFVPrWPe773NfaXN1FUcN1KcNPpDnQcPjiwu7pp+N9KhJ1gjADuFDk4cm/TQRXC41NwWn1PP9yUwUo5el0QOywJ7ohrItNnd7B/cZXOwrWH77951UNdaWfEBK4EHIdn5Nddbn1PbWe5dnAGUCoasFjPFgZPMldYZIDjx2G5gA8qMkO+wLHaWULA02j6ZnGGQxAwy3VecGsWyWICDWcINC5LBJQwPsu7zGH+YgKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGB+WOQ1w9fra0y8sdOvMFeuhitJp2O92INYOiEp1RM=;
 b=R64Cv5HYGQE45TsVWQcd646n4G9UaksKSOOQguJZF6FhvW7KXzdpcOTM3RvptPvH3z8ONBQSOXBhunXv3pxRjQxkd+obH8pPeQwX13c33BdEPdRQgvmT6VE8aVbHYZyJ1NkOwnqPuS+tNmiuwNZkV/IS5nyV8OtLYP1CBmBDnII=
Received: from SN7PR04CA0034.namprd04.prod.outlook.com (2603:10b6:806:120::9)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 06:28:19 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::ef) by SN7PR04CA0034.outlook.office365.com
 (2603:10b6:806:120::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 06:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 06:28:19 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 01:28:12 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>, <sohil.mehta@intel.com>, <rui.zhang@intel.com>,
	<yuntao.wang@linux.dev>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterx@redhat.com>, <sandipan.das@amd.com>, <ak@linux.intel.com>,
	<rostedt@goodmis.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH RESEND 2/4] x86/power: hibernate: Fix W=1 build kernel-doc warnings
Date: Wed, 14 May 2025 06:26:38 +0000
Message-ID: <20250514062637.3287779-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514062637.3287779-1-shivankg@amd.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: b8be5f61-c0b5-4fbd-57b2-08dd92b08480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLVIegvuGEhRLylhE48clljTM6xKiSLqZMDnLJ/TpWPSpSXeqXbSNJ3tkh+9?=
 =?us-ascii?Q?fGWQS7WORLTPCazKYCT27ORzW/iXidzQtF5HVQBCy+uYIvwxJDsaBxD3D/hN?=
 =?us-ascii?Q?xGTFD07XICow4naF1E5w/w/qhFYRYmltOtSpJRCuOINqWqsNLTQbJjEnNlL0?=
 =?us-ascii?Q?XR/ubT8H73bWnSWR70BMfQXWYJDtjqcS4ZTwECUfb2ARhXQP4APt01pvrPuk?=
 =?us-ascii?Q?sWAhhO6aeXd0FHHvYZLhxK1KBa+I+7dhKH5MmclA/YWEs5j/gSyJYmaDQcON?=
 =?us-ascii?Q?+g+tegr4p/gqTLaZEPrY9W6mK5rKSZBepHhvSmUDVAFWriM6aKasu0nCYpri?=
 =?us-ascii?Q?pJXcrDt7erPw3xC5y7PEaMotv6J2/3Zhj7Spb3DDVWN3DMjYBWXa9zdr8Rme?=
 =?us-ascii?Q?qhSHEBbdQ66IJODnG9lJDNrCnsp++PzguR7T8fAxFkCFaUBX4qSeB6EJlSOF?=
 =?us-ascii?Q?MVUT1gwmrIYvV+XZl+NzVNj25OG2U3cLtVhJLbcBGiH8NCj2mtBOeD5Xu7v9?=
 =?us-ascii?Q?Mh8T2ti5O2BCtQWny6m7op5T8LtGTTjvsipiWMqg42arfTwzW49DTXjmuOuj?=
 =?us-ascii?Q?skbwSLuyoOEsHYYpglcbM0jZ439XD97+AEjZSUjJQlg30bXkQ6uY5MOKcuAI?=
 =?us-ascii?Q?ET1q8x0fHWmcyX6J1wCg+SJZZYQ3AWnCUKy+rSnnU4lJCPAoKFGkF93a0kR2?=
 =?us-ascii?Q?OMzm8NAD2D/mimkhSFaTV5FIIBe+9h6dQBLFEyFikcApbr9+dyTdUUYNvEyj?=
 =?us-ascii?Q?XW7FyIvqcFLy+E8NDhyBpwV1dvohcmDTyYECUgm3DZQ6FciXBdHWpgGTgJVB?=
 =?us-ascii?Q?tAaTxRfpB5jmDwaEYDyZwMZ+cE777tVw009DFcWMAindyHDLR4t9Ie0/dQoc?=
 =?us-ascii?Q?cq/VbUq/9zZLBbenvY7lnwwW4Qhclp+t1JxpRQYsAMYG7Q6YVYxJ6SASIxj2?=
 =?us-ascii?Q?zGeiAIIAUallJ2YPPqhyH2TeS+nPQd7B20t/hccVOuP6s3qs8mHeyU4Yk3VQ?=
 =?us-ascii?Q?cajORSfRQQCWyRWqU7PXjZBzG4lTEcmHGqutQUvMRiem97qqJR61Usb/XGGs?=
 =?us-ascii?Q?oOeO80NTmFVMwPTk3kVG3NsdZq8R204TjqQEHGHRJ2/x7mO5mZqA4al+HnKz?=
 =?us-ascii?Q?OG2+KpX08rga4Lp8y8YlQlPYtg2+NNKpXh87I4WBbBZBn0OlTTIEEye1sZ6j?=
 =?us-ascii?Q?siMKg0Y3Wa4p6fwFUQpQiFr0jWz6ZQMlsGDeKwXVcQ1hIc+ByVFGcpTI+gRY?=
 =?us-ascii?Q?Cy15fvHFdx1a4mi/FcTfSCAv1l6PpkGStATj6YuADKr6z4dDJrpmPpvCTtoY?=
 =?us-ascii?Q?MPAbxmsA0c+n+k4wopABMqxh4rVm37eDHPsFq24VSXzBAtMt++YSsMu3ZAEy?=
 =?us-ascii?Q?+1cTBSTk/vjwQPBvj3BfqwiZPtdN669GFLvSq+X4dza0sHs61yDmiBUFKSRq?=
 =?us-ascii?Q?zQiE7XHmtTBaHow5+iGceGt3kJ6GTyiAjyDDll2QPEoVKdolMdKGktLhHPvr?=
 =?us-ascii?Q?yhqwasi71zSd4Xow6EH+DK+h8C+zVcCJRSW6aT7hLwBeJL5f4QhSeKQgOg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:28:19.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8be5f61-c0b5-4fbd-57b2-08dd92b08480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961

Warnings generated with 'make W=1':
arch/x86/power/hibernate.c:47: warning: Function parameter or struct member 'pfn' not described in 'pfn_is_nosave'
arch/x86/power/hibernate.c:92: warning: Function parameter or struct member 'max_size' not described in 'arch_hibernation_header_save'

Add missing parameter documentation in hibernate functions to
fix kernel-doc warnings.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/power/hibernate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 5b81d19cd114..a7c23f2a58c9 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -42,6 +42,7 @@ unsigned long relocated_restore_code __visible;
 
 /**
  *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ *	@pfn: the page frame number to check.
  */
 int pfn_is_nosave(unsigned long pfn)
 {
@@ -86,7 +87,10 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
  *		of a hibernation image header
- *	@addr: address to save the data at
+ *	@addr: address where architecture specific header data will be saved.
+ *	@max_size: maximum size of architecture specific data in hibernation header.
+ *
+ *	Return: 0 on success, -EOVERFLOW if max_size is insufficient.
  */
 int arch_hibernation_header_save(void *addr, unsigned int max_size)
 {
-- 
2.34.1



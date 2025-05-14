Return-Path: <linux-pm+bounces-27116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DBAB6319
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C774D162AE2
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DD1FE474;
	Wed, 14 May 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0rvArIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBF1FC7E7;
	Wed, 14 May 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204138; cv=fail; b=kf0j1H+Ukqn4reOrxd4D1XfiadttJbdU0eb3Z/x9DHQtNfNzw8X9hff1G3h2xJz3kyBaqvSQhu23EPJD7S1kcMN1GfnWvi1I4w6ZwFfsSftnktyDy8ca5GqDmQWRNq1He3Jr7LvGHCGmDjVYtuTbQUifqq2nQ487tVei+F65jw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204138; c=relaxed/simple;
	bh=CCMf4WsaLhz9e6nnpNse4SCP6G700qLNV0Q/DOzW/m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6wWlwFWami9PBSMFB8fctSZJHUrCdBYXXg+vp7d+MWHDg+1UupsEsqRnAac1TNriTgZWX9QlH5e5ey3X73jnjeO/NYVkkcwpkR1cGPC3Hrln7Aij1zA4b0gbfLawr0RA7UdkgoeYFUZszYulHz+EH//0FXFZNhm/8TJz8R+TgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0rvArIo; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ+OvbLtiAKu1nhlW1UKAfNj/q6gp34YYWTrWffghhI688xA66NGGWifX+J7sxs21nt+rVGs832U32XvJrN4/DMRAAdw6ETejOGsyEsPQ0ZofjjbrcMgc7QaxXhIAvRizor88KhXD+Ax63cRYmXT0yCNbNq5KgBKWVDRD/EYXRRcjAha1cVQFf1d1xDJ/+KHbpLxYvI6drFK5dk+sURley19UZPNmg2DHuQVkN8H3b0Fn1FRldhf7NT/8qPDY/sKLDRrkuiDkNG6g7Fxt5WiKXoSukgETME/7dWYhftZFVTvgfBX5jGV+Mlu53tauQlyt/RY48TbOlM9hriG26eiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cLAhnGR2pw9ZZ6or1ESe1Y/oAiVS6Dbb/g04RDC78w=;
 b=xgijx41KJYhKJIGi8EmkWUj6Fn+w3io34cVEHiRXRFLkzKYr1VToS3Sx4lHOrKv8dqjSyHjIbsDjHHvvpgewyd26V2JHO6Jm3Ar7sBjPXE8i9XNGhBfLO7f4m7rCawZ1YBpSCf33iC5bxUQF9ta1h+5En5cEq5gS2qR7B0m7td/LoXnfBB+mPUFsvxjGKImrElbn5r8jaMhgh6E83fFp5oKLGEfyWU0/UJfbhfVy5WYF3M/K15UEqQdOnPpU3mgBBLEtfVYyZSG4eszNx2nHLdh7GunncbYdqL/nojCbULeWIAA5Pm73WHXwuMNaSM8UA4/1a8IokuKJkgH+7E4OMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cLAhnGR2pw9ZZ6or1ESe1Y/oAiVS6Dbb/g04RDC78w=;
 b=y0rvArIoPCthyld8W1VKUiSWlFMt4yd/ggqMR6agixX5x5WWhE2CTCkS/+jiVM+z7zLtpuR3sPKlmJW1x4pOniWbtOU6p25XrT0OfDwZIStkmZV0to8+pk5dE61nwksdm07KqqyAWWWCwQkg8KOnhyolCWMBpEQ6THq4rISY9Bw=
Received: from SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::8)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 06:28:50 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::a9) by SA1P222CA0111.outlook.office365.com
 (2603:10b6:806:3c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Wed,
 14 May 2025 06:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 06:28:49 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 01:28:43 -0500
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
Subject: [PATCH RESEND 4/4] x86/apic: Fix W=1 build kernel-doc warning
Date: Wed, 14 May 2025 06:26:42 +0000
Message-ID: <20250514062637.3287779-4-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 374cd920-3abe-4d34-bab3-08dd92b096cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTogHDvQtWPSET96QicYkfSRLoVAKMj2Mk1O5m4MdOJvRHOIz8E2LRFGSlsX?=
 =?us-ascii?Q?Je6zyWowhEXyEYG4ZmFeOwyx78VfezaVTXQh3P8fCdrjOLApTVcNTlP0VUNb?=
 =?us-ascii?Q?erv8W59AGhkxPsU0t33WHO/xsEKxVSU976f1pw52313JP0LD5t5fTnbK0L9Z?=
 =?us-ascii?Q?7rdvjcpwQoRtKOI7VXAFs++h5UVm651wWAqS8NnG3YvJMReHYy+njeZSQ60P?=
 =?us-ascii?Q?GP0umpW/OGWlN6MISclaPYOQJ7kIPzLt01lAu22ON2bAgr+XxUqVI3oBGlGo?=
 =?us-ascii?Q?CrS/2OpkVOo+u6foy+JX/x9teyBV/m6ekE0qhZmw0nJkAfELijDSm9tysZIN?=
 =?us-ascii?Q?lW1oz3JYf3tuSwcDIJ0VoBNJ4xnQ9q9iuqjNHRX9boO2g5mgQH9+dLv5SJpN?=
 =?us-ascii?Q?won1+VfQmLB/VpGeUzp/KMUfVhVDdMKh3zQehy4vsCDUTbM2MQUPhsJe/MW+?=
 =?us-ascii?Q?TDzJe5D3J4qYr1/wgwbWD4RwqLZ72/7phlqxQTPCPyAIaMgXVWXbwZuBn3hu?=
 =?us-ascii?Q?Crh3zqW+49LxBV+suqxIBqimHMglHSD6R5F0tEBPS32kXHZMt0KgkBZVwaqf?=
 =?us-ascii?Q?WjrEAWEFAev38UBdfjFVhwgz7h9/UB1I0qoj95MMDokHH4t4yBml2V3aSbXk?=
 =?us-ascii?Q?Yt/mHAIkrB4LzAQEwj3Bb73s9SXjyqm54AiBlT02XHE4ZWwL5NFIzXgV8/PQ?=
 =?us-ascii?Q?90Ng381CQ319Gub+WF/d45wtU+GiOOxwhbQrvaleAaD2gerdAJCooc8LfP3B?=
 =?us-ascii?Q?NmuTqObHA2IP0+EckTkkLNx5j58w2nH90UAndENI3px6pbI7/fUljFZjeykH?=
 =?us-ascii?Q?GHb60GomM1nG48oPiRxoOm5Xn1Cu9RLEs5/EyHhShWFW4G1oYteXqLvMGphw?=
 =?us-ascii?Q?yRBMdA/ZrADHY4aYkWdM8JS+0I+XkacdwIk1/Kkn7YPrBPtrDGUHuxw2SYEk?=
 =?us-ascii?Q?kNcEBgaBzAlR0ebZ9fIV+9FZxUh9iThDoWH+C7n6WZnRwSwBV+4mDHiMwrJO?=
 =?us-ascii?Q?FMXQAUtr5Z4HBfdZTrfxDPjGKeHxbEMITTmwsG17Aib5CefC/qX3Y5ts2MJS?=
 =?us-ascii?Q?1e3I7BVNQ9B4Lrh1fkpObof7A8znTwvA/JAxxvgChsGs4uk7De0DljTw0Y0E?=
 =?us-ascii?Q?xu/MjV13r4AT7RdtdEe6Dm+WhNg1dxaD30eTQKIu3/exPBGQzo81KasAvqcB?=
 =?us-ascii?Q?BPJmpvFaXqh28ArH2kDK2j/VgJBevjGz1bgpvsB6UQftLIhXqR9z4V4ZMj5D?=
 =?us-ascii?Q?RD6JIy+X6TVoZlpIZPC1vqZMpSZVlOKR2ee1nGsCOOM2Yy5vXli/a1ksdo4M?=
 =?us-ascii?Q?xBarRms+uWaFTygayUT8myjRSPekLbfLEyUaMbWrpr+gHMOHVPPJrMeJBjbY?=
 =?us-ascii?Q?urP5M9mcmeNEA2iDJdecBaTH1fUUPSYaTogpUEfRtLQY85gXzIYikV87eNTI?=
 =?us-ascii?Q?BiasYjPve2C/ge7bBbaPD0DCPCxcA1FrUqmoP9mIJAkYmN3KNoQkFFi9gbae?=
 =?us-ascii?Q?7Sj8+8HIFR7oW9lsUT44utAs6gUsZDLTZ0V8f1pPoRZQB4KHQSqZP6SK9g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:28:49.7778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374cd920-3abe-4d34-bab3-08dd92b096cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

Building the kernel with W=1 generates the following warning:

arch/x86/kernel/apic/apic.c:2140: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
arch/x86/kernel/apic/apic.c:2140: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead

Fix the description format to fix the warning.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/kernel/apic/apic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 62584a347931..f888a28d400f 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2128,9 +2128,10 @@ static noinline void handle_spurious_interrupt(u8 vector)
 }
 
 /**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
- * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
+ * DEFINE_IDTENTRY_IRQ - Handler for spurious interrupts
+ * @spurious_interrupt: Catch all for interrupts raised on unused vectors
+ * regs:	Pointer to pt_regs on stack
+ * vector:	The vector number
  *
  * This is invoked from ASM entry code to catch all interrupts which
  * trigger on an entry which is routed to the common_spurious idtentry
-- 
2.34.1



Return-Path: <linux-pm+bounces-15482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B836D99927E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58FE1C24401
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179711D0417;
	Thu, 10 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TADmxxTA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711531CF2B9;
	Thu, 10 Oct 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589070; cv=fail; b=svjMN0PVUz9r4d3Dfc63d4uc/xE+7sU2BqwzyrmaWKMA5TdQboHH+gkDgz0jUzOcq24GGHJA8+XaQwsgf/t0lHyOxho1rwQN8/hdDoxCNE6XRNe2qb0gCe+vvc7luGLwR5saXPDJXZSuZpC+F5ld0KvTwx9suxwirmmHkeKypQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589070; c=relaxed/simple;
	bh=JUGQuUQjs1ZFgp5QIQnERFeT+fFWgmOCyJBP4RP5Nas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7Qsw8sfIWTnN8rptbcxpHEo7SLgCGMH5g1OBxzsZs6nZkG+WDIipQ/JggW7go6EI9mBqFMa56lfKhlfD46ulS+RnTBQ4HK5MkdWjERlqG0kY/TFIBh5PXfRH3fGKFQR5pFaJ/m8WngXnDWf2xtCcSRewycU8WlYIbq2fAAPluY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TADmxxTA; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwJ2pJAGlgWVMIqifel4MKRdJFXnrhzdLkn9uWhzoT46//VtG0m2NcCeMc41bl73j6DeiDPsu1mH85ToREzLpyeMznSyp0ZxVAEYFJdG4Oig9PC98vzjbH88Zuqz8dgWwsPqPbnf+z2sH4rtaRajaX1/czu0s6pYkdhx10LiX9aPtTJK7Ez3Z9iFolTCYESKATPNPZx2GDPolGlks5S2TfWKOzoq9hdIQedLUEc/V4WUQsmM2AipHlGHpbhOn7KkV0uChmNHIoyHNC1Rhuf5/C+NCibiFx/+TfdBgaeUPuwkNko/3dqGKxKA4yt02ajmGnFLuMOvXtngY1wLHtGfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IscyHjX4ScGr1Xp2u1eW5BQJRksPYchH4CKn0wHE5JQ=;
 b=u27TcAZQQHLvxEtWxFiKb8RDHaPHLQKjo72EXomh6gTxSoqln9BrQjowP7yXRoIrA9+Jh673QRVNOF3mWEQo0E/OpsJHDyn3MZHgDxLFeSghUzTVXQ54dBvwM42ekXexvlQsz8ScQ4O4yqdwWHGOIlC83NLA6tPHaEHfDWYO8DzmtYINZm/hxCEK6A+jYarQUmUmY2t4n6XA9PyQjM8E5+NYaG+/6p79aT6pluNG9xPLDs9pYiHcr8w8u8PDJoVMg5s6tIKL4+zGz4rsd9qPqIP0D7q5J9FuyS3WFB7iKFmCdPcX42O0tptm9UAkt+IbpLOag+y77MW9pQiwn9Rn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IscyHjX4ScGr1Xp2u1eW5BQJRksPYchH4CKn0wHE5JQ=;
 b=TADmxxTARWSurG5dPxe0KLGCooThjY5YTepwTdlFBoGtKipYJavoze+f8EHpq5FQNpdImKlFcXfBissNt5DAKSmpDd9bjs4f4Ahtp+z9HgmK1QQnHUZRU3Ma5RVfN+qrEog+46jkLWXfNpMKOZWSVGrqozTj6pkDHwTh2mi3mg4=
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:42 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::bf) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Thu, 10 Oct 2024 14:36:54 -0500
Message-ID: <20241010193705.10362-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fb3897-0cdc-4734-bbcd-08dce9630235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PyqoU+T+3ci+uuWXQVdL9V42YavydJ7APSqi+CFbLcDCV3wdHWl9VNx7VlIE?=
 =?us-ascii?Q?sEFlSBNrEXp6KJQSfHwvsLI+GEYCVZV8p3hLZstInc2/8Ptjjhvtt9xJY+fP?=
 =?us-ascii?Q?59w+LTiIp9iJFC2gFUbH/CQl7Kzfz/od2JYWX6cP/5lHvWN/K5WNhOmYvTVp?=
 =?us-ascii?Q?sqtMuXXB40/6ieo7VIlxk9CCzSbugdKRr/Fjx7I0jrFW3tWRcfBHsh9MHeJS?=
 =?us-ascii?Q?E2p+hIuYj3TaWaCzOU/YZO+BXrZ5Lr/kVXs5YzbL5lVo1MvvM88xkuoTT4iN?=
 =?us-ascii?Q?9TJMZST2y3OwUkt0ZQFHRn36GOS1VnUQ0AONi96+nekwBkWrYoIfxDloyrOh?=
 =?us-ascii?Q?km1ABn+k94+LvydvVg/Jkj+TRsaHV3A9jKuWNOIWvOluhoIO1Ad88nIF9KWz?=
 =?us-ascii?Q?TYLhuVynHZIcLltJgbqiO6Zg8mjzqwl5+KBYuUxnJ0H2rLj9LFqGvzts5RY1?=
 =?us-ascii?Q?O8aQZMiqlQj6SBAvOP2atPmC+42rMOY2Q5K+oz0BZDctr/8k9Q1/wd8cr+sg?=
 =?us-ascii?Q?0pmAsRN6qNzgOa5HSccOjiy9wfhVbpKhT35oBa8vpW5ot7VrPRyD+XaPN2R0?=
 =?us-ascii?Q?y/vzb3+A1UyqW6z0xlWmIJBSCX/97juHqgAVf1iUjPibEsXSWQ0T72DPYb1u?=
 =?us-ascii?Q?z8B6z4GQEEcevxvFL5pRfqLYH7sDuStEgqR+Zr6eebRUhvcF9uNhHgxr5zaY?=
 =?us-ascii?Q?gmy6U3upTwm3rnKGb5HKKSLmGROML5yUmMdqWHVafY4FDyK0MnaF1HcmbjKs?=
 =?us-ascii?Q?67cHZs7MOiwLplTX2rku6b2PJU0qETMuk6wt4GTxu3CDct70Mc3Q/sLRuN3i?=
 =?us-ascii?Q?gh5oE+JpJ6yXk4D9205gOCs9OcpprhwJ+B14pCELJEosRt6njWQh69AztH/k?=
 =?us-ascii?Q?oFrdjHTkluRCUZ26YrnjlNZQhSm6Ug8Ct6Hyfo47V4TKC4i4ryHcyQ0abQqU?=
 =?us-ascii?Q?eoikv5DgVYSrVM31KDjslp9E2yyEPtCq+ENlt8LF6A0t9iwFyv2+mwKYku9R?=
 =?us-ascii?Q?41pQKLY+9p/JFOje+JA0MWNAy3k1SZvcFTXVJPSFdYurrWlDI7UEw2g+Gjvk?=
 =?us-ascii?Q?vmrDiw/DcpBp5mjg7ZmyzwO5b2LrbTBemUD6v70jk4urK0g5MElOvlLTCh7v?=
 =?us-ascii?Q?EzkBAO00UFtKcy7pCiL0RkNunRTGJchOXAoSh5LRkeosR9wegT8M1Rsa2BMH?=
 =?us-ascii?Q?gxbOXN9fW6Owb5wqKa9+8wW4yzlUyMo581DiJJnfivisBzTBo1QpvZ0Dc9qU?=
 =?us-ascii?Q?pV6oqoYLkxtDgoWTIhdCEsJ9MuNqrpAYsXjFdNDLbocbJWgDrGjN0EiV+DLh?=
 =?us-ascii?Q?jrX+qd9pOJXC/we8HdCT2jW8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:42.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fb3897-0cdc-4734-bbcd-08dce9630235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Make Perry Reviewer instead of Maintainer, he asked me to take
   over this series.
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..90094e064d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1083,6 +1083,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp.c
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.43.0



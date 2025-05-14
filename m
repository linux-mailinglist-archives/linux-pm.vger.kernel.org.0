Return-Path: <linux-pm+bounces-27115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB01AB6313
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CCA19E7B33
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA41FCFF1;
	Wed, 14 May 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JXldQ8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D21B0439;
	Wed, 14 May 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204123; cv=fail; b=gxVk1eKnrIgZdpjNYqOXFXop+e+pKd5XfUeHQqM+jcsAVAFXaAWckwsAuC9huSIMP6vyFYyxXMzSUNC0WEbkTyHdDAk2Vqsas5i6KiucE6mKxdedQVyDXriRcpEUNJaP+c/6Rl2L4C5tVGRkInwyrfkwSXGLSEmM5cD7q7Nu/Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204123; c=relaxed/simple;
	bh=o/e6yusEPpX5jR30Qzsc8DdV+2NJVtRHm0DQ79zzIKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr+MI+bJAaFssxKoJtFGNHdHanxIiWYvneXRV2fn//yP0Q2wRbx/ja5hXfkcOt6Cy4+Wp62g2Iw8Jku1EFJDGLJ5cI48T5pb5k8df56BFneo9TV2hQqZQbIHh5gAgJfQL7yGcf32/hJegSt6lJTaJ7TCwe0UykWb1ozqx7EOwJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JXldQ8S; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg09WV4IOFz5aP7YktALVep1c853WowxU5FEbA4II/k4A7T0HVDjHG7NrPMy5swyPoap7NvvQEQWYSdbbTV++G9SXWlfH0neAHXrtht3OLL7NVZjAtQTj9hevFqvySiQur7EU1eOqbHzHq0y3mHB8Zmci4JnIyC8pZI9M9ahYBTb5qBDZX4hsAeKHAsDGCe0NMbYnqU7lCr8y8Zjh4DVPUbSqcaBa6wm0uXbPIyIL8uEyG6KbO9ScGfUxqAE7fB1AmIJSCH5vzteAMeAZ/WWlyFGQ1519u5dSqRiV8F5KkGoNylzg+gqWCP70epip/YYuNfNBrbgcj2tBzLinjMhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwQf/Y6LVvVs3hUR+t75InacKHRfvwmIKRARbqkqUvU=;
 b=hLYJ8ebK83hAKtndpDSLPAFgMZL/DjTxndNBUuvlihUkVpeZmkf/l/Dr912iqM8WdKerMB2I5OV+trHpVXHK4pGHU+IvrFVheomJDZyYoVNCZEzicEF10LATcOvrYFw2KdnSQNSA0FygzkIgLuYYK0MQ2t0UCBnDsyNLwdhCWCQO/+v4yQe/vQ41vhoIg9l4z+0eNvJrJ/PewgFxOk5Xnkz8/TqT0MEKg2nSOxufzTi4pwez45y0d214bf/4JEvmrFXFg86XcZ3RT/9Jsj37daoYB3+KBHm9sf44xyKdqwCrlMdmkXc8lQiBG512r639wl6znuO7pQ/85tyJ+krQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwQf/Y6LVvVs3hUR+t75InacKHRfvwmIKRARbqkqUvU=;
 b=4JXldQ8SAhpOil1ES7GVgz7dbbaw8TZbZT6dHe08JUe9agM+qdvSMef2/ha2PfaKpeTJPM6JhsXiTeWbMy2/lLA6V2PWfK2c/OAcbQGa/vLPe0raK567iPpzYp1FSesKjRhw8GoHvdhGHbh1BT9VTWK11/bd2+OFrnf0O3eTsfE=
Received: from SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::12)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 06:28:39 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::91) by SA1P222CA0169.outlook.office365.com
 (2603:10b6:806:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Wed,
 14 May 2025 06:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 06:28:38 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 01:28:31 -0500
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
Subject: [PATCH RESEND 3/4] x86/mm/pat: Fix W=1 build kernel-doc warning
Date: Wed, 14 May 2025 06:26:40 +0000
Message-ID: <20250514062637.3287779-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f2a1c0-7bbf-458d-7d14-08dd92b08ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Cul/K55UdafvwImmvux4yzX2/HjPtR2otH75GY4K8Awo7SSoKmTPDDt7dbs?=
 =?us-ascii?Q?qq6WQP1azNevJBWZYMgUriZteVT7Y8+O5mAIV0nG7oUyUIxSiO2RFoWxSyyi?=
 =?us-ascii?Q?UCPuSB1lDRE1KbMV57+gPfTq2GOwCaJ2OTSRn2vyut6J+/4TI7rsicZjz07z?=
 =?us-ascii?Q?MRaaA8+PC2JMgyeA2CxG4/5Rpo0JmfILoFZdhQGKx/dPbOQC3YuYiokyYq8a?=
 =?us-ascii?Q?ygvmxf199B8FNI+khYCoPEBV6LOMKLrNrOPXuZvssIJ2ynfoPcD43fzuddwE?=
 =?us-ascii?Q?glp7kZuBMwNDgOGItJZldgBPpJwwUQChZN6MaSlWX9+6fQUoJh6gcBU+upzT?=
 =?us-ascii?Q?gcDMFq8TfvPF5cVxceALXO3Qd863PjwGPeyfLtzAhqEZay4R/rw/HMO/Jiq8?=
 =?us-ascii?Q?qbeRszBL6Z1y6CK1c7dVNebKRw+/ILhsGMJ7Aydrr+cSK+WCBrUW1vpHJw2P?=
 =?us-ascii?Q?kxMDNF5C1UE2MbPHvnIWBQrvzRfcDYAcZySKaPsH9iI6dUUTqC9MerEjS/tU?=
 =?us-ascii?Q?H1rKNxPRgZXmy68lwg3H5cTMU+5lhlL2GCF/yIo3IyAzuO4c2cCNDQsrA3H8?=
 =?us-ascii?Q?8ZnKUKgIzBg2sawehYOsNIH0JK5Kac3RQT3BkhfV4Ia0LRiZFbQliDnml1Hz?=
 =?us-ascii?Q?m/19px9H9pdLslTMmggEAv51Cjqu8sl+j7b0bsWaUX6uMHqepU95T7h0pRnb?=
 =?us-ascii?Q?qAa+gyeDb+tUCD16W5NdLOKHIFj0w5CHvS/We1OswAIar/FBL0UM9bqR2i+3?=
 =?us-ascii?Q?xeWW5UXEtoEd1ruNBL55sqZNd7hdQuik/NmwmVVjwRny3999jfyNm5ZE/+BV?=
 =?us-ascii?Q?9JBr9Cydnu+GEQMVeW82nte6ZN5PvfDVFBkIj1OddwGZu2COqqu2bKkiJed4?=
 =?us-ascii?Q?WZ6PTYw0plfr6EoiGna6daZLRLKlQfMbIsCqzzQlt9pW+bY648thGOMyjkuG?=
 =?us-ascii?Q?Pss4wdIrUXbVCEclFMH1TBeq4r/BDuzCe+K5CzQYjHYcydYssdcAXJkOKfOO?=
 =?us-ascii?Q?SfCgso47KW4toQWJSbqrvkQwOWZ9/o1Dc89AiARMkewwVL6YGfejh23ecsGd?=
 =?us-ascii?Q?IjoBw9EVe758a52mWUtfxwk6iPqyTtxB4COm0fKztMKqXRbLHcTav/0Whhx/?=
 =?us-ascii?Q?4oV7uJHFcT1frvUlizh36Kzthc5mHkGm9TJJGQ/r4QYxhjqKu9pdnMvKtdV0?=
 =?us-ascii?Q?sHs+3PT7qn59+6cvCrRwDUfmM5KCrRlIybYcddVf2YF3pLYn9c1rB3kq6GYV?=
 =?us-ascii?Q?gkDgro/WA/AR9SFBwOy2OrPhiUr1kVu4wyf7UuNpTrDeOXJbJ5MB+0uELypf?=
 =?us-ascii?Q?9b9gvkbUo7jeZQeYMk2r9LvC03ktq87cSJFNVk0DvYy85vO+dViQW5F3tf+m?=
 =?us-ascii?Q?Vx8z/ZtIEVvQwAMke3DoT1vgPElxc+K9RjHzZW/Eq+ncRwyDbXaJ9uYhz1sv?=
 =?us-ascii?Q?B0rBSLtV0sMnlVcKoQ0XeUTp2AwN6eEVilIYU6BUxQDi1Nv4BlWFIKMMXCip?=
 =?us-ascii?Q?dDuJxbMAbjdQKVzS2Arl2widccmf877KaAn2FeTbHGhTn1wHVJSbxVNhSg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:28:38.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f2a1c0-7bbf-458d-7d14-08dd92b08ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

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



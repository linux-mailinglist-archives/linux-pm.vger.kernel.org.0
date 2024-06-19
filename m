Return-Path: <linux-pm+bounces-9553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273890E6B0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2564283FB3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CB811F7;
	Wed, 19 Jun 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E59SYEe0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5137FBA1;
	Wed, 19 Jun 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788637; cv=fail; b=hsRUHbwgjsB1u29iAz3q9wTRtglEUdSjUI+KwRZjupryyANQQvonEXhUFjAE8BPlSh587SF7xh9Hzjmq3nVkADFJuYqZd7eC/RMImfBB8o8/P06VVaSVFnydpCPwYklV3o3xATFQEoYRvzqqy6ysl6/cUDqnZc5SCxM58dLJA4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788637; c=relaxed/simple;
	bh=PkYLlZjxfECQNAtTpwSLNaDDoS6fj9PfSinZeOrh2Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZiuk+ULiti5bjbHrYuA17cM16gaA/trFIvjhMTDc0/7fwH0sa65hSZYfH4XGXcBGU5bKXjGTRYnKyW3R8vPTX1xDS6uGpIMccQUsYXnbJxD3qpBpFFeSpGPkC7DtdP0BYBZxtdIpcwsrcMr+rBZwmc+2rvNfFv7G6beHhL5rKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E59SYEe0; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2cD9BqIGTCYfBB+dFUAUxUz4XAJFE8XUlMyEUPHfVWvapqr8XiK7AT3nBTocFTU/LUV7CBLaJ71GL+p9pMeRbEYYYr+/0aWHyeUFzwkO11D1fmV2wbGAVuQKkSptsmv5lho9P77/lzIiWo+vhKur9Xb4dpqCi1gULzSF+rvEazuhr760qx+iRWi6wiy45MDxOZpjOB+8Gk+7ex8lZ8q7T7HJo1HcvWyBNaLBF0bk1rFG7N3hUTBEOEIfkfxEdcckJY/ve7hEaL93rYcWXnkDPyWC2Hl6RmQcqHw6M6PrJe6n+DQ6b2bNBS3p8SbIN6cJmjptOk1AUmXGoKQbpQXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=C+NiccEJlCtgeqt9ELNA0IS9qQ6BnIhMXabP41F8JlrRXjXdl3r2+7QYnbX6u20BGGimlsncThzWJEWKEDg0CqdCzGYEamZzQCbBHwBUmzgIsu0tVhdFcqrZIG4AvEFj4C6nrj7YESyRPByeCE9Nll2J0xEGRaC/ofhftTnWEwec8XXHuEodScpUIdeTacnyPmgoVXXcgMSioFNsDxgGnytsbZwNpDuSMVdk7o7Vd5oDTUAWYzNtCax+zjaW8o5259QExDTFiZZf/PckGguVyO8PuGsq0jQh4KNx1vixsXhgIuRtKJnSFYUI4NNyR4O85Du+xT+hWv7D919Lr4X2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=E59SYEe0U+w6cJ0PJppOk8T9bCrDPFGae4INHixSVZXM5DofaRjaxrq+mkE4wtDCxGTeyHyP2xm2gkLts1Vjk7VxfcBMmddruLv5j4vgSONW2b3Hhf+TPldQEez4QIEIIHGRYWEKdQlJYISlf4SE3DSsIMRwPEYZRbhn7SPTX+o=
Received: from BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:17:11 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::c0) by BL0PR02CA0088.outlook.office365.com
 (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:01 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/9] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Wed, 19 Jun 2024 17:16:34 +0800
Message-ID: <4331daca6ee8913dd8e2b5325fe4d1600be66652.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c04e73-dadd-4aea-f9b2-08dc90409991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQ2r7mfMsODMwjqyACfsLbgZhlCjbEQ7Z8uhVmqQ6qdfTe0zzNkWMQAK48dU?=
 =?us-ascii?Q?IlVESwSusmI9qOpG3YLShL6XJN4J+heI+z30LyTl/r1EWtqfBvp3JcADQU2M?=
 =?us-ascii?Q?qOjix6Ht0XUuB9JgpRgnTxgj/dPXZ8ANdNp0foLVOVCYBTZmo17DHLkfdULL?=
 =?us-ascii?Q?YO98sUFbM76o2Gk/LksPB64c8Xhi/yBo2mBxxDQfbNBdRoFN+uZUIJ+Pum0B?=
 =?us-ascii?Q?RnGOR4Jv3KSBz3Xby0siRRlsB7xdA4yAXYOyosRfIZ6f1oORHKTHDcAoxOr+?=
 =?us-ascii?Q?gH+AGFZi7HW7WRNljN9sWG9O9FHrqKtBwRLwxaLCaf8G2UYItb22nbeBdA7s?=
 =?us-ascii?Q?3yehYEifYewjeMDtOsyE5LEA3dzdvhY3IfsLrL0yT2T3S0kGZL0OnYcCKuLc?=
 =?us-ascii?Q?15pyRbm8dZ/hF+rYXpE157CZehUdqvjLV+zeb6z87ogad5h+AcABLcdyymLt?=
 =?us-ascii?Q?CFxqk7J4Sv4IP5YxgPJr8l51aJ2xkZ+KOhpaXPc+h4N/83KxpoN1piHFCo+0?=
 =?us-ascii?Q?wKBIVguBSZ8UPW4bGBoaePWNDPKOrn7HUy7XkdoHgaCzaqSUndIKFbDiTPt6?=
 =?us-ascii?Q?/2zVnFE2YKTyDz6diljePhOTzjy0XJ3LqfahZwBRKcptpiOHdLEwHItzZ3Ta?=
 =?us-ascii?Q?4AsGQeUKyKDNEyGrhdh8iJa9V1OVclRBEM+P3dYRhmpoqBVvkjTomj4Z/71A?=
 =?us-ascii?Q?1CDrhiEku5bHvJA3qHEX1n3e8UbfS7lxiDDUHzeaBBteN/VS0r2pu3K8dkuQ?=
 =?us-ascii?Q?bVHNryQtqpznsJYOwz3wRj+vd5o8LV79WPzrxWtl0Hc0i1toKu+rYHZ5lSGK?=
 =?us-ascii?Q?Huoj4x0WawN1hX7VJ7kx8ilU76B0TwvbukHX1/tjQ49Fdjv4cy1GMUHBLLD9?=
 =?us-ascii?Q?LP3YiPNJI/Q8eohsWes1IZNhK0wSL9nQVb4Xz8bYYY2/JhALtyfciTgJfgKW?=
 =?us-ascii?Q?5aXwr9Bui02nWiPXg8euu3M5UWuhf0cJQBtQrSarMJJbpJt1bZwTb2ROVrTi?=
 =?us-ascii?Q?WN3kQIae9CanaqF2eYGUyyOMCFw9bVQzdQnzYfv5setY9OKgKb+3zrBQRwNX?=
 =?us-ascii?Q?mgMk9Oj6T+8BwkSyzWtax5mNSUi4AHEAM5l2YvltBLlwua1dAI1yLwHnlv7H?=
 =?us-ascii?Q?OlgHygzUFA0h14IwXjVr/rfWw68t0wddbEw+SgCuE4ryGTZqhF0bxysviVZv?=
 =?us-ascii?Q?0CNmsHJtmhT71qLNa6XI+Db2jVp4kUvwYjhXVpnSgVvJgeqkCnKrrE38hIEa?=
 =?us-ascii?Q?fl5VeAAu+rm0IT8N5CIMiitIsXLdOvA9Y5CG7hQv8jzxj0Mh8mmpIO5S39f9?=
 =?us-ascii?Q?TURiRVpoM/t5lU0lulsqD1Eipx3+lBd0ET/alsc+t4f7GKy/s3pafomuvXRE?=
 =?us-ascii?Q?Qc1wEgxWC0jVwCLv0o0yVKnscV0DSkH+B5d/HxA890f8/r3UYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:10.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c04e73-dadd-4aea-f9b2-08dc90409991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..384739d592af 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -781,6 +781,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..2fc82831bddd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,8 +50,6 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
-#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
-
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
-- 
2.34.1



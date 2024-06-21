Return-Path: <linux-pm+bounces-9777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA44912BC4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE3289458
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59C1667EA;
	Fri, 21 Jun 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3h34POZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B57167DB5;
	Fri, 21 Jun 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988688; cv=fail; b=CvW7UomLBVHVnRbLc/lUGyLtnS8jZfC3FDt61b7ujnXHEbYB8aopfZ9o+F6K901ZyUlwKrzZH1ZLEa7llj9oPcl3QU38l7GnMADMimiw62A+P9NBDSJbe0SoIJOxlPt1WmaTVvNCqoffVhKnuzW6/tKZAHn29ACL5v2fnzLYx/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988688; c=relaxed/simple;
	bh=PkYLlZjxfECQNAtTpwSLNaDDoS6fj9PfSinZeOrh2Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrHlThOXt2ou6QjlrG02l7xcDGZiMdUif/j1myiYCwT60DS3bOhrA9tBMfnpVYhq5Hor+1K+E+0m732jMbAMGzoUeCmUdgocPvLlxpKUNCGZvic3TP2kJjlW2HWA+w9hmCcM2SyvtzYbEUPlhiiX2tXzovEyfkKUlH+dZqJBu+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3h34POZr; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgtQ8A4M69UnBa8s4G6jy9iOHPSz3fp9MmFE/S+z1ljwFXALDxKmNvinnV90EbSFW892Mj04CQQ+ljgRTfPbk8qpmVtSJna4AzFhBuk3sszjrFHKX1smAJehCcDOtaElU3P5Oa4ct9QitCRzjsp5wNPIGLOyrKGLofcLz7GlfTDq/ATZ0kNTZgDE9ZH6F7jgn07jHZIYnVWBmkC8rGM+oo0pifKTvSeH61OxthZqEUwD9Q1wUkLgULQUpLuuatCfSdFLj74s+MgkWQAGRZu1DSOUZp0WjDpP/zXSYa/q8PQKd+pKktmJv64OWRULaL16gty+/LmuzY2q8jqMN8Pv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=fWFU3nHCoCFj04jYzNzU0wPJI9GCA2EuEQICcdryqxcoEWIkLH4u9l9Rfl4zVxg3+sryJ0DnklvU9T9en9S2xrIfiOGs3MWc/Pmo/oYTxC1AlQnnihFNURlmhpFpuidl0w6xlcwax7cVxrq0jjkVUTpodU4+smMBr7Rti1SaqmYVWOi5tl7uMymLRBsg1a4PcSvwR6DSLx/s64bOsJjE48jIzbK/9Xj+LXChw8rYBHRcFVU2c8hxqvv1RFiwECQmnLJhMTQ7Gp0fg3bIf9PTQ2XjM0Vm6/8Jz5yUMll6Ls+JHuyZrRElCesfRPEX4yirZK4w8ChnyECKNUh71MCQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=3h34POZrUKY9UhJJqsPITxbTnkcaxI5PmpuE1P5G04CFIkH1FM7OscZ5HaIZcBYq2VjvxHc6awscqCzSGPFMEZ5NggZHihoLc8+pMMQUy6jzrd3sc8fk1XpbR7UMWyl13lACxUBlXvmYXWUaO8KIdoIcV45Dn5FUJppXYMmfjhI=
Received: from SJ0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:a03:3a0::35)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:51:23 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::8) by SJ0PR03CA0270.outlook.office365.com
 (2603:10b6:a03:3a0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:23 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:19 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 1/9] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Sat, 22 Jun 2024 00:50:56 +0800
Message-ID: <78b6c75e6cffddce3e950dd543af6ae9f8eeccc3.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dacc13-d042-46c5-dc1e-08dc9212627d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8qU1EcbQFqnBOh1v67ts0P1LerlWFvQHkIR0V3u5i2jUp+q/L5UU0wvqwp4?=
 =?us-ascii?Q?DL7MVoZ1G6ZmX9ZXSHfmWwiVMIu8ClJ9SzGG5w6OA5JJMkDpbq9PVnovCiGX?=
 =?us-ascii?Q?aVK3c5n1IrnVa8ygQ74xvaDWPOFhCCivgr/YcJbuG2VPJ35pZWrFKHxvmfU0?=
 =?us-ascii?Q?vaA32HeKCRRaFP/F0ykIeektngRCnOpcQP5KbrfQq5aRZTJjtsPjQAvM2aYx?=
 =?us-ascii?Q?1IMmMH6dJBEw9lE6tnbe/raMBOL+az0AMc6JUi6PRYhp67OKv9VyKnMErcEA?=
 =?us-ascii?Q?xSNe9eMqbXxcHeMj12tHaoFhOL1yp0o/7f9tdcA/eOR/gOKICy03WI2EmbVS?=
 =?us-ascii?Q?vX08NbNykezaOpOYp7boCr5Ia5xsikj3ampSuPDhqQrNHnGGG+XOZszFVQWs?=
 =?us-ascii?Q?7daXVHe5R/HGzGBuKHpLbD3IoZNb7V+VPtQwbmc3rgCQwrU9nIhhG1N8k24L?=
 =?us-ascii?Q?d0I2XsnVei4ETROVdoZdYv82LCBQj2BypypMXANVoddIy5FRnffRLp+1NDRH?=
 =?us-ascii?Q?hyU9kB3WXZBvLjmikEVe6LezfCmI9EXgjhpP/SlvK/eoDrkV2iqX1fqoDoPy?=
 =?us-ascii?Q?E8kq7mHqqpRiTVD8NlAX7GSKLUiyOPeyDWUv4oW7UlEU7nBfflLnMZmD/44t?=
 =?us-ascii?Q?R+gVI2yJZUmE1fKIx8qIZtkLxbgTmQpsVCamH5awJp0OwCm+IPYhu/vKzIzW?=
 =?us-ascii?Q?v8cR5+55PV+6LX3hqRBP+DOLaC1jlh4jjW5m+8v6Xw63SyZgX3ruQZu1zpFl?=
 =?us-ascii?Q?zjX7x3fmQHu0v/XqimC0So/8wihmvSkoytGWMLyLnFanRv09oKIUdh98gEMH?=
 =?us-ascii?Q?hPDQltInjltmUl+juNSyPaz+zoLSYzbx2ygItzz8K+RA8XtFv7kMPybZEbzM?=
 =?us-ascii?Q?jJcinNRjKd9jcDYzFUX9I9+v30dp3+dlIVjYTbYeLS/HuM7iNOgXmE04xRLy?=
 =?us-ascii?Q?ByvDz9Dm5ZF++zxsoqzrQBs9MRb/96WcPZMkRIwdE4RDqgLLlPZpKsH036C5?=
 =?us-ascii?Q?s7Y5dGxlcREf4cPYKyvkm91oAdjliJ+xO1iRf/PUwrO6gOm3Sv9uJHURH0Rf?=
 =?us-ascii?Q?kl8gaQhJ9sKIO7W7wkK+fbUcA8tNT2Xdk+v5KfmBCP3UzBzMgmNrTllXoCCb?=
 =?us-ascii?Q?EvXQhywxi2KxK44UL865xfdUr1sIbDVxMzPVlcUpPpuEkTa9NHu9m1KWOf4I?=
 =?us-ascii?Q?I37ZTTM9YHz9f87sDvBZa+zQSM8rvvmEh1LAlsVLYWLBlMtVGi+H/SP0lcQX?=
 =?us-ascii?Q?dkEYCWRGcYkswqQK05VSDYB+jOZ3IZwyMr9xbIRnuaa67J4rtv+3neIa70yD?=
 =?us-ascii?Q?DeU9CmlARy/lLjLfUMdpw9kB3Hml66M0OxGH94qyuxsq1FCrDnhFdR/8u1ZG?=
 =?us-ascii?Q?59tNUSxbP42FTuR5f8TMXYxGmqe6pMSWIdF7fgBxbq/J1qJuHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:23.7843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dacc13-d042-46c5-dc1e-08dc9212627d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

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



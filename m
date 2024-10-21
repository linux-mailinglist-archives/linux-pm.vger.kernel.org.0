Return-Path: <linux-pm+bounces-16128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEE9A71C6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970051C21ABD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F91FB3D2;
	Mon, 21 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ebZr84r5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EF1FA27F;
	Mon, 21 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533809; cv=fail; b=EPmpsKHKT06nlXs3Clg+w443aVYY8lqqoKtcPrFGlIxdpwzpmdHDwzTzNGhaiqdtc7hUK7cTVVnBe4ycp4mhgnZoV7vDjqnj3FzsfgHC9ag7qGBOT67Dd66pEdFKJeJJw6BaL8CtI3YIWRx2hunnqPal5nivYgwQApfRB11VmDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533809; c=relaxed/simple;
	bh=m9DsvIoyEVL47DOfQjdYURoN40jhquPqlSgfKI+U5o4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwAgihi15ELth5R8N0xsrmXlsMuUaqfQ7cltqFXWEO3RYMf5Or2K0BzKreAuQfCjc/710iKNw2d5bkEkMTll3jMpinY8ejsfQ4SAXYqgpnIvqVTNcKdSlSKKKVRwMj8r6985QiwgxUq98o2JanFnsh/Dn3WVTTQ5wPenymOK/tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ebZr84r5; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpAo6RU4SpdTNYaset4Jg/CKiWuUXCY9P0rRVPajR4Kkk1yT8rLjKbEZT5np3RuvKneAMmsG6PkLOayHZHA4EjjUyqG0WXxr1afqxmbCXLXMe/ZdtUgzZT7Ir/8CHzdgORaYRZPt5dOocyFAxfG5lGNg6uWjffii15zhI7Sa/bFo99yx8FhXQFxZOp5sLOPYPRd9zRbrn6i5Trli9tHWF7pgFEIlrA8ndPa0LwjFHAbP0Q+HuL8eUc8l3UCTZaouTHevwzZl6pV6I7emms72mV2ZBy0IaUWP/vpGinLf5+i5K6nbMgeoIB6JlsqKuEvTio9W0VukeDzHlwQ/JSFrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKmKNuX7W471NSvyi+N49QiC6bAANemeibU1F0ELCI4=;
 b=Lhvt74mkGxnME+mTU3P8W4THkF/LApnkWVkc7xsXay+XI9l9yKyg0gtAUVZsMtAXjkaTRstd+OZr/JkZxKNewvD2Vl7UHxj/WWtazDFX9/qpivE2887O3/JqEjQCeBSFiibq1ggdl59ulxNxNuwzbo1HvbfQqGTfnBcE8sbVjim2+bmwfX+DQRW8+yv4A005O6yluZPCHFHVCwB873ai6FdhJK6PazY2A89ss5xLN9YjRXkxnTCWqw5LBbk0mfa4jLSmnI/DT41shKh7AP6pO5sfuS2Xm4geqQKwRGUOOBb7ml//gS2lNkgvR3Nl3+/woy34auIKExuOpBZmhTAZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKmKNuX7W471NSvyi+N49QiC6bAANemeibU1F0ELCI4=;
 b=ebZr84r5rB4MsVTZ2q/YywaoTazQg/9SBeEfv9/2NFjyvY0hfgn9aFpG+r6jYNsKdV5eegmAJMb+a/vT7KEVF27/MGD3uqoUQQX21lCDRepfDDWy2Kbc/v0MXZ9CILDoxl5+XSFL68a3Smyc3IP3d3/AU5bvzxOslu2bYu05uw8=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 18:03:21 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ee) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 06/13] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Mon, 21 Oct 2024 13:02:45 -0500
Message-ID: <20241021180252.3531-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: c9868b5b-f2f5-42e3-7133-08dcf1faa63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mT5K+0XxTmqGF7Y6F/t+0Qe3nWEhV+3jutiAgLJCG/2cgzTJro65W75F1F8y?=
 =?us-ascii?Q?WYe4O/Zx7xpZ1+RkIk6xt9M+o8A6sa4o4SwMt0Iq7hPlkj2+y8bclxPGgZCI?=
 =?us-ascii?Q?D8rD0GQQIVOhmjFYHnwsr9i+L0F9ILEw6q/h7QrQL/u8rlJw8nPZgpTwU3Lu?=
 =?us-ascii?Q?Fl3jEmfaqo/zQj9kIs924uMBic09TMy+dUZ/A3rMYkt0dBU2VvDJDf82yMl5?=
 =?us-ascii?Q?AVtuP2l+bUOtBaI5W+7+u7svFpx8nLEi01UCvJcTA2OC/U7DZLqUjBP9bfi2?=
 =?us-ascii?Q?VsNla05ioG19ge0FApmMgxSBj5+hxW262IF26ppufwwHWXyHWh95f1V1mpuO?=
 =?us-ascii?Q?4tw5jn9LIn1PoK7gG6hxI9apMv25eVJn+SF7n/5wfBfykctLsPju6sv3+QDm?=
 =?us-ascii?Q?ovsxJt+5dfL9Pt3murTULYE5uxNbNPNCyn9TxqeKREvhpzzF3eAhO3Jw5dQ6?=
 =?us-ascii?Q?U2KMGfYPsPi5gZr5WVzJHnyucKnqkP7jOglPgzIJHxfTgaCSEv1Nb1ojP63E?=
 =?us-ascii?Q?Ur2EdzrvlWO2YpIG8dJLKAg61CLQrTisquk2lsVktoZHGxv2Nhc4mi2e4E6z?=
 =?us-ascii?Q?o+lB0DUHEXx6xJ8QQk/bDHUmBGWFT2XmibTpg0VMmi0oUEEzNIBbDZ8705Lz?=
 =?us-ascii?Q?NiyKt1Fybu2w6iHmLO8Cqd4mjW7NsmxaUmbhHqkJSGUgjcskFXnucS3kxDW4?=
 =?us-ascii?Q?Z9l8E4ZaeKKd3nJy4hCcyJt5UEjHgVQ08BgSmE1I4JucYOEtenqWdWnM9iDz?=
 =?us-ascii?Q?nMDX5a1vqnu+zXuxvo58PHWm9wKjUwyTAW202sGgw9RqykhX3R6yBfwvqlsa?=
 =?us-ascii?Q?6beTTdrQMTuvwzoAHgcyeTkOTpoT1YPCTzxNKJ2JnOWEP8ER0fj4D2ZMN566?=
 =?us-ascii?Q?2aIY4lK+9jhL0Fm6j5/B2wOGmOsmPEtlnU3FwxaT4UPZejRESlOk7nwixXGs?=
 =?us-ascii?Q?ds2uOTjqtqSbkErvrc3zhM+WO8Nstd+E8I/fmYJwJrYDrGomcqpPlpIxEqRC?=
 =?us-ascii?Q?VviwD3NepojzHORUlgbmib6WcsACOKXHkFSCoc93TNAM8SX44/c1TTp9gS9M?=
 =?us-ascii?Q?nlJhuoEnOCSCu6Kke3W8ajwl8KFJvZeSFXQamI/vk1JZYJiVQz9dZea3afeC?=
 =?us-ascii?Q?9u8ZBVpFiKJ81j0dSbkblrf51/O8QtZQsJF5EvMmDXLJjD6UtK7FACZPqLhn?=
 =?us-ascii?Q?v8+TxE7NouYufzeHxKwh8HYWc9f0qj+hETdVpSngOHJp2FH/qKQaY2BE8vp/?=
 =?us-ascii?Q?w48Dw2WdskleyDW0nhOQSUFQgc6ULx/9Slxm5BFerv4TFsqJmUqyaV6A4XeA?=
 =?us-ascii?Q?jh2TN06SssB2lq85qFfYzOxEXEUAe1Kia1fMNcDwyNNXizRbSDUFLEvZ2MJB?=
 =?us-ascii?Q?k6mBDSNRPgQ4pHCHAyBlDw/crM6XYAvxZLjbd8Vq13t9b6L+0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:21.1327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9868b5b-f2f5-42e3-7133-08dcf1faa63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

From: Perry Yuan <Perry.Yuan@amd.com>

When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
to retrieve the shared memory address which contains the CPU core ranking
table. This table includes a header that specifies the number of ranking
data entries to be parsed and rank each CPU core with the Performance and
Energy Efficiency capability as implemented by the CPU power management
firmware.

Once the table has been parsed, each CPU is assigned a ranking score
within its class. Subsequently, when the scheduler selects cores, it
chooses from the ranking list based on the assigned scores in each class,
thereby ensuring the optimal selection of CPU cores according to their
predefined classifications and priorities.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 196 +++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index a92fe74b415e3..b5cfe20c11052 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,21 +18,73 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <linux/topology.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu_device_id.h>
+
+#include <acpi/pcc.h>
+#include <acpi/cppc_acpi.h>
 
 #define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HFI_MAILBOX_COUNT	1
+#define AMD_HETERO_RANKING_TABLE_VER	2
+
 #define AMD_HETERO_CPUID_27	0x80000027
+
 static struct platform_device *device;
 
+/**
+ * struct amd_shmem_info - Shared memory table for AMD HFI
+ *
+ * @header:	The PCCT table header including signature, length flags and command.
+ * @version_number:		Version number of the table
+ * @n_logical_processors:	Number of logical processors
+ * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
+ * @table_update_context:	Command being sent over the subspace
+ * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
+ *				This is based on the maximum APIC ID enumerated in the system
+ * @reserved:			24 bit spare
+ * @table_data:			Bit Map(s) of enabled logical processors
+ *				Followed by the ranking data for each logical processor
+ */
+struct amd_shmem_info {
+	struct acpi_pcct_ext_pcc_shared_memory header;
+	u32	version_number		:8,
+		n_logical_processors	:8,
+		n_capabilities		:8,
+		table_update_context	:8;
+	u32	n_bitmaps		:8,
+		reserved		:24;
+	u32	table_data[];
+} __packed;
+
 struct amd_hfi_data {
 	const char	*name;
 	struct device	*dev;
 	struct mutex	lock;
+
+	/* PCCT table related*/
+	struct pcc_mbox_chan	*pcc_chan;
+	void __iomem		*pcc_comm_addr;
+	struct acpi_subtable_header	*pcct_entry;
+	struct amd_shmem_info	*shmem;
 };
 
+/**
+ * struct amd_hfi_classes - HFI class capabilities per CPU
+ * @perf:	Performance capability
+ * @eff:	Power efficiency capability
+ *
+ * Capabilities of a logical processor in the ranking table. These capabilities
+ * are unitless and specific to each HFI class.
+ */
 struct amd_hfi_classes {
 	u32	perf;
 	u32	eff;
@@ -41,23 +93,105 @@ struct amd_hfi_classes {
 /**
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		cpu index
+ * @apic_id:		apic id of the current cpu
  * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
  * @class_index:	workload class ID index
  * @nr_class:		max number of workload class supported
+ * @ipcc_scores:	ipcc scores for each class
  * @amd_hfi_classes:	current cpu workload class ranking data
  *
  * Parameters of a logical processor linked with hardware feedback class
  */
 struct amd_hfi_cpuinfo {
 	int		cpu;
+	u32		apic_id;
 	cpumask_var_t	cpus;
 	s16		class_index;
 	u8		nr_class;
+	int		*ipcc_scores;
 	struct amd_hfi_classes	*amd_hfi_classes;
 };
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static int find_cpu_index_by_apicid(unsigned int target_apicid)
+{
+	int cpu_index;
+
+	for_each_present_cpu(cpu_index) {
+		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
+
+		if (info->topo.apicid == target_apicid) {
+			pr_debug("match APIC id %d for CPU index: %d\n",
+				 info->topo.apicid, cpu_index);
+			return cpu_index;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext =
+		(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
+	void __iomem *pcc_comm_addr;
+
+	pcc_comm_addr = acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_addr,
+					amd_hfi_data->pcc_chan->shmem_size);
+	if (!pcc_comm_addr) {
+		pr_err("failed to ioremap PCC common region mem\n");
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
+	iounmap(pcc_comm_addr);
+
+	if (amd_hfi_data->shmem->header.signature != PCC_SIGNATURE) {
+		pr_err("invalid signature in shared memory\n");
+		return -EINVAL;
+	}
+	if (amd_hfi_data->shmem->version_number != AMD_HETERO_RANKING_TABLE_VER) {
+		pr_err("invalid version %d\n", amd_hfi_data->shmem->version_number);
+		return -EINVAL;
+	}
+
+	for (unsigned int i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
+		u32 bitmap = amd_hfi_data->shmem->table_data[i];
+
+		for (unsigned int j = 0; j < BITS_PER_TYPE(u32); j++) {
+			struct amd_hfi_cpuinfo *info;
+			int apic_id = i * BITS_PER_TYPE(u32) + j;
+			int cpu_index;
+
+			if (!(bitmap & BIT(j)))
+				continue;
+
+			cpu_index = find_cpu_index_by_apicid(apic_id);
+			if (cpu_index < 0) {
+				pr_warn("APIC ID %d not found\n", apic_id);
+				continue;
+			}
+
+			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			info->apic_id = apic_id;
+
+			/* Fill the ranking data for each logical processor */
+			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			for (unsigned int k = 0; k < info->nr_class; k++) {
+				u32 *table = amd_hfi_data->shmem->table_data +
+					     amd_hfi_data->shmem->n_bitmaps +
+					     i * info->nr_class;
+
+				info->amd_hfi_classes[k].eff = table[apic_id + 2 * k];
+				info->amd_hfi_classes[k].perf = table[apic_id + 2 * k + 1];
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 {
 	struct amd_hfi_cpuinfo *hfi_cpuinfo;
@@ -74,14 +208,19 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
 	for_each_present_cpu(idx) {
 		struct amd_hfi_classes *classes;
+		int *ipcc_scores;
 
 		classes = devm_kzalloc(dev,
 				       nr_class_id * sizeof(struct amd_hfi_classes),
 				       GFP_KERNEL);
 		if (!classes)
 			return -ENOMEM;
+		ipcc_scores = devm_kcalloc(dev, nr_class_id, sizeof(int), GFP_KERNEL);
+		if (!ipcc_scores)
+			return -ENOMEM;
 		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
 		hfi_cpuinfo->amd_hfi_classes = classes;
+		hfi_cpuinfo->ipcc_scores = ipcc_scores;
 		hfi_cpuinfo->nr_class = nr_class_id;
 	}
 
@@ -95,6 +234,59 @@ static void amd_hfi_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->lock);
 }
 
+static int amd_hfi_metadata_parser(struct platform_device *pdev,
+				   struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext;
+	struct acpi_subtable_header *pcct_entry;
+	struct mbox_chan *pcc_mbox_channels;
+	struct acpi_table_header *pcct_tbl;
+	struct pcc_mbox_chan *pcc_chan;
+	acpi_status status;
+	int ret;
+
+	pcc_mbox_channels = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+					 sizeof(*pcc_mbox_channels), GFP_KERNEL);
+	if (!pcc_mbox_channels)
+		return -ENOMEM;
+
+	pcc_chan = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+				sizeof(*pcc_chan), GFP_KERNEL);
+	if (!pcc_chan)
+		return -ENOMEM;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+	if (ACPI_FAILURE(status) || !pcct_tbl)
+		return -ENODEV;
+
+	/* get pointer to the first PCC subspace entry */
+	pcct_entry = (struct acpi_subtable_header *) (
+			(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
+
+	pcc_chan->mchan = &pcc_mbox_channels[0];
+
+	amd_hfi_data->pcc_chan = pcc_chan;
+	amd_hfi_data->pcct_entry = pcct_entry;
+	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
+
+	if (pcct_ext->length <= 0)
+		return -EINVAL;
+
+	amd_hfi_data->shmem = devm_kzalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
+	if (!amd_hfi_data->shmem)
+		return -ENOMEM;
+
+	pcc_chan->shmem_base_addr = pcct_ext->base_address;
+	pcc_chan->shmem_size = pcct_ext->length;
+
+	/* parse the shared memory info from the pcct table */
+	ret = amd_hfi_fill_metadata(amd_hfi_data);
+
+	acpi_put_table(pcct_tbl);
+
+	return ret;
+}
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{ "AMDI0104", 0},
 	{ }
@@ -121,6 +313,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0



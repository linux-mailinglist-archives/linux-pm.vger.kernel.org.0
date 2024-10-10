Return-Path: <linux-pm+bounces-15487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F1999293
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3481C208F0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495781E3DE0;
	Thu, 10 Oct 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vz7cbhGf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF41E0099;
	Thu, 10 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589073; cv=fail; b=bBAlekp/kmbTQSe3ecNalo+jIHjUU98UCpL8tgYMuZ+jgg9lIDccGJJYB3cThLeLsiSIEOA0FqltL2OEiBmats+H4i4SWja4qARzytiiFFepkilfgnYA1GlLRGeNb+A2l7r10wglfj7/GZZjcAyBxKlzRRdNn3JxUpu5nRHXG4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589073; c=relaxed/simple;
	bh=dDR1zDXRWXd/vZaEWt4Q+WvqydN5BEvTdRT2PJ6OCB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMDTDH3jssl7zUuMrDGkBCyzPx63cS9zuGjersDvGyupRhZWqwSI7sHIKj/B5x0lqG7ygAevYB4tRto9QYhJj18DqQrYiuES9sYRnwIOEI9YVuw4vwAxLJWMCtRQZIEwEq2D5BDA3zsUu7mBFuSC9WReojMNggknUHDtV9joWpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vz7cbhGf; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWQmtozTEWH2AZGIdCynVFVNC5Ni7JpBgNDevtBGi/lY00ySLLq/TXWYnihsLE4Fr/dy5C0LvOSbdb0zLIEK3fqWTTvAf5ug/9LmdCWOTcnXdijMPGQWkJDamGhP6OL8h4HOdT4bBVlQRxX0kLVGqOski9slp+6PDUIgfrt52HLN7Dxsybzv+tR2e8/FkzmE4/KY964epkdVBigXCX5JkVglF7zcKlvujh3XM9oLS1V6jsi2A8mocBhd5/BIz4Vb80e6NeEHiLxrILIcDi7Hk9I36ykcOZpskD0GYAt/z2lCQaRx0c08AifGbbPElwloVLBW7Of9TSED7/GgYhaeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEKOmnQCEMH32XuCjLsGnwQ+wSLix7ZcHBi9RACin5M=;
 b=HwQY2ZV3b2jGo96KVGZ2XJL4a8l4GCwgWxCH6vZ8jtQz6pT0Cy0MtpPpypWA/zcl8+ue5MG86fIwCeXPXaTrVVzAc137NojudBimBHd8YneW7JHsgZoa5wPqjBjmsc7ygPXUNs6cOhuZhbIkExfbBpYqIpCCX7FA1kdUVWo5NFqafGzPvERnW5Go4VdL+vZFW6yLLK/ppWG/mP7zLX5T+1g1T4vmpxnIeRqm9duHruBLowqxtgu58NKy8PbnxGZJnuLBTu47gYDD+uhrGM81OZR78pu6YfAWh02Y74AwvFTAttCqvSnqLdGvx90XJ2Jt532HKMO56kcOSxUbdiOUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEKOmnQCEMH32XuCjLsGnwQ+wSLix7ZcHBi9RACin5M=;
 b=Vz7cbhGfjf9RkfYdljVDBpvhVrBP3eY5D6irVLlRzm2LGMzAZ9hHmnfOiuCpszb0ghjCsvConztnf2m413RjR9VNvzCeUMxIn2cZaPfc+NwDdHU5+k9H1shg85IYM+hTeU8AlgAaoC5vEvP01l04eYwkjoJ3CZHh483CQvGqpR4=
Received: from SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::21)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:45 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::4a) by SA1P222CA0151.outlook.office365.com
 (2603:10b6:806:3c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 06/13] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Thu, 10 Oct 2024 14:36:58 -0500
Message-ID: <20241010193705.10362-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9403b82c-42ac-440d-b9cc-08dce9630419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6AgQl95KQsV45adRzqW1SjCuxiCqtWqbXjcMss668O3ZXoUchiFhZr+gIrTT?=
 =?us-ascii?Q?h0s9OdFUuhmEgo1pFB1vWymWruLdHdbt3WjupPBTz3D1lq6LAamxbzwjsebl?=
 =?us-ascii?Q?KiRi7+Us2KiC5fm6UlX7K1mQg/OoyZzLp0zCm7ANXWxDzh9pCab4xo2LI20e?=
 =?us-ascii?Q?/rrwkO1jYDmF8gfKDCG0+bv/4amjm7yK03PwRbQvXh/21rDk+uqUiUYkvnGx?=
 =?us-ascii?Q?NG/+5iAKIfLdTOrhyV9HgjeVvWY6CdoYEK2TnZbLh3WWAMvUDeLkOpJfiVZ1?=
 =?us-ascii?Q?FVjOxfqm6FkdfqLA+aUbfV5SDZrXsgdnToN/Y2lvqnfAJP88cEuePEnrEOXD?=
 =?us-ascii?Q?z1TS35xsGMluQhvhUFQnPKUP2OmJS4Mi6klKKMFGjNb9UC4te99mPe3uR2T3?=
 =?us-ascii?Q?7KPVDXi+da96ijZ8iGtqtnmISV1ZhP3ptHE1/vdcRHl7yhUECVzXd7L3y/l3?=
 =?us-ascii?Q?rh+cZTOZMpAa3Iwp99ytrKDYPIy+kGzSAq6XYZ9Kjhwrl+2G2bqWiXgcHZbw?=
 =?us-ascii?Q?6VZoa1G0Tp+7w561uXsMjnvly3zJ7p7D0/a3eHUENjUqUIyQOxQ8jj88wxYe?=
 =?us-ascii?Q?p4kNKYbBjxn1YZkHTSLluym+cflnTVAZ/WVXoLD8F29mZzjY6rSsE59AjIBP?=
 =?us-ascii?Q?yCMdmTfSIaJOLcCSofdhX9qNfhLhZQj6Jlza0hm7puhNi17PKh5ueoOdPY9y?=
 =?us-ascii?Q?z8A3qFR933pg1roW4b4qptCxQ2Ip+1y9S9gyq7Y6SZ2MWImLlFCj55u3B6gE?=
 =?us-ascii?Q?0XTOjdBuPp9YXAmknMGWf8t9S2He5DnEHJpbFJvp8lQqO80Aw/z0B+dy3zm8?=
 =?us-ascii?Q?AFOTEjuQvB6GAZHpO3rZ0W1f2fg0dllITCG5gHDPxsj1ZqFYtZFw9wtDqqkj?=
 =?us-ascii?Q?ntATTj8OU7OuOQCAbIfirl7sPCohmHf7IrqCZG22xAWylklIJkTgEw1t6D0P?=
 =?us-ascii?Q?mmyWSEmieCCzhpgBhfIqQckuNwAEvo+NxAVIb0DaZn8ezTMTDF1hHpnHMVwa?=
 =?us-ascii?Q?wOgKnXcCjF3GdCEDrU5J8hyPmflJntQQXAUSQvzbF3p9NFHC4avkNMEqHyVb?=
 =?us-ascii?Q?mPxy8mlNw7dikqupsyyyyJiChy7Xm8e41DCFAWfxh0OfswwdsO+jt0YzfUdF?=
 =?us-ascii?Q?suEswK8uvkSjMXX6EK2MPpMtOhF3eG/mAPKutAVGBQoPvSQjPq5JuDFQ89YF?=
 =?us-ascii?Q?itcBFrGQvJtzbOktFrobRkjEeN4dPzi3FjXDIUxGLzU9g6JKmWBBCul2LQ7u?=
 =?us-ascii?Q?5alktvLQEtcQ/ONgQg5V5wAjEgdXigzKTflClhOYXo5SnoGFqCOLU7VF8xXN?=
 =?us-ascii?Q?Xn9AqAE0OEYbjfXW4o6sEBLHvRDbyQDThdNKzIEDfCcnXOIWgtUdBaYQ3z7i?=
 =?us-ascii?Q?WMcz9gq7ZRyeBX/dqYm/bbhMyoH3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:45.8659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403b82c-42ac-440d-b9cc-08dce9630419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

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
v2:
 * Rework amd_hfi_fill_metatadata to directly use structure instead of
   pointer math.
---
 drivers/platform/x86/amd/hfi/hfi.c | 215 ++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index da2e667107e8..10651399cf75 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,22 +18,78 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 #include <linux/string.h>
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
+ * @signature:	The PCC signature. The signature of a subspace is computed by
+ *		a bitwise of the value 0x50434300 with the subspace ID.
+ * @flags:	Notify on completion
+ * @length:	Length of payload being transmitted including command field
+ * @command:	Command being sent over the subspace
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
@@ -42,23 +98,105 @@ struct amd_hfi_classes {
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
+	for_each_possible_cpu(cpu_index) {
+		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
+
+		if (info->topo.apicid == target_apicid) {
+			pr_debug("match APIC id %d for CPU index: %d",
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
+		pr_err("Invalid signature in shared memory\n");
+		return -EINVAL;
+	}
+	if (amd_hfi_data->shmem->version_number != AMD_HETERO_RANKING_TABLE_VER) {
+		pr_err("Invalid veresion %d\n", amd_hfi_data->shmem->version_number);
+		return -EINVAL;
+	}
+
+	for (u32 i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
+		u32 bitmap = amd_hfi_data->shmem->table_data[i];
+
+		for (u32 j = 0; j < BITS_PER_TYPE(u32); j++) {
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
+			for (int k = 0; k < info->nr_class; k++) {
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
@@ -68,8 +206,7 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
 	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
 	if (nr_class_id < 0 || nr_class_id > 255) {
-		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
-				AMD_HETERO_CPUID_27);
+		dev_warn(dev, "failed to get number of supported classes\n");
 		return -EINVAL;
 	}
 
@@ -79,7 +216,10 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 				sizeof(struct amd_hfi_classes), GFP_KERNEL);
 		if (!hfi_cpuinfo->amd_hfi_classes)
 			return -ENOMEM;
-
+		hfi_cpuinfo->ipcc_scores = devm_kcalloc(dev, nr_class_id,
+							sizeof(int), GFP_KERNEL);
+		if (!hfi_cpuinfo->ipcc_scores)
+			return -ENOMEM;
 		hfi_cpuinfo->nr_class = nr_class_id;
 	}
 
@@ -93,6 +233,70 @@ static void amd_hfi_remove(struct platform_device *pdev)
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
+	if (!pcc_mbox_channels) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pcc_chan = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+				sizeof(*pcc_chan), GFP_KERNEL);
+	if (!pcc_chan) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+	if (ACPI_FAILURE(status) || !pcct_tbl) {
+		ret = -ENODEV;
+		goto out;
+	}
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
+	if (pcct_ext->length <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	amd_hfi_data->shmem = devm_kmalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
+	if (!amd_hfi_data->shmem) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pcc_chan->shmem_base_addr = pcct_ext->base_address;
+	pcc_chan->shmem_size = pcct_ext->length;
+
+	/* parse the shared memory info from the pcct table */
+	ret = amd_hfi_fill_metadata(amd_hfi_data);
+
+	acpi_put_table(pcct_tbl);
+
+out:
+	return ret;
+}
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{ "AMDI0104", 0},
 	{ }
@@ -121,6 +325,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	/* parse PCCT table */
+	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
+	if (ret)
+		goto out;
+
 out:
 	return ret;
 }
-- 
2.43.0



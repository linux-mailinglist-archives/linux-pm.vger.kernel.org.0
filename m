Return-Path: <linux-pm+bounces-16985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D699BBC86
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940F31C21B15
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE41CC170;
	Mon,  4 Nov 2024 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wv7nIqDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985D1CACE8;
	Mon,  4 Nov 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742888; cv=fail; b=uLw3JnKNxPJyIdvEW9CJGMU4hv6YwCvVaM/vjG9jauJuE6vf1lqyUwf/ho277lkt+eGSI4MBTDLY2yMmrKUF9zxFpm5gpClnp9DrkoCgREzKJBetdCaJR4bT3TT4k9BKOKOt+lHe+Q3CbW4gFdJaaww/PPfnKYXoU7/FOZZPZkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742888; c=relaxed/simple;
	bh=KKJke1c9NkUZI/EZwFveiL6Qacvt2SHhOk4dUNExIhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k88GVuWiZszT6/fOF7Hl/5nfZabs/5KcKpAY49cmPXH/hc3yu/bR8CpALSipaJvOghY8dgRg0BDx+zIW+vPwbRpHMHTrIODHR9doaAQTbDTI7lrliQETRVqBoLRQyqsGol12zQRfWmmblsuFCb7RDP+rM2nflUZ8QcJT7Fw701k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wv7nIqDU; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB9N1j/LWst72yvrqfuFLUSzFZwKKj44h9A+6D3HwnDWHRi9UAkHLwDCn7jOnbuzeubbMDRLGRtGDKIUvQSpAYaAIAfZFN9JZIo4e0ofWc2DaVVwyjU+j5wvYGWPIZWI/ZBzRT0ifADrN0n/ebxBRz/+e5+nL1RITJXvnzRB7wLnSgTTW7aVIND82MYNuxmE6R29MruWihGoKIdTdPH7xx9anxGDLb5EPbE3Tfghu+o508n5OxImaRHUDX8X8qGBuk0bs1t6rkHzVRo+jDZxsSB8DW5xch9xpx86AhzczCkQG75gNbFgH7+1nva7jGWG5gNfx2uXs9PPRai58rudkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uctgYgmOW4Z9RVGjbUwFp5sBYHMmBn9Q7lcMqZzM3dQ=;
 b=khc1nEsjtl22B/imx/KVC62PIrJGb4AdIFBFe1EqhJPVTqmrW27+fCzRMaX1x421tKYT+s4iMfdt1M7BhKKFEiR91tVnol2c4cJPRRXJbHpVrs38UIbC6EhMmmwFQprnzaURbps/b7YYFYrYO2L59MIt0BCR7Id0RjzBR+ukt6gw43aL/ANiOdoZbeEIFI2HtC20Z378a4m6N4fBXzfjBrY3XTWw7O2uG+Mg94lhZc0mxuaZ3qpxq68oKrE+8hkiDOh3EGpjQ5mgEOAuEwbODb1vsSvPrmRTJjJjwZ59v/CkHu1iP0uJqUAjTNxRoV5tKSiCkbfp4ypErsPeC58TNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uctgYgmOW4Z9RVGjbUwFp5sBYHMmBn9Q7lcMqZzM3dQ=;
 b=wv7nIqDUmikzV+rB5NO4UivufL8KzjbpCRbSHqMbmhRw+fpRcsV6Y9WzT3HAvhes8H0yBNXKomGmQ4p/ASk0SLUsWDFhfBvZx7LC0gv+rtV3ynxgq/bpkIfY5keVeGgskUpptFlikRO7wn40d/CqBloYiqnIrtgkt7CtKOmW8mE=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:43 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::df) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v6 05/12] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Mon, 4 Nov 2024 11:54:00 -0600
Message-ID: <20241104175407.19546-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac9a8ad-47c1-4d5e-969a-08dcfcf9c331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNVQSSFs7dEQ8vXG6wEyQ3SWN41t+s1/mrea5JtO3AmMKYx+q1ma/vZymOUX?=
 =?us-ascii?Q?1LgCs2kGJLoa/cptkDxdDToQFRtFGeaLcK5imcHS0L2WlZfHhol3QoVO4BEz?=
 =?us-ascii?Q?WAt7IEamVSZyEkhLhgsvVegLeJPED811b+1vta0noqmbId4d76UKd5qpW+t5?=
 =?us-ascii?Q?sm7VWhROMvdzr7pua+mXjDWiOI5XsPd6RZUosaCtF0b/jKrVF5eqlqhLyyAb?=
 =?us-ascii?Q?q9vjDNajtOOjLAbA+wRjGWi6oHyfZwYyReUTOSlnkxyUHbX5ljXla2cnI/Q4?=
 =?us-ascii?Q?8MfBscb2gsLYOdCWq69hepqQqF01XGTjiPm/4j+vH+U8vJUTVvtYvlzVl5AY?=
 =?us-ascii?Q?376AZRdmu46b1EfLkPDpIVu+WGzNKqgmKQrxqmzPecaIBMuqvPclMInXdrm0?=
 =?us-ascii?Q?ig95MGzMqHrRinExFgjybVH93GTeXMeT9eAJxZPu0JvgWUxRGphfny3L9Y3Y?=
 =?us-ascii?Q?mirkALLafzLXFwQNNrhI0IBI5sJrqoyaL/r1LamePnOF8qvJ62BIVYotMn+q?=
 =?us-ascii?Q?HK629bEvj+3X3jSvED+iIW81UNtw4Zb4RvcNwoRwvnx1nwhlrjod9YIQSu/K?=
 =?us-ascii?Q?FGtYi4x/af3nsI1nbL4dYuVm4ioJn4whaHAaoMN+jSG8VXkhmhx4y31Vu4oc?=
 =?us-ascii?Q?Frsfj/dnytRliUqFOdNfEKtnNiGmIY5sZTWCL0oGwLhq7R/fIJD0rX581CiV?=
 =?us-ascii?Q?IvemSjFSarD6UJBpcAihV5f17/B1dRcP5ykD2KheglVAqcTXBLtczsuDcU09?=
 =?us-ascii?Q?dnAMUPcYin/LM0nJboKEbL85vWBZbOmq1pPtCAvvsCERK+f7f2nZL+zx6rBA?=
 =?us-ascii?Q?NMDfrHxZF5czVxmkKEjvETjsDBRwyWkKqwjgoTgtj0uigVW8g9843jZknqlj?=
 =?us-ascii?Q?k8qngSJPLvTxsi8Iy5Z5Z6fJ488JEtbfrLOxntAsVF6mC51lfk32goH0vK8n?=
 =?us-ascii?Q?pn/m+SkUCrvCxAjqDE/00FRXxdJ3werZHR6CFRme64qhaTSXPq/T/1AUCc9Y?=
 =?us-ascii?Q?fYZhNN9VFJKs5njLyoXGp/OMEJKaJjTjHsbUIDrFCpMhWRhC+yCTZff1T/WM?=
 =?us-ascii?Q?fKxJ+m+famcQYiBFAY1Htn4cVdfzIMPv3LmBPXkm+BEjq8OqqopMcLk80xAS?=
 =?us-ascii?Q?Ks2kvQ88y/m8kETuXtBQ+axkCy7Dx0+Y0//pZ8YN0WyAGg+nJIwl1cmc0ZY4?=
 =?us-ascii?Q?SPYhzHsnYIPlMTnGgMzg6Cn0b/c+gqvesss0t5kRpI1Kb6HOHo7H3DNXDK4e?=
 =?us-ascii?Q?5Ldq35gjGfFHBiTe0Mz/yhW2UcL9kKUuJXBLbXOg/d1f+T9tbnWTkr/WjPqe?=
 =?us-ascii?Q?qEpvxR2yVKDQ94qbf3uG+c7tDr3avzVOzU20qU0tAU7EBaXzQHFUbkPw1bKx?=
 =?us-ascii?Q?BYiRG1Vi2Mtk1U282uHCfNv2Z16H1ldTlTzxBQKU1Kz8eFzfFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:43.0068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9a8ad-47c1-4d5e-969a-08dcfcf9c331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

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
index 2cd71d79a22c9..708d7d18fe2f2 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,20 +18,72 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
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
@@ -40,23 +92,105 @@ struct amd_hfi_classes {
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
@@ -73,20 +207,78 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
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
 
 	return 0;
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
 	{"AMDI0104", 0},
 	{ }
@@ -115,6 +307,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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



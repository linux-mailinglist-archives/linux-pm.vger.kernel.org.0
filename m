Return-Path: <linux-pm+bounces-15701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72899FA43
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D42840D8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA22076A1;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDBtuUux"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1C20402D;
	Tue, 15 Oct 2024 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028255; cv=fail; b=sp9VACiNJH/VWl9Q8hyRZll+daNPVw3WAsHgT2ujaz+dYGsAhILTAL7fWPGFJGlRuUOVy6ks1DMdmD2etLXgrWq7nfqqPOAJcME2oAznClJHfICKaa0NsZSxnlpFhh28eyyuExMhR+4rPZNxm9OpQpSOYKPcSPRqYttcqHoPG00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028255; c=relaxed/simple;
	bh=UrgtfIdVbFM8uz5IOSlgGJaGtWtLGgox3PhNHUJDhw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN9RXPt4qvKWasDX37kENhyWYHtBI0UNCYdn/DvR5nTBAhdmf6Ti6uOE0l0++FceXQ2YZJ/x1I0tMl3IGT+maqyGai7iGdMIhrC+dsa3y1VOu7IaMqOaPjLZmr7FRQCAehSBGSCOX/vk+7FtljVbW6X4rOk5nYjgk7TSC4AwV60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDBtuUux; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jExpJzvdmTtmuMsclIrCRvjN64zUtNSriemESypgBJtLtgmAPJSkxCfrAT7vmQcNlpZFeJopEomU7K4w5OqgMzYerEIdp9l3eUDOGw/MRBjDxyR830dGurjCPUOfh16tG7ZDPhXomJc7lu5QREe+oM7kn2L9HCn/aUKRuc+vJTWiPVjFvf+2T5/02dSsUOz9TLOKrYAgJ52Kg9kJ87xFqniVHMqlet8VLogxCdikBKbbfqb4lgYi2UEMNTSB+QLoKeN075cxBw7stRfUwJ8w8qQYsQ5afBgjWl07A5mkH0d6hu+wedQMF6j9MzM3oGZYwZ8Hm/CF9n7x+y76gt3Nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwRSD35aTJG3zkIYypM58gfK/fEQGtNQDDngqqoFgTo=;
 b=XbD0iA+N6nk1Ix6w4g7wFe7VKipomqmfiN9dZhSjpIqtHW5X96GGpLUo31KpgKwQGwAQUfPv1N592YwLcLEsWDsEgc6sFo4rxEf7xAm4QNwClzEw6iPop9lVQysqthdParLsWtPLpyMj6T/ozZ1TkYxutz0ACxetwvlwa3kxIilE02Q2p05lFBPwqubQVYRRl9P2vGyZdHJx1W35IgxvJ6zv/UzjgajmWNri8WAiMrWfh6M6kZv1ZikABv6pw7qVTEOc2I827UuZWVJDuFTtUa9BFec5iZ7/pvFqcGp1s4rdY+HPUROK/WjN453al3uIk+Dt4ZwEmrSC1FqLCj1wgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwRSD35aTJG3zkIYypM58gfK/fEQGtNQDDngqqoFgTo=;
 b=PDBtuUuxa+hOCA4pdmKMazc2FyCOyA16zh66bWUs7yZlEJIdtyYJRQ9Dwh7xY6VbysipL+EzvxmWZZD6Z5YClfi1/WbjwCwUTZOzIfV0zqQ1fisM6ICvfVr9c0bkSaDy7PxaXY11Oxp27bWHTG72kE7PptqM+Fs1gJnVYkmIjso=
Received: from MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Tue, 15 Oct
 2024 21:37:28 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::ca) by MN2PR02CA0028.outlook.office365.com
 (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 06/14] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Tue, 15 Oct 2024 16:36:37 -0500
Message-ID: <20241015213645.1476-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: e10edbb2-48ef-4bb2-2be9-08dced619124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x/YujijG0VHBeIcSJtR8d+7ZfNhbN3PV+oBnlhfpwmds/tZL0Ov4WMvmnJ/q?=
 =?us-ascii?Q?6hpBwV2fLsSdOo3gCuGUFLP4FCBbSRXqaRRWWzHeupstYKK7FYJC/WbLvYsP?=
 =?us-ascii?Q?8zUQvhPfXK7J+abvKEZGNHosIQImRPfD1gpF6KRAAZVXIQwj0YZzKa6GeA9T?=
 =?us-ascii?Q?IABgnpbFAyyvRXZ7dgGs5fadM2T2hBbOEfthw/GQNfy5DI8Q28qx4daJ2se8?=
 =?us-ascii?Q?xcOy6XiPC/vG4fCcT1iibejF9kpbMVE6QzBWyDQKWX5e0vauKj/r1ZEtIslI?=
 =?us-ascii?Q?ZpABls+rWc4IelKGyk2Xek+bPaCKwiPcvfakd6rRCF4RnHFXZy2cb8WGW39o?=
 =?us-ascii?Q?koSrgm7fyxSwPpnFgw/3LCXrUGrzysckObFrNMmrgF+iJ6gG2t+Go/M61X4W?=
 =?us-ascii?Q?ahAfUYnvL+jyb2ao9S1t5x3viYin00q5MrM9i3mjDNkEvEUJ4K1GP70NWH2g?=
 =?us-ascii?Q?Vj2OjpO8IEF1GLeOl6ItgGBQQVsxqknv40sr3KeLFyEMWmdbVp27tss4aWXA?=
 =?us-ascii?Q?7N/Q69tgiruIkejq5ekQFsIkgAtlv/6oOxPeWy+n4T5dZpUNhQGr6g8GnHRE?=
 =?us-ascii?Q?tyhbNEIJNk1rhu+Z3e5QUHFZmB47TR0CoYSjJF0wS9nTGqvldg+Zv1r9Hp84?=
 =?us-ascii?Q?mUbmGBUidjQRkOZ7kcTbnVNT3dwlxqxsTSI9JitEprfU0FmBYgOhSJdqd3xe?=
 =?us-ascii?Q?9WfEcPMkmhuOC1NpnWvdUDsC20/lTHI7MlvUU97DubJOIioDOj/aqBZo9Rxe?=
 =?us-ascii?Q?wukceJ0wFfzs8ksVbhhD/msIkX72eP/oAcArx3ZUSlpLq5lrlEGXPfeTUPjv?=
 =?us-ascii?Q?TOEhD/yj4o3F+ETRpCyEWyu+pVNts9IfSPHN4xc++Ofk8cs88OH9o5G5WL0t?=
 =?us-ascii?Q?+/bdzbdSYwE/lDnlLafzxzjN5GNfyKk9Nc+WhvEVPe375IMKtjVSYNRNoOi6?=
 =?us-ascii?Q?CsRp2pIdO3ursDJcXBu5i/nhbLvTilaB4p/2EtwquySGdBBSqcf24ZS921Kg?=
 =?us-ascii?Q?IMcQ8Ci9+LkCQAGrbH3LUIT2wKbTmzVvZFO6DRkBVgaCxHXwmJ40EWbQoHFd?=
 =?us-ascii?Q?0w75NQEz/9x675vn0KtTbwwrEycwnCoEr4ln0b/z3i0tQ1uJsuG3H1soqjCE?=
 =?us-ascii?Q?BieMxszumEiQSJdczY20QY2Du8wXPnHdQlXpUwAycwJHldaEXc5cG69EEBjY?=
 =?us-ascii?Q?qeLBi9GqbEtstPEkoOncoWuVln2fDQmKTE6a0d7A/lL7nL1FokGDcbvPAdyA?=
 =?us-ascii?Q?JI0Fjwd4e86z8ZxusqzTqffzy6Tfcw22Yb0MXInst0cgTE/DK4q4M3O1kOC0?=
 =?us-ascii?Q?fPxWZWhNri/GaXozOj3/r89OZcKFsgTHKAUM5OCbBeCc1H6FwRweYvmNKjxY?=
 =?us-ascii?Q?mq1QUm0+1NSCvTMZJd9OrMCu8z3l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:28.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10edbb2-48ef-4bb2-2be9-08dced619124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079

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
 drivers/platform/x86/amd/hfi/hfi.c | 200 +++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index fbbc2c119a64..d2952233442b 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,21 +18,77 @@
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
@@ -41,23 +97,105 @@ struct amd_hfi_classes {
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
@@ -74,14 +212,19 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
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
 
@@ -95,6 +238,59 @@ static void amd_hfi_remove(struct platform_device *pdev)
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
@@ -121,6 +317,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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



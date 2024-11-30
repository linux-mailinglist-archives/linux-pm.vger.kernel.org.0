Return-Path: <linux-pm+bounces-18290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCB9DF18E
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E140163104
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1521AA1CA;
	Sat, 30 Nov 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQNK5tb4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59151A7045;
	Sat, 30 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980059; cv=fail; b=K+zzbW1o2Ps148UQ7KRWjQjvTwa1nMObmZdG48hO5NRWTuSUekAY3Mj2rA1MADbi7jGy6PKC8rMXRrj7CHkDUKQAOqiYjKPJJQYC452O7sNZ8meTUHrAxXmGENjP/puh72Qkyo8t1IgTLXUXm1FJOHmQsmfvP5Onz5++4/GtWNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980059; c=relaxed/simple;
	bh=ien+250UDGSrySnQglG7UUoGBOSS6C1yuHB+mvVLNHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLvxUaBHVeyosSpa65OivoYMQl7k1XivIwhxDxm8tURJ5taK8hdzLFdG70OBf+oAPOI4iuwG+XMSQUqeHkqBfe0b84gkj0MUFs75BRLMP+oaBcy7M7hZRLsv8Cvh9GVEtlg2Uxt9ey8T1wy5u/vpwLvk64Nx9ks1CrcgSOkAcqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQNK5tb4; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCuPQLRKSn4oRfM+DewAcOqnk66Tfgbh/n8S2s0izhKxSLkjOAtulE0BodH+aGi51bGg+Iku72/lQ1qaahV0NwoA+LN3PbWmt9/xb8unBsr8furDcImaoqkXKf7N0pFWAqYItS5MQ715j4oiDBZ2/ueNzvNm+m65o6a8SJN6UjJQR3DYNIQ6vxN87NcUvcmVDBvtvQrZoAVMdFoSY9UuuHh2JT/ujupXBTC8SBLJubOzdB6fvbnMcM/SesiBo3h79qkJSmZplAXU9lQhqyNwY1hEzf2+x2jWr0sE4Fz4Xiw6/6nwXsYraePZMnBCn88adYbJzStSc+vLoh2H/MDGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ0JhNSo5HIbRJxB/mR7KS3J2do3bzPNbgtturNXyiU=;
 b=wKXKWbqmXH65XECHZ0+/AN24Fl6GUvVsUD/5i7wkzKQ0nAH77nWmCPrH7JDjIsBPe8SZkHFFdnI+4jqyCjFJDVRr2n+LIwSLDeX1CcS7gAMkmksFCpA12o+9+Se953YruXDSzE/9fifzzOfIlLeElX3Z2n90UXn1QvA4n9ISL7K5ZjvwExSrxqheNnQgzXdweO1SO4mCGxQGi+MKsSTqQJHWn+oFkog6KSk5kFvWeFFnM+tNtNm0qBhPQ+dRtC5Dt7VPfqQ7Q/avRlMj6Og57QdonG1q/1zJUVnT12sTUCpdBThhXKeHHgdbt6QJ3BJTpdBFB6Wyp6XR+rG20oEWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ0JhNSo5HIbRJxB/mR7KS3J2do3bzPNbgtturNXyiU=;
 b=CQNK5tb4BP75GrCxPdItQ5cokgRqSvoMg1qm3G2cxeDH2+pitC16oSvK61mhb/h5nPZx83/Mz2M0xmBhDAfjFB0s0dVjm64vAiIMi+qbgZtnXsW+DFlzOuU3BGBh3jBtGGdFsWIJCDcPLcX5kqYjZ0hZEYVLUr+tlnWmlfr2Fhc=
Received: from CH0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:76::25)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 15:20:52 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::4) by CH0PR04CA0020.outlook.office365.com
 (2603:10b6:610:76::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 15:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:50 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 05/12] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Sat, 30 Nov 2024 09:20:16 -0600
Message-ID: <20241130152023.684-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 305c0d6f-bf37-4e41-b9ea-08dd115293e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU1MQkVHMlhUdmVuSjEzYWNpUzBJc2xJUDBDVGI2RW1qNlBURE16TXdQT3V2?=
 =?utf-8?B?M3hUZEtwa2Y0VFh6aGJpMmU1bWMrUDFCeUJSeGljM3Q0ZThVNkljL0E1dEtN?=
 =?utf-8?B?LzhDVFRMMlpCV1JVVGNCZlZRTUdZcXFFYkF5aWpGb01SUWhxZnNaMjVwb1l3?=
 =?utf-8?B?STRsUWZ3OUtPUE1MUEMxN3lVWWhpZjZyTDBUUnhLbk41eXhuS0RQb3FXN3Nq?=
 =?utf-8?B?SGJRUmpZUitDNHpSaFlyMllpcjVIRjRGcjZvNjJPQzRNMnRlU1NySzYwbXJt?=
 =?utf-8?B?cnZaSXZJaDhiRGJML1liSk5iWU1VQUFEbXlsaTlva1NlczZhcC90UUJCKzhT?=
 =?utf-8?B?SUR1R3lNNy93dTMzQm5YamRNQVZ5Rk1RQzBoQzN4dmxVWElvK3JVWmhyT3RI?=
 =?utf-8?B?VDFWYXEvSlJpUjVSRFdWdkRCYlZ6ZUk0RjlGZ3k1dFlkb2wydENVcXQ5OGFi?=
 =?utf-8?B?Y2NCTFZibzhZU3RmSEtKVTN2WEVMN1JKdVRoaHpPckFQSGpBcUlxRFVuT1lB?=
 =?utf-8?B?YXVkclo1VElyWXlkZjZTaVk2RnV5N01LdEFHRlRySk5MYzJ0SW5PWnRaWmxF?=
 =?utf-8?B?alpoLy9LY05mbnAvaG9OZGE1dC9rS0g4UGozSFN3VHptR0JRc2kreFNvejAz?=
 =?utf-8?B?NzJoTzRBUzZaVEJ2N25INWFZQXRVdE5kSTBlbDFRR1Z1WmZSay9zK3Bnd2ww?=
 =?utf-8?B?aXczZ2p2T01pWkoyMTZrS1YydmVNVUpvcWVDZVNxaVZKWUcxR05YenpXVzVi?=
 =?utf-8?B?TDVSZkVpcmtlYXhVRk5oNFJIRklTNy9EVDhHOVAzSGZPODFIUysySzFGZXF0?=
 =?utf-8?B?MUx0cnJpVXM5ZzdwUzBBWm8wdTl0UWZ1U3lqbHNlR1VBMzduNjdLQkp6eGpO?=
 =?utf-8?B?cDJaN0VpZXltUHp0UDZuYnRQMWRoclRZSTYxWFR6akpOUytCcUpzMDNOVkJz?=
 =?utf-8?B?TFhoOURUbC9pTVJqN2FtWmpMdUkwcURORVNqZFdOZEswaVRjeGVuR1pSaTZt?=
 =?utf-8?B?RUcwd0tvS0lvZnRESlBSUU1adjdqeWhZazNQT1o2d1U5QlBlL3BSU29kaHIz?=
 =?utf-8?B?MGJhVG92WGcxYzNtS3RWZDlBWTdsZmxkRWtya09KVW9jMTRTZjdFVWJDUlpN?=
 =?utf-8?B?bkl6U0xOb0dzbGxvZlNnWFhYaHBIN29RTTB3d0d5dVdHeEd2SlY3SGxmTUVP?=
 =?utf-8?B?S2JJM1p1MnYzdzBTWHNqb0c0UTh3cDZzc1dFVjJ5aGk3a21obzZkNHhxUm83?=
 =?utf-8?B?VE81bEVjYW55NVBIMEpSVDJwRGxrTHRzeS90VHRGbnloZkxvcS9uT1dTNlF6?=
 =?utf-8?B?T2IwUXA5M3VvQVdNTHVFUjJkL0NITWQyZ1BGb0RYMXQ0NFYvN1owRmZvNGs0?=
 =?utf-8?B?Q3h5R2xiaUlzanBwTjNaeXJQSjY5Ti9WYXlOWHlFbkFPRVFBd2p5RjAwUXZx?=
 =?utf-8?B?dE1ja1FqanNSc0cxZWJ6WU5lRWRNcVFNY1pWOWxCNXdWSDVIbFAyWlNzZFlN?=
 =?utf-8?B?MGpTVVh1Z21PU3BpT3hVdEJ4U2tiQmJ5OHNQSC81WTVrNWJUalc0QUV4QWFF?=
 =?utf-8?B?bmJDUzdOcUxzMVp6Q0xMaFdraDlLc0xRVjBOSWxpREZQeUVMY2ZibUVadGZ5?=
 =?utf-8?B?WE12b3lNTjFSaHlDSUhEYWxKVzNZRlRyMUdXV3VNM2luSzN3dzBvYVRnYkxu?=
 =?utf-8?B?WDF3UDVKM1M3L2YrN2RmQUpjVWhiVWc4TjAxVm9XMHdKYm94UFVSZXFzYmZV?=
 =?utf-8?B?ZTdaQldkRGsrTmtxYmxJcHRFRzdsSURIZkdyUXhmS0h4M2xJdmRodzd5VzFr?=
 =?utf-8?B?UVFTRlB4TmcyZjhac0pmelkrK2NVeXZhbWtUbWI3aWNLRUpyQUkxcmhnYlJ1?=
 =?utf-8?B?V3R3cmRZTkRkajJsODJCR0ppT2lHeXpJYWRPTU5CTXQzenRpRThCRzI1b0hH?=
 =?utf-8?Q?3Un5sffsqXTE4mTlcvjCT5p4cd9/+Jzh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:52.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305c0d6f-bf37-4e41-b9ea-08dd115293e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 * Drop __packed
---
 drivers/platform/x86/amd/hfi/hfi.c | 196 +++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 2cd71d79a22c9..3c90e93fd192c 100644
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
+};
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



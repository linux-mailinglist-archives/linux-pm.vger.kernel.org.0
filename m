Return-Path: <linux-pm+bounces-22328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D78A3A6FF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9E169034
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66803274262;
	Tue, 18 Feb 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArCDJ5eQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536E274258;
	Tue, 18 Feb 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905741; cv=none; b=rw3hYoXFPhmA8OCI+GaZ5UCuIsrj+ejkTglECln0QNsEh1qd1v/O08PCx0ERhcPF0OCmvOtwIbjJcmUROHM7Fv6xY25i7cTKH7Sg0amQ55whePFGwtAsjZ+nKit6nQun8jTeQBw+P5a3ONck4zBrYaRQH/QVLINd5bnbUc4DMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905741; c=relaxed/simple;
	bh=6sI0GRW/qnQOu2y/XnVKfxVu+sKklHKajvLwOtU484E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCEkmGzrYLr2UIbMAPqsz39kEwfPkzRVCMMTRSq6I85Kg3W2EfAyjHdaluRbbaES2Ux+7vPp4VxAP6XL741syXP8F/HBcl1B3gI5R8EFa7tGb3mno+bUGZHbXDmIkQw/smJXaSEjUqPhb0Nq7pXkAql7IQFsyN9OkVG7fzmiEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArCDJ5eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B126EC4CEE4;
	Tue, 18 Feb 2025 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905740;
	bh=6sI0GRW/qnQOu2y/XnVKfxVu+sKklHKajvLwOtU484E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArCDJ5eQc22nv4zcxRxmpRnL0kttAAZBudyEvitqJBcBzuhXX+L4F5lhZDcolI/zO
	 k69rzejJ2hcxXEvOnsXS5ty5w8MgRrB3Ez24CnsVt/VMp+znGLG6/tPe+QTCaeAGru
	 /Ay/HBjnTsIZlDSK/W/5zxRxFq7oKyNL9RbOwnsi4nsKBMoJ+9oMHg1Yfnp55E34fi
	 3OErkO/AtU4T9EQ/jOVIHMO+QFdg7BxofSwYZ06HshCLCuOc2vcoWkOD5YcBe+inek
	 B8BtEjfJxR5VyJanGq139MMqDiprT6bB5RmFyKIO1AD377gDLSaZzIwKnQWpT9Wx2N
	 d5qUasYiYFeVA==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v8 05/13] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Tue, 18 Feb 2025 13:08:14 -0600
Message-ID: <20250218190822.1039982-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Reverse xmas tree order in amd_hfi_fill_metadata()
 * s,for_each_present_cpu,for_each_possible_cpu,
v2:
 * Drop __packed
---
 drivers/platform/x86/amd/hfi/hfi.c | 194 +++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 426f7e520b76c..7ab7ae0ec72ca 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,22 +18,72 @@
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
+#define AMD_HFI_MAILBOX_COUNT		1
+#define AMD_HETERO_RANKING_TABLE_VER	2
 
 #define AMD_HETERO_CPUID_27	0x80000027
 
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
@@ -42,21 +92,103 @@ struct amd_hfi_classes {
 /**
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		cpu index
+ * @apic_id:		apic id of the current cpu
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
+			int apic_id = i * BITS_PER_TYPE(u32) + j;
+			struct amd_hfi_cpuinfo *info;
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
@@ -73,6 +205,7 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
 	for_each_possible_cpu(idx) {
 		struct amd_hfi_classes *classes;
+		int *ipcc_scores;
 
 		classes = devm_kcalloc(dev,
 				       nr_class_id,
@@ -80,14 +213,71 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
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
@@ -116,6 +306,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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



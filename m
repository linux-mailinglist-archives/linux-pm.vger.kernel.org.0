Return-Path: <linux-pm+bounces-28321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362AFAD2736
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC603B2ABC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77A221FD3;
	Mon,  9 Jun 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVeKutTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3490221FBA;
	Mon,  9 Jun 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499534; cv=none; b=kQPzBh0pSzZ7P2PM91pMOpc7uMcl6ZQ1KB8wKG3qqRJpDaic6IcVDHW+ZPJ7DPgBRtL98bLGe7tQtGlfUkhqZturyjbaG0xFJnJK0GBGuPP4IxYklDfqZY7BNqBnjQvMC8W/uvmlJS69VMx4I6Y4sB0iFon+eJzNL/jsqP4COrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499534; c=relaxed/simple;
	bh=lSaLanyn+kHdSqSgLQKmnHdRc7dGBuqWLjuUQUyNAwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8tgxE8jOJ2PzqRMom4yjGjo1lwDqcFxGzAUAxWvhMU6vLefWzNxuda20aYyc3oliOg3rrPgtEL+3XlUfGDwqjd9+9qvlvV+azngEn3V/uD2Kyc7bGSEdG6qVb4k4/cBBiPTvntdIw3EKGuQnjgGACStNUq+RDSNFzuxUl2mafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVeKutTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF9C4CEFB;
	Mon,  9 Jun 2025 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499534;
	bh=lSaLanyn+kHdSqSgLQKmnHdRc7dGBuqWLjuUQUyNAwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVeKutTc/7rtY8nzOrQKBtdq1tjDUEDuoR+L552BrIm5dU57oQAwfbhBl5uCSr1rR
	 xIpn4ZwE6TPRt3VgGlBMKgYgfILDBb+zl4S7yhNDLnnEpHwbmTDnGulvSH1kdBO9Zz
	 nkGkLhJd+t3cjEBidI/H0NFBCA6oSUHNCP/Itax4IB9G1qQh8ZiFhxrR9rde8vG/vV
	 0KJzIMTmUXMyb7AlBBSz9VhEIOLaOAs7034XLYVZ35u7qI3PNL2796oDbjRM4aXTKt
	 OTWBpQTq71DsHmO228+TsU2XxMD2LZyHcJ47FzIA5ztPF0f3ezYr+TwEAKns2ajDUQ
	 VYEtvl6EJXz5g==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
	Perry Yuan <Perry.Yuan@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v11 04/13] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Mon,  9 Jun 2025 15:05:09 -0500
Message-ID: <20250609200518.3616080-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <Perry.Yuan@amd.com>

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

There are two CPU core types defined: `Classic Core` and `Dense Core`.
"Classic" cores are the standard performance cores, while "Dense" cores
are optimized for area and efficiency.

Heterogeneous compute refers to CPU implementations that are comprised
of more than one architectural class, each with two capabilities. This
means each CPU reports two separate capabilities: "perf" and "eff".

Each capability lists all core ranking numbers between 0 and 255, where
a higher number represents a higher capability.

Heterogeneous systems can also extend to more than two architectural
classes.

The purpose of the scheduling feedback mechanism is to provide information
to the operating system scheduler in real time, allowing the scheduler to
direct threads to the optimal core during task scheduling.

All core ranking data are provided by the PMFW via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Rebase on v6.16-rc1 (Adjust for X86_FEATURE_AMD_HTR_CORES)
 * Use one tab + two spaces for help text (Randy)
v9:
 * Drop Kconfig mentions of $FUTURE features
 * 2024 -> 2025
 * change nr_class_id to unsigned
 * change classes number error to be clearer
 * symmetry for probe/cleanup
 * drop extra mutex
v8:
 * s,devm_kzalloc,devm_kcalloc,
 * fold newlines from patch 5 into this patch
 * Drop ->cpu member, push to later patch
 * s,for_each_present_cpu,for_each_possible_cpu,
v7:
 * Adjust Kconfig to 80 characters
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  17 +++
 drivers/platform/x86/amd/hfi/Makefile |   7 ++
 drivers/platform/x86/amd/hfi/hfi.c    | 158 ++++++++++++++++++++++++++
 5 files changed, 184 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index 63e4bd985699c..b813f92653686 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -6,6 +6,7 @@
 source "drivers/platform/x86/amd/hsmp/Kconfig"
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_3D_VCACHE
 	tristate "AMD 3D V-Cache Performance Optimizer Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index b0e284b5d4979..f6ff0c837f345 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_AMD_HSMP)		+= hsmp/
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
 obj-$(CONFIG_AMD_ISP_PLATFORM)	+= amd_isp4.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 0000000000000..019638047e629
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+config AMD_HFI
+	bool "AMD Hetero Core Hardware Feedback Driver"
+	depends on ACPI
+	depends on CPU_SUP_AMD
+	help
+	  Select this option to enable the AMD Heterogeneous Core Hardware
+	  Feedback Interface. If selected, hardware provides runtime thread
+	  classification guidance to the operating system on the performance and
+	  energy efficiency capabilities of each heterogeneous CPU core. These
+	  capabilities may vary due to the inherent differences in the core types
+	  and can also change as a result of variations in the operating
+	  conditions of the system such as power and thermal limits.
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
new file mode 100644
index 0000000000000..672c6ac106e95
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+obj-$(CONFIG_AMD_HFI) += amd_hfi.o
+amd_hfi-objs := hfi.o
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
new file mode 100644
index 0000000000000..e613bdf027b26
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Authors: Perry Yuan <Perry.Yuan@amd.com>
+ *          Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#define pr_fmt(fmt)  "amd-hfi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define AMD_HFI_DRIVER		"amd_hfi"
+
+#define AMD_HETERO_CPUID_27	0x80000027
+
+static struct platform_device *device;
+
+struct amd_hfi_data {
+	const char	*name;
+	struct device	*dev;
+};
+
+struct amd_hfi_classes {
+	u32	perf;
+	u32	eff;
+};
+
+/**
+ * struct amd_hfi_cpuinfo - HFI workload class info per CPU
+ * @cpu:		cpu index
+ * @class_index:	workload class ID index
+ * @nr_class:		max number of workload class supported
+ * @amd_hfi_classes:	current cpu workload class ranking data
+ *
+ * Parameters of a logical processor linked with hardware feedback class.
+ */
+struct amd_hfi_cpuinfo {
+	int		cpu;
+	s16		class_index;
+	u8		nr_class;
+	struct amd_hfi_classes	*amd_hfi_classes;
+};
+
+static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
+
+static int amd_hfi_alloc_class_data(struct platform_device *pdev)
+{
+	struct amd_hfi_cpuinfo *hfi_cpuinfo;
+	struct device *dev = &pdev->dev;
+	u32 nr_class_id;
+	int idx;
+
+	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
+	if (nr_class_id > 255) {
+		dev_err(dev, "number of supported classes too large: %d\n",
+			nr_class_id);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(idx) {
+		struct amd_hfi_classes *classes;
+
+		classes = devm_kcalloc(dev,
+				       nr_class_id,
+				       sizeof(struct amd_hfi_classes),
+				       GFP_KERNEL);
+		if (!classes)
+			return -ENOMEM;
+		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes = classes;
+		hfi_cpuinfo->nr_class = nr_class_id;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] = {
+	{"AMDI0104", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
+
+static int amd_hfi_probe(struct platform_device *pdev)
+{
+	struct amd_hfi_data *amd_hfi_data;
+	int ret;
+
+	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
+		return -ENODEV;
+
+	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
+	if (!amd_hfi_data)
+		return -ENOMEM;
+
+	amd_hfi_data->dev = &pdev->dev;
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	ret = amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver amd_hfi_driver = {
+	.driver = {
+		.name = AMD_HFI_DRIVER,
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
+	},
+	.probe = amd_hfi_probe,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES) ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		return -ENODEV;
+
+	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
+	if (IS_ERR(device)) {
+		pr_err("unable to register HFI platform device\n");
+		return PTR_ERR(device);
+	}
+
+	ret = platform_driver_register(&amd_hfi_driver);
+	if (ret)
+		pr_err("failed to register HFI driver\n");
+
+	return ret;
+}
+
+static __exit void amd_hfi_exit(void)
+{
+	platform_driver_unregister(&amd_hfi_driver);
+	platform_device_unregister(device);
+}
+module_init(amd_hfi_init);
+module_exit(amd_hfi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
-- 
2.43.0



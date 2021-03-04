Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7832CC5C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhCDGJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:09:29 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2835 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhCDGI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:08:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079520002>; Wed, 03 Mar 2021 22:08:18 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:17 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:17 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 2/5] firmware: tegra: Add Tegra194 MCE ARI driver
Date:   Wed, 3 Mar 2021 22:08:09 -0800
Message-ID: <1614838092-30398-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838098; bh=lI74aTkbe7LHdD3TDHPb188VdRsOXpjv+fKYqb3YOUQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Bz3tqcXReN+BamoYpdXOxQGSHyJBV38ZJo+56JWAdVWBivXubU5KQ7//VNovoo1PT
         wD12yGyUI0w/It31cMP4kDZj7DdQVCL8apGI4f6kJKcAydIFn3nIdqAVJx2yiODXdg
         pIDC+Jfh5t1PBDIG34OCGtljvEJOR7OxZEoUnT/16tsRIKnKTLI0AmUo0B1D03SLOi
         /Tju/oPoW0W0XZKRNc75oLmZFR9RGXJWLU94brRXMHBeB/zHXOtB1H1osa7rqHdod3
         qt41Z8vmSkIW04hEmk4yNXw0c0FtaEgr26mTxRxTOrK/QtpQHXgcymzMpHwEEpI3ad
         Zl+2kFKbsSBWA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra MCE Abstract Request Interface (ARI) driver manages all NVG
requests to MCE firmware running in the background.

This patch adds Tegra194 MCE interface driver for communicating with
MCE firmware on CPU state configurations and state transition requests
from the CPU idle driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/firmware/tegra/Kconfig        |  11 +++
 drivers/firmware/tegra/Makefile       |   4 +
 drivers/firmware/tegra/mce-tegra194.c | 155 ++++++++++++++++++++++++++++++++++
 drivers/firmware/tegra/mce.c          |  88 +++++++++++++++++++
 include/soc/tegra/mce.h               |  32 +++++++
 include/soc/tegra/t194_nvg.h          |  56 ++++++++++++
 6 files changed, 346 insertions(+)
 create mode 100644 drivers/firmware/tegra/mce-tegra194.c
 create mode 100644 drivers/firmware/tegra/mce.c
 create mode 100644 include/soc/tegra/mce.h
 create mode 100644 include/soc/tegra/t194_nvg.h

diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
index 1c8ba1f..a14ef1c 100644
--- a/drivers/firmware/tegra/Kconfig
+++ b/drivers/firmware/tegra/Kconfig
@@ -23,4 +23,15 @@ config TEGRA_BPMP
 	  This driver manages the IPC interface between host CPU and the
 	  firmware running on BPMP.
 
+config TEGRA_MCE
+	bool "Tegra MCE driver"
+	depends on ARCH_TEGRA_194_SOC
+	help
+	  MCE (Micro Codec Engine) firmware is in charge of CPUs power state
+	  transitions.
+
+	  Tegra MCE driver is an interface driver to communicate with MCE
+	  firmware for all the CPU power state change requests from CPU idle
+	  driver.
+
 endmenu
diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
index 49c87e0..2c0417e 100644
--- a/drivers/firmware/tegra/Makefile
+++ b/drivers/firmware/tegra/Makefile
@@ -6,3 +6,7 @@ tegra-bpmp-$(CONFIG_ARCH_TEGRA_194_SOC)	+= bpmp-tegra186.o
 tegra-bpmp-$(CONFIG_DEBUG_FS)	+= bpmp-debugfs.o
 obj-$(CONFIG_TEGRA_BPMP)	+= tegra-bpmp.o
 obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
+
+tegra-mce-y			= mce.o
+tegra-mce-$(CONFIG_ARCH_TEGRA_194_SOC)	+= mce-tegra194.o
+obj-$(CONFIG_TEGRA_MCE)		+= tegra-mce.o
diff --git a/drivers/firmware/tegra/mce-tegra194.c b/drivers/firmware/tegra/mce-tegra194.c
new file mode 100644
index 0000000..5cec761d
--- /dev/null
+++ b/drivers/firmware/tegra/mce-tegra194.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <soc/tegra/t194_nvg.h>
+#include <soc/tegra/mce.h>
+
+#include <asm/smp_plat.h>
+
+/* Issue a NVG request with data */
+static noinline notrace void nvg_send_req_data(u64 req, u64 data)
+{
+	asm volatile ("msr s3_0_c15_c1_2, %0\n"
+		      "msr s3_0_c15_c1_3, %1\n"
+		      :: "r" (req), "r" (data));
+}
+
+/* Issue a NVG request with no data */
+static noinline notrace void nvg_send_req(u64 req)
+{
+	asm volatile ("msr s3_0_c15_c1_2, %0\n" :: "r" (req));
+}
+
+/* Issue a NVG request to read the command response */
+static noinline notrace u64 nvg_get_response(void)
+{
+	u64 ret;
+
+	asm volatile ("mrs %0, s3_0_c15_c1_3" : "=r" (ret));
+
+	return ret;
+}
+
+static int tegra194_mce_update_cstate_info(u32 cluster, u32 ccplex, u32 system,
+					   u8 force, u32 wake_mask, bool valid)
+{
+	nvg_cstate_info_channel_t cstate_info = { 0 };
+
+	/* disable preemption */
+	preempt_disable();
+
+	/* update CLUSTER_CSTATE? */
+	if (cluster) {
+		cstate_info.bits.cluster_state = cluster;
+		cstate_info.bits.update_cluster = 1;
+	}
+
+	/* update CCPLEX_CSTATE? */
+	if (ccplex) {
+		cstate_info.bits.cg_cstate = ccplex;
+		cstate_info.bits.update_cg = 1;
+	}
+
+	/* update SYSTEM_CSTATE? */
+	if (system) {
+		cstate_info.bits.system_cstate = system;
+		cstate_info.bits.update_system = 1;
+	}
+
+	/* update wake mask value? */
+	if (valid)
+		cstate_info.bits.update_wake_mask = 1;
+
+	/* set the wake mask */
+	cstate_info.bits.wake_mask = wake_mask;
+
+	/* set the updated cstate info */
+	nvg_send_req_data(TEGRA_NVG_CHANNEL_CSTATE_INFO, cstate_info.flat);
+
+	/* enable preemption */
+	preempt_enable();
+
+	return 0;
+}
+
+static int tegra194_mce_update_crossover_time(u32 type, u32 time)
+{
+	if (type != TEGRA_NVG_CHANNEL_CROSSOVER_C6_LOWER_BOUND &&
+	    type != TEGRA_NVG_CHANNEL_CROSSOVER_CC6_LOWER_BOUND &&
+	    type != TEGRA_NVG_CHANNEL_CROSSOVER_CG7_LOWER_BOUND) {
+		pr_err("%s: unknown crossover type (%d)\n", __func__, type);
+		return -EINVAL;
+	}
+
+	/* disable pre-emption*/
+	preempt_disable();
+
+	nvg_send_req_data(type, (u64)time);
+
+	/* enable pre-emption */
+	preempt_enable();
+
+	return 0;
+}
+
+static int tegra194_mce_read_cstate_stats(u32 state, u64 *stats)
+{
+	if (!stats)
+		return -EINVAL;
+
+	/* disable preemption */
+	preempt_disable();
+
+	nvg_send_req_data(TEGRA_NVG_CHANNEL_CSTATE_STAT_QUERY_REQUEST, (u64)state);
+	nvg_send_req(TEGRA_NVG_CHANNEL_CSTATE_STAT_QUERY_VALUE);
+	*stats = nvg_get_response();
+
+	/* enable preemption */
+	preempt_enable();
+
+	return 0;
+}
+
+static int tegra194_mce_read_versions(u32 *major, u32 *minor)
+{
+	u64 version;
+
+	if (!major || !minor)
+		return -EINVAL;
+
+	/* disable preemption */
+	preempt_disable();
+
+	nvg_send_req(TEGRA_NVG_CHANNEL_VERSION);
+	version = nvg_get_response();
+	*minor = (u32)version;
+	*major = (u32)(version >> 32);
+
+	/* enable preemption */
+	preempt_enable();
+
+	return 0;
+}
+
+static struct tegra_mce_ops t194_mce_ops = {
+	.update_cstate_info = tegra194_mce_update_cstate_info,
+	.update_crossover_time = tegra194_mce_update_crossover_time,
+	.read_cstate_stats = tegra194_mce_read_cstate_stats,
+	.read_versions = tegra194_mce_read_versions,
+};
+
+static int __init tegra194_mce_early_init(void)
+{
+	tegra_mce_set_ops(&t194_mce_ops);
+
+	return 0;
+}
+early_initcall(tegra194_mce_early_init);
+
+MODULE_DESCRIPTION("NVIDIA Tegra194 MCE driver");
+MODULE_AUTHOR("NVIDIA Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/tegra/mce.c b/drivers/firmware/tegra/mce.c
new file mode 100644
index 0000000..6d949ff
--- /dev/null
+++ b/drivers/firmware/tegra/mce.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION.
+ */
+
+#include <linux/module.h>
+#include <soc/tegra/mce.h>
+
+static struct tegra_mce_ops *mce_ops;
+
+void tegra_mce_set_ops(struct tegra_mce_ops *tegra_plat_mce_ops)
+{
+	mce_ops = tegra_plat_mce_ops;
+}
+
+/**
+ * Specify deepest cluster/ccplex/system states allowed.
+ *
+ * @cluster:	deepest cluster-wide state
+ * @ccplex:	deepest ccplex-wide state
+ * @system:	deepest system-wide state
+ * @force:	forced system state
+ * @wake_mask:	wake mask to be updated
+ * @valid:	is wake_mask applicable?
+ *
+ * Returns 0 if success.
+ */
+int tegra_mce_update_cstate_info(u32 cluster, u32 ccplex, u32 system,
+				 u8 force, u32 wake_mask, bool valid)
+{
+	if (mce_ops && mce_ops->update_cstate_info)
+		return mce_ops->update_cstate_info(cluster, ccplex, system, force,
+						   wake_mask, valid);
+	else
+		return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_mce_update_cstate_info);
+
+/**
+ * Update threshold for one specific c-state crossover
+ *
+ * @type: type of state crossover.
+ * @time: idle time threshold.
+ *
+ * Returns 0 if success.
+ */
+int tegra_mce_update_crossover_time(u32 type, u32 time)
+{
+	if (mce_ops && mce_ops->update_crossover_time)
+		return mce_ops->update_crossover_time(type, time);
+	else
+		return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_mce_update_crossover_time);
+
+/**
+ * Query the runtime stats of a specific cstate
+ *
+ * @state: c-state of the stats.
+ * @stats: output integer to hold the stats.
+ *
+ * Returns 0 if success.
+ */
+int tegra_mce_read_cstate_stats(u32 state, u64 *stats)
+{
+	if (mce_ops && mce_ops->read_cstate_stats)
+		return mce_ops->read_cstate_stats(state, stats);
+	else
+		return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_mce_read_cstate_stats);
+
+/**
+ * Read out MCE API major/minor versions
+ *
+ * @major: output for major number.
+ * @minor: output for minor number.
+ *
+ * Returns 0 if success.
+ */
+int tegra_mce_read_versions(u32 *major, u32 *minor)
+{
+	if (mce_ops && mce_ops->read_versions)
+		return mce_ops->read_versions(major, minor);
+	else
+		return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_mce_read_versions);
diff --git a/include/soc/tegra/mce.h b/include/soc/tegra/mce.h
new file mode 100644
index 0000000..d4be89f
--- /dev/null
+++ b/include/soc/tegra/mce.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 NVIDIA Corporation
+ */
+
+#ifndef __SOC_TEGRA_MCE_H__
+#define __SOC_TEGRA_MCE_H__
+
+/*
+ * For correct version validation, below two defines need to be
+ * updated whenever there is a new ARI implementation.
+ */
+#define CUR_ARI_VER_MAJOR	1
+#define CUR_ARI_VER_MINOR	2
+
+int tegra_mce_update_cstate_info(u32 cluster, u32 ccplex, u32 system,
+				 u8 force, u32 wake_mask, bool valid);
+int tegra_mce_update_crossover_time(u32 type, u32 time);
+int tegra_mce_read_cstate_stats(u32 state, u64 *stats);
+int tegra_mce_read_versions(u32 *major, u32 *minor);
+
+struct tegra_mce_ops {
+	int (*update_cstate_info)(u32 cluster, u32 ccplex, u32 system,
+				  u8 force, u32 wake_mask, bool valid);
+	int (*update_crossover_time)(u32 type, u32 time);
+	int (*read_cstate_stats)(u32 state, u64 *stats);
+	int (*read_versions)(u32 *major, u32 *minor);
+};
+
+void tegra_mce_set_ops(struct tegra_mce_ops *mce_ops);
+
+#endif /* __SOC_TEGRA_MCE_H__ */
diff --git a/include/soc/tegra/t194_nvg.h b/include/soc/tegra/t194_nvg.h
new file mode 100644
index 0000000..3a5d558
--- /dev/null
+++ b/include/soc/tegra/t194_nvg.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 NVIDIA Corporation
+ */
+
+#ifndef __T194_NVG_H__
+#define __T194_NVG_H__
+
+/* Header for the NVIDIA Generic interface (NVG) */
+
+/*
+ * Major version increments may break backwards compatibility and binary
+ * compatibility. Minor version increments occur when there is only new
+ * functionality.
+ */
+enum {
+	TEGRA_NVG_VERSION_MAJOR = 6,
+	TEGRA_NVG_VERSION_MINOR = 6,
+};
+
+enum {
+	TEGRA_NVG_CHANNEL_VERSION				= 0,
+	TEGRA_NVG_CHANNEL_CSTATE_INFO				= 4,
+	TEGRA_NVG_CHANNEL_CROSSOVER_C6_LOWER_BOUND		= 5,
+	TEGRA_NVG_CHANNEL_CROSSOVER_CC6_LOWER_BOUND		= 6,
+	TEGRA_NVG_CHANNEL_CROSSOVER_CG7_LOWER_BOUND		= 8,
+	TEGRA_NVG_CHANNEL_CSTATE_STAT_QUERY_REQUEST		= 10,
+	TEGRA_NVG_CHANNEL_CSTATE_STAT_QUERY_VALUE		= 11,
+};
+
+enum {
+	TEGRA_NVG_CORE_C0 = 0,
+	TEGRA_NVG_CORE_C1 = 1,
+	TEGRA_NVG_CORE_C6 = 6,
+};
+
+/* NVG Data subformats */
+typedef union {
+	u64 flat;
+	struct nvg_cstate_info_channel_t {
+		uint32_t cluster_state		: 3;
+		uint32_t reserved_6_3		: 4;
+		uint32_t update_cluster		: 1;
+		uint32_t cg_cstate		: 3;
+		uint32_t reserved_14_11		: 4;
+		uint32_t update_cg		: 1;
+		uint32_t system_cstate		: 4;
+		uint32_t reserved_22_20		: 3;
+		uint32_t update_system		: 1;
+		uint32_t reserved_30_24		: 7;
+		uint32_t update_wake_mask	: 1;
+		uint32_t wake_mask		: 32;
+	} bits;
+} nvg_cstate_info_channel_t;
+
+#endif /* __T194_NVG_H__ */
-- 
2.7.4


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E67F14E1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 12:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKFLT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 06:19:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFLT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 06:19:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 713E5602EF; Wed,  6 Nov 2019 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573039196;
        bh=cURXtLqZ6tIDcwNNl2xs+365IFqil9Q21AKcdhK6P2s=;
        h=From:To:Cc:Subject:Date:From;
        b=FzC5gEZFLDwUdnTmlzBgLBIQIlaEKPqNVztfJlP3ns3jcQPcNpuL+R0jaiDKooJHU
         TCZmF2bxKSRGidbyYmpRd67phZtrYkYtwbZOJdCUZl9/ujuPJzO4arzPMFo0MUFHsX
         eIyeWuXvErFWgGxJMa8y6zrEMaGOpAkv9CZ4srBI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65DDA602EF;
        Wed,  6 Nov 2019 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573039194;
        bh=cURXtLqZ6tIDcwNNl2xs+365IFqil9Q21AKcdhK6P2s=;
        h=From:To:Cc:Subject:Date:From;
        b=k1oMGSEc9loZHH0gAFYjQJgPhz1/xo547CuC9B6+blzG4CoysehCY91ED1usAaMcJ
         Q8lAYANkxC4eppRm4GZ1a/u897J+d5gByVfc4FygzQWGF/SJmaz7RRkJ3CZ+/C0Zvj
         O+FhKDq8X8bv4R4YZiufDChthJbUtfBYqgsnWOB0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65DDA602EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [v3] soc: qcom: Introduce subsystem sleep stats driver
Date:   Wed,  6 Nov 2019 16:49:25 +0530
Message-Id: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Multiple subsystems like modem, spss, adsp, cdsp present on
Qualcomm Technologies Inc's (QTI) SoCs maintains low power mode
statistics in shared memory (SMEM). Lets add a driver to read
and display this information using sysfs.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
Changes in v3:
	- Addressed comments from v2.

Changes in v2:
	- Correct Makefile to use QCOM_SS_SLEEP_STATS config
---
 Documentation/ABI/testing/sysfs-power    |  10 +++
 drivers/soc/qcom/Kconfig                 |   9 ++
 drivers/soc/qcom/Makefile                |   1 +
 drivers/soc/qcom/subsystem_sleep_stats.c | 143 +++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/soc/qcom/subsystem_sleep_stats.c

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 6f87b9d..e095eae 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -288,6 +288,16 @@ Description:
 		writing a "0" (default) to it disables them.  Reads from
 		this file return the current value.
 
+What:		/sys/power/subsystem_sleep/stats
+Date:		December 2017
+Contact:	Maulik Shah <mkshah@codeaurora.org>
+Description:
+		The /sys/power/subsystem_sleep/stats file prints the subsystem
+		sleep information on Qualcomm Technologies, Inc. (QTI) SoCs.
+
+		Reading from this file will display subsystem level low power
+		mode statistics.
+
 What:		/sys/power/resume_offset
 Date:		April 2018
 Contact:	Mario Limonciello <mario.limonciello@dell.com>
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 79d8265..bed0704 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -185,6 +185,15 @@ config QCOM_SOCINFO
 	 Say yes here to support the Qualcomm socinfo driver, providing
 	 information about the SoC to user space.
 
+config QCOM_SS_SLEEP_STATS
+	tristate "Qualcomm Technologies Inc. Subsystem Sleep Stats driver"
+	depends on QCOM_SMEM
+	help
+	  Say y here to enable support for the Qualcomm Technologies Inc (QTI)
+	  SS sleep stats driver to read the sleep stats of various subsystems
+	  from SMEM. The stats are exported to sysfs. The driver also maintains
+	  application processor sleep stats.
+
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 9fb35c8..f3a2fb0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
+obj-$(CONFIG_QCOM_SS_SLEEP_STATS)	+= subsystem_sleep_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/subsystem_sleep_stats.c
new file mode 100644
index 00000000..724b213
--- /dev/null
+++ b/drivers/soc/qcom/subsystem_sleep_stats.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, KBUILD_MODNAME
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/soc/qcom/smem.h>
+
+enum subsystem_item_id {
+	MODEM = 605,
+	ADSP,
+	CDSP,
+	SLPI,
+	GPU,
+	DISPLAY,
+};
+
+enum subsystem_pid {
+	PID_APSS = 0,
+	PID_MODEM = 1,
+	PID_ADSP = 2,
+	PID_SLPI = 3,
+	PID_CDSP = 5,
+	PID_GPU = PID_APSS,
+	PID_DISPLAY = PID_APSS,
+};
+
+struct subsystem_data {
+	char *name;
+	enum subsystem_item_id item_id;
+	enum subsystem_pid pid;
+};
+
+static const struct subsystem_data subsystems[] = {
+	{ "MODEM", MODEM, PID_MODEM },
+	{ "ADSP", ADSP, PID_ADSP },
+	{ "CDSP", CDSP, PID_CDSP },
+	{ "SLPI", SLPI, PID_SLPI },
+	{ "GPU", GPU, PID_GPU },
+	{ "DISPLAY", DISPLAY, PID_DISPLAY },
+};
+
+struct subsystem_stats {
+	uint32_t version_id;
+	uint32_t count;
+	uint64_t last_entered;
+	uint64_t last_exited;
+	uint64_t accumulated_duration;
+};
+
+struct subsystem_stats_prv_data {
+	struct kobj_attribute ka;
+	struct kobject *kobj;
+};
+
+static struct subsystem_stats_prv_data *prvdata;
+
+static inline ssize_t subsystem_stats_print(char *prvbuf, ssize_t length,
+					    struct subsystem_stats *record,
+					    const char *name)
+{
+	return scnprintf(prvbuf, length, "%s\n\tVersion:0x%x\n"
+			"\tSleep Count:0x%x\n"
+			"\tSleep Last Entered At:0x%llx\n"
+			"\tSleep Last Exited At:0x%llx\n"
+			"\tSleep Accumulated Duration:0x%llx\n\n",
+			name, record->version_id, record->count,
+			record->last_entered, record->last_exited,
+			record->accumulated_duration);
+}
+
+static ssize_t subsystem_stats_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	ssize_t length = 0;
+	int i = 0;
+	size_t size = 0;
+	struct subsystem_stats *record = NULL;
+
+	/* Read SMEM data written by other subsystems */
+	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
+		record = (struct subsystem_stats *) qcom_smem_get(
+			  subsystems[i].pid, subsystems[i].item_id, &size);
+
+		if (!IS_ERR(record) && (PAGE_SIZE - length > 0))
+			length += subsystem_stats_print(buf + length,
+							PAGE_SIZE - length,
+							record,
+							subsystems[i].name);
+	}
+
+	return length;
+}
+
+static int __init subsystem_sleep_stats_init(void)
+{
+	struct kobject *ss_stats_kobj;
+	int ret;
+
+	prvdata = kzalloc(sizeof(*prvdata), GFP_KERNEL);
+	if (!prvdata)
+		return -ENOMEM;
+
+	ss_stats_kobj = kobject_create_and_add("subsystem_sleep",
+					       power_kobj);
+	if (!ss_stats_kobj)
+		return -ENOMEM;
+
+	prvdata->kobj = ss_stats_kobj;
+
+	sysfs_attr_init(&prvdata->ka.attr);
+	prvdata->ka.attr.mode = 0444;
+	prvdata->ka.attr.name = "stats";
+	prvdata->ka.show = subsystem_stats_show;
+
+	ret = sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
+	if (ret) {
+		kobject_put(prvdata->kobj);
+		kfree(prvdata);
+	}
+
+	return ret;
+}
+
+static void __exit subsystem_sleep_stats_exit(void)
+{
+	sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
+	kobject_put(prvdata->kobj);
+	kfree(prvdata);
+}
+
+module_init(subsystem_sleep_stats_init);
+module_exit(subsystem_sleep_stats_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc subsystem sleep stats driver");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


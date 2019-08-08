Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6385A5B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 08:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfHHGNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 02:13:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfHHGNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 02:13:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C3E576058E; Thu,  8 Aug 2019 06:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244814;
        bh=1iME6ppVp1VoWQYGmbZMKD1rVId64moVHK8NrmaA64o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhinH6f2bKcYl70HjIiGR295AxK7YYKm7ovCplrDYwazs2DgH6FK8FEpVKA1D4/5g
         0UF4vD7uZ4gYx3HfOKM4d7alrlPO5XagI76uZbdjwcNXQPYoiiaB2sNNNMgYBMOtAV
         FWvkn+bLhkmWlU8eK+MqVlV2NkgLTZI7xDnxDx7M=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B685608FF;
        Thu,  8 Aug 2019 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244811;
        bh=1iME6ppVp1VoWQYGmbZMKD1rVId64moVHK8NrmaA64o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiqLC4IzjXJn6gtQBKHp9ZyzjF9qFQPmwd6pZlS3//Q6TvGXrXBFLR1Ky0VWNiVVK
         SBf7j4p83EHmM1d3w+/Ch5TtwxpRDe7dRM4gAESYiacLMudKW0RoQddGTh7n7YLoZK
         jwZKJLmsUDMHaXktrpmTFz9/kanOxgz+InB+4SVk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B685608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, mkshah@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH 2/2] drivers: qcom: Add SoC sleep stats driver
Date:   Thu,  8 Aug 2019 11:42:28 +0530
Message-Id: <20190808061228.16573-3-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808061228.16573-1-mkshah@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm Technologies Inc's (QTI) chipsets support SoC level
low power modes. Statistics for SoC sleep stats are produced
by remote processor.

Lets's add a driver to read the shared memory exported by the
remote processor and export to sysfs.

Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/Kconfig           |   9 ++
 drivers/soc/qcom/Makefile          |   1 +
 drivers/soc/qcom/soc_sleep_stats.c | 249 +++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/soc/qcom/soc_sleep_stats.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 880cf0290962..7aac24430e99 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -163,6 +163,15 @@ config QCOM_SMSM
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
 
+config QCOM_SOC_SLEEP_STATS
+	tristate "Qualcomm Technologies Inc. (QTI) SoC sleep stats driver"
+	depends on ARCH_QCOM
+	help
+	  Qualcomm Technologies Inc. (QTI) SoC sleep stats driver to read
+	  the shared memory exported by the remote processor related to
+	  various SoC level low power modes statistics and export to sysfs
+	  interface.
+
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ffe519b0cb66..1530e0e73075 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
+obj-$(CONFIG_QCOM_SOC_SLEEP_STATS)	+= soc_sleep_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc_sleep_stats.c
new file mode 100644
index 000000000000..5b95d68512ec
--- /dev/null
+++ b/drivers/soc/qcom/soc_sleep_stats.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2011-2019, The Linux Foundation. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#define ARCH_TIMER_FREQ	19200000
+
+struct stats_config {
+	u32 offset_addr;
+	u32 num_records;
+	bool appended_stats_avail;
+};
+
+struct soc_sleep_stats_data {
+	phys_addr_t stats_base;
+	resource_size_t stats_size;
+	const struct stats_config *config;
+	struct kobject *kobj;
+	struct kobj_attribute ka;
+	struct mutex lock;
+};
+
+struct entry {
+	__le32 stat_type;
+	__le32 count;
+	__le64 last_entered_at;
+	__le64 last_exited_at;
+	__le64 accumulated;
+};
+
+struct appended_entry {
+	__le32 client_votes;
+	__le32 reserved[3];
+};
+
+struct stats_entry {
+	struct entry entry;
+	struct appended_entry appended_entry;
+};
+
+static inline u64 get_time_in_sec(u64 counter)
+{
+	do_div(counter, ARCH_TIMER_FREQ);
+
+	return counter;
+}
+
+static inline ssize_t append_data_to_buf(char *buf, int length,
+					 struct stats_entry *data)
+{
+	char stat_type[5] = {0};
+
+	memcpy(stat_type, &data->entry.stat_type, sizeof(u32));
+
+	return scnprintf(buf, length,
+			 "%s\n"
+			 "\tCount                    :%u\n"
+			 "\tLast Entered At(sec)     :%llu\n"
+			 "\tLast Exited At(sec)      :%llu\n"
+			 "\tAccumulated Duration(sec):%llu\n"
+			 "\tClient Votes             :0x%x\n\n",
+			 stat_type, data->entry.count,
+			 data->entry.last_entered_at,
+			 data->entry.last_exited_at,
+			 data->entry.accumulated,
+			 data->appended_entry.client_votes);
+}
+
+static ssize_t stats_show(struct kobject *obj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	void __iomem *reg;
+	int i;
+	uint32_t offset;
+	ssize_t length = 0, op_length;
+	struct stats_entry data;
+	struct entry *e = &data.entry;
+	struct appended_entry *ae = &data.appended_entry;
+	struct soc_sleep_stats_data *drv = container_of(attr,
+					   struct soc_sleep_stats_data, ka);
+
+	mutex_lock(&drv->lock);
+	reg = ioremap_nocache(drv->stats_base, drv->stats_size);
+	if (!reg) {
+		pr_err("io remap failed\n");
+		mutex_unlock(&drv->lock);
+		return length;
+	}
+
+	for (i = 0; i < drv->config->num_records; i++) {
+		offset = offsetof(struct entry, stat_type);
+		e->stat_type = le32_to_cpu(readl_relaxed(reg + offset));
+
+		offset = offsetof(struct entry, count);
+		e->count = le32_to_cpu(readl_relaxed(reg + offset));
+
+		offset = offsetof(struct entry, last_entered_at);
+		e->last_entered_at = le64_to_cpu(readq_relaxed(reg + offset));
+
+		offset = offsetof(struct entry, last_exited_at);
+		e->last_exited_at = le64_to_cpu(readq_relaxed(reg + offset));
+
+		offset = offsetof(struct entry, last_exited_at);
+		e->accumulated = le64_to_cpu(readq_relaxed(reg + offset));
+
+		e->last_entered_at = get_time_in_sec(e->last_entered_at);
+		e->last_exited_at = get_time_in_sec(e->last_exited_at);
+		e->accumulated = get_time_in_sec(e->accumulated);
+
+		reg += sizeof(struct entry);
+
+		if (drv->config->appended_stats_avail) {
+			offset = offsetof(struct appended_entry, client_votes);
+			ae->client_votes = le32_to_cpu(readl_relaxed(reg +
+								     offset));
+
+			reg += sizeof(struct appended_entry);
+		} else
+			ae->client_votes = 0;
+
+		op_length = append_data_to_buf(buf + length, PAGE_SIZE - length,
+					       &data);
+		if (op_length >= PAGE_SIZE - length)
+			goto exit;
+
+		length += op_length;
+	}
+exit:
+	iounmap(reg);
+	mutex_unlock(&drv->lock);
+	return length;
+}
+
+static int soc_sleep_stats_create_sysfs(struct platform_device *pdev,
+					struct soc_sleep_stats_data *drv)
+{
+	int ret = -ENOMEM;
+
+	drv->kobj = kobject_create_and_add("soc_sleep", power_kobj);
+	if (!drv->kobj)
+		goto fail;
+
+	sysfs_attr_init(drv->ka.attr);
+	drv->ka.attr.mode = 0444;
+	drv->ka.attr.name = "stats";
+	drv->ka.show = stats_show;
+
+	ret = sysfs_create_file(drv->kobj, &drv->ka.attr);
+	if (ret)
+		goto fail;
+
+	platform_set_drvdata(pdev, drv);
+fail:
+	return ret;
+}
+
+static const struct stats_config rpm_data = {
+	.offset_addr = 0x14,
+	.num_records = 2,
+	.appended_stats_avail = true,
+};
+
+static const struct stats_config rpmh_data = {
+	.offset_addr = 0x4,
+	.num_records = 3,
+	.appended_stats_avail = false,
+};
+
+static const struct of_device_id soc_sleep_stats_table[] = {
+	{ .compatible = "qcom,rpm-sleep-stats", .data = &rpm_data},
+	{ .compatible = "qcom,rpmh-sleep-stats", .data = &rpmh_data},
+	{ },
+};
+
+static int soc_sleep_stats_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct soc_sleep_stats_data *drv;
+	struct resource *res;
+	void __iomem *offset_addr;
+	int ret;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	match = of_match_node(soc_sleep_stats_table, pdev->dev.of_node);
+	if (!match)
+		return -ENODEV;
+
+	drv->config = match->data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return PTR_ERR(res);
+
+	offset_addr = ioremap_nocache(res->start + drv->config->offset_addr,
+				      sizeof(u32));
+	if (IS_ERR(offset_addr))
+		return PTR_ERR(offset_addr);
+
+	drv->stats_base = res->start | readl_relaxed(offset_addr);
+	drv->stats_size = resource_size(res);
+	iounmap(offset_addr);
+	mutex_init(&drv->lock);
+
+	ret = soc_sleep_stats_create_sysfs(pdev, drv);
+	if (ret)
+		pr_info("Failed to create sysfs interface\n");
+
+	return ret;
+}
+
+static int soc_sleep_stats_remove(struct platform_device *pdev)
+{
+	struct soc_sleep_stats_data *drv = platform_get_drvdata(pdev);
+
+	sysfs_remove_file(drv->kobj, &drv->ka.attr);
+	kobject_put(drv->kobj);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver soc_sleep_stats_driver = {
+	.probe = soc_sleep_stats_probe,
+	.remove = soc_sleep_stats_remove,
+	.driver = {
+		.name = "soc_sleep_stats",
+		.of_match_table = soc_sleep_stats_table,
+	},
+};
+module_platform_driver(soc_sleep_stats_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SoC sleep stats driver");
+MODULE_LICENSE("GPL v2");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.


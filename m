Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93DA231EA2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2Mep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 08:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgG2Mep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 08:34:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A4C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 05:34:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so21472251wrs.11
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szQFy2yaWn8ZbUsB4xteXiZK5ADMWhSSjVtaK6zckMM=;
        b=XlzEZQgUEEH3t2YKxNmbKkt6eHfz8hx/jTLJSd4tLYcZEUzUiSZdhNqeqgfAkzb3Ob
         FfZOVGNWOii/SNOq3uUruta4JOXalZ7CASkPConiMgNeXxenepzCWw4fke0rRNqqqB57
         0fGr4ptEXl4BfUOst2QXEH35Z4VbEOJ09sHaXQNZn9enaXkhoCYU2l/UnpbzBXnIju1q
         3Li9yQL/FDKhRptUofPCfPYlXMTKaZqttnRwXJuMOenkAjFJHBpU411QI7KjAoiCggV+
         0fx5quTSQ3fK34ZFt694NJ/fvuJqnhVkN9g1kgNQ9w0T+vLyufy1+MRclDjj7maoN4TR
         9KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szQFy2yaWn8ZbUsB4xteXiZK5ADMWhSSjVtaK6zckMM=;
        b=gwrUsYBAAKtqM6TlY29Uh/qI43ZN71dp3jY7tTTBLcIxQAiFJoS0uA7rKSzX2InUyh
         dxXUkLt3oBnqwPTDgd7vzgxbDd9XRRM07oqaIs7POwnqREvn2/pA0/d6BdMVhU67yaju
         vq9nixFVs7My2arO5DkLT8JFELtTsn5Qg+saBzs1GwDUFUEPxAGrep4XafCezIDTjn7X
         VVqLc9BAHxwpEJHI26H2bnkMFK2TJdfyk1B4400F2J0AAP5rzzxGHOfmDPmBQkNUTM2C
         tQ20jywDUrAZYIx8BniTi1kSLRQ8fcabhklfwg1ICjpXyQNU3rF0og+os7wkvPzxtBJS
         EcCQ==
X-Gm-Message-State: AOAM530ULSrHea1I3tTqEXiFcw0lHfFm8VfYTZ2PcPU1i2d0FiAlJtBC
        d5pvgdG0KykiYhSkOt1T9+G3lulW444=
X-Google-Smtp-Source: ABdhPJzbdAN5jEykd3htSbfo/drI7Zl9EDyG2xsh79oqrNAqaaZvqeNDnHUuvWaaL3eFIZsuAIOtcw==
X-Received: by 2002:adf:9487:: with SMTP id 7mr28418052wrr.133.1596026082651;
        Wed, 29 Jul 2020 05:34:42 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l1sm6177688wrb.12.2020.07.29.05.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 05:34:42 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        akashast@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v2] interconnect: Add bulk API helpers
Date:   Wed, 29 Jul 2020 15:34:39 +0300
Message-Id: <20200729123439.9961-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are drivers which just need to get multiple interconnect paths,
request some predefined amounts of bandwidth and then just toggle the
paths between enabled/disabled state.

The aim of this patch is simplify the above and to allow drivers to put
all the path names and bandwidth data into a single static icc_bulk_data
table and call the icc_bulk_* functions on that table in order to scale
all the interconnect paths in parallel.

Suggested-by: Evan Green <evgreen@chromium.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
* Fix kernel-doc. (Bjorn)
* Do not print EPROBE_DEFER errors. (Bjorn)

v1: https://lore.kernel.org/r/20200528162542.30158-1-georgi.djakov@linaro.org/

 drivers/interconnect/Makefile |   2 +-
 drivers/interconnect/bulk.c   | 117 ++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h  |  22 +++++++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/bulk.c

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 4825c287ca13..d203520b0a56 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_core.o				:= -I$(src)
-icc-core-objs				:= core.o
+icc-core-objs				:= core.o bulk.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
new file mode 100644
index 000000000000..73e2c8d0a412
--- /dev/null
+++ b/drivers/interconnect/bulk.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interconnect-provider.h>
+#include <linux/device.h>
+#include <linux/export.h>
+
+/**
+ * of_icc_bulk_get() - get interconnect paths
+ * @dev: the device requesting the path
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the table with the paths we want to get
+ *
+ * Returns 0 on success or negative errno otherwise.
+ */
+int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
+				 struct icc_bulk_data *paths)
+{
+	int ret, i;
+
+	for (i = 0; i < num_paths; i++) {
+		paths[i].path = of_icc_get(dev, paths[i].name);
+		if (IS_ERR(paths[i].path)) {
+			ret = PTR_ERR(paths[i].path);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "of_icc_get() failed on path %s (%d)\n",
+					paths[i].name, ret);
+			paths[i].path = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	icc_bulk_put(i, paths);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_icc_bulk_get);
+
+/**
+ * icc_bulk_put() - put a list of interconnect paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table with the paths being put
+ */
+void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
+{
+	while (--num_paths >= 0) {
+		icc_put(paths[num_paths].path);
+		paths[num_paths].path = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(icc_bulk_put);
+
+/**
+ * icc_bulk_set() - set bandwidth to a set of paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table containing the paths and bandwidth
+ *
+ * Returns 0 on success or negative errno otherwise.
+ */
+int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < num_paths; i++) {
+		ret = icc_set_bw(paths[i].path, paths[i].avg_bw, paths[i].peak_bw);
+		if (ret) {
+			pr_err("icc_set_bw() failed on path %s (%d)\n", paths[i].name, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_bulk_set_bw);
+
+/**
+ * icc_bulk_enable() - enable a previously disabled set of paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table containing the paths and bandwidth
+ *
+ * Returns 0 on success or negative errno otherwise.
+ */
+int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths)
+{
+	int ret, i;
+
+	for (i = 0; i < num_paths; i++) {
+		ret = icc_enable(paths[i].path);
+		if (ret) {
+			pr_err("icc_enable() failed on path %s (%d)\n", paths[i].name, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	icc_bulk_disable(i, paths);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_bulk_enable);
+
+/**
+ * icc_bulk_disable() - disable a set of interconnect paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table containing the paths and bandwidth
+ */
+void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
+{
+	while (--num_paths >= 0)
+		icc_disable(paths[num_paths].path);
+}
+EXPORT_SYMBOL_GPL(icc_bulk_disable);
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 3a63d98613fc..f2dd2fc8d3cd 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -23,6 +23,28 @@
 struct icc_path;
 struct device;
 
+/**
+ * struct icc_bulk_data - Data used for bulk icc operations.
+ *
+ * @path: reference to the interconnect path (internal use)
+ * @name: the name from the "interconnect-names" DT property
+ * @avg_bw: average bandwidth in icc units
+ * @peak_bw: peak bandwidth in icc units
+ */
+struct icc_bulk_data {
+	struct icc_path	*path;
+	const char *name;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
+				 struct icc_bulk_data *paths);
+void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
+int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
+int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
+void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
+
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
 struct icc_path *icc_get(struct device *dev, const int src_id,

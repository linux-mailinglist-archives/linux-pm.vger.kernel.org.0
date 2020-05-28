Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09E41E675D
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404925AbgE1QZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404897AbgE1QZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 12:25:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B7C08C5C7
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 09:25:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so20259285wrn.11
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upen+1gLdYl5sl1SEbs2cmY9Gfz3t0VKucJOtqijRN8=;
        b=ygUyqtem8IQGxDaFwRWGbuSrFwL2VWgYvj0Hjt6w/jywMj/jyFwQLCAYqYILcjCQb4
         UKlCsN6c9sUWcT/SNrMlFTX1iQDy9rB4vlKrzLOhzP9rVXddezOgMh1bHHSJWa6n/gPi
         z++9p81bJVivDgFmodJUn8IWP7zUgpNwzJ8qLZ604nWA14HD9uMT7ItPU+oE14uxGheD
         RDXy98ZDO6Icic4RNN9LpJjP6OxEZdHOx9n+K72/G4T4kJxtlBHSBfTNPkMi4xbSnCfH
         Jwa/HrV2YewIVhybN/SbwnKxv8NHtdgw4gmDG2aLBdQ9oY/GHUEaoUO9c1CY5eQxpqqu
         uESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upen+1gLdYl5sl1SEbs2cmY9Gfz3t0VKucJOtqijRN8=;
        b=jzmgq4UpaMNkvcO7e962dMuATaseHshZ9aRCS5BexDuqVaGXngWK9tACuqpJIjdYCt
         +l4Aku3+T4ArwcF9TtKtrxHcW0UO+rCFNK7oHzX6rBNr2rwp8Ybf+9e28Mq0FfnLoMey
         rK7xlZ/kFTfK0UTe+/wRlJnOEq5e17i/99BWv0ZweSRs+h0UL2y8seYFazPn+BjWHcVd
         HYBkYCCKVeq6xQk2p/pjib6FmghiCYZZxX0LrXgGyyhynkR+7LyebIcENWRBwnmRxk2T
         VNMX4D7UCQOkWaQ7NSr+j2MWcGhVv5Y2+oKvAd+Br+hFmdromsUkfCbSmicLnDojKoVV
         iURA==
X-Gm-Message-State: AOAM531d4GXwkLwvGiGKRLFlPRaxfEe0qgi95BKZ4j4lHIbTOrpDiCW3
        C9y/maji0O/wl3Ey8dK53RYk8qXjAB/GGw==
X-Google-Smtp-Source: ABdhPJz6dToxV0ZGkU4AscFPjiCysK6RYqbWEXFKx+wGOrhiaHgJvbxmLM/TJpNcaxW/5Zf7NvFI3w==
X-Received: by 2002:adf:93a3:: with SMTP id 32mr4273513wrp.344.1590683144665;
        Thu, 28 May 2020 09:25:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u13sm6357214wrp.53.2020.05.28.09.25.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 09:25:43 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        akashast@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] interconnect: Add bulk API helpers
Date:   Thu, 28 May 2020 19:25:42 +0300
Message-Id: <20200528162542.30158-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
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
 drivers/interconnect/Makefile |   2 +-
 drivers/interconnect/bulk.c   | 119 ++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h  |  22 +++++++
 3 files changed, 142 insertions(+), 1 deletion(-)
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
index 000000000000..9bd418594665
--- /dev/null
+++ b/drivers/interconnect/bulk.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interconnect-provider.h>
+#include <linux/device.h>
+#include <linux/export.h>
+
+/**
+ * of_icc_bulk_get - get interconnect paths
+ * @dev: the device requesting the path
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the table with the paths we want to get
+ *
+ * Returns 0 on success or -EERROR otherwise.
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
+			dev_err(dev, "of_icc_get() failed on path %s (%d)\n",
+				paths[i].name, ret);
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
+ * icc_bulk_put - put a list of interconnect paths
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
+ * icc_bulk_set - set bandwidth to a set of paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table containing the paths and bandwidth
+ *
+ * Returns 0 on success or -EERROR otherwise.
+ */
+int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < num_paths; i++) {
+		ret = icc_set_bw(paths[i].path, paths[i].avg_bw,
+				 paths[i].peak_bw);
+		if (ret) {
+			pr_err("icc_set_bw() failed on path %s (%d)\n",
+			       paths[i].name, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_bulk_set_bw);
+
+/**
+ * icc_bulk_enable - enable a previously disabled set of paths
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the icc_bulk_data table containing the paths and bandwidth
+ *
+ * Returns 0 on success or -EERROR otherwise.
+ */
+int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths)
+{
+	int ret, i;
+
+	for (i = 0; i < num_paths; i++) {
+		ret = icc_enable(paths[i].path);
+		if (ret) {
+			pr_err("icc_enable() failed on path %s (%d)\n",
+			       paths[i].name, ret);
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
+ * icc_bulk_disable - disable a set of interconnect paths
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
index d8c29049f066..7cf022176209 100644
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

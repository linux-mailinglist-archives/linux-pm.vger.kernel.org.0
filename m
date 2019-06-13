Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDE43963
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfFMPNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:13:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35447 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbfFMPNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:13:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so14323299ljh.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzGXjB+KGlEcxHUIsQo7AmMnVkgFM9AD0lQLEt/BIAo=;
        b=ZxZA2GtuR3iHlk8oEqUTtvufwpuN67TEuVqep78QMQ+eGad3VpYKvlN4nQh+G/wiuS
         LcBaEsoe3E5XzZ2mhTknfCSYgJju41TLNSR9fCrOYFFNzuBUXiIqJFW+5nj8uDk8FSNK
         iUfE1ATQyldwO7IRI2gpOgySaImmjmI7Q55qcRy+YuJ425aT83RRCraQI8JbrdvAvDTB
         Iwx6JE5wEXbbYVi9dZbYfYtUgzvVFDM6sMIiwBdHgfrCdD8adGbh/dD6kOV1mU3UuF5z
         rFCJU1u6e1MrrCSpK0NRJwBYoggD7cSQzMk38Zc2vpMh9mMr33fC4OWYvKW6P1J4UWMH
         7x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzGXjB+KGlEcxHUIsQo7AmMnVkgFM9AD0lQLEt/BIAo=;
        b=Rpzk04Zbo6Zh/X3BPaq3u7oefma5LO4TnXy0SfP3ZcPxVsl0eJWcr19lSv+Oiavab3
         e2LuS4oj11KTJWOpena4A0HQHmY4T3FegxXAXTEU3HDr5fSz9S/ij9qedbABZmRNbt97
         NkKaRJQYrq6sXDsQboRzTkx1EkiESXHuxLVwj4BJiQA88JJHBKURWk9Ml6MWaMQhUmlA
         pxRtsUUmlWhwIIG8EKIycNupe+I9ROHjtYNhjZ+NnMHMGEYtCDcYcTCBRER+RUe/kMzH
         M4Q/5NooLd422fqirqUQIyINvnwrBwPe0AbB2tfOGzAkkwYXgbhaxaeuEgMYYnqKmckM
         VnfA==
X-Gm-Message-State: APjAAAVBCSJCKvyujH19PHs6sSgZbpGWbhp3KTA1UMTltAy1C/IDklJT
        SGaVnf2k3GnwvVpWzgfocTqjYcxtFgU=
X-Google-Smtp-Source: APXvYqyYk5KJZbHLEbwbc6WkGVmWsU6p/dKFY2GUCNaeeQl4n6oZS5J/7Ok6MErVgTRtRzHuwVunhA==
X-Received: by 2002:a2e:9e58:: with SMTP id g24mr3911625ljk.1.1560438811844;
        Thu, 13 Jun 2019 08:13:31 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm42923ljj.41.2019.06.13.08.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:13:31 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/5] interconnect: qcom: Add interconnect SMD over SMD driver
Date:   Thu, 13 Jun 2019 18:13:21 +0300
Message-Id: <20190613151323.10850-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613151323.10850-1-georgi.djakov@linaro.org>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle communication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v4:
- Hide the driver from config menu. It will be selected by other driver.
- Add remove() function to zero out the rpm handle.

v3:
- New patch.

 drivers/interconnect/qcom/Kconfig   |  3 ++
 drivers/interconnect/qcom/Makefile  |  2 +
 drivers/interconnect/qcom/smd-rpm.c | 80 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h | 15 ++++++
 4 files changed, 100 insertions(+)
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index d5e70ebc2410..03fd67173494 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -12,3 +12,6 @@ config INTERCONNECT_QCOM_SDM845
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
+
+config INTERCONNECT_QCOM_SMD_RPM
+	tristate
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 1c1cea690f92..a600cf6cc272 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 qnoc-sdm845-objs			:= sdm845.o
+icc-smd-rpm-objs			:= smd-rpm.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
new file mode 100644
index 000000000000..0a8c9547bd29
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPM over SMD communication wrapper for interconnects
+ *
+ * Copyright (C) 2019 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include "smd-rpm.h"
+
+#define RPM_KEY_BW		0x00007762
+
+static struct qcom_smd_rpm *icc_smd_rpm;
+
+struct icc_rpm_smd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+bool qcom_icc_rpm_smd_available(void)
+{
+	if (!icc_smd_rpm)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
+
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+{
+	struct icc_rpm_smd_req req = {
+		.key = cpu_to_le32(RPM_KEY_BW),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(val),
+	};
+
+	return qcom_rpm_smd_write(icc_smd_rpm, ctx, rsc_type, id, &req,
+				  sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
+
+static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
+{
+	icc_smd_rpm = NULL;
+
+	return 0;
+}
+
+static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
+{
+	icc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
+
+	if (!icc_smd_rpm) {
+		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct platform_driver qcom_interconnect_rpm_smd_driver = {
+	.driver = {
+		.name		= "icc_smd_rpm",
+	},
+	.probe = qcom_icc_rpm_smd_probe,
+	.remove = qcom_icc_rpm_smd_remove,
+};
+module_platform_driver(qcom_interconnect_rpm_smd_driver);
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect proxy driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:icc_smd_rpm");
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
new file mode 100644
index 000000000000..ca9d0327b8ac
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
+#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
+#endif

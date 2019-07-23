Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C644171A3A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfGWOXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:23:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37368 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390074AbfGWOXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 10:23:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so41325602ljn.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYU5uExLdvkd3JySXo4ikuWuU9TKWBHt3CrzgnJWCNA=;
        b=dPqki8ih91xsb4gJhR/9Xcf6J/YbqCIpXb1A5GmOjH8xwHK0jukrf0nRMY5ktPDnKW
         a7Zju9SwtVgvgQydRt2flh2dnh345wbQNNbrlNAd+4rmnLxBQT9kMrvxNMJoC6NlEzOH
         nHNWb7PdQ8PHp2NodheRMTJEsfNwKzooTXfUG0r1l2rtIk86/B88s9644QpxA5D5IXUT
         4w0mc6DsRkH5tkTPsVhWwg0VISWjkwdei6T7ra1S0NRGaJWF8SJoIy2vEaupo6m+MHIM
         43Q90SR/MY5DYD3ttiTelTV2T4pLxz4nwtpXY/hhz4EmkdxlsUaefL1+f6ye0hj6idZg
         ifFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYU5uExLdvkd3JySXo4ikuWuU9TKWBHt3CrzgnJWCNA=;
        b=lfNJlxdJIPJZ9Nefq81wPxg/DSAz6RPer99zjbWQj79pMkZiiIk+/0UNqgzpLcIUqN
         dZ5HdHgZOoGlw/dRupHQrV6Ef1Imy2T+xtY76U5a/Ap4ZaIa56XIcavyiTLtnrplB5Ff
         uYPn/vy1lZ1qaKCw0xeGKjsKqy7BDwAACHwPkI+8XUmgBqt3y09ImlE6Gs42qSjOWZ/0
         9/Ixg6n8z0tCog3Ax77kLXDgfuB1eIeEza+Kl3hTyh90a/TMitxLx8IhBpdgs+k5Q9PG
         argDC1b3gDTQgJV5RVDtFP4KUVYAy/gn0qeqy/JSv+rG9UpUF9DJToajMr3MrEIrf19y
         0T6Q==
X-Gm-Message-State: APjAAAVAlp0CEo8rvc4Vj9eE575X+bxIOrcByQN0PGQLcQZruxrR4zj8
        6FrR5yeG/rUCJ54DhP2DACqsDA==
X-Google-Smtp-Source: APXvYqzQKMVJc6bZ4dymBIQWNd+dKbCefWlmWeLQmo6McVg2bKKvZjqnlYARDSeEQjKF3QbDSDFOtQ==
X-Received: by 2002:a2e:9858:: with SMTP id e24mr16411197ljj.91.1563891828744;
        Tue, 23 Jul 2019 07:23:48 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z17sm8048519ljc.37.2019.07.23.07.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jul 2019 07:23:48 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 3/5] interconnect: qcom: Add interconnect SMD over SMD driver
Date:   Tue, 23 Jul 2019 17:23:37 +0300
Message-Id: <20190723142339.27772-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723142339.27772-1-georgi.djakov@linaro.org>
References: <20190723142339.27772-1-georgi.djakov@linaro.org>
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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v5:
- Use the more succinct return !!icc_smd_rpm;
- Picked Bjorn's r-b.

v4:
- Hide the driver from config menu. It will be selected by other driver.
- Add remove() function to zero out the rpm handle.

v3:
- New patch.

 drivers/interconnect/qcom/Kconfig   |  3 ++
 drivers/interconnect/qcom/Makefile  |  2 +
 drivers/interconnect/qcom/smd-rpm.c | 77 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h | 15 ++++++
 4 files changed, 97 insertions(+)
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
index 000000000000..dc8ff8d133a9
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,77 @@
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
+	return !!icc_smd_rpm;
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

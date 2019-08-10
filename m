Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13578876B
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHJA6x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:58:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34518 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJA6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:58:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id q4so439995qtp.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IF9ScQESeKBDqqyLJCPFsIZb4YaXurMAPhBQcn8rBE=;
        b=ZU4jIzkezf53nUo8Z/wR2/OcpsWPiOjSJlCPYQ4MJOmc5/khwGT/LW6V1gyUOWrxim
         KGQxMxFSJ8XnVxDMrmIfXHBMbs+HE1P9YQjUvsTZGeA0DEPctyu0G5OylkXLDKgnPytY
         zYN8Qv4RN5qyWsH/KeHcwCY6RMlARbG8m8snj1IWwRcWCi0MVSSKllr1QeCOIapZh0tF
         0ShEoEg2AvKS55liT4RhW9xavx655e4X2zznX/JE8TgDn/vtTTs93YPMfChxiYySH1Zg
         13gyWSv/F19+GTFfY+Xy9n5Dnd166SCa2XFhcHTbvksTaHV+ELC4p7ZI30vbYS+NPQp9
         U38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IF9ScQESeKBDqqyLJCPFsIZb4YaXurMAPhBQcn8rBE=;
        b=qk/RAfeWuJu4LmdJ5jKqO6J6B/nU8JZigNT1MlCX5j9Fi1aOXFhmQY1uzbNuKC2XiV
         5i7C88I0e796/xEo1qGq1oyIIVJYy10h5R+kOFD35Iou7QC1EJ6MTl5w1N0Gpl6wKobo
         bjrh77RkPBPDrM3bMzad6KTdRJoS388n+G22r3AhynCff1GRZCZUOT6zpBpUOgd0P2cJ
         JATBgDeyfuqVj+Urw8n645WV/AaxeZUCkK2p0pKKUPsI1unj2ioR8Czd6TcXb0cA5tKh
         Q1zXr3BNGLfqMw0MKROkBPaI3LIwh4/lhUHsmNBkJBnDEvKG0rHqHHxJjXHbNfdCTTiE
         6XDg==
X-Gm-Message-State: APjAAAWbn9i35/SwkMfUJNr9lhmZWuTDxCmNWsl2+UGqaK2qrnZ2ztJQ
        vLu90rdSk+/J1GMdQUA5Q2V4fw==
X-Google-Smtp-Source: APXvYqx+UJmrkdB/nmlwch2AAI+c43LdHJMpDtBClvTyr9cjLcMEiRDvnPJjJZeQdvQ6ti93549PNg==
X-Received: by 2002:ad4:4026:: with SMTP id q6mr5105538qvp.12.1565398732189;
        Fri, 09 Aug 2019 17:58:52 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id t9sm4603105qtr.29.2019.08.09.17.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 17:58:51 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
Subject: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
Date:   Fri,  9 Aug 2019 20:58:46 -0400
Message-Id: <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MX power domain in RPMH can be used to warm the
the SoC in SDM845. To support this feature, introduce
a RPMH power domain cooling device driver that can be
plugged into the thermal framework.(The thermal framework
itself requires further modifiction to support a warming
device in place of a cooling device. Those extensions are
not introduced in this patch series).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/Kconfig            |   7 ++
 drivers/thermal/qcom/Makefile           |   1 +
 drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index aa9c1d8..a540130 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -20,3 +20,10 @@ config QCOM_SPMI_TEMP_ALARM
 	  trip points. The temperature reported by the thermal sensor reflects the
 	  real time die temperature if an ADC is present or an estimate of the
 	  temperature based upon the over temperature stage value.
+
+config CONFIG_QCOM_RPMHPD_CDEV
+	tristate "Qualcomm RPMHPD based cooling device"
+	depends on QCOM_RPMHPD
+	help
+	  This enables RPMHPD based cooling devices. On SDM845, this is
+	  MX power domain.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 7c8dc6e..e4eb520 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o \
 				   tsens-8960.o tsens-v2.o tsens-v1.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
+obj-$(CONFIG_QCOM_RPMHPD_CDEV)		+= qcom-rpmhpd-cdev.o
diff --git a/drivers/thermal/qcom/qcom-rpmhpd-cdev.c b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
new file mode 100644
index 0000000..265523b
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd
+ */
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+
+struct rpmhpd_cooling_device {
+	struct thermal_cooling_device *cdev;
+	struct device *pwr_domain;
+	int max_state;
+	int cur_state;
+	bool is_pwr_domain_on;
+};
+
+static const char sdm845_rpmhpd_cdev_name[] = "mx";
+
+static const struct of_device_id rpmhpd_cdev_match_table[] = {
+	{ .compatible = "qcom,sdm845-rpmhpd-cdev", .data = &sdm845_rpmhpd_cdev_name },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmhpd_cdev_match_table);
+
+static int rpmhpd_cdev_get_max_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
+
+	*state = rpmhpd_cdev->max_state;
+	return 0;
+}
+
+static int rpmhpd_cdev_get_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
+	int perf_state;
+
+	dev_pm_genpd_get_performance_state(rpmhpd_cdev->pwr_domain,
+					   &perf_state);
+	*state = perf_state;
+	return 0;
+}
+
+static int rpmhpd_cdev_set_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long state)
+{
+	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
+	struct device *pwr_domain = rpmhpd_cdev->pwr_domain;
+	int ret;
+
+	ret = dev_pm_genpd_set_performance_state(pwr_domain, state);
+
+	if (ret)
+		return ret;
+
+	if (state && !rpmhpd_cdev->is_pwr_domain_on) {
+		ret = pm_runtime_get_sync(pwr_domain);
+		rpmhpd_cdev->is_pwr_domain_on = true;
+	} else if (!state && rpmhpd_cdev->is_pwr_domain_on) {
+		ret = pm_runtime_put(pwr_domain);
+		rpmhpd_cdev->is_pwr_domain_on = false;
+	}
+
+	return ret;
+}
+
+static struct thermal_cooling_device_ops rpmhpd_cooling_device_ops = {
+	.get_max_state = rpmhpd_cdev_get_max_state,
+	.get_cur_state = rpmhpd_cdev_get_cur_state,
+	.set_cur_state = rpmhpd_cdev_set_cur_state,
+};
+
+static int rpmhpd_cdev_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev, *pd_dev;
+	struct rpmhpd_cooling_device *rpmhpd_cdev;
+	const char *rpmhpd_cdev_name = of_device_get_match_data(dev);
+	unsigned int count;
+	int ret;
+
+	if (!dev->pm_domain) {
+		pd_dev = dev_pm_domain_attach_by_name(dev, rpmhpd_cdev_name);
+		if (IS_ERR(pd_dev))
+			return PTR_ERR(pd_dev);
+	} else {
+		pd_dev = dev;
+	}
+
+	rpmhpd_cdev = devm_kzalloc(dev, sizeof(*rpmhpd_cdev), GFP_KERNEL);
+	if (!rpmhpd_cdev) {
+		ret = -ENOMEM;
+		goto detach_pd;
+	}
+
+	ret = dev_pm_genpd_performance_state_count(pd_dev, &count);
+	if (ret)
+		goto detach_pd;
+
+	rpmhpd_cdev->pwr_domain = pd_dev;
+	rpmhpd_cdev->max_state = count - 1;
+	rpmhpd_cdev->is_pwr_domain_on = false;
+
+	pm_runtime_enable(pd_dev);
+
+	rpmhpd_cdev->cdev = thermal_of_cooling_device_register
+					(dev->of_node, rpmhpd_cdev_name,
+					 rpmhpd_cdev,
+					 &rpmhpd_cooling_device_ops);
+	if (IS_ERR(rpmhpd_cdev->cdev)) {
+		dev_err(dev, "unable to register %s cooling device\n",
+			rpmhpd_cdev_name);
+		ret = PTR_ERR(rpmhpd_cdev->cdev);
+		goto detach_pd;
+	}
+
+	return 0;
+
+detach_pd:
+	dev_pm_domain_detach(pd_dev, false);
+	return ret;
+}
+
+static struct platform_driver rpmhpd_cdev_driver = {
+	.driver = {
+		.name = "qcom-rpmhpd-cdev",
+		.of_match_table = rpmhpd_cdev_match_table,
+	},
+	.probe = rpmhpd_cdev_probe,
+};
+module_platform_driver(rpmhpd_cdev_driver);
+
+MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88B6AF043
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437039AbfIJROp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 13:14:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41562 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437022AbfIJROo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 13:14:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id j10so21598411qtp.8
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9F/vvtUdvbyD33UWlhzTxkuCa0DWaFmi4SY1XMgTAuU=;
        b=Gjln9GbM9nOOKTQSIjPm1CBoOEzG7NkuB+2lclA+7WWh/VkMsZYI/bKvD7rTE1SFvD
         ALgaaqvNXJv/Xs5Gsf38fEEA9nTD8Nhv+SIoUZg9ybNDKIbwJIUtA3xZh46E0GXp3x5b
         Homia22HCO/9NR9Dl1RqQOasekzh2zUH9G6YoP6ydTXU3WsJhoEJcs2G/mxxVWVyCDcZ
         8YcTdb+RP1T9W45TqfYxF3SQGZotGlODA3b9JL7/scUQYvuE1jhHl7L+eiAcAFFhU2WH
         +W5/ph9mYomGBeW0c/EDzd3liwRoHle3Pvxb6NVYknmirH3EQscqTzeCGFdmP0906FSm
         0v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9F/vvtUdvbyD33UWlhzTxkuCa0DWaFmi4SY1XMgTAuU=;
        b=mkuUfI4j3yz7h9ZItKauHcFNBF+6/da/4zRAeZgId6ROe5CoIyqJ4gGSL7kjPM6lma
         K4WmJ6+Yz+T0iWytNPlftphtDb4mrAI6sAO33Xo75dGBPnqzlrhZSPaDtnaKQO1SFFuf
         5LzpA5T5L8bbl1ic6lopDHppPTfmeD3leMiI4IFsHWtKTCSa7gaSffQO8KABADzUKZq5
         8B+4sCZ/qibs4kNWdGmLoRkM0t8CHvbDv0H9DgHX5IMsFZgUozi0NkeEv49qO6fCIAPP
         1ShlMr7wLFcXbwXUbauzWpFjDKvMDkEVPn5xv6X+wI80uRjRp/o+WzROVatNLcy8Z6cF
         Wyww==
X-Gm-Message-State: APjAAAVxhrVw0Kt/DYJscrjRXePTybj9eVedwzwJ4MPuC91/DRT9+XLN
        3keyp45N0cmPsfATkV7C97ePSA==
X-Google-Smtp-Source: APXvYqwDgmmlp0YEL9py9MK3LV2mk/9QIqB/9jPn58f5P0VKtYmXKFbQKbMvZkm+ndcDP9DiQR6kiA==
X-Received: by 2002:a0c:db94:: with SMTP id m20mr18626455qvk.142.1568135683409;
        Tue, 10 Sep 2019 10:14:43 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:42 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] thermal: Add generic power domain warming device driver.
Date:   Tue, 10 Sep 2019 13:14:35 -0400
Message-Id: <1568135676-9328-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resources modeled as power domains in linux kenrel
can  be used to warm the SoC(eg. mx power domain on sdm845).
To support this feature, introduce a generic power domain
warming device driver that can be plugged into the thermal framework
(The thermal framework itself requires further modifiction to
support a warming device in place of a cooling device.
Those extensions are not introduced in this patch series).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v1->v2:
	- Make power domain based warming device driver a generic
	driver in the thermal framework. v1 implemented this as a
	Qualcomm specific driver.
	- Rename certain variables as per review suggestions on the
	mailing list.

 drivers/thermal/Kconfig              |  11 +++
 drivers/thermal/Makefile             |   2 +
 drivers/thermal/pwr_domain_warming.c | 174 +++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/thermal/pwr_domain_warming.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9966364..eeb6018 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -187,6 +187,17 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PWR_DOMAIN_WARMING_THERMAL
+	bool "Power Domain based warming device"
+	depends on PM_GENERIC_DOMAINS
+	depends on PM_GENERIC_DOMAINS_OF
+	help
+	  This implements the generic power domain based warming
+	  mechanism through increasing the performance state of
+	  a power domain.
+
+	  If you want this support, you should say Y here.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74a37c7..382c64a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)	+= pwr_domain_warming.o
+
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
new file mode 100644
index 0000000..3dd792b
--- /dev/null
+++ b/drivers/thermal/pwr_domain_warming.c
@@ -0,0 +1,174 @@
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
+struct pd_warming_device {
+	struct thermal_cooling_device *cdev;
+	struct device *dev;
+	int max_state;
+	int cur_state;
+	bool runtime_resumed;
+};
+
+static const struct of_device_id pd_wdev_match_table[] = {
+	{ .compatible = "thermal-power-domain-wdev", .data = NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pd_wdev_match_table);
+
+static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+
+	*state = pd_wdev->max_state;
+	return 0;
+}
+
+static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+
+	*state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
+
+	return 0;
+}
+
+static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = pd_wdev->dev;
+	int ret;
+
+	ret = dev_pm_genpd_set_performance_state(dev, state);
+
+	if (ret)
+		return ret;
+
+	if (state && !pd_wdev->runtime_resumed) {
+		ret = pm_runtime_get_sync(dev);
+		pd_wdev->runtime_resumed = true;
+	} else if (!state && pd_wdev->runtime_resumed) {
+		ret = pm_runtime_put(dev);
+		pd_wdev->runtime_resumed = false;
+	}
+
+	return ret;
+}
+
+static struct thermal_cooling_device_ops pd_warming_device_ops = {
+	.get_max_state = pd_wdev_get_max_state,
+	.get_cur_state = pd_wdev_get_cur_state,
+	.set_cur_state = pd_wdev_set_cur_state,
+};
+
+static int pd_wdev_create(struct device *dev, const char *name)
+{
+	struct pd_warming_device *pd_wdev;
+	int state_count;
+
+	pd_wdev = devm_kzalloc(dev, sizeof(*pd_wdev), GFP_KERNEL);
+	if (!pd_wdev)
+		return -ENOMEM;
+
+	state_count = dev_pm_genpd_performance_state_count(dev);
+	if (state_count < 0)
+		return state_count;
+
+	pd_wdev->dev = dev;
+	pd_wdev->max_state = state_count - 1;
+	pd_wdev->runtime_resumed = false;
+
+	pm_runtime_enable(dev);
+
+	pd_wdev->cdev = thermal_of_cooling_device_register
+					(dev->of_node, name,
+					 pd_wdev,
+					 &pd_warming_device_ops);
+	if (IS_ERR(pd_wdev->cdev)) {
+		dev_err(dev, "unable to register %s cooling device\n", name);
+		pm_runtime_disable(dev);
+
+		return PTR_ERR(pd_wdev->cdev);
+	}
+
+	return 0;
+}
+
+static int pd_wdev_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev, *pd_dev;
+	const char *pd_name;
+	int id, count, ret = 0;
+
+	count = of_count_phandle_with_args(dev->of_node, "power-domains",
+					   "#power-domain-cells");
+
+	if (count > 1) {
+		for (id = 0; id < count; id++) {
+			ret = of_property_read_string_index
+					(dev->of_node, "power-domain-names",
+					 id, &pd_name);
+			if (ret) {
+				dev_err(dev, "Error reading the power domain name %d\n", ret);
+				continue;
+			}
+
+			pd_dev = dev_pm_domain_attach_by_id(dev, id);
+			if (IS_ERR(pd_dev)) {
+				dev_err(dev, "Error attaching power domain %s %ld\n", pd_name, PTR_ERR(pd_dev));
+				continue;
+			}
+
+			ret = pd_wdev_create(pd_dev, pd_name);
+			if (ret) {
+				dev_err(dev, "Error building cooling device %s %d\n", pd_name, ret);
+				dev_pm_domain_detach(pd_dev, false);
+				continue;
+			}
+		}
+	} else if (count == 1) {
+		ret = of_property_read_string_index(dev->of_node,
+						    "power-domain-names",
+						    0, &pd_name);
+		if (ret) {
+			dev_err(dev, "Error reading the power domain name %d\n", ret);
+			goto exit;
+		}
+
+		ret = pd_wdev_create(dev, pd_name);
+		if (ret) {
+			dev_err(dev, "Error building cooling device %s %d\n", pd_name, ret);
+			goto exit;
+		}
+	} else	{
+		ret = -EINVAL;
+	}
+
+exit:
+	return ret;
+}
+
+static struct platform_driver pd_wdev_driver = {
+	.driver = {
+		.name = "qcom-rpmhpd-cdev",
+		.of_match_table = pd_wdev_match_table,
+	},
+	.probe = pd_wdev_probe,
+};
+module_platform_driver(pd_wdev_driver);
+
+MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4


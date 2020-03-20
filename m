Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5918C4E0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCTBmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:42:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34512 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgCTBlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so3738690qtp.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+q0Whneakoia71PzXBgxmZbnd+3OHmL7DK4XuhtZbsg=;
        b=pdylMiGCq/devMh7m0Gj/CfkrdfdovRUED2arwHY3YZmdpuvoVo3Av7s+j6jPkG+86
         giK4uCy+sHNGWyauJenzGi+z3wGZuAJ8bcKNnnQoJaclnCHVJIaMwGITOZBlWreZunkV
         6Pwe6IkgjqlmEI/oy3VNeWVWWmF13j3Pu1fg7UqHLcM7/tu3pkFvJRFX04E9hSh9ndGP
         Huls/g/UqdMz9EVRmzY51A+1AFhjsJ6HvCCXfHx8Y+Nky5il561TTptdGjt7CeNCM/Bc
         Zv+EOnCfsGEOYxgEht3LDDBdHzZU6a31d6ChNYnfTp9zFedJb+nrl7SG3LTXVdPBQHJK
         L0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+q0Whneakoia71PzXBgxmZbnd+3OHmL7DK4XuhtZbsg=;
        b=jsequ0QOT+Vlcyv348g4kazrSUCKny0BP4kZxd8+R8QMtEtLakKWPJmw5JFLGufVVV
         QlgbvKVAHGOXNgrsDIEgdFfitZwz5136qOJ6MqsDsBbOblDEdPi9bkzCjC/tJ8v6GPI9
         0XU54P1jrNv2v9bccxB1ROJFO+kmZcyBCd2UbthJ9oM64Y4/a30EKFQtVhPX2WH+JXch
         cghHYtYu7+e4EZNiR0Ood/H+1UIjDwX7euf80bMKmPmhF7zSlxAxVpzr3gdKuEarnw8Y
         TIaMq/fFZ+iB1fCsDyyyXeC3g0z4PglG1EZUCm2GDycmK3CTimypqkx969d9iofQjVEv
         1mkA==
X-Gm-Message-State: ANhLgQ1gGragW1uzDWevqDAES6ud0xy68rlThi0CG0aDczF+DSqCmAFL
        Lblue6g2oCN0929ZvfNslQxeFw==
X-Google-Smtp-Source: ADFU+vvV3I4YxVq1xAymPLnOWFCy9dHEri/NXuJUV5hlLXACtlePaJg5MOBUPU7k00uY22SlISNjIQ==
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr5859372qtk.171.1584668473741;
        Thu, 19 Mar 2020 18:41:13 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:13 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 3/6] thermal: Add generic power domain warming device driver.
Date:   Thu, 19 Mar 2020 21:41:04 -0400
Message-Id: <20200320014107.26087-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320014107.26087-1-thara.gopinath@linaro.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resources modeled as power domains in linux kernel can  be used to warm the
SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
generic power domain warming device driver that can be plugged into the
thermal framework (The thermal framework itself requires further
modifiction to support a warming device in place of a cooling device.
Those extensions are not introduced in this patch series).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
	- Removed late_init hook pd_warming_device_ops.
	- Use of_genpd_add_device instead of pm_genpd_add_device to attach
	  device to the generic power domain.
	- Use thermal_of_cooling_device_parent_register to register the
	  cooling device so that the device with genpd attached can be
	  made parent of the cooling device.
	- With above changes, remove reference to generic_pm_domain in
	  pd_warming_device.

v4->v5:
	- All the below changes are as per Ulf's review comments.
	- Renamed pwr_domain_warming.c and pwr_domain_warming.h to
	  pd_warming.c and pd_warming.h.
	- Renamed pwr_domain_warming_register API to 
	  of_pd_warming_register.
	- Dropped in-param pd_name to of_pd_warming_register.
	- Introduced ID allocator to uniquely identify each power domain
	  warming device.
	- Introduced pd_warming_release to handle device kfree for
	  pd_warming_device.
	- Introduced pm_genpd_remove_device in the error exit path
	  of of_pd_warming_register.

 drivers/thermal/Kconfig      |  10 +++
 drivers/thermal/Makefile     |   2 +
 drivers/thermal/pd_warming.c | 168 +++++++++++++++++++++++++++++++++++
 include/linux/pd_warming.h   |  29 ++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/thermal/pd_warming.c
 create mode 100644 include/linux/pd_warming.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4d6753f2b18f..92522d541d0e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -206,6 +206,16 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PWR_DOMAIN_WARMING_THERMAL
+	bool "Power Domain based warming device"
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
index 8c8ed7b79915..7db87a779126 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -28,6 +28,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)	+= pd_warming.o
+
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
diff --git a/drivers/thermal/pd_warming.c b/drivers/thermal/pd_warming.c
new file mode 100644
index 000000000000..c0854d2e4b92
--- /dev/null
+++ b/drivers/thermal/pd_warming.c
@@ -0,0 +1,168 @@
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
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/pd_warming.h>
+
+struct pd_warming_device {
+	struct thermal_cooling_device *cdev;
+	struct device dev;
+	int id;
+	int max_state;
+	int cur_state;
+	bool runtime_resumed;
+};
+
+static DEFINE_IDA(pd_ida);
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
+	*state = dev_pm_genpd_get_performance_state(&pd_wdev->dev);
+
+	return 0;
+}
+
+static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = &pd_wdev->dev;
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
+	.get_max_state	= pd_wdev_get_max_state,
+	.get_cur_state	= pd_wdev_get_cur_state,
+	.set_cur_state	= pd_wdev_set_cur_state,
+};
+
+static void pd_warming_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct thermal_cooling_device *
+of_pd_warming_register(struct device *parent, int pd_id)
+{
+	struct pd_warming_device *pd_wdev;
+	struct of_phandle_args pd_args;
+	char cdev_name[THERMAL_NAME_LENGTH];
+	int ret;
+
+	pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
+	if (!pd_wdev)
+		return ERR_PTR(-ENOMEM);
+
+	dev_set_name(&pd_wdev->dev, "%s_%d_warming_dev",
+		     dev_name(parent), pd_id);
+	pd_wdev->dev.parent = parent;
+	pd_wdev->dev.release = pd_warming_release;
+
+	ret = device_register(&pd_wdev->dev);
+	if (ret) {
+		put_device(&pd_wdev->dev);
+		goto free_pd_wdev;
+	}
+
+	ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto unregister_device;
+
+	pd_wdev->id = ret;
+
+	pd_args.np = parent->of_node;
+	pd_args.args[0] = pd_id;
+	pd_args.args_count = 1;
+
+	ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
+
+	if (ret)
+		goto remove_ida;
+
+	ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
+	if (ret < 0)
+		goto out_genpd;
+
+	pd_wdev->max_state = ret - 1;
+	pm_runtime_enable(&pd_wdev->dev);
+	pd_wdev->runtime_resumed = false;
+
+	snprintf(cdev_name, sizeof(cdev_name), "thermal-pd-%d", pd_wdev->id);
+	pd_wdev->cdev = thermal_of_cooling_device_register
+					(NULL, cdev_name, pd_wdev,
+					 &pd_warming_device_ops);
+	if (IS_ERR(pd_wdev->cdev)) {
+		pr_err("unable to register %s cooling device\n", cdev_name);
+		ret = PTR_ERR(pd_wdev->cdev);
+		goto out_runtime_disable;
+	}
+
+	return pd_wdev->cdev;
+
+out_runtime_disable:
+	pm_runtime_disable(&pd_wdev->dev);
+out_genpd:
+	pm_genpd_remove_device(&pd_wdev->dev);
+remove_ida:
+	ida_simple_remove(&pd_ida, pd_wdev->id);
+unregister_device:
+	device_unregister(&pd_wdev->dev);
+	pd_warming_release(&pd_wdev->dev);
+free_pd_wdev:
+	kfree(pd_wdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(of_pd_warming_register);
+
+void pd_warming_unregister(struct thermal_cooling_device *cdev)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = &pd_wdev->dev;
+
+	if (pd_wdev->runtime_resumed) {
+		dev_pm_genpd_set_performance_state(dev, 0);
+		pm_runtime_put(dev);
+		pd_wdev->runtime_resumed = false;
+	}
+	pm_runtime_disable(dev);
+	pm_genpd_remove_device(dev);
+	ida_simple_remove(&pd_ida, pd_wdev->id);
+	thermal_cooling_device_unregister(cdev);
+	kfree(pd_wdev);
+}
+EXPORT_SYMBOL_GPL(pd_warming_unregister);
diff --git a/include/linux/pd_warming.h b/include/linux/pd_warming.h
new file mode 100644
index 000000000000..550a5683b56d
--- /dev/null
+++ b/include/linux/pd_warming.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ */
+#ifndef __PWR_DOMAIN_WARMING_H__
+#define __PWR_DOMAIN_WARMING_H__
+
+#include <linux/pm_domain.h>
+#include <linux/thermal.h>
+
+#ifdef CONFIG_PWR_DOMAIN_WARMING_THERMAL
+struct thermal_cooling_device *
+of_pd_warming_register(struct device *parent, int pd_id);
+
+void pd_warming_unregister(struct thermal_cooling_device *cdev);
+
+#else
+static inline struct thermal_cooling_device *
+of_pd_warming_register(struct device *parent, int pd_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void
+pd_warming_unregister(struct thermal_cooling_device *cdev)
+{
+}
+#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
+#endif /* __PWR_DOMAIN_WARMING_H__ */
-- 
2.20.1


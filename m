Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6481EDAE3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 03:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFDBxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgFDBxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 21:53:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DBC08C5C2
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 18:53:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u17so3980496qtq.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zVKcLTPmnGwe40Y367QYIcZACR6WrRrYV644jQUiEs=;
        b=wWp6CJTqDOyoFiDlZn1RLWo8Hmy/EWuTSribqdOwk5CHkQFGicLYbtiYIQm7t8I4le
         NOl2bkCeWBwACjo4HVqTt84VS6fc7Wc2rEeC6ecL3qnnWqwgXOqt2tdnjMRnKIMcT/vw
         eWAtV/7ViPZqHAiQEOWlrLnX2STnNR8nElsEHk46SfWRfwkb/2rxFkvb1nfdWi6IFBoO
         q3ydaxZqnD6beBnYQPDoWREQLRaVTVWO9fOmu1T+w/g32pI50Hgh3FarYsrGxrJ5cwZJ
         NgIi3WCFwXD9nZl85/64TMJMnJ4PqHj53uYKV/C5v5oVnidr/s6KWZv9vHKMDQaGl/Bq
         Azbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zVKcLTPmnGwe40Y367QYIcZACR6WrRrYV644jQUiEs=;
        b=ANQXRdfQ7Kq/SE1OLkOJtPioit5S1uDBEWg0ik6/2ViwAiMI+/v8MNm8jpRylfqxAo
         4vUGvgFpxy9XzpUNLwYdPGnAZZv27Dbks0gJTouuKkEEpCAIKQEdTNbgvfkb9Kx7APyb
         9iJiWcRk3rXvbIzR9MF3UkytvL86btT+u6e/VwXPvqm6jfR+CoF+XtPCI/yq/G1Kt1pM
         B4evvEhsSvtJ4C7K93p+jxmkA3S5mDDFsey8yWOhJWJqXl9kn3N4HkKRpr5hQp9kzPTk
         2Ot/ACE/320RIClFeY/3DjZLQAkEv3U6SYvSKrKC1BwHWQH6k38y6l/4XeLkql60kmDV
         55jg==
X-Gm-Message-State: AOAM532lZcvT4DPAzvetByGg5dMsNle7nBQ3NrSOEWbbrscrfYB7s+Zh
        8LSJ6QlBYwZ1kDOevqimC+EM9g==
X-Google-Smtp-Source: ABdhPJx3QMOwNKw/vg6Qo4Do37BesTxVwG1EFm8RXWKL64cET36kH8f3if6rvKhrSBWCgRScsulADw==
X-Received: by 2002:ac8:42c3:: with SMTP id g3mr2208401qtm.313.1591235603690;
        Wed, 03 Jun 2020 18:53:23 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:23 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] thermal: Add generic power domain warming device driver.
Date:   Wed,  3 Jun 2020 21:53:14 -0400
Message-Id: <20200604015317.31389-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
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
v5->v6:
	- Fixed issues with ->release() and kfree(dev) as pointed
	  out by Ulf.

 drivers/thermal/Kconfig      |  10 +++
 drivers/thermal/Makefile     |   4 +
 drivers/thermal/pd_warming.c | 169 +++++++++++++++++++++++++++++++++++
 include/linux/pd_warming.h   |  29 ++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/thermal/pd_warming.c
 create mode 100644 include/linux/pd_warming.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e53314ea9e25..3a0bcf3e8bd9 100644
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
index 86c506410cc0..14fa696a08bd 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -28,7 +28,11 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+#pwr domain warming
+thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)	+= pd_warming.o
+
 obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
+
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
diff --git a/drivers/thermal/pd_warming.c b/drivers/thermal/pd_warming.c
new file mode 100644
index 000000000000..1ea93481c79b
--- /dev/null
+++ b/drivers/thermal/pd_warming.c
@@ -0,0 +1,169 @@
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
+	struct pd_warming_device *pd_wdev;
+
+	pd_wdev = container_of(dev, struct pd_warming_device, dev);
+	kfree(pd_wdev);
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
+		goto out;
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
+out:
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
+	device_unregister(dev);
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


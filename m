Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B895169207
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBVWEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 17:04:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgBVWEv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2020 17:04:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so5323469wmh.3;
        Sat, 22 Feb 2020 14:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhQUUlUjVhHr6sphTHHa2ksMN9UV4WLzzCRFzZrdNOk=;
        b=hqTZR+1ILk5FVqauJCy6rjaxmiYbw2I5CisYse+baC5mgxwAUTLVT00YGw40xnpxfX
         PzoKuox+EiEU2naOkj7PNfL3yhEs6Gquq9wzNKG8gCGtwHoxNlzIw178jrISjOCHACwU
         4aTnnk9+RnBkwY8nxyU1nkIAQ8l0Jq8jM+kyS96s3PtNqZSyac6fkyEjf5XHIK44sCK2
         4bHKWjBQbH7Ii83fjMRpV876RY1RKQwYjRzOt1gjkZXYqG64dBICBZnwM7LwDIEMqGIO
         0xlIGnj+5SlS3KcWA3Z3XrJSF2pjGaUdnmd/fUEntGoF0OkaC+Obk2MYbDzfRIMMUYd9
         vTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhQUUlUjVhHr6sphTHHa2ksMN9UV4WLzzCRFzZrdNOk=;
        b=MAPl+AvJBi0svZLnNC+pbOB8XpHtc5zs/+RhSlMwsunWmAmRZXF8ZPLaeRxdunxPpI
         rnmCyhRhu5l5cvk0r4YMwcp7hneelc3uDGs3C5xI8UkEJzI4BHq6MZcy9iKHozwf2wSp
         R1rZ4uisgexFVMgRib2vKOvc9G7LEMBhxhhj2PsPoySfGzB/4F18g+xNk4ZTtLHhHVNK
         bBAidNQ4IrNAsAgIC4eTy6DGw+uhzbgTgAiu7tamtUb4b29q/lfzo77Z1HY7uDp+veVQ
         aEun//xl0gFjeXNf7xPNEPVOq6kQjkA+FH92EFfS7D8E0a0yCwdfED2Ts64lU1dsz/kb
         H9OQ==
X-Gm-Message-State: APjAAAXn0NOqPKt6KMVaugdGzeDn7MWOXODgWzC88T0JRIgzK1D4qUg/
        X54t1WIaDSFR5NYWSJhhiEo=
X-Google-Smtp-Source: APXvYqwQ8u99yRx/WtTy3S7i93YkO3dPik8SKciWy6GxI5oagbMDni7PyYQJoLBYnAqPcQKllZtyJQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr12000734wmk.172.1582409087753;
        Sat, 22 Feb 2020 14:04:47 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q130sm11151738wme.19.2020.02.22.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:04:47 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        linux-pm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v3 2/2] drm/lima: Add optional devfreq and cooling device support
Date:   Sat, 22 Feb 2020 23:04:32 +0100
Message-Id: <20200222220432.448115-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200222220432.448115-1-martin.blumenstingl@googlemail.com>
References: <20200222220432.448115-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most platforms with a Mali-400 or Mali-450 GPU also have support for
changing the GPU clock frequency. Add devfreq support so the GPU clock
rate is updated based on the actual GPU usage when the
"operating-points-v2" property is present in the board.dts.

The actual devfreq code is taken from panfrost_devfreq.c and modified so
it matches what the lima hardware needs:
- a call to dev_pm_opp_set_clkname() during initialization because there
  are two clocks on Mali-4x0 IPs. "core" is the one that actually clocks
  the GPU so we need to control it using devfreq.
- locking when reading or writing the devfreq statistics because (unlike
  than panfrost) we have multiple PP and GP IRQs which may finish jobs
  concurrently.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/lima/Kconfig        |   1 +
 drivers/gpu/drm/lima/Makefile       |   3 +-
 drivers/gpu/drm/lima/lima_devfreq.c | 215 ++++++++++++++++++++++++++++
 drivers/gpu/drm/lima/lima_devfreq.h |  15 ++
 drivers/gpu/drm/lima/lima_device.c  |   4 +
 drivers/gpu/drm/lima/lima_device.h  |  18 +++
 drivers/gpu/drm/lima/lima_drv.c     |  14 +-
 drivers/gpu/drm/lima/lima_sched.c   |   9 ++
 drivers/gpu/drm/lima/lima_sched.h   |   3 +
 9 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h

diff --git a/drivers/gpu/drm/lima/Kconfig b/drivers/gpu/drm/lima/Kconfig
index d589f09d04d9..09404bc96ad8 100644
--- a/drivers/gpu/drm/lima/Kconfig
+++ b/drivers/gpu/drm/lima/Kconfig
@@ -10,5 +10,6 @@ config DRM_LIMA
        depends on OF
        select DRM_SCHED
        select DRM_GEM_SHMEM_HELPER
+       select PM_DEVFREQ
        help
 	 DRM driver for ARM Mali 400/450 GPUs.
diff --git a/drivers/gpu/drm/lima/Makefile b/drivers/gpu/drm/lima/Makefile
index a85444b0a1d4..5e5c29875e9c 100644
--- a/drivers/gpu/drm/lima/Makefile
+++ b/drivers/gpu/drm/lima/Makefile
@@ -14,6 +14,7 @@ lima-y := \
 	lima_sched.o \
 	lima_ctx.o \
 	lima_dlbu.o \
-	lima_bcast.o
+	lima_bcast.o \
+	lima_devfreq.o
 
 obj-$(CONFIG_DRM_LIMA) += lima.o
diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
new file mode 100644
index 000000000000..3a6b315136ce
--- /dev/null
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *
+ * Based on panfrost_devfreq.c:
+ *   Copyright 2019 Collabora ltd.
+ */
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq_cooling.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/property.h>
+
+#include "lima_device.h"
+#include "lima_devfreq.h"
+
+static void lima_devfreq_update_utilization(struct lima_device *ldev)
+{
+	unsigned long irqflags;
+	ktime_t now, last;
+
+	if (!ldev->devfreq.devfreq)
+		return;
+
+	spin_lock_irqsave(&ldev->devfreq.lock, irqflags);
+
+	now = ktime_get();
+	last = ldev->devfreq.time_last_update;
+
+	if (atomic_read(&ldev->devfreq.busy_count) > 0)
+		ldev->devfreq.busy_time += ktime_sub(now, last);
+	else
+		ldev->devfreq.idle_time += ktime_sub(now, last);
+
+	ldev->devfreq.time_last_update = now;
+
+	spin_unlock_irqrestore(&ldev->devfreq.lock, irqflags);
+}
+
+static int lima_devfreq_target(struct device *dev, unsigned long *freq,
+			       u32 flags)
+{
+	struct dev_pm_opp *opp;
+	int err;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	dev_pm_opp_put(opp);
+
+	err = dev_pm_opp_set_rate(dev, *freq);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void lima_devfreq_reset(struct lima_device *ldev)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ldev->devfreq.lock, irqflags);
+
+	ldev->devfreq.busy_time = 0;
+	ldev->devfreq.idle_time = 0;
+	ldev->devfreq.time_last_update = ktime_get();
+
+	spin_unlock_irqrestore(&ldev->devfreq.lock, irqflags);
+}
+
+static int lima_devfreq_get_dev_status(struct device *dev,
+				       struct devfreq_dev_status *status)
+{
+	struct lima_device *ldev = dev_get_drvdata(dev);
+	unsigned long irqflags;
+
+	lima_devfreq_update_utilization(ldev);
+
+	status->current_frequency = clk_get_rate(ldev->clk_gpu);
+
+	spin_lock_irqsave(&ldev->devfreq.lock, irqflags);
+
+	status->total_time = ktime_to_ns(ktime_add(ldev->devfreq.busy_time,
+						   ldev->devfreq.idle_time));
+	status->busy_time = ktime_to_ns(ldev->devfreq.busy_time);
+
+	spin_unlock_irqrestore(&ldev->devfreq.lock, irqflags);
+
+	lima_devfreq_reset(ldev);
+
+	dev_dbg(ldev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
+		status->busy_time, status->total_time,
+		status->busy_time / (status->total_time / 100),
+		status->current_frequency / 1000 / 1000);
+
+	return 0;
+}
+
+static struct devfreq_dev_profile lima_devfreq_profile = {
+	.polling_ms = 50, /* ~3 frames */
+	.target = lima_devfreq_target,
+	.get_dev_status = lima_devfreq_get_dev_status,
+};
+
+void lima_devfreq_fini(struct lima_device *ldev)
+{
+	if (ldev->devfreq.cooling)
+		devfreq_cooling_unregister(ldev->devfreq.cooling);
+
+	if (ldev->devfreq.devfreq)
+		devm_devfreq_remove_device(&ldev->pdev->dev,
+					   ldev->devfreq.devfreq);
+
+	dev_pm_opp_of_remove_table(&ldev->pdev->dev);
+
+	if (ldev->devfreq.regulators_opp_table)
+		dev_pm_opp_put_regulators(ldev->devfreq.regulators_opp_table);
+
+	if (ldev->devfreq.clkname_opp_table)
+		dev_pm_opp_put_clkname(ldev->devfreq.clkname_opp_table);
+}
+
+int lima_devfreq_init(struct lima_device *ldev)
+{
+	struct thermal_cooling_device *cooling;
+	struct device *dev = &ldev->pdev->dev;
+	struct opp_table *opp_table;
+	struct devfreq *devfreq;
+	struct dev_pm_opp *opp;
+	unsigned long cur_freq;
+	int ret;
+
+	if (!device_property_present(dev, "operating-points-v2"))
+		/* Optional, continue without devfreq */
+		return 0;
+
+	spin_lock_init(&ldev->devfreq.lock);
+
+	opp_table = dev_pm_opp_set_clkname(dev, "core");
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto err_fini;
+	}
+
+	ldev->devfreq.clkname_opp_table = opp_table;
+
+	opp_table = dev_pm_opp_set_regulators(dev,
+					      (const char *[]){ "mali" },
+					      1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV)
+			goto err_fini;
+	} else {
+		ldev->devfreq.regulators_opp_table = opp_table;
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret)
+		goto err_fini;
+
+	lima_devfreq_reset(ldev);
+
+	cur_freq = clk_get_rate(ldev->clk_gpu);
+
+	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto err_fini;
+	}
+
+	lima_devfreq_profile.initial_freq = cur_freq;
+	dev_pm_opp_put(opp);
+
+	devfreq = devm_devfreq_add_device(dev, &lima_devfreq_profile,
+					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
+	if (IS_ERR(devfreq)) {
+		dev_err(dev, "Couldn't initialize GPU devfreq\n");
+		ret = PTR_ERR(devfreq);
+		goto err_fini;
+	}
+
+	ldev->devfreq.devfreq = devfreq;
+
+	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
+	if (IS_ERR(cooling))
+		dev_info(dev, "Failed to register cooling device\n");
+	else
+		ldev->devfreq.cooling = cooling;
+
+	return 0;
+
+err_fini:
+	lima_devfreq_fini(ldev);
+	return ret;
+}
+
+void lima_devfreq_record_busy(struct lima_device *ldev)
+{
+	lima_devfreq_update_utilization(ldev);
+	atomic_inc(&ldev->devfreq.busy_count);
+}
+
+void lima_devfreq_record_idle(struct lima_device *ldev)
+{
+	int count;
+
+	lima_devfreq_update_utilization(ldev);
+	count = atomic_dec_if_positive(&ldev->devfreq.busy_count);
+	WARN_ON(count < 0);
+}
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
new file mode 100644
index 000000000000..fe4f8a437033
--- /dev/null
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2019 Martin Blumenstingl <martin.blumenstingl@googlemail.com> */
+
+#ifndef __LIMA_DEVFREQ_H__
+#define __LIMA_DEVFREQ_H__
+
+struct lima_device;
+
+int lima_devfreq_init(struct lima_device *ldev);
+void lima_devfreq_fini(struct lima_device *ldev);
+
+void lima_devfreq_record_busy(struct lima_device *ldev);
+void lima_devfreq_record_idle(struct lima_device *ldev);
+
+#endif
diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 19829b543024..7f1f7a1c03e5 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -214,6 +214,8 @@ static int lima_init_gp_pipe(struct lima_device *dev)
 	struct lima_sched_pipe *pipe = dev->pipe + lima_pipe_gp;
 	int err;
 
+	pipe->ldev = dev;
+
 	err = lima_sched_pipe_init(pipe, "gp");
 	if (err)
 		return err;
@@ -244,6 +246,8 @@ static int lima_init_pp_pipe(struct lima_device *dev)
 	struct lima_sched_pipe *pipe = dev->pipe + lima_pipe_pp;
 	int err, i;
 
+	pipe->ldev = dev;
+
 	err = lima_sched_pipe_init(pipe, "pp");
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/lima/lima_device.h b/drivers/gpu/drm/lima/lima_device.h
index 31158d86271c..f5348474a6fc 100644
--- a/drivers/gpu/drm/lima/lima_device.h
+++ b/drivers/gpu/drm/lima/lima_device.h
@@ -5,6 +5,7 @@
 #define __LIMA_DEVICE_H__
 
 #include <drm/drm_device.h>
+#include <linux/atomic.h>
 #include <linux/delay.h>
 
 #include "lima_sched.h"
@@ -94,6 +95,23 @@ struct lima_device {
 
 	u32 *dlbu_cpu;
 	dma_addr_t dlbu_dma;
+
+	struct {
+		struct devfreq *devfreq;
+		struct opp_table *clkname_opp_table;
+		struct opp_table *regulators_opp_table;
+		struct thermal_cooling_device *cooling;
+		ktime_t busy_time;
+		ktime_t idle_time;
+		ktime_t time_last_update;
+		atomic_t busy_count;
+		/*
+		 * Protect busy_time, idle_time and time_last_update because
+		 * these can be updated concurrently - for example by the GP
+		 * and PP interrupts.
+		 */
+		spinlock_t lock;
+	} devfreq;
 };
 
 static inline struct lima_device *
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 2daac64d8955..5d9cfc940dd8 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -10,6 +10,7 @@
 #include <drm/drm_prime.h>
 #include <drm/lima_drm.h>
 
+#include "lima_devfreq.h"
 #include "lima_drv.h"
 #include "lima_gem.h"
 #include "lima_vm.h"
@@ -306,18 +307,26 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out1;
 
+	err = lima_devfreq_init(ldev);
+	if (err) {
+		dev_err(&pdev->dev, "Fatal error during devfreq init\n");
+		goto err_out2;
+	}
+
 	/*
 	 * Register the DRM device with the core and the connectors with
 	 * sysfs.
 	 */
 	err = drm_dev_register(ddev, 0);
 	if (err < 0)
-		goto err_out2;
+		goto err_out3;
 
 	return 0;
 
-err_out2:
+err_out3:
 	lima_device_fini(ldev);
+err_out2:
+	lima_devfreq_fini(ldev);
 err_out1:
 	drm_dev_put(ddev);
 err_out0:
@@ -331,6 +340,7 @@ static int lima_pdev_remove(struct platform_device *pdev)
 	struct drm_device *ddev = ldev->ddev;
 
 	drm_dev_unregister(ddev);
+	lima_devfreq_fini(ldev);
 	lima_device_fini(ldev);
 	drm_dev_put(ddev);
 	lima_sched_slab_fini();
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 3886999b4533..2eae4ddfa504 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/xarray.h>
 
+#include "lima_devfreq.h"
 #include "lima_drv.h"
 #include "lima_sched.h"
 #include "lima_vm.h"
@@ -214,6 +215,8 @@ static struct dma_fence *lima_sched_run_job(struct drm_sched_job *job)
 	 */
 	ret = dma_fence_get(task->fence);
 
+	lima_devfreq_record_busy(pipe->ldev);
+
 	pipe->current_task = task;
 
 	/* this is needed for MMU to work correctly, otherwise GP/PP
@@ -285,6 +288,8 @@ static void lima_sched_timedout_job(struct drm_sched_job *job)
 	pipe->current_vm = NULL;
 	pipe->current_task = NULL;
 
+	lima_devfreq_record_idle(pipe->ldev);
+
 	drm_sched_resubmit_jobs(&pipe->base);
 	drm_sched_start(&pipe->base, true);
 }
@@ -362,6 +367,10 @@ void lima_sched_pipe_task_done(struct lima_sched_pipe *pipe)
 		else
 			drm_sched_fault(&pipe->base);
 	} else {
+		struct lima_sched_task *task = pipe->current_task;
+
+		lima_devfreq_record_idle(pipe->ldev);
+
 		pipe->task_fini(pipe);
 		dma_fence_signal(task->fence);
 	}
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index d64393fb50a9..19bbc5214cf2 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -6,6 +6,7 @@
 
 #include <drm/gpu_scheduler.h>
 
+struct lima_device;
 struct lima_vm;
 
 struct lima_sched_task {
@@ -44,6 +45,8 @@ struct lima_sched_pipe {
 	u32 fence_seqno;
 	spinlock_t fence_lock;
 
+	struct lima_device *ldev;
+
 	struct lima_sched_task *current_task;
 	struct lima_vm *current_vm;
 
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7D32F097
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCEREG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhCERDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 12:03:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA69C061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 09:03:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u187so2064526wmg.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FRb7ItoNyUYyhXCHU4qOqv4pUK8UWPoqe/ZnMREqgVA=;
        b=EgUhOogowl99zpTzCzDFdUKufp8k9c2Gtw+KbklyRh9lG5Kpt5QaM9U79eUMWFyJKe
         OWSSPvd+BuEKkWrvoJO1Ivzf9Qe1vCZm08urwp9Zh0TGbbxSjjmo80dp5hrx4P/NWWnE
         4NCqtnvVCUVsj80mq/qovHX9uVTKYdDxHUiJzm1rBr3vdLcSxoFpANUBJExljWclTCNU
         D8jyIdRzmUtn4FtjTC9wiWSqndGe2lDrn9vWi2ZWq4jv/jCuP+xaJuvMGyw/QEgqFgjC
         SUU67xpKbIHQ2v3685uL3a184kMuhCRtr6k3KxWWzA2EK3gfph8cMx/pUw6dxnA3YKzx
         9p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FRb7ItoNyUYyhXCHU4qOqv4pUK8UWPoqe/ZnMREqgVA=;
        b=hUAO43VTJLwZoYJ3EIAvF/xcr+MKKUyJPfjAzMaJ34zyoM/pQUCXVyDsTomS7NIh0M
         BgndMLhawFq8UtNn6QlB/mD7IUO0eZWLbE41JFvj589MQtlOO5avgUBCjrVyRf1H5904
         h9fjHZszJKuqNCACYoH4GV0dniNVzuk8zSGCfxRa+7OgRYfijGSm0+2XUMSpyyYkmr1V
         km2SBDOCfnQqP6y/M3JUD4wMzpdjtv1kf4vW3/kmZ/Ndcin7qpSEUwJTGzaNaPT0wHDu
         cuJ9R5yj7WbGoZ+UWUcDGlQSJTMZE7JbxX96IbdvZJc3Dt4dGAw4c4Ri3U6DUQxoRoy8
         OiRA==
X-Gm-Message-State: AOAM530Zu0s/+DEM+e0oBrtHmN3FTvtdx3VWx7KxDruWpxAWRmtIuie4
        FznsFlXd60wI1F0+Io4Q3EHjOA==
X-Google-Smtp-Source: ABdhPJwgyaupgci5lBNHruz1mxgNewnWlNWe9DNU6BisY3tavo++IJzHF3YSaYwuf5gizHV6XPyQRQ==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203mr10046088wmu.45.1614963830695;
        Fri, 05 Mar 2021 09:03:50 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id p17sm4760934wmq.47.2021.03.05.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:03:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/4] devfreq: Register devfreq as a cooling device on demand
Date:   Fri,  5 Mar 2021 18:03:34 +0100
Message-Id: <20210305170338.13647-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the default behavior is to manually having the devfreq
backend to register themselves as a devfreq cooling device.

Instead of adding the code in the drivers for the thermal cooling
device registering, let's provide a flag in the devfreq's profile to
tell the common devfreq code to register the newly created devfreq as
a cooling device.

Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/devfreq/devfreq.c | 11 +++++++++++
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b6d63f02d293..5c0fdd3a48d2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -26,6 +27,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/thermal.h>
 #include <linux/units.h>
 #include "governor.h"
 
@@ -935,6 +937,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_unlock(&devfreq_list_lock);
 
+	if (devfreq->profile->is_cooling_device) {
+		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
+		if (IS_ERR(devfreq->cdev))
+			dev_info(dev, "Failed to register devfreq "
+				 "cooling device\n");
+	}
+
 	return devfreq;
 
 err_init:
@@ -960,6 +969,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	thermal_cooling_device_unregister(devfreq->cdev);
+
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 26ea0850be9b..554e7904b0c5 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -98,11 +98,15 @@ struct devfreq_dev_status {
  * @freq_table:		Optional list of frequencies to support statistics
  *			and freq_table must be generated in ascending order.
  * @max_state:		The size of freq_table.
+ *
+ * @is_cooling_device: A self-explanatory boolean giving the device a
+ *                     cooling effect property.
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
 	enum devfreq_timer timer;
+	bool is_cooling_device;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
@@ -198,6 +202,9 @@ struct devfreq {
 
 	struct srcu_notifier_head transition_notifier_list;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+
 	struct notifier_block nb_min;
 	struct notifier_block nb_max;
 };
-- 
2.17.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9F249F16
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHSNGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgHSNAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 09:00:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F645C06135C;
        Wed, 19 Aug 2020 05:59:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so24467502iow.11;
        Wed, 19 Aug 2020 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oVAmZyNrEFZ/qRL/Go1FpkwND3iynaGyrQg/YaoVXg=;
        b=H9uu9JET+dLKWqo7t/dWEJEOctZhL8wpGr2sXlW4Vb0wn6trZDEN53GJhvvjgJhZIP
         659ezdEWF8Z4SwbFa/Asb8VX8m00ejalsigAVz8iJKnKyCI+Y14A0l9BpPcAIV61HTCV
         uSfB7Cuztw8qjG9OfjCWkBcFv/MC/IwjzPQ7rRo//S533Jp0nMNsR7oulST+XzR+YwnC
         kmSr1NWBD1FlYBqRwOimkgE9IAGSV+V5ZHP0kBvKwX1FPYgqHSh2pN5JijoMlxiTGLex
         Fb+pWCudQGBLu2FCBxMHqDJ5M8C1HHIJQcVn0ocp9XUmG7NfOTi/5BXj5i9AOFw+Bd4a
         43ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oVAmZyNrEFZ/qRL/Go1FpkwND3iynaGyrQg/YaoVXg=;
        b=hC3xTUxk8dbKJbLSAJ5cq5eC2NBYH+7zkjdCZK5ryfZBp3yDIx/8fHl+B8eSIn82BG
         h2S1NMtHB0NEJu5nE+1lAH5nz2cVqzzQd0WLfD0Mp6m/09usRuEcddKXz82nZgWOM5uh
         UKcQIFa5zan5oMPH61NcGZtmLxwRYYpaQGr3EaIVRa2oPs2y4ScqhVClo6F+qPbk1Jgc
         n/qR95vnTtTaCFPjS3d9I8/+Q5C1rtt1AaMO8K4sapJXsm/RoTxq1pcKZ+hum6JS/UAF
         XcWfJNWsQ0vfaRtE0iEZV2WMXDFwvHNzDISYSjYjW1H4eEZFVK/1WoUSGCyKzzlVbwn2
         gq5A==
X-Gm-Message-State: AOAM5303v6hSnnkQgrXApLRptbjC4kGCePzazWBgrWjx2Aoyzj3oAXI/
        gFpcJXnBqslN7mtqG8cgPWpwZZYd2dmDjmP1
X-Google-Smtp-Source: ABdhPJy7SeHYcvfIBOyXe6sU4+ijHjrvIgF6d7n/mmqAgapcaRBQ/s4uRdGv3Qa2xUjeFQ0kgX8+iA==
X-Received: by 2002:a02:3843:: with SMTP id v3mr24082031jae.23.1597841973657;
        Wed, 19 Aug 2020 05:59:33 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b588:1a5f:55c3:870e])
        by smtp.gmail.com with ESMTPSA id i5sm4138388ilc.69.2020.08.19.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:59:32 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     aford@beaconembedded.com, hns@goldelico.com,
        Adam Ford <aford173@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] thermal: ti-soc-thermal: Enable addition power management
Date:   Wed, 19 Aug 2020 07:59:23 -0500
Message-Id: <20200819125925.2119434-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bandgap sensor can be idled when the processor is too, but it
isn't currently being done, so the power consumption of OMAP3
boards can elevated if the bangap sensor is enabled.

This patch attempts to use some additional power management
to idle the clock to the bandgap when not needed.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
V2: Fix issue where variable stating the suspend mode isn't being
    properly set and cleared.

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ab19ceff6e2a..9404631bea4d 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -25,10 +25,18 @@
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
 static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v);
 
 /***   Helper functions to access registers and their bitfields   ***/
 
@@ -1008,6 +1016,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
+	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bgp->nb);
+
 	return 0;
 
 remove_last_cooling:
@@ -1041,7 +1052,9 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
 	int i;
 
-	/* First thing is to remove sensor interfaces */
+	cpu_pm_unregister_notifier(&bgp->nb);
+
+	/* Remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
@@ -1150,9 +1163,43 @@ static int ti_bandgap_suspend(struct device *dev)
 	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
 		clk_disable_unprepare(bgp->fclock);
 
+	bgp->is_suspended = true;
+
 	return err;
 }
 
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
+{
+	struct ti_bandgap *bgp;
+
+	bgp = container_of(nb, struct ti_bandgap, nb);
+
+	spin_lock(&bgp->lock);
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (bgp->is_suspended)
+			break;
+		ti_bandgap_save_ctxt(bgp);
+		ti_bandgap_power(bgp, false);
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_disable(bgp->fclock);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bgp->is_suspended)
+			break;
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_enable(bgp->fclock);
+		ti_bandgap_power(bgp, true);
+		ti_bandgap_restore_ctxt(bgp);
+		break;
+	}
+	spin_unlock(&bgp->lock);
+
+	return NOTIFY_OK;
+}
+
 static int ti_bandgap_resume(struct device *dev)
 {
 	struct ti_bandgap *bgp = dev_get_drvdata(dev);
@@ -1161,6 +1208,7 @@ static int ti_bandgap_resume(struct device *dev)
 		clk_prepare_enable(bgp->fclock);
 
 	ti_bandgap_power(bgp, true);
+	bgp->is_suspended = false;
 
 	return ti_bandgap_restore_ctxt(bgp);
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index fce4657e9486..ed0ea4b17b25 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -12,6 +12,10 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/err.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 
 struct gpio_desc;
 
@@ -203,6 +207,8 @@ struct ti_bandgap {
 	int				irq;
 	struct gpio_desc		*tshut_gpiod;
 	u32				clk_rate;
+	struct notifier_block		nb;
+	unsigned int is_suspended:1;
 };
 
 /**
-- 
2.25.1


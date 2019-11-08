Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F8F59C5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfKHVWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:22:54 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39088 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbfKHVWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 16:22:53 -0500
Received: by mail-yw1-f67.google.com with SMTP id d80so2294185ywa.6;
        Fri, 08 Nov 2019 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7K2H5yXWJYp0lSdq9ybY57CVv0NwHSt8pnGeTKmonU=;
        b=tzWPFUthaGMLHWvKSNwJinQ/IpMn6fZi6DGbszhMqTK4E3sdCFcDIp1Ex2gknSureV
         07jYF53E/+9K5LPFvXHL65zT3nt98FW0pcLU/68lSEAgEsf8vMoiDrotgreQ4yhw9Xre
         Cd9pEzOfz4MR6LMAXgyBtLqPKrbIcrWRdUiAhGy7Z7zSRceqWzOGI6/T2SbgfaVvUawm
         1VWcpod2yy6KMWARuzBMHMX5fTLEv+Azf9Z2O3TZvQtvzBAxEioZazQktVyMEzprLYOY
         cQO5Jpm58y1xFOUQlCVXupoHm95w1LbsAuxQEj9nmlH3FeADcjUAFn8G36SdgZZ/81UA
         pZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7K2H5yXWJYp0lSdq9ybY57CVv0NwHSt8pnGeTKmonU=;
        b=c2nuYqnXdTAtnqnqtPBSvXv1ls1PD7wd4HhHZni8RIFC9XwRjhi9c4rteBJkb1FRZY
         4CDer5waHTJ/+3dZ4JG7WcBJB+R2l3WLP6AnRxRyJz4QySc0gnPbgVOcCAw+VtJX9PL3
         65N6909RHBUxGm4/xr9lLfURxVLYwRuCZwGT4u6wt1Kp1noBi94Rsxh6tVmp4lhkQj+V
         7/q8RV1hCsUu8TEumvqeBVMnR1EVFamiTVnUnJrN8Kpp5geaV3IHC7z+yOg2ZNsbzsaO
         vh6MmjVuzv+lW8zwCG2mka0A6PqN4LOsuGhurhdphhDeUzQwVbZfdFnRw16xBFlhQPOU
         KN+g==
X-Gm-Message-State: APjAAAUG3O+WolViuv5La4hAnQQOJI0Y0hJrglnrk4zepMxIrDIjIXSw
        XhHGnUHzNFmK9EgSHDwMpJzWmKEitOrHIQ==
X-Google-Smtp-Source: APXvYqxpRr1i2ydkLT+QsomfYbsIoZetnFNDS6QfM07tRHgXWYeY/Gq8IFciluXV19P6BG6vOzsJrw==
X-Received: by 2002:a81:10d4:: with SMTP id 203mr8566431ywq.390.1573248172107;
        Fri, 08 Nov 2019 13:22:52 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l127sm3978155ywb.21.2019.11.08.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:22:51 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     hns@goldelico.com, adam.ford@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] thermal: ti-soc-thermal:  Enable addition power management
Date:   Fri,  8 Nov 2019 15:22:13 -0600
Message-Id: <20191108212213.3861-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bandgap sensor can be idled when the processor is, but it
isn't currently being done. The power consumption of OMAP3
boards can elevated if the bangap sensor is enabled, because
the bandgap clock blocks deeper idle states the SoC.

We should idle bandgap with cpu_notifier instead of
runtime PM to avoid tagging it with pm_runtime_irq_safe()
that we want to stop using for drivers in general.

This patch uses additional power management to idle the clock
of the bandgap when it is not needed.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..35edac688843 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -26,10 +26,18 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
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
 
@@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
+	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bgp->nb);
+
 	return 0;
 
 remove_last_cooling:
@@ -1060,7 +1071,9 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
 	int i;
 
-	/* First thing is to remove sensor interfaces */
+	cpu_pm_unregister_notifier(&bgp->nb);
+
+	/* Remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
@@ -1174,6 +1187,38 @@ static int ti_bandgap_suspend(struct device *dev)
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
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index bb9b0f7faf99..a21d07a1a23a 100644
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
 
 /**
  * DOC: bandgap driver data structure
@@ -201,6 +205,8 @@ struct ti_bandgap {
 	int				irq;
 	int				tshut_gpio;
 	u32				clk_rate;
+	struct notifier_block		nb;
+	unsigned int is_suspended:1;
 };
 
 /**
-- 
2.20.1


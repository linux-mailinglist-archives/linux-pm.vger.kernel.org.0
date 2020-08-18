Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2F248A5A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHRPrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHRPqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 11:46:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E62C061389;
        Tue, 18 Aug 2020 08:46:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b17so21600439ion.7;
        Tue, 18 Aug 2020 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IhRK4si9xEoUVOddxAouxLbNZadm1eVe8xYF5LfxIzI=;
        b=TckO8q8q9GYYWdaLzHlnObn7mHR35pCqimMAEwUhMPsF+NV+xV4ejpqnKoPqKMSypT
         I9rU/5J41DIaPz4HTAMJjpDixzfSvnBXc04VLIQhM5qpnZEEvRzp3RbFCNvXzr6Ww3jk
         ahUxT8/0Exv19xESS+wdDLpFGPiTevIx24ZYNCZZCehuWCYI92TXVxlp3tiPQPiJO0Ru
         K4BG00OH2+9JsWS8PobPx7L9NqAZMq4ctc5u838x96I/PKQ9E37iHirGcO+qfdK6AlOQ
         YPwmNkDHaTSREYdWJ95Yo5rR8cXARlsCgoxlrmJr9bre6vrIiCzBUD5lN9d7hNOfWlDi
         7uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IhRK4si9xEoUVOddxAouxLbNZadm1eVe8xYF5LfxIzI=;
        b=eMSRZ6WTcunhlr/jxoYEu2EGz6SMOS/IC0mZoxjvv4Augj6qMg+ygkfLYZZdybLQ6Y
         rCF6OsGocT98+bA/8mb5s8+YZ1k0CbfATSM+s3KchQ3BOvUIpIetHzd2Rko/mxzk/VE8
         PipHeMb0PHRfqcAInOBClI28PX9DkQmh1uotjjIPnohF3bEJJpGsAw5Ws3BZ2P6YiZwy
         tucv6d3MikiyqCntJhUuNpha963vfflWEv0cMBG+xDnmVxXE+hNN+qe0/n9D3jFnr1n2
         qbyX8/ufcQ5vy6FY2NK9IC7kaqZiR4At2aDV2rpFDlyruFWQcmC1VzML4YTRjdTS8f1r
         bp7A==
X-Gm-Message-State: AOAM531PkBwaaVVy0xpsI5O4/0NuqmwOhvDufM8DCn00BW+RpN7VfiDz
        pWWU3G50/GLPWKOST8JhAs34Lb0K8SmPDg==
X-Google-Smtp-Source: ABdhPJwhvjO8PItUV55yph5joJ/ppt3vZmd0TDwQG+VHhkUUct6SsNcqDfEBWZNCP2Uo8fBayzx6+Q==
X-Received: by 2002:a05:6638:8b:: with SMTP id v11mr19816588jao.122.1597765599365;
        Tue, 18 Aug 2020 08:46:39 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id z1sm3113625ilh.13.2020.08.18.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:46:38 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] thermal: ti-soc-thermal: Enable addition power management
Date:   Tue, 18 Aug 2020 10:46:32 -0500
Message-Id: <20200818154633.5421-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
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

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ab19ceff6e2a..923ef3abb867 100644
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
@@ -1153,6 +1166,38 @@ static int ti_bandgap_suspend(struct device *dev)
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
2.17.1


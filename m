Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE68265F96
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIKMde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 08:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgIKMcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 08:32:10 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B7C061573;
        Fri, 11 Sep 2020 05:32:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a19so4236131ilq.10;
        Fri, 11 Sep 2020 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugTNUn8mm2Ku6DfVm6vxHRWJ3JTBU9LWayGqG53mxMw=;
        b=MpdvMpPqMKWBctHOkuDpfxbTZK3NqQSwG0yCiF+ibrvu2DHy4mZCcuQx8xzubGiltk
         fXkGxi9AehKRLwp0zIARnb4WngxM54WeeCagnuDxR29D12RJa1RwACdiwe9q5YMfIJYN
         ZcUEatOXvTiO9nfXsyZEkNS2co1OVbLzgigfJdoFzuimQ1Fn9s8sKghAhXBZQAx/OENo
         ziWEcXeoXQ1OdBgW99Ypps/x+fb6rEHBfc6A6iBRcPKTcTtOrep0VtJ0hv/Kg6weibPT
         Wds0+wkvGyF/NhDJYTE+ScXFZX1lSo4xa05qmXHg/0sC/uX7kHss/xGwC1pxVFNmeCA2
         QpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugTNUn8mm2Ku6DfVm6vxHRWJ3JTBU9LWayGqG53mxMw=;
        b=aFNay7b0dKNebITLYAjLRyKY1KHJAYMPj18w7DsM965BPgUq2AWhZ1Z6L3mV+CYzrs
         LWRtE4crh7Pa1vHDMrjrFeK7z1QER0Y67lwofE3CZ9a4RYR80XdMZCteSH54zu5bv5MB
         Clht3l/DZjiSvZV3gy8e6qWRP5hrFkVBjWNThtr20W45usBLQ1d3iOCgJgOcfdUoUXn9
         KuqlPiVwbrPv4bQPua4Avu0IWZUgHvAWq0bkSZfZFVzoyNacBI2zt7G1oFM1BqX8+glg
         aQcUNcj9pgJBsKR9LcQ2izWQrOtgHl+gvUince3S5/DwN8BBN3ba/iGDLNf6CZUySFfZ
         4qxg==
X-Gm-Message-State: AOAM5327iensW63wa45mvShIVMVl8MoFC8xNe8oPCdt8HisMLBfP9c7T
        ryZCRi3ptXt86fx2aNeKofZVeXvhMAQ=
X-Google-Smtp-Source: ABdhPJxl2ZwcqutABattNSET4QKwUd7/IzX1WiTFxtg4ligGakYCwNb+FcHWlik94jksPpHtKPkWvw==
X-Received: by 2002:a92:9646:: with SMTP id g67mr1536585ilh.116.1599827529114;
        Fri, 11 Sep 2020 05:32:09 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (mn-10k-dhcp7-1791.dsl.hickorytech.net. [68.232.239.6])
        by smtp.gmail.com with ESMTPSA id m18sm1144277iln.80.2020.09.11.05.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 05:32:08 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: ti-soc-thermal: Enable addition power management
Date:   Fri, 11 Sep 2020 07:31:56 -0500
Message-Id: <20200911123157.759379-1-aford173@gmail.com>
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
Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04
---
V3:  bandgap_omap_cpu_notifier is only defined when CONFIG_PM_SLEEP
     is enabled, so make all references to it also depend on
     CONFIG_PM_SLEEP as well

V2: Fix issue where variable stating the suspend mode isn't being
    properly set and cleared.

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ab19ceff6e2a..5e596168ba73 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -25,10 +25,20 @@
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
+#ifdef CONFIG_PM_SLEEP
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v);
+#endif
 
 /***   Helper functions to access registers and their bitfields   ***/
 
@@ -1008,6 +1018,11 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bgp->nb);
+#endif
+
 	return 0;
 
 remove_last_cooling:
@@ -1041,7 +1056,9 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
 	int i;
 
-	/* First thing is to remove sensor interfaces */
+	cpu_pm_unregister_notifier(&bgp->nb);
+
+	/* Remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
@@ -1150,9 +1167,43 @@ static int ti_bandgap_suspend(struct device *dev)
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
@@ -1161,6 +1212,7 @@ static int ti_bandgap_resume(struct device *dev)
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494B933943F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhCLRDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 12:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhCLRDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 12:03:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB738C0613D7
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 09:03:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l19so4219477wmh.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MotLWcKEAwk5d5cO6koO4+5PW/4j89nsIKT3D/mQf/k=;
        b=uMtJEddo/apKTRPUpOe2gBO64mOi6Yx8nCGsweTIrjBzQqQHeNSzCxx/SPxRKio4u/
         U7BV3QGxk6DASUj8myYOxUyrTFoT0pzakXnV8hbPTE7UZLt8yQo6eO0viDSTU/qaC+qZ
         lAoe28FX8HqNtbXukl0zwTGL4OX+KSa8C2OmK0ccHrs5LCmDFJe2rV4Ww0DbK6pnELrM
         1AS2u3vIxkWOA0mcbPVdGfdmDhRDHoJW/s6iv3ZGb9GdkAow2LIVMtyOg32zhRYQRFKf
         TgaV0+CUAVYL+D78Y0BYs3HcqjHPo5WlYL/UKYYu1vUrzjF1noh3lUSHqaw0uwUShVS4
         scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MotLWcKEAwk5d5cO6koO4+5PW/4j89nsIKT3D/mQf/k=;
        b=ZwKOopebT+Xc/3wL6kQOedKQKafH1VTPcycWbwa6x1AWl0xlImcsvcSolEtr3hHUDr
         obuJyq8+ScJWbTlWi7735C7oa4kHT5FMuXWGrgqjE9Y9UZktkwPt95229gIKQ3dd62Fg
         qlGM7jMywv/o5cT4z8p5NiSMNascnmOyl4JmVzsEXI6ec6OZqQd/EhxckXy9HU859iYh
         9UrBrXW8yrA8OqlqFggs38VPkNUO0dxwWMUjnj+UUctScD8NWbcptrOE87V2I1mAZw1+
         RviRChw6l0OLM7xp+gecpXaVrWpy98f32MICJoVlPOgQKQXaE8Q/oyzEBO3r2JfxaOp7
         VtQw==
X-Gm-Message-State: AOAM530fFGmwmdF4RcMmcxGI65tlRY7VHp5QvvvyVpihqeUS6V5wnLvQ
        906h9bM37d+CqGvtEDA6F0VDpTYDpbmQKA==
X-Google-Smtp-Source: ABdhPJxKajnxOKuPd+qw3KDRxr/khkMZ8IayzUVFqFSw+JlCxAg9QeT2CwDLpQsCx59ySooB/RWvow==
X-Received: by 2002:a1c:4182:: with SMTP id o124mr14271973wma.61.1615568611445;
        Fri, 12 Mar 2021 09:03:31 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id 1sm2854681wmj.2.2021.03.12.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:03:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 3/5] thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering
Date:   Fri, 12 Mar 2021 18:03:14 +0100
Message-Id: <20210312170316.3138-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312170316.3138-1-daniel.lezcano@linaro.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-devfreq-0
 thermal-devfreq-1
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal' prefix and changes the number by the device
name. So the naming above becomes:

 devfreq-5000000.gpu
 devfreq-1d84000.ufshc
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
V2:
 - Removed idr.h header
 - Used kasprintf instead of fixed buffer length on the stack
 - Fixed typo in the log
---
 drivers/thermal/devfreq_cooling.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..fb250ac16f50 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -14,7 +14,6 @@
 #include <linux/devfreq_cooling.h>
 #include <linux/energy_model.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
@@ -25,11 +24,8 @@
 #define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
-static DEFINE_IDA(devfreq_ida);
-
 /**
  * struct devfreq_cooling_device - Devfreq cooling device
- * @id:		unique integer value corresponding to each
  *		devfreq_cooling_device registered.
  * @cdev:	Pointer to associated thermal cooling device.
  * @devfreq:	Pointer to associated devfreq device.
@@ -51,7 +47,6 @@ static DEFINE_IDA(devfreq_ida);
  * @em_pd:		Energy Model for the associated Devfreq device
  */
 struct devfreq_cooling_device {
-	int id;
 	struct thermal_cooling_device *cdev;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
@@ -363,7 +358,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
-	char dev_name[THERMAL_NAME_LENGTH];
+	char *name;
 	int err, num_opps;
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
@@ -407,30 +402,27 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
-	if (err < 0)
+	cdev = ERR_PTR(-ENOMEM);
+	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
+	if (!name)
 		goto remove_qos_req;
 
-	dfc->id = err;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
-
-	cdev = thermal_of_cooling_device_register(np, dev_name, dfc,
+	cdev = thermal_of_cooling_device_register(np, name, dfc,
 						  &devfreq_cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev)) {
 		err = PTR_ERR(cdev);
 		dev_err(dev,
 			"Failed to register devfreq cooling device (%d)\n",
 			err);
-		goto release_ida;
+		goto remove_qos_req;
 	}
 
 	dfc->cdev = cdev;
 
 	return cdev;
 
-release_ida:
-	ida_simple_remove(&devfreq_ida, dfc->id);
 remove_qos_req:
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 free_table:
@@ -527,7 +519,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	dev = dfc->devfreq->dev.parent;
 
 	thermal_cooling_device_unregister(dfc->cdev);
-	ida_simple_remove(&devfreq_ida, dfc->id);
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 
 	em_dev_unregister_perf_domain(dev);
-- 
2.17.1


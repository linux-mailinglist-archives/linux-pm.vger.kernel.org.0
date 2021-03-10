Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD5333BBC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCJLqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCJLqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:46:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A2C06174A
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so6918090wml.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/GwBIjz9iOP0pxeHT+2leILb24Wf53Rkht4zzhD+XbE=;
        b=MAzzHWKc3AcB9TA+bPnp96grLDeT6sUGggo4ltJGXiBM+hXmVJt5CTsJT9qjvZE/Pi
         nmNN85mJMa87JZWdxPwX3sZ8qgr9Rxmar6J3R0MNet2PVKRQAfLThadVCc27z4FeYMzk
         D1RtQ0lL2ALlrSbvWyEwz7sSxXM4xzZdINDN2IoaOgorIyUt/Ra0J0l410565mej6R8q
         /f48EaIA/1jUgnzsSpcOwJ1pXtncBUkmqBMiZhcG478z/ufGkNc8XQKKdYHDO8F7A0Vg
         MS2VFLaUKsHjV2Do1BJBEpja9m0IGUWUpxriaG7BwcQqnYwKlfa94KVQAHOpKPsCSpha
         xBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/GwBIjz9iOP0pxeHT+2leILb24Wf53Rkht4zzhD+XbE=;
        b=WstWNT22iLny3tnle6/tYRtULojxboP3i9KjZ0wA/7HGKzKkH7xRQpPjiy55kP/Pea
         Y+TW6ZIkxdd6fU2A7qopFo7z2coM/IHFom/NzSNwNZ525UxrAJG/6ChNTJ5DhWMVv3WW
         EaAHlQVB4D8dR2djiBO+F1j6OgKF/B5Px4oJD0KbjufEXe95jVXAffNr7uL8bQ45pHQe
         UvVMUYpFcuhODkfnsQkWG5zo7/MdmMFN0Z6CkygK010d5/mnpHgs+xMy9nqx4zlDkecf
         aI3ZtyraUTZV2+lCJzBlfayzTSuAHLoc9iTHyAAYKPD3BLb8Zp0Tyx+HwYwtzEfh73fI
         8l0w==
X-Gm-Message-State: AOAM532kMx424WCQ8fyCPGQIzIsI2bRqR5p0vNpnvmxasHnmxGlmKrgP
        uQt7jUxhGGEEsUEmCgpu2Hl50A==
X-Google-Smtp-Source: ABdhPJy5NdV3/fpTsCRRmIsXQ24zLTa6ItYFOGyfNsaof6Sd9vEj4fGHJs33zp20/UagJO0JMC838Q==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr2933680wmc.164.1615376782515;
        Wed, 10 Mar 2021 03:46:22 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id h10sm30368165wrp.22.2021.03.10.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:46:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering
Date:   Wed, 10 Mar 2021 12:45:59 +0100
Message-Id: <20210310114600.27178-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310114600.27178-1-daniel.lezcano@linaro.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
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
patch removes the 'thermal prefix and changes the number by the device
name. So the naming above becomes:

 devfreq-5000000.gpu
 devfreq-1d84000.ufshc
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..62abcffeb422 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -25,11 +25,8 @@
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
@@ -51,7 +48,6 @@ static DEFINE_IDA(devfreq_ida);
  * @em_pd:		Energy Model for the associated Devfreq device
  */
 struct devfreq_cooling_device {
-	int id;
 	struct thermal_cooling_device *cdev;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
@@ -363,7 +359,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
-	char dev_name[THERMAL_NAME_LENGTH];
+	char name[THERMAL_NAME_LENGTH];
 	int err, num_opps;
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
@@ -407,30 +403,22 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
-	if (err < 0)
-		goto remove_qos_req;
-
-	dfc->id = err;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
+	snprintf(name, sizeof(name), "devfreq-%s", dev_name(dev));
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, dfc,
+	cdev = thermal_of_cooling_device_register(np, name, dfc,
 						  &devfreq_cooling_ops);
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
@@ -527,7 +515,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	dev = dfc->devfreq->dev.parent;
 
 	thermal_cooling_device_unregister(dfc->cdev);
-	ida_simple_remove(&devfreq_ida, dfc->id);
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 
 	em_dev_unregister_perf_domain(dev);
-- 
2.17.1


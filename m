Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3B6E0CF3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDMLrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDMLrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 07:47:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C29ED5
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso14577328wmq.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386415; x=1683978415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=gESRsna9XWyk/KwQX0XbxJviRAtaQKcmohShrQT1B9JAbemafdpAFiajo6uaJgXmVQ
         kxxRmTB5tyvFwBhkyuwwnM80F1Y38VkgRr+JbOVFoEvedQtsdX6INun5wSS3kQREpXG8
         CDuc/Zb6XtHVaGQumBYbJU7BeRv13BB3l8IbswZmSLih6IuGtu4oogjkww4bO+CLOpas
         TevDdIeetR3MSi20N0cErhAwGW+xYJm/orRNAkT40mj14IPZ7XqRGqQ3WPA+n97OgG9g
         3iCuE/n8cT0j95rF/bu4Ma49lJtzpcOqae/Yi9oVnlk22k3/sh3Fb4K3dy6hmc6awB3L
         07Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386415; x=1683978415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=dU3CGh/DfFaO9nofTH3lKDbJfRuiibsspU6xzXNmDxHRN8Vp9iyaeB0/J+Nd0OeWK0
         zWPqtWO77QkXHzIYdgNljWtCksMvvjfof4ylMID//ItkL8yR3xBO6BRVhGXCGT96xgTl
         xSEMgiPp7svODdFKHkmwZk2PpFN4hRe+Elic74clUo5wFf14F224FXjyVgExaQEEkMQG
         jp04vquWXjfftycf7/rMY14xp1NBFEHgq3fvb+N58x0KwZOwOIsA/7nPJU3CRpqAxPZe
         4xXY0pYdqF8ZlGmlVpDzd1kaKWepe1PmuE7Q0L/SxYLzEW31tKgLFKSpzlWVWdEAvWyM
         4FUA==
X-Gm-Message-State: AAQBX9f3oxv3WYtSOxhaC7NsQUelGOjy7ujFMiobL+7/u0FVVS5GMtsa
        GrXR5PMkDTv9Xlrf75IJ3T4Pf33a485rFF+yh1k=
X-Google-Smtp-Source: AKy350YxZp+fPhGbbaN0y386+hnQogP+/sUyBMs69Hoj71y1o/R0i2nrWldz/jrTXhMhX8Q46B9McQ==
X-Received: by 2002:a1c:f302:0:b0:3ed:b048:73f4 with SMTP id q2-20020a1cf302000000b003edb04873f4mr1626368wmq.5.1681386415664;
        Thu, 13 Apr 2023 04:46:55 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH v3 3/6] thermal/drivers/acpi: Use thermal_zone_device()
Date:   Thu, 13 Apr 2023 13:46:44 +0200
Message-Id: <20230413114647.3878792-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get the device associated with the thermal zone, let's use
the wrapper thermal_zone_device() instead of accessing directly the
content of the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 255efa73ed70..5763db4528b8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -789,6 +789,7 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct device *tzdev;
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -820,12 +821,14 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
+	tzdev = thermal_zone_device(tz->thermal_zone);
+	
 	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tz->thermal_zone->device.kobj, "thermal_zone");
+				   &tzdev->kobj, "thermal_zone");
 	if (result)
 		goto unregister_tzd;
 
-	result = sysfs_create_link(&tz->thermal_zone->device.kobj,
+	result = sysfs_create_link(&tzdev->kobj,
 				   &tz->device->dev.kobj, "device");
 	if (result)
 		goto remove_tz_link;
@@ -849,7 +852,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
 remove_dev_link:
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+	sysfs_remove_link(&tzdev->kobj, "device");
 remove_tz_link:
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 unregister_tzd:
@@ -860,8 +863,10 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+	sysfs_remove_link(&tzdev->kobj, "device");
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1


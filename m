Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA726E7558
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjDSIeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDSIeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 04:34:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F7B1024C
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r15so7135362wmo.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893232; x=1684485232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFr0nNH7gKvfGd1xmrDdwsbO4A4hFnitswKb+PdA3E8=;
        b=W/Tqw/dMvtEe3FajEF9yCwGnfzmUZEjH+Tif9EgeaHJIdCUZf++mkSpx6eNr2zFb3B
         ev+9mSAGmiJOJ/xVRku+fLPsaOHjzLH2vkIUvhFYMXg7qd0Fk1N8vHRCL4CXq+60iHAG
         KpfoO799aCEpb1snZiiflY8lj4Yo2MXdArjEAeSUWr98PgdJ6U8mRomWqj566wQR1ZhZ
         LhHNRCim/aJ0ubva7AbwrKjtojJ2zcS0hQABDMbqunXxyXfaEQcEd12Y4zJsuyqNN9B3
         iUAWLfYe3gGZ+lxE+JU/R7HFQWChRETiFZ0meFXZBsdJZdALiwBMGzcLOM7cIEOkwhvT
         QgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893232; x=1684485232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFr0nNH7gKvfGd1xmrDdwsbO4A4hFnitswKb+PdA3E8=;
        b=f2tbym2p65W9JLXVKLqQO5j0nT3QhDoUuz6Cj1qctX/FaMhIV5hZe5O6+BGnNORljI
         Rg1sZui5CUb2RyEZedwew1m0UQDgtJE99H0fYXfO2q+tU9LP5Xq0VsS4DDiM+RKax1AU
         f4l/J58cMBc+SFmfl1DCDJCl5xnSufC9yhwhQNQQ5SpG4mmUIIhBqZnTkQSN4e5aIEF3
         KcGfdasesP987JDZwWZSULMVFFeEQ3EqwiNOexwIQbz6nUDq9gLGP6J7LHe34JjaxyOD
         GdDcJcT9EIBQdUa+yRnEJQBVzzXO+i6/DifcFrEllZ9VMchpNuGIVEETfPEHdLq1EkZ0
         HdJA==
X-Gm-Message-State: AAQBX9e8jpnxql61U0iUU+gcZvxgc9JiAf9Z8Mbx9aHpyUDLfiWrif7m
        zd0pljKEAyMWuoLpDot5fBVeTw==
X-Google-Smtp-Source: AKy350bEQa6B5ZqLGlKS+oPmo6grbCsWKBRQGeNInPxEGgjFovGVroUCPj9Lo+sCs3xC28bfbvM3Cg==
X-Received: by 2002:a1c:cc05:0:b0:3ef:d8c6:4bc0 with SMTP id h5-20020a1ccc05000000b003efd8c64bc0mr14793730wmb.40.1681893232730;
        Wed, 19 Apr 2023 01:33:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH v4 5/6] thermal/drivers/acpi: Move to dedicated function sysfs extra attr creation
Date:   Wed, 19 Apr 2023 10:33:42 +0200
Message-Id: <20230419083343.505780-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACPI thermal driver creates extra sysfs attributes in its own
directory pointing to the thermal zone it is related to and add a
pointer to the sysfs ACPI thermal device from the thermal zone sysfs
entry.

This is very specific to this ACPI thermal driver, let's encapsulate
the related creation/deletion code to group it inside a function we
can identify later for removal if needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 52 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5763db4528b8..9a90b1a117cd 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -787,9 +787,34 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
+static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	int ret;
+	
+	ret = sysfs_create_link(&tz->device->dev.kobj,
+				&tzdev->kobj, "thermal_zone");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&tzdev->kobj,
+				   &tz->device->dev.kobj, "device");
+	if (ret)
+		sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+
+	return ret;
+}
+
+static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+	sysfs_remove_link(&tzdev->kobj, "device");
+}
+
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev;
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -821,23 +846,15 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
-	tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tzdev->kobj, "thermal_zone");
+	result = acpi_thermal_zone_sysfs_add(tz);
 	if (result)
 		goto unregister_tzd;
-
-	result = sysfs_create_link(&tzdev->kobj,
-				   &tz->device->dev.kobj, "device");
-	if (result)
-		goto remove_tz_link;
-
+	
 	status =  acpi_bus_attach_private_data(tz->device->handle,
 					       tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
-		goto remove_dev_link;
+		goto remove_links;
 	}
 
 	result = thermal_zone_device_enable(tz->thermal_zone);
@@ -851,10 +868,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
-remove_dev_link:
-	sysfs_remove_link(&tzdev->kobj, "device");
-remove_tz_link:
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+remove_links:
+	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
 
@@ -863,10 +878,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tzdev->kobj, "device");
+	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1


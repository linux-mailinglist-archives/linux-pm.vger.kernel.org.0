Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2613560CE7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiF2XAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiF2W7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 18:59:45 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C340E41
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:58:51 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e5-20020a636905000000b004119d180b54so372268pgc.14
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWtWzcF9EWPJff15LpScH15OiRkVx8LFLsKeZfF4Vw0=;
        b=UWnG7cUEsRngB6+FpQTUwPtY9Fa3M+ATomWL5dGrpOXykhGGRzSBaCXjDQaUY4BrYW
         h/H4Br3KmDKglsXZPzpUEXfhjZTa7FiRY8piqh4zhPp/oou/IUKk3mx5UAnH26IjAKdd
         c+Xa8s6M1FROWeLXLlIM/slorgk9aROq6KqLnb9Z496zQA1DvS6wDYN2rFSwXOFo3B/D
         4ob/c3m4KBJRAYYw47dExamOQUG6hyOpe8Sj+iyGLx2EyURd31oVQYuTRkvl24brbvG7
         d82GerEUcdkV3m77tkk560ty73+vqzYk++v+i/529GVvtViEuHnULbvHKoiEKrwDP10B
         qYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWtWzcF9EWPJff15LpScH15OiRkVx8LFLsKeZfF4Vw0=;
        b=rvVlo/+sED4PnDcCOIqzlme1bVhoOZJUMvtjgmUB6dEj3X6GEtaYZ//0bvo2PEx8jc
         cao4HMjUJVnEehf8h4k5YU916kBIF3AodRrtIoTvCfoQmgoJWdG/i3C7zkeIe0NfAhld
         KVLcBl3Ydxewpui+XHfBhsRuMFBU3LE/fKAeL3Ziji78Qf3h29EWdOWGYZ5TkR/mrh5y
         APBRmaKXYpD9bQ7POVEJSPpxexPEp5c5JWvGN259N8Bz8LWjltX4t144LPbBY0kq4Prx
         j2oHj+o3GrwQCytk/EJM4xL6r9/UR4WMGa1C4sZs7YL05g0HhSEQHEYjuN00jx5EwjHi
         aDtw==
X-Gm-Message-State: AJIora8eHoywiMn3jzRoQftz97fXUOA6o+NnMzptsEPBQoSY5tz8k9Pi
        ADLLlA2bjnM305WyBPljwO/GpYiMvHGNpidbrhw=
X-Google-Smtp-Source: AGRyM1uLiis59SVfbCrONv+Ja9MRsl2c1ovETkCcknpE61KRbyIRoDv1ilv1BDthOXjvyc8q8yGx/OzrECY12zFh354=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:d2c9:b0:16a:578f:c356 with
 SMTP id n9-20020a170902d2c900b0016a578fc356mr11245986plc.4.1656543531426;
 Wed, 29 Jun 2022 15:58:51 -0700 (PDT)
Date:   Wed, 29 Jun 2022 22:58:41 +0000
In-Reply-To: <20220629225843.332453-1-willmcvicker@google.com>
Message-Id: <20220629225843.332453-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220629225843.332453-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH 4.19 v1 1/2] hwmon: Introduce hwmon_device_register_for_thermal
From:   Will McVicker <willmcvicker@google.com>
To:     stable@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel-team@android.com, Will McVicker <willmcvicker@google.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ upstream commit e5d21072054fbadf41cd56062a3a14e447e8c22b ]

The thermal subsystem registers a hwmon driver without providing
chip or sysfs group information. This is for legacy reasons and
would be difficult to change. At the same time, we want to enforce
that chip information is provided when registering a hwmon device
using hwmon_device_register_with_info(). To enable this, introduce
a special API for use only by the thermal subsystem.

Acked-by: Rafael J . Wysocki <rafael@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 25 +++++++++++++++++++++++++
 include/linux/hwmon.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c4051a3e63c2..412a5e39fc14 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -725,6 +725,31 @@ hwmon_device_register_with_info(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
 
+/**
+ * hwmon_device_register_for_thermal - register hwmon device for thermal subsystem
+ * @dev: the parent device
+ * @name: hwmon name attribute
+ * @drvdata: driver data to attach to created device
+ *
+ * The use of this function is restricted. It is provided for legacy reasons
+ * and must only be called from the thermal subsystem.
+ *
+ * hwmon_device_unregister() must be called when the device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new device.
+ */
+struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata)
+{
+	if (!name || !dev)
+		return ERR_PTR(-EINVAL);
+
+	return __hwmon_device_register(dev, name, drvdata, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(hwmon_device_register_for_thermal);
+
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 8fde789f2eff..5ff3db6eb9f1 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -390,6 +390,9 @@ hwmon_device_register_with_info(struct device *dev,
 				const struct hwmon_chip_info *info,
 				const struct attribute_group **extra_groups);
 struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata);
+struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
 				const struct hwmon_chip_info *info,
-- 
2.37.0.rc0.161.g10f37bed90-goog


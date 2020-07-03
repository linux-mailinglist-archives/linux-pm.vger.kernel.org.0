Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A502136B5
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCIx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 04:53:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B724C08C5C1
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 01:53:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so33239422wmo.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yPw5lE3p/HPrYy0OQ0kH4UKHdhOsft7/FKkXJ1qoZ7Q=;
        b=Lis8QvmH5PzzVHtd85M4asu+1O1H23q5wkNJUm+SMiCcn2q1Py15QGu367B8vrtS8G
         f7lGIyo1oT3cvLeEoipcrKTsJjSFshWnMH71oScyxh3qvpBmNlFobIHF0963SBx8d+xX
         uhHTTxg9KjiimbrwPuXGh41eI+gruKOz26ivRqh/lirR082eMZuczXvSZ/30LC4NU7Hl
         N+/ccLih4RBT7jmslziBTKeSSTY5lhkgET2XwgUkuPKEmtMae6KAh/jfheKFbdlRp0pc
         7o0LSNfYQ38sV3K0f730HaZMAaYI873PgKPvIGZ/DAUybjRFFM0zEXzIk3hzaosTOov5
         eAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yPw5lE3p/HPrYy0OQ0kH4UKHdhOsft7/FKkXJ1qoZ7Q=;
        b=NCAak28SkJuhsHcDeLWtHPYEPNF6KucXA1yyY4OhmQJX640imb0xoo3cIj6xE4xEOn
         wax6UTjzbsrK5VdfDMInK6i+N5wk7RgTwgtS/CSNuJUXXhvpCz61eOgsZvJxzkFD8+4X
         VrCWosK6GbgDlCobk/JVooSr7ZODv8Lij+Pck0pvG2UpYXiVHIxFf4As1Q48jDYSStMB
         UkJwOuufJckk4lzBu2KpzpSOdXSdIzUgJEwZ7shrM79DsX1UFf0IhDc8Swa5ov9e8vI+
         12F2V6ZOYqAQ8v6p8O1la6SnpOqposXUuwUTI3bDeNmaJk9rwE047tT5Sw86jxytjmZ6
         Yq8A==
X-Gm-Message-State: AOAM531pgLXuHPeMDqOhJjL0U44E5Pjpqs84K5WOzsu51uGyRcU1UVeI
        3SScA74WADCcbcj6yrbRaU6frw==
X-Google-Smtp-Source: ABdhPJzDgajaDjS89mcroLneStpY3qZEMwnifDxsPC5MHXH88Ftlz3mw8Dl39thzEsAQnRk4HF3Eiw==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr33312393wmd.122.1593766404091;
        Fri, 03 Jul 2020 01:53:24 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id z6sm12543611wmf.33.2020.07.03.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:53:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/4] thermal: core: Add helpers to browse the cdev, tz and governor list
Date:   Fri,  3 Jul 2020 10:53:06 +0200
Message-Id: <20200703085309.32166-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cdev, tz and governor list, as well as their respective locks are
statically defined in the thermal_core.c file.

In order to give a sane access to these list, like browsing all the
thermal zones or all the cooling devices, let's define a set of
helpers where we pass a callback as a parameter to be called for each
thermal entity.

We keep the self-encapsulation and ensure the locks are correctly
taken when looking at the list.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  9 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b71196eaf90e..9caaa0b6d662 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -617,6 +617,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *data)
+{
+	struct thermal_governor *gov;
+	int ret = 0;
+
+	mutex_lock(&thermal_governor_lock);
+	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
+		ret = cb(gov, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *data)
+{
+	struct thermal_cooling_device *cdev;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		ret = cb(cdev, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *data)
+{
+	struct thermal_zone_device *tz;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		ret = cb(tz, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c95689586e19..71d88dac0791 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *);
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *);
+
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *thermal_governor);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1


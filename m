Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4248894
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfFQQPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32965 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbfFQQPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so4299980plo.0;
        Mon, 17 Jun 2019 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8peS1wx9mCHCsJ/G8o4t9CHWs55Os1v5lM45cTTAng=;
        b=Re6ufvestWhEDcyAdz0zYpQxtfPbAWxrp2XbkbQY3QppF5PxEAbjQVAU0eoGqsejbc
         WgaovPfEVEihrFH3tPwtkn3ayuX3dxBsc9zlr09oiViQ3t2uSzM75xBIexCJpdCB4SKR
         lyyzhOw4OXx2M3BQTKkGUY3T7KzuCPqAYMG3mcrbWZC0NNP1JTfXJm90+WNRxtTUlimM
         mPy8boZ63eQ4Th83rjAc+r8i2qUc2rPgojpXxEgoPcGj0SUsJgx+6Wj0IiK2TKPYKk+Z
         n9DDggpKdqbI8V82aJTb/xoz6MoRZTTvQ0DkHkmzkZfJGNgLzjFlkFsgjHb0N6nk9urW
         05nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8peS1wx9mCHCsJ/G8o4t9CHWs55Os1v5lM45cTTAng=;
        b=d5cF+U2CJbDthqXPKdXrimbmCMKRgs2UQcsaU4VkPDHyUoeM2hjjsvcxwKVy0RIRZr
         TChlvyCGfujm0OeZgugqtWZSkghbl0rHPow13k6voSGsbFpuMqCL0lT6oBpMLGsWw1Bx
         W9SnFYavS9TDFHjeiJCZYjGiNNtXz9/0dh6VY1rhTp1QR2UCNgoTDPNiuXa+BGKSkBhS
         imJnSLd8ZcvdJ45TfP/QnqYMa4dGuMpzh/Uu7MHdtnzH6iB6aWg7xqIpJt5ZXq1lQBY4
         0TCMgFPxELhGSFqm7atVnAQqpQ4pkGEL3/cyyNp6ev82R6yLnj9OQoaScbeW6Un9Eltu
         kfSQ==
X-Gm-Message-State: APjAAAVDsfLqY2hl7hx8mej5OAuUMN/Dtk3u6Ig5D16GfsFqlWOY1gro
        ahgepiLBlSgpDChCZ982ed85ZBmvs9Y=
X-Google-Smtp-Source: APXvYqz5DSKbwAy5ZLjRE11izdNBsJdJlwH3P7s8pmkBXl6il3etXUVC14l6+FJG9i0jo+6dm+rxUw==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr1808961plr.185.1560788122818;
        Mon, 17 Jun 2019 09:15:22 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Mon, 17 Jun 2019 09:14:57 -0700
Message-Id: <20190617161458.3754-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
 drivers/thermal/thermal_hwmon.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b24..4e79524182e1 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	kfree(hwmon);
 }
 EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
+
+static void devm_thermal_hwmon_release(struct device *dev, void *res)
+{
+	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
+}
+
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = thermal_add_hwmon_sysfs(tz);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = tz;
+	devres_add(&tz->device, ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index a160b9d62dd0..1a9d65f6a6a8 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_THERMAL_HWMON
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
 static inline int
@@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return 0;
 }
 
+static inline int
+devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
 static inline void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
-- 
2.21.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6968B0693
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfILBfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:35:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfILBfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:35:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so12498133pgj.7;
        Wed, 11 Sep 2019 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0lwGN+LUXDKi5KuFbcc2RGuv/5GribWzP248c589m4=;
        b=AdGmVzVx2MPHq3lSjRZ8BQGsla6vEamT3K1D6aGbaqHu1NqjC+TD4TwE2LSYbVBi9l
         teC8nzxpgN3ANQbrIFnyhTpzkxHIm1Kzq2Ga9x9kshjaotxnyE/l6j9xeJ9fgkNHM+Qp
         tmyLowjmVf+4WmefmJysKNrLRX+CFieoKvAaVGiW20ZGsRJjLjDj1k2wEJ+dzrhLunsi
         4f6a9tfhGEJNA9aXSUec87WePxq9wfY9yPIW8p3I4O/2ouRhz3JcELoJYZJGQeR+MzRG
         QROt7vnzm/QXm5mwVIssiaeEQfKNYP0T8vNID2UE+WeDz7mhytBNX5AQj1RhLtOGhtz2
         cnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0lwGN+LUXDKi5KuFbcc2RGuv/5GribWzP248c589m4=;
        b=U9MFmMS8jdwIEhHJMSeefN1rkoD01ZtyWzhszDnbBgxVpyCqeRckEL8ZztV76bU7HW
         SgrRC0LihbRySkcgDUdRjoGx96Lob5Ij0FW5L+vKr6Vu5RNyuSwF30Q/TJrL3SAubqI2
         53324CKto9K2e74Xq+MdTxcBHb0cixs+Y2iTtwhQMVgV/TQ4SvE1yCKqh1NGZ2hUP6VQ
         Q+QS0qVFy3Ws5Zs8QHudb1R+NBH0odZw+DnQK9+lcbGFalEZSXKyB5X60Betm4ApDEfx
         Pm/nHsfUl0A7JIECyOiehPrP9EtcCIsYVw7ueD1bfXXtWk7q6ztvz4t4NmxQa4Su9sJW
         7/rQ==
X-Gm-Message-State: APjAAAUEqwPcIScUTMc8v84h5+uwgGOApkts9CLGyzTm5hv5DOHjYZN9
        KHkBpziPpimDKbNGCbPT72w=
X-Google-Smtp-Source: APXvYqyZKE1SxukxD5sUaq9u3PxLRoLLHIBTVxWdGAOomEDoAlp0u00YX7nGTruOcfYtoef/yMjUTQ==
X-Received: by 2002:aa7:869a:: with SMTP id d26mr46996259pfo.2.1568252103285;
        Wed, 11 Sep 2019 18:35:03 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:35:02 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Wed, 11 Sep 2019 18:34:46 -0700
Message-Id: <20190912013447.2977-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013447.2977-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <20190912013447.2977-1-andrew.smirnov@gmail.com>
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
index dd5d8ee37928..c8d2620f2e42 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -248,3 +248,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
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


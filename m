Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CE3F194A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Aug 2021 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbhHSMbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbhHSMbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Aug 2021 08:31:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68633C061756
        for <linux-pm@vger.kernel.org>; Thu, 19 Aug 2021 05:30:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15so3751387wmj.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Aug 2021 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQnOV6HhqP7xV2Furr8pq5/wUZ2SXaR/nLHhOafGXkg=;
        b=2M3dXhUfU0qKuKCF87Zz/LV0W9JQ4kD1+H3/waNq+P2Yf+7Rxl8X8TFZGsAZpel+Nn
         UCTQouixJTql6pETsgzdq8mtVxzWEhonECdt4/Xf5v1fUkW0RrD0zrFTZm00qnaz0o26
         lZpjbcc2W0OR4sb1fI7KVj4jUPu+nHdBJ5TN1filcNaxa1ye9u9gnKPjuhGIHBJl/a/L
         GhZP3mHe787LX8EZIe3/vHcSLLHUaMXsV+46+ibrE2V6CU7Y2GC2PfV6WdMK8uhn6ltp
         Kezc7+/+sYCMM2G5ksZC0vXx3G2CEIy42ebH3nmIvdNWSWIho1bcFdzBl5QuwhxGliQK
         twXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQnOV6HhqP7xV2Furr8pq5/wUZ2SXaR/nLHhOafGXkg=;
        b=byE/fpQwjgdXL51HwAtaI59SACDFLC8lAmCaQ5/wi5ThBEuK6et9lLd3juKbaH9eoG
         4Z9wWOhWz7KAgR9gbziHkP246U/+/Oq/OSw0lIBOXDeI98UZZI6dJkTp/ZAD3PDL8nBk
         x6VB2rK9nYTv6kXQMfrsAu3/fjCdhrqIsXL0E54r2nyfeX7dgaum4dD5yFK+0T5tJUED
         gKK5lf/Cx2Ge5ahVTQrOoKIR8YrQPNyh9iDW1P7m0zZ2WAYwdJ4srqlF+t/sd+laU8+9
         wBulf1xRq8EWXWws+qrHtyVfkF2wUza4CHSytqI+ev/ErM991C4gPsG8XQ2vVytbcCju
         X+WA==
X-Gm-Message-State: AOAM530/0r3SONVEewudVPYtk47sB33nHrwvcv2NS15V56+6XizjbKGf
        90H+S2bpwXOsjON/QyYFmar90MZ+a8YDwQ==
X-Google-Smtp-Source: ABdhPJxLoydTz8/ZAOb+nllolXs0SdEtbPQ1+DoQvowXCF1XS0hwyU2vhLvpz1Jrs2HKBUr1Ms9LAQ==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr13535984wmh.21.1629376243984;
        Thu, 19 Aug 2021 05:30:43 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y10sm8146814wmo.18.2021.08.19.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:30:43 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 1/2] thermal: provide a way to get thermal sensor from a device tree node
Date:   Thu, 19 Aug 2021 14:32:14 +0200
Message-Id: <20210819123215.591593-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819123215.591593-1-abailon@baylibre.com>
References: <20210819123215.591593-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to add support of a virtual thermal sensor,
add a way to get a sensor using the device tree node and sensor id.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/thermal_of.c | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h      | 12 ++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6379f26a335f6..4d3b07ceef41a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -82,6 +82,46 @@ struct __thermal_zone {
 	const struct thermal_zone_of_device_ops *ops;
 };
 
+
+static LIST_HEAD(thermal_sensors);
+
+struct thermal_sensor *thermal_of_get_sensor(struct device_node *np, int id)
+{
+	struct thermal_sensor *sensor;
+	list_for_each_entry(sensor, &thermal_sensors, node) {
+		if (sensor->dev->of_node == np && sensor->id == id) {
+			return sensor;
+		}
+	}
+
+	return NULL;
+}
+
+static int thermal_of_register_sensor(struct device *dev, int id,
+				      void *sensor_data,
+				      const struct thermal_zone_of_device_ops *ops)
+{
+
+	struct thermal_sensor *sensor;
+
+	sensor = thermal_of_get_sensor(dev->of_node, id);
+	if (sensor)
+		return 0;
+
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	sensor->dev = dev;
+	sensor->id = id;
+	sensor->sensor_data = sensor_data;
+	sensor->ops = ops;
+
+	list_add(&sensor->node, &thermal_sensors);
+
+	return 0;
+}
+
+
+
+
 /***   DT thermal zone device callbacks   ***/
 
 static int of_thermal_get_temp(struct thermal_zone_device *tz,
@@ -518,6 +558,9 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 			if (!IS_ERR(tzd))
 				thermal_zone_device_enable(tzd);
 
+			/* TODO handle errors */
+			thermal_of_register_sensor(dev, id, data, ops);
+
 			of_node_put(child);
 			goto exit;
 		}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8da5b61070472..3c46b142ebfef 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -104,6 +104,16 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
+struct thermal_sensor {
+	struct device *dev;
+	int id;
+
+	void *sensor_data;
+	const struct thermal_zone_of_device_ops *ops;
+
+	struct list_head node;
+};
+
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
@@ -394,6 +404,8 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
+
+struct thermal_sensor *thermal_of_get_sensor(struct device_node *np, int id);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
-- 
2.31.1


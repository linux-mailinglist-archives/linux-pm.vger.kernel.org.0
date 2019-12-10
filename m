Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E06118DEF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfLJQmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36338 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfLJQm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so98332pll.3;
        Tue, 10 Dec 2019 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0lwGN+LUXDKi5KuFbcc2RGuv/5GribWzP248c589m4=;
        b=VZSJzE9vD8fY8ler14aQN+zwXNhOpwWdw7wwDyGHH0PP48U06fRdhDtZNJBoz4rLy0
         IvzGsmB7KAv+EM7NiV35TniZ9SYrvOqeHa+aKAlhoRlHo/G+LpVpdaBL4wjUCG9Lb4vl
         Yl1M/wh+HU1bmsKKc/dfTkFioiTBQiG0uVVGF6v4WWa/92ymS4RdX/YLqAKm1UDdSx4K
         9ShPmgYrYT9mWayqRlt/WF4Ao5PcMzfH7N8qWCmuokoBmqggQlyDdvbK5vbeHRpM2JD+
         YHl9gFTJK/YoMEbZijuuGE7qOeNehsm5NE62gRE75Dl4gxE+ZM7j0yoMUoeaGGJzq/yb
         w1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0lwGN+LUXDKi5KuFbcc2RGuv/5GribWzP248c589m4=;
        b=H4VXUAuBR46ppmVHaBm0hI/U3MS2gUSmiI441ZyqGR+l5+NMteyPOMKgmWWGqiXojB
         /vGAukRF7v69oqJO38TX4z+dCudK0TdMz14+YN2lqDOL4q+3oYlTeHKDtj6I5aTWRM2q
         nMEV4JKdHha/vx0BiM3F/GPucXs4kkBTgKB81PvAhPZpJzNcPEoEoJFmFZBEAGn5Vt+p
         a7tLNk6Yr3Uuwqu6qsUw8k9W2vgH4lE4I890BgMZt5dI2/xdP3AmK+uysKaJAh6rbgsI
         lIb6DDo/elN+ZWS9NsG8yx3oe9yC5WSnskK+Gzyo3b22Hd0vA5+HFwPm91UkIGwrwPdc
         Ra4g==
X-Gm-Message-State: APjAAAX7pFj48LslBSaVTg8ougTEYuqntIMXiZW3wkwmkklmcHpWyLIr
        YP1tp7xtPEeYQ1qWt0PhRAo=
X-Google-Smtp-Source: APXvYqy3rkbCa2BQ/IHR1Htn/kCvysMrYaozap7ez+/KB9iNEljuIhjVFnpS3CEmhoy8EjDsdQrJhg==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr6481689pju.36.1575996146180;
        Tue, 10 Dec 2019 08:42:26 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:25 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Tue, 10 Dec 2019 08:41:52 -0800
Message-Id: <20191210164153.10463-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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


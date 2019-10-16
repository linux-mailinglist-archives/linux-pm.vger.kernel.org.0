Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2ED9379
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfJPOQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:16:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42319 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbfJPOQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:16:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so24173219lje.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k2u9bLHeCkW2sI7qPqLe3kI1MAwc5YOPhis0jyjf3HU=;
        b=kTu8ZZ17AkTFg7mnu9VxS//jUQYFzfzTnOUPIlKmoQVRKPGwNk8nsvhIV/lCYRe+TK
         mnxL3UZ1WkkCMX25h+o1ifR2W8aj8tCknphOSLlhz3eEBBesRAd2YdFY/1XdCMWN8Wlw
         RH26V4HbbFrisf7keu8XrLlQtxEWZR9vzUVSnhpMRUNijmi+IUn23PcleZYHlZ7fpkRV
         Cyeu4htASVOcoMHmp+zGOwEFj/r6tNYXqwLprQo66Gh5y5D5Om6GpI6TY3Ls7OdDFab6
         oDv4kxfImiafA+f3UmUETw1u2JSRET3TyPni+98dSPio76f9s3iH5VHQaBZua11aC0ma
         0U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k2u9bLHeCkW2sI7qPqLe3kI1MAwc5YOPhis0jyjf3HU=;
        b=un1F9C9QtQ2q+rGLXe3vGS6DPtKpnSjKIA0HbUNgvh+EyAdnpAre1pIzPIcohkcwcm
         ntr+eOT5aByS12wOpx68iQBg+DouL6za9tB3RE8NFYHVQ5hzR7G7yNnI1OO0a+UpYMxo
         i1GjhGSaqy+P7zez+x6knx3x5MnUHbYPeWKPoNTOyygTQraGaB7vSIJw7Bn0KFeL7HWS
         Nv1TKBpTS5L80MdE+d0yVk6EOKRdgrAakYZQvdtmchdVuf5G6wZt3jt3jU6PgwXf0Lgy
         oKOGTCvNXt6EreUFW8xufUHRo/mx9KX1lhWWyuGoQbs1Ku1kYTkyqdJy/5Oarvm5XMZe
         tWbw==
X-Gm-Message-State: APjAAAX9ApSWv6KekjBXUSBrGFIezRJQ2IPgKfIPJ+GhawKouk9cH/DT
        CDSJVVNhNRHGRF42xbBkycJL1w==
X-Google-Smtp-Source: APXvYqwJeoPN8LR96JI35Bi18ipmT0uImkhDRheIHQ7sN2fQZvKHdZ9gR1Za+v4DMcUW0tr3G3KAfg==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr5222844ljc.186.1571235391447;
        Wed, 16 Oct 2019 07:16:31 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id d25sm6501463lfj.15.2019.10.16.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:16:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / core: Cleanup some function definitions in power.h
Date:   Wed, 16 Oct 2019 16:16:27 +0200
Message-Id: <20191016141627.18642-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power.h is a bit messy due to the various existing CONFIG_PM* Kconfig
combinations. However the final section for wakeup_source_sysfs*() can be
moved inside one of the existing sections rather than adding yet another
one, so let's do that to clean up the code a little bit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/power.h | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 39a06a0cfdaa..444f5c169a0b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -117,6 +117,13 @@ static inline bool device_pm_initialized(struct device *dev)
 	return dev->power.in_dpm_list;
 }
 
+/* drivers/base/power/wakeup_stats.c */
+extern int wakeup_source_sysfs_add(struct device *parent,
+				   struct wakeup_source *ws);
+extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
+
+extern int pm_wakeup_source_sysfs_add(struct device *parent);
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline void device_pm_sleep_init(struct device *dev) {}
@@ -141,6 +148,11 @@ static inline bool device_pm_initialized(struct device *dev)
 	return device_is_registered(dev);
 }
 
+static inline int pm_wakeup_source_sysfs_add(struct device *parent)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_PM_SLEEP */
 
 static inline void device_pm_init(struct device *dev)
@@ -149,21 +161,3 @@ static inline void device_pm_init(struct device *dev)
 	device_pm_sleep_init(dev);
 	pm_runtime_init(dev);
 }
-
-#ifdef CONFIG_PM_SLEEP
-
-/* drivers/base/power/wakeup_stats.c */
-extern int wakeup_source_sysfs_add(struct device *parent,
-				   struct wakeup_source *ws);
-extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
-
-extern int pm_wakeup_source_sysfs_add(struct device *parent);
-
-#else /* !CONFIG_PM_SLEEP */
-
-static inline int pm_wakeup_source_sysfs_add(struct device *parent)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PM_SLEEP */
-- 
2.17.1


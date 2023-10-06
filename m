Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC97BBE53
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjJFSFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJFSFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 14:05:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6DECE;
        Fri,  6 Oct 2023 11:05:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c45c45efeeso1439035ad.0;
        Fri, 06 Oct 2023 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615510; x=1697220310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXyPDavHOtQ7HLLH2RqJNaI3/l9BPsuhohNmiySwoOg=;
        b=i9d8EwqHSUuazqB0SGZ4P9g8bUdaE6MJJfcRHLUi/t54gh3XspZS/FsGR8q4gRxnib
         ewLR7ShkwhgX0cRvnm8IEyfD483z8m2HaoD+xp0bdyjAFN7/4PErytq8OxrhM8Ur4R9R
         4tjqiNVttigVYwyvQROGYdpq1zYqu7btsw1cLoo6Pe0gicLC2Al7LAyit2si9o8rHS6a
         5aZ2PK8xbsPrd0SZ8n96BLohokSSvCxiLCmU1iG51U2grNhjX/ZeYBejkepfHPNQZ8cN
         1azewDAuC54p8Rt9qWcu+r1kDxmspcVVQIyLwhqcQYcSDEPP7rZRbGGr7kI4OXJXDULI
         1OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615510; x=1697220310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXyPDavHOtQ7HLLH2RqJNaI3/l9BPsuhohNmiySwoOg=;
        b=EW1gpGgieU/tdvxI92Ra5us2IFh+KnRQiYFMG1Iy54yywXB+GtdwQmKSf8/p1Mvlx2
         9uIrZz5+wsz/gtN5+iRGfxPJi0BDXZ+4gu5CvPj3h0WfQjGG58jDVHLuUqL2tZ3fo5yb
         oeH3EBl+mGA8lkNprXVYLgImpp+mmyCgkTe549/LBZ8uw9yvXDVaVV3xmLfZmW0ayfNq
         LM8rP9TYuwDhxDz96iQ6Cr0litToySsy/ublyWjZqV2KARjb0VTb65qQaznVXxoEKYie
         womEyC/sUsHz80QPMIjIDvR6GlamYEz5aRambRze/zsR2QgNytKSknEFwUw/5/32PX27
         uB0w==
X-Gm-Message-State: AOJu0YyKb/4M9MLM63BzLCiRLStmlAebsDm202CTCANRSR7D2oau6pQL
        1l0C5oLJczB+/SJ1Iv24w2w=
X-Google-Smtp-Source: AGHT+IG+WP0v8GL/FBPzLrUdKaQ7CC6xmIrILrkXK15KSSjE3UfRZRRlK4drATBHwMiY8mudNTpvUA==
X-Received: by 2002:a17:902:e5d2:b0:1c4:1cd3:8062 with SMTP id u18-20020a170902e5d200b001c41cd38062mr9522994plf.2.1696615509539;
        Fri, 06 Oct 2023 11:05:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d018:9da6:2e69:1658])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001bb1f0605b2sm4165355plt.214.2023.10.06.11.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:05:09 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v10 3/4] reboot: Introduce thermal_zone_device_critical_reboot()
Date:   Fri,  6 Oct 2023 15:04:52 -0300
Message-Id: <20231006180453.2903342-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006180453.2903342-1-festevam@gmail.com>
References: <20231006180453.2903342-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Introduce thermal_zone_device_critical_reboot() to trigger an
emergency reboot.

It is a counterpart of thermal_zone_device_critical() with the
difference that it will force a reboot instead of shutdown.

The motivation for doing this is to allow the thermal subystem
to trigger a reboot when the temperature reaches the critical
temperature.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v9:
- Make it smaller after introducing the previous patch. (Daniel)
 drivers/thermal/thermal_core.c |  7 +++++++
 include/linux/reboot.h         |  5 +++++
 include/linux/thermal.h        |  1 +
 kernel/reboot.c                | 27 ++++++++++++++++-----------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3184e9f2eadd..b92795529a53 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -326,6 +326,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
+	else
+		hw_protection_reboot(msg, poweroff_delay_ms);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
@@ -334,6 +336,11 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_halt(tz, false);
+}
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, int trip_temp, enum thermal_trip_type trip_type)
 {
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 4586c663884e..abcdde4df697 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -179,6 +179,11 @@ extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
 
+static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, false);
+}
+
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
 	__hw_protection_shutdown(reason, ms_until_forced, true);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6710a4ace992..a026ce390a87 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -361,6 +361,7 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b236c4c06bb3..7bc01b38629a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -957,19 +957,22 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * __hw_protection_shutdown - Trigger an emergency system poweroff
+ * __hw_protection_shutdown - Trigger an emergency system shutdown or reboot
  *
- * @reason:		Reason of emergency shutdown to be printed.
- * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
- *			forced shudown. Negative value disables the forced
- *			shutdown.
+ * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
+ *			triggering it. Negative value disables the forced
+ *			shutdown or reboot.
+ * @shutdown:		If true, indicates that a shutdown will happen
+ *			after the critical tempeature is reached.
+ *			If false, indicates that a reboot will happen
+ *			after the critical tempeature is reached.
  *
- * Initiate an emergency system shutdown in order to protect hardware from
- * further damage. Usage examples include a thermal protection or a voltage or
- * current regulator failures.
- * NOTE: The request is ignored if protection shutdown is already pending even
- * if the previous request has given a large timeout for forced shutdown.
- * Can be called from any context.
+ * Initiate an emergency system shutdown or reboot in order to protect
+ * hardware from further damage. Usage examples include a thermal protection.
+ * NOTE: The request is ignored if protection shutdown or reboot is already
+ * pending even if the previous request has given a large timeout for forced
+ * shutdown/reboot.
  */
 void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
@@ -988,6 +991,8 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
 	hw_failure_emergency_poweroff(ms_until_forced);
 	if (shutdown)
 		orderly_poweroff(true);
+	else
+		orderly_reboot();
 }
 
 static int __init reboot_setup(char *str)
-- 
2.34.1


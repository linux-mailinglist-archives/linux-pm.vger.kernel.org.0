Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298357F064E
	for <lists+linux-pm@lfdr.de>; Sun, 19 Nov 2023 14:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjKSNGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Nov 2023 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKSNGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Nov 2023 08:06:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB18B9;
        Sun, 19 Nov 2023 05:06:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce6059c2bbso3643675ad.1;
        Sun, 19 Nov 2023 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399164; x=1701003964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGau2wnG9D3Hr8rRxRGVzQVzsLMJnulDUCmg/9Pyeu8=;
        b=fzSyBjPzzcswTNK4Wp6LfMGwj6SKoSuMUy+8Navza01JwJq+SppYUw9mmCKMNn+0mD
         K8wSUZVUqRWLJNimcDfS5IW6SwhHdNVZHWjJHjc4B8mySpvmvrqiI0OnDTC0/lS46qfZ
         eW/N24XHiTtYQqLR4SZVVhllbPUZGkKyZpxAhqc1SiA2qH/tBUuePL00dr+EJRG1yRb8
         AWK06StYADGXaAxajws3wYkno2hz/VTnswnxjZIFJHXIGrUs738ydCbrRHlFbO+jiNdw
         hCGNi/n3x90Y5WVw4K80qL453lO4/2Iuf0/a0gJ2Ot3zOWWorR8wNGb39SLm7v15+Q6f
         W9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399164; x=1701003964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGau2wnG9D3Hr8rRxRGVzQVzsLMJnulDUCmg/9Pyeu8=;
        b=kr37/8ap6OY9yQNNtKrMvHARblAPIXOFRJAww94SqVbopIgckfY5cfhEG+lgtzuGGe
         WjUTn8RRJzSpYrZ/5dP7tJKJiKcMtHByUQILheCEzRuzQjQnXtaXZ31dCfCAWzBqtO34
         NR2on7JlO91dKowlnYdlYMz90amfNzRWAZMRz9qv95qZlg+7uhnXGr7QDexVWUEoU9uk
         /+MhS3X+VilpC4LZeiXHpBtGAicbeWQ88LCC3ouhlGJAUx2pnRi2TplszJrWZUAoJABF
         pzx6kDNFTLeRuSzT72UExCzn0xiQ37OMkbTeIiAS6K5sD7spvsM3rH2gbG4TM0lidu3J
         YWjA==
X-Gm-Message-State: AOJu0YyKyNcBY3mMBGK0B7txaL2wTQRBaU7V+q7y/0RK33JzTb7A96H7
        iF7iNLivcL/lokKd5EKQyEA=
X-Google-Smtp-Source: AGHT+IE2SBSpeJ/QiT6SvHEh/U2Ku9PmI27Y8HMoM9t35Tz8ZawkpZ7SFrFXpzH+gBXAr6hkk9lbmg==
X-Received: by 2002:a17:902:e892:b0:1ce:5b6e:bad8 with SMTP id w18-20020a170902e89200b001ce5b6ebad8mr6527572plg.6.1700399164073;
        Sun, 19 Nov 2023 05:06:04 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8afe:6d39:e955:7d2a])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b001bde65894c8sm4433696plb.268.2023.11.19.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:06:03 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, mazziesaccount@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v11 3/4] reboot: Introduce thermal_zone_device_critical_reboot()
Date:   Sun, 19 Nov 2023 10:05:50 -0300
Message-Id: <20231119130551.2416869-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119130551.2416869-1-festevam@gmail.com>
References: <20231119130551.2416869-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v10:
- Rebased against 6.7-rc1 and fixed a conflict.

 drivers/thermal/thermal_core.c |  7 +++++++
 include/linux/reboot.h         |  5 +++++
 include/linux/thermal.h        |  1 +
 kernel/reboot.c                | 27 ++++++++++++++++-----------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8c808ff9ddfe..1c735f858e50 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -327,6 +327,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
+	else
+		hw_protection_reboot(msg, poweroff_delay_ms);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
@@ -335,6 +337,11 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_halt(tz, false);
+}
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip)
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
index cee814d5d1ac..3644326b18ac 100644
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
index 07eb6537ed8b..f76814037f41 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -970,19 +970,22 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
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
@@ -1001,6 +1004,8 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
 	hw_failure_emergency_poweroff(ms_until_forced);
 	if (shutdown)
 		orderly_poweroff(true);
+	else
+		orderly_reboot();
 }
 
 static int __init reboot_setup(char *str)
-- 
2.34.1


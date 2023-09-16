Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0F7A2D24
	for <lists+linux-pm@lfdr.de>; Sat, 16 Sep 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjIPBuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 21:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjIPBtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 21:49:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8B1FCE;
        Fri, 15 Sep 2023 18:49:44 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a9e89fa553so527921b6e.1;
        Fri, 15 Sep 2023 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694828984; x=1695433784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xdcSFdFjeAbW57aqe8jzF0wIE2taB5ecDehO1YAVcs=;
        b=a/z6nbIo0jyWSUtD3XSc77MP1yvYjbTNc821TSFyeky2W2LyERR0hc4nOBHRW1pD4q
         awLNNZ2KNKs3CC27OeJCZz30WzheHxW7DUQ/YmonQ2bbNWnBOp/jw/J/FKI3jyP1UrVL
         XfgYOr7qjyTRVHBiYMHf30HwlRV0WaytPy7k6ZCQ9qe2Sy8Ry2oZiKfK/Tejsg/TU5YW
         GHDG3tgVeSRbs7e4lpRXtU5JDArT6riSBtm1qQ1UCUUF5aDf2D+B6aTlwAKOqKfTf5Jf
         14bscC2fbJPupni2r32xXq01iXabc/lGEOrDeRxrXLpRgYVqdqxMnuw0TDnHNGuGmTEG
         eGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828984; x=1695433784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xdcSFdFjeAbW57aqe8jzF0wIE2taB5ecDehO1YAVcs=;
        b=mf2UbyFtTmjljqEBeSnxKi+don8B+4NP+p4O6m/nS6c8E58iidRt5DU0Vs3D2bshgp
         7OFE+L/4Ib8HAyMgORl8mCcpTWh+IPKZcwXSDIXNCdiVuoibOf7VHtB9Tu0ij2lvY4qs
         MWGwE1VKgg81VdS9Ggcp/g66mAaQncF03xmoIc9lMGquypAjjxp/zBy83+7hH7ZQtzpo
         Ecgiu1SxWL1fs5uXNUEDnFDbl9Re0DqgunIZ7RZyMJC/XPrV775kOqvl3MUx+ZRtlRgo
         8M+P+yN1Hdy9nY0HeVdlB8r3wkt9G7ZqUjndTfx2TZZoM/26RY1QAcKvK45tkvIEk9+k
         V8/g==
X-Gm-Message-State: AOJu0YyNDl3HHIXKh7hTGcCb8iX8cuQ99a38mmkrx8lnEWst7ckSbcp0
        YMaeRC26CYSBMdAQ5Jt14hM=
X-Google-Smtp-Source: AGHT+IFCWamhKPSBEyZDPSdvLAZn5P1ZKmoTuUrZJBzRgjKBTieVSoAFrMqcauLw9KsBrUGDAIkAEA==
X-Received: by 2002:a05:6870:9596:b0:1a7:f79c:2fbc with SMTP id k22-20020a056870959600b001a7f79c2fbcmr3427334oao.0.1694828983639;
        Fri, 15 Sep 2023 18:49:43 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bb17:c38c:aa6:be85])
        by smtp.gmail.com with ESMTPSA id eg38-20020a05687098a600b001c4b473581fsm2519986oab.12.2023.09.15.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:49:43 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v8 2/3] reboot: Introduce hw_protection_reboot()
Date:   Fri, 15 Sep 2023 22:49:27 -0300
Message-Id: <20230916014928.2848737-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916014928.2848737-1-festevam@gmail.com>
References: <20230916014928.2848737-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Introduce hw_protection_reboot() to trigger an emergency reboot.

It is a counterpart of hw_protection_shutdown() with the difference
that it will force a reboot instead of shutdown.

The motivation for doing this is to allow the thermal subystem
to trigger a reboot when the temperature reaches the critical
temperature.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v7:
- None

 include/linux/reboot.h | 11 ++++++++++-
 kernel/reboot.c        | 33 ++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 2b6bb593be5b..b6d59c7a3377 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -174,7 +174,16 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
-void hw_protection_shutdown(const char *reason, int ms_until_forced);
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
+static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, false);
+}
+
+static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, true);
+}
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..76fa6e9e4f1d 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -953,21 +953,25 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * hw_protection_shutdown - Trigger an emergency system poweroff
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
+ * Initiate an emergency system shutdown or reboot in order to protect
+ * hardware from further damage. Usage examples include a thermal protection.
+ * NOTE: The request is ignored if protection shutdown or reboot is already
+ * pending even if the previous request has given a large timeout for forced
+ * shutdown/reboot.
  * Can be called from any context.
  */
-void hw_protection_shutdown(const char *reason, int ms_until_forced)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -982,9 +986,12 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 * orderly_poweroff failure
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
-	orderly_poweroff(true);
+	if (shutdown)
+		orderly_poweroff(true);
+	else
+		orderly_reboot();
 }
-EXPORT_SYMBOL_GPL(hw_protection_shutdown);
+EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
 
 static int __init reboot_setup(char *str)
 {
-- 
2.34.1


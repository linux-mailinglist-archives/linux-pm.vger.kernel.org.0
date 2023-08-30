Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842EB78DA78
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbjH3SgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbjH3PTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:19:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB761A2;
        Wed, 30 Aug 2023 08:19:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bb1133b063so690304a34.1;
        Wed, 30 Aug 2023 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408766; x=1694013566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuULaM8fl5rgdaoQC5loZ8/I8f+dfEz9yTwKKo4bS2Q=;
        b=W6RSFnNcMIW4cQKY8X8V2WHPmEsU7Vb3n/7cehpL1M5rqu2snC5I+F3KMe8LrY14rk
         SudTHtLYmM/F4qoEEeygku3NARWiq5aSy9FN9QWuH7hUyIoX5ceqGXg9+KoQXGpz5G+0
         f3CE2BrlgftXBtlZCsj2mg0YEcZhU3RsWBqaex1qVlx/W8nhTb28jJi+kO8KkCzTqeUU
         2h0Yk51s3kUAmWqp0V9m6fIcNqDTq124jsGPXhyL5JefQTPtxbBABMVU8d8cV/C1ZTiG
         vPI0ilcsrlrkFrD1M+ZLCmiOV7AIRiSXMx+dPrwB1erHiDybpNd0HBJnU/nIuPIu+A9S
         xxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408766; x=1694013566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuULaM8fl5rgdaoQC5loZ8/I8f+dfEz9yTwKKo4bS2Q=;
        b=UepE6mPE/hMVHHV7gZYOSi6mooI7Rb/7bka+TFCF86HzBrBDQJLleez761cE5/o7XF
         ZoVOtaAehswLQ3E8joQwSpldxB4rkO+owkQtHFGg3OSzzWLQVYNvjoDR5NvOPaHoNNXq
         JYJO4TdMzLVHqgyOUf0gmGqL46ZDvavfLJYwKC4gHaXQY6cCr5EEJWuKOwZJtDlJoPk2
         PKNVAydIHUp+U/hN/7yKnAAGEgbO79DPC+g7oWNfVtHZzB5NYpYUOJQwe1eoBFVVK/Cf
         9ZYwLuX0KPncp7//IWWf7MAZLQ2dHQO03gc+LNDtDlipQV9YZ6FoQyTTxHjR6fDr5Vhs
         DA1A==
X-Gm-Message-State: AOJu0YzbpMIjV6sglPvLBYK20pLyH+IduxEIO4GeMSA+MLl8gL2tUvmn
        r3vc+j2f5tDRtCONhXe8K2rWkwEVpkE=
X-Google-Smtp-Source: AGHT+IGbNgDVOBZmN2rq+L5s//Uzmuy47sRexeR34lp+8YPHNP8poEkNYCrU0n5OhYqd79zlXYhuXg==
X-Received: by 2002:a05:6830:6702:b0:6bc:a6d0:ab7 with SMTP id cr2-20020a056830670200b006bca6d00ab7mr3451514otb.3.1693408766600;
        Wed, 30 Aug 2023 08:19:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5158:34be:358c:6304])
        by smtp.gmail.com with ESMTPSA id d24-20020a056830139800b006b884bbb4f3sm5672559otq.26.2023.08.30.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:19:26 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v6 2/3] reboot: Introduce hw_protection_reboot()
Date:   Wed, 30 Aug 2023 12:19:07 -0300
Message-Id: <20230830151908.2149847-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830151908.2149847-1-festevam@gmail.com>
References: <20230830151908.2149847-1-festevam@gmail.com>
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
Changes since v5:
- Avoid duplication by making __hw_protection_shutdown() to have
a new parameter to decide between shutdown versus reboot. (Rafael)

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


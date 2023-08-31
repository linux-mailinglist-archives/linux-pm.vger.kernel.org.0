Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABF78EE04
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346316AbjHaNDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbjHaNC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 09:02:59 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF4E49;
        Thu, 31 Aug 2023 06:02:55 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c4f8aa690cso54687fac.1;
        Thu, 31 Aug 2023 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486975; x=1694091775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjiM0hE7UYPJ02iVkLiAIo7jZMCiroGK59XnT6VStsQ=;
        b=NrmkslorUoaVwWnICNt84/VtI7QaqysoUvGJ1ePmqFb2/l+Svvm/BRgJhztG1T4dMQ
         BjPpYvmUREpNnWXP5nTWv/8juO3DOWKmm9Xr4MlwqKD+EibxoMmbUb3NkCkVmR61NVzP
         5v/WvejdDG3uIIQTgVbp8DVY7gpVbJ3HFNLxmf8aAFOHZl8SWtpE8YLxbHORvtxtpILl
         SXCEa+zdCpKF/Gushw9WDYD/iY3EDnL/k0yGE4cXZtXv1iiwYPkb0XGyOkTbunR0M7mK
         /SdTHVOR7IL2O6AwcOcOhsQho+R/W+weZvF2WRqNBsjroYVtb3MW7KQ9wO5y81GkkUwl
         7k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486975; x=1694091775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjiM0hE7UYPJ02iVkLiAIo7jZMCiroGK59XnT6VStsQ=;
        b=OYetrwmzCdJ4hp6EcVGZymJLRkFGtTS2+fykvJJRHv87HyWbKtTKCcsPUi3bb2VUfb
         j3sdTWISHZBKBDX3J9GbZiI3NFNAS9wr3PmnO/niWRDGJLynjaQauAqMyoAiQaPA1DeI
         w6YKWsf7cHE5Kn6AqgyOBM4LVb4yTB8wY6GFQ6wpD9XUbuDuR2P/g7rK36qtINQgDJdF
         UoNbPGmdsOGZJdhC+HHXN/GzAL3abqaHJsGjWEDLwkSHoXMYemrZQtk+iioDotm2I2T9
         V4tzCpqJ8fRRQ0Niv0nkT7DXNkMxi+k5sy3arie8x+byxih2ySPsqG3oRMaknypj7gTp
         mCqQ==
X-Gm-Message-State: AOJu0Yxxe8KEXYB6M1jwr0ce+rKfgMt/B+2hQ4xhcqlUiSkeZBiEuum8
        s5BsKtFHiYiqUx2xL/CGuzo=
X-Google-Smtp-Source: AGHT+IFlWVfvv/z3eWKApgEDr2JvB1XUHQU+jO67pf71eZpYAVdHbiB+yDnwOBIwvQXjS4QIb9eZow==
X-Received: by 2002:a05:6870:2198:b0:192:6fce:d3be with SMTP id l24-20020a056870219800b001926fced3bemr6383289oae.1.1693486974690;
        Thu, 31 Aug 2023 06:02:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:583a:68ca:f232:6448])
        by smtp.gmail.com with ESMTPSA id zh26-20020a0568716b9a00b001bfd65998aesm802155oab.58.2023.08.31.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:02:54 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v7 2/3] reboot: Introduce hw_protection_reboot()
Date:   Thu, 31 Aug 2023 10:02:41 -0300
Message-Id: <20230831130242.2290502-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831130242.2290502-1-festevam@gmail.com>
References: <20230831130242.2290502-1-festevam@gmail.com>
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
Changes since v6:
- None.

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


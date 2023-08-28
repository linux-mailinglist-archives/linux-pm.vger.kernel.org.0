Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C325578B8F3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjH1UAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjH1UAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 16:00:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBBFCC6;
        Mon, 28 Aug 2023 12:59:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a88b1e18f2so375125b6e.0;
        Mon, 28 Aug 2023 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693252776; x=1693857576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uusCkjysh/AWlACw3hz3AZGWKR8hyQooItcfr6OYtE=;
        b=RwUICWutMxoFD5F9l7TFpPCuX27np4Awc2zvuZHTIS/zXHQ2V2Y0Dovw3AYtCbcrfW
         ke4Y04GU35bo9y5TmHsIVErEWGDAafOx9E8RdM0vTW4KfdehQHzkkUKod18oV1A3wG85
         viV4aQK+ZXE3bMOfvWJ0V14b/Gc5qmLYZBPKoW6gP6daRy2vqMWXGfS49SE0wYtjFNAD
         9uGgvBMAga8pwrNuaAsiDHRDiWdReqDPD+2Hdl88vBz+ZOsySWXSOP2vI8swtOqh1hDl
         63qEV9yQAtm4qkCshHOCnoCwTW+WhDfbm5VBqDabcJwhIF4BzAqs58EaAUA4mHI2MCqI
         Lzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252776; x=1693857576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uusCkjysh/AWlACw3hz3AZGWKR8hyQooItcfr6OYtE=;
        b=NN8oturM82KIWwCAaY7tXm1wN+iSbmXUJZ1qD/3GXpHI13CKOfFMj3H5zPT6sDzw+J
         rLwu+kmKT6YpjGQszZNiUI5rR+SkPMcTK7Ar5Ok/ls5Czlzp6mghHHetQfuaokk/TEPI
         NaEf0Osh06Dgxl6KR5vVANhtNSDpmrOBbyTfrAqbetHlRC41Lh3PD1hVHKJKNadRIQ7G
         mDc1rVptYc+TLHk9QHZrqcz7qdngEgwFdezzyHWBHFXSL9M0nlVmVmvMSedPYKiSStAb
         z+pivAN1hFq9PRQ2a8NSllrfRj6XULKVO+4RDhMxNiAQqeCEXuAbaAaOqFKT6u8M/wgO
         VDhQ==
X-Gm-Message-State: AOJu0YxG449t64BW9TW0N9ccMXSgLkF56jhdGaXtmHNH4uvegYWraqGd
        quugmTFSc7zdYb1dpJ8VKrY=
X-Google-Smtp-Source: AGHT+IE4q8i2r5ispwNleag74zJQEZfnsyLE5ldHdxwY+lORwPvmF8qc6REXfqBuoGQ/3kzDShWbdA==
X-Received: by 2002:a05:6808:1599:b0:3a8:7446:7aba with SMTP id t25-20020a056808159900b003a874467abamr19596256oiw.5.1693252776235;
        Mon, 28 Aug 2023 12:59:36 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id k24-20020a544698000000b003a9a2362f66sm2254341oic.16.2023.08.28.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:59:35 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 2/3] reboot: Introduce hw_protection_reboot()
Date:   Mon, 28 Aug 2023 16:59:01 -0300
Message-Id: <20230828195902.1645169-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828195902.1645169-1-festevam@gmail.com>
References: <20230828195902.1645169-1-festevam@gmail.com>
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

Introduce hw_protection_reboot() to trigger an emergency reboot.

It is a counterpart of hw_protection_shutdown() with the difference
that it will force a reboot instead of shutdown.

The motivation for doing this is to allow the thermal subystem
to trigger a reboot when the temperature reaches the critical
temperature.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- None

 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 2b6bb593be5b..4a319bc24f6a 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -174,6 +174,7 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
+void hw_protection_reboot(const char *reason, int ms_until_forced);
 void hw_protection_shutdown(const char *reason, int ms_until_forced);
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..05333ae8bc6b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -952,6 +952,40 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 			      msecs_to_jiffies(poweroff_delay_ms));
 }
 
+/**
+ * hw_protection_reboot - Trigger an emergency system reboot
+ *
+ * @reason:		Reason of emergency reboot to be printed.
+ * @ms_until_forced:	Time to wait for orderly reboot before tiggering a
+ *			forced reboot. Negative value disables the forced
+ *			reboot.
+ *
+ * Initiate an emergency system reboot in order to protect hardware from
+ * further damage. Usage examples include a thermal protection.
+ *
+ * NOTE: The request is ignored if protection reboot is already pending even
+ * if the previous request has given a large timeout for forced reboot.
+ * Can be called from any context.
+ */
+void hw_protection_reboot(const char *reason, int ms_until_forced)
+{
+	static atomic_t allow_proceed = ATOMIC_INIT(1);
+
+	pr_emerg("HARDWARE PROTECTION reboot (%s)\n", reason);
+
+	/* Reboot should be initiated only once. */
+	if (!atomic_dec_and_test(&allow_proceed))
+		return;
+
+	/*
+	 * Queue a backup emergency reboot in the event of
+	 * orderly_reboot failure
+	 */
+	hw_failure_emergency_poweroff(ms_until_forced);
+	orderly_reboot();
+}
+EXPORT_SYMBOL_GPL(hw_protection_reboot);
+
 /**
  * hw_protection_shutdown - Trigger an emergency system poweroff
  *
-- 
2.34.1


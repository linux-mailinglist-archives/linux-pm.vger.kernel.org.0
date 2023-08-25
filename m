Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E317884E6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbjHYK0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbjHYK0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 06:26:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2C19A0;
        Fri, 25 Aug 2023 03:26:01 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bc57401cb9so113983a34.0;
        Fri, 25 Aug 2023 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959160; x=1693563960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLr5gK3Lt46knsg3WNaCXteFlAoEoVQYH/7az4C+2/c=;
        b=qsdKwZRbm3hkdgX6kSfwJ0zI1Xc2UQOzpf5hgfvFh/OG9Z5Xv5RY27B1MUi8rDdglt
         C1C9bkHOR/jlPOjy1oDaiXFacGrM8StXyGTzAWZBMOeM/DKz/P+HvmiagcYtbBCcULBb
         Sp4zdQ/4AubMNSiFybmN9PxJk7JvGpXK3SQrs/dut6L+/zIDPGzD2WsYC3y2heswXYUG
         j4EgOCsrC3KxTmcUrG6qFOidPm0FZlqf/YdOZDVHdZehIr4Z7HjdImpa4B0z+fOl6fLZ
         ciSz2ri9HlZ4tuSGGe/EXmoexNzmrmccywrP5ynFTt3/PiXThycatpMORTnty3aQdKIp
         jEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959160; x=1693563960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLr5gK3Lt46knsg3WNaCXteFlAoEoVQYH/7az4C+2/c=;
        b=LGtzZ+AK+wTiDKSmRnWizMTTnSp6H1ynouTNuKVAcwYHl+f+9YgUsekp68FmI7rG+L
         jklz1U1jYk3R2+RntvHWeqVuvjc4W7EgGXFzOzHY5eVsK8FKB6q8Vb++domtQ/GtfsEK
         //b1gEaT6QIsZe6aCFSpOuymbO1KNGU92I/wbDnCw7L42qXAznjRYvX87GlUYDsB9mOF
         Ohlg/mCTdl8kqOwtukAdEqGsepp0/Xiny0Xi1epMqGGvt6p9fPLPEnw7wuUCO8Fv17O/
         Gtt3vcoBjYF1EotZwWFZdcW8OAxcP9Wrt3yHW0QXez/M5iXKNb+C3JGe90BfbjU0tHOg
         6PbQ==
X-Gm-Message-State: AOJu0YxNNGyhaxW2YrsW4VY1G0dyCewO8tRyqrovabppEpHtp5RgSBN8
        kQ53RWxvEmYZ9OkByNa1mlE=
X-Google-Smtp-Source: AGHT+IHW/+GUt9rsqBDwf3dvc4xtAyQgSgmNc8mOvgp5o+7JqJR+Xtyw1Y8aLU2OR796fXy4RXgDag==
X-Received: by 2002:a05:6870:ecab:b0:1c8:bbd0:2fd5 with SMTP id eo43-20020a056870ecab00b001c8bbd02fd5mr22645989oab.4.1692959160592;
        Fri, 25 Aug 2023 03:26:00 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3d89:37d3:ba11:1a82])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b001bf3942ea12sm835916oab.1.2023.08.25.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:26:00 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/4] reboot: Introduce hw_protection_reboot()
Date:   Fri, 25 Aug 2023 07:24:52 -0300
Message-Id: <20230825102453.836627-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102453.836627-1-festevam@gmail.com>
References: <20230825102453.836627-1-festevam@gmail.com>
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
index 3bba88c7ffc6..64517d1e4c55 100644
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


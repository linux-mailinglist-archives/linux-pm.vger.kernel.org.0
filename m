Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D678B2C5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjH1OOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjH1OOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 10:14:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD0E7;
        Mon, 28 Aug 2023 07:14:15 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c134602a55so651791fac.1;
        Mon, 28 Aug 2023 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232055; x=1693836855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/y/OzGht6uESn/2y+kml2L9EOpmzM5vaL1ZN2yoFwo=;
        b=jw3RgLfCpPX5dRMkXX5b4sSdkK4s5HaEZfTlQmSGfzASFHDCkKp8x29FB4oS6HXMGl
         jE1TAUt723+APcpkVlCFDxss3qEbS7gsgCPHOUDXkqj108kn0kH+6QZLFEgCPcKpOPF6
         ilAnaFbzbYUnzORaKvfsroGwXSLZO0qGrso4fEWWn8gCAsZYnmzPpeR2tDT/P7ybgnBL
         +liHIlxAh+g8u7jfZu6ugAiu8k/aPM0crVNzIblOwX3NIEJystRJtEwORY34L+WAD52D
         Ykpei2+AWbxX9m3pTYxXUtANtjXTThigZ0ZVJlWS0uRn28s3mLviVA8Z6p4FhA4ymFNu
         4lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232055; x=1693836855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/y/OzGht6uESn/2y+kml2L9EOpmzM5vaL1ZN2yoFwo=;
        b=Rv1Tsf9FQRpOdcsSxSDgW+7VtTpoArLr104hOn7gGuonVpG1UfDE1rmYBfseFGUw5M
         O+wZvNxDzDIdryLO77NdohFmcMoM8cRDTRFNQvBOKUOkxg6ri6zHlPTVBfH2szmVsDuV
         y1lNmAWGZWcqb3rld1eaQvXhOPNIgzaMoBcpaRxzzHVz03iUP9MsdFhIZ04BqD+PRiQd
         v1WVd0aQBwMoSD/xlUmkfaeFCzfqP3PvMOCFdw+TNQixuhX61tueJO8cOy+p07K0wmsN
         jvqxxcVdKNbkk8fezRtWtMX0wvykQg9Wy7CvQ+ceXg5RZnMjliENKH0l5xl1HGI+KOQ8
         NZLQ==
X-Gm-Message-State: AOJu0YyvrPZccyS61OHM9igH7516j6ynBRl1q/K5JKVxq6V3n+NKmdtC
        DTVS1h0imXF/3Uf6vWeN+UM=
X-Google-Smtp-Source: AGHT+IHglFtV417hZYXfWoZR1GwzLic9Cb8ps9koJ0Sivvi9nfcZM6uCmgTI7wh1uyvxSNxZlK+4vg==
X-Received: by 2002:a05:6870:6124:b0:1b7:5e47:5b75 with SMTP id s36-20020a056870612400b001b75e475b75mr28734986oae.4.1693232055060;
        Mon, 28 Aug 2023 07:14:15 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id l5-20020a056870e90500b001c4ede43955sm4323892oan.31.2023.08.28.07.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:14:14 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/3] reboot: Introduce hw_protection_reboot()
Date:   Mon, 28 Aug 2023 11:13:40 -0300
Message-Id: <20230828141341.1583591-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828141341.1583591-1-festevam@gmail.com>
References: <20230828141341.1583591-1-festevam@gmail.com>
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
Changes since v1:
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


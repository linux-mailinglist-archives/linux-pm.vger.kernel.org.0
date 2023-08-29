Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA878CD1C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjH2TmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjH2TmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 15:42:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DDCC;
        Tue, 29 Aug 2023 12:42:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca018afe8so1224683a34.0;
        Tue, 29 Aug 2023 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338130; x=1693942930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLNBwMKv5VU8YZb3FI/dbw928xvMZfMLOw7sqi25S4g=;
        b=jVBrhGpCR5kfWJpouCM/w58qlTICxVdObSuxrxg9gX+zeuHH8ybbfUNwz09X49PfId
         vAcjhobVB+waaoh1RqJF1ZRDsaKQrctm7d9aieuS0PT5K7R1lwP9tttIHGiUZkCnDF0h
         fyX7nUFuVMRiTprrgk48MQ4SX+7j/FK823ZVDuNbqJQtKZrRc3o1D8UfEXm8mOeDHG0X
         DzP81j5xtVn6jo+KIeW0mVAoxoZFzmwHcNuIDZ6xpP8RB5ztIwrSq6Hg/GBE5tLiDGoz
         J/nyUX8kGLwZgG+AGjtroF3Pcuy9BQIxRfxig+n2+49oaH9rRlCbi3qfInCP9baNe9i9
         TZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338130; x=1693942930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLNBwMKv5VU8YZb3FI/dbw928xvMZfMLOw7sqi25S4g=;
        b=A17cTBABQiTfyDsurtR3W6QfRi6OKnZeb9aY1DPtSK9bGpFMPo7LR0GO12kqQ7yWRi
         LeWpnS3lEWnEDATtrvpM+hIdmqNylZTgRMG5MipQ0rXujnRuYpNZm465JrInDyZ0FQ20
         YG4BTal39dsM+cgLcSTG48TZCE63uzYc20ISPLV2QaYaXCvM0J4kL9KvrWhoLNJXgUev
         40b1a3c8BgAK24ZOU+X//moTAeu4fG+fymUcPDYH2eIFlAJqlpGW3nkpmrnuRkAxi3jv
         GiX6EI+n2nKTuoF6bACcB7U22xHeXyl2h1yki8INxqttoXQHrX7iImOo8loHZwT5mOqX
         9yAw==
X-Gm-Message-State: AOJu0YxRfIVVhTEVSOVy5xLT0v2Mq8vHkA/Ql7ugnO4xD7BEIWF6xN7P
        H+xJdl46Dyp+FNruMi62ZtM=
X-Google-Smtp-Source: AGHT+IEW1DfCl+fssuhVpfvEM/oibGLC5msOljLh8oV3hTrEg7N3c0mle5PwQjNFooDNjmrWkzJOaA==
X-Received: by 2002:a05:6830:460b:b0:6be:ed61:a4a8 with SMTP id ba11-20020a056830460b00b006beed61a4a8mr111777otb.2.1693338130500;
        Tue, 29 Aug 2023 12:42:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d7855000000b006b9848f8aa7sm4905457otm.45.2023.08.29.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:42:10 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v5 2/3] reboot: Introduce hw_protection_reboot()
Date:   Tue, 29 Aug 2023 16:41:59 -0300
Message-Id: <20230829194200.1901988-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829194200.1901988-1-festevam@gmail.com>
References: <20230829194200.1901988-1-festevam@gmail.com>
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
Changes since v4:
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


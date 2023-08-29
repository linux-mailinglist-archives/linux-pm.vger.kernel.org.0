Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83378C3DD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjH2MKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjH2MJn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 08:09:43 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F241AB;
        Tue, 29 Aug 2023 05:09:41 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso912697fac.0;
        Tue, 29 Aug 2023 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693310980; x=1693915780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzUUjWIr8T0FZIbu34J9BGxTroSGsDdkY4ko+SJQrnc=;
        b=A1pUETre5tdg0G0mCkuEDmy4RXfXoVCiPK8BP9Zk2ScIjVEg0wHFccq4IvvHXZzjcH
         TMeSXa7o1SoGYvzjS3aBjI902WCfI/PTtZ2cNHUR1o8vfXTzqKslGQaUEg/hO1cc0v3i
         ja0z+ev7TWav+syWR7HIYDzoQ5lF4S8xovd/jySoy4md02TwRQS8ZVgra+VCzsa5wQu0
         fs5y/UVwz7TitMT0sZPC8PckpHwsB3a0A5nuHwjDaAJKZsc2Wbg56CAdBTjbMvQVfw91
         KOjYlFI7t3ZjvccDeFLUnpIopjbB6He9vFcYHyMHz6f3vPcpYAjiB6K8P/hG3bJC/TaC
         RM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310980; x=1693915780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzUUjWIr8T0FZIbu34J9BGxTroSGsDdkY4ko+SJQrnc=;
        b=doC3kmpahhQGJSy62GRNRHvHD+j2rkf72aY5JsGAnG4minVN8S6oG/flYvkInMkhCg
         efnfOvqDvz07wrlng23i9jyG6pcwwV5f8Rch0jT8xxt5XSi6UbpCFNT5bi3qGyvKliWa
         Z8wFtlJjsRmLF4n1yx0u3dn5Jfoes57tOZU307hfscvAkYyrESehO0z4atAHYiOAkI4o
         qfma/HAOykQAvGt1nDt5VNza/ykZv6gSDnl46FJuAZhi9FJ2DYk94/ieg8kvfy2bD7Fk
         bL7PHDAQM8G1npuWXHTpCcubj7k4UYZAhyrcK/3FQJBNiXx2J/HispzuhFv/gNP+w21W
         XBgA==
X-Gm-Message-State: AOJu0YxlYNVmKCdf1jARyZ5YE12vpX+wUvjtgzOkUcwlVOLANc9Cbk67
        yN5amLhiQpJ3/LVbKAyXK0c=
X-Google-Smtp-Source: AGHT+IHt8NP1HZ0CNe6b49MjjmGovhfJS84ptGTRXqIGozLkPeFRI3XCCI1LO8hhfE7boSGFIWgpHA==
X-Received: by 2002:a05:6870:d10f:b0:1be:ec3c:1ef with SMTP id e15-20020a056870d10f00b001beec3c01efmr31988232oac.0.1693310980312;
        Tue, 29 Aug 2023 05:09:40 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id zc17-20020a056871271100b001d0ad5205fesm2000651oab.7.2023.08.29.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:09:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4 2/3] reboot: Introduce hw_protection_reboot()
Date:   Tue, 29 Aug 2023 09:09:23 -0300
Message-Id: <20230829120924.1711175-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829120924.1711175-1-festevam@gmail.com>
References: <20230829120924.1711175-1-festevam@gmail.com>
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
Changes since v3:
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


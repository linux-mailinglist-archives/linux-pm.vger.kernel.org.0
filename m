Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23EF7A0259
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjINLTJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbjINLTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:19:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC001FE0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50091b91a83so1337711e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690338; x=1695295138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iylS42xIwfKwNaPXWAAIowhde9V6LPMJgFO7eJ5XP8Y=;
        b=a1LjuLWdYSF4u6aaxpQYCUktao2jdIXeOBsPUdR7nVLkHvR5xhHITwYmwI51H4zJP7
         D/NzTVyJPQSvVTi+13oBIajLwBsHIfblZMBEhj57TUMUdmFOMgbDjHCXk1/EUbG5Rw6U
         OU/iUw8R1L+IC0t20/2r8cbRoH7v/xzQRSh4odDdeMlahpX8zrFULkTZG0F4ulZKAgLW
         Bxbp8UUfiQEqTsVC0EjVctIcTK1ZULmiddmk2wO1tcr53Xrhi4EdkP4MDgGuB8PdCi4Y
         pxjdD16Z1cDfeeGswlDWsFSQOtApNGO9aEQgT2epyj5m2B5kcYSoBgWitQwTvwmBmn2R
         z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690338; x=1695295138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iylS42xIwfKwNaPXWAAIowhde9V6LPMJgFO7eJ5XP8Y=;
        b=HP/K99zj8eN5fqhA7ouNDQMjXgA/HZ6VwdM2frBW2dyhoTlLRoRs56xUOBk20d5e5L
         uY7yakDG1dJRCdlttffY4ziD4CiVB2xCFfr7qoTFJ2Uj5eCI6GyReCZjqEWbZB6AvR+P
         03kkjpoaULmgipLm/xMtNoLE8CWlyyImrGyzqf0SM3eC0PtrtuGz5+jNz4T+Fm6RKvWN
         qzgPo8+NZElB3gsxelTSy5lBQZu917FJ0dpujZHoKNdCpL/3mkU+IuhQbR/E3aKMaJer
         oypnXPas6U7ihrRvexsMDWVM/4QpJSJB1vUr7njL+vdV6qsYJqGgPDN1dPTr389FC9rr
         xigA==
X-Gm-Message-State: AOJu0YyQZqrbT9ga8r2xBxTGTVTQAMjIQgaJzlANkmJOnutKHhfhVn4U
        cZUviFI11l1fLDue8DzsU7w1VA==
X-Google-Smtp-Source: AGHT+IH2zQb2iOtho5IVrl2r1apG7cvFkXqz2DHfQwHHBvuWKPs6io8VlsMrHsY2rYku1hB8rETSoA==
X-Received: by 2002:ac2:5b1b:0:b0:501:bc0b:6118 with SMTP id v27-20020ac25b1b000000b00501bc0b6118mr3988441lfn.50.1694690338693;
        Thu, 14 Sep 2023 04:18:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v13-20020a056512048d00b00501c6d78f11sm233222lfq.298.2023.09.14.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:18:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/17] pmdomain: st: Add a Kconfig option for the ux500 power domain
Date:   Thu, 14 Sep 2023 13:18:55 +0200
Message-Id: <20230914111855.586724-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We shouldn't really use the CONFIG_ARCH_U8500 option directly, but rather
have our own dedicated Kconfig option, so let's add that.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     | 1 +
 drivers/pmdomain/st/Kconfig  | 5 +++++
 drivers/pmdomain/st/Makefile | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pmdomain/st/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 1e2c5f531638..cfe9ea754062 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -11,5 +11,6 @@ source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
+source "drivers/pmdomain/st/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/st/Kconfig b/drivers/pmdomain/st/Kconfig
new file mode 100644
index 000000000000..a77a70211f61
--- /dev/null
+++ b/drivers/pmdomain/st/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config UX500_PM_DOMAIN
+	bool "ST-Ericsson ux500 Power Domain"
+	depends on ARCH_U8500 || COMPILE_TEST
+	default ARCH_U8500
diff --git a/drivers/pmdomain/st/Makefile b/drivers/pmdomain/st/Makefile
index 8fa5f9855460..6d8b617eb834 100644
--- a/drivers/pmdomain/st/Makefile
+++ b/drivers/pmdomain/st/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ARCH_U8500)		+= ste-ux500-pm-domain.o
+obj-$(CONFIG_UX500_PM_DOMAIN)		+= ste-ux500-pm-domain.o
-- 
2.34.1


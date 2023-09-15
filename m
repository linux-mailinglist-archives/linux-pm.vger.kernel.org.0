Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7417A1A52
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjIOJVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjIOJVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 05:21:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203D270B
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so29918941fa.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769682; x=1695374482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Os6bv0Dt3LeB6u/HS9K4uZVY2Yt4IFbSegYd0tcLec=;
        b=lJwaHkbZHaSzWzs2VvefBPHGWQa4zX05rV6Yj+V5gIwQ7EyL/cuQhgXGDWIA7v1VZL
         hjCLuzehSmkWLhAWgFn+n3HpGjzZKlPZC5W09STyutM28hv+Cu2IAgUjlivQKwCZ4kec
         VVy1Z8ctGvPG6HN5D35KISqR9PO52JfWY/SoRGN6DSv5s576IbL2kwf9IBKuPY4a46tZ
         gsRdkSLtKQZWhCTs18K84CTXcuPFL19Dg3nIhPMI4tR0hOQpNOjGXYuPMBTmM/ppjFYL
         luqkYToi2WPr2avKtX/4wefvcdt08EPdJ+UPIrxmBZTT4mx8U8ShewlZzanxCA72elMA
         U6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769682; x=1695374482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Os6bv0Dt3LeB6u/HS9K4uZVY2Yt4IFbSegYd0tcLec=;
        b=BXBc8rW9BK7jlWNvGb8ze2Rqsa57n9jeoaT/zreQ13UAQMt00MH/QLp3y5o21f+pER
         2Agsx9+HYYhsinfN5iaBHzqhoxenxMWzt5BbbKgdm2QXrnIr5DLuQVajFXT1Oslra3ur
         0yC0FcFbSBkT+KjbPcFlBguUHcm/c/fTQoLGmBVc8O1xnakDO70l56rJPtd51Zmy51kO
         hJL39uJqUdEjgPZyaR31EE89C7PrVF+aH8gyadyA9b0/plNveonORaoL48K1Zf6ze2DC
         fYf3DDw6ju4PivFRCx9C7dlGUNZ5j/pul/TA7XxWtfqSfxV7ol7ajqcLG2Wf0O0ueknd
         Ymnw==
X-Gm-Message-State: AOJu0Yx4EYAa+kFrl0Glm5n9GQkuJ/EK2fJkmxjReA9Ll1+o+Q1N3q7C
        65/+2Q3oLJj2xhcd5lkzcX8r2w==
X-Google-Smtp-Source: AGHT+IE/zpxUF1uu6BoDONyVpbXJeKhY3xFLEPlW57X6jw1Xtx2VwUTkRcH+jl50/wFagGsRc7Grsg==
X-Received: by 2002:a2e:b001:0:b0:2bc:ee89:6976 with SMTP id y1-20020a2eb001000000b002bcee896976mr1063977ljk.24.1694769682154;
        Fri, 15 Sep 2023 02:21:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/17] pmdomain: mediatek: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:53 +0200
Message-Id: <20230915092003.658361-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: <linux-mediatek@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig          |  1 +
 drivers/pmdomain/mediatek/Kconfig | 29 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/Kconfig      | 23 -----------------------
 3 files changed, 30 insertions(+), 23 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index e2c85f20a0c3..b1d9dc7d71e3 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -6,5 +6,6 @@ source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
+source "drivers/pmdomain/mediatek/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
new file mode 100644
index 000000000000..21305c4f17fe
--- /dev/null
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "MediaTek PM Domains"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+
+config MTK_SCPSYS
+	bool "MediaTek SCPSYS Support"
+	default ARCH_MEDIATEK
+	depends on OF
+	select REGMAP
+	select MTK_INFRACFG
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Say yes here to add support for the MediaTek SCPSYS power domain
+	  driver.
+
+config MTK_SCPSYS_PM_DOMAINS
+	bool "MediaTek SCPSYS generic power domain"
+	default ARCH_MEDIATEK
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	select REGMAP
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, the System
+	  Control Processor System (SCPSYS) has several power management related
+	  tasks in the system.
+
+endmenu
diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index a88cf04fc803..0810b5b0c688 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -49,29 +49,6 @@ config MTK_REGULATOR_COUPLER
 	default ARCH_MEDIATEK
 	depends on REGULATOR
 
-config MTK_SCPSYS
-	bool "MediaTek SCPSYS Support"
-	default ARCH_MEDIATEK
-	depends on OF
-	select REGMAP
-	select MTK_INFRACFG
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  Say yes here to add support for the MediaTek SCPSYS power domain
-	  driver.
-
-config MTK_SCPSYS_PM_DOMAINS
-	bool "MediaTek SCPSYS generic power domain"
-	default ARCH_MEDIATEK
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	select REGMAP
-	help
-	  Say y here to enable power domain support.
-	  In order to meet high performance and low power requirements, the System
-	  Control Processor System (SCPSYS) has several power management related
-	  tasks in the system.
-
 config MTK_MMSYS
 	tristate "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
-- 
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1267A024B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjINLSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjINLRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:17:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8A1FF6
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:17:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso1410475e87.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690267; x=1695295067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRH6OrUr+z0cZQpLuLGyuJMctqYD163Kr9u2QpwLYcY=;
        b=Y4MC9Gb+imfY85bDzmArSXAPidOsPoh6Ba8jQmmjr/W3XCmitVnzuvZ3v8cc3b3ejY
         E4zA4etgS85hJMWUrMyqLcOGm2Y0YVeC6JRwwRLFFgDCjHxiWV9s/eHa4rbXCYYUWUUa
         KK0h24KcZLwCxLe2GDkHNuChmFdFJVQN5DCx3EU9p9KTKRBHZHkQswVcN7AEeiQF4+UJ
         Ewnaiw+HVxDMWc6nINGSvJ6/GG3EzB8MmYXcFh5GoFrT/6gimzg/fYv+PixbuB7aBvX3
         IUYdXwKVWgm7dCEUDpSxVCstMvUW+Jdhqi68mXg7GMYauEVjsEr71wqAZvQ0bRDH0BX1
         yF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690267; x=1695295067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRH6OrUr+z0cZQpLuLGyuJMctqYD163Kr9u2QpwLYcY=;
        b=XEOVq2xSaFEHPOg+fAypR1ZfN53KgdYUQJn7G29D0buq0tyvKAGInU7O3Daz32ABqt
         qht2rIkH7MZB5E0sIpptHXMf1o/zMMO0oztk1dayymW13VvUoUC2SK6Wp4T+/lc5vCnx
         iD9SjsTf/g9UDixDAIWos/oUNmQA+AL02AvYutGS+Up7dt+DOt3O+GjVxHA4pVelOcZP
         9LWU5pHoM+ez1WJyQqvn2fK5qdCulDNGQ/BvAJCNT6+qd6tPSwSK9Z2A0y7z+JLRC+AW
         wXrpppE9QmcdThuWS/jJWXY53SimO90q/uIbzEMpoL97kTmfkMJqO6ueWGrgvXVL1vlE
         JFCQ==
X-Gm-Message-State: AOJu0YydVmuKCl45AfE7syuQa62xVim31u+U/iZbMu9q3lfUS4Q079Nz
        NFDhcHc4lQGs+3W1WOgv0Vbc9Q==
X-Google-Smtp-Source: AGHT+IG+zvfdRoCHg863MO1oc+o242dOyN3OArQ0YkCJDQaEF6fm8SXbA4YZWUC5fkXlYy9dpmXDxA==
X-Received: by 2002:a19:4316:0:b0:4f8:5cde:a44f with SMTP id q22-20020a194316000000b004f85cdea44fmr4020739lfa.10.1694690266851;
        Thu, 14 Sep 2023 04:17:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id q12-20020ac2510c000000b0050092263a20sm236630lfb.6.2023.09.14.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 07/17] pmdomain: mediatek: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:44 +0200
Message-Id: <20230914111744.586593-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 8a02523b62ce..5929f2d31588 100644
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
index 000000000000..184011b51615
--- /dev/null
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "MediaTek Power Domains"
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


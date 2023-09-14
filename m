Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0057A0243
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjINLRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjINLRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:17:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA771FC9
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:17:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50079d148aeso1432197e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690236; x=1695295036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i01ZwhFKlrFFwp2TeTntBDNdPU8fSl314WlanHljcec=;
        b=opMpVPzsFDWclZZqyZYNinrucsgVFWEDpzLsA/VLI+R4CQ/lypGcn87+7dNbWoa6OY
         PmQScH1I3vth8ih6qJqy6+TWRTV9EYiXrzAoEDdsQKZ/cUKot3EaOWZihv9gbmaL88GI
         jrxOPOs/aGrEr1J8XBY9/SpIDwgDETv7CLMBylhCRzk1YDKidjOn2s1l6vSjvnrV6Hlk
         7NeLePvxvM3NVZ4VBVl+y7ljlj/QfjJdlKvIzzgxEKinJE9DrYqYZiigAh338mvwlIEC
         HXXw2iC8yaHlXOigfoFf/HhawxtGA8Iimpg/mOd/GVvY95dZjt5kfVYAflOzxfar8mG/
         C2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690236; x=1695295036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i01ZwhFKlrFFwp2TeTntBDNdPU8fSl314WlanHljcec=;
        b=Odq0GCOHuDlnNBNmguf7D1d/xSsO+7n61laOYakaYBS9s3TUPxLu3c1C39ZQIYGNho
         MoPe8Jbjq/etcbL9FdxMte7kmoU9+ccCdtLIMzNwv5J7A7C6U9Hx7I4SLZ1qN+bS+4xr
         r791fPzNhxkA6WUz0ALQpjcnvrxKSk9ICJ0uKJlr7WcBwGLhUoOVCzjXUJdW24nFYjlI
         RkpjFGMInkFUXM107rprJk3iE1x3prS1I8c0H2b9FvravN4pD66aD0AO4see4q144Tj9
         CnWe+Bv62ofIOpC66PlQ10h6LSeAvOJyMOGH8KV8zX1cASF9GR/BaV2M+y8i4askqGIU
         3jkg==
X-Gm-Message-State: AOJu0YzN8/Hof9Ke/gf3TqQ6aFjoN9XSzFu43wTNh1et63t2RWM4+F1f
        +YxUaQv9YktH5Mox4eNIZDfrlf1ldOKu+RskS8cdqw==
X-Google-Smtp-Source: AGHT+IGDjoyTHtzNmJttlaj3jNDjN0HhiwRNEyZ8rwnvs9ZEjBQwpDBAiyBTONV+SlXcQ/a1Fasksw==
X-Received: by 2002:a05:6512:312c:b0:4fe:7dcc:3dc1 with SMTP id p12-20020a056512312c00b004fe7dcc3dc1mr4103999lfd.44.1694690236028;
        Thu, 14 Sep 2023 04:17:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a28-20020ac2521c000000b005008cd93961sm233024lfl.192.2023.09.14.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Subject: [PATCH 04/17] pmdomain: apple: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:12 +0200
Message-Id: <20230914111712.586522-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: <asahi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       |  1 +
 drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
 drivers/soc/apple/Kconfig      | 13 -------------
 3 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pmdomain/apple/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 07d2f8165abe..55a9ca191849 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -3,5 +3,6 @@ menu "Power Domains Support"
 
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
+source "drivers/pmdomain/apple/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
new file mode 100644
index 000000000000..12237cbcfaa9
--- /dev/null
+++ b/drivers/pmdomain/apple/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+if ARCH_APPLE || COMPILE_TEST
+
+config APPLE_PMGR_PWRSTATE
+	bool "Apple SoC PMGR power state control"
+	depends on PM
+	select REGMAP
+	select MFD_SYSCON
+	select PM_GENERIC_DOMAINS
+	select RESET_CONTROLLER
+	default ARCH_APPLE
+	help
+	  The PMGR block in Apple SoCs provides high-level power state
+	  controls for SoC devices. This driver manages them through the
+	  generic power domain framework, and also provides reset support.
+
+endif
diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index a1596fefacff..eff486a77337 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
 
 menu "Apple SoC drivers"
 
-config APPLE_PMGR_PWRSTATE
-	bool "Apple SoC PMGR power state control"
-	depends on PM
-	select REGMAP
-	select MFD_SYSCON
-	select PM_GENERIC_DOMAINS
-	select RESET_CONTROLLER
-	default ARCH_APPLE
-	help
-	  The PMGR block in Apple SoCs provides high-level power state
-	  controls for SoC devices. This driver manages them through the
-	  generic power domain framework, and also provides reset support.
-
 config APPLE_RTKIT
 	tristate "Apple RTKit co-processor IPC protocol"
 	depends on MAILBOX
-- 
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4409C7A1A5C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjIOJV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjIOJVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 05:21:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E678268A
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bce552508fso29094741fa.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769687; x=1695374487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpRw/Nyqv1IAu9jwP5IM347QJfNRDr51sp+Cv/OMBfc=;
        b=SH9X43qnHeskIjZ2SgxFVuck39O+WrSLhSeQXBMS0//VVc0ZY/W+C4khywK6yL1Pog
         DgZs9GsjUi6+5blfodqdD+RRNlqIxdEQR9GzfG9FwFEjCI3oLFJk4VaCjhuaYneoaJkT
         MP9pJ6hp6taJ365htH6KfOOLo/KhshshFuX3ugY1n77a3Ul2HBEskEzq3EG6xTmxWeLq
         Y1ZmNREaWN0mYlJnaRCuN+4A5cXDTQp1OL2ijhyEE2UC8ZKREZnJoihrSXfTQ/xU3j4O
         8rd2HRrWwLHP1xej7HSmGR7V+legSzLzdrEsAGq86c0kqilwgu3IGIbzAvkUfRXudvvv
         Kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769687; x=1695374487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpRw/Nyqv1IAu9jwP5IM347QJfNRDr51sp+Cv/OMBfc=;
        b=EeQORMGV12b946TP2L1nlcAhuqeKod0PefnWQNce8LsoyxXwId1zePZuYWIpIMOJxA
         cuxZSfWrtrMnnO95gqL2zfr5BTXkDMVHU0kRRdXtjaIpvOmmqkxzGlEsp1fNXUgOjWO7
         JX7Y0YWFQ0MYiFbivJ5pn2OBhcorbZzeT6EiL71UfA77BO17uh5OhztK7XQETOjEwKLB
         qceWVRs0d2bT1ryw2XWVkhJAj24+BsQFpaydLPeccfCQd9oRE5qqIlDMeqHq9zxwW/eA
         5prDvOeuDKtXOs2rh+qCrUCGF3PEanyWWU5fc6jlh/cVYejyrSvfEoE+RZIACc2FRnXn
         G3Sw==
X-Gm-Message-State: AOJu0YzKROlF8L9tkX2yIsWwd+3G2TNss8BImdvWFYuqArGhIRoDtMQ+
        8gn3TqdSWUejMQ/ahstPU3ZAbA==
X-Google-Smtp-Source: AGHT+IFfEfbuyQGDwmyo+FnzogD3H8gVtamynxzaP2uvT5VpEjahjrgz4DFCThndBuMm73k/8MK1VQ==
X-Received: by 2002:a2e:92d0:0:b0:2bf:645b:6afb with SMTP id k16-20020a2e92d0000000b002bf645b6afbmr1015294ljh.21.1694769687139;
        Fri, 15 Sep 2023 02:21:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 12/17] pmdomain: st: Add a Kconfig option for the ux500 power domain
Date:   Fri, 15 Sep 2023 11:19:58 +0200
Message-Id: <20230915092003.658361-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We shouldn't really use the CONFIG_ARCH_U8500 option directly, but rather
have our own dedicated Kconfig option, so let's add that.

Cc: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     | 1 +
 drivers/pmdomain/st/Kconfig  | 5 +++++
 drivers/pmdomain/st/Makefile | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pmdomain/st/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 4a411e0985c3..08f8a3aa9805 100644
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


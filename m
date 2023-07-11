Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40F574F205
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjGKOXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjGKOX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:23:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8C19BE
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso92097501fa.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085369; x=1691677369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3HkS8n/DHjLJ9CSnu0btooLeG2USC/O5hAcB+zQHR0=;
        b=YFzpDs4qddfLuT2Ja47Tie8E9U6WSvRiitw3Rl6fvE7ZRbRoJ/B1O7jT+omGz2Zkoo
         Psieekd+8Hyx64OQnlvvI62//QvgBAYh+forEFEZlWdq6K0ex3Fk4oK/XuogaHW4O2RQ
         KAhZAe/mXovdHvRxuM0igb/7yg/9gPrZwWfcpVg2S6K3ceqZV3rQx1mHdYj1mZYZ1P1X
         o7nF3oFkjdaKskPFUFPENSh7AVinLMokMVPv7/uFZ56fMFDsJqiZvNPm226qBD8+LE7a
         D2Z29Jh6edFJJT5FZYRmny/D3dq0IbZ7ylCIMd0ZNN9/F9GaGvkbI1T0A1XG7LZduV36
         LZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085369; x=1691677369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3HkS8n/DHjLJ9CSnu0btooLeG2USC/O5hAcB+zQHR0=;
        b=K8g35/lc1mleutk0JDOR8v+puPooB8tQfJy6wgd0eLCWFrpduWw6s2IX1pgY/lynjo
         zJSCrhM5f0NpDVKFoAVR3oyvdyYikD4k5z0431csHLBoocsgBv306daQT1E9zjLPF0dH
         XRydlqT3zzfghREXd4SRjHl19f6orX7N5RTpta3Z0LsBJRszvGPCOMmY/Aukz+TDYszb
         XlwSfWTmSi9A5SDiyvNbgKhdRkfYkY7NNgXGKLtJt6FYLtHCnywLOu5xbli/mbeHLYGm
         dUDnzs7mSkIZVtl85gUZMxumCzI//Xw8EGJj9TDhyOXLSLZEpsm4rBdt3fI7aaUPALpk
         Y84Q==
X-Gm-Message-State: ABy/qLbxltBPMOPbZiPgUNVoeCmDPJuvtBohRjtHQkaNERGk5nO2eDmX
        y4Awq5zt84yTjAtw+J66/iBKnw==
X-Google-Smtp-Source: APBJJlHeyQA/rrTBRnhHmFHAQ9RkvQirevuuq4l+s9FWvVcIYzcJfIjCrcqTAVLnbDxJIqDqRKtRxQ==
X-Received: by 2002:a2e:b0c7:0:b0:2b6:ec69:7c3b with SMTP id g7-20020a2eb0c7000000b002b6ec697c3bmr12314784ljl.46.1689085369756;
        Tue, 11 Jul 2023 07:22:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id q6-20020a2e84c6000000b002b69b44fd52sm488065ljh.5.2023.07.11.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 18/18] ARM: ux500: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:22:47 +0200
Message-Id: <20230711142247.751857-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To simplify with maintenance let's move the ux500 power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                     | 1 +
 arch/arm/mach-ux500/Makefile                                    | 1 -
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/st/Makefile                                       | 2 ++
 .../pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c      | 0
 5 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 633bc6767cd5..377f68e66fb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2421,6 +2421,7 @@ F:	arch/arm/mach-ux500/
 F:	drivers/clk/clk-nomadik.c
 F:	drivers/clocksource/clksrc-dbx500-prcmu.c
 F:	drivers/dma/ste_dma40*
+F:	drivers/genpd/st/ste-ux500-pm-domain.c
 F:	drivers/hwspinlock/u8500_hsem.c
 F:	drivers/i2c/busses/i2c-nomadik.c
 F:	drivers/iio/adc/ab8500-gpadc.c
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 5e903241bded..270e5676fa02 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -6,4 +6,3 @@
 obj-y				:= pm.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_SMP)		+= platsmp.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index efd955f586e9..c429485c13f6 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -8,6 +8,7 @@ obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
+obj-y					+= st/
 obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
diff --git a/drivers/genpd/st/Makefile b/drivers/genpd/st/Makefile
new file mode 100644
index 000000000000..8fa5f9855460
--- /dev/null
+++ b/drivers/genpd/st/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ARCH_U8500)		+= ste-ux500-pm-domain.o
diff --git a/arch/arm/mach-ux500/pm_domains.c b/drivers/genpd/st/ste-ux500-pm-domain.c
similarity index 100%
rename from arch/arm/mach-ux500/pm_domains.c
rename to drivers/genpd/st/ste-ux500-pm-domain.c
-- 
2.34.1


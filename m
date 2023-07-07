Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511E874B29F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGGOFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjGGOFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA32727
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:05:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so29278231fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738708; x=1691330708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je6bX0AG52q7DCDonA0DGTjDfx3q/PN/GS0L63XBpKE=;
        b=rqys2j0Brupq2w6GZ7RSuJyTRxQkePn2AmvkLBcbNlhauUH8on92zHFWGuTWw7bJqV
         sTT8Y1aS1ldnXlEoEHbJDr879g9eKyrS3xqY/aGRAznAnzGRhxCBITnVLOQK94T+o0PW
         NXXzY11KmEIuAVTVBj3XQtCiof2eZmVLL69RNGnbI6s/XbSYRxGhmLVJZdtVNGyqV/Ne
         OqOWktaQPHnaC9rs8U+TEZ1abQNIWYqlrbAfa933ZCBHISyQYdWeSvzyYyJyWk4kQOt8
         Sa/XNWyw7URYvfS6+GqzVmroDCq2suM5Y6XvQ9Rl46rd67XAKlva79Wbl3g/tlYRZPOc
         6BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738708; x=1691330708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je6bX0AG52q7DCDonA0DGTjDfx3q/PN/GS0L63XBpKE=;
        b=X9/fLdQhvh7Cjg30E7NM+tHGFN+YGjprb0uwEBA+4Z56jePd8BAzqWMji1tZoV0tzb
         Bfnz05Be/Lb0vPo5JAAFSSjdi1YN9Hl1m2/Tg4kDeMouuHVJyhgFUoKEht2bfbKkmgy1
         HO3LXjTqNtl9XxDEksSrOjhT9XBZXDd9hznlctZjaIABrweUXjqxiXjvcoud7/4tI5MJ
         5EG1I5Qn4wLy5h/YIc6vKSqHGDftwcBM0DxCminNdN+D2505oZLjZmmtwb01TzNgyNW2
         wTKONcdd0o5rRiDOGyDWP9jbNuA6yyZpZpvthVHohuordReL4JDrpEDxvSllGW4t4RG7
         WTAQ==
X-Gm-Message-State: ABy/qLZMaV3b0GKrtN/sF6TkaUQY1NCTE+Jv+CXGL4yduPREnwmx5ROy
        3a1A7/qcSI2l9aPySLbYC7DoBw==
X-Google-Smtp-Source: APBJJlFywF6ogRXpPhtF1mvvSGVdfjDZgUL+OgdGxg7RXiaHc/cGdKtCfKzjx55QKt1N+wmABJ9csA==
X-Received: by 2002:a2e:9a84:0:b0:2b7:1dd:b416 with SMTP id p4-20020a2e9a84000000b002b701ddb416mr3804478lji.15.1688738707990;
        Fri, 07 Jul 2023 07:05:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH 16/18] soc: xilinx: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:32 +0200
Message-Id: <20230707140434.723349-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/xilinx/Makefile                                   | 2 ++
 .../zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c}    | 0
 drivers/soc/xilinx/Makefile                                     | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 193892189f0d..efd955f586e9 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -12,3 +12,4 @@ obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
 obj-y					+= ti/
+obj-y					+= xilinx/
diff --git a/drivers/genpd/xilinx/Makefile b/drivers/genpd/xilinx/Makefile
new file mode 100644
index 000000000000..a706ab699cfa
--- /dev/null
+++ b/drivers/genpd/xilinx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS)		+= zynqmp-pm-domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/genpd/xilinx/zynqmp-pm-domains.c
similarity index 100%
rename from drivers/soc/xilinx/zynqmp_pm_domains.c
rename to drivers/genpd/xilinx/zynqmp-pm-domains.c
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index 41e585bc9c67..33d94395fd87 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
-obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
 obj-$(CONFIG_XLNX_EVENT_MANAGER)	+= xlnx_event_manager.o
-- 
2.34.1


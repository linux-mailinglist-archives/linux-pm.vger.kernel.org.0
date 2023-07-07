Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012274B294
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjGGOF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGGOFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D82212C
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:04:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso31011231fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738697; x=1691330697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qyum3k4tjelZ9EZzRNlVIF22Us+iBOxD/GKR5sbt34=;
        b=f3RG+EafmByUgKe8RFhvUo0UapMEMxPfE1WH+JdHr4CyT3ofKlMLlN+fBgAA8In52w
         FUBiwolmlm+jKRRY75fobnEb/2oT3CL5ixV+f5+QuKSj1fcIRRYP2LvlR5OH6ivpXy2H
         wbIUSC8Lbega6GxYA0NHK+nq/5LMsvJUq+Ydamp8kaXOSRJVakkybleuhujUl8f7xExG
         YM9W8eAfG4hqaJVvoGNPzuMGW3rP0DHNJoAWa9N5WiD6Cd2YSaJmutUequzWeoVl1ESp
         YXzr94lap+QWCbAzQ8Xx+H/23zy04oMpbncsbFzU0RMtZ25orOPrGEyt7Zop37ZlkBJS
         xsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738697; x=1691330697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qyum3k4tjelZ9EZzRNlVIF22Us+iBOxD/GKR5sbt34=;
        b=iNniQIb/v7CsjHsxzT38qycRXXiKdM4vFAJDghcAsuwCVTh3Wri0xGzJJ/L0oimTzU
         YkO0ishFai001R9oulOvYcT3fFWU2NzgnQmqaGgPO4UWWDo77ffjMvzB05mdADBgK9d9
         YY2M1IqwgHYHPs71FPKzhSAt40tItXBFzpXQ6Azl3f9swafggvpchDrIOWDBk8OrAjWn
         o1FpC0Rv+G5Es5Nk8UCoI2CDec8yHMj/oD9xSfHnjdyM8pmBkBYUdwkeL652qpYZmfL6
         mu6hle5ivybq7wFtZh23AbpjsvvbuWPczEDB1HEz/YvRxaeGHBye6q69jFCtV83dv9kw
         zRdg==
X-Gm-Message-State: ABy/qLZbbCsaux9BXnzH83U4oeNaPocHJ2Y9C/AySDMGOJAdpsR8KtKm
        F1X/X5oiCFAdsZ9/hW4VO1R3vg==
X-Google-Smtp-Source: APBJJlEIR/ULGxuj2SzHUNnMAJkyr9wn+Mq7Vhm89E5STBrFYsy5xjKKlWzX/dG7nKg7feP+/lEDDw==
X-Received: by 2002:a2e:80c4:0:b0:2b6:9b2e:e352 with SMTP id r4-20020a2e80c4000000b002b69b2ee352mr4154824ljg.9.1688738697355;
        Fri, 07 Jul 2023 07:04:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 11/18] soc: samsung: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:27 +0200
Message-Id: <20230707140434.723349-12-ulf.hansson@linaro.org>
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

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/samsung/Makefile                                  | 2 ++
 .../samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c}  | 0
 drivers/soc/samsung/Makefile                                    | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index c178421e0cbc..1cf0ff26a44f 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -7,3 +7,4 @@ obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
+obj-y					+= samsung/
diff --git a/drivers/genpd/samsung/Makefile b/drivers/genpd/samsung/Makefile
new file mode 100644
index 000000000000..397aa5908c1d
--- /dev/null
+++ b/drivers/genpd/samsung/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_EXYNOS_PM_DOMAINS)		+= exynos-pm-domains.o
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/genpd/samsung/exynos-pm-domains.c
similarity index 100%
rename from drivers/soc/samsung/pm_domains.c
rename to drivers/genpd/samsung/exynos-pm-domains.c
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index d35270fc6b2b..248a33d7754a 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
-obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
 
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o
-- 
2.34.1


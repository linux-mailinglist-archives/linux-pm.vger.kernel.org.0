Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF174B297
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGGOFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjGGOFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2326A9
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:05:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso3094707e87.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738699; x=1691330699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XnY/GyZrUw9Juk0p/ED/bwiocbQW9F5IpBV8vKRnmU=;
        b=VHFOyK/HJt+DaBJz+gKOwdykaUd1K+cMEkPJhCGUPohGBYJbxIBfscKSR1zUp6BUFq
         nuuS6Oz+VGmHbCBf/n5rUKnHU99v2RiEQg0YDIyNwi1ZcvWap6njv2k7WYkIFJ6uLu/D
         SrFAMwH4IW0d53TU+GR5Saqym2m6qKdgZmvt1O37f08PoOwDmo+GIXTB4oTvIme0pxMJ
         mbMM5cZpsFuhdWYLGXIQoCrHoXlkAAYUOec31+PVPzDzKL40DdBT05eJ5S2jUj36G3wZ
         VUkNGsysQ/qdV8UVy/g8jV5PwVOtJkaXj6CFYQgByFB+UEKnfbqIkX0OIvAy4wxOAGln
         ahAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738699; x=1691330699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XnY/GyZrUw9Juk0p/ED/bwiocbQW9F5IpBV8vKRnmU=;
        b=hpYTkczKY++bCHvpWogU3h76CZgiiklBx5A0T8MZ00D36cWXhg2HZi9EMNY/qKBv8x
         zAPu8gJkRDHEskLzCN+W6NQGoSeg8OOb8/I62ujrllHH+2m+FahXretG4bhVgejVtni8
         EVAJpLXCoGCNlCws1CTPrnOh6wKhGQiCKSfQycMN8pOdxDS9PuEEl6qjyqk/sQ59HyvQ
         lUruhzAqmlTUvi6+z6StTAOSN6uZR9tAVndQC9YlgagLgN8K96uLG4f0Pu77vw8fRxMp
         f8ZSEL1965ZV7hCRgj8a+dg7L36i8Fb3TOIIdbGar6C+MOFY4J4mvmdkjH7CgQMDUBgx
         uOXQ==
X-Gm-Message-State: ABy/qLYDEHpivAIUMk084l0cHTsaKS/LfTEMUhivifcRC9juVWS7K4Nm
        V00A9MymTJdD24+xX0ab+dwGrQ==
X-Google-Smtp-Source: APBJJlG1uhr1Kp4j3/QpQGrtS7yfv8aAwoixL3g207ucHUtsAlZFcafYpRhe3bV7T8aJdLCnhuUCBA==
X-Received: by 2002:a2e:9658:0:b0:2b5:68ad:291f with SMTP id z24-20020a2e9658000000b002b568ad291fmr3768161ljh.19.1688738699706;
        Fri, 07 Jul 2023 07:04:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH 12/18] soc: starfive: Move the power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:28 +0200
Message-Id: <20230707140434.723349-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cc: Walker Chen <walker.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                    | 2 +-
 drivers/genpd/Makefile                                         | 1 +
 drivers/genpd/starfive/Makefile                                | 2 ++
 .../{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} | 0
 drivers/soc/starfive/Makefile                                  | 3 ---
 5 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} (100%)
 delete mode 100644 drivers/soc/starfive/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index cb57f5fb2cd7..9e580df3e5db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20311,7 +20311,7 @@ STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
-F:	drivers/soc/starfive/jh71xx_pmu.c
+F:	drivers/genpd/starfive/jh71xx-pmu.c
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
 STARFIVE JH7110 TDM DRIVER
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 1cf0ff26a44f..baf2021235a7 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -8,3 +8,4 @@ obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
+obj-y					+= starfive/
diff --git a/drivers/genpd/starfive/Makefile b/drivers/genpd/starfive/Makefile
new file mode 100644
index 000000000000..975bba2a29a9
--- /dev/null
+++ b/drivers/genpd/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_JH71XX_PMU)		+= jh71xx-pmu.o
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/genpd/starfive/jh71xx-pmu.c
similarity index 100%
rename from drivers/soc/starfive/jh71xx_pmu.c
rename to drivers/genpd/starfive/jh71xx-pmu.c
diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
deleted file mode 100644
index 13b589d6b5f3..000000000000
--- a/drivers/soc/starfive/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_JH71XX_PMU)	+= jh71xx_pmu.o
-- 
2.34.1


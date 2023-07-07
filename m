Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464D74B288
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjGGOFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjGGOE5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:04:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506A19BD
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:04:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f943383eso31018061fa.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738691; x=1691330691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C9FKQaL/DjhwSAwt3ArSmfw7wijMULRc04IKf+RB6c=;
        b=JhXWmV+T447FKYsYy6dzhvKCW6juQUSijMSScTTi/Vg7iA6f59CwmTplfO221r6YH1
         Ru43D7CE7iM4eTo+xO0B6q3tnI5fQtzTwWCdmG9X6Ud2CMD1lPUyxc7LZEeQndf8oW3j
         TgWzcg3sttamRQvHTWcIIuC6Nj0a73F+Jb68Tz0u5Q4ETeom+/6C3osqTB0SkRIPhO14
         AuVwUFy5FsIw8lGcZuQ6+CppiH2Spp3aMRTyo+z3fY0l2CPBwwdHSyk0wX8+GMLDkPCc
         3UsYSKMXfe3p9LT9EOf6PF3Ji6YARY+SQ2367x6aKW9agMKORnZ/w8FgBTPMK+TKwf4y
         aM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738691; x=1691330691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C9FKQaL/DjhwSAwt3ArSmfw7wijMULRc04IKf+RB6c=;
        b=JdaeZ8NL0Mpo2dDsyshCIhozKDf61uiJ9ZB3k/oTpsgysQcm7PpEhy/82LJYUODGGQ
         qRr8nrB3dk4VObhZ8FeHs+/sGybX5mvgNWmM8tAaloQcDGIdYfuNRmXw7Sqx+rXzPS2e
         8LZcvFg7UWMSrWtaMQEca6l+ygNsRVAs2TQoW6ndV2QD9ToGG2a/j++ChSq6nv4lSsrh
         ucK5llTvKvrXCcaMYNxU54XzXZEhAv4yCVghKaM3GkRNAyVdTogsAn6rm5cbQXaCKrob
         JcXOM43MJBKpGiHdBlhBSM31rOoQaLzb4rxgAcwmXG8/rzfo74radTjDTDf/xryKgYS4
         buKQ==
X-Gm-Message-State: ABy/qLZ0LlnVoMU5l1gSRqRTWt7zf1ArFfWu/GnrOHF7ti8pBbKDRAK2
        dES3iSf8aUPWdfVCnnNhqg4Phg==
X-Google-Smtp-Source: APBJJlHBmMeXjugK8v9YuEhL1V3jLnXeidwnEj3l3uiEN5XJ77pwCTcdYgDDx1GbKdO/iL6N2yp8wA==
X-Received: by 2002:a2e:a40f:0:b0:2b6:efcf:1463 with SMTP id p15-20020a2ea40f000000b002b6efcf1463mr3811395ljn.6.1688738690802;
        Fri, 07 Jul 2023 07:04:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 07/18] soc: mediatek: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:23 +0200
Message-Id: <20230707140434.723349-8-ulf.hansson@linaro.org>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: <linux-mediatek@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                              | 1 +
 drivers/genpd/mediatek/Makefile                     | 3 +++
 drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.c    | 0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.h    | 0
 drivers/{soc => genpd}/mediatek/mtk-scpsys.c        | 0
 drivers/soc/mediatek/Makefile                       | 2 --
 14 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 6b9e9fe907f3..1a0a56925756 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -3,3 +3,4 @@ obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
+obj-y					+= mediatek/
diff --git a/drivers/genpd/mediatek/Makefile b/drivers/genpd/mediatek/Makefile
new file mode 100644
index 000000000000..8cde09e654b3
--- /dev/null
+++ b/drivers/genpd/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MTK_SCPSYS)		+= mtk-scpsys.o
+obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) 	+= mtk-pm-domains.o
diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/genpd/mediatek/mt6795-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt6795-pm-domains.h
rename to drivers/genpd/mediatek/mt6795-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/genpd/mediatek/mt8167-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8167-pm-domains.h
rename to drivers/genpd/mediatek/mt8167-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/genpd/mediatek/mt8173-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8173-pm-domains.h
rename to drivers/genpd/mediatek/mt8173-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/genpd/mediatek/mt8183-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8183-pm-domains.h
rename to drivers/genpd/mediatek/mt8183-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/genpd/mediatek/mt8186-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8186-pm-domains.h
rename to drivers/genpd/mediatek/mt8186-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/genpd/mediatek/mt8188-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8188-pm-domains.h
rename to drivers/genpd/mediatek/mt8188-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/genpd/mediatek/mt8192-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8192-pm-domains.h
rename to drivers/genpd/mediatek/mt8192-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/genpd/mediatek/mt8195-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8195-pm-domains.h
rename to drivers/genpd/mediatek/mt8195-pm-domains.h
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
similarity index 100%
rename from drivers/soc/mediatek/mtk-pm-domains.c
rename to drivers/genpd/mediatek/mtk-pm-domains.c
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/genpd/mediatek/mtk-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mtk-pm-domains.h
rename to drivers/genpd/mediatek/mtk-pm-domains.h
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
similarity index 100%
rename from drivers/soc/mediatek/mtk-scpsys.c
rename to drivers/genpd/mediatek/mtk-scpsys.c
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 8c0ddacbcde8..9d3ce7878c5c 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -4,8 +4,6 @@ obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
-obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
-obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
 obj-$(CONFIG_MTK_SVS) += mtk-svs.o
-- 
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4E74F1C2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGKOVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGKOVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:21:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45B10FA
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:21:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso8655939e87.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085269; x=1691677269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RT59kaXTgg5sgTQpdgoEwntc5E3q29hk2GymBQEqefk=;
        b=AQPWUshV2DPhAH6FtxoBop1FDYTgaHN5JKSl2ydch4oMjUqPUez+s5K439puSFRJWR
         thALx5tssRdd+6BSRtAiTazZn9vVi6XzEjh5XXWcjjvz7rZ6huduI81XvhlXuAyQtfdi
         ldRcruREpgzVfKsubvo5h7D2eZxr1L+OuEUzjLeEBjdnNqrnTGwkBGRbf3DbeTSBaov1
         jmYMxMqMcX9zZbC0W24P2e/I2d4sT4KLYVVNXuqUb4gKZ2u9LUyyiFPyFtuBuA4rbfF/
         a8OcHVfd6oPl4aI+Ehc4Wo3RYXEQRJWvS8CX+Bz9trDx+XC5yEwG4EAj//48FgxeWCH4
         3QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085269; x=1691677269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT59kaXTgg5sgTQpdgoEwntc5E3q29hk2GymBQEqefk=;
        b=JWW5U5zs0m9n7z/QA/DXjKmm50HLSoX5i2MMi8JApRviPli3PVbG/PpaQ2zMPP2bqD
         zDucGwHhpb871j+YO/23qir1UkwDhESzcwhB1aZV7H78Id7ZtkUjlUca23DoOmD+jrMN
         ykYQPy6knpiTxayaqzw3mibGvsAMtAKdsSTA1keouZk+4hRXHa7T/BrdPgd0/fI3hZFM
         cYHYawb+jHy7uYmp7xH7kCFOvgtTsRVvV2J55iMie+PnDjJuaj1iW7HFUXpmKlUStG/A
         rcdly5ETbrLlyfRn2rqoPOakEHyBe4zBmm+d5QWPaazhhVRY+auu9ysJMLyT0D76A7Mo
         YODA==
X-Gm-Message-State: ABy/qLZwsdXAAfL39nRXKDe8x1O/CsUAnxO1tLTMtVFTvFRDJDv8gtTC
        zmIQfczBpxm1+sD8pEcBXKMRpQ==
X-Google-Smtp-Source: APBJJlERTWUt1nW1R3qthtM4b3NkqQF+8nog8fJNhfRAzWktGBzBiTc3eX6IscM8Ccgn5kp0ki4mwg==
X-Received: by 2002:ac2:505b:0:b0:4f8:5886:1868 with SMTP id a27-20020ac2505b000000b004f858861868mr12413967lfm.24.1689085268998;
        Tue, 11 Jul 2023 07:21:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24297000000b004fbdd19c926sm336482lfh.284.2023.07.11.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 06/18] soc: imx: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:05 +0200
Message-Id: <20230711142105.751611-1-ulf.hansson@linaro.org>
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

To simplify with maintenance let's move the imx power-domain drivers to the
new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: <kernel@pengutronix.de>
Cc: <linux-imx@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/imx/Makefile                   | 7 +++++++
 drivers/{soc => genpd}/imx/gpc.c             | 0
 drivers/{soc => genpd}/imx/gpcv2.c           | 0
 drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c  | 0
 drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c | 0
 drivers/{soc => genpd}/imx/imx93-blk-ctrl.c  | 0
 drivers/{soc => genpd}/imx/imx93-pd.c        | 0
 drivers/soc/imx/Makefile                     | 7 +------
 8 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc => genpd}/imx/gpc.c (100%)
 rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
 rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)

diff --git a/drivers/genpd/imx/Makefile b/drivers/genpd/imx/Makefile
new file mode 100644
index 000000000000..5f012717a666
--- /dev/null
+++ b/drivers/genpd/imx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
+obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
+obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/gpc.c b/drivers/genpd/imx/gpc.c
similarity index 100%
rename from drivers/soc/imx/gpc.c
rename to drivers/genpd/imx/gpc.c
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/genpd/imx/gpcv2.c
similarity index 100%
rename from drivers/soc/imx/gpcv2.c
rename to drivers/genpd/imx/gpcv2.c
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/genpd/imx/imx8m-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx8m-blk-ctrl.c
rename to drivers/genpd/imx/imx8m-blk-ctrl.c
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/genpd/imx/imx8mp-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx8mp-blk-ctrl.c
rename to drivers/genpd/imx/imx8mp-blk-ctrl.c
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/genpd/imx/imx93-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx93-blk-ctrl.c
rename to drivers/genpd/imx/imx93-blk-ctrl.c
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/genpd/imx/imx93-pd.c
similarity index 100%
rename from drivers/soc/imx/imx93-pd.c
rename to drivers/genpd/imx/imx93-pd.c
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..3ad321ca608a 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -2,10 +2,5 @@
 ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
-obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
-obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
-obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
-obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o
-- 
2.34.1


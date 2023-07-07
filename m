Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCC74B285
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGGOFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGGOEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:04:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0A11B
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:04:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso29518921fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738689; x=1691330689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF5D6DQXm7HmIRP9eyngZlJuQfQ9Itx50jvuqv/ykMM=;
        b=JMbAWi+fqDg/Evsupl0EVzPs2UcPCdo38/GO8Pg20qBSNf/atPExZKLCAnwBkE8A15
         0eN5RsPtrjRsWt9jqtT9+0zbq3+x1SsOFYNYBgGsKW22XOWNjlKkRYC0Z0WSqhX1W6fG
         pVfjMo8zwvUcXvuhgk/5JWv2MCECN/O7LDICkaUoSijBElVdNPn8ZVPhJ7WSq5x59blX
         nYWDzpiX5iL/vDFWnSUxkiNFefEV4tcfqRFaXWoDDMIOxdXLGcUXqKmw96tTxlDlsjPY
         CmRpQdqqF++ZP1c0suy3JdKSG+OU/x1BQnUBiFpDLlex8QP4Av3aKtbnUfJbKMKLiKsA
         ALTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738689; x=1691330689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF5D6DQXm7HmIRP9eyngZlJuQfQ9Itx50jvuqv/ykMM=;
        b=WVQ22hvu8zdzgCgjLuv40ehFY5nPtnkqC6I7BD1+6lrq79703+dQdCLyOxdDBQ+tjC
         XhSIRoKhtnB/+MA0W9EDl13+0OMfY6ZJBbnJzLYZZ5QLzxTB8wwYzrpntJlO4FspoXA+
         ZFlD3umaZkjbERGJ6OKeICgXZsLQIvxJONmT24eblMkxL+Q0ZdNokmV8Z5pBfZOSSY/X
         X3ewH3Slr7mpVdEm+Yyftsw/kyBDKpEYqeQsmin1D+yG8EfIKRDUehT8lBGn+NCvJQ7i
         JQLeASJkDOWnQcuWo/sG7g2UQoomR/j1JpwcAbFpfdcXGyASoxspzGo2bJ+SLzne71x6
         KLKw==
X-Gm-Message-State: ABy/qLZzmtyRVdnrIL1Y6xO0xzMtiEKQ8hfXD9SzQ8OJNO1I39+YQ1wA
        1MpF3ZT2PtUpGrMCoGiAqQm6qA==
X-Google-Smtp-Source: APBJJlFb6SSYCwJcJTyrOC/BxJjT8XyG0bkUDGjb3F1FZA+EfYbKiuxmfkgwjvgd+gPEnXSAymZUVQ==
X-Received: by 2002:a2e:b0c6:0:b0:2b6:fa3f:9230 with SMTP id g6-20020a2eb0c6000000b002b6fa3f9230mr3630259ljl.46.1688738689714;
        Fri, 07 Jul 2023 07:04:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH 06/18] soc: imx: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:22 +0200
Message-Id: <20230707140434.723349-7-ulf.hansson@linaro.org>
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

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: <kernel@pengutronix.de>
Cc: <linux-imx@nxp.com>
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


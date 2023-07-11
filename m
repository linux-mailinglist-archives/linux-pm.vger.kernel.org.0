Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9874F230
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjGKO0Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGKO0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:26:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5926AD
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:25:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso6933308e87.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085475; x=1691677475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ETzJnyxb//1LYCRZgH6X5nK55znbdEdKT0t8qjhkAw=;
        b=TpQjD365mxeGXkAjNS1Yg5OzWV5hWBmQFP1W5jq6C/AgtBmyVfUiBwjjdYXC8Eae1p
         gzTVXLqA/LRNhkzEferJ0M3dGsZ8dYPRip9BB5MOCbevyG2N2xyIyS8V1PQ5paNd7W4S
         MYQukgp4KFF3xls+tzfj7Gjv0b1HA9RRV5PmYg008NBqRV9o4zLoJ+RMcekCayb8I+XM
         e1/HZ+1yH4cfLg3ulOsh1p53gr6Hm4neaIhMNFhBlZRV2NrRWRVzSouVSULYQwrSio1t
         +7lZ7G99ooRXummOAXo3N2Yxu5iF+kBjbhyypd/bSwwiAnWmTQr1ososN+jB3VRANZJG
         oMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085475; x=1691677475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ETzJnyxb//1LYCRZgH6X5nK55znbdEdKT0t8qjhkAw=;
        b=X87KUGmt78e2R9ERoLjglkYUEX8Ncx9DwDe8Dc3gC2k4omCMv/yoy7qMa+tKDJcgPR
         JTBcywg0JcnY28yZ0I5Q+H/n0/z18S+rAa8izrf3+1pfu246/iMoF1nFmtHEEJ4RIXVP
         7bgPmZNYmNipEX/W9DjGJJJxL8I0vd/vRyVUpKUIpqo1pBBu4jvLQqYO3KTu1vlFwnkt
         7HCV4QxpRZr4KRkM+zdXq77mAEOFWWTRwnH+7Mgx0yvh2kzKzK6vv0/0iKeoB58qeBSw
         wSMleqq/Dw0RdOyIaPRWaUdLcpiJbkarsLzkvz2b7IebLmHvY4qEK36jqlHQVlDaPj/h
         MvCA==
X-Gm-Message-State: ABy/qLYcby5fCstWEdqWaULRjoLv/8d6uSBd3MQSqguuyiVJRlNeBN3e
        uVUiHYlhbtdJzcFwpsbaQByDNw==
X-Google-Smtp-Source: APBJJlH5vtnfD2VWOxoAWSTv1/4Sxwt9FRzf0RXakCeJHs85TPWrAyK4Co3SRyIcN0Rf1+grwX7y8w==
X-Received: by 2002:a05:6512:4016:b0:4f6:56ca:36fc with SMTP id br22-20020a056512401600b004f656ca36fcmr7142871lfb.6.1689085474936;
        Tue, 11 Jul 2023 07:24:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g12-20020ac2538c000000b004fb763b5171sm341888lfh.86.2023.07.11.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:24:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 03/18] soc: amlogic: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:24:31 +0200
Message-Id: <20230711142431.751888-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To simplify with maintenance let's move the amlogic power-domain drivers to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: <linux-amlogic@lists.infradead.org>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                        | 1 +
 drivers/genpd/Makefile                             | 1 +
 drivers/genpd/amlogic/Makefile                     | 4 ++++
 drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
 drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
 drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
 drivers/soc/amlogic/Makefile                       | 3 ---
 7 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38eebcc97aa2..ab583b8c5b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1843,6 +1843,7 @@ F:	Documentation/devicetree/bindings/phy/amlogic*
 F:	arch/arm/boot/dts/amlogic/
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
+F:	drivers/genpd/amlogic/
 F:	drivers/mmc/host/meson*
 F:	drivers/phy/amlogic/
 F:	drivers/pinctrl/meson/
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index a2d5b2095915..cdba3b9f0c75 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= actions/
+obj-y					+= amlogic/
diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
new file mode 100644
index 000000000000..3d58abd574f9
--- /dev/null
+++ b/drivers/genpd/amlogic/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
+obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
+obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
similarity index 100%
rename from drivers/soc/amlogic/meson-ee-pwrc.c
rename to drivers/genpd/amlogic/meson-ee-pwrc.c
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
similarity index 100%
rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
similarity index 100%
rename from drivers/soc/amlogic/meson-secure-pwrc.c
rename to drivers/genpd/amlogic/meson-secure-pwrc.c
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index 7b8c5d323f5c..c25f835e6a26 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -2,7 +2,4 @@
 obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
 obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
-obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
-obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
-obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
-- 
2.34.1


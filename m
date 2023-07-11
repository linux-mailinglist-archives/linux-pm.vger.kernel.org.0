Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2674F1C3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGKOVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGKOVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:21:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89518127
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:21:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8620364e87.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085270; x=1691677270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXan3BQLOGVU26VVDfqibPbUTvNWRP/07Lp3Hf/FNck=;
        b=lqdOYmJum9lMmusdABBEDrPfyUPjmg1sjbjSj1BPzNzMuneGmo7eOt4BUjUfk8hsLF
         c9ZYo51BCaW/v/SVJqECrHEprdjqX5DqAMt/j0ehhKlz1fKlPyfdy2lyQ4AmTHUsruVm
         JUmhwfyQq7rfOy41Z/YBktXAS41K89LRxtSYcfkgitdjoSuN0YSvBGSYYUUvw0IgkCym
         xdDWrSZyl4UdR00HIApafCR54d+zWGEtz686I7ufoGIsv4v+0fedXk+RySVdqPAPSY6c
         r/SOS0gtdeUgiGvZU4gcpv+Q3XffdjBock02DcNDzVhPd3e4pHyQv0Q8A8MpKxG+oy4M
         0KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085270; x=1691677270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXan3BQLOGVU26VVDfqibPbUTvNWRP/07Lp3Hf/FNck=;
        b=fUctKbySxCbLV48TAcFnjbMvbQgLdal/MoKdIkcbTbi4ZBUf85aY/5aBds2q0vvb2q
         HswIhPjekYqNw8VV5BrjuKgdRh21u128WFNE0wXv7K9MYs7ceBSUoMGZgVEnFUFGPfSR
         wNT7l4Pmx/Uj1JiS3rRtPewxqTGw0212R2os5Q1spXoZ6V0he+IZTCkbK+p5So4UnXPW
         4bylDAJsP5v2Y80/rfYYCSjkfp1qh5GTZPJpF4QiW2f21SE7IUOVV9ttbREttVkYDaUL
         6YjqY3/WahIsInDUWfXgqyXRSHDUR1t6HaOmB5KD93WBx9gpiz0JKBM/SA9YecZ5asIB
         oHBg==
X-Gm-Message-State: ABy/qLZmU0N3cMDsaYmxgtBQSqsM26YkwK2Nz5kmiOGbelHnHXCSacqJ
        /b7ii8sAuLSraQRfwK3XL9eNiM8jZfz1jvbJ4UI=
X-Google-Smtp-Source: APBJJlF/tD2PTLs1zZYNjcNoPQ6bP2DE1k5mx9xYe5Ulksm+zK79IQNLAEUlrHt6/v+3TKR4FlVmoQ==
X-Received: by 2002:a05:6512:b99:b0:4f8:68a3:38d5 with SMTP id b25-20020a0565120b9900b004f868a338d5mr16890335lfv.66.1689085249578;
        Tue, 11 Jul 2023 07:20:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id j14-20020ac2550e000000b004f9fdb0ed8esm333145lfk.304.2023.07.11.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:20:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Subject: [PATCH v2 04/18] soc: apple: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:20:45 +0200
Message-Id: <20230711142045.751570-1-ulf.hansson@linaro.org>
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

To simplify with maintenance let's move the apple power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: <asahi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                     | 1 +
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/apple/Makefile                                    | 2 ++
 .../apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} | 0
 drivers/soc/apple/Makefile                                      | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab583b8c5b97..caa221fd0c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1904,6 +1904,7 @@ F:	drivers/bluetooth/hci_bcm4377.c
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
+F:	drivers/genpd/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index cdba3b9f0c75..91d4a3808981 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= actions/
 obj-y					+= amlogic/
+obj-y					+= apple/
diff --git a/drivers/genpd/apple/Makefile b/drivers/genpd/apple/Makefile
new file mode 100644
index 000000000000..53665af630be
--- /dev/null
+++ b/drivers/genpd/apple/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= pmgr-pwrstate.o
diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/genpd/apple/pmgr-pwrstate.c
similarity index 100%
rename from drivers/soc/apple/apple-pmgr-pwrstate.c
rename to drivers/genpd/apple/pmgr-pwrstate.c
diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
index e293770cf66d..b241e6a65e5b 100644
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
-
 obj-$(CONFIG_APPLE_RTKIT) += apple-rtkit.o
 apple-rtkit-y = rtkit.o rtkit-crashlog.o
 
-- 
2.34.1


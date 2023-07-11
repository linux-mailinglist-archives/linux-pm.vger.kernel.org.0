Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011874F212
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjGKOXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjGKOWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:22:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B926A9
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so453225e87.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085327; x=1691677327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs5HDm6ClAZIf3WkkOUYl2r52GqE7LmKxr5cfVC2LLc=;
        b=jc4XrpikC3c2UuGtvw5CwGWN3nmPyvXxozjIL6j5tRHo/XZib9AMRJX66OHyorPEO8
         msrKHJdpC9eP+Wqsn2i+IAzPLH/g/IuEoD9c36i6GFCwEaq9wgsvEguoJ4xviORcFhgv
         vAT+Y3Wjs5iYZE0S7400sbFyJu8ZHR0jOl+ysnCXzK/K3C4NeV18TqHDS+hpaXDR1b7X
         gd2U3mWP9Sw9lxmt8TBkYhMYA67lzH5aMqWDJ5DvpVQK7IKVvsXLDFfXRY3/c5cgJwIy
         3xv/tgd6/y7WxqRd19RRrsdoANjXq2eHmbrortC/HhtogF2KadfLeUZ2ZX1kZsyiYWRz
         sSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085327; x=1691677327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs5HDm6ClAZIf3WkkOUYl2r52GqE7LmKxr5cfVC2LLc=;
        b=CKOSmzKi187VuK+LyFrx2z6uniHWK3EI2nktc4pclidfMuo3HHn+N7Yh+xNqd9Tqlw
         439uxnZ5amPkILwe4uZ4OVOKRvN+RVCt2VTKpGPk1oJpTiJrZsPVjslo6TFZXrjvbRHc
         OBe7363pXMOy7CVe9iXvtU9dJoG+t81Iuz6TfhxsWtYItk+q/HdGf/o1LFG/bKh6kD1h
         FzgTu8wgVs7E1lbDWI2k0Ok2K9ReivnbUrNYzuGUd1DcDv9BSHhv/5xX2B70F2cxDNvX
         qcloEoe6HB/VPLA38zhXTQd3sGI2GiwGJFNvfIhDxzw4CAgPNy900tNTzNJG7GAnATtj
         d3RA==
X-Gm-Message-State: ABy/qLbRx6ka9Mg0Y1b4tvANMyIEdB4/QtriurgfdcYWeiryb8wyF3uy
        7Aco7clGMSmmw05SPEakrsfRcw==
X-Google-Smtp-Source: APBJJlGv0oKmDLjWCKzWfjK0JMEvmmjGq+p5yDLXp8SCG7qJLArfkjI905UBeAZEoXF0MSLIsp07fQ==
X-Received: by 2002:a05:6512:3f3:b0:4fb:772a:af19 with SMTP id n19-20020a05651203f300b004fb772aaf19mr11433025lfq.34.1689085327565;
        Tue, 11 Jul 2023 07:22:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b004f858249932sm342123lft.90.2023.07.11.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 13/18] soc: sunxi: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:22:04 +0200
Message-Id: <20230711142204.751754-1-ulf.hansson@linaro.org>
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

To simplify with maintenance let's move the sunxi power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: <linux-sunxi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                    | 1 +
 drivers/genpd/sunxi/Makefile              | 2 ++
 drivers/{soc => genpd}/sunxi/sun20i-ppu.c | 0
 drivers/soc/sunxi/Makefile                | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/sunxi/Makefile
 rename drivers/{soc => genpd}/sunxi/sun20i-ppu.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index baf2021235a7..76f2a411e6bc 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -9,3 +9,4 @@ obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
 obj-y					+= starfive/
+obj-y					+= sunxi/
diff --git a/drivers/genpd/sunxi/Makefile b/drivers/genpd/sunxi/Makefile
new file mode 100644
index 000000000000..ec1d7a2fb21d
--- /dev/null
+++ b/drivers/genpd/sunxi/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SUN20I_PPU)		+= sun20i-ppu.o
diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/genpd/sunxi/sun20i-ppu.c
similarity index 100%
rename from drivers/soc/sunxi/sun20i-ppu.c
rename to drivers/genpd/sunxi/sun20i-ppu.c
diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
index 90ff2ebe7655..549159571d4f 100644
--- a/drivers/soc/sunxi/Makefile
+++ b/drivers/soc/sunxi/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SUNXI_MBUS) +=	sunxi_mbus.o
 obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
-obj-$(CONFIG_SUN20I_PPU) +=	sun20i-ppu.o
-- 
2.34.1


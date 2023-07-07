Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636574B299
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjGGOFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjGGOF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6D2703
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:05:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso30705551fa.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738702; x=1691330702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C42FrWKbauKrpHyGQL85ov8a9IzG5rtXeIwWVhxtqVk=;
        b=MCu7vlROYZ/xIKEYZmjZztxNMAhryMpK0Unegzg8Q/0Z0ijMjupo0Vj5o5KA/+OE+J
         XFiVISB2r8qtP8rYoLnpVNxW8FXFTbJfkeKDW9l4Dkb8UUmR5LqMhAVeRaF7AumW79Jb
         RXVGTkN9yite37tYrCtpU9vqK64UbqszV80El/ekskzn9wowhvbQmaraxzrrfeJcOMlN
         hOZiVmq/6FjsdDG1LrZM3sauPgkivdWBYOgFZ46y9Gn/mF11V9jQc3tGfUG7Y2KYnKc9
         +nKM1MJF6h60t4rdpGe8CblT4AZ4UOXr7xH/DPGqRF9fgG8WLARufHtNFBcF8EHyUcjx
         h+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738702; x=1691330702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C42FrWKbauKrpHyGQL85ov8a9IzG5rtXeIwWVhxtqVk=;
        b=J361laQeRznp3AjTlKQ9DBKjY/j4kaOi0e4uB5Cu+1sUtmbvdwzLu/8hBPg1fiml4h
         hn2FIQ+zAxzs0Vd3cPK8wRQkfXKEdGdjYSFyF+JyQyPXz7BaBV7t7aPQhF0oJ+08ski9
         vjmOrQb5kD5I57Ekv5enkCkwal15RrBGcaBAbJyARGXT2cwRwbZjTcoEj8IAK04ME80a
         mfs4JinOBLdKKez9kWAurn2xdUUDWu4ZAZM05cdRfiwnT+95i1FYEA7X86yGjXaNgIwK
         kPGSz3fK/wJrS+h7z+YlYb1pvl+0oKOhsVQ61gAfoWK6k642AdMR0jzr7CBa9a2gYCvZ
         0zew==
X-Gm-Message-State: ABy/qLbToPxkYx3a9nT7a0hUdjtk8WguGxqC71A0OsuXZyUpgFSQVcRA
        QNH3UrQxFFm50Yjak0KxEpsUxg==
X-Google-Smtp-Source: APBJJlGEv/lo3wa1G7PQ6zQPPu2YP1CoXxXtYuj6YVBRNt0l/8ADVQL/9ApsIP43zURVV2GBgM+6Zw==
X-Received: by 2002:a2e:99c9:0:b0:2b6:ed7e:5a74 with SMTP id l9-20020a2e99c9000000b002b6ed7e5a74mr3830249ljj.36.1688738702659;
        Fri, 07 Jul 2023 07:05:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 13/18] soc: sunxi: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:29 +0200
Message-Id: <20230707140434.723349-14-ulf.hansson@linaro.org>
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


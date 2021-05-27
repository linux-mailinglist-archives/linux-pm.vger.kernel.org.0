Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C539376E
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhE0Utm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhE0Uth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB8C061763;
        Thu, 27 May 2021 13:48:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e2so2578575ljk.4;
        Thu, 27 May 2021 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=palSs2ovhpm3GLHjVJgVWfSUR62+snPsfg9/z1qkuvycX5RDA2cwyHqNof6zKW31dJ
         lTZD6Fs5nchkWmLqfsSQb8V01eNqMu9DpDRSZ5Zu8KE+oQo/eQbonRtl8W8AURSOUwQ1
         kWcV4CE5csd0TwlReDGs7cDXi8XJIJ2PM3sL36rJLtemEwjj3JNygyvXEZ9jh4hBvY8E
         8viVgsd+QrLWM3UdUYZ+Bg9ATx/x3/fAqGGk/RTfONCHqTs0m3arSF+2oEX6A/DWNh+E
         wGz7kklaZkEGys/IjFKNxb6kkjjmXIdBe8+GnoLoLOpXeXXpafP5e9eSPRRxBPDZhyoE
         z3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=jyudNKJbzLGe9018QWoTjBDTFAPxf2fC13wsbP4laCeZ9Y+5jjz55/UhvtpegHUTgA
         ViND61/Xkm6v5tsfVP5uGvdoAygwYhlF9C+kXsuhbnfxKSeeAoLg/ZRuWiqubTTwIihe
         z8VUIlABp+dWKuL82HUHLluGeFX+8prAYl1m865BUBAj9evLzAGEG2L3Zz53I15IA4qA
         z1ivdAHq63C0hQfAXG/vdju7hu6ZRt4IMqMNDoncl0fG1S+TlIYv/L8JBcbzLLp9CblH
         1tcEtlxELY9XjxQTG8vjs05+tYJkQMhAtseYPOMloSpKr9ekHKN2rbRmm8qWxmNfXqg+
         KIIg==
X-Gm-Message-State: AOAM533X4pn4Q9pHtwjyvSWiLdcsqIuHbp9plianeIHhu9KwmVOpxXCa
        EgDKCSdF675aDvHa0R9RCzo=
X-Google-Smtp-Source: ABdhPJxuPNZQAb9teMzr4D3kebJBEENLfmjh1BWjGyq2oaeaq3k83MSvnXYyWiHHUlqxdrMenFgD+Q==
X-Received: by 2002:a2e:bc23:: with SMTP id b35mr4023105ljf.378.1622148481836;
        Thu, 27 May 2021 13:48:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:48:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 07/14] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Thu, 27 May 2021 23:47:35 +0300
Message-Id: <20210527204742.10379-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix compilation warning on 64bit platforms caused by implicit promotion
of 32bit signed integer to a 64bit unsigned value which happens after
enabling compile-testing of the EMC drivers.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 4 ++--
 drivers/memory/tegra/tegra30-emc.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 5699d909abc2..a21ca8e0841a 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -272,8 +272,8 @@
 #define EMC_PUTERM_ADJ				0x574
 
 #define DRAM_DEV_SEL_ALL			0
-#define DRAM_DEV_SEL_0				(2 << 30)
-#define DRAM_DEV_SEL_1				(1 << 30)
+#define DRAM_DEV_SEL_0				BIT(31)
+#define DRAM_DEV_SEL_1				BIT(30)
 
 #define EMC_CFG_POWER_FEATURES_MASK		\
 	(EMC_CFG_DYN_SREF | EMC_CFG_DRAM_ACPD | EMC_CFG_DRAM_CLKSTOP_SR | \
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 829f6d673c96..a2f2738ccb94 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -150,8 +150,8 @@
 #define EMC_SELF_REF_CMD_ENABLED		BIT(0)
 
 #define DRAM_DEV_SEL_ALL			(0 << 30)
-#define DRAM_DEV_SEL_0				(2 << 30)
-#define DRAM_DEV_SEL_1				(1 << 30)
+#define DRAM_DEV_SEL_0				BIT(31)
+#define DRAM_DEV_SEL_1				BIT(30)
 #define DRAM_BROADCAST(num) \
 	((num) > 1 ? DRAM_DEV_SEL_ALL : DRAM_DEV_SEL_0)
 
-- 
2.30.2


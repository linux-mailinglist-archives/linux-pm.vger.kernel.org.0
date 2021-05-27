Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876CB39383D
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhE0Vpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhE0Vpf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110BC0613CE;
        Thu, 27 May 2021 14:43:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so2281695lfj.1;
        Thu, 27 May 2021 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=UvAFDXd9ZhY5H5Qe2SorzXqtsMKT7W8IWcpABGT7kN0kOSrqn0hnfOywyzzdF/5dIC
         jfCM/qF9WtOkERpUUU/URO/lGzjf29oxT61cfsn5zSZxKeRbSoeooIynAkmybiSi93ty
         t0s5Pdekqd/sbk5sRPA+NQLX/L2QRbJvhKIl/eYlaJDdmkRwdotVCzjZaamWZ4Delaai
         sDcjpnqTQohwNKNImQ0GtvGASqdI6wLyj426CXdcQ2NTWNrCDxvxu5PFfznz1AkVvK5H
         57iHwJ+EnhBWH+s//jcMVMa6mLl3bW2JOSDUJELpoBb1CacxuDkbhA7PP0AwhQlz8gUR
         GmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=VjFnbs4/soII4Bx4zCY+VzjS8aE0t37t67gaQfm6L+kdVK+BrJaWelWaKvAi1Wc0tz
         GNZx22UiK0QyC0oFFZyKSF7XIM4qZWjFx3jXJ9tRc7qCgKkA4OQyLUArYgSJXgBEvh3Q
         acBzfDsOZ0GMMpNJY4b7kASPCku2td7B1q8zJIlMcFvDNVDzUb4LzMu8vr8oXlmJwF0C
         bF/nGayOUeHsgWarObAZ3jeloJGrqtqGaWUW+FbcxwVs+yYv1FbPtJwJ3kO+pdLp1KZ6
         SS0OTw5N+QFWVk2c8j+MoAQg8d8+/h5ntbCKBVi9Pw8ZoUmkUo2XFEPTFMNdi4/Oo1Fl
         Utdg==
X-Gm-Message-State: AOAM532P3HeG/3DxhqVJWIOY0ylJeTDSo9q/ww+BXq8H/LBDFvDoj1fB
        xF3zscR90CT3Yaf7gn75zPo=
X-Google-Smtp-Source: ABdhPJy5GkP3F1HXH3SDY5dJLOmOHXkyM1oICtkpsLFoDAOVoOlhJiVL9lgrhtoSTX2C92/Kqo7LXA==
X-Received: by 2002:ac2:4281:: with SMTP id m1mr3505892lfh.164.1622151837830;
        Thu, 27 May 2021 14:43:57 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:57 -0700 (PDT)
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
Subject: [PATCH v4 07/14] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Fri, 28 May 2021 00:43:10 +0300
Message-Id: <20210527214317.31014-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
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


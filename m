Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA874393999
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhE0X4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhE0X4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED37C061761;
        Thu, 27 May 2021 16:54:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so2638840lfr.6;
        Thu, 27 May 2021 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=KDnbtnGV0jfVfAuHcB290foxY6Tbn+jnYmW1rRHO3TMbfuyaUsNHenUvBcof2abKi/
         /HADINmIQF0nwpHfY6+9S684eaw90oYytkJfqqHvq3b5pz6LN6N3k+MZ7sNKK1Zp8Jk4
         WSQAUWknaiM5NQrDzmLIJYHW4/tkoBolMWz7zzFj0qilAfXog3Xl6J739UDbpmQUQ2ZD
         5HnCaMQCP8fdL9RRN9lWKO8Kt6yIlLRdo6eeBi3ZmV3H0BPsGQ9emfFVlHeBuEzuYnXQ
         Y4pCsFjCpLhq+Nfx5RUm1bmzOJHxIrsBBce19ROLr5wDYO7/HXWIv37ETtGQdKreu/4v
         yTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=iX9+2bbHBiYxjigOn6fhBd9x8uo6+OPrqv0m+AvRsOlt67XXtUDFv2fVIcl6m9lrEU
         VD3HgZvoA0QdbXXzXjFPwHWlg/6RXaAjzNl98XyLv7fFIzRrAMMVFETsQi2y0maIUgZC
         lKhHZcuWYgI2NLZftSBmrfM3tl7aHmPsti1Aj8JXq8LOqtlP2OAf0+UP8AdbSOgvXEap
         eOpCgzGSX1A1dlaHCA6pBszvYeOkERMPNMmbtEQdgA3/m0G+D+nIW/uHvvidSs6AJri+
         epaJe5TaBp1JElevQ9MO1E9z8hthx3oODy1dSuSltSRHQNHfanwLwD+aW89eNOzNmdfY
         Oz4w==
X-Gm-Message-State: AOAM533RlBrGDGBgb8aShjJn1u2ynXiCnf9xVmqQ3DBPnx8fcWce3wAc
        YRFXPVEaQzQdbhbW1AAYVFc=
X-Google-Smtp-Source: ABdhPJz5AKHDk8x74UYjdKipGVHmsJePpFiLHLisIyYcMrzSWkkK2n0ebC1GA2jYNVOsPoV53lUoZA==
X-Received: by 2002:a05:6512:214f:: with SMTP id s15mr3865979lfr.243.1622159664724;
        Thu, 27 May 2021 16:54:24 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:24 -0700 (PDT)
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
Subject: [PATCH v5 07/14] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Fri, 28 May 2021 02:54:06 +0300
Message-Id: <20210527235413.23120-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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


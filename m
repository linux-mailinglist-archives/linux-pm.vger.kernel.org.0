Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9896738DDE8
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEWXPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhEWXP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BEC061345;
        Sun, 23 May 2021 16:13:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r5so37964013lfr.5;
        Sun, 23 May 2021 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=OErM4JnD/gNFlqVqIfLc/n1bSFiUmbHNPFwSueq2QklEP6f+NAhNETDOLYVqxwmbRX
         ivXdvTxPtUFu4a4y/+LOWquMHqFuWQ65SU5N4S2S3pZudUc/WB8U0M9HXggXHTSZOmOK
         yV+iNAaGq8KWr283xFa2OqjSeTR6+raNTXq7ueA3fGNDSIO6khcCmQ5zlTSdQ26+AsHW
         K1Rt6VtvdEu/Vx3edtIBDAiOXjym175w8cpPRTMcYaLSiaesHFGXdSytJ6Ew6AcDG/OM
         wF46nsWL9PZKiJmAi/lMeTav+kdd/lzUT+bpyviHLQfcYd7k5PiMXO+X5JYlYDgMsH7+
         /UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=EuHfgXag3mIhWMMEmCJ/rNQBAj00ARJtPd9zkrKnBRNQ4GLTbDhtHR1nA5jsfcSovg
         svxhzMf5m6EblTm12mtODdOhFIhQikMfg5XBMJP19gTdUSNzx+1jdFiYP4uUPbDru0Tg
         GAV8DhYxR5ip9/ahrpGeX35UkVSsxsSJC2QzZTCsIb+iIJ9AxmZhjA1onIJ9Zg62CXls
         cKXYYO3mUq5NmsGASy2FavZJi+y7+UrG4Qbe4U7b8YrHgW9AB2p0uHvUAE+eOGeXsksD
         vefMmImDc/TkhF7axEiKJkQpTeemwKy9EIg967UBkeOtGvltK4OYWVuojYeGQwPzrc63
         qdIA==
X-Gm-Message-State: AOAM5319nSmqkF/ZWSLFQFoSWBxpDvZ7pQ78MopP4D/A3hjeSLbfR+jQ
        5iVA/Qz0c/n/qT6Jwxirtj8=
X-Google-Smtp-Source: ABdhPJwHw77jRCGdYpUCUG2K1ICDGwBzfbsCsdbUy3ZzArG9bswCglF7/0ZUFRhjxGhiC0ZSwJl92g==
X-Received: by 2002:a05:6512:2399:: with SMTP id c25mr8981296lfv.59.1621811633986;
        Sun, 23 May 2021 16:13:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:53 -0700 (PDT)
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
Subject: [PATCH v2 08/14] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Mon, 24 May 2021 02:13:29 +0300
Message-Id: <20210523231335.8238-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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


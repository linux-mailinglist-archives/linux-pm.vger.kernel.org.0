Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9DB38BA23
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhETXKR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhETXKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21EC06138B;
        Thu, 20 May 2021 16:08:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 131so21797567ljj.3;
        Thu, 20 May 2021 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyfuUJygPypv3PLq8+UwCGzuqV5dXIOCDthlvjoInWA=;
        b=lrCzowrEA2YL5iBi5edNzQ+WSfZSB+9c0qNQDEe3fkMhAStJG0QnIVnJe4Q/aV6RcG
         55LDUra4Qrct/27K3vrAmF7egfwsr3FmU6PDzPDkgZh/4dRBjI0gWvkBJ4llg+PF/9zi
         mmyr1WgOlnpTLWApwP4H2XzUONL5NFszPF9ZwgBVt+f2lAVMOw+E5utIa7vTDBH5lVSH
         uBzzSlXy48vpO/TKgXQ+V2uYkzIbahqKnWyIyMGHUnPY1jsaLhNoQSiBMD6eeUrC2cIt
         rOmW5YYH8tEHJry44EMhZ44jOxVKKpUkpsqByx1397N1NQAxFq8obRqpsrc/CqtMNyag
         9rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyfuUJygPypv3PLq8+UwCGzuqV5dXIOCDthlvjoInWA=;
        b=nmCDJUy/R1tK/9RokBncUZSOSmrEpWctmb2RQdYxIDKbgsA0a2+Z24WNqsNFcBVjMw
         jYy66LFSxj5VR8gyXlT9+MIHU2PjLvu/lAMBIDQqt4t16Ci8CWpz7gAFVeRoRkj3LzXp
         6KUd6ZkiZtNHH/mj4Uyj8zRKcVWFIHFZTuSayShrqjHj4HLXyOIN3908gnxYYx7Pppz7
         V4L7d+MT1iLsdvZWs1V/P3l/c5Amd6DjFW3TPRbPhKTgAr/xla3ZnyH7XpzSC82BwEJh
         U1UcIH8YasvR8zL0wY+5y2RH3N39TzOEqVX/KKy3DA8WmNFOmeqIPk2Yw0DGewWGPgHG
         Qw+Q==
X-Gm-Message-State: AOAM533fng/RE8tAd/Fb32XUuFW9voRmGU6ZkjhcFHxkUX8gEPxVGO1U
        Lu9rJf35xTCjCvJ+jIRK+RA=
X-Google-Smtp-Source: ABdhPJy4cHP6cqgA7BLVTv7uNonvfnAu9aOfdSUF9/JoTjuLftMsSikVyUxDnan3jb7UqTzaDAWQ0w==
X-Received: by 2002:a05:651c:1404:: with SMTP id u4mr4456555lje.451.1621552125727;
        Thu, 20 May 2021 16:08:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:45 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 07/13] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Fri, 21 May 2021 02:07:45 +0300
Message-Id: <20210520230751.26848-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
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


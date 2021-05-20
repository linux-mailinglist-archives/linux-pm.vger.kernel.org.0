Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920D038BA1C
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhETXKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhETXKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0FC0613CE;
        Thu, 20 May 2021 16:08:44 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e2so15473628ljk.4;
        Thu, 20 May 2021 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=e2FjZi+8NBZ2j23qE6JVdDFNO7zm74l86MwqIF4hhJR97385fP+o3MGwbtM3G4AslG
         EYMBdIV2xPEVpHcxikUkmts1pnlsZ/gfsIxBI+PM/WGo3i+cQ6ppBbgHc9JVeDat8ZVf
         vj9yn2LSDp1HmNiCGkzVlIqIxyorA8BKClDPxXIgS7HNbZwPf4SCp94XQg2XWVbW/Z4J
         bsrhuqxFdF6tRO/2WSngIHEPp/kXretgspESeYtujO1mu6vIOr+WMxfy4N1e8yNL+d4a
         9F++9jx8/jcPRUkkZvPGthnrJNqSBPkgPkgQ33BSLLADoidrIwMBAo9xur4WSKQfwBpl
         QH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=LCcekUMxp9W+nMooO6PoeK8uFD3ZBNYKdRz0WvfC4fyLxVY1UJjhp+0tDov/PwB0Vi
         5Ih/GVBZgMyQxtpd+Lw7GBuG1afkKJuBHR12EcoiSOgVfOWkbotu3DGzoRbXtuXuLh3s
         JllFqQvzqOfcXQL9r2bZeXdUAAdRwv+sQ+SqorxIiDZVk5/7Bki64Uwm+TqZfFxuKz1J
         lZW3DqYsnWU9pl4XcGkekxO+r3e+Hhp1Loqt36pnaQCXJQ9kMR8x4ZdA8KoS75PDzG/R
         6KJWi9DkHtP5H3h+oZIubPyyM4EH+Qb3sQumnGO4eEt2rD3uZAIwmuWGLaG9wcvpmXk2
         A/oA==
X-Gm-Message-State: AOAM530YNLIiCFFOJjGu+LpMpK9xKGlkgqKXJw5X+hO2mK9/Fsqg2AAU
        e0j3pamSMsW6skkgb5GuceA=
X-Google-Smtp-Source: ABdhPJxgDBmSLAHBcag/fJfG4i7JYXQkhKFmHWdEPzf8c4nRn7SKiy956bXMClTASHuBRL+UJPOKwQ==
X-Received: by 2002:a2e:a784:: with SMTP id c4mr4454768ljf.95.1621552123390;
        Thu, 20 May 2021 16:08:43 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:43 -0700 (PDT)
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
Subject: [PATCH v1 05/13] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Fri, 21 May 2021 02:07:43 +0300
Message-Id: <20210520230751.26848-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing stubs that will allow Tegra memory driver to be compile-tested
by kernel build bots.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/fuse.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 78cbc787a4dc..990701f788bc 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -52,14 +52,28 @@ struct tegra_sku_info {
 	enum tegra_revision revision;
 };
 
+#ifdef CONFIG_ARCH_TEGRA
+extern struct tegra_sku_info tegra_sku_info;
 u32 tegra_read_straps(void);
 u32 tegra_read_ram_code(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
-
-#ifdef CONFIG_ARCH_TEGRA
-extern struct tegra_sku_info tegra_sku_info;
 #else
 static struct tegra_sku_info tegra_sku_info __maybe_unused;
+
+static inline u32 tegra_read_straps(void)
+{
+	return 0;
+}
+
+static inline u32 tegra_read_ram_code(void)
+{
+	return 0;
+}
+
+static inline int tegra_fuse_readl(unsigned long offset, u32 *value)
+{
+	return -ENODEV;
+}
 #endif
 
 struct device *tegra_soc_device_register(void);
-- 
2.30.2


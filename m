Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD239377B
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhE0Utk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhE0Utg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4DC061574;
        Thu, 27 May 2021 13:48:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so2572388ljd.5;
        Thu, 27 May 2021 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=o287LWBK3tchYnGzv75tfHJ1VdqUYTX82f7U34q1JZcC1b744czDVI5h+wBt8d62YI
         3BgNFPRQOjQ+mYvVUpUp9lpZfHZRvrd5g3ztj3FnHahadAkK4O4nQrZbgUDD8oWOgtgX
         dIGfS3CamF6KFcII+CFkYoDJCZxoYV+Dqidmbvc5EQ0j+xICVlbzl9SJF9EpcBQDZfbD
         AnEvbd9hIyksFc9LYzEcF3sjutA6G1olgWMG9Qem1Xeo+e4Fh/CJnJirYAiAmM6rIY3S
         NwA+/99uVrmgmhhnzbakcIR6K2vdxw4kzBqi2lRZieykt/zXezml0UcIdCVEG9wnyX/P
         pdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=bBf1shXf+5qssIWd5UHahk5x19Z+WvcI25vZf6WKoeQlD6VaD+RnSBs+s3exj8vDyC
         xfF13+BbeOM0Ajb/Sk1eV9fZqQ18qRenep0BNRXt0QGDmwL7+XuUN+PQnpkfOWKd4vWB
         KDfbcO1Kl8F9zUoqJsQ8eATXplgoN2R/g/qhU2huKTqhhETqka/gjqnzP30bl9Nn8ysn
         b7wJnCrnU/Z6JCMB4e8kEyDIASnJtbWSszDLurorxQFZJCvf54X2OuWZO+xL+uDIK1Y6
         lSlsceTNwtmfq3tNgYMwgwYkJIDXntmC9asLrlMqzWbyGJLp81Ro39YJMnZ1CvFdz0VC
         MUTg==
X-Gm-Message-State: AOAM533vebPQ8RfO095PdI2Qpc/PWGdiMyAokjiV7guEzVPFidcbzLzC
        gR0Zh/N5KBuvdGIZ4g9JbdQ=
X-Google-Smtp-Source: ABdhPJyNnSGRAZAdJaNO2CJRf8+LyjkeQ48ZTe7V0W88t44kISXEF12v+xfOJ1+5fQVAaXQ9m3fW7w==
X-Received: by 2002:a05:651c:210:: with SMTP id y16mr3963314ljn.386.1622148479669;
        Thu, 27 May 2021 13:47:59 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:47:59 -0700 (PDT)
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
Subject: [PATCH v3 05/14] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Thu, 27 May 2021 23:47:33 +0300
Message-Id: <20210527204742.10379-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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


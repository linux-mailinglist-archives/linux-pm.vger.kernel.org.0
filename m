Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658CE38DDCE
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEWXP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhEWXPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD78BC06138A;
        Sun, 23 May 2021 16:13:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so36646498lfr.6;
        Sun, 23 May 2021 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=CF37b7D1aqlYUSaBfq5pHb3uZ16z9XHH9PNfK51EeV8fyDfCZO3HksWbM8HZGP59gg
         rMKbxcRAM89QPqrHOsKfL7Z9OJL2L2uYgb7VR4AvEJHDpmBIz74iWudxbX+hMpmA+8Z5
         c3iVyepbvV6GdpS5RPG3XCH1b7Vw+/JUO+GBnCrmfG9KbVkDm7D5i3Ovy2f+y6osVoCl
         Vgt9ljFJxwgbnXF17GEdDZQsKNEIEiqSrlCcxn6drMhyVyxoapEWVfqRy3zsAOlK3NZC
         TMa4NtuBLq14GuS1jw+8xpkjKVdDkxqBRVxa0Pp7JaKdN9A69KHTRbQHwKvD2VvLcqOS
         g9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=IUswOQQUsvrOwJyu6jaJVrggyGzrDXr3vSfiHFJjmLEk/e5nGSgKZRKAGgJ3GnBcAD
         m0OL20GUStXMgRVCzo9rK8kPnUVEZj3fYjvUm6bS0DiKzfplqyfUP5df1TCpZOt/v67i
         KEJxTmqbCMau6ChtUNqG71xsf84EeCxYQZobwm8ORfRhwFCHT6FfUD49G2fHQvZm2D7B
         1CVNZr8E628xh/4UaxuYc1BkWNBEo2RydrWHD6sAVPu56m7Ds3zwPAGwXh4msWMeb+jb
         9dzBd5bRtO0TI1dQIU2OqxrDljyZjeVDbzrFgd7gqF830kk1kr/R3IfLYDn8as3PiWcT
         sQRA==
X-Gm-Message-State: AOAM530ehRVEGUAadxpO6AYa+/XwMQ/DxJDzpnvyNGhLor3StcQt9sul
        vItu+iXpICWRwCDd1g+5880=
X-Google-Smtp-Source: ABdhPJwJQsTanQYSjUwanuyy0AlMicehi5msnfCaCUyeZxLZhtapG+Iug+8a/zeIaoNZQJObQb8Wyg==
X-Received: by 2002:a19:7607:: with SMTP id c7mr8478184lff.58.1621811632217;
        Sun, 23 May 2021 16:13:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:52 -0700 (PDT)
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
Subject: [PATCH v2 06/14] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Mon, 24 May 2021 02:13:27 +0300
Message-Id: <20210523231335.8238-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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


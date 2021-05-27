Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5C393828
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhE0Vph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhE0Vpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57726C061760;
        Thu, 27 May 2021 14:43:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e17so2279564lfb.2;
        Thu, 27 May 2021 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=rUPMSMjLT+W0Mc7O4aPFQ9QWkBu43ZHfgZC7wWkB40kkC5u7rwm//A8izBgEmYafhR
         Ad0j/uMg0Z8laKg9A/IZ0BCSA59KXV2XhurMdKHBujrKfGd9sQTY8RmL53NnT99sI3TX
         ox8TCnXc+lc/qzzcrNR1pqeySEwX/+LfftV0vNpmw7PnZ3SLX0GrvNGpggRuI49CM8Go
         62OAy26SYrfuL+Nfpqz3nUwoAwLR20Lc6VutgSlZAFzei2fm2tw0TQ5g0isS7wGPiosn
         KoFf275KXbUi+p0z+GGtQdspEurOLi9PUAtpS6bXgX3NdlK6fTfwLsQoBQNkyE/VV/LI
         CMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=mwJtDYo12QpXQDY1jt2F9s/I2oEg7JOpGP1sM76+hsRb0jHeB/UecUPjlqJ09dGaLs
         u1e09tmfMtfOvtrFSoUx7H4As7oA+Jt2ZU7B+1K95m4lFnXPzX9coqxbkYb5Gdc8VQbw
         9XrUGMjHsv+Hyuh4qHTvUH+ijnWKja1YvF3q38Z2HFElfCp9dMhc81csCHrVVSGqwBvX
         9n9zAcPUHtxT7ZIK6fGN/0DEcYgAftiVs4ES0UPZpEF1gdSPV2HpOL7MVty6k0S/dful
         NNgs4HfJm64AGnJJOgu/aMVhz2IcbgPUQZps0dbMhG/FObOgnTjhqINxMXisjjYF8V9I
         In5A==
X-Gm-Message-State: AOAM533PF3omEd4VaaZxHqSrC9wJypsC7ccUwu/GqkqoDNEU8dWVG89e
        /OHR+/+vFYzDC1JEw8a63tk=
X-Google-Smtp-Source: ABdhPJwjaJvFWwpBeniphHGbx3yI8Vch5sKL5VAUur4FGX4lR6pIoX1U6TJYoX+TVxBJDD1rtD1kCw==
X-Received: by 2002:a05:6512:2295:: with SMTP id f21mr3566723lfu.524.1622151835702;
        Thu, 27 May 2021 14:43:55 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:55 -0700 (PDT)
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
Subject: [PATCH v4 05/14] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Fri, 28 May 2021 00:43:08 +0300
Message-Id: <20210527214317.31014-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
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


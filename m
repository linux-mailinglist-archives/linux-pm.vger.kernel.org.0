Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48F39398F
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhE0X4B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhE0Xz6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:55:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F65C06138E;
        Thu, 27 May 2021 16:54:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so3043894ljk.4;
        Thu, 27 May 2021 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=C2hZ0668kB8Ia4XZwIIGfwZHXQ7bbUEeRqWBKt4ZtdcDCxwzAFDEB5xpwwIq4iYNze
         B3NaFRwfOsqk+jt9hjyQItxoQ9Bqm7E+cVmoEa3dFeC2lJbYoPiEfnlUV7TrAOVBl6r2
         r4pXy7A0ebS9+A4aZAk66KWophPwBsX+tWLjmI686iPtpms1rLl9HNuuJ5snaDRsGabu
         A8Fy2k9CmqrUyQo0AAZ9HMtLUTc0bZCjTjJ1bM14yMU36IiBnBCnqN7NhsGxhaEkOlYW
         8SdMpkzWpqqrbmUrlhExk4dEDuj2T7uKDTJD2Dx+t9PAG8mKF08T6S3uLZDEKayWUC/J
         /UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=Ga+3uHQp/XWPhKCyHKnkqFLJNxmRGhpYX6bVdrOYoHCxWUHzyaRQRa1+g160Jc1DCx
         Y8fDrYasDz7CRI65zZwb7evoCRJ129F7dOYc5tWqQuNCMwGjfMMu687ZaRSu6OfkDJ6l
         1WWHJnPQWHdhZuPHA0kGHi4+23T24xEr10P5glPRx26A75ovml5gGCWc55J+b+NRlCsa
         +Q6tbOb3m15OtmUvoCt3+6YmOxcsdIYr7oqKMarI8FZkNcCD0NKVe1woLN6N9tt3wjk+
         YQz67kBJanFaIri7Ibp4c4lAVEMVaD84JKmseRDWE2q3TBaHJ/LNCVeg216sLzmaHL/Z
         Q6Ww==
X-Gm-Message-State: AOAM533OBk4lKGtxuqdO2De3x5gvO0MMAjPLv4shjlWFI63UoTrEp1QZ
        TQhAPq7K1pCw/V1CRFbjeqQ=
X-Google-Smtp-Source: ABdhPJzw74puAHhNpABx/6eXY6R0bECzHcJd2NAWD+YJnZDtOwvjDQf8gVqZ5t3SOojSxkPkpUZ52w==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr4512079ljl.325.1622159662757;
        Thu, 27 May 2021 16:54:22 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:22 -0700 (PDT)
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
Subject: [PATCH v5 05/14] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Fri, 28 May 2021 02:54:04 +0300
Message-Id: <20210527235413.23120-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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


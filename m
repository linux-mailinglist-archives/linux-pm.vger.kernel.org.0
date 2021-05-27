Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1936393861
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhE0Vqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhE0Vp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB9C061574;
        Thu, 27 May 2021 14:43:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t17so2704103ljd.9;
        Thu, 27 May 2021 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=IeJKbId95K3iK17owixOY6kalvvBBzL4PEPRprUHFRyWbRjX0aT0nu/lkbbJJ2Pfel
         z14Ktt62JnhGWxW8BN6SN3951qZORfqqr63fqYM/wli6iyYHuQxQjHPMIqNiZUfIH0K8
         4hBRaTXPLAIvP8szOiTPpYSllRNCmQN0gavhBoTrSOU/wsiI+VNJKc5mY3O4D7GTwrDM
         4oPE4cOOI9OIWXHr4HqqOSonfWh+0MXOQXiM38aIKi4/7DI6MysjQc+gmD/Svv5ID1xh
         icsbSZZFw+YvuhHEZLWbsnJ04/DpqwKJy50541NtgbX2fKBfxqhgE01bqjboeMhFET0h
         pLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=MUdDiwivdkBsHsu+I1HSyHCfzjZhcM4kl4S9Nvbx8UIip2/0EGoQYsaVNm7PEzLEua
         VGx3KXYg9QlImRjMpOYjPCfVahBur2pIAGqKORpb8pjWyk5FKXnenWe55gHbBJbCNtmQ
         Y0ASG/wq6emO1WnCpbOYAy+JwiNObqFD7r5cjaHD+KJB5RwOAnFlimwo/H2z+Z+lbAKb
         WK4vPI9ljSKTbp6miiIM7wsc1R5TvtkVji7SeAU/Bh0cJh9oiFOK7GJNZhX1qqSGApCq
         v/cn8BkzFU6qh5+Hl1dgRLG9mWeDKPRcKtADyr/Cn+E6V6v29mTmwNZC1bJQf8TfXIGM
         Ejuw==
X-Gm-Message-State: AOAM533RqE3YVSQptwewbD4NiMvA4yHDH/30dB4cXh3M6A+U5/tS+so8
        FqgRZOULFcmK0Y6uqxbb6PU=
X-Google-Smtp-Source: ABdhPJz1ay4qkLtz1wNyNXpgOskEjyw6OXgWZ39qRNHBlWbB5fzuPMVTtfpz2jZLaHVoTx404NsXuA==
X-Received: by 2002:a2e:8746:: with SMTP id q6mr4149087ljj.416.1622151833296;
        Thu, 27 May 2021 14:43:53 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:52 -0700 (PDT)
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
Subject: [PATCH v4 03/14] soc/tegra: Add stub for soc_is_tegra()
Date:   Fri, 28 May 2021 00:43:06 +0300
Message-Id: <20210527214317.31014-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stub required for compile-testing of drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index 98027a76ce3d..744280ecab5f 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -6,6 +6,15 @@
 #ifndef __SOC_TEGRA_COMMON_H__
 #define __SOC_TEGRA_COMMON_H__
 
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
+#else
+static inline bool soc_is_tegra(void)
+{
+	return false;
+}
+#endif
 
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.30.2


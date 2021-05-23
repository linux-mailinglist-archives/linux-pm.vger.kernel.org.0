Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47638DDC7
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhEWXPY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhEWXPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15CC061756;
        Sun, 23 May 2021 16:13:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so36646401lfr.6;
        Sun, 23 May 2021 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=oMYvR28mGflLKSlyL6w8hhczckbrZ9mm0l6gS6ZwU1L/CF5L+O5PW4eN32FL3Cw64u
         fhgcOvICOgKZ2a2DarXvZvwBRGZiusiwPmvuq6mOiGQ0Da458T06PIncYTupJgJHdwcf
         GfKKyPfPWqRo/aiAetFaF/E3yeSZd/c/ofVhkPf4ePtfnjRzlgAO/fUoiGvCgOyr/ec0
         mZzyUqcFm4YtMjorHKkXyrzXKZt5vdx3ObkWJZUVMvwpKqK+G8//1c9rCj+3M9MtHWMj
         j0ywPi1qOGUAS6iqnvlj5DfnH85cXs/d29dzm1mRrD3mS5gyXujWi9J46YJlPY9fgfYj
         k9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=klFvTlEabj4n/Ttd/LlMXxHO6QE4EzUUrUX9Za9yHiz+EcQa9+IL7o676juSwY3Z4C
         u1UkV+guEcBifRoGbd4Oncvj/SMltVEDupcEkwCyYyMmniIbFqgWvle3pYAfpTYyW6QS
         xIQ6BcH3kYRjNnKDlVUI1Q/UUehswvwrYsxOejlLjIloPFX9M9klOcsSajdGUYq8SdEh
         eL4TfIvu7WKO6gX1Va+HXAAlLyDltPSSDJ6ChiFVXHBvjGREvJNMFN67wbF+KnQYo9vS
         hXk7z30f18qJCgoP2n06SQvTjKjYgj78O/0tkHh+59+lXcHYdlwlZUxfeahqXCJHfgMM
         oz9Q==
X-Gm-Message-State: AOAM531zubohptz2sUWuU1y8TSOZdocwIfuk1EWci68GaOZqctjfh1jx
        dHwEwgnnaneX9HsJuM8tA7g=
X-Google-Smtp-Source: ABdhPJyD2Q89dCjuYaBHe7U1MZK1U8cBcOFUz6X07UJBumKDWDamKFI0YSQToGT47EY2o6RLW51+Cw==
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr9124441lfg.104.1621811630479;
        Sun, 23 May 2021 16:13:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:50 -0700 (PDT)
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
Subject: [PATCH v2 04/14] soc/tegra: Add stub for soc_is_tegra()
Date:   Mon, 24 May 2021 02:13:25 +0300
Message-Id: <20210523231335.8238-5-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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


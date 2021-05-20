Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8C38BA0E
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhETXKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhETXKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4858C061761;
        Thu, 20 May 2021 16:08:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v8so21919859lft.8;
        Thu, 20 May 2021 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=PeeRFLmZ8TfYZ0GQg6iH6bin0T0xVY/jqEd73UEXmr4dg6GlvydWE8xF2wWkWC00q2
         WUHBXTKMbMdw5MvVrgFfp/w+9p9K2oVN7hPN/Bwmqj+VOu2AtKlh4GmP750h3FzFLvt0
         6M02EjPDkcS0DD6XP80R89DkilSTNLIf/naW7Fm6W7IOd21uMxSzhLPsdQLGtedGoNl8
         SXW9ugRaKqzmX68Ez+mu3DjPj8FtkSglqm5sj3zMj9Jo1TQ8NmXhiZrn58NnAWDHqyR8
         N7mWZs2i/U+3KEG0azqWRFZtmsbqUCVXlY5j6im5hBZJa6VrtchVKoVgL7JfsqTKTKxB
         mwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=bmfya/k/2fP8iVzlYR/4s2wcrW5W+XpHBvYJuebzkffQWXpAIMzezjyYX7TluLfkZI
         E5QRkocjWBAHbABzkQdRtFHjl1mLF5T1maLqL9EbC1voogwYuCydOLD/BpvqjndvAqb1
         M5hUCdzOLjjyIup+eo1HkQFZD5C9szgKnLNK+3sozd9LGMjEGoqpu0CZW61oZmroU6dF
         YhRdxXQOjPfrGR+4/WRilpXYKc9cVmvS7liVvX5zw4IiAAmOy7ixGUUdaBnnKB/v+Kho
         PD/UllPKrsLk5vA9X+3ZuASH/LZ28DNj53rvjXbjrAB/zA0BfKnv4PY62PT1VxpViR7R
         x81w==
X-Gm-Message-State: AOAM5329VoIxXW7JrJdB0zUHRP1EUKiGYEp/4mfIdXpQJSbGF3cNCV6U
        PsSOgVnh3ta4y2zmn95QxcQ=
X-Google-Smtp-Source: ABdhPJx0EilwJMtqaOHlPCOecysO9SMYaZpGuzqOf68nFRPexJLbkCYWarSwMAKdV6aJqE5OA0bsDQ==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr4668917lfi.352.1621552121344;
        Thu, 20 May 2021 16:08:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:40 -0700 (PDT)
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
Subject: [PATCH v1 03/13] soc/tegra: Add stub for soc_is_tegra()
Date:   Fri, 21 May 2021 02:07:41 +0300
Message-Id: <20210520230751.26848-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
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


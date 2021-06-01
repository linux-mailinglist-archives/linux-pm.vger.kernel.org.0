Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC0396B2B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhFACfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhFACfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29735C061574;
        Mon, 31 May 2021 19:33:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so19333099lfc.9;
        Mon, 31 May 2021 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=gjw2h5Na/QkoNEtmDSy5b1sPeOPXIM3aHBW/wdXB2sZj149SFUk5lr+tiR7bn2In1r
         etKPMvWD0vpKkaAbknNfDtTEM3xc8PWCiYVIgYJI2CcQpFETCve2aVxPXaG4nV0yJutA
         WXcHygEmvpkG+Z7l/g4IGvQqszIVf/D9lnJ8lJ0NNSfYDQRTJA9Ye7YQCE80yQQwqyQ/
         ApeLcx1uVyZd8NRmmJ/IkHobMs4ey9PdH/n0IbrW14gSQyT6y5VIKU5L2/lwx0uycNGz
         roRQVGUiUXD9gfUeOCTV/C3/8OTh+ezzxeyU8ZT+dST+vt/G6tIDK9yqfN82+LVlrt+g
         rn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=ukm2GruOjIO0Df+9bevbmDOGMDiNnyYnXvBa8cfb+tW+DJ8p/NT7O98oMbukur1kih
         rkwK9W2Yvl2KkgYUj1dJA53C0ebjU5T4TcBxVrUhkHrPwvSmpYxlXSRuM4FuFwyIlO0Y
         uu6H9r85Nf/gqQdPbPDBbW5Bha1Q6LQMV6tRJW4/yKKTVhu0+ydVlCs/mJuI3ONDUKIF
         vMOctBe1jISDD9nruZryjLV0crZEp53UWqI5IhPENei8YJdxlY4sYtlRxuxP2ubk9POR
         bkfFtdzGSRXbB8PqhmoMrwr+LhwsbqAWEAUT2uWxD+moLLPCztnMk9njGbTuYMCYMDND
         9d/g==
X-Gm-Message-State: AOAM530MbyAfUMACj8gxn3yvlyyOjCD7IW5MzjL4W57C+1/m2pQC3gwb
        14sU+pfQEQ/zgJxyxG1E8L8=
X-Google-Smtp-Source: ABdhPJzagwyAOC406vqk8S4DmhOFjQs2WJL4KtRbvo7nuNUFCa3Dg5iUzgK9M6Lq8KEppo/AI29eRw==
X-Received: by 2002:a05:6512:1326:: with SMTP id x38mr16179110lfu.62.1622514806580;
        Mon, 31 May 2021 19:33:26 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:26 -0700 (PDT)
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
Subject: [PATCH v6 03/14] soc/tegra: Add stub for soc_is_tegra()
Date:   Tue,  1 Jun 2021 05:31:08 +0300
Message-Id: <20210601023119.22044-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
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


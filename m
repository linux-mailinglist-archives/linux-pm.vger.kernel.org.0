Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6527639375E
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhE0Utg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhE0Utd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B528C061761;
        Thu, 27 May 2021 13:47:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t17so2554601ljd.9;
        Thu, 27 May 2021 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=Ahqh1M8K+QBqEtTl8sfkdLiTsXCnvAmEdHJqTxwiftOxDfv1Vr7n8scD8g9XFtOrSS
         wHaeVT7NmF/D/GF450H6UsbkQ0/StJdUPH2nF2H5HU0ErjJ5/DF3xAu2xFS4pZi/dAAt
         letOvwrMIJwxLidlLzwzAR5vb7aS1awgsrnHHMM/JuK12O92AwJz5tHrPzp9b/QFoDQ1
         QY0TkclrcNUHozh0WhYVN+at2nJKashjJLnSWEMUCnE8ksIEezRT3LTq7GVTqXfgQNFi
         9s616tGMjVb7+pj2FxpzWpDjpb+V8ePOJq3+0lixERs35gnPTlTAkX1wpv26jP/wTEV+
         nHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=YltRgAb2JAm5O6Zvv0KxETIBlA+DBABLc62mEvvQsr6jrbnc03/jLt2RiMwERyhGkB
         12TFnG+N96ybHaZLvDwT4YRA/if2QJVh7GXcK5m+YDyfZE/iRC9HX2EIZgh5QuhhLUDK
         TNir5z3fA3ZMum1JNeZ/Xu+OLNBg99DcvszQZQXtY+4lIJ1Mb3JBwTgZOTITqsIfqexj
         HnY9w4UwUVKKHbvcdyf3IVl+dDT1P+g4lGbbvw4kZ/rrVTBvNIVP+cYnbiVZgtvap2AF
         g+nkWLHJv6wOxM4MhbHJkfGKnoMvFo2IvdtAtB9aIejr29eOmgLBWxrF4LEyHzdTPS0L
         jvfQ==
X-Gm-Message-State: AOAM533wM7jiAlYn6/IqP4RncKI22UVN2LZo3YQSggOxPTpEGTMd10Sz
        sLkHNHkW6EAM1qHtbh2qPf0=
X-Google-Smtp-Source: ABdhPJyaxZaiCHKNkjcVviPFxr5qTMuz5DD07MEAxw9UjXsThuP9nb4mvCu08BwokuwAaQb/06kjGQ==
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr4080535ljk.123.1622148477506;
        Thu, 27 May 2021 13:47:57 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:47:57 -0700 (PDT)
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
Subject: [PATCH v3 03/14] soc/tegra: Add stub for soc_is_tegra()
Date:   Thu, 27 May 2021 23:47:31 +0300
Message-Id: <20210527204742.10379-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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


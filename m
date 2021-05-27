Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FFD39398A
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhE0Xz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhE0Xz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:55:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63708C061760;
        Thu, 27 May 2021 16:54:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j6so2596314lfr.11;
        Thu, 27 May 2021 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=ZG3lwior+nTwOCXhy7YF6SbXb+0sbRVBynKIUqwf1quWp8fpTytOZ7bdtfiMAgKv8f
         RgWB18MrzBm3FXSY38C1h6mlPUsNVNyTQaKx09qzSV326VPqobN/pnKUO1VtYQ2K1J9r
         1Oxr15diSag6OFKr7+FMDhmfceFq7czujbHjy8X1v32/8yPG3iyQHoG3SIcXFwMIzNp6
         0A4o90KN2Di4q9GnINxGU637GBdpSSq2XcrEBsMSmEdJ0u9C3NnO8bnvhKp2WH2jXWu0
         9d2y4Pqfk+doWXUwt/NTk7DACuaPJ1k5e5bL4Axm8EW8D6xj9/mNlZ4NevLyIChCRd+I
         Pm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ7rCy2VE/t2KfttY6Z1tGootvL+h1fkg+mpjvNoBrY=;
        b=cv8QbPj+pZ1hvoP+cpEtUJpo2KF/h/wcTT40ckTp27aoSsAyOLjd98kj9GVWE0ldU9
         dCJ0rs/USfluJ1nRrsAuyHJQ4quURAITiwV6VTUknR+GMlrLwSVALyIZorwGquyp3Ylj
         ulDwZu8rz2vdVnBcw9fy+7gD1OS0Q08Y4qPQb4KQJn/trCSxKHPdwbF3L+WQY2QX0XGv
         HVgJVpspfghRkWSR8ZNCO9dy0rvHjZqtJNn2IucPJdgQPVBVAqRv2XhLJh5660iSab4Q
         lMxe4Als/mlNMdV4DxJEbXkevWEZRhaTYaCTnJDgMqe4VZUdaIyx3rc/eud4ahRgeDXX
         zkXw==
X-Gm-Message-State: AOAM530YiJm7TJALVfIUyGcvixnZS//wh33ClosYky/jR2DVL74IngBV
        fYrYjK2fQE5arjuwjNpSmBf6mL1zLqk=
X-Google-Smtp-Source: ABdhPJyhvKdQGTxHUVY2yDPRLPiGjYsoylf/Q+gSz881S8aReKlOOU3uteRvy97HdeX4wyGLVB5pjQ==
X-Received: by 2002:a05:6512:52b:: with SMTP id o11mr3850299lfc.341.1622159660819;
        Thu, 27 May 2021 16:54:20 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:20 -0700 (PDT)
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
Subject: [PATCH v5 03/14] soc/tegra: Add stub for soc_is_tegra()
Date:   Fri, 28 May 2021 02:54:02 +0300
Message-Id: <20210527235413.23120-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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


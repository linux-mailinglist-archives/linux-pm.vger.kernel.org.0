Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F33C4043
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGLAGf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLAGe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04DC0613DD;
        Sun, 11 Jul 2021 17:03:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k3so3505347qtq.7;
        Sun, 11 Jul 2021 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTbm+Ivds98cb9V5q8q1C/zZH2NCdOMIxgLjAuUIi4Y=;
        b=e6KFZp5MY5dIqEWOMEdQlVZO85JAxGhf/+0C/OMeAttBchIQ1aDkUiVV61LM3bo01l
         Kn9v6ftCBZZgx4/QJnk4QQWbxrdfHNi7tHlCkOQWc1ANc1dwfRhdssAyojVtuR57zSzC
         5IfWbjOOQsI+D5iKessslUL6mRYS7YVhhtmhxIf4OhRg1tESH4U6d71pUiAXZEK42qPl
         OLMUr/TxC9S85vFDXJZQFvSn6BG+G8QshZQdmcB96FcbbVQkTMQQzsMHNQMrCRiPwKrd
         HBWi7K+bfh41gNgc5Rz36wJLYnFQDAkX48vGOiNjHUY4DrKy9rWXW2d149SCr/wSUecg
         IZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTbm+Ivds98cb9V5q8q1C/zZH2NCdOMIxgLjAuUIi4Y=;
        b=VUxaNh+LwIJSSonDbnXigZEI1iKBEniJM9Fe3U8KiPOwJm2kmbadyqfvRTPAH9R8+V
         T0nI8uYYDnoq306K58bOYQBtgdoqB+XB8JP5hjBQ+zgwNnSRuXCiW25qmlUeDQNZBCmg
         f89b/P/1JNRksi+El4a9QQPPulOCTt05aOY9Dd+DeLg6MPeVxahNrLDkHDB6TRBcR8os
         cxPk0MGgXFY2PfyGryiadn56IwPaTYQ+uyP4Ru5uKmcq5ye+jinTzOMnU/2sa5brfY//
         pw/7GZcpiCU0eT6FdptyrE8JmdXddU/lnQdPSq4t+zfSfWnHl+ej05fuE+VWTcO79W5A
         yu3Q==
X-Gm-Message-State: AOAM531xPf4rCLq1OksGZP+AinW33a4etF1B8Yh7yoFAQqyNpiupZbia
        VmzOfAQU0Exx53JHeSBllqE=
X-Google-Smtp-Source: ABdhPJw0mJHjZBY3C7gjk9CFWVqFMYRFXUipZmACDMOIVTeq82kTY3tLRgRyMuHI9FTFHh01JLiSSw==
X-Received: by 2002:ac8:7f02:: with SMTP id f2mr27210251qtk.213.1626048226877;
        Sun, 11 Jul 2021 17:03:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/5] soc/tegra: irq: Add stubs needed for compile testing
Date:   Mon, 12 Jul 2021 03:03:19 +0300
Message-Id: <20210712000322.4224-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712000322.4224-1-digetx@gmail.com>
References: <20210712000322.4224-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/irq.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
index 8eb11a7109e4..94539551c8c1 100644
--- a/include/soc/tegra/irq.h
+++ b/include/soc/tegra/irq.h
@@ -6,8 +6,15 @@
 #ifndef __SOC_TEGRA_IRQ_H
 #define __SOC_TEGRA_IRQ_H
 
-#if defined(CONFIG_ARM)
+#include <linux/types.h>
+
+#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
 bool tegra_pending_sgi(void);
+#else
+static inline bool tegra_pending_sgi(void)
+{
+	return false;
+}
 #endif
 
 #endif /* __SOC_TEGRA_IRQ_H */
-- 
2.32.0


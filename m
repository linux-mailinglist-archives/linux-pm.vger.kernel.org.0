Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA339D1E8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFFWcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFFWcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:32:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC43C061766;
        Sun,  6 Jun 2021 15:30:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n17so2300235ljg.2;
        Sun, 06 Jun 2021 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9cVm01T3XBfO6x49juZ/jg9Mlr4Ym2jjpA87Fsdt98=;
        b=R/2mbdh5gXLQ11ZRE1rLgzpLqIkzabFbljZtt11gLkBX8aqhndteRv+c6wR56ROOQI
         jJxz+m9o3hxO+cmvU677nKpMsALg3D4LVpfv2c5fiFrkdq4iKX70L6yvJNqI6yQupHBm
         AkmG1QsbaObqs0MtdwTqRDsBaG5m0im7gaPOVvySDIzlXG0gXy/23RmTMeT30MmNs56j
         fQnAC0RhAH9yPJaeORQFPPPz4iWc9qCiHkBErBOX0C2zNXjv5z9pQLD2Zwiyx43PEj0n
         /AcObRzE18MEHM6K57RxzUZehb4PuTpjxB23QjfjVg7CmdD+mTxZD0fn2Y74vCddl5fN
         GJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9cVm01T3XBfO6x49juZ/jg9Mlr4Ym2jjpA87Fsdt98=;
        b=uZu0bFQRavlZ1Js0UTIpurN6n1CZshsvievYXHq5WUPRUFAB0LI1uKrIGStQS0upCN
         X+MoAdoQm0TgRIUre0j+NqM+f83XeAqsPmO63zHFFHuNJq7nmRZLkXtSfnJg+sgtD/Sy
         xokegirplx07jMQle7/c24lwEJbBNPlf9oJrHYyBHHyNMmdwFadtPliRM6ukIAnhpy2B
         YDikjYFYWUvWwcR7bPYkpZfAn/v5ZCsmzRKQhyzUfB2UWIY2PCzwvdDR7a/YTChxlqZs
         Id1bF44JrOdg4nqfAKYtsNY9vC9qYwXiEvcLEKu5sZBkf60zw8sSD9HkhoFMxsKBdtxK
         YqfQ==
X-Gm-Message-State: AOAM53102VQjlr7Y1w8+AK9dw/eivSrOnorXvahQSJlDQcIhvbrvWfrv
        kt9ILbXn1NER6WF0QjyvbYw=
X-Google-Smtp-Source: ABdhPJymqT1AHdSmLlIdmvjxMza3sxyxHXbxd1wQkGimiMSJiMEukjOpCXNmOHonH0oJF5sZ1uQA/A==
X-Received: by 2002:a2e:6e09:: with SMTP id j9mr12607231ljc.151.1623018603138;
        Sun, 06 Jun 2021 15:30:03 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/5] soc/tegra: irq: Add stubs needed for compile testing
Date:   Mon,  7 Jun 2021 01:28:14 +0300
Message-Id: <20210606222817.12388-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606222817.12388-1-digetx@gmail.com>
References: <20210606222817.12388-1-digetx@gmail.com>
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
2.30.2


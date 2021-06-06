Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68C39D1EA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFFWcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFFWcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:32:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72C2C061789;
        Sun,  6 Jun 2021 15:30:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r14so275959ljd.10;
        Sun, 06 Jun 2021 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExWGR4VIXCqtCDv/X2/Hi7Cf+i10YymHwbB0CYXGtsM=;
        b=JeaN0DHTvazorvjOUmOwYFWTlJVeQ0Rj0g5/M2Spcn6zRvpeoLtV0oIp39+K10fTiG
         pOb7Mr8b4kkTfuOGhJPppbTJ5Us6WbpBBnTbf61vVL8f7iz+rOsnmHDHBepbm4cvMSLQ
         D0bBmQBRl5ky0JVIe/scoLplRFVlxsxX0dRQTjOYzUjbXOuF4GtVr/hl6U1k4/rrEwnY
         HWja5xkezxKDUChJ73xLrCHByJJOSYyaqYOtR6W1qrOdbiK1bjQn6v2njWfNlgbNZEVW
         W4/p4EI1ZH8UpfBxsyRiVG/QsTJNIDdFmBZVyeK8HO0gFnYKpOzNGFi1QnEoHITf3G4O
         pEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExWGR4VIXCqtCDv/X2/Hi7Cf+i10YymHwbB0CYXGtsM=;
        b=dI8YctFBpSmO+VcDis+5X/mCDz+ww/16a0jdtA36x+xkathfF5VwmhO+1vF4lSTYCO
         qdIY6pTpWkR1ZIm+ETBE/s218SUgbT2WxYCMtynp1pxS+3DuC4+1weryq5UkQgvCuvzv
         oA+lHESj1MhadJxJQw5f1acfG0QprH9Mgex0wkP9yfWix1XksxV9DHzRKHpESWZXL0GF
         S037/B+NRqvTEYJT3s0NYXCMpNYiFNZPkbWoqoXrwIyLzKEJG30Q33LHOUVdWhZyudDh
         VMRGwb/ZOjt8mL3f+of0ItwGOcpzDkz9uqqSjM1WzIfb8Q4/HQUbPH619hEfY+WZstWE
         7dDA==
X-Gm-Message-State: AOAM533BMbxwdfai3DGprq7FhOAZusfMXvJd9qngjBp3G0Ug0Vx5IOrF
        UjESSwCugXoqLBobyuQB4MA=
X-Google-Smtp-Source: ABdhPJxll34kjQkN7b9+R6Z7JYck8j33HWzrptZr0d85USScPDqjrCavJzVJ1kAEQ86dmCVpZ2dE6Q==
X-Received: by 2002:a05:651c:3dc:: with SMTP id f28mr12501216ljp.294.1623018604337;
        Sun, 06 Jun 2021 15:30:04 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 4/5] clk: tegra: Add stubs needed for compile testing
Date:   Mon,  7 Jun 2021 01:28:16 +0300
Message-Id: <20210606222817.12388-5-digetx@gmail.com>
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
 include/linux/clk/tegra.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index d128ad1570aa..9bd06d8a5436 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
 #endif
 };
 
+#ifdef CONFIG_ARCH_TEGRA
 extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
+#else
+static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
+#endif
 
 static inline void tegra_wait_cpu_in_reset(u32 cpu)
 {
-- 
2.30.2


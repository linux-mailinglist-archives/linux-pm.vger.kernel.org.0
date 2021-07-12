Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01883C4047
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGLAGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGLAGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78420C0613E5;
        Sun, 11 Jul 2021 17:03:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id r125so8672615qkf.1;
        Sun, 11 Jul 2021 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZO3c0fpnwQfqDRvDUKCPGXMXP2rFLnO7bySGQVOuzg=;
        b=vCZay26jzh9L01bS8XWPXrySgaXzdy3IEphMKjLpnfs1p87ywLc5mFprJnM6+Bf3YB
         j2ukdxz6ossB8bsiOnfeLKoRZBCn7dDN4Fp2foztbrKYl6MMnt7ubosy7tD8UXgyK0lE
         RbFdk3ueSYLEe8EYBGrGPKEfRVDGzG1RD+1RJ+Ejb0In39BPI9AVOE1R2L+MH+F/5G4b
         qoLCijXF1T+0oct9Ik0vSZphNzdOLm13HsW4qnIUD+dwg2gvz1CpWVLw4lUqmxaBo4kx
         DI/M6QEePdrYTCTjYTSYb5ZagPIL3f0jxdiMtFLWZhCbNl3LHTFhK/4LJLjsvZ/2ekaE
         UTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZO3c0fpnwQfqDRvDUKCPGXMXP2rFLnO7bySGQVOuzg=;
        b=pHY1fQgboY50OH4u1KcGJkdhNiEdYiPdUYRDwaeiAeltvmUG984+QV8QwBJuITx8dN
         coNdUF6ihCG8oFtT6kc8B6agED21byMBZ+gfSpDWOlBcgGKZpqdbQwW816enru+0v81J
         bDyLtyUYewdLJhsODjkCfl16sd6zMmXHoH5WxUuFq/2xhs5QjAkOVq+SmEw3jSsjhVQC
         hPKKk2NFiVklfzebTRocQaG7aVdcvMgcgIHtOCy6+WVt2a7Wz4jKq+EeTAHWNnDdUPYT
         VPlyGEBy7jWWtpwnxrEk2gjq+Fs+zAsCNOBbUXuxYil/zoPt4ovTZu1QaZewQKfmoTGX
         94ew==
X-Gm-Message-State: AOAM530o8BnRLKSDeivyHePSFcrXjYgUMnNZCCnImJvacu2+Zl7+vO3i
        KdUeNWH6WF1XZ2B2W4xjAAo=
X-Google-Smtp-Source: ABdhPJxDwzwszqHn2YG0fUt6K6A2ORAvtr399U72TEdUNOWdtRUQwX2aAk2Yxig0bu/tfSihnCCTZg==
X-Received: by 2002:a37:b881:: with SMTP id i123mr50189620qkf.207.1626048230707;
        Sun, 11 Jul 2021 17:03:50 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 4/5] clk: tegra: Add stubs needed for compile testing
Date:   Mon, 12 Jul 2021 03:03:21 +0300
Message-Id: <20210712000322.4224-5-digetx@gmail.com>
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
2.32.0


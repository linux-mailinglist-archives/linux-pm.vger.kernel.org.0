Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C34408182
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhILUav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhILUai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BDEC06175F;
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so11411505wrb.0;
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0H54VcaSkULvQ0XfRhbooC/ZXW5WM4Ks5Bh/dzSIL8=;
        b=Hm8kwc9+ak0NQvURspJVzZlnw2P1MvUPDLATWgiisBkeG2XJTi+80RgVDkxolXnBPR
         CrVUDcXylOqzqU20VLb/ba+VYwJnCjQHeRJ8zWpUOYC0S9X6Gq+C111DBQyMZPOnJlWj
         bExfAMWsXn3D2tAwuzp/vhBFQQQyX/syil99wuC9M/WyXlFczDSXykBQENS4yWjZ2Zb3
         Xad8W3kR1vK81VSVkQQkx7CG22w9mKEEG8HW59hVEHtur5PRVITiylNUJQUSnuEn000b
         vbIgfhJteFP3AYgir4m6tp/ZW2DdIYTqp0aYDV3BplUtPSyAuwgafhGEmz26t1UdHGiZ
         fG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0H54VcaSkULvQ0XfRhbooC/ZXW5WM4Ks5Bh/dzSIL8=;
        b=BsWQ7TnhD96u1Xby3+faTLSBnGbZ8MNfn1g/4WawyfQ4NZOjSMTQGXamSWxJkdDbBC
         LIxV/LL0q+pFW/Y/ObOBwGcuGcJsB6bhbVii547CZw8WarZqnvNjb65Vne5RznjSBQ0Z
         NA/aoGk1B12uuyLu8XhuBie9EDYcpiNb+zxnwHwYIbrmtxg+vH57YUe6wAy9zTsEI/FE
         OFamrfbAnZbN4HnqGAR2KjCt+gluUYyF6Xt/2sKp1i5JjAfu0asseE+EyvuZRt/haCzM
         VloQHlW7cnPUzvo/oa2nw0KgDLwucBD4jqwL5P9ddGujJjkwE7V/Pp6T/ktokQMjSg+A
         3BCg==
X-Gm-Message-State: AOAM5309NUvfWzk/m1M0//DBgAIeiHyydA17QD627M3mNp++iV5ZxOxD
        fZiQEugT5+3bQX/HncbRtJsBWQhs9XY=
X-Google-Smtp-Source: ABdhPJwh2PUp3Py6hlk1c6sbav2J9iqh9ayK+eVHYQ9Or7wUlnyUeeZgVt0FRJMgGwLgO+R2wWNCCQ==
X-Received: by 2002:adf:f789:: with SMTP id q9mr8868994wrp.367.1631478561454;
        Sun, 12 Sep 2021 13:29:21 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] cpuidle: tegra: Enable compile testing
Date:   Sun, 12 Sep 2021 23:29:06 +0300
Message-Id: <20210912202907.28471-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912202907.28471-1-digetx@gmail.com>
References: <20210912202907.28471-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e56120..599286fc0b08 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -99,7 +99,7 @@ config ARM_MVEBU_V7_CPUIDLE
 
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
-	depends on ARCH_TEGRA && !ARM64
+	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
-- 
2.32.0


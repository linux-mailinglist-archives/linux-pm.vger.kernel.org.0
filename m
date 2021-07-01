Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622863B9932
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhGAXba (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhGAXbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CB6C0613DB;
        Thu,  1 Jul 2021 16:28:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id p24so10843187ljj.1;
        Thu, 01 Jul 2021 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqOHj6UrFfgcQU2vnkicKWRHxHORBQtzS7/4pVKTGxE=;
        b=p/S/evnlDY8Y47RxMRWl4G0g+WA6F+DXjVn+WNg3RJdi6Ow/eh4kYoBBZoNpyXPWsp
         ZIiCMx7znWdNULpZzwdojijgI2r5GhpBx5Vpy9tSNFZDzNOB/YHS4NGl13xD9oxSnpmp
         pMTDe0cwOd4Jspep1s6qTZUFUdboSBQLl/Hn2Mtvxo/7bC+vf/1RN1//AM8tOLhO39HH
         vh/wSrYs0X26J8eaV1lLnCeoYwNTZNW9jVwOJw+M+SnqfR1ZkHEN69LSO7D0aUAliDSm
         wAwcG0h9a1Lgtn8gbgxsvn3Efqe3lKv50g6ME383GUuBv1jvuUPUwjS6WTmrL6RGxw6C
         EbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqOHj6UrFfgcQU2vnkicKWRHxHORBQtzS7/4pVKTGxE=;
        b=L2w4pvNarqUdBt1gXfKEA+txpNFToxJjbsSA0HUnSMatgy2liIOgABIl08soGzKLzg
         IDOn27LCKHu0Ahx3QPhK5l/HEjdMxSRBvnGOKyKdHUEaVBx2vEytCIsYLnpeAEBqWNBg
         7Hx6rxLzf3Ri87dZGraUgho2e3QJm2duCH10Bt2hhJ4TO06wDCotL8524XyPra9Dixvi
         uYYxAmE50IKDYoLqxAdRclAydmEUjaXvM7WwERYQ6VP3WORvn/8/pN0pBwFuA8EIdcVs
         oGDfp86xDLiRd3btoJYBupqz1UVHKNJurucLqLOHT5lWnKLPNb1luXdKTCsXFjlaE4Yo
         k/RA==
X-Gm-Message-State: AOAM530cYxYaloGNtC1BMKxRHCQgzRLTp3Nbm2ykU4saKBfWd8qv4Oti
        rG8RFrvHtsHYD4aF1QvtAvQ=
X-Google-Smtp-Source: ABdhPJyQcvw0XZ6Z8C/0FdRqZAA7PCaWoycuxhyd4tykJmzWd0PCREHHOhoXVeSHDVNGgM5oyFuodg==
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr1601164ljm.114.1625182124972;
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 25/37] clk: tegra: Remove CLK_IS_CRITICAL flag from fuse clock
Date:   Fri,  2 Jul 2021 02:27:16 +0300
Message-Id: <20210701232728.23591-26-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

FUSE driver now takes care of keeping the clock enabled when necessary.
Remove the CLK_IS_CRITICAL flag from the clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra-periph.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 292d6269daf1..4dcf7f7cb8a0 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -777,11 +777,7 @@ static struct tegra_periph_init_data gate_clks[] = {
 	GATE("ahbdma", "hclk", 33, 0, tegra_clk_ahbdma, 0),
 	GATE("apbdma", "pclk", 34, 0, tegra_clk_apbdma, 0),
 	GATE("kbc", "clk_32k", 36, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET, tegra_clk_kbc, 0),
-	/*
-	 * Critical for RAM re-repair operation, which must occur on resume
-	 * from LP1 system suspend and as part of CCPLEX cluster switching.
-	 */
-	GATE("fuse", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse, CLK_IS_CRITICAL),
+	GATE("fuse", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse, 0),
 	GATE("fuse_burn", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse_burn, 0),
 	GATE("kfuse", "clk_m", 40, TEGRA_PERIPH_ON_APB, tegra_clk_kfuse, 0),
 	GATE("apbif", "clk_m", 107, TEGRA_PERIPH_ON_APB, tegra_clk_apbif, 0),
-- 
2.30.2


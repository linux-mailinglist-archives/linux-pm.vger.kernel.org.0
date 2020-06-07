Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2C1F0E59
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgFGS6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbgFGS6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:58:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77359C08C5C7;
        Sun,  7 Jun 2020 11:57:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so17764805ljh.7;
        Sun, 07 Jun 2020 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CY3FjRZp76KZl7tgz6s6CVjJ18LTSPB3H8v+jn0FVvg=;
        b=hVX5Ont6noNRP2P/2CCSf7FevOekRSrVKaunpciA4p+SogwZtz+xQzL4R/xkncA7Ru
         UY+985KTJr64ll+QcIVljePsWDFkFWzlYM9BK99+400sPBNdXNSXTNtVXuriMcEMPCMM
         xpQxTuY2+tL5/9FbxOcLccYaDdbw4SgEhY3NkrH6fMOHkMq2XEN/PU1VUeSOHOYbC3PA
         +aCDx3NDNIONWlAZwKkff0B8a7XiGSkKrLsT9GbSNGeZ8r/K1PPL1/gylpLS+50ClQXq
         DaPKESo7Il34FyXaqxZ7OI456IiJ0YR0w47Pnz1xECmGksALhndZA4DgfOVXAa5DIQfe
         xfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CY3FjRZp76KZl7tgz6s6CVjJ18LTSPB3H8v+jn0FVvg=;
        b=R1ZGLVtBlha0Lxw5aK1kkhhhkgabDAFMM+JOoQ1ExIvIoPOZmsag1MPt+FJiwsKAw/
         HlJfRdTPwgQeVyvh9xzE5JSwvrdgGb47RfjuQtT8fHA4gUxQlmppussFPOq8bGMBYZ8B
         GxygP5DHbdP7zQMFYDzi9ix5BM5oUIghnlB1S1mkDbntZJ514SFY4AHQUgfoJ3YNdvCM
         e6TnMVsjAjO3f4wv427kL4Xe58G7kapDId80BNir+OOnTohYi4MLBjL40TAo0WJ6igc7
         Ore9xU7BurovnvjZ9TBny+sIXopmbJ4eui8Njia2r6pgnrDZrdQ3JKXoUEvLA9y6ft6r
         B/WQ==
X-Gm-Message-State: AOAM532okr4kEiiS5O+Qb1IbbV17sAnBJYdEsvaqSPGtyGcTYqHS3INP
        oLlrKQ9xwv3BkXSMCsd556U=
X-Google-Smtp-Source: ABdhPJw2XOdVWfb3p0+g7ckPPPPttWtk5v4VNsp8WSNUtVnAkpbl2b9c476TMJa1JB02XN/urafppQ==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr9790721ljp.57.1591556278032;
        Sun, 07 Jun 2020 11:57:58 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 36/39] drm/tegra: dc: Tune up high priority request controls for Tegra20
Date:   Sun,  7 Jun 2020 21:55:27 +0300
Message-Id: <20200607185530.18113-37-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra20 has a high-priority-request control that allows to configure
when display's memory client should perform read requests with a higher
priority (Tegra30+ uses other means like Latency Allowance).

This patch changes the controls configuration in order to get a more
aggressive memory prefetching, which allows to reliably avoid FIFO
underflow when running on a lower memory frequency. This allow us
safely drop the memory bandwidth requirement by about two times in a
most popular use-cases (only one display active, video overlay inactive,
no scaling is done).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 12b318bb8475..48dad375b470 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1971,12 +1971,12 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 		tegra_dc_writel(dc, value, DC_CMD_INT_POLARITY);
 
 		/* initialize timer */
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x20) |
-			WINDOW_B_THRESHOLD(0x20) | WINDOW_C_THRESHOLD(0x20);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x70) |
+			WINDOW_B_THRESHOLD(0x30) | WINDOW_C_THRESHOLD(0x70);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY);
 
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(1) |
-			WINDOW_B_THRESHOLD(1) | WINDOW_C_THRESHOLD(1);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0) |
+			WINDOW_B_THRESHOLD(0) | WINDOW_C_THRESHOLD(0);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER);
 
 		value = VBLANK_INT | WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT |
-- 
2.26.0


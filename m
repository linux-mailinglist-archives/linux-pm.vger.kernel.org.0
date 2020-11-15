Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C42B39AF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgKOVeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgKOVdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:24 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F1C0617A6;
        Sun, 15 Nov 2020 13:33:24 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x9so17850394ljc.7;
        Sun, 15 Nov 2020 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dCbZvyPJ9eUu2G59fWkwNpYcrEO/zvwjAoLRWdkXSE=;
        b=lMs/M5N9kQbceTLDtzVP/G5macXOzeX6SPspxlJ4cA6fHAEgf6osXQnKHrS+UJ4zNT
         V57jTZJeCTOZZkfUIriDG6IP5umWyzF4K0L5KJQOKcImFyABpc/Sos1eeq2shV3SFAtD
         PofOkKtSej7g8/xAlvpmUOc69Lj6d5s8c0lfEMcmDzXu5iA8BLUucjFU5y1MDCEadd+l
         VIAGxdwTi52FU1zmC5zTGtQvgc5i/EsFv5OM2A7sD3I7F1ekFoJUXIZG7q4IJg/d/VqL
         8FbZeI4pqPvSNogpudQpFf8mbWxG+S2P34cV47CdDmWQGcbT3f1uBpwz5gYtIYK1SmuN
         aKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dCbZvyPJ9eUu2G59fWkwNpYcrEO/zvwjAoLRWdkXSE=;
        b=B6ncEzeEC2vHruHSXKFGUaHRtqrwUsSgXTFaMUIGkOsgjtuEWFTV1NzcOXwGj2eRGd
         ndox1hwLvM57binm9jI2CvpsZr08UnqGQOEsMJFq00+B5F8Y8eGf9gu/3hJcbofRls8s
         KuucSncmDsBI+OgSBSbuB4z2RY21AxALq9ntCOERzy98OE5Ep4VXYTbPHs+vc8tCxSQ9
         qM9F72spLn4TqIR1dvY8mNowcApduhAxuBjM79Ptq/agEjphQfgATyyJBPOebeXt8/JY
         bQbKTV3Zd59BPT1QV9qBNVhPlTXJjAO1r2v+tV156gyvI6nu15lyXBb4ikI6fkKJiVjk
         exCw==
X-Gm-Message-State: AOAM532JkAuKZ6d3u+C8gBbq2Kis51hwrqVroKzlVGiDx/j0imZD97O7
        n/eTTMpWToIkWojLpnD//qA=
X-Google-Smtp-Source: ABdhPJzgkqzs6ZJFhHgL5iqv84vjq17IcARI+54xc8lQJnLv4fufEgDzCkmsCAWv79+cAZPTAxGnOg==
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr5211261ljk.397.1605476002720;
        Sun, 15 Nov 2020 13:33:22 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:22 -0800 (PST)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v9 06/17] drm/tegra: dc: Extend debug stats with total number of events
Date:   Mon, 16 Nov 2020 00:29:11 +0300
Message-Id: <20201115212922.4390-7-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to know the total number of underflow events and currently
the debug stats are getting reset each time CRTC is being disabled. Let's
account the overall number of events that doesn't get a reset.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 5c587cfd1bb2..b6676f1fe358 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1539,6 +1539,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2310,6 +2315,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2318,6 +2324,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2325,6 +2332,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2332,11 +2340,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): overflow\n", __func__);
 		*/
+		dc->stats.overflow_total++;
 		dc->stats.overflow++;
 	}
 
 	if (status & HEAD_UF_INT) {
 		dev_dbg_ratelimited(dc->dev, "%s(): head underflow\n", __func__);
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0d7bdf66a1ec..ba4ed35139fb 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -48,6 +48,11 @@ struct tegra_dc_stats {
 	unsigned long vblank;
 	unsigned long underflow;
 	unsigned long overflow;
+
+	unsigned long frames_total;
+	unsigned long vblank_total;
+	unsigned long underflow_total;
+	unsigned long overflow_total;
 };
 
 struct tegra_windowgroup_soc {
-- 
2.29.2


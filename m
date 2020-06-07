Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77DB1F0E51
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgFGS6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgFGS6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:58:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA22C08C5C8;
        Sun,  7 Jun 2020 11:58:00 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so8873515lfe.5;
        Sun, 07 Jun 2020 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LVvE0OiYzwk9TxoGPobpgcZWVTviUfu3oOilcfUerI=;
        b=ZosR1+S0wKnlNEWsZTicNwlJhxuVimCvmhd6fMtIiwenhy6LfBHPOfMCtwfYHiF2Rq
         g7KJxTKDT4P4RiLnVM/NF58FpJXbdfJd8BmQPAMynQYVvohifi3n3ZNwyfDSioMmtDCu
         M/3UNKyfD5nUNiCScokDeE8pBqaRDWdV8HBdGp4Y77PZ6GPV4/XrkY8Nnsp0UIUkilZY
         yBNcBmrMn29f9RlpZeOQ/H4sGyBJUGdJfmshdxVS4wdd+nOwl/LZvVxgAV6Cx8yt7oCq
         xAOyID17SplV0mqFeu7mLt5qtvkICv+ApHcgTvqK2yAzLFWNMtTxPQAbXKHIZDGaZD21
         /0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LVvE0OiYzwk9TxoGPobpgcZWVTviUfu3oOilcfUerI=;
        b=kaVtxa9aClXlCx8EEdDS6gc1iQs+ZLuolaxHc8dMiJvaXM/i1THaY7370tQ/Q1jedv
         g1P5uY+eIQo0DXH/PG0aA1vn9vgNAQkQWxFepRHnvTWaTsHEabyvcgmWi1Kn3+JTnlzc
         6ElTp/ThPP90GzjCk4+NlaiLq2Vd7xpCqhrDvhS2qvRe6376Q27AeTkxiAEnGtJzSob6
         cfl4ess7FxBIa3BrgMFtbv0kko2bgBTpOiBGb0d8PLeGYqXtIMHdqYkKK8RufUu+2rje
         ybNTadsiJAACens5S/7JzBZaw2oYuqvL1KRkqPRjUbzyxJGtLqyypHVFw1FvhpOkBLHl
         7BTg==
X-Gm-Message-State: AOAM531kG7D46Qx+SBjDCS2dBVVSKkhlih4ATy9bXD+mBBzAFiv5H30s
        L/yLQlyNVbIxrqYUJlpqLrs=
X-Google-Smtp-Source: ABdhPJyjL9RxG3zPWpDaCfdXCkAaGiFQCA2lwegcUltZjdvev6ZW0rEtS9TYECcHb3oTiqV/xIye8w==
X-Received: by 2002:ac2:4471:: with SMTP id y17mr10734107lfl.178.1591556279356;
        Sun, 07 Jun 2020 11:57:59 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:58 -0700 (PDT)
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
Subject: [PATCH v3 37/39] drm/tegra: dc: Extend debug stats with total number of events
Date:   Sun,  7 Jun 2020 21:55:28 +0300
Message-Id: <20200607185530.18113-38-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to know the total number of underflow events and currently
the debug stats are getting reset each time CRTC is being disabled. Let's
account the overall number of events that doesn't get reset.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 48dad375b470..6a5a017e37d5 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1616,6 +1616,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2178,6 +2183,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2186,6 +2192,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2193,6 +2200,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2200,11 +2208,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index 3a0ff57c5169..3eb4eddc2288 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -41,6 +41,11 @@ struct tegra_dc_stats {
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
2.26.0


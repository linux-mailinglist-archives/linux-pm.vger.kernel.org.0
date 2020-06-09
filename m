Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41C1F3BA2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgFINP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgFINPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DCAC08C5C6;
        Tue,  9 Jun 2020 06:15:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so23351536ljm.9;
        Tue, 09 Jun 2020 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LVvE0OiYzwk9TxoGPobpgcZWVTviUfu3oOilcfUerI=;
        b=LQRbsZc/lMaqJwhwYqlJ++21C0noO4DH8w52LHMyg8AOXQmpf0wPewjYgk7+pfqCWq
         cxnZj8BMQKkjOHEnugfej595EKqcLsZ28RfOVIvXPbQ4Saj/Ai4RSS+y7S0R1xS+aTcR
         xtItdWXFNK0hHg6Xzwyo4PPVn88ATldn3Q2uFMNiS2YBEivJL49NPoV5k3izFaj4mfCz
         2uiwV9OSWKov1f+FR6LhyuiI+O3cNGQVM+NCLUu6a1AUngdci8kE4CXYRT41vR0L3IjS
         drItWhVYX/T0TC4NqSs8L5S08neBvMw2UY2moJ4wdcCIyS1H/Q3eCu1BjKcM6fMzrXfI
         P0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LVvE0OiYzwk9TxoGPobpgcZWVTviUfu3oOilcfUerI=;
        b=LwmFfrH8iFVRBhS+bXMdNUZJJXX+RCAW4W/LzvLRdLFwXQ4Zm1ydA6uUiH/CksVIj8
         CCh1JzGraUqmPz7TwTyrsusbWnGC7DfM2jWajaPEcAW6vmBlTh0i8biDo+x+c07jvdeA
         3GYl9WNFckp2+0YMG7ufJKHs9jZYF2Ew5EA3HCaSq72ICX1kriNKmNLqPKoTlq+TFLzw
         zk69b+zDhQpEPTPhbJuXOGKgBz04YGevfTrHsqXXTDOgHL4uNjAjvynk5S0pcl5Rj6lK
         hNG6CFMHkZYmyFWTA1AWJfAxGhhbCp90aGa6QCl3d2gUKyRsIsBbqsMI0j1kGmOYJ2DS
         RU2A==
X-Gm-Message-State: AOAM532tc/GQ9LSdn/FA7vZSvW+mAKAppqoD2rkvvmMYQNZpnBWI9ZxZ
        nKOzpjZd9rIyy+1n930D5iQ=
X-Google-Smtp-Source: ABdhPJzK5eWenm7x+U+CQZqleiYsThYNTHWO2Zr34XmtKFRmw3ulwHvfXBQ2k+ypw43VkEhfEYQ8gA==
X-Received: by 2002:a2e:7011:: with SMTP id l17mr14743726ljc.424.1591708510439;
        Tue, 09 Jun 2020 06:15:10 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:09 -0700 (PDT)
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
Subject: [PATCH v4 37/37] drm/tegra: dc: Extend debug stats with total number of events
Date:   Tue,  9 Jun 2020 16:14:04 +0300
Message-Id: <20200609131404.17523-38-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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


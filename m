Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9685724420D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHNAHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgHNAHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63DC061757;
        Thu, 13 Aug 2020 17:07:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so8092836ljc.10;
        Thu, 13 Aug 2020 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I441vpS3S5aDlVzrg/mTzQrvjnvNW+TqUcAQJ59TLM=;
        b=Aacq3Tu5kitjooDIHTqmVcRI0PhSXKEqTTnvrZFmM5H001UFUNP9Sky0+GT1d3AZ4U
         Nt0NQgAYFfh+mUvmV6GtZ6GzUoQiNxQd3HZJikeGjtugP02+aAxMjMec3venF3HkZqdr
         ZS+DWN2mXcyogiUsIB8KatEHdaitiLkVmHZcW0LqyoVphj9aor0Oas9rkDzhF/oxysSg
         ptnskfvIyA9gRArGqO1Z10ZfHiPlj/rEYT7bk30rzSI2kGETMRR11oxHdNNnCrGP/WaZ
         nNOifEJHr+md6VGLjEzSq4Nf6jJCbNuAJY5fcH6tPNwZIujxqwDhutbEOvc4MJNzvNzk
         oc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I441vpS3S5aDlVzrg/mTzQrvjnvNW+TqUcAQJ59TLM=;
        b=c6iBvP5cFCAMLq4eGjJ5bRnLuOWXYV+22dMW85dj1SPDGDGCCrLMCT1xOJo+JPZKvZ
         OrAT+PbZRuEa6850odHQxlwPRrCY7TmOw6TzVkhkkJHEgK801ZpH1aGFMcCHNFDWGVjE
         mpv66eS61dZO9K3pesZrTSKB/qAf7GyhEpn4GSO5u5Wbb4JiZH2uvbFFbRTJg8ARruzI
         cKfMgAevql8sjmHu8CR8VeFLnnLmswBiirst2CYyNC7qO96+4PSVRZpkYaPgAoOt1T+x
         lN4bCJuC5SglW8oOkGG1RXaPHHd5aE0wxHEcfwfuVRxJaBRQuvOA3ZUIaKFAlgnsxzKM
         CbmA==
X-Gm-Message-State: AOAM530MJvyHtfvAmje2T08D6BF4tGm9SuSzl0dISDMeKIsqkdNQf2QC
        mFac9hSPbVxMve0bTCDkxig=
X-Google-Smtp-Source: ABdhPJwS3t1VhewclqFmHM7Z+G4PJRRjcKaBY9PA67owkG9Oe2NamFWEnuF0B6DZLWORmPupH2dW5w==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr103221ljk.290.1597363661566;
        Thu, 13 Aug 2020 17:07:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:41 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 36/36] drm/tegra: dc: Extend debug stats with total number of events
Date:   Fri, 14 Aug 2020 03:06:21 +0300
Message-Id: <20200814000621.8415-37-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
index 4b062408467e..0692b9f0ec29 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1644,6 +1644,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2206,6 +2211,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2214,6 +2220,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2221,6 +2228,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2228,11 +2236,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index b70eeeee2033..41ca33abb84c 100644
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
2.27.0


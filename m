Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C092CDEDC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgLCT0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLCT0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:26:16 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6525FC08C5F2;
        Thu,  3 Dec 2020 11:25:02 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so4393259lfo.3;
        Thu, 03 Dec 2020 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dCbZvyPJ9eUu2G59fWkwNpYcrEO/zvwjAoLRWdkXSE=;
        b=comoDseRXVDKzFn9i3gBlbvcVp8U4meW9qg1it+b531GPnMYh5c/hmaQYK9H6BR+3j
         vx+Y9Rb7vFyhj1kIrNn3X7uRsjhjwwl4pFB94N0VS7Uhj+p0cYchgGoWgL24bNUPP4T3
         verFelMO9N2fhghS8lU63vb0qfwr5AQPEnmbOqM2WF97LVIyha4soqTI0CPz46iskKPK
         12pflg8R8wkNpG37q0MZMX/L6AigU4I1z4jZ7Gpc14dkVycGE0jnkDZOHH9Gbg2snnf6
         029zoIt/n2Tzc/Bw4PdnQGcKdje4EVqfZSFx2q07BnuniqCp5mlUt6kgvWIsVpG03gw3
         CJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dCbZvyPJ9eUu2G59fWkwNpYcrEO/zvwjAoLRWdkXSE=;
        b=unIimbkgBqTL4qOLriy/eCLflwh8alEuuLdFWZySMwoYmyVkf2NcfAOdpJkXQ0N6gz
         sF8SZ66A0vUP69mye2hBpus1hbZYqmFEWguPEZY6jUu8i3f5jBC/72z1zd2+iU5ckdJB
         HW0hm45yyVo2IMNiAK8sgGFxPGwA4uQeg4oLiFI+lzklaOhEebFRSVDxPTQrbPyOchX4
         0CByt90eE67dWYCb+OWRutGfKBKpTYltK4HlkQ8l1tJqxY7K5LqyDyxXfzKd9tESN5eI
         2deNJQOdhcQ5f+k0NMS2Sbr+6nYrhc0Vo8k72UZPbzcOoPUH3Io+md6QRguSc9R8cS2j
         FXCQ==
X-Gm-Message-State: AOAM533Tzwrli+YN/i7S5mwpGoxftIYvgvGugxM5U6tEFbbCk5xeCxuD
        8DoFtsb5GAgqCOEjSBG5Bqo=
X-Google-Smtp-Source: ABdhPJzYUiGTUA6BQcOXvTwrOBG6wlaDUcOd+ZQotdRN43mdbhmOwdlpbdUmvx4fksJKT0SQ4u/0zA==
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr1868238lfe.412.1607023500935;
        Thu, 03 Dec 2020 11:25:00 -0800 (PST)
Received: from localhost.localdomain (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.gmail.com with ESMTPSA id z7sm861932lfq.50.2020.12.03.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:25:00 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v11 08/10] drm/tegra: dc: Extend debug stats with total number of events
Date:   Thu,  3 Dec 2020 22:24:37 +0300
Message-Id: <20201203192439.16177-9-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203192439.16177-1-digetx@gmail.com>
References: <20201203192439.16177-1-digetx@gmail.com>
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D03B9918
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhGAXbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhGAXbL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222EC061762;
        Thu,  1 Jul 2021 16:28:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e3so2337747ljo.6;
        Thu, 01 Jul 2021 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YPb2dOMic/7GhvUsTcmLeY3TClgBbrs4MKpE0tEkFA=;
        b=rnmCp1clL8ApFDeAHZW40p3yEL0c28iU9Ydrziwpe0rlyYrZwjjd6JXaTmjcrjNRyD
         8E3v274qIn/RK2N4d77FH0YjL0n59MzsGFOsDMqxpZcb4Nr/JHvsjkgO+56IjI0bkNPQ
         3Suna9oy7rUc+spc1M9hNlCkGDEUrRPiBMEj6JXj/YgjLcpzfjmBH9w9Aitz49Xe1vyy
         bnnWvPOBtcEJV9ouoBEeqzAlr6ExQW+mLAThZzdivp256JfBQEICgbyfS18ljsfnJXGQ
         lG0ZqsVM2+m7x3YxF8rJ5eMOuUjV23DM6rdKknDpHExMXSCXlNbfdqK82+1sJttaiEpZ
         H4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YPb2dOMic/7GhvUsTcmLeY3TClgBbrs4MKpE0tEkFA=;
        b=IhZPJxC3AvzpgNPnWZYkX2TrQAViB+t3uRXH2dfLjQ1kB4Sh9+k+kU1L8FbceOmrg7
         ZHfxBirZnNGYvPaL7SlySEwDOFKth9120hl8XJ5qGr2yoaQK+xEeUY5QlPhAd6c8jZhB
         xGeKLguZyKk4mMvFOW/1wYEjNqHQi+5RjrYlAY8855loadexasfE7uaq0WHPEzB1D2Eu
         +GhxToDrVqXelH2z5f+DLGGEgLwOaVLQSAXbEK1za1KMCUtzNwSwStKbGmR2a7Q0Btd6
         bqUsNufb2tCEGIMD58HQCdxHEfSEvSvQCf89dMpMYICMjNJqbtxnXdm7ZuAyTVmeL3h2
         PNMg==
X-Gm-Message-State: AOAM530TWKc4Fo0q3wfRkrNUcOpdzZkt2OBjfp/gSlwC6uoA+YmYjehw
        vC/L/nO6m3gNO0fupGfcVq8=
X-Google-Smtp-Source: ABdhPJxQ1GhGKwdDsIcfCNNtrIiFbzD1Up4lHr97BBxD9r4HH1v6jqbDKygWPNgkLLVoDq+gNG28UA==
X-Received: by 2002:a2e:752:: with SMTP id i18mr1509214ljd.497.1625182117078;
        Thu, 01 Jul 2021 16:28:37 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 12/37] drm/tegra: dc: Support OPP and SoC core voltage scaling
Date:   Fri,  2 Jul 2021 02:27:03 +0300
Message-Id: <20210701232728.23591-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP and SoC core voltage scaling support to the display controller
driver. This is required for enabling system-wide DVFS on pre-Tegra186
SoCs.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 69 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h |  2 ++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 51bbbc42a144..fa9cbeb7a958 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -10,9 +10,12 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include <drm/drm_atomic.h>
@@ -1727,6 +1730,47 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 	return 0;
 }
 
+static void tegra_dc_update_voltage_state(struct tegra_dc *dc,
+					  struct tegra_dc_state *state)
+{
+	unsigned long rate, pstate;
+	struct dev_pm_opp *opp;
+	int err;
+
+	if (!dc->has_opp_table)
+		return;
+
+	/* calculate actual pixel clock rate which depends on internal divider */
+	rate = DIV_ROUND_UP(clk_get_rate(dc->clk) * 2, state->div + 2);
+
+	/* find suitable OPP for the rate */
+	opp = dev_pm_opp_find_freq_ceil(dc->dev, &rate);
+
+	if (opp == ERR_PTR(-ERANGE))
+		opp = dev_pm_opp_find_freq_floor(dc->dev, &rate);
+
+	if (IS_ERR(opp)) {
+		dev_err(dc->dev, "failed to find OPP for %luHz: %pe\n",
+			rate, opp);
+		return;
+	}
+
+	pstate = dev_pm_opp_get_required_pstate(opp, 0);
+	dev_pm_opp_put(opp);
+
+	/*
+	 * The minimum core voltage depends on the pixel clock rate (which
+	 * depends on internal clock divider of the CRTC) and not on the
+	 * rate of the display controller clock. This is why we're not using
+	 * dev_pm_opp_set_rate() API and instead controlling the power domain
+	 * directly.
+	 */
+	err = dev_pm_genpd_set_performance_state(dc->dev, pstate);
+	if (err)
+		dev_err(dc->dev, "failed to set power domain state to %lu: %d\n",
+			pstate, err);
+}
+
 static void tegra_dc_commit_state(struct tegra_dc *dc,
 				  struct tegra_dc_state *state)
 {
@@ -1766,6 +1810,8 @@ static void tegra_dc_commit_state(struct tegra_dc *dc,
 		value = SHIFT_CLK_DIVIDER(state->div) | PIXEL_CLK_DIVIDER_PCD1;
 		tegra_dc_writel(dc, value, DC_DISP_DISP_CLOCK_CONTROL);
 	}
+
+	tegra_dc_update_voltage_state(dc, state);
 }
 
 static void tegra_dc_stop(struct tegra_dc *dc)
@@ -1859,6 +1905,8 @@ static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
 	err = host1x_client_suspend(&dc->client);
 	if (err < 0)
 		dev_err(dc->dev, "failed to suspend: %d\n", err);
+
+	dev_pm_genpd_set_performance_state(dc->dev, 0);
 }
 
 static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -2622,6 +2670,23 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 	return 0;
 }
 
+static int tegra_dc_init_opp_table(struct tegra_dc *dc)
+{
+	struct tegra_core_opp_params opp_params = {};
+	int err;
+
+	err = devm_tegra_core_dev_init_opp_table(dc->dev, &opp_params);
+	if (err && err != -ENODEV)
+		return err;
+
+	if (err)
+		dc->has_opp_table = false;
+	else
+		dc->has_opp_table = true;
+
+	return 0;
+}
+
 static int tegra_dc_probe(struct platform_device *pdev)
 {
 	u64 dma_mask = dma_get_mask(pdev->dev.parent);
@@ -2687,6 +2752,10 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		tegra_powergate_power_off(dc->powergate);
 	}
 
+	err = tegra_dc_init_opp_table(dc);
+	if (err < 0)
+		return err;
+
 	dc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dc->regs))
 		return PTR_ERR(dc->regs);
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 5e13f1cfd749..88fc9c634c1d 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -91,6 +91,8 @@ struct tegra_dc {
 	struct drm_info_list *debugfs_files;
 
 	const struct tegra_dc_soc_info *soc;
+
+	bool has_opp_table;
 };
 
 static inline struct tegra_dc *
-- 
2.30.2


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91075255440
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgH1GI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgH1GIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:08:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C63C061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so55506pjd.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHZeI2yfFEkpCkFHmLsd7DtKmS2VipSIn1WAzrLDQFE=;
        b=O/ulWoothsxdPQ97xUPAUF8mGcsHgg0SyY1cIBhktJYelPiAMSEkxkz/j33wP2C+Lq
         vbXrtKofh2FKpOGyRQmm9D9Cts2zfKI9qst0d9eDfHoZ3ARRHSvM47r89aGu9oRT4QRx
         64B9170HVrKF8kOJiV8NrDLdPSDI+gRjG8N/bKQf1V4TBIvWLY4xg0MnamDt8rVICGLN
         +rVhKfjcmjNJLx5WZl1n4E3tCbSCFY8qbEsEdPo5WpqxCs65T6GdDqBj3pNNyznWONvZ
         OQxut+bgVRDcKCXc3uvfKhbN4aNZbQMFIJwee77qFz0Pv6LUakfOtGZrFOlIPhb0T4XB
         zK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHZeI2yfFEkpCkFHmLsd7DtKmS2VipSIn1WAzrLDQFE=;
        b=kzWalJeEPW4WYMAzYV4VNGDuorAx/LjNmEY3gHijlliBh0iIeYHaAtVywgJn2a+1+b
         V6aK3OeBSi4leFNAhfBr0SnLv7fX/z5X4ZdPNodfs++ya80SzJSh+5ll76bMx4y95QDg
         tWeHomZ+0/H/+vW3n1V2yvuOS13q6Tze1TmgLyTlO7QBaKU8mZAj+BUu4PgB4BsCPHRk
         414obqSNE9LYnXhUrJDdfQeupD3wbHRyUWJumPF5x6IRHo+iHyRh83xJ4Lm/j68g8zdG
         THF+2053I66SGfH20PugPU9Rybc+iAACsOrS67oYPR3FPOLHZCsylAlmjlD345ubm3ap
         P9Tg==
X-Gm-Message-State: AOAM533yTM/oWgezoGpNFqvmGxeMf4FZMi8yGlR81ssepFNFZHr2SAYA
        jgVu7dPQ5x3fbkbJubDHZEFHEg==
X-Google-Smtp-Source: ABdhPJzUn/yAsux1BzGUFFYk5nk+3HRDii55+GgvRQzXYUbbXQKWlcl/DTr9MzJvuF556xdk7KaYkg==
X-Received: by 2002:a17:90a:1e65:: with SMTP id w92mr262778pjw.187.1598594903805;
        Thu, 27 Aug 2020 23:08:23 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id e65sm96904pjk.45.2020.08.27.23.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/8] drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Fri, 28 Aug 2020 11:37:48 +0530
Message-Id: <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

While at it, also create a label to put clkname.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2:
- Compare with -ENODEV only for failures.
- Create new label to put clkname.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 -
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  8 ++------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index c0a4d4e16d82..c8287191951f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1010,12 +1010,9 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(dpu_kms->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(dev);
-	if (!ret) {
-		dpu_kms->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(dev, "invalid OPP table in device tree\n");
-		dev_pm_opp_put_clkname(dpu_kms->opp_table);
-		return ret;
+		goto put_clkname;
 	}
 
 	mp = &dpu_kms->mp;
@@ -1037,8 +1034,8 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	priv->kms = &dpu_kms->base;
 	return ret;
 err:
-	if (dpu_kms->has_opp_table)
-		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_of_remove_table(dev);
+put_clkname:
 	dev_pm_opp_put_clkname(dpu_kms->opp_table);
 	return ret;
 }
@@ -1056,8 +1053,7 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
 	if (dpu_kms->rpm_enabled)
 		pm_runtime_disable(&pdev->dev);
 
-	if (dpu_kms->has_opp_table)
-		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_of_remove_table(dev);
 	dev_pm_opp_put_clkname(dpu_kms->opp_table);
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e140cd633071..8295979a7165 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -129,7 +129,6 @@ struct dpu_kms {
 	bool rpm_enabled;
 
 	struct opp_table *opp_table;
-	bool has_opp_table;
 
 	struct dss_module_power mp;
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index b17ac6c27554..4335fe33250c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -113,7 +113,6 @@ struct msm_dsi_host {
 	struct clk *byte_intf_clk;
 
 	struct opp_table *opp_table;
-	bool has_opp_table;
 
 	u32 byte_clk_rate;
 	u32 pixel_clk_rate;
@@ -1891,9 +1890,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return PTR_ERR(msm_host->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 		dev_pm_opp_put_clkname(msm_host->opp_table);
 		return ret;
@@ -1934,8 +1931,7 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
 	mutex_destroy(&msm_host->cmd_mutex);
 	mutex_destroy(&msm_host->dev_mutex);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
+	dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_disable(&msm_host->pdev->dev);
 }
-- 
2.25.0.rc1.19.g042ed3e048af


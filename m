Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6113B5B047
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfF3PDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:03:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39723 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:03:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so9034928qkd.6;
        Sun, 30 Jun 2019 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtkecUl94WZUWVyLIbg41zPL4XOnGr9FinN/AjQ9do0=;
        b=bgoeXIm2Szb7H23F1xIuOV/OvrFFy4Z/4Z0LEr6zIOkjv9PUlSVyyIiIVoUnNQaW8Q
         cafpxW5/ZXUIYGeRvkXt4qZICIMaH2o+0zNqueBWKrkmrXfN57tKIlDyT1Yh+y1ay5v2
         zvN5vBXY57R5bCr/DfN5c62hyqHT+WV8C0cAxaZEoxbOCjKjvFomRHB7qf47grSh6HTs
         tZo179xphOFk9zBbCEgXJ+L4BIgMwmEVwGIaExH+6eE4DCHzqTWCQuhd33+N9n/PrQwj
         PmNmj0Fi1fdqzDqg7RjZXUXshd5SMg+oEeyEwBG5SnPiettac8xLsBb1dFjL8YMVyQEx
         y2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtkecUl94WZUWVyLIbg41zPL4XOnGr9FinN/AjQ9do0=;
        b=ptY7dF8vOvYC6HBuMtdDnrZROM0/nYF19Jc3VUdT/SE7r1Sm+EbUZgLtThzMYoZnEI
         yY55ATYdgqGfIS7rMH29WvE4Qihu0MZfTKWjKAUSw4QefqSw55CKCsKW0X7q89RtQQwc
         JqwnNZjUrovf5Jeiklsr7WJOg1BHJyzn3R6glB3xnp0FgaVRG9i8MLmN2CtGOaosjb6e
         mvkOWqrJ4BsK7Q2S5VqZ/8rNnV+qZIlxc9tYlTa2KQAoF5Zv8uWSeHDh8Ze2ZUs+r05q
         znBmDIdxkKQC4hpPptU/N8uUxfWCTk4twgK+8cSgp4SlbmvjwDu/BKfmoHpXb2dPP11E
         nXcA==
X-Gm-Message-State: APjAAAXSsPtl1FWjHZ8UUh3KAgHMCJhBhUQXi8yGFh75daMyRFGQ9NjD
        abSPZBPo8yJI1foI3Bb93nQ=
X-Google-Smtp-Source: APXvYqzb7VEqdJN3zMk22jED6mEzBTBoZp0mQsZB6WSr/6mKWnavlfT0+rulViFI0nHFDxdAaJYyMA==
X-Received: by 2002:a37:9506:: with SMTP id x6mr17139922qkd.107.1561906990902;
        Sun, 30 Jun 2019 08:03:10 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id j25sm3431572qkk.53.2019.06.30.08.03.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:03:10 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/msm/dsi: get the clocks into OFF state at init
Date:   Sun, 30 Jun 2019 08:01:42 -0700
Message-Id: <20190630150230.7878-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630150230.7878-1-robdclark@gmail.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Do an extra enable/disable cycle at init, to get the clks into disabled
state in case bootloader left them enabled.

In case they were already enabled, the clk_prepare_enable() has no real
effect, other than getting the enable_count/prepare_count into the right
state so that we can disable clocks in the correct order.  This way we
avoid having stuck clocks when we later want to do a modeset and set the
clock rates.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c         | 18 +++++++++++++++---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 87119d0afb91..d6e81f330db4 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -215,8 +215,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 		goto put_gdsc;
 	}
 
-	pm_runtime_get_sync(dev);
-
 	ret = regulator_enable(gdsc_reg);
 	if (ret) {
 		pr_err("%s: unable to enable gdsc\n", __func__);
@@ -243,7 +241,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 	clk_disable_unprepare(ahb_clk);
 disable_gdsc:
 	regulator_disable(gdsc_reg);
-	pm_runtime_put_sync(dev);
 put_gdsc:
 	regulator_put(gdsc_reg);
 exit:
@@ -390,6 +387,8 @@ static int dsi_clk_init(struct msm_dsi_host *msm_host)
 				__func__, cfg->bus_clk_names[i], ret);
 			goto exit;
 		}
+
+		clk_prepare_enable(msm_host->bus_clks[i]);
 	}
 
 	/* get link and source clocks */
@@ -436,6 +435,16 @@ static int dsi_clk_init(struct msm_dsi_host *msm_host)
 
 	if (cfg_hnd->ops->clk_init_ver)
 		ret = cfg_hnd->ops->clk_init_ver(msm_host);
+
+	/*
+	 * Do an extra enable/disable sequence initially to ensure the
+	 * clocks are actually off, if left enabled by bootloader..
+	 */
+	ret = cfg_hnd->ops->link_clk_enable(msm_host);
+	if (!ret)
+		cfg_hnd->ops->link_clk_disable(msm_host);
+	ret = 0;
+
 exit:
 	return ret;
 }
@@ -1855,6 +1864,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	}
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	msm_host->cfg_hnd = dsi_get_config(msm_host);
 	if (!msm_host->cfg_hnd) {
@@ -1885,6 +1895,8 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		goto fail;
 	}
 
+	pm_runtime_put_sync(&pdev->dev);
+
 	msm_host->rx_buf = devm_kzalloc(&pdev->dev, SZ_4K, GFP_KERNEL);
 	if (!msm_host->rx_buf) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index aabab6311043..d0172d8db882 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -354,6 +354,7 @@ static int dsi_pll_10nm_lock_status(struct dsi_pll_10nm *pll)
 	if (rc)
 		pr_err("DSI PLL(%d) lock failed, status=0x%08x\n",
 		       pll->id, status);
+rc = 0; // HACK, this will fail if PLL already running..
 
 	return rc;
 }
-- 
2.20.1


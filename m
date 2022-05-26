Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07C534E57
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbiEZLoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbiEZLoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:44:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C46CFE26
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so4220576pjh.0
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM3evDjfiE3dprTsclqC+/G6p3TK8Ys0Oy1ZcImUYfI=;
        b=laC4QuTRCSg15JyXcb0ZD2Q4k53G7vghjfyxzv8umgfoorTsmmpQfMbYRec0NDOGhY
         ZE0ZNojePoqY3DSa/G78FdLptguqGGFfqzBBeXXMtwm/h7U7JYySMx7+JuJ2G2PWb3bF
         PeCNYJfs5DMIsiIbeRrYXdDW32Yaz4CxTKzg74MkpPCwWlM8X1FpLYNQf3pyAK8WTICf
         8TYeST48ot3aMLkvlkVrIqlqckVx0E8VRNIYFTuZMyd/flWwH0p6GgIs0sTfN2G+gAse
         HFr9P6EcchTDffeVhYQex9XhPyJ9Fh+fa8aoXzjKUaa1c3/Z2YLN8kK8lbl24keZ9tzc
         tJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM3evDjfiE3dprTsclqC+/G6p3TK8Ys0Oy1ZcImUYfI=;
        b=1VJuT41yh29PG5+Up4t3d1kQB4xJ3WsnA6Sj/iq9dCKtrQx8h+GgBooMEErKVSvqkM
         7AatVR7ngf76Qka54z9zKlNSx79Dgrv39SceKhHRZGsjNelwAOe0wNn/OB9N21xvyYbS
         Ah38fwZ2cpRRGnjDq82BTGGuNyfoxeIVjhi6Kml99lPPUh5d2w8UOcPW2zACR8MHnkBH
         kN5UaFNBZEqni2XO0fqjXhDFSiukBIFTgFWQys3oPye2OImcI1nLxKnGTjlZIJvmY2WL
         aC3ZAbTGKwCygLdrP7GkM/k6Wk7Hyxs+bF+B/keyDb3RmbH4D/OimmKmSk0dTCrsZ0D3
         d6mg==
X-Gm-Message-State: AOAM531E+Sn+s08AC1be0wVMmigpEhacTX6l2VpRDHj9rJdlAmdbMLu0
        BvNWwPxemCC+6tuAO3916Ogj8Q==
X-Google-Smtp-Source: ABdhPJzFEsV7cJrNzaIFA5do0FQhIQLA3swJDrst+zf/HBD8jNqWQ/kokmEk7NyfDIO4ycChLj/aKw==
X-Received: by 2002:a17:90a:4803:b0:1dc:b4c9:1958 with SMTP id a3-20020a17090a480300b001dcb4c91958mr2177698pjh.61.1653565449495;
        Thu, 26 May 2022 04:44:09 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b00161527e1d9fsm1270109plb.294.2022.05.26.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/31] drm/msm: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:13 +0530
Message-Id: <f6a74bce04534144719ee4811a663dac85056815.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  8 ++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 10 +++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  5 ++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.c        |  5 ++++-
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  5 ++++-
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 407f50a15faa..c39fb085a762 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1728,10 +1728,14 @@ static void check_speed_bin(struct device *dev)
 {
 	struct nvmem_cell *cell;
 	u32 val;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &val,
+		.supported_hw_count = 1,
+	};
 
 	/*
 	 * If the OPP table specifies a opp-supported-hw property then we have
-	 * to set something with dev_pm_opp_set_supported_hw() or the table
+	 * to set something with dev_pm_opp_set_config() or the table
 	 * doesn't get populated so pick an arbitrary value that should
 	 * ensure the default frequencies are selected but not conflict with any
 	 * actual bins
@@ -1753,7 +1757,7 @@ static void check_speed_bin(struct device *dev)
 		nvmem_cell_put(cell);
 	}
 
-	devm_pm_opp_set_supported_hw(dev, &val, 1);
+	devm_pm_opp_set_config(dev, &config);
 }
 
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 83c31b2ad865..ddb2812b1ff7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1805,6 +1805,10 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 	u32 supp_hw = UINT_MAX;
 	u32 speedbin;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &supp_hw,
+		.supported_hw_count = 1,
+	};
 
 	ret = adreno_read_speedbin(dev, &speedbin);
 	/*
@@ -1823,11 +1827,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
 
 done:
-	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_pm_opp_set_config(dev, &config);
 }
 
 static const struct adreno_gpu_funcs funcs = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index e29796c4f27b..43f943fdfde5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1203,12 +1203,15 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *ddev = priv->dev;
 	struct dpu_kms *dpu_kms;
 	int ret = 0;
+	struct dev_pm_opp_config config = {
+		.clk_name = "core",
+	};
 
 	dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
 		return -ENOMEM;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 53568567e05b..54bdb33eef45 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1974,6 +1974,9 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 {
 	struct dp_ctrl_private *ctrl;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_name = "ctrl_link",
+	};
 
 	if (!dev || !panel || !aux ||
 	    !link || !catalog) {
@@ -1987,7 +1990,7 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = devm_pm_opp_set_clkname(dev, "ctrl_link");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		dev_err(dev, "invalid DP OPP table in device tree\n");
 		/* caller do PTR_ERR(opp_table) */
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index d51e70fab93d..7d5b027629d2 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1801,6 +1801,9 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	struct msm_dsi_host *msm_host = NULL;
 	struct platform_device *pdev = msm_dsi->pdev;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_name = "byte",
+	};
 
 	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
 	if (!msm_host) {
@@ -1862,7 +1865,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		goto fail;
 	}
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "byte");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514


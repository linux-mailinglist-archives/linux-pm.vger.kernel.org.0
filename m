Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26AF1F3B94
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgFINOr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgFINOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A9C05BD1E;
        Tue,  9 Jun 2020 06:14:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so12447317lfc.6;
        Tue, 09 Jun 2020 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTclmq28GLYsw04BzrWHjRkTzltxC1UwK7DmWEtnz4Y=;
        b=ZgHs8HAencTPVUhtbAVYSfa4nW9ULdGMWFzfvxSBO5tClV12UMwawdaUhNd9KiiV+r
         8VAOPxPsIzXheMsc+tK3jIHwOPxrMlC82fTJ2weCWrznjCQnV0bXG7Vn0YQ2SAmR9/C/
         /lc3t/xigYaV1oRweu18DW+mJFToE/kBWplXZJM2BRu2iqfeVB2xA2R0uRupdFSrvqXf
         aJEtQTjrROz+JlCmtjUVQSagW2PayvibKYePfssT38LUkZBjclX/EoWShsr8lsX05+KH
         O3Hh8tEwYxyfmYtTR8tWhbMxfOLwMCeQW++tZF1mwRVaHAH+flGbVGxIoeDBAZUvJn9+
         lzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTclmq28GLYsw04BzrWHjRkTzltxC1UwK7DmWEtnz4Y=;
        b=Jjs0qxdoCHUfuamiRM5xcJkqyfwknpgZnsZp8zNTqC6DJLUcEqxhjy9aPsN3m6x276
         zBRLmfPSyPlXR1GVIda+wH9HjHBaIx1XYUze3glA50V7WzsCjYh/EEhAbhbO/Pepnnrs
         a0MeugwaIkPeZxpo8dmUdu7M5QS+YyeYuXrxXPV7eH5pVW8boKEQA90uYzTRzVpGWVH/
         j2j64D0WGEC1FXPUIaRpPGEroboyzQk+Pryl7L5LdGJQ9fkFVU13BBLVXjwGY5QHN27G
         Yry+miEhOfsnw3q5pxrj+A+i24JspciVOjc5v82IQ9JMv2LhCzS+AgXETWHc5P8j07t4
         7g1A==
X-Gm-Message-State: AOAM533wvHb5zjTCTZwqkSVT2WeeA0LXh06LtsG+0lAwCwxJ8au6nIQb
        tJFwV0C+jH+fhecumcOP7Vs=
X-Google-Smtp-Source: ABdhPJyIyUMdwz3u6ZmBBB5w+U+vbMx0NlPpvQjr3Gf+YZCBZjb6DmFh+D3ifSeUDjBMxXdiWvrmYg==
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr15602867lfg.33.1591708479951;
        Tue, 09 Jun 2020 06:14:39 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:39 -0700 (PDT)
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
Subject: [PATCH v4 12/37] PM / devfreq: tegra20: Use MC timings for building OPP table
Date:   Tue,  9 Jun 2020 16:13:39 +0300
Message-Id: <20200609131404.17523-13-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_round_rate() won't be usable for building OPP table once
interconnect support will be added to the EMC driver because that CLK API
function limits the rounded rate based on the clk rate that is imposed by
active clk-users, and thus, the rounding won't work as expected if
interconnect will set the minimum EMC clock rate before devfreq driver is
loaded. The struct tegra_mc contains memory timings which could be used by
the devfreq driver for building up OPP table instead of rounding clock
rate, this patch implements this idea.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index 6469dc69c5e0..bf504ca4dea2 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
 	struct tegra_mc *mc;
-	unsigned long max_rate;
-	unsigned long rate;
+	unsigned int i;
 	int err;
 
 	mc = tegra_get_memory_controller();
@@ -151,12 +150,17 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	tegra->regs = mc->regs;
 
-	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-
-	for (rate = 0; rate <= max_rate; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
+	if (!mc->num_timings) {
+		err = dev_pm_opp_add(&pdev->dev,
+				     clk_get_rate(tegra->emc_clock), 0);
+		if (err) {
+			dev_err(&pdev->dev, "failed to add OPP: %d\n", err);
+			return err;
+		}
+	}
 
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+	for (i = 0; i < mc->num_timings; i++) {
+		err = dev_pm_opp_add(&pdev->dev, mc->timings[i].rate, 0);
 		if (err) {
 			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
 			goto remove_opps;
-- 
2.26.0


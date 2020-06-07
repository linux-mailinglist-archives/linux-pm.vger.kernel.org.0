Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE81F0EA8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgFGS5b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgFGS51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE8C08C5C5;
        Sun,  7 Jun 2020 11:57:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so8829397lff.13;
        Sun, 07 Jun 2020 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTclmq28GLYsw04BzrWHjRkTzltxC1UwK7DmWEtnz4Y=;
        b=fse29tBPjCLCBGxWqXOJ/MfHHJ3fn0Bo269sN3NRX+YD0d8ToTNKF0gqNBo/maO8fT
         kFIjTZugVG4HmmLMz4LPAb0pYq+Atsn1VUnnJIX3ZGRgm2IvjLMug4edPrhdRGIy1zMY
         bvYO0MVX1tQnApdAEg7Y9TSR4QDayyN/p9NMIVnr7pRfL62NVU1+aEN15pm0wf7j4ESS
         ZD5KW8SYw+vq0YdI4L5rA7ZTl3BXzElpZkgDGEDGs3u66qfWh3N6xFBt5/qEAOByOIEZ
         1l5DF2NRWcRe5y0GuwNzZ0dF8vKfSKc/qSSp42v4Pqy0e6ODyynMnPpa+WAM3vlOc/iu
         hiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTclmq28GLYsw04BzrWHjRkTzltxC1UwK7DmWEtnz4Y=;
        b=ZukG4Gg1z/igz9T1+OosnoYVyOQZTZsou0PyAASY3ZIiNhlLGcnf6Cc5DXv7LKx1dX
         Xry6D+i3oCmBposZv95lXBtftFbJebHR4R2xSN83w4VqR9ZmJ2bAXn9hK+DLSDF4ujEp
         +ug8HIg7UnvotunHqrYvLQ8v47mXeXrsebFDlt9pshx+H+afQb8h6nMiQxGKawadi53B
         4SI8AfDWcKJnU1HJN2yf7ofvuKWOcFEa1foNFKZTB6K4XHp2+M5FF3l9F+9K2yZzRj0J
         OPCw/mtMPQEMeiBpx455T2GbE28wmzaUsy0IMMCvViQhe7QVHJn1/9NGtdBb8My3ydIb
         WDag==
X-Gm-Message-State: AOAM5313lY8czRRKCnc9rdSFmijbEtB+otfXNKrv53CtWrC54GCuM86w
        C9sxKrRh84PyD7G2Gu8wtPQ=
X-Google-Smtp-Source: ABdhPJzGkIKOUsJIxQPWdbqCeRK86qvxiPaPJFhifu3GFKSbTYmdhlEp7pmaeio9U4olf8k8sHhgnQ==
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr10504765lfu.192.1591556245681;
        Sun, 07 Jun 2020 11:57:25 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:25 -0700 (PDT)
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
Subject: [PATCH v3 12/39] PM / devfreq: tegra20: Use MC timings for building OPP table
Date:   Sun,  7 Jun 2020 21:55:03 +0300
Message-Id: <20200607185530.18113-13-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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


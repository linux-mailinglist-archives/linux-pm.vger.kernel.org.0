Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BF27A41C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgI0UwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgI0UwN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 16:52:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389CC0613CE;
        Sun, 27 Sep 2020 13:52:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x69so8749932lff.3;
        Sun, 27 Sep 2020 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9r2zUlJrQ7nkiEBpXA2Zv1BwsnURHaKKsGfTp01MSk=;
        b=pUCVHsgg4jDkQONWaRzG9b/bpX4s1TOfzL90y8GlmQkFUxCo2MaFL+GKrCXyyiIPJr
         gkImS96jOXObL9jgsyUrEo8TNVTR6Hd4jhQLOOKz0eDcVywWiPr5O2F4OvTnOdr998Hu
         NeWNLfJOsPD8pk2Pt23OJQeeEIkRm6d2V4lQYD3qtLQelxpPP//gQGmE4Lgp5M8U7Rld
         FYKtAVflIhN9bfQ8LwXTxj3TOsZRdYU6u3u5gT91u6c4MEraWIR1VFVQ4UPlaOE05mSJ
         W0xQPV0YZGJWRjGji/5eYLJF5jIeQL656kW3XSET6rjFCW8m/nsX2k0MBDfkx77an/EJ
         gNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9r2zUlJrQ7nkiEBpXA2Zv1BwsnURHaKKsGfTp01MSk=;
        b=rCjEzWbd7C+DpSsFqqbPzuuN+DnUo9n9omHF9RXIDC6ah6lBvZ37MwrWQ4mp/1BLxz
         7uNnrOctkw7JWdq0Fi2h9z85LJDOscI1mFzc3FWTACDEfgDi4NS1G+/QewaGouKABdBm
         WkuYTVCyNoPuNNTabxOvEsEM/lD4Ua2BNnNLz/ge5ZyS5sX6n1jghyE83y3X4TXSVsMT
         o6CYgxGCf6QPr++1V1NMnkw9gV8kcf6k+A+D+Sg/nKeEW2/DzMD/m3/TnBiFY0vmZX/R
         NxnALOa2IAHu5/w1G36wD2jd8mL320XMcdPrLVs7natreO6Bb3B++28VZEnOhDwlEOj7
         UEAA==
X-Gm-Message-State: AOAM532Md/NJrNcJ4v+bjnN1Upjg7ViHiuzGBzS7EBcXvEZ4lhJyoWcD
        BmMP+mPnuS+MxA2zFddwdTs=
X-Google-Smtp-Source: ABdhPJyWw7w3gRx+RybRMq2ufLwBRLagwjF81tg5nJm0+m0WQLVUPV46vXlmkeknt4pT2GRMcyiNag==
X-Received: by 2002:ac2:5333:: with SMTP id f19mr3274267lfh.339.1601239931461;
        Sun, 27 Sep 2020 13:52:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n20sm2604485lfh.1.2020.09.27.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 13:52:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / devfreq: tegra30: Improve initial hardware resetting
Date:   Sun, 27 Sep 2020 23:51:39 +0300
Message-Id: <20200927205139.19548-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's safe to enable the ACTMON clock at any time during driver probing,
even if we don't know the state of hardware, because it's used only for
collecting and processing stats, and interrupt is kept disabled. This
allows us to slightly improve code which performs initial hardware
resetting by making use of a single reset_control_reset() instead of
assert/deassert pair. Secondly, a potential error of the reset-control
API is handled nicely now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index dedd39de7367..f5e74c2ede85 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -822,8 +822,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	reset_control_assert(tegra->reset);
-
 	err = clk_prepare_enable(tegra->clock);
 	if (err) {
 		dev_err(&pdev->dev,
@@ -831,7 +829,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	reset_control_deassert(tegra->reset);
+	err = reset_control_reset(tegra->reset);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to reset hardware: %d\n", err);
+		goto disable_clk;
+	}
 
 	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
 	if (rate < 0) {
-- 
2.27.0


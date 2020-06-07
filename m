Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390191F0EB5
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgFGS76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgFGS5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B8C08C5C4;
        Sun,  7 Jun 2020 11:57:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so17770657ljp.3;
        Sun, 07 Jun 2020 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvPgx7nfuClCEbY/9qNxk5Wqh42dXshULVk6+zlWjrI=;
        b=Txv9TK5zoOMhF7vXS6mMGopAvQ+wLC0R/0y093Xav9/7fflf+t5MEXh1lX87cGtY7t
         EcIm+ueYddyomNsmyAYXjNonsld6ay8KVREB8rcJeZx+/W8YmwEudUGkYcyXR41nj0VB
         GKutkpURwr+mUIjkAOti8e8J+81e6jRcSJVlC4i3BZfaAXHj7072WB42o6YublbDu09+
         8zStnINDe3Y+8D1SQeF1Ib02vyjoXXPwjloqf2s9xU/R4zrPFzanc1gRCebkc0N6QhLo
         djzCJxqaKgHmuRQjAR2joQM5a6TMR1drYGm57cvhYNb5TK7i4EWU9ITCknEgTpCJvQrt
         xe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvPgx7nfuClCEbY/9qNxk5Wqh42dXshULVk6+zlWjrI=;
        b=oPEIUl2oANS8y5e0SLtWGwD4gmQF5nn2IubdNTl1JJA8nPse/wSnglkXgyhP6Smb3O
         pkYTrATSMNUp8RWxqirL0EQneeJG0MVhVFm18uM4vXG9CqQYNLFlOd12UG9KeLigUc1h
         iMDZs0/KfCbtvvYGsjmcfTK/ySfoN0xtje0niAos6qRLn73t/SF8O+tzLxfrrzSyhAMj
         Gi9Z8w92E7IKpNhGCLbEdWJY8WxOEU+Tq6EnY4lh6gy1Qae2BRxjW90jBzO9jTJ/zWWD
         hdoGJ0N6Q237PVrbhb5W3xqlbKQ0s9k3w0Zt4cJnURkHlLGQcCIM9FP2MAeOlpmaDDrZ
         ptrw==
X-Gm-Message-State: AOAM531n18elsIkDDpAz+r2rhe8/7229Q/a7+9l8MOt2hK6voHCgP5+L
        MRnRpasvkCFdlxgJU7KtC3c=
X-Google-Smtp-Source: ABdhPJzToqPSxd3YO6VNTABt1RtCoxHsyBrguxlEv9L7QuotPpVI46VP9V3JtmxqUgxI2eV/+FvM2w==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr10029549ljj.369.1591556249647;
        Sun, 07 Jun 2020 11:57:29 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:29 -0700 (PDT)
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
Subject: [PATCH v3 15/39] PM / devfreq: tegra30: Add error messages to tegra_devfreq_target()
Date:   Sun,  7 Jun 2020 21:55:06 +0300
Message-Id: <20200607185530.18113-16-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 13f93c6038ab..a03fb16c5c4c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -641,12 +641,16 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	dev_pm_opp_put(opp);
 
 	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to set min rate: %d\n", err);
 		return err;
+	}
 
 	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to set rate: %d\n", err);
 		goto restore_min_rate;
+	}
 
 	return 0;
 
-- 
2.26.0


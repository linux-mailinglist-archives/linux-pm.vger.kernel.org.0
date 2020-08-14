Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19EA244254
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHNAHT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHNAHS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4CDC061385;
        Thu, 13 Aug 2020 17:07:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so8072750ljo.12;
        Thu, 13 Aug 2020 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OACUgnIVU65tzsOzScIriTEik4ElupmW/3n4uNknnCw=;
        b=kZL77P19rsPfMMmuxF3UHL/Nw2J9zg9LBziAuYQ3QGHZKN9kRvJK7aiAXbyRYjKZQ8
         /5Wmh0LE201J+xiNAsLVXtEFIHp7BqFJaetac2UzyAmf4fwbF4Hz5y7PQep8vSK0S2yD
         +6g/WwNIulGxYBcNf2zp7lmJCi0+MZqEumQcasLcUhjAwuVx2pC3kyKNxrXDx6YRHGHd
         FZKLo9faGDn8FGsUuvYBT+yQ8b/cTDloITpIriRIGl90pO6Ftvav1FqXrsFGOwBd2hsz
         aOjBHxaHnknr21wkmfTOjJMnHlen/Eyyyg4xWKumXfMyebpvCdNKn6XJOi5Uc2hXVU50
         PRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OACUgnIVU65tzsOzScIriTEik4ElupmW/3n4uNknnCw=;
        b=eFuy4qMMrVa9jhd/Tt6Sp2c39d0npvwVLHuUnNV5rRX7/5Y961+7/yCVNf2q1KCayq
         LDQcpg7+Nxh+2B6w70lt/mIOlH5QxoGr8pOQozvooYqFGajP0bxpcigki7yiS13PRmSR
         FWy8kYAF19lqMR1NPrjg4wAm4y9BFM/oItOK4XaFFKmYPeI2r0waYJfOp8nHD5ViJsrA
         kWvyXEZrNi+xcKnOWDcwcOtQI/LaXuZ68zuqxJNKKJ0izbqN1OCaBJ9f1O6CGOzUPAk1
         OAhMEpZfxPBAEh8AXf9pM1wfGXxBYJ/VRd5/HZ1+FDQ5G+Vo4tAU0HZO4n554CaaQaHG
         EG7w==
X-Gm-Message-State: AOAM530TK2MxfDd4fcGOjz00EWnGk3o7jAomBR452K4sCSciB3c8xluE
        DTETawpQibPOQSPw98XYzK0=
X-Google-Smtp-Source: ABdhPJwZBq6RRxfSxs1QS6UjMbi4aAPxYtBEkRmgJlSMBt/bp0JaRodpMylZTYNCmfkGoS/0/xKH5w==
X-Received: by 2002:a2e:7504:: with SMTP id q4mr107843ljc.41.1597363636645;
        Thu, 13 Aug 2020 17:07:16 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:16 -0700 (PDT)
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
Subject: [PATCH v5 14/36] PM / devfreq: tegra20: Add error messages to tegra_devfreq_target()
Date:   Fri, 14 Aug 2020 03:05:59 +0300
Message-Id: <20200814000621.8415-15-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index a985f24098f5..bc43284996de 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -44,19 +44,25 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
+	}
 
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
 	err = clk_set_min_rate(tegra->emc_clock, rate);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set min rate: %d\n", err);
 		return err;
+	}
 
 	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set rate: %d\n", err);
 		goto restore_min_rate;
+	}
 
 	return 0;
 
-- 
2.27.0


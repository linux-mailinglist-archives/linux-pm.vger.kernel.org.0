Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D871F0EAB
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgFGS5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgFGS51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5260C08C5C4;
        Sun,  7 Jun 2020 11:57:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y11so16107669ljm.9;
        Sun, 07 Jun 2020 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psA+m6s/YQ71wfUHabJ5pnZ0YjIiMWnkB+97bmL+R4g=;
        b=S1PDuGNq7E9mwtIgJv3NytNhAkTlVeUjHCERs0sHTWdJynfgHKj9HKiJlkdyzlVByV
         oTp2g0nv9D+dx1ZvNNYB+EUg/qEggXllzjIo9USmcdTWZCK/K3K/8XLvWKwVsdT4Aver
         mxSLQ84VaSkpwXgz7vvie32cUccuHsXBPRIiPtkHDrriVpDH7z0G3EIEPoOrl3aibOJX
         SDMGs+K0Xz96yoAZ6E6Vzga4ARu4CsUIg9ReLIOTamPFRF5o2lFCXVhVfF5sJRuAub+O
         V0TB9avmvWpoA0GHdFcNb9ZFuVvoIQXYauZiH9NcI/qJQrdIkEYcoq3n3DWhaTZSqiqS
         BGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psA+m6s/YQ71wfUHabJ5pnZ0YjIiMWnkB+97bmL+R4g=;
        b=GzOyfqFybxyrWyaMeM1kHZiEZ/1qU6fOA1I9nUL8ccLaX9afGAH7H5PSSlf3CYJ2R6
         zp+ewircf8zdfJRJqZNa5Adnd56nOWhbbsbYksG40KS7aiLrwcVO4Hy5Vn9cYLuguH04
         GkFlJLpeAmCHxxTKgcUYCODMVV/1lk7BavBhYvv7vOyr+YhqqKZIOpXvu3Jmjf7bi9VV
         vcjTpDMCLB6zPmZXDEPpKxVsr+wjZvS2Q57/UKqx558bHtUpCbBb9pmg3cFjLb+mWmIX
         dQUo4IHhSiQkXhKh5N7Bc/h6bv1GJKIOiJed+Fuolk1ctlRk3NSlQUhlitAqu4co2MAU
         JlrA==
X-Gm-Message-State: AOAM5330dcAv6UJ6E1I459R1rKTJw1dNgV4fpNhShsUSzkHSe/H8468n
        X6SOkLotZ1Vh/4/17siv7C0=
X-Google-Smtp-Source: ABdhPJxheN0cL1ha+60/pLocAeabnd82f6oNwfdCGDjVhdBvpii8MY/VqywkmCm8atJ9gMWg7PzA7Q==
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr9784645ljj.149.1591556244340;
        Sun, 07 Jun 2020 11:57:24 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:23 -0700 (PDT)
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
Subject: [PATCH v3 11/39] PM / devfreq: tegra30: Silence deferred probe error
Date:   Sun,  7 Jun 2020 21:55:02 +0300
Message-Id: <20200607185530.18113-12-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra EMC driver was turned into a regular kernel driver, it also could
be compiled as a loadable kernel module now. Hence EMC clock isn't
guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
there is no good reason to spam KMSG with a error about missing EMC clock
in this case, so let's silence the deferred probe error.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e94a27804c20..423dd35c95b3 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -801,9 +801,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		dev_err(&pdev->dev, "Failed to get emc clock\n");
-		return PTR_ERR(tegra->emc_clock);
+	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get emc clock: %d\n",
+				err);
+		return err;
 	}
 
 	err = platform_get_irq(pdev, 0);
-- 
2.26.0


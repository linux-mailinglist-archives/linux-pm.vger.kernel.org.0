Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220D244269
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHNAJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgHNAHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4950C061757;
        Thu, 13 Aug 2020 17:07:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so8142176ljd.0;
        Thu, 13 Aug 2020 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjS15xtHXrUnM7iCNXL7EPsczHz2L3DzWOt0K6mcHE8=;
        b=YFCS2QrRp0FGtc1iVsHYn+sIReyd8H2Ajt6myMTgLXMJhH1urQnNvUnQcIUSCXG2g5
         a7bN9akTMATX4xOuLot4+FTXmdwxXcQrw0Mfg93Nb88rhjkjCQE6455J/2X9KiPRU8kD
         iI4S3Ybf8by6MtqCE2e+Do/QLZZ867H6aK/+AZ8NMJD2s9zpTnyNk0MeYKK7gVH1H/KI
         rHTMIz3M19VYOu0OLusDkGC5LTTMXNaviuxP3tbndKhn4KOqCYGzDAyFSdCdaLS0e7Gs
         pfPjnJZLlT5iZr4wVJvG7RYVMhnq840cLcqZcBioEoKI3nChe6xluYlpcCdoi2taVEPG
         vkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjS15xtHXrUnM7iCNXL7EPsczHz2L3DzWOt0K6mcHE8=;
        b=rJyIlXa7ZfDS0QvIw8cQ2ARpmlGlMHUA/nm9q/zCWNhDuJVhOZUi1sow6t0GRfnHSa
         qa5Odqq6l+4xSPFkSal+c+fBDo8yN8A/OmkAirumUbSqf18UqpOGl9BFYPhiiw9eUB34
         R3/5scbmHpgMRDgjeMTY9TxtJ5KwgrBkinr3v1TKV8JGiMVYvbvGv/FYHlQSuPrpQTWe
         SM0wNk9cS6+OyDPzRAtMmJK1P2PNB7XVcC5cPQsR/w0YfO9oMIrF01O8bjkzFiAJLJNr
         PhFlVpegfwu3je3ssrE00A6YJrkjmbJ8O6QU0UsFfCHO4LtkA+3dlOQidsexnS5Tlt9A
         cJfQ==
X-Gm-Message-State: AOAM533a8WdVgmOF6hj+IJIJdfax7jSZhrSFnVwyNP2E1IbX2DOk3ujD
        r8aTBXmC7CH5k2AWjZcfmXQ=
X-Google-Smtp-Source: ABdhPJwQDYHAtpZ5+gDAzMB2w7Bzd9T+Cz7ZuPoj+LPBOqaXO2G+ZzicL3WI8E8Tos3Spd/SPclalQ==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr107967ljn.422.1597363633314;
        Thu, 13 Aug 2020 17:07:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:12 -0700 (PDT)
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
Subject: [PATCH v5 11/36] PM / devfreq: tegra30: Silence deferred probe error
Date:   Fri, 14 Aug 2020 03:05:56 +0300
Message-Id: <20200814000621.8415-12-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
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
2.27.0


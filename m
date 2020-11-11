Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38F82AE56E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgKKBPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbgKKBPT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0510C0613D1;
        Tue, 10 Nov 2020 17:15:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w24so580018wmi.0;
        Tue, 10 Nov 2020 17:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHNbWPkrTb0yyMBNVbyvruwI0j5FiAUBfarfcvC5tnQ=;
        b=K9k6yRTEzRmQ2mqzH5BNitSKPtlpx5UPNyhzsfZ3CZXuqxGDCx+3rLioJqtOWRX7fp
         GbN3Z2ONcjIEOS+L+3kpNplyVgPAAmJausNFSZRSiSLtZ+b3GzkEf2kB2mJWffy5Xe3u
         JEHqAM96aaGSh5bOoWD4xKBjGg0L8V7soyOGoA040QWKRSMP3moX2v+LtsF2BOmH763w
         hbVeRZVjSXWFcegE64SVArJbvvlhk/NzXEyHzezsolEqZOAjfMozyFGUI6b7wDlxEYRp
         1nP8o2gTAfpMlgQh9BAzAcYfURzlthM0rb+bnS76SmQ5u2S3b6yay63PmoRoKGb8wiqq
         dTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHNbWPkrTb0yyMBNVbyvruwI0j5FiAUBfarfcvC5tnQ=;
        b=bVXxc6rpdqXKV0+zQwAPToJ+73g9xOqJDXAYRo56Q3ONnzl3L/XNmc5MNvhCURCRzq
         zfcpBW0+hrz1U7smm/VfUxBChuFNtU0agrOyjbtsb6Dx5nR83TVLoeXQNjJUv0I7UmZu
         9+zcDWpg1fKy8KtkJbCDNaQpldUmiUzNk9mTNeajJo/ZdfDEey7cUYTsTbEUhbmDkD5I
         +hcj7a2SIAbd0nSLHQaY1ogXlOhebyhTS0lwvvy7T4FFclPScj+C/ITbSvjdEVkQdq/E
         CDnrS6Yu68yKh7eFSvp1p+ZnFOFO5w7iCzeDYCzv5QCPrP4AFMq7GFFNGlR6wUR8x7pP
         SdDQ==
X-Gm-Message-State: AOAM532GsQ6ZW44pTpyNCcdyqNi9/8sx6p4IHc3dWG7aXtsTSI0hfk60
        QvPiwkpWmyXz7A8yY8YhUUg=
X-Google-Smtp-Source: ABdhPJwMpC8/L0r4cSYNPDf8hWqCNiTg7SuMpXF6Myd+0zGn4oksOR4Ah3UwA/Ww+8eibE7SXUT9kQ==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr995368wmh.10.1605057317711;
        Tue, 10 Nov 2020 17:15:17 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:16 -0800 (PST)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 05/26] memory: tegra20-emc: Remove IRQ number from error message
Date:   Wed, 11 Nov 2020 04:14:35 +0300
Message-Id: <20201111011456.7875-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove IRQ number from error message since it doesn't add any useful
information, especially because this number is virtual.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b9cd965980e2..0320d9df4a20 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -1131,7 +1131,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	err = devm_request_irq(&pdev->dev, irq, tegra_emc_isr, 0,
 			       dev_name(&pdev->dev), emc);
 	if (err) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", irq, err);
+		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
 		return err;
 	}
 
-- 
2.29.2


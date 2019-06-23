Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE7A4FEA9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFXBuw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 21:50:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37536 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFXBuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 21:50:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so10928839ljf.4;
        Sun, 23 Jun 2019 18:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFAhsxZO8T7oZCxQiimcCo/LECLyus1D6/1BOS50MWw=;
        b=E2kifvmmy2gkmDOOuotj98pK8r+bOT2Mu3aN6jHcZVrA05ekxa0KYmYWF2Xq4BMacY
         rjtrQDXJc9przwGkUcfzTG5IDUv7A807WL+i9LLztPLYAqHJfglaQ6SkvfOUOVzMlKxc
         17RThbglHNAn7TBzVbM8/iBL/MXeAAjyhi8z1AHKo+c1JSBYnke8Ivz57H7htIrw7esy
         dmyBpmBPUA5kHLRaN82HdYJCWlKx0L+a24kUdoYKET8r0x7bEApaVLGDaXnymci3dFb1
         CQs5d0yjiFpagRZ48Yt0kI5BOZiKbsD9ePn54dElkr1qZG3JvZKyLuAbpqbF5JHvOs1e
         k3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFAhsxZO8T7oZCxQiimcCo/LECLyus1D6/1BOS50MWw=;
        b=R23mBmi+iHyuemlRWGNQAGZqcKJqzcKe4cY58a4vdkkZd/mv0BwE87V8YfrzN+/hU9
         f3LLVkA7zmEOCKCooaqFGVsKZgDwT2kCEm3cUrkqbELcdXHGnPgKX4Q1ZD5JUrTV7PUJ
         tasytymrZyj7CXEWKFSOuslmjM6FyF7f2sC4Vd2T2QyLBXjDjYuYKxXI5QX/Mu5E2H7t
         WICUd6aIjkeW94ksbV8Q2TbAZ6uxdO4avC3uOEUynnYCYXVfVI8Ttk2s9bBrBdGIEHhp
         qstCNXhETLjsHGcPsYoSAf6vtfcR6uRj0jdGAYbsv8C/zZvZt0BAOR8m8T0IykS77K8d
         Iz0Q==
X-Gm-Message-State: APjAAAUIngf28EXfIZ4H3EJQ2t8DhkhZRyEpELsKbtyL3tR7px2wn7M9
        Ag1QjJ3xSTr8gV2z/93llnWJMRW8
X-Google-Smtp-Source: APXvYqxzc6HuObFu5DbzYy7Unm9KOZXY7WwP1d6nYBJ5H/BV/iLBfvSJXcF5kdZs8bMetpEsE5FCxg==
X-Received: by 2002:a2e:9a13:: with SMTP id o19mr12704403lji.102.1561326516005;
        Sun, 23 Jun 2019 14:48:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/11] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Mon, 24 Jun 2019 00:46:48 +0300
Message-Id: <20190623214658.11680-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQ numbers are always positive, hence the corresponding variable should
be unsigned to keep types consistent. This is a minor change that cleans
up code a tad more.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a6ba75f4106d..a27300f40b0b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -160,7 +160,7 @@ struct tegra_devfreq {
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
-	int irq;
+	unsigned int		irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -618,12 +618,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
+	tegra->irq = err;
 
 	reset_control_assert(tegra->reset);
 
-- 
2.22.0


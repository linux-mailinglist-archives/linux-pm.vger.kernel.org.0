Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E02E92CA
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfJ2WGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41283 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfJ2WGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so331555ljh.8;
        Tue, 29 Oct 2019 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=PMM8ZHjztDKj7RfeyexDPFQxTw09ZFSUJpNTpZ9LzuPgybf5cs4PL7APSEHSNBZC2f
         aZdGGdnRFRL4z6L1mn/WABTWyJKh+B35T5dqVaDyRFa8Y5vHQkyljwkz8qCSQEdBZkw7
         5M20UBCndnb8dlK0xPiDgebcO60KyuReTh6Zlmj7mrbnpSOkE8v9cW/NmT2V2nPV6g4b
         07xwr9AY3leVjqbuF5aZWZ0D+6V1HccNQf8H8FQ/qpHSnjsLJ8n5/nVN1IiL9AePpIV1
         hPtbnmDicHq5/mFBVXGBVHoPAX3z/F8XqQU2JkcdiB+MolzyaxxPsRuS/aIb0s8NQ101
         JJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=d3mAmFN0fI3npDkWgqXFH4cfZo0M4qW5F93Xf/hM7v9yj1meCOcRhW7+XBSHrSoRMC
         jUwom7Y1Hb2eMMRTsBbECYjEJfQJOsDC6qge4yXwnJPXtRdaTgAxYmxIVdhZJCPNW0lv
         Zny5AT9szbCpk0ZyFAsZxfGoI3jjIldf6AXYl4CdiTp02aO7g6OP9Y6th/zXneAIb/5+
         TnzIxOKAbie2bwod0/NsJYH1pTqDNNi1lqlfTialRnU9f4Gszd7j2As4OcRSgWrL8mVf
         hz/n2ktatZc0vLw1dp/wmXVWcW/1vHbil+M62bIUCr7fFs+ng0nk1VmOPjUSFZGIUBbH
         WNdA==
X-Gm-Message-State: APjAAAWGjxgpiUFTU9NyT7n8IYketCJg0n6jh3d/vZeaQIxXgWsYFCE1
        YyKSFOxoBmMVDoQ2uP7h58wTrkkC
X-Google-Smtp-Source: APXvYqyF61OfNi9o8iSFdS/6C+hpCB3nmkDxZsfipOepvNUFnmu2YryQ+1qQRD7iVJBto6mbc8G83A==
X-Received: by 2002:a2e:9058:: with SMTP id n24mr2463465ljg.114.1572386770132;
        Tue, 29 Oct 2019 15:06:10 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/19] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Wed, 30 Oct 2019 01:00:01 +0300
Message-Id: <20191029220019.26773-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
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
2.23.0


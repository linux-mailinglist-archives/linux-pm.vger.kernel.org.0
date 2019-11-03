Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364E4ED4BA
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKCUmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46217 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKCUmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so2072141ljp.13;
        Sun, 03 Nov 2019 12:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=sA8KNKslQTu1fx9Hz2fbizBl3BgADQEJQ/twcTW6XrldX5d2D0pKA7E2P5heHDDM7b
         3ILsSBEvYvqKEb7ziEm8BRaPMUyYxbLT83+hcofjRGccsG9eNti8swPW2LtgMD1qxCqy
         sn0himHN/mWBVAEs+Z90pyRRoLzCEIgzir0G+nM4zssLUWzVe8RTp8B0HqXtD5hv+5Yo
         lqqthKze4yEqzskH+NlP/w1tQ373kWBRV1t3fLYRN+OqmyeERoaLybyy+fQPss09afP8
         c50hmBwzPu1J9jOaAxe/P4AeDhjszouAS/n99Kk8WZcEHO0DKlDBELC/AV7alF/RqVLj
         MxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=NN1tR60J/llwfcbCGJ1UwcHie+zxgnDRjyP8lg66hBMSjmjvADfkxlMD78udi4psbN
         bikQ930SqIBG0EKAnmdI4X56bmNwWUXdMsGOTdR0ZSIbQMia2XBAnEXnTmK/I3AArFnL
         eLK9ttAxN3BYwna1MX5FC3kxRMI40Sip+gVdr5QdI8IsVkr0htj7qnN/m1RSSYMFYFOg
         cUlUoyRgI5psa2xfvFWZi2o1hIIGsn0Y8ngJIzrvu6j/sAorERGXaIaZ/MvebYS6ICqp
         dH5xW7IAzjb+geAC6Z7DSOBCPFVdOENEAWSm/zhBZVkbjoDUUFw68BTngIRWboFPR8FY
         FVFw==
X-Gm-Message-State: APjAAAWp9lwET6JR8JuscbOvWF3MWMdb2BFr/s2ev2h7YdpxB1g/qNvL
        nsu7d6T2WnYpTNtMvBtuAV99RHTm
X-Google-Smtp-Source: APXvYqw4+G9IDQ4vnBSolbpPMmiz7JH+55Y/+11xHwJDYjXvbs23dzrbkHtOQj0Ha1cdpi/nGI+gTg==
X-Received: by 2002:a2e:3a1a:: with SMTP id h26mr16288308lja.25.1572813723354;
        Sun, 03 Nov 2019 12:42:03 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/18] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Sun,  3 Nov 2019 23:41:13 +0300
Message-Id: <20191103204130.2172-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
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


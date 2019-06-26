Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB44C55DB3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZBfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41954 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZBfA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so353131lfa.8;
        Tue, 25 Jun 2019 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=MxKfXKnPT5mUDPoqglh5+YiohAZpvcCzyzIufEJPnla0muTv3ly39mxL5xkdwZ28zh
         sAnpH48Qu2jYcLaiMxQ/g0GAy+POkFl7vGZFEWd0+ejhJM7YgMrmMNMU7Lg4UG1gmPzW
         sQWsIfrKZ+SpFU6g8ODMs+LkoSEHYCoQ+Nv31OpEAk87957B+DpDChUJAA24O5QnhWFd
         T6JbsavoIi6e/HfTV81nKTSFMMKLSWLg3lkh4bSiO9rcNqdM41uZffUM79WLcdW78kBD
         hzwrPWUAXhm6A4n+zsF0uGyThYYqlOGriOtq3zsWvhUSFhncUIshrcVgowCgySNlfmit
         IoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=f7mzOq+cly+UZxwz2MqFEghFhtqb9JBxkP2eLBuZxm6B8XCA1Na4uy6LAFM9RqUrQy
         pn5D+3/FDo00+2vug6MLco5042zgm1Y+ov+5eKMD8SUkS4Hrueq6ZYc96hEtYtY94RYI
         B935M2Y13SwKhqRWKT2dXM1wFasweyvg4cgI+Vhqrdmw8HGtgBuhr7zNtP4Qx4O3IYAk
         X9ZqooiXz7PrEUvsEhxu4U/DLgzu3yG8vLM+1IknbLksbfee1x7LB7W809jWwHdTdmo+
         xszajNJjPx4g2J4sklZOW2YVDW6tp1s7iO7oFf+XgiAvj1HFzggYj3jincgZnaHMbMzn
         /w2Q==
X-Gm-Message-State: APjAAAWXqaj69YYxMyVq4spOyRf44aIOSQbFfyTvFp6nfONjzT4qzJ6E
        6B8f6x7GY29QItN3SUUgmks=
X-Google-Smtp-Source: APXvYqwAYLR5E9BD2lpKo/RSk2pbuwUzj90QG0Wyb23ZecxQAZBkqRtrgFTtPsw63j9o7CBQ/Nhu5Q==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr928166lfy.51.1561512897944;
        Tue, 25 Jun 2019 18:34:57 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:34:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Wed, 26 Jun 2019 04:32:35 +0300
Message-Id: <20190626013252.30470-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
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


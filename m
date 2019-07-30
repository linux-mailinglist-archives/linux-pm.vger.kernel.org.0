Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBE7AD93
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfG3QcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfG3QcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so66483537wrr.5;
        Tue, 30 Jul 2019 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAb/Wbf6jN1XW90qv7LwGWyr9ST9lsuKJ6ZQmhSvlSc=;
        b=B52Y6ecYwJ01MrPj5v1iQKo+08trN8HAitRyDdmF2eAeduJVshReg8PtQ1vLiEnyzz
         eeblqXSX9dvocNnfWLW+xQlWbeqGTSWQJPHkX56IzGecCNoFfvpsiKoyGfVkKWc9WQiD
         InPKWczClbZG3zyJtSxFuAR4nUxCC056S7h8ZG4mEg1K3CLvbNCsnHos+rC0ghNCARaO
         zWu6VeG89edOTp+oahNKF/lfcYLtK8S8tVCdp+YmpJ6JKyyDWdyo4yok/tyr6PbaIqIP
         G/rtO0b2dCCK0t7zlugrq4Y9ct1/2ePtUX4DYjN0dhb+ZmH1iXwmPazp9Q9a0julPj9M
         m5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAb/Wbf6jN1XW90qv7LwGWyr9ST9lsuKJ6ZQmhSvlSc=;
        b=S0ms+tOiNuZGGhfl9Z4Lo0YIJyWopiKQsM5gb95r/HEK3+uUw+jx1Rnz7+SPzbPp/B
         DbuGsQ40Uy44jh2R73M2fQjerMCGtSKe0kPbwMibkhyFynvBTQ+Y1H8wSm5yQAau3clM
         62Ef+56gje4sSx6431jk99kKOsKELfi9F69y02eTWKu/wepveWJt0joLya0YwvppIUJm
         qmL4xRP8YrZuNRdkA+gYHgmY053tR7O2zv480wwANhHU5L7/WoMjXd7zHEVCmShv88rX
         M0burzOzbBPQVtwbdxB+N+jCiTkPUdRI8VrOqmbtge+ILivqfeALuMnJC04dbdKt9niO
         hS3g==
X-Gm-Message-State: APjAAAVTFQ9ooELM1sRTw7vmdftHYjiFVTyawQ9fDxR5CQvWBRiK09f9
        lwFV70vvbbIjuuulaqaoDgM=
X-Google-Smtp-Source: APXvYqz9QrAYsJsoZlzHjSb/eLW603ZuvezVphBqMkwt5SXjHAVKaSjp0aWaacXrI+0gT5y0RMczIQ==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr51092367wru.125.1564504340045;
        Tue, 30 Jul 2019 09:32:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/20] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Tue, 30 Jul 2019 19:22:17 +0300
Message-Id: <20190730162236.6063-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
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


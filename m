Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4054EE92B8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfJ2WGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41301 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfJ2WGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id m9so331890ljh.8;
        Tue, 29 Oct 2019 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRymNhrJUhLlZEEx42xq+S6wejhNhQ6tSpFG1qtRzpw=;
        b=WW7Hhztj6pmwQMcH+VCKDTuj8IIqqw0olGTUziZ2j/ED6oLrlxCqH7Zbl3Hhk615W2
         rDC8y78xeKET7BCxmy5slZu3bv1TvM99heaeOCgPj0btDXFRr2HFGFAYeV/Q3/4/IOv7
         o5lmscIQangfXboAcDIrnTyQbPWuVIPJ89fZadhgeZkrv4NEIYNjwYYqP/M+wa3upO1e
         /QLSLsG+oODUDfy68v034zq2o+k0f572jcoR+iHT0zCa5jfx4/NLdFphziomxWN9/QDk
         UA4m/rNhYvX5fdRKRBlo5p8qKV+elE4Hjt1maGXuy+U8OI9SR5xxoQvoxWRF70MJTHAQ
         MpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRymNhrJUhLlZEEx42xq+S6wejhNhQ6tSpFG1qtRzpw=;
        b=c53T+zDXalw9633Zy9SihEPZpUrMpoflK0shyUy3+UcVZLX3W+bZkn48D/Fsy8wGpK
         0Pfw2EzGJKOfcUbf5TKe/kxRsoJN0iqcchkWXBFzEiGDQSHTyRpuB6aKSgVISXf7VYdB
         NXHaPpJ5brpoNtFNRqKv2qq6Z6271WfqvN+P6+u6517ktIftBqhXHG4usY3/wU9gNxgv
         Hu84cw5u1Bwc6yHrIuy5ci4ZDJB10ktkxALGT1SpDRxOs3IAU4RYT41DWxQSJIKorNra
         auQfhQo11ZT1IJch1LKobpvPx+m80kGyFRti1qgTagWGn01SPE5G0OIWhggZmYDtBI5S
         rWxg==
X-Gm-Message-State: APjAAAWULEInxAN/xtrwtwSOPpr6C10IYXLr5mNWjL6bNOaMko/R301v
        07I1Tmqj6gvdxJXfH4FSvS4=
X-Google-Smtp-Source: APXvYqzShsW7xQ8Y5tOH8hiVPhNxSCTFpx7CFzlYNz2ytysZ6qP0Vw1ASdCGTKYCIoQJnWfU1ll0Sg==
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr4026803ljj.65.1572386778343;
        Tue, 29 Oct 2019 15:06:18 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:17 -0700 (PDT)
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
Subject: [PATCH v7 09/19] PM / devfreq: tegra30: Reset boosting on startup
Date:   Wed, 30 Oct 2019 01:00:09 +0300
Message-Id: <20191029220019.26773-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1934b4eb4e78..fb1163aaaae7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -467,6 +467,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0;
 
+	/* reset boosting on governor's restart */
+	dev->boost_freq = 0;
+
 	dev->target_freq = tegra->cur_freq;
 
 	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
-- 
2.23.0


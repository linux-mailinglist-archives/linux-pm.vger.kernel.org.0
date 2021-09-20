Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51C4127AC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhITVEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhITVCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 17:02:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD54C059363;
        Mon, 20 Sep 2021 10:23:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so31880755lfr.10;
        Mon, 20 Sep 2021 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FH0NgxJWofET3fg5T9f/eJzZHrX+F/eL7pq4def6uQw=;
        b=q1Gf88uXqLRq3AwuB/CdnFpMAERakzmDWQ7s1yj0n7DqBzkX680ZfEh6OMiNliwMIc
         kCBvBA0Cf+kFV5QJi+y3aaO2H6vhrk/Nv8EGYfw2vfPJRQTwHXAKOPZcyMfzKYS852mf
         yBFCVhJLKEB641bZw9/px0GdxtQkNkoq8fdFWCzpNQvjISDIYp7uOiz1+/eON78PJ2p1
         aLl/JkMGeHk8Q5e9QcNgzrKr7Zfmn7lDgeD9sI43SseXwX6VknYe4CfxQ8DofBTOl3Vu
         PwxwCJAY5Nui7OIYb7WKvE6UczVr28JJodCqpW8JsKHdqDQxpmvlxcunTaBHC4DtIzcb
         0XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FH0NgxJWofET3fg5T9f/eJzZHrX+F/eL7pq4def6uQw=;
        b=KXM+wLUcJgLppK2W6Vz3Y/aH7Qw/GI8eoD9q+r98gAzHRwRxSDZp/9XaTRHqgI2WT+
         wu7J/RyHIEvyrqLwBt0rVfCeBDSfpPcpPY9vF7kBjkJD3cyBNzvXmo8QTS3z9eeEAOoK
         J7+c4SM2xc4KR4de5pCPYONo7pDczCIZPR/v+nZgiBYYZFOBht+OZ9UMMCNTkH10ZAEG
         Hs7+mhlqk5raYhc8nc2ibEFk7Zs7HL4Nz66TsFvvoHWnDyRIBmnZGDaTYoXKoQl6VtQM
         s1hrGxsWTBwJefCWCQ1NsGL2h+udbhEBbr8qCyPKVmk/V7U1xOlQWSl8Ij9dkNCkY8Wb
         RtdQ==
X-Gm-Message-State: AOAM5332RVyteIg6FvhXLHNfjNqErd82S7K6uMgCwpkuDkiRAWObZnhm
        wF2fRuegOdQQbq/t9VLvMOg=
X-Google-Smtp-Source: ABdhPJyPvN4cSVL2kD7wPRc/kuAhlKI5+a+HKu4WN6DA7Q/2GqPk67C3wcNlO2sGQYlfoZjC3Yumwg==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr20858664lfy.140.1632158597129;
        Mon, 20 Sep 2021 10:23:17 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id t13sm1311038lff.279.2021.09.20.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:23:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] PM / devfreq: tegra30: Check whether clk_round_rate() returns zero rate
Date:   Mon, 20 Sep 2021 20:22:49 +0300
Message-Id: <20210920172249.28206-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920172249.28206-1-digetx@gmail.com>
References: <20210920172249.28206-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC clock is always-on and can't be zero. Check whether clk_round_rate()
returns zero rate and error out if it does. It can return zero if clock
tree isn't initialized properly.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d83fdc2713ed..65ecf17a36f4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 
 	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-	if (rate < 0) {
+	if (rate <= 0) {
 		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
-		return rate;
+		return rate ?: -EINVAL;
 	}
 
 	tegra->max_freq = rate / KHZ;
-- 
2.32.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978E158CDA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF0VMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0VM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so3770341lje.12;
        Thu, 27 Jun 2019 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=czuXZoTypGF7IFBSRI463FGPnROcd4vPfRF1FBbfk7M/mUscTLsvaH2gizlsDJ/NOl
         BkcsSy9Y+HefTH32X/1cKuSUi46RpV3oc5VmQgCWmsHCAK2Z3pRLxc+EzYxca+jHKkuh
         /g/2bIJYuuoOdlTfVUdSRlmEmUVvu3dyb8bBI7Nx0mcBN/EowclulXavAq7iN6hqB9vB
         w3cCPnmE6EDHHimMQli/3OvAgeP5/v8vYzNwQzSjcP0ye8dkxuX7OweALd9PJ85mfHjg
         k5rn5u+o2FO76yx/5/NeyxMiRKalKpKXox8QqADrrKDxa6tXr8AJWbiWVV66MfoQ9/gA
         PN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=n/9P0aIi7CNjnM1Wy4t8OScdLsP/h+CZk18NaxTsaVtsORIj/N+FrlHXeTfzOtrSXm
         ymqRKVQzHbog4oVzm4s1lp4QGnlJybvaYoy1PDENuZc47K0zr3srtVDcqJTnVAbTxK93
         J72EAMzPf7xVTL6GV7YXQ5ZFJpkvn/98noePjN7sq8ime4AK13VKhVd3Sy7K5jNEGr3p
         FqwIutjj3wL0mJHQgBiKT/eg+KoUBouiowvnA/Bkp5nEvOnljjWWTeeX04ye0aQv2Jlw
         5CKUWMvjHDRetkYZVIwlHDm4WZOeAXrU1FcmKo9RDHawvOOvChCJ3/N3f6kB7X3ZuOlH
         P0HQ==
X-Gm-Message-State: APjAAAXwyv5PkP0xmBkEEWzwtBDXuIKIAgYO5tgUrcMfNsjUYW/Kjr2B
        Y3hl7dqjY+aviulUa7vGvRI=
X-Google-Smtp-Source: APXvYqy7GWINPpL+mLfBWo+xxQch0gVFtmkAoiXNu8Ku9bvNoK3FgZB4gENuHPP1sezYQV397ze9Bg==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr3477423ljk.99.1561669946647;
        Thu, 27 Jun 2019 14:12:26 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/22] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Fri, 28 Jun 2019 00:10:56 +0300
Message-Id: <20190627211115.21138-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The EMC clock rate rounding technically could fail, hence let's handle
the error cases properly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5e2b133babdd..5e606ae3f238 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
 	struct devfreq *devfreq;
-	unsigned long rate;
 	unsigned int i;
+	long rate;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
+	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	if (rate < 0) {
+		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
+		return rate;
+	}
+
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	tegra->max_freq = rate / KHZ;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
@@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
 
+		if (rate < 0) {
+			dev_err(&pdev->dev,
+				"Failed to round clock rate: %ld\n", rate);
+			err = rate;
+			goto remove_opps;
+		}
+
 		err = dev_pm_opp_add(&pdev->dev, rate, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
-- 
2.22.0


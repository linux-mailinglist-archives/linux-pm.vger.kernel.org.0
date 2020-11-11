Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7374B2AE5C0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgKKBPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732618AbgKKBPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B411C0613D1;
        Tue, 10 Nov 2020 17:15:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so698690wrc.11;
        Tue, 10 Nov 2020 17:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaEGNlagm12rE9D/Wwm7i6p9QUikpwKV1tx7Tt13Q1s=;
        b=FrJAgroaw87i4Fom8Zp2mStkjQuZklEi5B+Wzm5MqgQs7TVYDTSIIBbx8YrnX5gn9n
         W19VdWJ0NghMs3ldUZhf94DBe38JAZUnfdV/pLY8AOQuEwaVhsdF0UuJuYNCjwLEdgLX
         VVEGnqNad6r0IrG6A1QTL+HKoEecxVT2nzEQToOLfEQqAbjVfaslUJVXmaNUzmGhe0Yi
         gJNqGxwCepBRYKLMDSOCI/vnrn4PCJgoWmKxUWaLwFcVaPEElizMhsDJoI9USkQtsA/v
         dV2C5+G4V2FXfZX5+cubMaFSkDDQXMFebzF1s2ykwGJKfIJcZ6kELhT1SfE4K7VPcSdo
         hcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaEGNlagm12rE9D/Wwm7i6p9QUikpwKV1tx7Tt13Q1s=;
        b=sBAkMrLOlaNcpUcSbl7fYCIlS63GC83zzX3YkcyuS8BCLOs8dN5AMLIcIqfC+hfZuw
         qmq1+Rd3Hj26H+k3uHOS5y1M9kO3ScD2XgfweVe/gzlE8cNr1sMop7GuYtC0P6KpGtGe
         8bT3aAYnYUo/sozPLeCS44vOvKJ8jrftpJxBfDVSgzSdsFT4NirnfzVYHSUotnEkUbhy
         pBOJ+uK6PWt42U9au0S8ztm4D8dIED/5VvsvkJIen7/WMaFJWdqjpBDlmmgZS2DWUvnP
         z9djFbP2MFWsqclhOItalMeKb2sCVGdxOyNcuvPId9V0Y8Tfn/IKEXCONyJBat8Z7tfV
         ZLxA==
X-Gm-Message-State: AOAM5315meWRk8hclNLb+efNEGLEmU5aBp3ILyxXl9GyG/SQYX3L637l
        CSJ6iO201JW1grHv4VxGBlA=
X-Google-Smtp-Source: ABdhPJz6ljHmxkfhc3SNdcEVqNIvy7oRVDOWk6rMWdNFVJu/Q0bDA/QujtchGwgSZQUeFOX3HhhX3g==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr25595932wrt.141.1605057313860;
        Tue, 10 Nov 2020 17:15:13 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:13 -0800 (PST)
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
Subject: [PATCH v8 03/26] memory: tegra20-emc: Factor out clk initialization
Date:   Wed, 11 Nov 2020 04:14:33 +0300
Message-Id: <20201111011456.7875-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Factor out clk initialization and make it resource-managed. This makes
easier to follow code and will help to make further changes cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 70 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index bb3f315c9587..d01b556a6d06 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -960,6 +960,49 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	return err;
 }
 
+static void devm_tegra_emc_unset_callback(void *data)
+{
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
+}
+
+static void devm_tegra_emc_unreg_clk_notifier(void *data)
+{
+	struct tegra_emc *emc = data;
+
+	clk_notifier_unregister(emc->clk, &emc->clk_nb);
+}
+
+static int tegra_emc_init_clk(struct tegra_emc *emc)
+{
+	int err;
+
+	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
+
+	err = devm_add_action_or_reset(emc->dev, devm_tegra_emc_unset_callback,
+				       NULL);
+	if (err)
+		return err;
+
+	emc->clk = devm_clk_get(emc->dev, NULL);
+	if (IS_ERR(emc->clk)) {
+		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
+		return PTR_ERR(emc->clk);
+	}
+
+	err = clk_notifier_register(emc->clk, &emc->clk_nb);
+	if (err) {
+		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
+		return err;
+	}
+
+	err = devm_add_action_or_reset(emc->dev,
+				       devm_tegra_emc_unreg_clk_notifier, emc);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -1003,25 +1046,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
-
-	emc->clk = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(emc->clk)) {
-		err = PTR_ERR(emc->clk);
-		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		goto unset_cb;
-	}
-
-	err = clk_notifier_register(emc->clk, &emc->clk_nb);
-	if (err) {
-		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
-			err);
-		goto unset_cb;
-	}
+	err = tegra_emc_init_clk(emc);
+	if (err)
+		return err;
 
 	err = tegra_emc_opp_table_init(emc);
 	if (err)
-		goto unreg_notifier;
+		return err;
 
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_rate_requests_init(emc);
@@ -1036,13 +1067,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	try_module_get(THIS_MODULE);
 
 	return 0;
-
-unreg_notifier:
-	clk_notifier_unregister(emc->clk, &emc->clk_nb);
-unset_cb:
-	tegra20_clk_set_emc_round_callback(NULL, NULL);
-
-	return err;
 }
 
 static const struct of_device_id tegra_emc_of_match[] = {
-- 
2.29.2


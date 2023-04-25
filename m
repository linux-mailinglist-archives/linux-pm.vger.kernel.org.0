Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA89B6EE306
	for <lists+linux-pm@lfdr.de>; Tue, 25 Apr 2023 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYNbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Apr 2023 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjDYNbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2023 09:31:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099ECC1E
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:30:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so3635984f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682429457; x=1685021457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDyX15c4y3riamcjrdLMF5pPD4/84jZH8J69KsbOpF0=;
        b=1OUmbyzN0xF/mDJ1gUGkqSjXYr2z+M5aimUYWd9TNVfidYxTNxjh2AtzJkq94h84se
         F1r6So8ybYynTOFUbiBR+B7R7r3yVfjalof12uKPCrxFGRoR8TBkkRBoBsSEfzttgbxE
         DeYWaiRnA/NUUATsH8ng8QjPP1ibPa5zg0at9vGqz9DPLlo1RCJJohmyRS1Dt81VNJmq
         8e5Qt5oMrzwUpORj3g22uN406FLzpVuyzKaFQZ2spHQHh98Uulw/s1bJHlLbsbkDW5Zb
         Rg7WPZmU+sWOeDXSS/APn4biXVeKfFF5ZDyGuqLXWeXx6Ee1Nh0GC58fFKtLsZlIn83r
         s8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429457; x=1685021457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDyX15c4y3riamcjrdLMF5pPD4/84jZH8J69KsbOpF0=;
        b=EmjaO5oi0PtgMxoDNOrmMa2qsFUepou5tRytylwZwxOw0aGXPCXmJmJkqMTb3Bktbi
         01sEjGUXcohq3zNXHDM/fa5KFVgI7/BDptdBLHwa4KkZ5M005Pu9pLhiBaKHAeFPkF5A
         ng0StPXUXk2p7C+xyd5GJcIzqD+GMH1oQXB7sN/2qc1mKFWn7lCXb9nHq5Z0FHkiwKcS
         AtENR7rHyO+rxBTpZAf04YgjCMUB9Ub7YrzSGiR6FKCYyX7Bad2+oClrwkA1ofXWWH53
         XRWBk2yQKaBfB+FGTrFI6iAAaXGn4m+q0w3nj3iTOMKoBnfmG+76xfQNam3mri8QmKWp
         J0Sw==
X-Gm-Message-State: AAQBX9dQQSuSk/t/lpgc5tVIu9WUlArzZRQk/99e/vOfRfuP8PPsdDk4
        IflnHGlbDxiqI80BewTtkOL83w==
X-Google-Smtp-Source: AKy350YyCGlFSEPWOXnlFISBuLHAPdnh04Ht+/tDW8FG9nCjr2WWTpXNTxCyBqmmPnR3q5N39NDk7A==
X-Received: by 2002:a5d:4f8e:0:b0:2fb:2567:bc1 with SMTP id d14-20020a5d4f8e000000b002fb25670bc1mr12267998wru.8.1682429456731;
        Tue, 25 Apr 2023 06:30:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm18575434wmq.38.2023.04.25.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:30:56 -0700 (PDT)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v2 1/5] thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
Date:   Tue, 25 Apr 2023 15:30:48 +0200
Message-Id: <20230425133052.199767-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425133052.199767-1-bchihi@baylibre.com>
References: <20230425133052.199767-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add suspend and resume support to LVTS driver.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884b..5ea8a9d569ea6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1169,6 +1169,38 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int lvts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct lvts_domain *lvts_td;
+	int i;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+
+	clk_disable_unprepare(lvts_td->clk);
+
+	return 0;
+}
+
+static int lvts_resume(struct platform_device *pdev)
+{
+	struct lvts_domain *lvts_td;
+	int i, ret;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	ret = clk_prepare_enable(lvts_td->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
+
+	return 0;
+}
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1268,6 +1300,8 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
 static struct platform_driver lvts_driver = {
 	.probe = lvts_probe,
 	.remove = lvts_remove,
+	.suspend = lvts_suspend,
+	.resume = lvts_resume,
 	.driver = {
 		.name = "mtk-lvts-thermal",
 		.of_match_table = lvts_of_match,
-- 
2.34.1


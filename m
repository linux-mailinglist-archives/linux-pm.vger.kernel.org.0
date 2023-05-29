Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EA714D20
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjE2Pfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjE2Pfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 11:35:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171C3C4
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 08:35:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso2098474f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685374537; x=1687966537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ1Pw000YHwunl4UOYUIH6XIIpBvLCqm0y/k6ZseuYk=;
        b=4mZai65JwnIG31lGL2FdgRbna5ZX+1vQfraelVx+zO93D0FR0QuDbiNo8FaYCM2xYJ
         SOnD9umdATXRVthXkkARqZIMPkDTQy23NIHNmbGkqswDme5R2INWw/exCro7K8Q3odVt
         O/qbxxy3w9JYMmbv7BJUfS1o1B4GzJZjRi4Eh7pRT+xpItAMYaqURjelrCQvlpwDs2c+
         l9Yg2bfb0aOxWERFNunADa2qvLxt/4fPWMpqf2K4i5L+tWFhVM++jki+iXq55Z37IRZA
         KAv6NStIoaqaxTMRch67UfZBCoxRLLhUpwGY3w3PUBSENfUMiHfasMUFzFs9PRGbjeZU
         CjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374537; x=1687966537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ1Pw000YHwunl4UOYUIH6XIIpBvLCqm0y/k6ZseuYk=;
        b=evi75l4U3EYS8reDmRfoRfDpqTl8z90ARYW5iftPr6wzwOvKxpt8XoD5FGIM1I5QCI
         4y1SBKGa6oaYNyJFdAaLXulrp+oLz33mpBU3OselpRmUp0h5OGMXvk3/RrGxVN3Ol2na
         xnh8kaVHa/D/bHKGG37cUJ+KYuHZ5wqXUa4KH2rYyMRVuPji4Kn0t+9MFjD/NBJNNY74
         ig8MCR1H44B8o4Pd/qOpmNCIFNWyLSOkUr7/hHkv2akuISQT87rQDXMypmjHoDASX8Bn
         Vd4SyWB4vvI6aqRXw6vse0RaITMhuxN/hCY7KStHWh6HKSfuUYx1+WYtCJEr831zGmh8
         tcRQ==
X-Gm-Message-State: AC+VfDz9MgqF9JGTQ5KfAbKFoaM12P3q1Htq8mRrwxrgKzYKKDO4F/2d
        mcw3SEDzPsZFX6YrzJoi/rwVTg==
X-Google-Smtp-Source: ACHHUZ6G0aBAtC/cPLbBBLlra6lcIfNV54GneoMynv4vOLmsZoj4L7CcHXrSU5ONQmISmgw+w6krYQ==
X-Received: by 2002:a5d:67c5:0:b0:30a:e3da:efe5 with SMTP id n5-20020a5d67c5000000b0030ae3daefe5mr8296777wrw.32.1685374537501;
        Mon, 29 May 2023 08:35:37 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm269781wra.97.2023.05.29.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:35:36 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzystof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
Date:   Mon, 29 May 2023 17:35:29 +0200
Message-ID: <20230529153532.3541327-3-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529153532.3541327-1-bero@baylibre.com>
References: <20230529153532.3541327-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
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
2.41.0.rc2


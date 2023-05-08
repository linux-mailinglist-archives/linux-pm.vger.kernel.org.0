Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAA6FB4A0
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjEHQFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjEHQEx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:04:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3159FC
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:04:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso1707564e87.3
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683561890; x=1686153890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8of//y9tmokmOnW15e6yt8zqMt9fsDSSEcIh47rbdE=;
        b=eTLjQN7KPiurBrzl05+P3S387ZXWCaGKIioWBTS6+95lvzq2wJ5/C8aRF8k6nCI9Le
         0t26xqBGys0EuOY56Zl1uaWr8M3HzcD60E14GY7MY1mkDBiEkulysBA8bPMJr1/7Ai/b
         CHm+uVPJF8fJIiD8yvg9J22vcHp8qf2xQO5Evc/FgHMZ+vCXRWAlVPPEF+ByFBTfntNC
         JJmmA3I/FEaGnA8UWlm5ez82T7RdcnOkEEBw9t5KK85K8ZDPgKDkhSE6ePOoPappEpvG
         0b6jWL9GVcDIK2hdH/iiiNIUqZ9RrRWGxsm+CXcFahKKWeHfQg5Dgk2k0KbXfj4S8Ojg
         50tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561890; x=1686153890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8of//y9tmokmOnW15e6yt8zqMt9fsDSSEcIh47rbdE=;
        b=XKx+Mgpgmp7B+7gxGhEQGNVrqswQ9LlBYa3rjeU1PeIrSpC5O0BpG2AJmK7nu56/ce
         KGzRnPYs2oJtEqqvjQuQhYWmQImeyweavCosD69BPEuVM0takM0GGOpAAK05HMzPhHWM
         38nS21QDOfD9WHTfCXJwR0NtC9ZKG4HYBcu/QLct7D4UNTBRLo2o9S43nth9t7PwXyML
         /rOcDT43OqZNUuG490Vtsw3EvcBfIvO9q6C2vnr1exM7+DG96OnZFA/5UNzXxn3TVlId
         j03aJtkSzPQyl39IaWL4YMZ22OaGCT4uvqDKXn0+XJH/UvqIxRG+B4XLUFoevy8idjt3
         +p5A==
X-Gm-Message-State: AC+VfDycpDsQUt451JRD5ktOwhfYNCGA8HBBLNqN5fSZD44re/qV1jCG
        mMYIZnL1V9bXKtHu2Ut3tTw7zg==
X-Google-Smtp-Source: ACHHUZ5hNIcKRvQOvkbwN59i3v7bngFSbc/m8iqKcD4PdTMefxF9Zc3coCf8oPDk4eLZgVerE8FGUg==
X-Received: by 2002:a05:6512:79:b0:4ef:f5fe:bc76 with SMTP id i25-20020a056512007900b004eff5febc76mr2686233lfo.14.1683561890425;
        Mon, 08 May 2023 09:04:50 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004eff4ea8dd3sm32372lfp.76.2023.05.08.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:04:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/6] power: reset: qcom-pon: add support for pm8941-pon
Date:   Mon,  8 May 2023 19:04:42 +0300
Message-Id: <20230508160446.2374438-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For PM8941 we don't have a defined field to store the reset reason.
Support wrapping pwrkey and resin, but without writing the reset
reason.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/power/reset/qcom-pon.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 16bc01738be9..d42475bc0ee6 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -17,6 +17,8 @@
 #define GEN1_REASON_SHIFT		2
 #define GEN2_REASON_SHIFT		1
 
+#define NO_REASON_SHIFT			0
+
 struct pm8916_pon {
 	struct device *dev;
 	struct regmap *regmap;
@@ -45,6 +47,7 @@ static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
 static int pm8916_pon_probe(struct platform_device *pdev)
 {
 	struct pm8916_pon *pon;
+	long reason_shift;
 	int error;
 
 	pon = devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
@@ -64,13 +67,17 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	pon->reboot_mode.dev = &pdev->dev;
-	pon->reason_shift = (long)of_device_get_match_data(&pdev->dev);
-	pon->reboot_mode.write = pm8916_reboot_mode_write;
-	error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
-	if (error) {
-		dev_err(&pdev->dev, "can't register reboot mode\n");
-		return error;
+	reason_shift = (long)of_device_get_match_data(&pdev->dev);
+
+	if (reason_shift != NO_REASON_SHIFT) {
+		pon->reboot_mode.dev = &pdev->dev;
+		pon->reason_shift = reason_shift;
+		pon->reboot_mode.write = pm8916_reboot_mode_write;
+		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
+		if (error) {
+			dev_err(&pdev->dev, "can't register reboot mode\n");
+			return error;
+		}
 	}
 
 	platform_set_drvdata(pdev, pon);
@@ -80,6 +87,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 
 static const struct of_device_id pm8916_pon_id_table[] = {
 	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
+	{ .compatible = "qcom,pm8941-pon", .data = (void *)NO_REASON_SHIFT },
 	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
 	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
 	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
-- 
2.39.2


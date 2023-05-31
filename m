Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE177717346
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 03:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjEaBm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 21:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjEaBmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 21:42:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A311D
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso541851e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685497372; x=1688089372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVVVClRGQ3W+a4D62JgYgRZeO7k7GdsG/nIGFO07NhE=;
        b=vOiOxUgpdUx4sO3r01yIUuAfFsasVWnW6N6FiQslNJpkAzZn2R1A6lD9HRtqR+JBLW
         3zYHVJIhSHROmwc9tI9JVKkcDRHyyaJgkqhKZ0VZiekQvjsxcrX8ghiK7Nmxhqie8HOz
         jnTAuTGW9XnuxWmy+Jni8p2YPAvYK7wKrIXJTzrAh/jgmV6/Qmz0nqGrVbIn19PPzYpn
         NoQcPZ5juDx53GiFfwD9VFG43SORhakvVb1aNClcH9T+ZJeFnl87Iux0dTPY8w5NaocD
         ZuiXO1FcM9IPu8CANRoP/f/Cs2s9IJyZtqmXXvC3dWFpPRxzck6fwE61o79dIsz8x2qp
         p05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685497372; x=1688089372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVVVClRGQ3W+a4D62JgYgRZeO7k7GdsG/nIGFO07NhE=;
        b=eEgfzQogMJy2hc8vNZx7G44SuWDil+2mLjR2XnJUSkX/NJPf/WwRKFiWFSNXB0NL/I
         oJ8q11b7DfPdpSKSefsy8V/luLOI3K3xiEIJ6xGrE3nropRYQAgtm8i/i7TH9I6ie8/n
         sbkV6z+EcWIYlW0GpfLKpuGTvyvOS9XNWyzMLsvcH+LA8AOO8328chP23jcQtY17VI4O
         89EbimYATaYS9pOw5+NZGqOS3TgE/OttwBkcTXb6DQNGgiNJbrCcoWJb99fteg8GE34J
         ukJSmoTTZVcqliM5Cgwkmb8tvOP7LYlhIFC2mhn+P442FFPjB2dUApMXc2ePEHHMq4R2
         j6Ow==
X-Gm-Message-State: AC+VfDyujrncTQesWl/9ByqBT5l7f20bruyxMLiv8VlFeoy54nXhl/iO
        VuZP4fLX8x37MkpFgC7C+g96PQ==
X-Google-Smtp-Source: ACHHUZ5xKHZHlSFAIUgV9MRQhU+bzS3GEljBXd1Ge5xA/wxIe7ClbRxK19Qjn5/oMZx7aDGwjkLbyg==
X-Received: by 2002:ac2:5296:0:b0:4ed:d5ce:7dea with SMTP id q22-20020ac25296000000b004edd5ce7deamr1294562lfm.27.1685497371885;
        Tue, 30 May 2023 18:42:51 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id q20-20020ac25294000000b004f3945751b2sm515994lfm.43.2023.05.30.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:42:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/4] power: reset: qcom-pon: add support for pm8941-pon
Date:   Wed, 31 May 2023 04:42:46 +0300
Message-Id: <20230531014248.3824043-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
References: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For PM8941 we don't have a defined field to store the reset reason.
Support wrapping pwrkey and resin, but without writing the reset
reason.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/power/reset/qcom-pon.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index ebdcfb28c4a0..1344b361a475 100644
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


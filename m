Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1E6728DD2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjFIC0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 22:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjFIC0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 22:26:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CB30F9
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 19:25:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so13027731fa.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686277556; x=1688869556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVVVClRGQ3W+a4D62JgYgRZeO7k7GdsG/nIGFO07NhE=;
        b=xhBPcRUkznKGI8r3ED9YzjcP+y04kjYXrbivO5gwy4sIY24nWyPFank2HZbZBdWb8s
         84/QAL3QxZgECeHEoUQ1KEoldTHwWeeBRYJO9spoIaKPySpiLaWq+uI9tVIWDyf0fZsI
         hbIruYiDlCiI4YvvBpFxS4abBk4jNJ5xDOLKS9JUoDGUxDo6WO+WaOlI9bF+9cOYZiFz
         wgAHuOtKNSImbXyBuILjuXuu8Lx+p60HE9fhw0FXDCc3sTxIbmmyaXh8rQuGv0o+sCRK
         78sEAgxZVgkfSbqYl73DmHu4yMZ3JW9lIc0uqayT2EllvBXl9iaC/bjzkU2k/YBZPPQp
         MkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277556; x=1688869556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVVVClRGQ3W+a4D62JgYgRZeO7k7GdsG/nIGFO07NhE=;
        b=InduRmlh/2g0pjnveQ69um4lxlbVx6NeiSKgbS8Wt+CDjoFY15dz/b2xQSXO3K2irt
         lpR68VMLX+4n4xyl5k0fLJup4GkeJsGL60P89G4bkZl2k8ZfT7st/Cl2FZJdufq5WdLw
         9VvvrZXa/0B+Xv95GEATjEbVkLJ9cR6pwCOP/SZuiszUAT++qxL+VqsjI4XOQkerIjlV
         HMfNgm7S40LgEZRGIDC1I0mZl9CcSmomkFDTLxmUF1oIgA0TItVR14lYXFn8kh2TlFpa
         kEEetokUOi2opdvE3hq6LDZvQARNtUWi3dgl9NQmhCV5kxbNWMTz+IPou/GfSxAThtMR
         Qb7A==
X-Gm-Message-State: AC+VfDzjldte5QjCTCecaFSeB7S2U2eIRGuXktqFMQZ/vXauv+VRMl1u
        wpgw/D1oX9bmLbbr0ewjdu54Rw==
X-Google-Smtp-Source: ACHHUZ4dYPSYnbv1DroYWYIlkuvy4q/dGxMKVISUXy9G1lUnZR352dzZvsXgcDt+PHKSZxk0YiFqLQ==
X-Received: by 2002:a2e:3515:0:b0:2ad:ad0b:d0fb with SMTP id z21-20020a2e3515000000b002adad0bd0fbmr161896ljz.30.1686277556311;
        Thu, 08 Jun 2023 19:25:56 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9dd4000000b002b21089f747sm167429ljj.89.2023.06.08.19.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:25:55 -0700 (PDT)
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
Subject: [PATCH v4 2/4] power: reset: qcom-pon: add support for pm8941-pon
Date:   Fri,  9 Jun 2023 05:25:51 +0300
Message-Id: <20230609022553.1775844-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
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


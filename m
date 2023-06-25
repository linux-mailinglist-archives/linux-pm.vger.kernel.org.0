Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE973D40D
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjFYU00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFYU0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23ECE7E
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so3403352e87.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724770; x=1690316770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v2jo2vlueDBgLi7osAEGDY72QrtYiWub+RBKr9UBf8=;
        b=yQcX4aUlMdAYIhov2f1U4yo07kKzuLanngLfnfT3zKJqJygQtE/rGulBH792tQKX5K
         GqE7/lXZL8veLtLOvIMVVVXQgPcmORbD6QAyeNWPTTXJh3bjSHoRpfAKVOrsyKvmRGTT
         WZkkdj98l2lyXl+DcWRoNRtlNdCwILgpKVWuKfbFAmxW4ZWHKJR/vMzmVw2DuA4L/eaG
         RgLCdmq84C+kNOQ9OhgnfMnTULyQogRD2D+CnVqZv6aPCKeUezlxRgvM45Txavk8b5WP
         wQTQ3l7dQ5cYWt9BBc6zDWrNGc8Y89vdKw9Q3CAn7NdODwhKkTzHaxNNt3Wy69Iy3l5V
         I+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724770; x=1690316770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v2jo2vlueDBgLi7osAEGDY72QrtYiWub+RBKr9UBf8=;
        b=fx9K7SaJPglBQ1iqgEDgUK5IldKnYmwIcZaNekjoIhkixr1ul6YdiAuQgEi12WWgVL
         nGPRZzaCTAapq9M8prqVZjmIRE+Vm7SL5DpPiyseRw4IM33GN7pl/Js8zoJm9aDqKA5G
         R/hp5HvzNMuE3v7HI9t44UUgeHGSGgWaZmvU7Eg5lPUXzYVJjJ8m+2y6CS3gNoTEnc0s
         1kAxgY5weO8DCfsHP2v5trCOh/wpILvu6A4/EwDVloxc5MVrJJ4g2gDzpJZVx4cCU/d5
         9qhOxEPNrZayf6z6NTjwDq+PWGzmHydXSYuttonLWdMJUK7n1S4bXGO9MjrDJFJn+EE8
         3U9g==
X-Gm-Message-State: AC+VfDwKTRJsV+ptWFL4JOO42CUaW3lhnyr3BFhLMPbmy2J35WnO9VJ2
        +NGqEdfVtFSUO817RJxQdwGI8Q==
X-Google-Smtp-Source: ACHHUZ7Wi/Att+CmRFxYOL5PfnwptwpMbcCY/RzO7cIWFEo0ICIIYpHET4zGxNWYItrkXEhYdW4lmw==
X-Received: by 2002:a05:6512:3f9:b0:4fa:5fbc:bdc8 with SMTP id n25-20020a05651203f900b004fa5fbcbdc8mr1496744lfq.5.1687724769833;
        Sun, 25 Jun 2023 13:26:09 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 23/26] ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
Date:   Sun, 25 Jun 2023 23:25:44 +0300
Message-Id: <20230625202547.174647-24-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator node show be added
instead.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
index 8f178bc87e1d..6a2ff30a2f3c 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
@@ -652,7 +652,6 @@ saw3: power-controller@f90b9000 {
 		saw_l2: power-controller@f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
-			regulator;
 		};
 
 		acc0: power-manager@f9088000 {
-- 
2.39.2


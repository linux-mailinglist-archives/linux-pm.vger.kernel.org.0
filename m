Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF8744F10
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGBRnc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGBRnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC46E59
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6a675743dso55955041fa.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319782; x=1690911782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVBy+fu/oMsx5XODIGCyweQZPFV4UABvq1rgp87MeiY=;
        b=RX+rH5G1WUZGaR//tuDlRX+FJFXbMh3m6Ujuj4l8tGX8/3smocSEdl8ht0CbEneNaT
         A0bLIuEO3/TjdOJrCeQeMnCJtN0udUECQJ+mZYQ3TpkmnVgi4c0s3k78oYGnUrjp3fn8
         Z2kYIUfzlG74abgGLWZAiyTAfdSR+QBE4tsBs/Y9g/NB44xiETCZILFsG0uJfUWj7btC
         TNagVopqCeWUhdloVhAWF2YoG//fPLKCOJYYD5ybQ4VFovSkBiHCtr1R3JYGX2SEqSMU
         0qaMNus/col76aMdtjg/7E3ANbbysC/uTHRcoemkH/O9A43AbWDWOZ1YNt0idCTRfLyt
         rgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319782; x=1690911782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVBy+fu/oMsx5XODIGCyweQZPFV4UABvq1rgp87MeiY=;
        b=PXKXV9ZX8LsdAqQbRJ3hSOfHJshivn/ggWfm35yk59vnHXqJaClcOuTce4BHNrt3iv
         68dbNB3Vzah+xfh+zcafRxu6aChvanbStKS6KyO/EJZwUnPlMjtNOkHY8PJqMc27AynR
         5EWwWUW0JHaIRctgpqUa8NloSAhnw2sQgJhDcnAEW0a3VLYVBk+CsgcHuCpcu+fydyLn
         uWZLoTw51OrD7RA15H767GGT5YYYEpr8BHIxb1umV3fMHsqK3fEm7nJPKF3Vzsoi4IgS
         mqVug9sFUCcPPGFd8QlHMCJVC70PEy/Ma3eaaQk4AsgQpX7kW+1XxMKsiSy1lHZhRx6T
         U35A==
X-Gm-Message-State: ABy/qLZ5xX29VTPgAIqu5gjTwPvfhLkGNsMX27gVGO5idA2dWq5ZPzqf
        cMjsquHkw7r/QzHFhiGQikS/0g==
X-Google-Smtp-Source: APBJJlFtVful/ALsf6VAFSukSaZBm0XeTZWD+E1XAmbrhkfCvDwrVQvb0aLBlqSvslgg/gfnMcbgRw==
X-Received: by 2002:a05:651c:1055:b0:2b6:db9b:aadc with SMTP id x21-20020a05651c105500b002b6db9baadcmr2544246ljm.32.1688319782635;
        Sun, 02 Jul 2023 10:43:02 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:02 -0700 (PDT)
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
Subject: [PATCH v3 16/28] ARM: dts: qcom: apq8064-ifc6410: constraint cpufreq regulators
Date:   Sun,  2 Jul 2023 20:42:34 +0300
Message-Id: <20230702174246.121656-17-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 39c44fae9d14..ddb092710275 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -217,8 +217,8 @@ pm8921_s1: s1 {
 		};
 
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1400000>;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
@@ -264,6 +264,12 @@ pm8921_l23: l23 {
 			bias-pull-down;
 		};
 
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
 		pm8921_lvs1: lvs1 {
 			bias-pull-down;
 		};
@@ -272,6 +278,14 @@ pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 
+		/* HFPLL regulator */
+		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
 		pm8921_hdmi_switch: hdmi-switch {
 			bias-pull-down;
 		};
-- 
2.39.2


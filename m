Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F6789DB4
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjH0LvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjH0Luz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB98CC3
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff882397ecso3492614e87.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137045; x=1693741845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJKq5xqa+IkQt1yiAXdQVIWb4sugXk36NSJJNWDebJk=;
        b=A0EuRbs7w/GtYN7EPG/qGlkn7jtItAW+oh70XoHfcCvMTiW9LG0/GoJyMKM6ZAupuN
         3yhR1kFQaT2qDNzObuUqgK8R+Scnvw6nA/nPC+bYGRTTXQV0ITnt3WxaWqYU3AIa7N5Z
         FqWILKhXCpKxLaYU9Q8dtDS/SwU2EoouoePf0zCJ7YKIN3MGO6fmQ15unr3hAYx8Q96X
         VvGBX2uMPN6TgA1u7Ne3zTf4HBAgBMJ8g/BngME292jPqG3Mctq61MDDHNGT3NWTBR6X
         EGEBQdtj2THKTe1gue+9ByQn4YWcO2uBYutCgN4IMIGZRAJu4gapeuGmo5iKNsgvyqTi
         e9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137045; x=1693741845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJKq5xqa+IkQt1yiAXdQVIWb4sugXk36NSJJNWDebJk=;
        b=bY7gpMrCBemYsOpxlipk5c86eTxm9R3c0UQJp46x6DhJEuKtyQ8lDuLRA4ZKdxTTeq
         K1lQnQ5py/dmROVBsLEv3az/wx3YbkPXDCTXmPd37zMP2nDyC2IGpGQhT69Os1//UErp
         pHZ3JuAcc37kG6rbxWhRh1gFzrhpEf6m6pvhOyOxeBYYUyUjRYFsabCH7YvyQX9Zpu1i
         tmxH5FVxRuM8m4nlTgz5sd/Ak6gEqAavttzg1XG8O/uWXIAad5raBKmP3LUFQowZA/T1
         oREh/CFYMa7+2YZH/8NepNPpufjrvGYtosWgtaKAUO+TSHvaYxntn2Je7IjjyZUpx/p3
         8G9g==
X-Gm-Message-State: AOJu0YyczWsXlHBGNvZjss+Ug6KWI63u2JZ0JVB33o1bEAJBvqFscN46
        cbTkVxqTt/6co9ppJ7ApMrqVQQ==
X-Google-Smtp-Source: AGHT+IH4vwUEa9C4O3F5XVX0DJ4Bmcnok2/i5QVe/7kjqRQk9U1QsVR59T4Dyn6xMcYMfwEuFRfyuA==
X-Received: by 2002:a05:6512:32cc:b0:4fb:90c6:c31a with SMTP id f12-20020a05651232cc00b004fb90c6c31amr20255459lfg.14.1693137045037;
        Sun, 27 Aug 2023 04:50:45 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:44 -0700 (PDT)
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
Subject: [PATCH v4 12/23] ARM: dts: qcom: apq8064-sony-xperia-lagan-yuga: constraint cpufreq regulators
Date:   Sun, 27 Aug 2023 14:50:22 +0300
Message-Id: <20230827115033.935089-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 2412aa3e3e8d..5b911e5f0b55 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -139,7 +139,7 @@ pm8921_s2: s2 {
 		};
 
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <950000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 			bias-pull-down;
@@ -290,7 +290,7 @@ pm8921_l23: l23 {
 		};
 
 		pm8921_l24: l24 {
-			regulator-min-microvolt = <750000>;
+			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1150000>;
 			bias-pull-down;
 		};
@@ -344,7 +344,11 @@ pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 
+		/* HFPLL regulator */
 		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 			bias-pull-down;
 		};
 
-- 
2.39.2


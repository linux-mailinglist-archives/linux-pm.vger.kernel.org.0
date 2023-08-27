Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F64789DA7
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjH0LvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjH0Lux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754D1B9
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso3197889e87.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137043; x=1693741843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KDBrUFxvk4wsTAEzsTm5KMoDepnn6zKvijV8dmMWVs=;
        b=eJa3SO1MWfrCt2LNj05Qv9mIV6/g1KqTjVMc9StVLX+7K2UsfVYbvYYPdhjSEC9SEP
         alDsRDcjK5GAyOf82KiDDT3+eihTCIEQ12wuRf9hxmYtt8ZWrmUyow2BOfyabtieURyS
         +RBcJF+e+dSWGy6Nyk5/p/rAxvADSvJy1d5G33FFU2PMdNEEq5lccF64BdKWnrd/xEdf
         Fqz4Wp3g/e2syVC8KfOOLe4tis/g9kYohGasBlah+0RS6aoSSgmIOgbRzpJUc1PcR0ZR
         8wyawiHd17tJDZZsB5iH30HuhiE/F177dmCfRv3wsa6uln3wTqRcfH0+zYx0CwjOvWT4
         hCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137043; x=1693741843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KDBrUFxvk4wsTAEzsTm5KMoDepnn6zKvijV8dmMWVs=;
        b=En1UFWXcrQWm3xNyxgJVApGRxBF6F79uV67ibOwgfkHW/gwuU1Y0vsVnFzXug32XK/
         h2XRDeJBrsFYy8v9OdmIKl2I4+Q5/1o6Tf4jATl6V7NOixcuncPgWY6qECvMwV6OCrmP
         JW3VKTF5EasNKsKhoVz9VcZQsyDDQoTrModaN7vAZ9xGmbwUt6GiftCNecQB6yR8x8Ft
         6WrNOs4+Go4EioV+5s2/0eNU4BwlkaLSIpbABSpFsCSUmfcp6grVblEuehAZU8WvgpnY
         9tBd/zg/H3V0H0l8tiRrezT2laIxSgaKMYXkOfbsp7He5xkPgVCF9G4uO6QpEghpHFb6
         Qz9w==
X-Gm-Message-State: AOJu0Yy7so/PduhmYvBbB7YhxhTJVFwY8BivJznZYZ3PRuGxOC8lK+k/
        CDJ3FWb/ipItIKupte13XXUAKQ==
X-Google-Smtp-Source: AGHT+IGxUZBkVrWP6BMePbUZBlujSEAikUvWhsWK+Cf0yxICxoD31Wz1dbr7xzSwVZ0JIHiwR31lcw==
X-Received: by 2002:a05:6512:3150:b0:500:9734:545a with SMTP id s16-20020a056512315000b005009734545amr7821055lfi.5.1693137043478;
        Sun, 27 Aug 2023 04:50:43 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:43 -0700 (PDT)
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
Subject: [PATCH v4 10/23] ARM: dts: qcom: apq8064-cm-qs600: constraint cpufreq regulators
Date:   Sun, 27 Aug 2023 14:50:20 +0300
Message-Id: <20230827115033.935089-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index 671d58cc2741..ee071aed9b8d 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -116,8 +116,8 @@ pm8921_s1: s1 {
 		};
 
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1400000>;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
@@ -157,9 +157,23 @@ pm8921_l23: l23 {
 			bias-pull-down;
 		};
 
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
 		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
+
+		/* HFPLL regulator */
+		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
 	};
 };
 
-- 
2.39.2


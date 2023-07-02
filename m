Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB436744F0D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGBRnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGBRnE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5096E6C
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso57503511fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319781; x=1690911781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oENXundP7VA1MRBgQvpQRhOTru+bmpAb8Jj6teLABdA=;
        b=um8AHGnAc49w/aoee5Zj053/cQRYmY2CzWL0EM06116yTf1ooLHmqdGZO37hUnJhWL
         NsmsHw6FxCPCkYI9sIWXlsEV4cUfYk8yc9Vr80dVghW+iVUDELYAZhSJjeUJBwc67IEl
         zsmDzU/vldC9/AVBU4hBSXe9vBXNgLfA+5u34LymHZk5wDlDmN/I8/WTCzcEAMiutneA
         uykGT5A7nI+dB08g/xcFCVBwaf3iY+Mvw0Z3kOEFGA9cK2tF8GQAX53TRBR47KBGqU+x
         JZS2cZCUaVw62tEkxoVUs5SFS/g9V2UxiVwg+pQDqsWwvJy6cxyNTc5QfCoAg/mef7aq
         spZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319781; x=1690911781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oENXundP7VA1MRBgQvpQRhOTru+bmpAb8Jj6teLABdA=;
        b=hSvsqJCh+EshxGxPAFcUXWWFs6wplq4M5qOmZOsuDEPcKqR2Wo84nPqfVlgDqPgiKt
         v7O71iSot2Bjk6E+jXUBdsgvYHu1tHKQqTt/Mj9yHB+NiY3Jr7srktk9EnFHdYeQxsqx
         MaYFHBte1RFw0//Jlis3Ev6PmIaqyl0rdEAoa7tgsZiZPyOyqAXyGJN+7EOhlpZyumx6
         x3hYgUSOqZJS87lxyYhfZNITPN/FoHKBvMC9pI8dKV/wuUV7vw6v1SgDikRAvmC6mT9n
         EjwUMiQSt3jJ+lMiUqJ6GJoiDjh59hr9qdzPIuri8pJHa3TdUJ6tp4ioo19g1UB9dMxd
         zEGA==
X-Gm-Message-State: ABy/qLY7VQAfOtXhlfbZrquT9goi7EP15zIpAx3DvsqPCwmbXRpEsG8D
        CPatZ+rn+HqkeILsugOq65odEQ==
X-Google-Smtp-Source: APBJJlGIGizI+sgvR9iOUHE9NZTug7FX/4nSpCfK61lbe7gurYQEjk8zzdYkhAWzMvzk6fkohun3MA==
X-Received: by 2002:a2e:3207:0:b0:2b6:da64:321 with SMTP id y7-20020a2e3207000000b002b6da640321mr2242151ljy.45.1688319780836;
        Sun, 02 Jul 2023 10:43:00 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:00 -0700 (PDT)
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
Subject: [PATCH v3 14/28] ARM: dts: qcom: apq8064-asus-nexus7-flo: constraint cpufreq regulators
Date:   Sun,  2 Jul 2023 20:42:32 +0300
Message-Id: <20230702174246.121656-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index 1caa73e20bc9..1d6fb840dc60 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -213,9 +213,9 @@ pm8921_s1: s1 {
 			bias-pull-down;
 		};
 
-		/* msm otg HSUSB_VDDCX */
+		/* msm otg HSUSB_VDDCX and VDD_DIG */
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <950000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
@@ -299,6 +299,12 @@ pm8921_l23: l23 {
 			bias-pull-down;
 		};
 
+		/* VDD_MEM */
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
 		/*
 		 * tabla2x-slim-CDC_VDDA_A_1P2V
 		 * tabla2x-slim-VDDD_CDC_D
@@ -327,8 +333,12 @@ pm8921_lvs6: lvs6 {
 		/*
 		 * mipi_dsi.1-dsi1_vddio
 		 * pil_riva-pll_vdd
+		 * HFPLL regulator
 		 */
 		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 			bias-pull-down;
 		};
 	};
-- 
2.39.2


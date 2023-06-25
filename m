Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BEC73D401
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjFYU0V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFYU0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CED10C4
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b699284ff4so12188911fa.2
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724767; x=1690316767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77d+d36KDkZJ6tRGLwEY2Ux3Xp+jyLxcEE3RlyjNnBw=;
        b=MJGUwU4csWft8gwY9EJC4GHGrYyX/vKLSqxL3D927k67Pwk3efZvimrtJgIoXQYd8M
         vBtGc6DejbION5Nl/fKaRox3bZ+Hop0MolxyeyerNtTS5aEGwh9VSklf9uvl1QV4exQn
         Q2W3i0EfINlMMMNrUJ5HMtfg+/Zossia5RowRM+Zrl/S/jCmVQIuLgjLmr6Bn4c+yo6Q
         bk0yoOTZtOyfzK8MDnARqlNdZHrO+UJukQbrIRneJ26h2tyY50L2/l4tVNGmV/5cjfc+
         D1lQDtHRMTKh5/X/OB6OBYKxyy5J0hyw1n3LD2PC3Z8IAYaQDj5pUJoBQIdEA7nsjMa6
         It3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724767; x=1690316767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77d+d36KDkZJ6tRGLwEY2Ux3Xp+jyLxcEE3RlyjNnBw=;
        b=INR6n+npiqglkHEdk62MEF5pBIXWmJ79Yv7c0kViK+rr4k5qgyxAD+19hHrLn4fNPU
         Ll445teWqI4TIVkGZXYrXg0IxN3sNqdNq4n05/Ot1ThhQT1+1X71HNi/BQDldm0aUdnJ
         g/vVMbksFhS26iWrGWiVgX74hdGYVp2DT7W8KWHLn97CQr/jEz1XJJ4m2Cx3Idc7kjr0
         ME7xrEzEGYHZgRuo2xTCzGrULocXVXFbpCv2lNOHWN2khtvB4NrlahtF80ceY/duOfpt
         zW6MsuABTScne7HgbL+K1Lgr9g0/jLuSqodMuL5si3qskqABHIHOGpMNVtzxZIcFCkjC
         H7TQ==
X-Gm-Message-State: AC+VfDwJXsrJ+D7O6xgEhgDLC1d3y5EomfYsnZ5nkoH3wh54Q6fWXKzz
        vljTXohTi/5f407+z0d+UtZ87g==
X-Google-Smtp-Source: ACHHUZ6UOX37vIQM2BQ6tIOcTtFsFUySwM68LzB8NeMFXoHNq8Fk5PRtssY25xmAChM3kT5Sdujpfg==
X-Received: by 2002:a2e:740e:0:b0:2b5:86e4:558e with SMTP id p14-20020a2e740e000000b002b586e4558emr8355931ljc.38.1687724767234;
        Sun, 25 Jun 2023 13:26:07 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:06 -0700 (PDT)
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
Subject: [PATCH v2 20/26] ARM: dts: qcom: apq8064-asus-nexus7-flo: constraint cpufreq regulators
Date:   Sun, 25 Jun 2023 23:25:41 +0300
Message-Id: <20230625202547.174647-21-dmitry.baryshkov@linaro.org>
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

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index c57c27cd8a20..9f5d72727356 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -218,9 +218,9 @@ s1 {
 			bias-pull-down;
 		};
 
-		/* msm otg HSUSB_VDDCX */
+		/* msm otg HSUSB_VDDCX and VDD_DIG */
 		s3 {
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <950000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
@@ -301,6 +301,12 @@ l23 {
 			bias-pull-down;
 		};
 
+		/* VDD_MEM */
+		l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
 		/*
 		 * tabla2x-slim-CDC_VDDA_A_1P2V
 		 * tabla2x-slim-VDDD_CDC_D
@@ -329,8 +335,12 @@ lvs6 {
 		/*
 		 * mipi_dsi.1-dsi1_vddio
 		 * pil_riva-pll_vdd
+		 * HFPLL regulator
 		 */
 		lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 			bias-pull-down;
 		};
 	};
-- 
2.39.2


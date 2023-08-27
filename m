Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4334789D8D
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjH0LvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjH0LvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:51:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A96C1BB
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500a398cda5so3716759e87.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137054; x=1693741854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iFr5ykSW5K/n9AH6BnSCA7flwWQ6QIykUQHsbJGtbs=;
        b=ef2gEVG/82XfG0mQrkVAAmk+eVc0NES2QamcfKNnCe/G+DSeRCe5NTwjoITMyTJScN
         L6FfeR4M3K9jC/nwVhPbzg7WVLI9MC8nR4QulC+GhBdfhdIzMT4zfWcMJXl3NpyR9uDf
         jMPsVMQpnVz1zB2cUffBSMQk67RHAVGOVVppiEToaKqM/BAeCuyjLH4atdY6kEecaeyl
         jZGE8lgICQrBeBPRZ/5T6TrN0BjGbehi0t8iaMFi44CfbTPvxzKk1GZDZ8v3ShhhfBIN
         7p6xiwds5Rjd4WnMbjWBQ0OY8HypUPkinAhrr+mmy+02JRf8WvfMGZTlLL4tG6XlqHjq
         EgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137054; x=1693741854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iFr5ykSW5K/n9AH6BnSCA7flwWQ6QIykUQHsbJGtbs=;
        b=XFxxySutFW4ZpM/b/RpSezKARXCg35+jhNRRuCv7+nbNeoC9+l3MEp8F8IL0+pQPRE
         zmhimMv0/Q8SBNARGyflKF025FNX+HPuQafCujE2SlAjQuXP7UES+C4fHbtgT94l9HGP
         Bbw8o2sEjkH/qrB2onECNM2bOXgU/hdugUkCnRhRzxG38MF9ciluSoxpZH7lF83aU1bN
         IfdUMg30vrJGDSRCDYZR6Tt8c4aWv80VrzVkcK+DclsmRRs01nTb3F6nhUbb9JfilfaT
         dzfxUBKV5Lp0Nd6ZYxDkeWtUxfc3LVMCCnsvxoDHqmXZ0S9ertqETLOf2LGdLDTmeA2V
         053A==
X-Gm-Message-State: AOJu0YyElY3cgzc1Yz3Q72U+M78F+Uailt4X12oD9aMKXgmjzPB5rvep
        XR40bgXGiDkc+a7/cFS55JOG+Q==
X-Google-Smtp-Source: AGHT+IFPncuxEc70hypPWOq9OKWCCPeTxvJl6mRRrmle+JQxUrnM6ogihzRMYLvrTliBMvOHP3qLeQ==
X-Received: by 2002:a05:6512:470:b0:500:aec8:cac1 with SMTP id x16-20020a056512047000b00500aec8cac1mr3026380lfd.26.1693137046513;
        Sun, 27 Aug 2023 04:50:46 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:46 -0700 (PDT)
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
Subject: [PATCH v4 14/23] ARM: dts: qcom: apq8064: declare SAW2 regulators
Date:   Sun, 27 Aug 2023 14:50:24 +0300
Message-Id: <20230827115033.935089-15-dmitry.baryshkov@linaro.org>
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

The SAW2 (SPM and AVS Wrapper) among other things is yet another way to
handle CPU-related PMIC regulators. Provide a way to control voltage of
these regulators.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 2f94d26fc792..ba7d5ef8de17 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -368,25 +368,41 @@ acc3: clock-controller@20b8000 {
 		saw0: power-manager@2089000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw0_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw1: power-manager@2099000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw1_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw2: power-manager@20a9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw2_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw3: power-manager@20b9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw3_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		sps_sic_non_secure: sps-sic-non-secure@12100000 {
-- 
2.39.2


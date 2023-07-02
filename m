Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F428744F18
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGBRne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGBRnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAEE6A
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso58222541fa.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319784; x=1690911784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh4EuEIUK+3K7ESuiSNxZvDgHB1SyNbbFuyE3lj3Cyc=;
        b=Mt4Q5nEyplEfo1GCziqSb/i7K9j/633W5HEgyukOwrQ/jXaTi5ltlm2WEm6oamSW01
         sdGX5Y+B5zxsOLhFkg+PxG/sC/haSq8rqfN8Tcs7DhWjSs4eBnl5ijufEVej/Bu9Lrfo
         puwU37PpWaMOdYjr0HQANXHvSrl694NBLgejNaBWtnd6hM2hl2Wf42gJKyAMmi9zEEM3
         oEhPCd8HctqAt94cYdLg3ZLh5SxFn5P+WBVpBM3DaQqP0EqxC6Hkdig3OanA4Hhpe25z
         0h7F1o7CDmV69SsdCR03ausaNYZ5n7vOmoboAP+qpEEllwwTiclwwQvb4VMb8jzOSRPF
         MWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319784; x=1690911784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh4EuEIUK+3K7ESuiSNxZvDgHB1SyNbbFuyE3lj3Cyc=;
        b=WveEM+YTqTC5aBbmG/Hju5StxaoTaNt0xUZyNgsZwLD5NiELp9TEN17J+RQgauP5iU
         rj71O3RluXpznH4PknwLcdP3q1j0tAbR17nIGyA9ge/gjRXbR8dzOueeexPuPDhtCiXP
         bGYuVDFp1yzoI/LTOAqXPB01pTGejJwkUl1gm/TM6CSUo7RXWcTKS4gD46FGJ6yyRG0d
         lAWkIG3iCBc5F88B+xIUIOAF4KlWHKhqiqXH1rxI1c5RKdM2UrlVBxawU4516bzBbgok
         hbaZqAD3dSsR/WpDeisuTYgXh67rKj96qiFP6tK2dUrsoHKYrPAZeIvddfAo6FV/LSPl
         F8/A==
X-Gm-Message-State: ABy/qLZBEUNQuqgDc0XCctDbEalJ572+sF+rAEKOk0L/LzrzhOb4/5xr
        qEZKl9oesww+eZL+wpupec0ESw==
X-Google-Smtp-Source: APBJJlEaifIO01HX4C2bZp/g6HKHe/Pv9mTaf6Q2TPfVcgRJpkmlktX6+8eyyUt02nQyqMASM5Y2Ig==
X-Received: by 2002:a2e:8893:0:b0:2b6:ccd6:3eae with SMTP id k19-20020a2e8893000000b002b6ccd63eaemr4678698lji.17.1688319784521;
        Sun, 02 Jul 2023 10:43:04 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:03 -0700 (PDT)
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
Subject: [PATCH v3 18/28] ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
Date:   Sun,  2 Jul 2023 20:42:36 +0300
Message-Id: <20230702174246.121656-19-dmitry.baryshkov@linaro.org>
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

Per the power-domain.yaml, the power-controller node name is reserved
for power-domain providers. Rename SAW2 nodes to 'power-manager', the
name which is suggested by qcom,spm.yaml

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 36c68ee5be65..5a85359d61e5 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -405,25 +405,25 @@ acc3: clock-controller@20b8000 {
 			#clock-cells = <0>;
 		};
 
-		saw0: power-controller@2089000 {
+		saw0: power-manager@2089000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw1: power-controller@2099000 {
+		saw1: power-manager@2099000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw2: power-controller@20a9000 {
+		saw2: power-manager@20a9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw3: power-controller@20b9000 {
+		saw3: power-manager@20b9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
-- 
2.39.2


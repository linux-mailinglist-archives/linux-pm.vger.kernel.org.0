Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB54744F20
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGBRnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGBRnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CBE62
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso57716391fa.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319785; x=1690911785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spy/Rz/cAzxXKn/s1kOsEtZbTl790jBubt05JLTnLbc=;
        b=xKVARl3+UEavVSKgEWAuZsemmhzlBXiFkYs+0+a2XvrnOYn+6kKi3bSiCv5xIQw1tH
         4Rde/UGHJm+jLcm3GeOjdUs+4MGDzdDhAT7ftX17teNQ9upYzmBFMgaUq42DAPMgFd6H
         uyms78+EI6eoPcCzjmRyIII9hr/uvxaqwNPJDpIZ2FrRxJzL6kOIEQ/30Gs1J/dPVse8
         Woa/SGMa2A+7MFpeEaulOkFYgkdrm5TrJiKmLsEWZwXipJqZC192llmi6jTsje8z/kwm
         gaIeEPTEBbn2BLwWoviRnJA7Dj5PD0gbg0adsKj9mwqeJBQMjnCPWx+6cwiTAECEOpN1
         UjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319785; x=1690911785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spy/Rz/cAzxXKn/s1kOsEtZbTl790jBubt05JLTnLbc=;
        b=OGS5Nt/sDT01nPhvLFGeJ1B1wOwovkUwJE/oUPVp6JqiDG+CQVmDnuauaxPlKkCl4G
         nJVd6pYG2Bc+sqO/iSvgwGxuZLBGC3vF5ejeLo8de0EUwG35dib2zjRUDfG9WVJ8K+8p
         B4dKOEqBlUafhea253aZeRYQ6CVimyoBsS2XJNILkgdtHPluW6uCsQxVMbDFd35I41ys
         qJ0x5BifzlOWIuw9X7IcBPpdduyMjQT7O2l5V9PJLJG2GkYYtB+qIX4HAmdlfhD3Y5sq
         ji+1cH/ox1MeXk93SjGSRKkCuvxXS+b42j/esMdT00Pcf4m5v6F+s0aUeHTWpoKQsTWm
         gdgA==
X-Gm-Message-State: ABy/qLbmbu8gs4sYKeP61yuSd2xRHbWRbswNGhOw82L3vBmAnR7JZ0Ga
        Yi5jH2zX70ENNouOkwxywPfztg==
X-Google-Smtp-Source: APBJJlG6YkIBJol9D4H5EYF2JEsDZOPDID8nIXGAv1Q5LpjlHVZZ9535mZzz5sKuyxPv/7oF6o4Yig==
X-Received: by 2002:a2e:8757:0:b0:2b6:cd71:6235 with SMTP id q23-20020a2e8757000000b002b6cd716235mr5413316ljj.42.1688319785438;
        Sun, 02 Jul 2023 10:43:05 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:04 -0700 (PDT)
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
Subject: [PATCH v3 19/28] ARM: dts: qcom: apq8064: declare SAW2 regulators
Date:   Sun,  2 Jul 2023 20:42:37 +0300
Message-Id: <20230702174246.121656-20-dmitry.baryshkov@linaro.org>
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

The SAW2 (SPM and AVS Wrapper) among other things is yet another way to
handle CPU-related PMIC regulators. Provide a way to control voltage of
these regulators.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 5a85359d61e5..ab4b8f8270bb 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -408,25 +408,41 @@ acc3: clock-controller@20b8000 {
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


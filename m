Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CA744F5E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGBRu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGBRu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:50:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F046E60
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:50:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba03becc6so3938185e87.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688320251; x=1690912251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VyppmCQXuilTGQB3wrm3Kg/cbYa6gmWtfZYYvtVywc=;
        b=V1E4BiAmo7N+qyuIKVoWjsG358Dsm/OIAjLN7B09/d1HL1Kp+WJSBOZpmf2kM3KFZ5
         BtWCaOHUGoDBxLjlYDir0y0YFIdWkQYIXhyq2r223soRALd81uXoMXrglxLX8TQ2ov2+
         dZujqUXY/P1xBifq1t2OdMHhCHQEJPvyz9Sxuxix4fNfFmFmabNc1Pn/tJHzoBxlf6Wx
         qZkeM99AQdlql1cadRlGKli2rocbTZ0zKDuZB5ZHIR5VIy1/x/TCEqoRklcec6fgV7Ju
         ++7MyD1juBxu3ib01TYA5dzMUK16UN22fPMddjNsBB02wG8xp7q/bZEMOxumJMRCXN2u
         a4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320251; x=1690912251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VyppmCQXuilTGQB3wrm3Kg/cbYa6gmWtfZYYvtVywc=;
        b=KRH+DHl1swh0oyjAlQoypzi8QyoPHfGZ9fcxUX+XbKZKsCIZUUfDeoh50ne+ybZ64w
         Xo5MPxnFkhHWvv6abP5xbwZFVWou/iTh0VX7fpSKcu1rlO0IcripNihfe6ZDjVbQbPtW
         m3ivSenthOOz6Sj29S0kSjgZx7IMoxlI92nm7ptwIPV6XBSzVuKQrledhEG0SjCwl604
         m64JuEJBlu0qjc6lD0VT+iBPU8CaXf4LI5dvlHDK64DabEIOI5WMCXfPYWtF774WVCSB
         p8fn0FISv6XWBvuk8Nw7TLbxsYzDN1cEmwhMQD27U5K4JZEHmbO4t3jtK9efv+IoxUp+
         IFDg==
X-Gm-Message-State: AC+VfDwmqIRYxl04jf4Fu6aDrJzpyWmIX3/RlD/snJpzN15+a/ju9RaC
        6ySQcMi9Jys6Ff3K4b4UAhfk2A==
X-Google-Smtp-Source: ACHHUZ6iZUtgUFX6GHfndWo1pEqoTsBwjADAu+kP0CnIpbdZiLritZ34nsvckKEtzg9tdbYRiCZJ7A==
X-Received: by 2002:a05:6512:3f24:b0:4eb:46c2:e771 with SMTP id y36-20020a0565123f2400b004eb46c2e771mr4046175lfa.14.1688320251213;
        Sun, 02 Jul 2023 10:50:51 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004fb759964a9sm3354130lfl.168.2023.07.02.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:50:50 -0700 (PDT)
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
Subject: [RFC PATCH 6/8] ARM: dts: qcom: msm8960: add Krait clock controller
Date:   Sun,  2 Jul 2023 20:50:43 +0300
Message-Id: <20230702175045.122041-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
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

Add device node for the clock controller for the CPU cores and L2
clocks. It will be further used by the L2 and by the CPUfreq nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index ba82b6ab899e..65065276c885 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -81,6 +81,24 @@ sleep_clk: sleep_clk {
 		};
 	};
 
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		clocks = <&gcc PLL9>, /* hfpll0 */
+			 <&gcc PLL10>, /* hfpll1 */
+			 <&gcc PLL12>, /* hfpll_l2 */
+			 <&acc0>,
+			 <&acc1>,
+			 <&l2cc>;
+		clock-names = "hfpll0",
+			      "hfpll1",
+			      "hfpll_l2",
+			      "acpu0_aux",
+			      "acpu1_aux",
+			      "acpu_l2_aux";
+		#clock-cells = <1>;
+		#interconnect-cells = <1>;
+	};
+
 	/* Temporary fixed regulator */
 	vsdcc_fixed: vsdcc-regulator {
 		compatible = "regulator-fixed";
-- 
2.39.2


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795CE73D3EA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjFYU0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFYU0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A0E51
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f122ff663eso3096802e87.2
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724762; x=1690316762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+GCrepZpZ07r0tv1d8SOWMaal6SlXWvh6wePwrW8Hs=;
        b=mXvRQ3f5cQ9LkMkGqZ2Aa42Sl/2iVck9y+oYYey834JPH5QxKlL+qoEyad1uKOA1Vu
         rz8eS//IE3dtW1qV2zzjO8ojn/HkCLqnpqCJodeyfiMUvO3Ok1gZ0JC5s7tMB4vIVov1
         R2LlvWE89HSpOva8Khg+MKv7CflNhc2R3SDSm+QodD1L1e6gxVdnV32YF5kNmTFbjW/U
         viHTMRdoS+pj487xUCUGs9g6X3CDJTJ8Y8Fvg0tES2RCEmaNvzRSsnjBhRCWzxYhnPBg
         DtacG/xrlZtk8NEh6qtdPkx7AgdiP36iz91p1vKHI1kl0fUsRzRdjUaH/pxyOw0hbcqX
         M1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724762; x=1690316762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+GCrepZpZ07r0tv1d8SOWMaal6SlXWvh6wePwrW8Hs=;
        b=kQPx0O+evKwjWDsK4mcCPxZoUMFE3VYkd0kWX0LLc8WsDb6wlx9bvpgVyZ0j3Gbodv
         jRwq+2TbQtOeKgZSHEjyJ4x55A21y0TTHtCe+uwWf45gAqRhuhIf26rst7ZIPjaJyQiD
         /lNCPhptlwsk66tn7MVRaCi0lc6xcCdLbtxxNBI/cqZufdIlriPPAtCY0DfkCKysiKaT
         9OIljkx+fxbHhaymQzCcMVo9ge4yZECirj2okF3fwDA80pGmD+ur01g3cfVsV2f9iWqr
         n8lYt/mEkVF64Iz5BfL/C7AaEuSSaoiNmjhBAr5IJY7FMXywmRTedChQ6j8OAlVJPuPU
         Ltag==
X-Gm-Message-State: AC+VfDyFPzV5BebKflVhVd+FsMVr1zRGVuCchfAGA0Y1CGuGMwRWWXIe
        Ww86XFc7AlLj7foAbyoftZ35Ew==
X-Google-Smtp-Source: ACHHUZ7f8ixQfL1ga1D0yEkIPcz5kwKkJFZfFGi4DPWaR07iYqYX/5/RzNexynfHi3ppKJ6JcD2aVw==
X-Received: by 2002:a19:2d4c:0:b0:4f8:7772:3dfd with SMTP id t12-20020a192d4c000000b004f877723dfdmr11111843lft.11.1687724762058;
        Sun, 25 Jun 2023 13:26:02 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:01 -0700 (PDT)
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
Subject: [PATCH v2 14/26] ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
Date:   Sun, 25 Jun 2023 23:25:35 +0300
Message-Id: <20230625202547.174647-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
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

Per the power-domain.yaml, the power-controller node name is reserved
for power-domain providers. Rename SAW2 nodes to 'power-manager', the
name which is suggested by qcom,spm.yaml

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index d2289205ff81..471eeca6a589 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -422,25 +422,25 @@ acc3: clock-controller@20b8000 {
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


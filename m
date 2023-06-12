Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C772B799
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjFLFkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjFLFju (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9B1700
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso4561982e87.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548376; x=1689140376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PALwgyHQ+TieQGPmUm7gjgazS+uJ8oClOdkRzim+GA=;
        b=WQ76T6AYO9iXreicPvFvTy8FGnJ5tlrR7zDNET/6ri723/Su8VflS/Ya1fq3VXZIyv
         PF2kCf5QUbyhkmHcqMlfxzh+G8NwJMyO0FbiKqZXYBZm3IxbRoGY6fs15ZWAmdf5f5BL
         25m6veF+v2wBl5QA9bMu/cP6AXahqqKyslExU5EdJf6Qj9tWd6vswiHhvVTdS481Y+Ct
         gcPt/DMtrNOoSkU08ajqZMYuR59esp6YOPaD8tpJOEeQ/29rWJGWa8oYa4Vgddne+4V3
         cOxk2QUS90j5H3VnVpONsq8IE1SRyJTfd+DY/VF08Qv7jIbtZPakplgYZozcdUN0QJgG
         5fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548376; x=1689140376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PALwgyHQ+TieQGPmUm7gjgazS+uJ8oClOdkRzim+GA=;
        b=dat2EPGbf5LzhTkqG+kTcg9qxFxT/+oDMmdV0lbRebmHoqQUr7OfO06wQ6ab72yVA/
         glf3oSPAPcvkri32yTOP4nv3TYcEM9lqKjM8qZoRS2axE04fLHmZTuDckZhk7u1zBHTX
         6A/hiRGXaFO1obAJdPB2+jDJG1k9cxgfybPN4dXydeobOxVCIjojDXVe/cvoxOYaIDy3
         POpXZdinMordxSCRJLFpWkGIZG/YjjLwC7rNjArLHZbR/q194JTDRcSxqQgwEjBYCAZ5
         fCRgML5mhaHr9ws8AcvVdVpHh2JtN+bpQizgRcIjk4M3FZC2Kvqu0+H3V9UTVvrWMJXq
         hNsA==
X-Gm-Message-State: AC+VfDwvxas9MWRWa5DzwjmMEz0NJxavx403YuFr5IhbfxwHRV2UUt+p
        qBs0hIehb6tu8eW2DhDii4dYyw==
X-Google-Smtp-Source: ACHHUZ70K7TIUhk3aWrow/GwcxAggY7k2lj2rDnC8KHQGKNXbohL/WhmjzvxUc2avAPBm2O4jSKpKQ==
X-Received: by 2002:a05:6512:614:b0:4f4:aea9:2a2f with SMTP id b20-20020a056512061400b004f4aea92a2fmr4023869lfe.57.1686548376642;
        Sun, 11 Jun 2023 22:39:36 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:36 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 13/18] ARM: dts: qcom: apq8064: declare SAW2 regulators
Date:   Mon, 12 Jun 2023 08:39:17 +0300
Message-Id: <20230612053922.3284394-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 471eeca6a589..1eb6d752ebae 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -425,25 +425,41 @@ acc3: clock-controller@20b8000 {
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


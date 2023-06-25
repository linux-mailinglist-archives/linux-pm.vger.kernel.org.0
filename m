Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBA73D406
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFYU0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjFYU0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3404E48
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so3154217e87.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724769; x=1690316769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x8ZUoWpxa9r1cAw/Urm1Fq8ospvaA77mmKnj58hx+A=;
        b=lkhqRRhaId1+fbUnNm8uMIjIIeodv/0pwGqmfPIll+FGFZPjIPD4zB3v/ZkkRNHxrL
         ut8mxWqb8nwiMJ52OWmyXx9p0opqy/I0cj7g02zq0i60qmruBvk2V2DAS1G62rJg0Mt9
         Cfa/juZPY/drDVUEkNHVjG4GOPb47bYWOpqNiqwxzIFKpGhXvglBA0kBy+INLzmsOvJV
         OAnJWJCyxHk0xtbckgVdPRxXr2qz3Au6yja5K67p3IZ0zvzoDe1lFfjuqm0j2nk1ZcUu
         PqOFnAV4LWTW9mhD+e3+/9VoTRScOqZ9nc1KA7Vzk2iMXeUdAX5unLvc/6yAFaCrRh9p
         /A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724769; x=1690316769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x8ZUoWpxa9r1cAw/Urm1Fq8ospvaA77mmKnj58hx+A=;
        b=bpVXwWt/yvE7pPNq3ajFnZ5daQ3eDozrubhaTbmgtx1cAaBIgaEJAHXuvUINEaTcYn
         qq5jI3BmDQAizeiwg6JxJqjapnmR39BetXtAtl/Av0LHBloYBAIg8Ynn4tpHJvlDIiEw
         gBHOue5hh64IoEtRbhmdxYIZUddISw8lf9rFM7m6fimEfG897KORZhqjULVb2UGJvs/C
         V+nJg5VjNk8Yr+HWvCiBMPGiYBfSb5NkutZVB3I0V9X+WOvCSxC2eGRYsvMpH0NAG7jI
         SdjQKjLpuZM5BoyND+8Ph3nDXNIk48GO+lJLfGfDcBhBcSuS1qSWe5o2zZ8QPfWdsVVl
         TTlQ==
X-Gm-Message-State: AC+VfDy+2YLKo43x28dD+SQO+dHrIczUUV4HD6qge7PpNTN9e5C1xbDg
        x+ca6Gmqe1D3wydEtmWKpPPs9w==
X-Google-Smtp-Source: ACHHUZ5XjeASG5nUB0DbX/IzMVaJHVKgs5sHkFrYuBE2nlr+YdkMA9u4/K8F3fEDH+ZGO0xR/zNH1A==
X-Received: by 2002:a05:6512:32d3:b0:4f9:6528:fb1e with SMTP id f19-20020a05651232d300b004f96528fb1emr8150780lfg.51.1687724768852;
        Sun, 25 Jun 2023 13:26:08 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:08 -0700 (PDT)
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
Subject: [PATCH v2 22/26] ARM: dts: qcom: msm8960: declare SAW2 regulators
Date:   Sun, 25 Jun 2023 23:25:43 +0300
Message-Id: <20230625202547.174647-23-dmitry.baryshkov@linaro.org>
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

The SAW2 (SPM and AVS Wrapper) among other things is yet another way to
handle CPU-related PMIC regulators. Provide a way to control voltage of
these regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index fa2013388d99..50a5d87e9851 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -227,13 +227,21 @@ acc1: clock-controller@2098000 {
 		saw0: regulator@2089000 {
 			compatible = "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw0_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw1: regulator@2099000 {
 			compatible = "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw1_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		gsbi5: gsbi@16400000 {
-- 
2.39.2


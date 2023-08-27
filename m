Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F01789D71
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjH0LvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjH0LvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:51:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F801A5
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078e52537so3519112e87.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137051; x=1693741851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwm1Y1yKYRC2h+rKhVRBCueR16O0EXSdEm7pH6xao2g=;
        b=zeDkuL9gLDOtGUp3sxh74K4EK+IzvWipMMDLCvIh7VPsj5D8Wu6woMcZV24JehwQyk
         abgsKoOz5xJ9ncztZWgoax0uIGcnvl0wVOOaAspWHcy/2KJWoVJWNKFk9Pb2KqLCEGUY
         SumSLkPaRz23E9XHi2TP4RgNr0vFFXiPuS4FLiJm+WRuVYFHbC+9Xa2kh/o1Mr0BQ1gK
         awkepLX3yifRJ+02dKJ+0U81yaiOcmR+YVkePME1Q0MksupFx/BFfBqpG0fvVwPcf0rb
         qT7dYTXd+rGUYdUay10BIK+HRXbduQpqTi5q6HBoG9CYA638dIDzcYGQ5n+cNAJkFZUm
         iiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137051; x=1693741851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwm1Y1yKYRC2h+rKhVRBCueR16O0EXSdEm7pH6xao2g=;
        b=bfEa2qWzBTlc6w1H9odp5TZDIHYnaKhbYF9imiokxu4VJ0mTAUi2KaU9pu5s3FsrEd
         mo6TazDhIFJne0rQpteDEQDfcpzNDZTGsvUkCfBiPLXGuNMKyhgy/Dc40Bg5pcIIZL4r
         kzcI6R4XTSMYESIJ45JcDafEsA+d4Z/9uWXKFeySSbH59RVan8tR/pobpAcH1XM1k0xn
         CbaASc3Nh/m/kKXh2Vpc0DQQ3FomfZHm4Y4tp5J5zoXspXkDSZSAqSn/gJ1PXtCZgSiJ
         rbnUlOXpG0r6vLA7dQMIhJbzFy45LOh3z+4kNzhE502vTd1keUITtQACo6qPTR6Qd7aL
         /fnA==
X-Gm-Message-State: AOJu0Yzdyo+9oOzTQppRhFuMC40GehC5vxjD4cCsxm14aD6yXi2CNGt2
        9G0cPdCLwAYNAXBPJhlfpRfFEA==
X-Google-Smtp-Source: AGHT+IGFpGW7MeqAUFh8aVAXu7OTE6U1OKVMAOiRtG4IiJPhDohiehKW0Qi1TrQenA9YoNglJnTxqA==
X-Received: by 2002:a05:6512:2203:b0:4fe:2efa:b847 with SMTP id h3-20020a056512220300b004fe2efab847mr21623379lfu.23.1693137051233;
        Sun, 27 Aug 2023 04:50:51 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:50 -0700 (PDT)
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
Subject: [PATCH v4 20/23] ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
Date:   Sun, 27 Aug 2023 14:50:30 +0300
Message-Id: <20230827115033.935089-21-dmitry.baryshkov@linaro.org>
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

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator node show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
index 2b1f9d0fb510..24bc2cbfbd96 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
@@ -652,7 +652,6 @@ saw3: power-controller@f90b9000 {
 		saw_l2: power-controller@f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
-			regulator;
 		};
 
 		acc0: power-manager@f9088000 {
-- 
2.39.2


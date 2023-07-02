Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24E744F3D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGBRnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGBRnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BDE62
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a662b9adso53816341fa.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319792; x=1690911792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opGMkE+RmDE5zkyZAa1LQgTvHH68ZBwvMhZI5dpXRoc=;
        b=WMVRoFPOH0oYuKrpEfqVgY7AixffovubRFVREzpvwkeL3p1FFB/78nSebso2Q6y10X
         y0L1rTbstwJr+sZbiRUliDK6PFSQ8p0CXevpodFxywVBN8s4jHU9OUBeVNik6G1gnqe/
         Gp3eYoH4dZa6DH3T1uClg13yiXKsjOLhm30sVuVZz5RYWQlChQFzFcmIBwdgg1zvtqlf
         xJNH5wECAVPQhEaJT+kX8aWsjSSYkmy67MmOcm91FWFglT8uPIhdCZBpMccqOhyFS6Pc
         g8nNNF/A3Lt7eyXAIop7m4CSE9V4Fe0i5pu02nvc/o/Daj3aoUHJFLiFTDFUiWuSFl0U
         L+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319792; x=1690911792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opGMkE+RmDE5zkyZAa1LQgTvHH68ZBwvMhZI5dpXRoc=;
        b=JhMs2OZk92UXi07D+BJPyuA88NfxMPOPG5UKUVRoyPxu/G0v3N/d60QyfY1qziQGfx
         dwOEGG9IlZyK4k7ANx/xd8ruYiFW4PWvf3/Ork7BRC/WuPaXfHmrqSU34tNI4zyY0+Go
         4IuVVHWT0KAadYXMReUF1HBAHIOZFqK8hoLcLmhE0ae+lLtaNw7w3YTQITfWtiLhFfO5
         Y+bDZDbtJztIp1Wg0v/BElMHZfZjs5nU1KMEHWWzO+tvZXPcIuUCLCzEFqt1AlgQyz0J
         j9fVVGbe511c4cE+fYOj65YRvAo5RCzdSvbmmlp+1ex1x8JsQePuUz97Bctz7/NK10vV
         zhPQ==
X-Gm-Message-State: ABy/qLarsrG45iuv0MWR0nE2Vbsdefkf2nXqIFj1lCTaIgP/VvVQOv/B
        9Thdiz2pdsV2F68eamTVLBuwXQ==
X-Google-Smtp-Source: APBJJlFEVtDlhA4Fop6XZKOVXJZ2gSWDSS2y34nlny7yuuVdgDbyQzPDFwBypd2gHJ6Lq2aU5U//RA==
X-Received: by 2002:a2e:9785:0:b0:2b6:d536:1bba with SMTP id y5-20020a2e9785000000b002b6d5361bbamr4061940lji.18.1688319792802;
        Sun, 02 Jul 2023 10:43:12 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:12 -0700 (PDT)
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
Subject: [PATCH v3 27/28] ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
Date:   Sun,  2 Jul 2023 20:42:45 +0300
Message-Id: <20230702174246.121656-28-dmitry.baryshkov@linaro.org>
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

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator nodes show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index f0ef86fadc9d..ad3c922843c7 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -350,31 +350,26 @@ acc3: power-manager@b0b8000 {
 		saw0: regulator@b089000 {
 			compatible = "qcom,saw2";
 			reg = <0x0b089000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw1: regulator@b099000 {
 			compatible = "qcom,saw2";
 			reg = <0x0b099000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw2: regulator@b0a9000 {
 			compatible = "qcom,saw2";
 			reg = <0x0b0a9000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw3: regulator@b0b9000 {
 			compatible = "qcom,saw2";
 			reg = <0x0b0b9000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw_l2: regulator@b012000 {
 			compatible = "qcom,saw2";
 			reg = <0xb012000 0x1000>;
-			regulator;
 		};
 
 		blsp1_uart1: serial@78af000 {
-- 
2.39.2


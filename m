Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB118744F1D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGBRnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGBRnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415FE5F
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6c5ede714so44416861fa.1
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319786; x=1690911786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiQD8NPXoK/nu21wRjz7swL+/90HK35SEq9eEZ5XXuE=;
        b=szb37ojCIrWyIbH7RQecSCJP/XyeHyNqmmaBh9onDYcDKLD+FIPvzBnDlqIGY+WFcw
         QSD33xfVIt+XDzwzzbL+FjtjY4tFTUbGMGhLhC2jGAk9pRDEDs5N2y8VIYFEMCvarAJm
         os4V8LiXrKwQddITdbdGB9vAqS5ygbeMTnnjgrWVmuTTjYdLn+FqO0dgWAC+10UiH3G8
         cos0esosbF4r75PFBny36CIY2jBj8EGcfi/C9kEcQCD6RPt9v+915NdZ2Ets+OhY6lCb
         773d9W5fipsjUR+o4HJ4WfKgXcr5rqPuWDKDjIY3vU57uNwXjiS0W1qBs58+XuljIjTy
         ldeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319786; x=1690911786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiQD8NPXoK/nu21wRjz7swL+/90HK35SEq9eEZ5XXuE=;
        b=ELp6nhLJOn8kqU4syXSCa+E8ZYr5no9RS+BcfQQ1d2zQyo0GWMxe071Tm+RLX/zQeC
         19QV/N2sxUssjc2G3kY+EhI2MuR3qqkx8DjOAVMiUntrJXJpg1OlG2hp46Zxp8RocaEH
         U+oIG1HdbjbcX4WLtDZLI5Cax4IMWp7acBu6SLA/DpUhyvdPQp98td+GEMVCZdbWqvlg
         o0FZ5xAsU3I6UqtJNGSffa5qor75GNrZKAF2eDSkLpgG92n59l1y6Fh8Is5BuuvGE9TC
         /yG+tHBpdTXZsXuqMk5x2KxSB38kq93Si+RJkCln4KrYIld0YERz3xwMeESrrFwnlsOv
         Zimg==
X-Gm-Message-State: ABy/qLbWKu8KMu2LV+ipGK0FmyQK51Xjenc/OllKVyeOO6wmcvVL/CXA
        FjV78Okff6+g9xketzJ/eX9o7Q==
X-Google-Smtp-Source: APBJJlEHhMCDwDgf/6aVjCgaLcezDzbyqLrvjHOiuS5k6VoPxU2fW7+YSfalxB9Qt1FFfIok6q1SPw==
X-Received: by 2002:a2e:8697:0:b0:2b6:bd20:c4be with SMTP id l23-20020a2e8697000000b002b6bd20c4bemr2409804lji.20.1688319786343;
        Sun, 02 Jul 2023 10:43:06 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:05 -0700 (PDT)
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
Subject: [PATCH v3 20/28] ARM: dts: qcom: apq8064: add Krait clock controller
Date:   Sun,  2 Jul 2023 20:42:38 +0300
Message-Id: <20230702174246.121656-21-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Add device node for the clock controller for the CPU cores and L2
clocks. It will be further used by the L2 and by the CPUfreq nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index ab4b8f8270bb..c212215800d0 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -213,6 +213,32 @@ sleep_clk: sleep_clk {
 		};
 	};
 
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		clocks = <&gcc PLL9>, /* hfpll0 */
+			 <&gcc PLL10>, /* hfpll1 */
+			 <&gcc PLL16>, /* hfpll2 */
+			 <&gcc PLL17>, /* hfpll3 */
+			 <&gcc PLL12>, /* hfpll_l2 */
+			 <&acc0>,
+			 <&acc1>,
+			 <&acc2>,
+			 <&acc3>,
+			 <&l2cc>;
+		clock-names = "hfpll0",
+			      "hfpll1",
+			      "hfpll2",
+			      "hfpll3",
+			      "hfpll_l2",
+			      "acpu0_aux",
+			      "acpu1_aux",
+			      "acpu2_aux",
+			      "acpu3_aux",
+			      "acpu_l2_aux";
+		#clock-cells = <1>;
+		#interconnect-cells = <1>;
+	};
+
 	sfpb_mutex: hwmutex {
 		compatible = "qcom,sfpb-mutex";
 		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
-- 
2.39.2


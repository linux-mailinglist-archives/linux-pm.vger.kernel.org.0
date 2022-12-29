Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA036588FF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiL2DBk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiL2DBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9DF597
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id cf42so25931026lfb.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZBrWGsgyNha7RW/93aBTXd8U+HviEYa+gXS5auCDeY=;
        b=PVQulYdxtWzzRk6Iu01QoKspnPjUzBt6p8Lim5g1t+Ou1fibZk3lL0Vm7i7BWwf/AE
         ZfO1so0onQf1XsFiryGZ47SssYsN8GuSUz0F312HZT1zff7Bstwcg6A4UMZl1yAXLKlo
         uCeriwmphTKQvBQIVEGPSiYZpwXP4mMP6RNU9V5r92B3XqRD2biPyMErv95xdkFCDi3I
         pbAevuxyft5ie3FYKNIPmN+bLnj2vNnOlotD5Yu2gF18Ryzr6Kx4c1P0ayofQScrhDUN
         QxXmaPEsc2/O330TEPAad0/5AlyFEzQCNaCruNlGDaTYzcmYdu52d1FnWrptxTKvgYnn
         6Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZBrWGsgyNha7RW/93aBTXd8U+HviEYa+gXS5auCDeY=;
        b=dYUSSRX2yLMkpB3bXChpq3KZ6FjV9m9lPuEZ66nB+HytS5bsIaCteUhsgMe6gI/Nbh
         Xars65CXY3rK+pheulxlHoXzUbhZ+HwJlsGXZ2+NjL5t1/0yBkRFey0SWfI3nMsm6Co5
         6R+c69466PnVArIjWwdXjIuyOb2SdFCSzx3NXxwUFK2o8z/Uzec92HRGb80IxaChi+Jl
         ZWBm4oa5HAqXMCZ13+YBWGRqp4v4ss09i33/RhFEl89HZVF3oAVcPLWzfz9WxYKQz82x
         iRDHe9P/DTDu/wun7hl+FIx+4Q6J5k/n2DxZn5Ut3P+2UBv814jpa91j9LbmWCFXHTJT
         I+Vg==
X-Gm-Message-State: AFqh2kqP+P8e87h00x8J0h9G9buCoQwtjhCQDGpdGzRmgmWFRs5OyR4z
        RYpo5kcnnFKPvgKCo4UKlKru0A==
X-Google-Smtp-Source: AMrXdXuf3n9I1LY3UKQ2FJuC1d1378wmDmuzLdglowYfMlUn6erlQ28ntsTAIx56r+iiqemOuT//bQ==
X-Received: by 2002:a19:7606:0:b0:4b5:32ec:7eb6 with SMTP id c6-20020a197606000000b004b532ec7eb6mr7340215lff.0.1672282880508;
        Wed, 28 Dec 2022 19:01:20 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:19 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 15/20] arm64: dts: qcom: msm8956: use SoC-specific compat for tsens
Date:   Thu, 29 Dec 2022 05:01:01 +0200
Message-Id: <20221229030106.3303205-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The slope values used during tsens calibration differ between msm8976
and msm8956 SoCs. Use SoC-specific compat value for the msm8956 SoC.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8956.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
index e432512d8716..668e05185c21 100644
--- a/arch/arm64/boot/dts/qcom/msm8956.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
@@ -12,6 +12,10 @@ &pmu {
 	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 };
 
+&tsens {
+	compatible = "qcom,msm8956-tsens", "qcom,tsens-v1";
+};
+
 /*
  * You might be wondering.. why is it so empty out there?
  * Well, the SoCs are almost identical.
-- 
2.39.0


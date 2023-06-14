Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0B7306D8
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbjFNSFe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 14:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjFNSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 14:05:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDEC26AA
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 11:04:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so9136401e87.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765896; x=1689357896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyLlsxl16OWqS291jN4brexaOHkZM0ynHfqUIIXviBM=;
        b=oZv/T8vheSbgW34JAf8IU/cSZSHZufUTOGP1zItVOHwwpLcuDyRP0oiblXUlJLVT2e
         6+iofHmUIa75i0yoBsrJXRMnyvtU0aFM5v3OdXqeAICWFaivvAj2tHGracGg41nFGJle
         LHZHN7XLIHXjuXEeCxI1zBtHAEu3FFIGhieATscJPpKmEP4KrEPJ0nqYaKt2Ti8z+IXS
         OgNb5IS31wla/etxLJvhnmoaMX7ErVCxl8jYXGPj8vpW+yZOctxVJyNNz0z20piaryLt
         81aR+DXNdihvVIPgom0A5QI3vm41JYNdsfavY++hBxSlJu5pirQi1Z0WQjw1D5Aq8LaM
         HGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765896; x=1689357896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyLlsxl16OWqS291jN4brexaOHkZM0ynHfqUIIXviBM=;
        b=UVhR09xeZxd9FBWJ9OjfE9LLNztAVaBN7eoIRXe3Bc6qkwr1lN3AyY43cb2RRhXamj
         R9NriZ3eQGunpp8ERyb5MfPfATA584HfKrKFma5K1in+2NKdt1+8WWgqjUv1ccRRxlXR
         mYrNm8TxNu1uWRGCRAoRxsdmRQkYk+z3iR8mNEXxOKTTRfhuh4JtL+NlZpwtwIsq1ySA
         CKzitcEPjTgzw7bo70RWgLvwQIGncBOfU5uExehLvYvkOrttku0vn2hkEpak34niJMRh
         lSRVi0mP63JYcXweJJwDLSZ51JGbFuU2bc8jTI0CqArb7oroyMrVxkcFAm3moGdGcr4O
         HqgQ==
X-Gm-Message-State: AC+VfDyLoE0q0xPZ/kigMWvVN2b6Spb5L7qFUGFsJhbvkHUI6JXbGkmp
        PSmrxl/85trP582aFwbLKBTqnA==
X-Google-Smtp-Source: ACHHUZ7BD/fPpNrSrvxazkrE65BH3/qC+GxPSXrQcmHNq/XAI1r2lSiWockovfVk8mQBXL9V+Q5MNg==
X-Received: by 2002:a19:ca0f:0:b0:4f4:fdb4:c76d with SMTP id a15-20020a19ca0f000000b004f4fdb4c76dmr8576299lfg.47.1686765896602;
        Wed, 14 Jun 2023 11:04:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:34 +0200
Subject: [PATCH v6 15/22] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-15-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=1438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1dxDULtatbAkSLWWf67/ek605+kPD/vruTIZt6NGovc=;
 b=4oH1pCEvbOMW4wvsyB3dFaB4QVq9MmwUF4ltrBSN51FMGT7GiH3nSkBxLZbfzPwk4uoF/wpkU
 9Rl/CHCwcaYA4shfju7EB3PYQU9WR/H88J78BTg3vvnfahQ4jaFXJh1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 70b67fbe453f..b567a2b4199c 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1230,6 +1230,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8916_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1258,6 +1259,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1327,6 +1329,7 @@ static const struct qcom_icc_desc msm8916_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8916_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.41.0


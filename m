Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01972A479
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjFIUUL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjFIUTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 16:19:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385944210
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 13:19:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6170b1486so2804447e87.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341973; x=1688933973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5onO20dzjk2EC2OX/d1LUxW5LUluhqz+S0Vy1JWrck=;
        b=H76Q71eHL9VfsyY6tyyl2WcXpobMLvRXfPbj3Zx57XSqsk6vKFs6gOg22jq4rhoGDr
         BlQlm7xKinFVRU1q42HzpT0Of45Pdai1C7hS0Ygm0T7ZeCAjW4nKiOrWEsT/OO0loRVL
         16ZgihyhggMsmdNowFWIB79SdLz1q/zceLgJ3kaOCtPtXuzgGOvQST9qYtW90snjdmun
         dZn5ZoWops4XtJ4ZjYVVe2WcwGqc6Q7Qv/6APwO5E2AHV5aU0pFni8Ihw11Nat4kGc8P
         AG78GuwNlfHzJCSNXiAfDYBYz7BF7iyGti/5SkB+Wg4S5e0WExHuQrHal1ZerR6KbfP1
         9ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341973; x=1688933973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5onO20dzjk2EC2OX/d1LUxW5LUluhqz+S0Vy1JWrck=;
        b=Rzesgj9lgybnszBeElDTlu23Ljh0G5hf3K1jg3/u6rSug9buqcw1aB6d7hhuWyrvBs
         QgYD1v1SUexL83bB0Nxt8PIP3tZFiw0uDjpaRDOcGZLKjKJsa4jHsrIXi6oAejX7z5NN
         99Nmv5ZR/HJ3np/4d/oMm3gUlC/7fonJkBdaOPp+3mwXvZinD3VnFH8WulmzJYuN3Eg3
         zD3OqYKoj4YXO2YX4Iui+k8KvgUnlbM7FquEkTNCDVTpRLiL9TNJMf33FGG8KVv6G1nP
         OSq0heOUxdSKZ7UxU1crpyXYnVNbZ/lWw7vu+J6GLtIW9GXZCfXWfuAE41HpMvmOoJa2
         olKg==
X-Gm-Message-State: AC+VfDylAKVzPDKWiPpYtWjp+O33qAZ1oB1t0bBLmavMzQ3cz3CVjFSF
        jHbIxkx6PNAenqXFh3Y8SXrulzKpvT30bKReWXc=
X-Google-Smtp-Source: ACHHUZ56wa3+cBZ4wkIRTyXpqlWO1adyJZToYnkp01tP0BKTKal08vLhqwMvgkKPK8PGEXzZr8SmPQ==
X-Received: by 2002:a19:380e:0:b0:4f3:78dd:8e0b with SMTP id f14-20020a19380e000000b004f378dd8e0bmr905551lfa.32.1686341973210;
        Fri, 09 Jun 2023 13:19:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:19 +0200
Subject: [PATCH v2 14/22] interconnect: qcom: msm8939: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-14-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1682;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rte30PLdG0LgSDSUW6PXEcOPxUSZ9J+rm7lwZDwGmAo=;
 b=iOXzLo14/aH/k+LlvLy+aXX//+5t+jP4JBli0nQ1Jb39FIZGKiHElsxmprFPe75ZG/pEfsuTA
 EWhLX0HXulSCDD1TsM2Byo6pCBD0oRVZYgVMZ7tINgcoKjlbXyt3dBX
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 639566dce45a..94b11b590a8e 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1284,6 +1284,7 @@ static const struct qcom_icc_desc msm8939_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1304,6 +1305,7 @@ static const struct qcom_icc_desc msm8939_snoc_mm = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1332,6 +1334,7 @@ static const struct qcom_icc_desc msm8939_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8939_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8939_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1403,6 +1406,7 @@ static const struct qcom_icc_desc msm8939_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8939_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.41.0


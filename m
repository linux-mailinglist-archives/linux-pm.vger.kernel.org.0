Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78777438A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjHHSH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjHHSHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 14:07:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F961B1D
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 10:07:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso50714305e9.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514448; x=1692119248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZQ93ryTVkLJ674HaEi8fy9NL3vC9KyVwveDa7EddrM=;
        b=QEfPy3Qvqw5guHS5CqWLd3Wxox/4Cxdxip787ZZBj5Cik9AEBZ6DJ684lzWIpiJcga
         D1ui0ledffFpfW47aFkin2wijEG7k2KJtbRqyVVOqh2QV/L7X1UVa5BNGBo7hK6gW+6u
         yHMwmnbLNm2E/Px4AhhfouljCLoP3oaUZBtwoSCvgveDQI97jb5tks8YN8ksFHYLiIA1
         R1x+1PVWCp/JTyxeun80O8+GVPDu7EH4rm/CphGNK3boIXSARMmj6LQegBh42feulASD
         b7ddZBKbP08+1WCkw4WZPG7tAvbaBmjY3vYkze0mpWnEEa3HKGrfURincsFDETvy5jCk
         I+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514448; x=1692119248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZQ93ryTVkLJ674HaEi8fy9NL3vC9KyVwveDa7EddrM=;
        b=Q8bnaxy1T0xWFZE2HA1n9tUN7xeikonL4c+EbYfl1ysCGSgt4GDBsEzFukM5BUBEJz
         EHJ2radzxmYzAybW9h7vgABTPX8XbzVTrvfiBqMs6zBHqKI0l2fKnRQZSHddhIpqs6p6
         Din7S1MI3tewhlYF+IxlEuXhCQOfuNOKflosT2XbC9KKO6l2hw5IY6QjYNFtzRVHrIAa
         GlRpzaLJGjbBVGTPu4prUAx+99Kbb1rigK1Hdin7tq8b+u0SBl3vRQPvBUgYzK2Kzksp
         xUOyuMCbhcjgHtfBIhPbIYFYHNwORL8FySfLfd2M4vkwpavPQxAlhhCHA5xAlSwUj16B
         CneA==
X-Gm-Message-State: AOJu0YwHk8HNSRYOcqFjxX+4k2W+yZ3JtSJyfGN3A9SVqGZ49mFdQR/h
        HMMoPWVDHhis/IJeXKrmcc0IwJ0BgHLK2WnM7qo=
X-Google-Smtp-Source: AGHT+IG9eggqMlJftuNT+UYhqts3d5BpOBl7EQ49aL1HZWMDX+s3HZ44tnUlcpa8asB0W6Zw6ZbjPw==
X-Received: by 2002:a05:6512:10d2:b0:4fd:d538:b97b with SMTP id k18-20020a05651210d200b004fdd538b97bmr9355921lfg.29.1691495026441;
        Tue, 08 Aug 2023 04:43:46 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:40 +0200
Subject: [PATCH v3 09/10] interconnect: qcom: msm8996: Set AB/IB
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-9-dee684d6cdd2@linaro.org>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=1682;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6Ylk54qLtCUKuTX9FA4QTRZGSUqgBkVW+4oTAnkFbFA=;
 b=G6C3tehG5i+wpYLksQeibNa9TcRRryQx2c1C+PbgLjLNinmWth7Kgiq6h+P+yrqSg+hvkS8hs
 P/WvsN11oQzB97MrKtKeOynWWxsSz6KKpBWsjH96NjyOnz66wttLu7H
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 88683dfa468f..b73566c9b21f 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -448,6 +448,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = MSM8996_MASTER_MDP_PORT0,
 	.buswidth = 32,
+	.ib_coeff = 25,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -463,6 +464,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = MSM8996_MASTER_MDP_PORT1,
 	.buswidth = 32,
+	.ib_coeff = 25,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1889,7 +1891,8 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
-	.regmap_cfg = &msm8996_bimc_regmap_config
+	.regmap_cfg = &msm8996_bimc_regmap_config,
+	.ab_coeff = 154,
 };
 
 static struct qcom_icc_node * const cnoc_nodes[] = {
@@ -2004,7 +2007,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
-	.regmap_cfg = &msm8996_mnoc_regmap_config
+	.regmap_cfg = &msm8996_mnoc_regmap_config,
+	.ab_coeff = 154,
 };
 
 static struct qcom_icc_node * const pnoc_nodes[] = {

-- 
2.41.0


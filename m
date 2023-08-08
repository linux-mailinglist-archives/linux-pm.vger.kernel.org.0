Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B2773FC2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHHQw1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjHHQvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 12:51:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF154C14B
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:58:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c10ba30afso1460473466b.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510267; x=1692115067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc7oZvOcJDkiBa4MtO2BaU3uRCE2+ug+vLU72IFcWhs=;
        b=wcUO5V/AwoenJB8WC23DIRzNWQLilMM2OeXfrGWych6OwUQeYRgYtZsCquFE6xgGp7
         /d4G0aZsYVk+XcLPE5fJs76RgwwKb8dH+kPqnb+aegRvNIDN5M8xdusVRJiV+u4Gp2h/
         7Y4rVrrL1AQJPU50AJO2ZPsli6pCDhkh1Y0O3nHaoEwKfxgbcKlxCht6VqwNwAzrAIr/
         fWGv6mx1idtDBsVVWGUaczobAOig7qrICs+OUwrTjbVSd48JXeSQA7viDWNGWXsWgUoh
         ZPdGRIceHZbyw5mTbG4D0hEpMg37BrEX6jj0SvQFlkbdwGj+/c2Y3xNrurNJAFuu4qd+
         5e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510267; x=1692115067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc7oZvOcJDkiBa4MtO2BaU3uRCE2+ug+vLU72IFcWhs=;
        b=ljQLBWcGRX/J6juv9zE12pGHc3DY8W0wFCwkURdbtPM5F1EQEjAwsQO0JagOTdUyU5
         ZhwAlaumTVJCfXYDKm58gtZw13YEAJrqXoX5ZcB7k1h4Hrgv5A/XFVTqSXJQMinuHc+F
         /51HYDmd0JPkQ1uiO+PZ0BebBCyY0gZAOQLuMCF+1KFIswLVnWnY22r1Rv+1SqIbXf5n
         Tkp+9awDDQq97Qx1gu1SXO2z/KpqaR0RTnYmWDYmxSAySb5ep3l2DthAPgBF9F9h2quP
         srB2Z0hYLmWrRdnUC7jVXvb63U2SDqC9OqojeRGVFE+NQ4dF52DSaJC51Tf/w5KMlB2M
         cpBQ==
X-Gm-Message-State: AOJu0Ywaeke+5bM/1Yx17ukKbgiHO0xwZQf62Eanx17rsYgK4wiPM1mR
        zzu2Mu3S6rzVydoQZbFgQFsWxGGxJoAjfOmTUO0=
X-Google-Smtp-Source: AGHT+IGIViV1UeCd6ELmCSkLWBe6UBi27tTfxw7uswsQ8FS8N7MqPD6g+EmoJwhsZKgDL3YjzXYphA==
X-Received: by 2002:a05:6512:159c:b0:4fe:8be:6065 with SMTP id bp28-20020a056512159c00b004fe08be6065mr3416540lfb.5.1691495023110;
        Tue, 08 Aug 2023 04:43:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:37 +0200
Subject: [PATCH v3 06/10] interconnect: qcom: qcm2290: Set AB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-6-dee684d6cdd2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=1336;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gKAcxl1xTWi9i07xf8cB7oRhF8MPHDTJc+D4hon02Tw=;
 b=/bhzfzY1MtFGMTp+JULsYOGnTOJIwGJE49F01H2p/MlyJ9JEx0rnCkANXo4at1X8Tkomohnvh
 OqvdFmQjUgZBW8klOIAOfgdxaBhjsxg6abuLyt5iCorjdgBVtxRUJaA
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

Some buses need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 52a6eb32e832..42fa01c66e73 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1201,6 +1201,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
@@ -1327,6 +1328,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_coeff = 142,
 };
 
 static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
@@ -1342,6 +1344,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_coeff = 139,
 };
 
 static const struct of_device_id qcm2290_noc_of_match[] = {

-- 
2.41.0


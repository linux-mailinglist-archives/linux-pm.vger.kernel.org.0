Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF51715B92
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjE3KVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjE3KVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:21:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54D91BF
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4f8b94c06so2809232e87.1
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442024; x=1688034024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPsObl2eYSl57hf5e5vm23MgLVAf+ptSP7UWMFS0yPo=;
        b=GCk1DfL2fR9t/b7umBJBdnOvjrJ/TffAQUWuIHBKjt/DjKcu112buWgxQ/LJqezHLg
         F46c/5aNA8YqUo2xe/0V8OWlIJwXxvgoOisTYJ+Uzbv/GCs1uY3h0GfJgP5LdyhhGyml
         Y+ZdhuaZZPZgnRrpEqT17+VWDqYxRSEphbkQHOnAT/dzR774ShybNVqr37UIkOIXeE4S
         +U9hlTTAcKgIwFvjOau/FV54KDT0ceqw5MDRnOKDiPoJ7kcM2dQq0JAlbzIk/g7+pTVI
         w2tlAjfp6aqPJKeuR+EqgYYiAJM2DqL435PKRDZ0Hy2FOCC4j3UTeuTXrVtMvSq5gXqI
         aSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442024; x=1688034024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPsObl2eYSl57hf5e5vm23MgLVAf+ptSP7UWMFS0yPo=;
        b=Dt0ir9IGGo+mlJn7nqmT43RXkKQ35i7qyy0h2JeI4S7rm71OS3+oka/Gr4RTtewJmM
         g28xQOJvgoKIdMABhdZsWDkpZyI7oRvtWIBdvLDLzL24n8NZ9gT7Cz/XdyNwkLnIaAJt
         kFVL7R87lP8BR2CN3wtQMX73EnM3Zrx8irSasqPjlv1GCeTKHgxOn1BAFAIvR/0HScP8
         OnlzvOhrFCdR8cJd54IewBwhKg5tTMAZbM5e7umAlRmKnnc0yD4/TkaZMKX1Iirka5lC
         FtwrkM5B3lbGBo5O6QjQBwARe9MHX4xthnvxafH2Zm4k4lMqZ6JqJtqFXvKqiHd7Giu6
         UIig==
X-Gm-Message-State: AC+VfDws/s7SQCIVKEHxSuZ6PyqxjtCMt/VHAm+BggPCRyaibFayZeYC
        x3g2GS1hO/87hgAQA3o4zLP51A==
X-Google-Smtp-Source: ACHHUZ5lx5CViTuxeCcbtsZno9zIJuTRjy6vwdA0lVXdpg+inNfAo6L2vz5c7z7veiFVr/3l4uuDzA==
X-Received: by 2002:ac2:5ec8:0:b0:4f1:496a:de8e with SMTP id d8-20020ac25ec8000000b004f1496ade8emr545614lfq.27.1685442024386;
        Tue, 30 May 2023 03:20:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:15 +0200
Subject: [PATCH 16/20] interconnect: qcom: qcm2290: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-16-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=2327;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AUnOBPS3NkcXCeAuiWAp3wlQXXz7ZJbGDI1WK0MkbBw=;
 b=mLVX0sFuQDPC2wh7J2YOL5ld7fn2UowkaahJmgkTbqaWoLJxCQZDC0Fla4quzPPDLOJp4TM90
 Y3vaMNbw5x6C1yknb9hhIeXRjjCD50gwSrF5PLDrDmqUwmqXl7BZQRK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index cb636e67a5a4..2c7a76fab83c 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1196,6 +1196,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = qcm2290_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
@@ -1251,6 +1252,7 @@ static const struct qcom_icc_desc qcm2290_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = qcm2290_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &qcm2290_cnoc_regmap_config,
 };
 
@@ -1292,6 +1294,7 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
 	.qos_offset = 0x15000,
@@ -1306,6 +1309,7 @@ static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
+	.bus_clk_desc = &qup_clk,
 };
 
 static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
@@ -1319,6 +1323,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmnrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };
@@ -1333,6 +1338,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };

-- 
2.40.1


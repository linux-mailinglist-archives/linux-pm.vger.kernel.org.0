Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B974EEF7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGKMdR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGKMdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:33:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3E170F
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:32:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso57879785e9.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078697; x=1691670697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qEI9ih7CsEfqqcZVsPdCla2s3zGk1zpIvdrNZp7GUo=;
        b=dAvzB/A7Czmgq3ktsc6UF4BQ1C8Xw08idezM9wayv81Gf5HNKmq26yAIc7nJo7uM+0
         DhnapoLeX50Cym3jFrCZcHOoBnVuwnPyx9CT37SLH51TwW2flON0+q40usRpM5wliuH5
         ggBI9eE8IeZhv1UsnNuKjUMJ3+o0aGWLME+5vyj2fo5mdZPEPCoeuYWParS/NZOB0qeG
         fIRcRbqe1K9vEB1jEOBGQ8lGSsTx+ebPnmp5TtSXyHzNYWVNyv89ie6MYim+BXZLZujd
         tmSr15k4AVhQ2omG71+eXnNd+7TXB3MI7vB9jfyRjTlbdhLINWSrKXdMIrFooAxUnCa2
         pw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078697; x=1691670697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qEI9ih7CsEfqqcZVsPdCla2s3zGk1zpIvdrNZp7GUo=;
        b=kfPQmhs4Wz1wL0O1opbuBh09HI/MTozM+HzAmc1/aWhOBB4uN3YnMiWZxZJCafCmVT
         mdDfFrXELc5acP1fwa3Uw37K5K66KGYN8gi5pYM3f3rc6iKKNI8z0t3BHevRY45glzr4
         6zAZ2F1vTSI+ca9STP4J0T2dZW77MhCIGnWCs3ehFYXHjF3LSgIiyZhVsGiV6edNEOEj
         Kj3PUbmbkewaMElOjhNYCv0K9GErOjI/5uEF0Z4phMWIgv+PDxUtWkwB5YmtrF+vBfBJ
         Dp2qfVh1jGCKMB5oGMi0A62usFFbZ7Q3ZT7Feukpy+2gmajauOkzncbFyarsBQs7urjJ
         D7SA==
X-Gm-Message-State: ABy/qLYeG4cSCQmyfsQmEHvmZlByb2yv1SiK+V6T4kN3/kQKAf4eztYb
        1OeXCB7Z1uurHfOggdS/mvl6SzRlAdwDb66gYx7IMA==
X-Google-Smtp-Source: APBJJlERwY5Ah/kFYLm9KWUQ1ixR3SDh15gYAU7TZOHqrhoESjYXLBqCwASCR5Xt40UjYu3EHMbB/A==
X-Received: by 2002:a2e:9f4d:0:b0:2b6:e151:791e with SMTP id v13-20020a2e9f4d000000b002b6e151791emr13433971ljk.43.1689077973594;
        Tue, 11 Jul 2023 05:19:33 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:50 +0200
Subject: [PATCH 51/53] interconnect: qcom: sm8450: Point display paths to
 the display RSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-51-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=2103;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GAWOUV4QJe60q6M3sv3YLGxilMGxFFgLlCxXc4BU++I=;
 b=n6mHwI5Knlo8QwAZ9UuQJZ5TSMk5uicF8dPrneNhYlmJUFzK9gguKI0KQoyfgn83kx8zxL6qu
 BLXqqqUvr/lAd5PsnBNC3JILtU6yS5lpYZClOMClAFtFiipSLnQ2MVw
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

The _DISP paths are expected to go through the DISP RSC. Point them to the
correct place.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 989ae24f2be9..6f42b1d693b4 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1517,21 +1517,21 @@ static struct qcom_icc_bcm bcm_sn7 = {
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mc0_disp = {
 	.name = "MC0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mm0_disp = {
 	.name = "MM0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_disp },
 };
@@ -1539,7 +1539,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 3,
 	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
 		   &qns_mem_noc_sf_disp },
@@ -1547,7 +1547,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
 
 static struct qcom_icc_bcm bcm_sh0_disp = {
 	.name = "SH0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_disp },
 };
@@ -1555,7 +1555,7 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qnm_pcie_disp },
 };

-- 
2.41.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D565FC24
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjAFHeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjAFHd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE59755EF
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt23so929076lfb.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPicP64XWz8gL6/aaZpc4qLwvo8co3wJZRTRbgcU+js=;
        b=Q82pw4caTFSrOjMmcx+RhkwK/gl9jV4ZOoo2un0fJAsjW0ReC+JtnA9AI8T7ohxzW6
         Jx3+UFcd8urHARMqTiLgAGTHkgA/IdJhi69kL5Cp/TN48Z8vnKeYGPRwsQey21Ar0AFt
         qEeeJz/GGwbRmd0/2Rko8bIvM0dSD8COxbXQtXzuUaIFG/x+ofFbD3JcLzTQBG0IVkKy
         ocrM1+NzqF2LIE7oK9bHpqUNvbXehoWuBzojbyeAxlwrAN+6SWf4AiyGquOVInZVK418
         hGou4Xh5XZbKAoEZ/yrmKINW8jf2JPu8EqRBVwnjRO/1ByVUuieNF5YOL8B3QXxTyxtH
         GP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPicP64XWz8gL6/aaZpc4qLwvo8co3wJZRTRbgcU+js=;
        b=fdHTgzOUzSaCG51ejl0HlCqAPK6JEDK4umO49WjdM2SnHmFMrM/MAXhs3BbJBLNdNd
         tgg/yUIT4cN/8bSUn/xp2h3KgvSDksb8uV1E8iKI43GijIY/a1fE/LH0fIPYS3T2U4H/
         +f44HftMGgwSX6Ya3jUnC0HVgc9uKIbSXQFe/gvFnawOIgYNGnuijq/+3W7XrnYbCsyQ
         +BLfCWA5g7lGsOO84n48KjH3PYLlgrSoNFKvBpw8P9cIXSxwWHWyf/hIbJU5FiOsstif
         uTVROuqqv910Q2eLN6rO0VRD2LAlb67Rr3BKaSAmv9J2sf4SQISbD46mv4EKVzT78nST
         /KNA==
X-Gm-Message-State: AFqh2krrjyIsBVyhUCGgY5SG8j1tzOwdZ+tPHk0PlOg1SgTkTzEv1RQR
        6V5605Sb/Exnwnv+J1OL+KrhxA==
X-Google-Smtp-Source: AMrXdXuWaAe+cnjl1JkMZ26CQEhXDz3zC3xBvASRcQBC8fmwK4aulL/rZCGxo/TQohmRZlRbnt+iAA==
X-Received: by 2002:ac2:5142:0:b0:4cb:2260:8553 with SMTP id q2-20020ac25142000000b004cb22608553mr7551983lfd.30.1672990399863;
        Thu, 05 Jan 2023 23:33:19 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:19 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 6/9] interconnect: qcom: sc8180x: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 09:33:10 +0200
Message-Id: <20230106073313.1720029-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to the sdx55 and sc7180, let's drop the IP0 interconnects here
because the IP0 resource is also used in the clk-rpmh.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 38 -----------------------------
 drivers/interconnect/qcom/sc8180x.h |  2 --
 2 files changed, 40 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 0f515bf10bd7..c76e3a6a98cd 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -469,15 +469,6 @@ static struct qcom_icc_node mas_qxm_ecc = {
 	.links = { SC8180X_SLAVE_LLCC }
 };
 
-static struct qcom_icc_node mas_ipa_core_master = {
-	.name = "mas_ipa_core_master",
-	.id = SC8180X_MASTER_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8180X_SLAVE_IPA_CORE }
-};
-
 static struct qcom_icc_node mas_llcc_mc = {
 	.name = "mas_llcc_mc",
 	.id = SC8180X_MASTER_LLCC,
@@ -1201,13 +1192,6 @@ static struct qcom_icc_node slv_srvc_gemnoc1 = {
 	.buswidth = 4
 };
 
-static struct qcom_icc_node slv_ipa_core_slave = {
-	.name = "slv_ipa_core_slave",
-	.id = SC8180X_SLAVE_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8
-};
-
 static struct qcom_icc_node slv_ebi = {
 	.name = "slv_ebi",
 	.id = SC8180X_SLAVE_EBI_CH0,
@@ -1524,11 +1508,6 @@ static struct qcom_icc_bcm bcm_co2 = {
 	.nodes = { &mas_qnm_npu }
 };
 
-static struct qcom_icc_bcm bcm_ip0 = {
-	.name = "IP0",
-	.nodes = { &slv_ipa_core_slave }
-};
-
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = true,
@@ -1604,10 +1583,6 @@ static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh3,
 };
 
-static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
-	&bcm_ip0,
-};
-
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,
 	&bcm_acv,
@@ -1766,11 +1741,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC_1] = &slv_srvc_gemnoc1,
 };
 
-static struct qcom_icc_node * const ipa_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &mas_ipa_core_master,
-	[SLAVE_IPA_CORE] = &slv_ipa_core_slave,
-};
-
 static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &mas_llcc_mc,
 	[SLAVE_EBI_CH0] = &slv_ebi,
@@ -1857,13 +1827,6 @@ static const struct qcom_icc_desc sc8180x_gem_noc  = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static const struct qcom_icc_desc sc8180x_ipa_virt  = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static const struct qcom_icc_desc sc8180x_mc_virt  = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
@@ -1913,7 +1876,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sc8180x-config-noc", .data = &sc8180x_config_noc },
 	{ .compatible = "qcom,sc8180x-dc-noc", .data = &sc8180x_dc_noc },
 	{ .compatible = "qcom,sc8180x-gem-noc", .data = &sc8180x_gem_noc },
-	{ .compatible = "qcom,sc8180x-ipa-virt", .data = &sc8180x_ipa_virt },
 	{ .compatible = "qcom,sc8180x-mc-virt", .data = &sc8180x_mc_virt },
 	{ .compatible = "qcom,sc8180x-mmss-noc", .data = &sc8180x_mmss_noc },
 	{ .compatible = "qcom,sc8180x-qup-virt", .data = &sc8180x_qup_virt },
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
index 2eafd35543c7..5b3bb0f0cb51 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -51,7 +51,6 @@
 #define SC8180X_MASTER_SNOC_GC_MEM_NOC		41
 #define SC8180X_MASTER_SNOC_SF_MEM_NOC		42
 #define SC8180X_MASTER_ECC			43
-#define SC8180X_MASTER_IPA_CORE			44
 #define SC8180X_MASTER_LLCC			45
 #define SC8180X_MASTER_CNOC_MNOC_CFG		46
 #define SC8180X_MASTER_CAMNOC_HF0		47
@@ -146,7 +145,6 @@
 #define SC8180X_SLAVE_LLCC			136
 #define SC8180X_SLAVE_SERVICE_GEM_NOC		137
 #define SC8180X_SLAVE_SERVICE_GEM_NOC_1		138
-#define SC8180X_SLAVE_IPA_CORE			139
 #define SC8180X_SLAVE_EBI_CH0			140
 #define SC8180X_SLAVE_MNOC_SF_MEM_NOC		141
 #define SC8180X_SLAVE_MNOC_HF_MEM_NOC		142
-- 
2.39.0


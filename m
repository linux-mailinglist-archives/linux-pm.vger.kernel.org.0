Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2D65FC1A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAFHeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjAFHd1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E26AD95
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bf43so924613lfb.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NQ4izbMf+dg+aEFS38W19wU77uxrxKm1+A5w1HnThM=;
        b=VE2XwkXWAolCeIltaFiJijpSWGcNLtMzeZHKf9hMUBilyoLcIPqn/0j8RB7JF8mu5D
         7u9yBU1JtwxvdQ9UxxIEsVyS8ThNIJ9cDHDC778zYKjBEPLWa/1p5UvImkjgkuyxG2Sj
         7IXBS7gEY6Vb4ikoZOTMpO32BEwotHmIyg9kzjd11iEDCCfUDTp/Fd1OGQc/om0UB6yP
         Dy3QzvxVPlcJQ8PKFi6XtCRVMWP6xudT0hBaM2ms0xjc+VlevrkSWPJw8o/hCV259eO4
         vtOmozwMWqGJ9Wz8deBlzpxblf0+rBXLEffvKGR3BH9tuzQwFt1fqf/omQiflclCIJ7p
         XBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NQ4izbMf+dg+aEFS38W19wU77uxrxKm1+A5w1HnThM=;
        b=S8/M0xioVOv7ockY38JVJ+DUVCwsnnQJT8gC3WUmQJ2QwDipfXwd+CiTPgpRc0SBtD
         ydlDwJhqJxNiLvumFNdsQ7HXycd9Z4DiXB8P2IBh+8LnV53LvdDW6Ce/Q9a7pB721NPH
         e8AFpJD9ObC8GlLhsw9l0qcOH6OofVkjgZwOJnNJmlxvx58Bz+FIMTkIYhjBYyolp5YQ
         wF3AQyHRo9cC/oK82F/yI9eUeHACv2uYa3vKOQrJB4HCh3CU3R7/dXF1c3g59JpAXJHs
         HT738HTDblhEbpikb/FZXk4zY4Fh1vQcXsvrppsr0Qflp6M/QMYLJrye7yK+Ou65d8LV
         tIZQ==
X-Gm-Message-State: AFqh2kqiao7YEVgvCUGIYW6GYm8RMWDpHMOVvJVw2id/WlNMZ2Nh0S1W
        NLAYhLXcn/gCTSUvDOeIs66Ong==
X-Google-Smtp-Source: AMrXdXvtHbN6l0XWHYf4U5VxpcyCgRsh0RSc1aatZYx4tanccAyGEEeyUuYSMQYdfPr/5YCCqOftMg==
X-Received: by 2002:a05:6512:b14:b0:4ca:f8ec:e86e with SMTP id w20-20020a0565120b1400b004caf8ece86emr16005643lfu.30.1672990399171;
        Thu, 05 Jan 2023 23:33:19 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:18 -0800 (PST)
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
Subject: [PATCH 5/9] interconnect: qcom: sm8250: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 09:33:09 +0200
Message-Id: <20230106073313.1720029-6-dmitry.baryshkov@linaro.org>
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
 drivers/interconnect/qcom/sm8250.c | 21 ---------------------
 drivers/interconnect/qcom/sm8250.h |  2 --
 2 files changed, 23 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 5cdb058fa095..e3bb008cb219 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -51,7 +51,6 @@ DEFINE_QNODE(qnm_mnoc_sf, SM8250_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8250_SLAVE_LLC
 DEFINE_QNODE(qnm_pcie, SM8250_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
 DEFINE_QNODE(qnm_snoc_gc, SM8250_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8250_SLAVE_LLCC);
 DEFINE_QNODE(qnm_snoc_sf, SM8250_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(ipa_core_master, SM8250_MASTER_IPA_CORE, 1, 8, SM8250_SLAVE_IPA_CORE);
 DEFINE_QNODE(llcc_mc, SM8250_MASTER_LLCC, 4, 4, SM8250_SLAVE_EBI_CH0);
 DEFINE_QNODE(qhm_mnoc_cfg, SM8250_MASTER_CNOC_MNOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_MNOC);
 DEFINE_QNODE(qnm_camnoc_hf, SM8250_MASTER_CAMNOC_HF, 2, 32, SM8250_SLAVE_MNOC_HF_MEM_NOC);
@@ -138,7 +137,6 @@ DEFINE_QNODE(qns_sys_pcie, SM8250_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SM8250_MASTER_G
 DEFINE_QNODE(srvc_even_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
 DEFINE_QNODE(srvc_odd_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
 DEFINE_QNODE(srvc_sys_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ipa_core_slave, SM8250_SLAVE_IPA_CORE, 1, 8);
 DEFINE_QNODE(ebi, SM8250_SLAVE_EBI_CH0, 4, 4);
 DEFINE_QNODE(qns_mem_noc_hf, SM8250_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_HF_MEM_NOC);
 DEFINE_QNODE(qns_mem_noc_sf, SM8250_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_SF_MEM_NOC);
@@ -171,7 +169,6 @@ DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
 DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
 DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
 DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
 DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
@@ -386,22 +383,6 @@ static const struct qcom_icc_desc sm8250_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
-	&bcm_ip0,
-};
-
-static struct qcom_icc_node * const ipa_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &ipa_core_master,
-	[SLAVE_IPA_CORE] = &ipa_core_slave,
-};
-
-static const struct qcom_icc_desc sm8250_ipa_virt = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
@@ -531,8 +512,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	  .data = &sm8250_dc_noc},
 	{ .compatible = "qcom,sm8250-gem-noc",
 	  .data = &sm8250_gem_noc},
-	{ .compatible = "qcom,sm8250-ipa-virt",
-	  .data = &sm8250_ipa_virt},
 	{ .compatible = "qcom,sm8250-mc-virt",
 	  .data = &sm8250_mc_virt},
 	{ .compatible = "qcom,sm8250-mmss-noc",
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
index b31fb431a20f..27189b97af9e 100644
--- a/drivers/interconnect/qcom/sm8250.h
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -31,7 +31,6 @@
 #define SM8250_MASTER_GPU_TCU			20
 #define SM8250_MASTER_GRAPHICS_3D		21
 #define SM8250_MASTER_IPA			22
-#define SM8250_MASTER_IPA_CORE			23
 #define SM8250_MASTER_LLCC			24
 #define SM8250_MASTER_MDP_PORT0			25
 #define SM8250_MASTER_MDP_PORT1			26
@@ -92,7 +91,6 @@
 #define SM8250_SLAVE_GRAPHICS_3D_CFG		81
 #define SM8250_SLAVE_IMEM_CFG			82
 #define SM8250_SLAVE_IPA_CFG			83
-#define SM8250_SLAVE_IPA_CORE			84
 #define SM8250_SLAVE_IPC_ROUTER_CFG		85
 #define SM8250_SLAVE_ISENSE_CFG			86
 #define SM8250_SLAVE_LLCC			87
-- 
2.39.0


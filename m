Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA08661B8C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAIAaB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjAIA3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC9BF6F
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:41 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn6so7328500ljb.13
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlOItJRRMAkDPzZgbJgWFgqfwmHPfRvxvGUyB6cVDak=;
        b=kv3GFNmkBgdFSGMLhxoe6hcn7lhHGCJtb9h5+xAwIP61AIKvuzwgW9VHhRpdkN3s1C
         oXI/5TOKy0/bgqlkL2esdhRmTODo1vu9P8/4ttv04VoEuudx4SL1CFbVjKlJu7M74LX4
         FFXLx/z+ULM1+lgn46UUWyA+88Nx1+NFGwnF1P5HjVR7mYX7CnI7hy7smu/a6P+Z8Nks
         1HDdbbRATlgsNwDIyihnRHqeUzOpg+ksSYtO++0sAZZmrceTG50uiNcLF79NBYzBN0Dx
         Zby/GGk3i8cPUF+mx42BEVepK9MGx9PyteO3QBQbH16b/PCyNPRjAio2N8QDxMRcWf0r
         cenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlOItJRRMAkDPzZgbJgWFgqfwmHPfRvxvGUyB6cVDak=;
        b=FG1dafLwp8UiO/Pt+CwbI8zqj4ZwrVshB7X9Y1yQ1v5CJVf/NCc2aPcUKg+oI/ubP+
         LYugrFvfyAV13mLm8kfkO7xLn6pspUfJbqRzysi834sUaBx/OWrxzmSBjkCwlewKbU+u
         5Olz1NNyMyh+s1wgEVf1VURiGd05EsdVJU8+MaBL3tYQD8ktm8JK6g77CFzKE5HBIs6h
         fxKe1Vbmvk6VJyP8RBjzvEcwAmmeSo06jbmZKDdAfJJsPkxYOTQesdq5pRmYx+fflzbm
         BnX1ip+qT4wslhqdQpNyZrIKGsNs+2DMLm/I6xtRxpK+SVpdjIM+KGd1PzTUEUyYLxdL
         WUdw==
X-Gm-Message-State: AFqh2kp5YLLs8nN3XwFrwu4IAeOa9wUf8bx32gWCOg8HLMJ5w5L0Mil7
        /S6BU5l455lVgPiRvKG7nAgZYg==
X-Google-Smtp-Source: AMrXdXtw57FoNh5BIP01qT2v7+x+VNHeJEYXT/5BnOMhpxh4/6huKkP5XAx1kWdbgQsATPpOJGKo9Q==
X-Received: by 2002:a2e:8350:0:b0:27f:bf7d:4256 with SMTP id l16-20020a2e8350000000b0027fbf7d4256mr12646185ljh.0.1673224179729;
        Sun, 08 Jan 2023 16:29:39 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/12] interconnect: qcom: sm8150: Drop IP0 interconnects
Date:   Mon,  9 Jan 2023 02:29:27 +0200
Message-Id: <20230109002935.244320-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
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

Similar to the sdx55 and sc7180, let's drop the MASTER_IPA_CORE and
SLAVE_IPA_CORE interconnects for this platofm. There are no actual users
of this intercoonect. The IP0 resource will be handled by clk-rpmh
driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/core.c        |  1 +
 drivers/interconnect/qcom/sm8150.c | 21 ---------------------
 drivers/interconnect/qcom/sm8150.h |  4 ++--
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index df77d2f6215d..cea54477cfe3 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1082,6 +1082,7 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
 static const struct of_device_id __maybe_unused ignore_list[] = {
 	{ .compatible = "qcom,sc7180-ipa-virt" },
 	{ .compatible = "qcom,sdx55-ipa-virt" },
+	{ .compatible = "qcom,sm8150-ipa-virt" },
 	{}
 };
 
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 1d04a4bfea80..c5ab29322164 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -56,7 +56,6 @@ DEFINE_QNODE(qnm_pcie, SM8150_MASTER_GEM_NOC_PCIE_SNOC, 1, 16, SM8150_SLAVE_LLCC
 DEFINE_QNODE(qnm_snoc_gc, SM8150_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8150_SLAVE_LLCC);
 DEFINE_QNODE(qnm_snoc_sf, SM8150_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8150_SLAVE_LLCC);
 DEFINE_QNODE(qxm_ecc, SM8150_MASTER_ECC, 2, 32, SM8150_SLAVE_LLCC);
-DEFINE_QNODE(ipa_core_master, SM8150_MASTER_IPA_CORE, 1, 8, SM8150_SLAVE_IPA_CORE);
 DEFINE_QNODE(llcc_mc, SM8150_MASTER_LLCC, 4, 4, SM8150_SLAVE_EBI_CH0);
 DEFINE_QNODE(qhm_mnoc_cfg, SM8150_MASTER_CNOC_MNOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_MNOC);
 DEFINE_QNODE(qxm_camnoc_hf0, SM8150_MASTER_CAMNOC_HF0, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
@@ -139,7 +138,6 @@ DEFINE_QNODE(qns_ecc, SM8150_SLAVE_ECC, 1, 32);
 DEFINE_QNODE(qns_gem_noc_snoc, SM8150_SLAVE_GEM_NOC_SNOC, 1, 8, SM8150_MASTER_GEM_NOC_SNOC);
 DEFINE_QNODE(qns_llcc, SM8150_SLAVE_LLCC, 4, 16, SM8150_MASTER_LLCC);
 DEFINE_QNODE(srvc_gemnoc, SM8150_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ipa_core_slave, SM8150_SLAVE_IPA_CORE, 1, 8);
 DEFINE_QNODE(ebi, SM8150_SLAVE_EBI_CH0, 4, 4);
 DEFINE_QNODE(qns2_mem_noc, SM8150_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM8150_MASTER_MNOC_SF_MEM_NOC);
 DEFINE_QNODE(qns_mem_noc_hf, SM8150_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8150_MASTER_MNOC_HF_MEM_NOC);
@@ -172,7 +170,6 @@ DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
 DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
 DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
-DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
 DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
 DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
 DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
@@ -398,22 +395,6 @@ static const struct qcom_icc_desc sm8150_gem_noc = {
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
-static const struct qcom_icc_desc sm8150_ipa_virt = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
@@ -517,8 +498,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	  .data = &sm8150_dc_noc},
 	{ .compatible = "qcom,sm8150-gem-noc",
 	  .data = &sm8150_gem_noc},
-	{ .compatible = "qcom,sm8150-ipa-virt",
-	  .data = &sm8150_ipa_virt},
 	{ .compatible = "qcom,sm8150-mc-virt",
 	  .data = &sm8150_mc_virt},
 	{ .compatible = "qcom,sm8150-mmss-noc",
diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
index 97996f64d799..023161681fb8 100644
--- a/drivers/interconnect/qcom/sm8150.h
+++ b/drivers/interconnect/qcom/sm8150.h
@@ -35,7 +35,7 @@
 #define SM8150_MASTER_GPU_TCU			24
 #define SM8150_MASTER_GRAPHICS_3D		25
 #define SM8150_MASTER_IPA			26
-#define SM8150_MASTER_IPA_CORE			27
+/* 27 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SM8150_MASTER_LLCC			28
 #define SM8150_MASTER_MDP_PORT0			29
 #define SM8150_MASTER_MDP_PORT1			30
@@ -94,7 +94,7 @@
 #define SM8150_SLAVE_GRAPHICS_3D_CFG		83
 #define SM8150_SLAVE_IMEM_CFG			84
 #define SM8150_SLAVE_IPA_CFG			85
-#define SM8150_SLAVE_IPA_CORE			86
+/* 86 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SM8150_SLAVE_LLCC			87
 #define SM8150_SLAVE_LLCC_CFG			88
 #define SM8150_SLAVE_MNOC_HF_MEM_NOC		89
-- 
2.39.0


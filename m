Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6B661B7E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjAIA3y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjAIA3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:44 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E98DFE8
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f20so7358511lja.4
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0YYMb5cChumCU/LFsVaRYcs53vHp6DRxjxo3uf1NRI=;
        b=eCUls80T6LjidquFN2iKyf7EFdJPe8gD/udncx6lasu7Bfwelihkp2h6saB0hZWWXt
         HGFIUaEjyE1BIq9STUsJFP/a6az8TCK8r3wDVnVisjYk5uv7uHV9P8VyTSCYx0ihjKWg
         I8TotucK6jo5Q0986QNric6ZBvZ08JIqjjpkgsRalttzbqPJPbxl8OvcUI/y9xSvPU/z
         XiRBm8/c0Dhgl8Zx7Q3DNacXYWpFOZu8/SWwOv3w6nhtzLKD1b6gu/bqHkvowL7kwwdY
         zsLhpjcznT4UIBDBPYnHpix0PkuComR3DcWZF5aqc9md+TlXOoOFB1ahxDSalweXzSik
         yB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0YYMb5cChumCU/LFsVaRYcs53vHp6DRxjxo3uf1NRI=;
        b=uDruIlqIwn30f1xYC6pxeHdr3AZ4gCMv1Zlqzse/a22IiRYuNz5R5DlmT05g1gb6Yl
         iGX026HhM777RB3fqrU2qJ8eVIEHmf4XOhGDVdarQiiIIGeEV5zOsiWYSvPHkLYVto9X
         WGfzhtMUnpibQxXlsv03H0HhQwedqvs9gwtLMyoVoxviLXN1UurVRP6FbdalZFLrMYcW
         Fpp5hWL+LitBWV2bkz506PkMJ+HrB7kuR8pnVNDWtjnMpX6n26h9nVgRUVoW4p3rpC2w
         Nm2vLlZ9WAF468mNzzQBtLxIWYjsJyQ5j4TISC5dVwxmjoS4WofW4k+eYKOSPpPnGhs5
         2RnQ==
X-Gm-Message-State: AFqh2krzspyrP4xeDeJN4GB+NxI7GMp3Emfogn35Hc89OnZQQNpopTwz
        8uP7zDHxV2jx30aH+fuPJV93Cg==
X-Google-Smtp-Source: AMrXdXsujovnyKSneJG0A5HTMUCrd+yZ0W6BzSrxOWn7ND6i/Db3OiBiY6o+wk7LEOSmuaRAURyBzw==
X-Received: by 2002:a2e:7d05:0:b0:281:bb27:90b1 with SMTP id y5-20020a2e7d05000000b00281bb2790b1mr2292721ljc.26.1673224180674;
        Sun, 08 Jan 2023 16:29:40 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:40 -0800 (PST)
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
Subject: [PATCH v3 05/12] interconnect: qcom: sm8250: Drop IP0 interconnects
Date:   Mon,  9 Jan 2023 02:29:28 +0200
Message-Id: <20230109002935.244320-6-dmitry.baryshkov@linaro.org>
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
 drivers/interconnect/qcom/sm8250.c | 21 ---------------------
 drivers/interconnect/qcom/sm8250.h |  4 ++--
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index cea54477cfe3..5b5fd436f23f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1083,6 +1083,7 @@ static const struct of_device_id __maybe_unused ignore_list[] = {
 	{ .compatible = "qcom,sc7180-ipa-virt" },
 	{ .compatible = "qcom,sdx55-ipa-virt" },
 	{ .compatible = "qcom,sm8150-ipa-virt" },
+	{ .compatible = "qcom,sm8250-ipa-virt" },
 	{}
 };
 
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
index b31fb431a20f..e3fc56bc7ca0 100644
--- a/drivers/interconnect/qcom/sm8250.h
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -31,7 +31,7 @@
 #define SM8250_MASTER_GPU_TCU			20
 #define SM8250_MASTER_GRAPHICS_3D		21
 #define SM8250_MASTER_IPA			22
-#define SM8250_MASTER_IPA_CORE			23
+/* 23 was used by MASTER_IPA_CORE, now represented as RPMh clock */
 #define SM8250_MASTER_LLCC			24
 #define SM8250_MASTER_MDP_PORT0			25
 #define SM8250_MASTER_MDP_PORT1			26
@@ -92,7 +92,7 @@
 #define SM8250_SLAVE_GRAPHICS_3D_CFG		81
 #define SM8250_SLAVE_IMEM_CFG			82
 #define SM8250_SLAVE_IPA_CFG			83
-#define SM8250_SLAVE_IPA_CORE			84
+/* 84 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SM8250_SLAVE_IPC_ROUTER_CFG		85
 #define SM8250_SLAVE_ISENSE_CFG			86
 #define SM8250_SLAVE_LLCC			87
-- 
2.39.0


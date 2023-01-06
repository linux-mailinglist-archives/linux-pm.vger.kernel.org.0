Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF36607BF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjAFULG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjAFUKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518884098
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu8so3533876lfb.4
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lZHLNPVwyb782Y1Pdyp+yigSMTuvcxhWD4r28OM7ZI=;
        b=nT/qpDbest9vFGbs/3dTZ4tv9t7gfhyfZHSufj98rI5240UJiXhIyMSDTuKC5OPgUM
         JOcFsXHNyacFxgtIcEBax/VNnwGDXA654fosrMsuOWkXrgrUDipRBbppvUtPCIicBX+J
         UuQyG2Yex5BEcUNllJ/61InJ0jaG7nYCmh9et6VU38V701pKngI+7YuqtE7Yrh4Z7yg+
         UB/7FXZTbS7NaNu4PBwrrXFBBh6YZbbeWdqHbLzLwt5+6vq8a1qBIxcbz17ejiOGSC/E
         EkElE3pURpxUyLv/4DYSxdoE0Uqu5c4BbyNFQw2dnP1uPGWiAamE9SuiwMhKcRrL7jX7
         0OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lZHLNPVwyb782Y1Pdyp+yigSMTuvcxhWD4r28OM7ZI=;
        b=ZUPL/jMDj2rvPjtbQEazuaCEUiRGdlpVxA/mwH9O2znpC4hviuLr5gJjbdr5HSlBJm
         cxaw+LwVDX1NdMtfTY9r4hun+PI3hL89CoOibz3gmn/eqryntyJPrYXWgeLoW1h8i2N1
         8zKXBcAawzk9mn+REuLaISGKBqf+RbH/KnIP2Itx1/FlRexSI+XQWaYEXq1zvjfda2xM
         2dstPsBYBFhPQjBoCL34FiAHIoaFrRzv1e7YPHQ5Y2bzeeE8oy1EZUYBN2zzNzlX+RjM
         7kjvj/i9kwgTgWrtcXkMGTuFQLFuxhKpAoOMqolpNNzwWFFmpxXf+qXKhM7Cn5q0rpPs
         dTCw==
X-Gm-Message-State: AFqh2kpU1L13wNOO26qT2MN1T2LeyLRIHDT4CBZSv4zBxH9E+D5qUfXD
        Ec5w/BLr/LBPR40ARvHpZq+ahg==
X-Google-Smtp-Source: AMrXdXuebx3Jum0oZe4fRts+d1EMAxx/VEPOxMRvGdsC0LvKv9c3BY2MSWluL1n6PMYflxCyEJ5+0w==
X-Received: by 2002:a05:6512:b9d:b0:4cb:6a4:ec77 with SMTP id b29-20020a0565120b9d00b004cb06a4ec77mr14120450lfv.4.1673035833879;
        Fri, 06 Jan 2023 12:10:33 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:33 -0800 (PST)
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
Subject: [PATCH v2 04/11] interconnect: qcom: sm8250: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 22:10:21 +0200
Message-Id: <20230106201028.1809541-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
References: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 402db0c53a59..3ec92e81053a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1087,6 +1087,7 @@ static int of_count_icc_providers(struct device_node *np)
 		{ .compatible = "qcom,sc7180-ipa-virt" },
 		{ .compatible = "qcom,sdx55-ipa-virt" },
 		{ .compatible = "qcom,sm8150-ipa-virt" },
+		{ .compatible = "qcom,sm8250-ipa-virt" },
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E264FEB71
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiDLXWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 19:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiDLXV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 19:21:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245439BAF
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 15:08:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso74106pjj.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1PgMlQ/c6d7ywcKlgwyQP4QhYqQ6ZhRRf8MqOPdNS8=;
        b=CFKaskt5J+Hjt1iheyHTHO1Hfw6AkzqezfNlKJ+nAvMUM720+8imfirmjfE6/OEkQU
         wRzFlrRoetvWkHTCpCMVXlr7Rv3zM35tvIPHub0Dse9Rfd1m3Ql56B8kpYymxzN9j1Aw
         q5Fxz8YtY4dXwct3mgjUG2sUIr+QXTOyuhg2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1PgMlQ/c6d7ywcKlgwyQP4QhYqQ6ZhRRf8MqOPdNS8=;
        b=hwgwNFL06dOwiEPsiUrU3sfAdcetyQ2AT6qF6lVdbtOEnFZkOf522WjVALAAo9GKgS
         Hedb6c3gpZNXAyqmrU4b+8TD0pZtHd4Yn8ghi9vEVnfA4Hv9hIYJhwh2j8G+lzIIyRyK
         0rd9iQWHkzowNRz5ztRiSQ/BealsOgfhlJ38w9lYlpDz+CsB5Os0Tb300iXMb+Q3ZRrf
         r7WdiI9h4YlE1foY1ENGGsqhUBn1GWM1FVHPBilW8I4crZXycelf05J9iH1BfNi5xppk
         x57HJAwrXcmfV4HBKEWdaHqeHGVTPOFBorcvYIHKdL6BEOCf8ZdcnsGZy/P+pVWHVtaY
         oTGQ==
X-Gm-Message-State: AOAM531JVpm6Ld2vtIspyUq94k7IY8ep4UPnHt7N0DhJl/iDpDJ2iwtT
        xiGUoHfEyEnM0ieMWo8fkOzoKdp8WzFsug==
X-Google-Smtp-Source: ABdhPJzeKTKBQ2FnG11WQUFGeA/Ru70BLnML8/dBikS6ligVTc2DOSF5rckZLGS2y4lfWiIYvaYTUw==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr40175310pfc.17.1649800839223;
        Tue, 12 Apr 2022 15:00:39 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e880:a5db:8eff:6b6a])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm40565288pfo.208.2022.04.12.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:00:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Alex Elder <elder@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 2/2] interconnect: qcom: sdx55: Drop IP0 interconnects
Date:   Tue, 12 Apr 2022 15:00:33 -0700
Message-Id: <20220412220033.1273607-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220412220033.1273607-1-swboyd@chromium.org>
References: <20220412220033.1273607-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to the sc7180 commit, let's drop the IP0 interconnects here
because the IP0 resource is also used in the clk-rpmh driver on sdx55.
It's bad to have the clk framework and interconnect framework control
the same RPMh resource without any coordination. The rpmh driver in the
kernel doesn't aggregate resources between clients either, so leaving
control to clk-rpmh avoids any issues with unused interconnects turning
off IP0 behind the back of the clk framework.

Cc: Alex Elder <elder@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>
Fixes: b2150cab9a97 ("clk: qcom: rpmh: add support for SDX55 rpmh IPA clock")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/interconnect/qcom/sdx55.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 03d604f84cc5..e3ac25a997b7 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -18,7 +18,6 @@
 #include "icc-rpmh.h"
 #include "sdx55.h"
 
-DEFINE_QNODE(ipa_core_master, SDX55_MASTER_IPA_CORE, 1, 8, SDX55_SLAVE_IPA_CORE);
 DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
 DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
 DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
@@ -40,7 +39,6 @@ DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
 DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
 DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
 DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(ipa_core_slave, SDX55_SLAVE_IPA_CORE, 1, 8);
 DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
 DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
 DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
@@ -82,7 +80,6 @@ DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
 DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
 DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
 DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
@@ -219,22 +216,6 @@ static const struct qcom_icc_desc sdx55_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
-	&bcm_ip0,
-};
-
-static struct qcom_icc_node *ipa_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &ipa_core_master,
-	[SLAVE_IPA_CORE] = &ipa_core_slave,
-};
-
-static const struct qcom_icc_desc sdx55_ipa_virt = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sdx55-mc-virt",
 	  .data = &sdx55_mc_virt},
@@ -242,8 +223,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	  .data = &sdx55_mem_noc},
 	{ .compatible = "qcom,sdx55-system-noc",
 	  .data = &sdx55_system_noc},
-	{ .compatible = "qcom,sdx55-ipa-virt",
-	  .data = &sdx55_ipa_virt},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
-- 
https://chromeos.dev


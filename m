Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB5661B8A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjAIA36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjAIA3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:43 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7FC741
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id g14so7337997ljh.10
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlvp5KyMN3SkZHshH3FZPnIMw0H8l2p4d7kxD9VWm9U=;
        b=SAuv2bKYNfOw9eM/pLyz/iIIFB7BECa7368lIlJPY1fZ3MVlVTJl5gf7xQKnUpI5//
         1j+ND1OVnQiQmZFqKsGTjorC1P1zk+Ac9SzKYJPpkPoZ9qyjYAqiyedYiFgplK1QKEr6
         N4WpNZ9NHPgnqkwwcgn1nCu/C3eXhGAQ/juhUEhnxozzD5RlOseuYIGfsmq+Viwteabq
         Tc/fuuM/Dbkupjb9HPVBJu9+mIwlQY/k6odGDmi5rKhu8APKA4ZgOSvD+5ghdd+gNOES
         NA9gWN1OEI9lQK1gA2w1jf560q6cQEjy3QeUm8jSo6KyApgEjcmiDAS9ch0dRhfLTEhg
         Y0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlvp5KyMN3SkZHshH3FZPnIMw0H8l2p4d7kxD9VWm9U=;
        b=R+pDoMok2UXAHIRQ+UhZzCUDADF7rksc16xEJ22HULp0QYOBPobbxgP5XYySQDLIO7
         AF7bz/gnA43HMcgIn6hVw1DI4EiLqc6Y5bcYEhO1ffsNnyvazyXI3uXJuA8Ut8GffJIY
         CY52m1vQNDCrSPZpdjf3JOfoOZUElYIh6MPKcmP+LDZSwq/E0sdYtxlB8YLY1H5ZFFmt
         z1cx1bOKnSFGIccKqfwCQGw0Br8D44EVq0XIDPhYqFhfHyj5RSgbRzlsdPaDaAeGatVS
         8tF/tsZmFWy7/exGsXnP+xlIJ7ymTU2ToU1Q1+NL2aVRnKryzCJWD2FTje0BpPFlTnSZ
         pGog==
X-Gm-Message-State: AFqh2koIVpbz7zImj9uB7ajcWOmIz/TJ4E/OuJfK60mWYaDn39+Z71I3
        e/J7A2zdO362xn4AYZuAfFNkCw==
X-Google-Smtp-Source: AMrXdXuaMq0PsnBvKcmibU0M8+nEK8yfyi33eBMXpBv/Tv2OX7AwjmKRxecqaHwcC9C3kUZoC1vqGQ==
X-Received: by 2002:a2e:a23c:0:b0:284:b2ce:293a with SMTP id i28-20020a2ea23c000000b00284b2ce293amr667139ljm.16.1673224181863;
        Sun, 08 Jan 2023 16:29:41 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:41 -0800 (PST)
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
Subject: [PATCH v3 06/12] interconnect: qcom: sc8180x: Drop IP0 interconnects
Date:   Mon,  9 Jan 2023 02:29:29 +0200
Message-Id: <20230109002935.244320-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
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
 drivers/interconnect/core.c         |  1 +
 drivers/interconnect/qcom/sc8180x.c | 38 -----------------------------
 drivers/interconnect/qcom/sc8180x.h |  4 +--
 3 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5b5fd436f23f..0f392f59b135 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1081,6 +1081,7 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
 
 static const struct of_device_id __maybe_unused ignore_list[] = {
 	{ .compatible = "qcom,sc7180-ipa-virt" },
+	{ .compatible = "qcom,sc8180x-ipa-virt" },
 	{ .compatible = "qcom,sdx55-ipa-virt" },
 	{ .compatible = "qcom,sm8150-ipa-virt" },
 	{ .compatible = "qcom,sm8250-ipa-virt" },
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
index 2eafd35543c7..c138dcd350f1 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -51,7 +51,7 @@
 #define SC8180X_MASTER_SNOC_GC_MEM_NOC		41
 #define SC8180X_MASTER_SNOC_SF_MEM_NOC		42
 #define SC8180X_MASTER_ECC			43
-#define SC8180X_MASTER_IPA_CORE			44
+/* 44 was used by MASTER_IPA_CORE, now represented as RPMh clock */
 #define SC8180X_MASTER_LLCC			45
 #define SC8180X_MASTER_CNOC_MNOC_CFG		46
 #define SC8180X_MASTER_CAMNOC_HF0		47
@@ -146,7 +146,7 @@
 #define SC8180X_SLAVE_LLCC			136
 #define SC8180X_SLAVE_SERVICE_GEM_NOC		137
 #define SC8180X_SLAVE_SERVICE_GEM_NOC_1		138
-#define SC8180X_SLAVE_IPA_CORE			139
+/* 139 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SC8180X_SLAVE_EBI_CH0			140
 #define SC8180X_SLAVE_MNOC_SF_MEM_NOC		141
 #define SC8180X_SLAVE_MNOC_HF_MEM_NOC		142
-- 
2.39.0


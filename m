Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA66607B3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjAFULA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjAFUKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6A8408F
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m6so3500351lfj.11
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6TNfDCQu0nivTzIywF2b+dmNFWya/YhuUF/KVZDFuc=;
        b=rMGavsMpuT+RTRknUGQ2e98lKOgC3z169lRCSRko9/2jlwNDooq7Sp7B8wzKaLjBfd
         awTK8lFTS9PdbyEDygd0hLwoi9pCqvu168dIqPeqIvAFxZv9rrgCxQDmjvOJtUgDD4QO
         uxs3MBXu5mMYhicwjfhH8I2rkYGOFa6T/H1mbTS5XI8UYICZUXehszluolA6wiai+gO4
         U0CfDRbehs0gzcvAsOvFHXzIVcGnxJjlh83swGSF346wLJHn2Oxnw4xgx+bCvHaFeaa4
         PU6fjWzy2hMFc6IDh/grh/WbDRolmTz+9AUIbDWZP0g84RZn4AmZus4xLevFrW5iyd5c
         QksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6TNfDCQu0nivTzIywF2b+dmNFWya/YhuUF/KVZDFuc=;
        b=BzREAoYPzkDpMjw5Q4CcPQ/26yIDn3It1wqCshRcjziP9+FI19/hbuOaoOuE441ClB
         7mnGSdTKPrAeuHXVcY7YYaxUzjnISwn31E8FLAjrvrIMNpq0rSSf58WdOqYE3qRW7aU8
         tUM1FRixLGhkaJgE67xNwzy1rvJOxoQ/fdpEMBF3bUk53T2MqcnoIKgAIgDmU1uxZMuh
         zwMcFEp/4COLG9hk8zsTjQr1FnFJaK8jejn8Z1uTCeoEixLugdSzd8nqGzyajx5FHdL+
         P4Knc2bCaWjeMektJAamT+XJ1dDbImCkBliuqw20BimeqFOYF/fCSO85xT/04mlGxIl/
         3bnQ==
X-Gm-Message-State: AFqh2kp2Wwh7SpIRuwkBxS7yXYo2tmh73Dh/9WWiW1+2tzrF0lo40UHL
        wAzNyVbR2zzFIVEgSvW/A8LhEA==
X-Google-Smtp-Source: AMrXdXupjRSMEfpA7amkTCP6oNBElyegH0AVvNXYtN0SZ0XW2wKTwQJ8Jp44Bu4WzeZ0Mfd2Q3V/tg==
X-Received: by 2002:ac2:4bd3:0:b0:4b4:a460:c995 with SMTP id o19-20020ac24bd3000000b004b4a460c995mr22439760lfq.5.1673035834665;
        Fri, 06 Jan 2023 12:10:34 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:34 -0800 (PST)
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
Subject: [PATCH v2 05/11] interconnect: qcom: sc8180x: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 22:10:22 +0200
Message-Id: <20230106201028.1809541-6-dmitry.baryshkov@linaro.org>
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
 drivers/interconnect/core.c         |  1 +
 drivers/interconnect/qcom/sc8180x.c | 38 -----------------------------
 drivers/interconnect/qcom/sc8180x.h |  4 +--
 3 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 3ec92e81053a..7230db81e0db 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1085,6 +1085,7 @@ static int of_count_icc_providers(struct device_node *np)
 	int count = 0;
 	const struct of_device_id __maybe_unused ignore_list[] = {
 		{ .compatible = "qcom,sc7180-ipa-virt" },
+		{ .compatible = "qcom,sc8180x-ipa-virt" },
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


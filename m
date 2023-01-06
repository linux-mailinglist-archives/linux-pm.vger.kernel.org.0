Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2158765FC19
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjAFHeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjAFHd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8377D755F8
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bf43so924679lfb.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYvhcU+C9b2YATvCAvPpM/RO3VrdB3OqAyRf9ppcwuw=;
        b=ZbK5OZVq5BpZxB0WV9hhLf365I/PjfrtM4cSL2XFDpgLMFBk88NlNIzbbeqlXiDwMt
         d24S0jfU+GfyLnMw0ebzjcRLrCE/Qu5E8nS6MDSlpmR2J/Di5PGOGayHHQvn906kg+se
         2TTjO2sCtlBaGs1eKsZcz9JWBHre3w2AF1zKIuYbxNEb8zOFYWUPPM2ildd5CMFRRgjf
         Ak2RCZ74FPo+ME93dCqKglFQqSToTcjfU03XtT2d4FRynthnpCGEQuQT7ZSDm/A2SdSu
         9m34I/Ym18PlRGbmXOTQjUL8qjQfjWqTLUIfx15GVFN1dTUAJqzjGjIZ5ZjkdkqdKJZu
         3rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYvhcU+C9b2YATvCAvPpM/RO3VrdB3OqAyRf9ppcwuw=;
        b=BSoeAUAzLL7MMTPKlgzDu6QgZUsWSbXy6oayxBelwXACWtY3+Y/roU1yw/DFF5VoLO
         70A8iuMzIW2pEDY6M6DFGie0NpPXto9RfNEOJ16Q4Ingi3CqJ9KE0w6nlxiEFkPzfPX9
         WX9QaUrg+nsEgiUYMa0i9uEsBYduyPtlhQb5jRt2CjTzbMOLRA/k5MhVRHCeYyLF+oQS
         lJzwWl5Ntw/OfjcHSgejRjxvenCXfmLhzCx7tPvzH4QFUt7crYK+ctCNv0wSdaHhoJoP
         fe/p3S0iLY8AO2AT3RWv5ctAxgutKAPZS7QYpN+IoabJC5dk5IvApQOFU7E7IoWPsFxc
         kKOQ==
X-Gm-Message-State: AFqh2kogvxZdyWAWbMIBm7wB60+QVZtEozb0Y1qoHzRgynItX35MhTb6
        zjMPcx98N3U1ogc1t+3XlomGzA==
X-Google-Smtp-Source: AMrXdXuzhRA7KwVGHyvos9Ai8RY5Cgfck+k4o9IkiIUSz0dsEXoMKf1tAKN+Zzs1K6YgdR24gPbgtA==
X-Received: by 2002:a05:6512:3048:b0:4b5:5f2b:ddf8 with SMTP id b8-20020a056512304800b004b55f2bddf8mr17385682lfb.7.1672990401084;
        Thu, 05 Jan 2023 23:33:21 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:20 -0800 (PST)
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
Subject: [PATCH 7/9] interconnect: qcom: sc8280xp: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 09:33:11 +0200
Message-Id: <20230106073313.1720029-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
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

Similar to the sdx55 and sc7180, let's drop the IP0 interconnects here
because the IP0 resource is also used in the clk-rpmh.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sc8280xp.c | 25 -------------------------
 drivers/interconnect/qcom/sc8280xp.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 507fe5f89791..e56df893ec3e 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -284,15 +284,6 @@ static struct qcom_icc_node xm_ufs_card = {
 	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
 };
 
-static struct qcom_icc_node ipa_core_master = {
-	.name = "ipa_core_master",
-	.id = SC8280XP_MASTER_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_IPA_CORE },
-};
-
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
 	.id = SC8280XP_MASTER_QUP_CORE_0,
@@ -882,13 +873,6 @@ static struct qcom_icc_node srvc_aggre2_noc = {
 	.buswidth = 4,
 };
 
-static struct qcom_icc_node ipa_core_slave = {
-	.name = "ipa_core_slave",
-	.id = SC8280XP_SLAVE_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8,
-};
-
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
 	.id = SC8280XP_SLAVE_QUP_CORE_0,
@@ -1845,12 +1829,6 @@ static struct qcom_icc_bcm bcm_cn3 = {
 	},
 };
 
-static struct qcom_icc_bcm bcm_ip0 = {
-	.name = "IP0",
-	.num_nodes = 1,
-	.nodes = { &ipa_core_slave },
-};
-
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
@@ -2077,18 +2055,15 @@ static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
-	&bcm_ip0,
 	&bcm_qup0,
 	&bcm_qup1,
 	&bcm_qup2,
 };
 
 static struct qcom_icc_node * const clk_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &ipa_core_master,
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
 	[MASTER_QUP_CORE_2] = &qup2_core_master,
-	[SLAVE_IPA_CORE] = &ipa_core_slave,
 	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
 	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
 	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
diff --git a/drivers/interconnect/qcom/sc8280xp.h b/drivers/interconnect/qcom/sc8280xp.h
index 74d8fa412d65..1b12472ddca4 100644
--- a/drivers/interconnect/qcom/sc8280xp.h
+++ b/drivers/interconnect/qcom/sc8280xp.h
@@ -10,7 +10,6 @@
 #define SC8280XP_MASTER_PCIE_TCU			1
 #define SC8280XP_MASTER_SYS_TCU				2
 #define SC8280XP_MASTER_APPSS_PROC			3
-#define SC8280XP_MASTER_IPA_CORE			4
 #define SC8280XP_MASTER_LLCC				5
 #define SC8280XP_MASTER_CNOC_LPASS_AG_NOC		6
 #define SC8280XP_MASTER_CDSP_NOC_CFG			7
@@ -84,7 +83,6 @@
 #define SC8280XP_MASTER_USB4_0				75
 #define SC8280XP_MASTER_USB4_1				76
 #define SC8280XP_SLAVE_EBI1				512
-#define SC8280XP_SLAVE_IPA_CORE				513
 #define SC8280XP_SLAVE_AHB2PHY_0			514
 #define SC8280XP_SLAVE_AHB2PHY_1			515
 #define SC8280XP_SLAVE_AHB2PHY_2			516
-- 
2.39.0


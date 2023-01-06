Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50BC6607CE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjAFULM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjAFUKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EF840A7
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so3496950lfb.13
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ill0/wzsh4ASoh+xaOta7TBlS3WIkzNzN32uocpWXo=;
        b=X6qNE3UcNwIDE86fIGGBCJqBKle+m44uj4ajoGGDOj+SN5pyfvOToy9a+6eozMVRqn
         oQ9pwl4ya5rFs4EipPqULKjCd6x1seP/Kc0bTtz+dRA68kFKipR8ayJP3w0lto/8OYfo
         g6rl7Jo7n3OCNrhXKsFznqwel8FWM949Egdbra0b7u7lg85Etsu8nbrt4EMPhkfQTIc+
         DpVaDseXSy3cZOpyNFIxBOR6SV+zH5Hca9kwFi9+hSLkGue1tNfHAyeT/DmX3v1dJrQb
         RxZuiG1yxJtrBGcMg7VPyf+i+c8RQ4AeHJD8jzDRIFEflyFruqyP+Oe+pjHNR8g1hNIJ
         M34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ill0/wzsh4ASoh+xaOta7TBlS3WIkzNzN32uocpWXo=;
        b=pKGkJbn0fUFdnAbG/aBRTs+i93eWaFbzBKQ8PLOtWi3Fje0/lMHilqfT0dKcL80vaF
         uI1tmS07pZHnrXV7QeF3hX3ZWxbZufIzmiEinEY5isih+MZpZOLF5FxTqLVog2l05Fi0
         xJyCbjk/xOw9Rs3/8cB902r+rp3gLiSQLIOxvKwFUjKWCX4R5zlt7r4m/EODtRli+TRz
         kd7Y0QyX7efjbPHQQr3iNFrpa5lygB9WA4zl1rX/yE19T0V9THyKLBUwygLvVp8sYw+b
         jKuZQ5wYhxv5QXDR+9Pc+ixjPNykzsILG8cI36J41R3DNp2JueVgvqulAw2lgIMTKxZm
         hYrg==
X-Gm-Message-State: AFqh2kr6nlW9jVCV0C1AIFBN/HLYVjKXPSgDrJD9Is6BgZmRRawI0Ug/
        h2+DShV3uiP8vEVFUmewBaX+ig==
X-Google-Smtp-Source: AMrXdXvFgU5Ftf+n21arffce7hFpX843/l8Bq1nmRAnRUo7d+UKiCUP0Y5L4n2ef+tEIv/FxcDBUkg==
X-Received: by 2002:ac2:4898:0:b0:4b3:d6e1:26bb with SMTP id x24-20020ac24898000000b004b3d6e126bbmr15431577lfc.29.1673035835584;
        Fri, 06 Jan 2023 12:10:35 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:35 -0800 (PST)
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
Subject: [PATCH v2 06/11] interconnect: qcom: sc8280xp: Drop IP0 interconnects
Date:   Fri,  6 Jan 2023 22:10:23 +0200
Message-Id: <20230106201028.1809541-7-dmitry.baryshkov@linaro.org>
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
 drivers/interconnect/qcom/sc8280xp.c | 25 -------------------------
 drivers/interconnect/qcom/sc8280xp.h |  4 ++--
 2 files changed, 2 insertions(+), 27 deletions(-)

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
index 74d8fa412d65..c5c410fd5ec3 100644
--- a/drivers/interconnect/qcom/sc8280xp.h
+++ b/drivers/interconnect/qcom/sc8280xp.h
@@ -10,7 +10,7 @@
 #define SC8280XP_MASTER_PCIE_TCU			1
 #define SC8280XP_MASTER_SYS_TCU				2
 #define SC8280XP_MASTER_APPSS_PROC			3
-#define SC8280XP_MASTER_IPA_CORE			4
+/* 4 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SC8280XP_MASTER_LLCC				5
 #define SC8280XP_MASTER_CNOC_LPASS_AG_NOC		6
 #define SC8280XP_MASTER_CDSP_NOC_CFG			7
@@ -84,7 +84,7 @@
 #define SC8280XP_MASTER_USB4_0				75
 #define SC8280XP_MASTER_USB4_1				76
 #define SC8280XP_SLAVE_EBI1				512
-#define SC8280XP_SLAVE_IPA_CORE				513
+/* 513 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SC8280XP_SLAVE_AHB2PHY_0			514
 #define SC8280XP_SLAVE_AHB2PHY_1			515
 #define SC8280XP_SLAVE_AHB2PHY_2			516
-- 
2.39.0


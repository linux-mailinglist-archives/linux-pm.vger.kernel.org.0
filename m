Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40D3D98DF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 00:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhG1W3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 18:29:40 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:54085 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhG1W3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 18:29:39 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 18:29:39 EDT
Received: from localhost.localdomain (83.6.168.174.neoplus.adsl.tpnet.pl [83.6.168.174])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id D40053F360;
        Thu, 29 Jul 2021 00:20:37 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: interconnect: sdm660: Fix up erroneous paths
Date:   Thu, 29 Jul 2021 00:20:33 +0200
Message-Id: <20210728222033.52500-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the earlier porting mistakes to make interconnect work properly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/interconnect/qcom/sdm660.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 632dbdd21915..93856dd6730b 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -264,10 +264,10 @@ DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, false, -1, 0, -1, SDM6
 DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 35, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
 DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
 DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
 DEFINE_QNODE(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MODE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, true, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, false, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
 DEFINE_QNODE(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, true, NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
 DEFINE_QNODE(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
 DEFINE_QNODE(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, true, NOC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
@@ -596,7 +596,8 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
 	if (qn->qos.qos_mode != -1)
 		mode = qn->qos.qos_mode;
 
-	/* QoS Priority: The QoS Health parameters are getting considered
+	/*
+	 * QoS Priority: The QoS Health parameters are getting considered
 	 * only if we are NOT in Bypass Mode.
 	 */
 	if (mode != NOC_QOS_MODE_BYPASS) {
@@ -916,6 +917,7 @@ static struct platform_driver sdm660_noc_driver = {
 	.driver = {
 		.name = "qnoc-sdm660",
 		.of_match_table = sdm660_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(sdm660_noc_driver);
-- 
2.32.0


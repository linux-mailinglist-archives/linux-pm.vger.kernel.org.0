Return-Path: <linux-pm+bounces-10510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8D925673
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF731C22331
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346A14884E;
	Wed,  3 Jul 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FThbjMgu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC23143C51;
	Wed,  3 Jul 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998331; cv=none; b=Q4uZs84SLhmj45GGsDudSPBQu7y4n0mYvh0Qx0jABsphLu5xOzg4VapEA2+KTrMJ1kvG90xZi23yCvk5WTJOqkAyfFId4lqWnzFGaFRKswC2KSDPn6FnaDhElOWGUIwJIeF01GHv4KSAvt9ROL+boH9h4kpEuGi6KZLFUS0W5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998331; c=relaxed/simple;
	bh=vTXIrNYgk07+cxh35MCsCkhSCeDYcKWZX/J/zDxpexc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg8PoNqm9LDYfFs1WKhYmaCF0XeRyOFq5M4pHtGim1yEJDoQN8m8I4HUiDwaU2RLW+RBzqvJEHpxBePxlhVbu6a8xcIurvhEumlGgiavpA1LKH0bttfwcCjFeMV10NPYkSigbdNegezhRvLg6Apbozf2IoAsCEaXnJUshRc0Jm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FThbjMgu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4634MYLo026743;
	Wed, 3 Jul 2024 09:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UbNoBFUcYXq8XZ6EildizcebXv7aqsBqo6JPgoSiu6w=; b=FThbjMguHvnFwcgo
	CBAWk1MC20n+cA1Bnk8srv0vzRff5LE52XtDOUG+lnkcWiI9iyUXJOzW+64xfWer
	+E1GDfzH1KQNhMIvnhuNrtTbB4NpkC7Uw8j508Os3jOe2JrbExUq/TSLvGPKLsnS
	0VqAzddII4jKjm23r3SHS/RgR5k8jOpx5v4WNprCujaW8nKTOXS2bvZxy4C/+06m
	8tZqsEPFiMPQJnfryBTJgcltihnkgZI7EsgIGosQUdzgadOEnXinVrElyZ+OcHvL
	RpuE5qrIxCalnVCpsx5YLF/5QyVPY6NVFb7MWXiP8iFs2tqvr/t2kM5Q3C2O08l7
	mTfyoQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yjhrn02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:18:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639IWm0019094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:18:32 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:18:23 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <luca@z3ntu.xyz>, <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v4 08/10] soc: qcom: cpr3: Add IPQ9574 definitions
Date: Wed, 3 Jul 2024 14:46:49 +0530
Message-ID: <20240703091651.2820236-9-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703091651.2820236-1-quic_varada@quicinc.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4uUcRhMzhtHWxy4ac1lRVZLza9rCyPpV
X-Proofpoint-ORIG-GUID: 4uUcRhMzhtHWxy4ac1lRVZLza9rCyPpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030068

From: Praveenkumar I <quic_ipkumar@quicinc.com>

* Add thread, scaling factor, CPR descriptor defines to enable
  CPR on IPQ9574.

* Skip 'acc' usage since IPQ9574 does not have acc

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: s/silver//, s/cprh/cpr4/
    Skip 'acc' related code as IPQ9574 does not have acc

v3: Fix patch author
    Included below information in cover letter
v2: Fix Signed-off-by order
Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/commits/konrad/
---
 drivers/pmdomain/qcom/cpr3.c | 143 ++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index 6ceb7605f84d..abd890cc4d9e 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -2056,6 +2056,142 @@ static const struct cpr_acc_desc msm8998_cpr_acc_desc = {
 	.cpr_desc = &msm8998_cpr_desc,
 };
 
+static const int ipq9574_scaling_factor[][CPR3_RO_COUNT] = {
+	/* Fuse Corner 0 */
+	{
+		2383, 2112, 2250, 1502, 2269, 2055, 2046, 1949,
+		2128, 1945, 2282, 2061, 2010, 2216, 2054, 2332
+	},
+	/* Fuse Corner 1 */
+	{
+		2383, 2112, 2250, 1502, 2269, 2055, 2046, 1949,
+		2128, 1945, 2282, 2061, 2010, 2216, 2054, 2332
+	},
+	/* Fuse Corner 2 */
+	{
+		2383, 2112, 2250, 1502, 2269, 2055, 2046, 1949,
+		2128, 1945, 2282, 2061, 2010, 2216, 2054, 2332
+	},
+	/* Fuse Corner 3 */
+	{
+		2383, 2112, 2250, 1502, 2269, 2055, 2046, 1949,
+		2128, 1945, 2282, 2061, 2010, 2216, 2054, 2332
+	},
+};
+
+static const struct cpr_thread_desc ipq9574_thread = {
+	.controller_id = 0,
+	.hw_tid = 0,
+	.ro_scaling_factor = ipq9574_scaling_factor,
+	.sensor_range_start = 0,
+	.sensor_range_end = 6,
+	.init_voltage_step = 10000,
+	.init_voltage_width = 6,
+	.step_quot_init_min = 0,
+	.step_quot_init_max = 15,
+	.num_fuse_corners = 4,
+	.fuse_corner_data = (struct fuse_corner_data[]){
+		/* fuse corner 0 */
+		{
+			.ref_uV = 725000,
+			.max_uV = 725000,
+			.min_uV = 725000,
+			.range_uV = 0,
+			.volt_cloop_adjust = 0,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 4,
+			.max_quot_scale = 10,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 1 */
+		{
+			.ref_uV = 862500,
+			.max_uV = 862500,
+			.min_uV = 725000,
+			.range_uV = 0,
+			.volt_cloop_adjust = 0,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 500,
+			.max_quot_scale = 800,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 2 */
+		{
+			.ref_uV = 987500,
+			.max_uV = 987500,
+			.min_uV = 787500,
+			.range_uV = 0,
+			.volt_cloop_adjust = 0,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 280,
+			.max_quot_scale = 650,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+
+		},
+		/* fuse corner 3 */
+		{
+			.ref_uV = 1062500,
+			.max_uV = 1062500,
+			.min_uV = 850000,
+			.range_uV = 0,
+			.volt_cloop_adjust = 0,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 430,
+			.max_quot_scale = 800,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+	},
+};
+
+static const struct cpr_desc ipq9574_cpr_desc = {
+	.cpr_type = CTRL_TYPE_CPR4,
+	.num_threads = 1,
+	.apm_threshold = 850000,
+	.apm_crossover = 880000,
+	.apm_hysteresis = 0,
+	.cpr_base_voltage = 700000,
+	.cpr_max_voltage = 1100000,
+	.timer_delay_us = 5000,
+	.timer_cons_up = 0,
+	.timer_cons_down = 0,
+	.up_threshold = 2,
+	.down_threshold = 2,
+	.idle_clocks = 15,
+	.count_mode = CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
+	.count_repeat = 1,
+	.gcnt_us = 1,
+	.vreg_step_fixed = 12500,
+	.vreg_step_up_limit = 1,
+	.vreg_step_down_limit = 1,
+	.vdd_settle_time_us = 34,
+	.corner_settle_time_us = 6,
+	.reduce_to_corner_uV = true,
+	.hw_closed_loop_en = false,
+	.threads = (const struct cpr_thread_desc *[]) {
+		&ipq9574_thread,
+	},
+};
+
+static const struct cpr_acc_desc ipq9574_cpr_acc_desc = {
+	.cpr_desc = &ipq9574_cpr_desc,
+};
+
 static const int sdm630_gold_scaling_factor[][CPR3_RO_COUNT] = {
 	/* Same RO factors for all fuse corners */
 	{
@@ -2676,7 +2812,8 @@ static int cpr_probe(struct platform_device *pdev)
 	desc = data->cpr_desc;
 
 	/* CPRh disallows MEM-ACC access from the HLOS */
-	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH)
+	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH &&
+	    !of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4"))
 		return -EINVAL;
 
 	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
@@ -2703,7 +2840,8 @@ static int cpr_probe(struct platform_device *pdev)
 
 	mutex_init(&drv->lock);
 
-	if (desc->cpr_type < CTRL_TYPE_CPRH) {
+	if (desc->cpr_type < CTRL_TYPE_CPRH &&
+	    !of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4")) {
 		np = of_parse_phandle(dev->of_node, "qcom,acc", 0);
 		if (!np)
 			return -ENODEV;
@@ -2828,6 +2966,7 @@ static void cpr_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id cpr3_match_table[] = {
+	{ .compatible = "qcom,ipq9574-cpr4", .data = &ipq9574_cpr_acc_desc },
 	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
 	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
 	{ }
-- 
2.34.1



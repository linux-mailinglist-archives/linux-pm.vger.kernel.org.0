Return-Path: <linux-pm+bounces-10911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3092CA97
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35867B228C9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860207F7DB;
	Wed, 10 Jul 2024 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZQjijns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AED58AA5;
	Wed, 10 Jul 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591962; cv=none; b=CqlH9MrmnDIsWqT84ZzwhfTPiTBfOB3769uyC6G3A6QtkHGt0kNLH0yXXVMdXjgzmfPcC2ys5rdbdJhnGs/2IUXbCW0t9hNL1Mdn7PhhuQqr3NsjhDfj6RSxVSnJi7x1u7B9BDYF75pKK02j3E5e3BujAwssKORX1KflFYdpZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591962; c=relaxed/simple;
	bh=HwWlR/Y4HpWo82eOMuP5oSX/okRDf37UMQbj+asJ72c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5r3rPVdY/dSgbILsqBqHsW6VCAin5Yun2ByXqZ08UoIc9AXs0AlvVG4F43E6NACDGZlrG174xPiJrTaWvLXA3EjcuDVDDeEcnFxAmnrmljsSfU03pBhOcViGT7e8WxG2o21aBWbzF5mtFTfFg+mTXK/Ys/us0G1QYXOEgqtu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZQjijns; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A3JBb4013079;
	Wed, 10 Jul 2024 06:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3uskcsTiOx5XaCgoWkArpK34aR6xZOA4pwy/sOSq5A=; b=JZQjijnsvjbmSNa/
	wT03NL2wlSZEDxaEVjkgr6NasTKKNLWccWIAYEeCsr4OZY6xoQrAs2EqSnrONwRt
	3OScjqryEdeNHrU6yOwulgNxJIC+/bbqmYZb37TdB0VertmQsXQcu9H8r73IC4wW
	U6k4N0t3l08V+y7Y/L2YjvbsEZclKwSHrmvkjscDU++g03FE+WGRddpIkEdLNXRR
	eOuT2zjYJhomEXtsmMbVO4wFhy/q+sjk0V2G6uXM0RFp1XCki27o048ID142M9sa
	ort8bp7i8p07HXAlvPARr7Wa2J8ETDUTFkf5A+GQbUrkoIEv64T8/CS01TMZaDuP
	eEAC+w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xpdr3pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:12:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6CPrs032124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:12:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:12:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v6 8/9] soc: qcom: cpr3: Add IPQ9574 definitions
Date: Wed, 10 Jul 2024 11:41:01 +0530
Message-ID: <20240710061102.1323550-9-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710061102.1323550-1-quic_varada@quicinc.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: yoN9SS9wWQ-LpHf3t4fnytYvkMayk_ad
X-Proofpoint-ORIG-GUID: yoN9SS9wWQ-LpHf3t4fnytYvkMayk_ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100046

From: Praveenkumar I <quic_ipkumar@quicinc.com>

* Add thread, scaling factor, CPR descriptor defines to enable
  CPR on IPQ9574.

* Skip 'acc' usage since IPQ9574 does not have acc

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Rebase on top of Konrad's v15
	- https://lore.kernel.org/lkml/20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org/T/

v5: Move the 'acc_desc' usage check to first patch

v4: s/silver//, s/cprh/cpr4/
    Skip 'acc' related code as IPQ9574 does not have acc

v3: Fix patch author
    Included below information in cover letter
v2: Fix Signed-off-by order
Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/commits/konrad/
---
 drivers/pmdomain/qcom/cpr3.c | 140 ++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index d594bc79be1c..0e24ee1556df 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -1942,6 +1942,142 @@ static const struct cpr_acc_desc msm8998_cpr_acc_desc = {
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
@@ -2544,7 +2680,8 @@ static int cpr_probe(struct platform_device *pdev)
 	desc = data->cpr_desc;
 
 	/* CPRh disallows MEM-ACC access from the HLOS */
-	if (!(data->acc_desc || desc->cpr_type == CTRL_TYPE_CPRH))
+	if (!(data->acc_desc || desc->cpr_type == CTRL_TYPE_CPRH ||
+	      of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4")))
 		return dev_err_probe(dev, -EINVAL, "Invalid ACC data\n");
 
 	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
@@ -2694,6 +2831,7 @@ static void cpr_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id cpr3_match_table[] = {
+	{ .compatible = "qcom,ipq9574-cpr4", .data = &ipq9574_cpr_acc_desc },
 	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
 	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
 	{ }
-- 
2.34.1



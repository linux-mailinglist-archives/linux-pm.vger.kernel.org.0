Return-Path: <linux-pm+bounces-9646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0890FE90
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0371C22C16
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A53198831;
	Thu, 20 Jun 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="duoTibvy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317719048B;
	Thu, 20 Jun 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871361; cv=none; b=KLEG01j+6WL9JbYHxYoEmJISK5JSwQBW+9NOqtqt0iL39JVT3p9LbuxdpSG6EKqns8ZBOxvii+Z7ztin7PTeyQDsbRuBA2BQAxkYnx9n86rWSwXdSncs4RLgeBekWsWdrjA0WR1QvEPa1w2HeCYvv/GMjNuBVAkOBXvSJia3gjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871361; c=relaxed/simple;
	bh=R/tm3NXp9cSbZiuTywLKPqWZf4X3i3jRNkh0hgoK714=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9OC1mD4Di7TRC9m77gxhQJY4XET+y6Te6V7+ru/oSxksy2v5XOPa0iO1gYvBBCQKI5SeQFSNasqBpgHNPfgPR1WLW7t9OhvHbgcpdFKy5/e0d1GSsHRfhHedl9DRavIJl3HryWXk2wa1MlYzipv/rC2i8TpytZLMWI2yPy8rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=duoTibvy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K239H0013167;
	Thu, 20 Jun 2024 08:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a5yf5U1/kdbq8jq91df+LGvT00bzbbQnkOslS7uCzNs=; b=duoTibvyQecsZ2LR
	bANJSwwoQASbL7s6M6Bwytx1gc2n48szVqUN/mWmbBjRlH2u1o1rpVtLOtRTbhWm
	t2/QtSLjoD/i28tcqhHvHXAv3MYLnOdr53XPONthqtG2uLkfQ9xUclrDuqdveyKi
	xm+LVslbVweO0RebXo3Aor8+8lybLTUPjrrI4N/wTclfC111/AxRJjafBGDBGD1T
	/HqRVLcrXNKU9+6HkiznufhEpPYJNJH7AFzpkPkqlgRS2uiQoBWNkq0RWB/73SHM
	Y67ak1QTdpevaHDQEaPfxmWBvmxi9WXreiq6n0xEZAa+MiUWgqklnL7QHMhyUkyO
	cAEJIQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvba30p9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8Fm49010064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:41 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_varada@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <danila@jiaxyga.com>, <otto.pflueger@abscue.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v1 6/7] soc: qcom: cpr3: Add IPQ9574 definitions
Date: Thu, 20 Jun 2024 13:44:26 +0530
Message-ID: <20240620081427.2860066-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620081427.2860066-1-quic_varada@quicinc.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: Zb-QlV90XeGv5Gom5g7KQlw3tAVA3034
X-Proofpoint-ORIG-GUID: Zb-QlV90XeGv5Gom5g7KQlw3tAVA3034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

Add thread, scaling factor, CPR descriptor defines to enable CPR
on IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/commits/konrad/
---
 drivers/pmdomain/qcom/cpr3.c | 137 +++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index c28028be50d8..78cb690f57cf 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -2056,6 +2056,142 @@ static const struct cpr_acc_desc msm8998_cpr_acc_desc = {
 	.cpr_desc = &msm8998_cpr_desc,
 };
 
+static const int ipq9574_silver_scaling_factor[][CPR3_RO_COUNT] = {
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
+static const struct cpr_thread_desc ipq9574_thread_silver = {
+	.controller_id = 0,
+	.hw_tid = 0,
+	.ro_scaling_factor = ipq9574_silver_scaling_factor,
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
+		&ipq9574_thread_silver,
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
@@ -2828,6 +2964,7 @@ static void cpr_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id cpr3_match_table[] = {
+	{ .compatible = "qcom,ipq9574-cprh", .data = &ipq9574_cpr_acc_desc },
 	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
 	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
 	{ }
-- 
2.34.1



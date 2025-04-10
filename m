Return-Path: <linux-pm+bounces-25162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1074A84B53
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921C3188853F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18352900B0;
	Thu, 10 Apr 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kpgO9T++"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75B28CF77;
	Thu, 10 Apr 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306875; cv=none; b=gGpnFDyXO6Z9jD4hzY3SpYhI8bTcUY9z/Pw70A/rRkE3YSz0xzvvZbQrKfvSdAsT/9Qo1F7BhejGESN+lrvV1cm9AVfO3lWEtZXVbw6YvpQxM0xhSaO49x08Y2MveMDOu9BXNbEA8WD3cwc0I2PAZyrGuHxptyFkDxE83BYefL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306875; c=relaxed/simple;
	bh=oM1/CJjKleR+pQ8tcCgcewvilyC/OjJXDcY1Rk4MztM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gym0OKxCsWajpv0PUUddCUwvomcHq4YUeNyGEhJ4lY8t8ahAr5Zg2CbqiZMVIYTi0/gu5FLBzFh30bi6Lp5Rzo7htKTru6so10hKoto6PIJkN+Y0iwv8FR9tyvJPQjJeygh4qHZfKdZrWkrKo23qgXCAijlNN+bgqlmQQRHltuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kpgO9T++; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFt6i8000880;
	Thu, 10 Apr 2025 17:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lKCKjKiUPU6w3zULIkkIndoE
	0JxPJ6elEYiA2sdNHNY=; b=kpgO9T++lXr0qFjF2hY/vgXcoLnEfe3LMHfuLEOT
	KmF5vLOzeFdxOD4QvyVsN0uVSWEQAEswglhL6nBWv842c8k17DcjehgfHEVoBydu
	vxKGv0cAxtX8Z5B4HoEvL2UO7/Z2nV+Op0inpm4ogejePyVi65aROMK8Vk09gfkN
	D/Mikw71o4AGeStPtsr6KB+oQTqLVOiasZ5nBqMKRtflW7ALhk9hifhry6pmH83G
	hib1EkwbQR3td7qJUmjHQYshKG9/e3RKmzAK9xuyygukAdopwPllsthlQ+h0ZQDw
	8Bej7abSU22uOPtp9ZngAZRlovfzACCbyoESFLDUQmZqdQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2yu50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AHf7vW031963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:07 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 10:41:01 -0700
From: Praveen Talari <quic_ptalari@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Praveen Talari
	<quic_ptalari@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
Subject: [PATCH v1 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
Date: Thu, 10 Apr 2025 23:10:05 +0530
Message-ID: <20250410174010.31588-5-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250410174010.31588-1-quic_ptalari@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PgkW7RIMOdxFQMLho6VLk1ewC8U0ptug
X-Proofpoint-GUID: PgkW7RIMOdxFQMLho6VLk1ewC8U0ptug
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f802b4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=-8ewQQW4l5uToJikuzQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100127

On the sa8255p platform, resources such as clocks,interconnects
and TLMM (GPIO) configurations are managed by firmware.

Introduce a platform data function callback to distinguish whether
resource control is performed by firmware or directly by the driver
in linux.

The refactor ensures clear differentiation of resource
management mechanisms, improving maintainability and flexibility
in handling platform-specific configurations.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 78 +++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 4cb959106efa..5e2add1e04d3 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -105,6 +105,8 @@ struct geni_wrapper {
 struct geni_se_desc {
 	unsigned int num_clks;
 	const char * const *clks;
+	int (*geni_se_rsc_init)(struct geni_wrapper *wrapper,
+				const struct geni_se_desc *desc);
 };
 
 static const char * const icc_path_names[] = {"qup-core", "qup-config",
@@ -891,10 +893,44 @@ int geni_icc_disable(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_icc_disable);
 
+static int geni_se_resource_init(struct geni_wrapper *wrapper,
+				 const struct geni_se_desc *desc)
+{
+	struct device *dev = wrapper->dev;
+	int ret;
+	int i;
+
+	wrapper->num_clks = min_t(unsigned int, desc->num_clks, MAX_CLKS);
+
+	for (i = 0; i < wrapper->num_clks; ++i)
+		wrapper->clks[i].id = desc->clks[i];
+
+	ret = of_count_phandle_with_args(dev->of_node, "clocks", "#clock-cells");
+	if (ret < 0) {
+		dev_err(dev, "invalid clocks property at %pOF\n", dev->of_node);
+		return ret;
+	}
+
+	if (ret < wrapper->num_clks) {
+		dev_err(dev, "invalid clocks count at %pOF, expected %d entries\n",
+			dev->of_node, wrapper->num_clks);
+		return -EINVAL;
+	}
+
+	ret = devm_clk_bulk_get(dev, wrapper->num_clks, wrapper->clks);
+	if (ret) {
+		dev_err(dev, "Err getting clks %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int geni_se_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct geni_wrapper *wrapper;
+	const struct geni_se_desc *desc;
 	int ret;
 
 	wrapper = devm_kzalloc(dev, sizeof(*wrapper), GFP_KERNEL);
@@ -906,38 +942,15 @@ static int geni_se_probe(struct platform_device *pdev)
 	if (IS_ERR(wrapper->base))
 		return PTR_ERR(wrapper->base);
 
-	if (!has_acpi_companion(&pdev->dev)) {
-		const struct geni_se_desc *desc;
-		int i;
-
-		desc = device_get_match_data(&pdev->dev);
-		if (!desc)
-			return -EINVAL;
-
-		wrapper->num_clks = min_t(unsigned int, desc->num_clks, MAX_CLKS);
-
-		for (i = 0; i < wrapper->num_clks; ++i)
-			wrapper->clks[i].id = desc->clks[i];
-
-		ret = of_count_phandle_with_args(dev->of_node, "clocks", "#clock-cells");
-		if (ret < 0) {
-			dev_err(dev, "invalid clocks property at %pOF\n", dev->of_node);
-			return ret;
-		}
+	desc = device_get_match_data(&pdev->dev);
 
-		if (ret < wrapper->num_clks) {
-			dev_err(dev, "invalid clocks count at %pOF, expected %d entries\n",
-				dev->of_node, wrapper->num_clks);
+	if (!has_acpi_companion(&pdev->dev) && desc->geni_se_rsc_init) {
+		ret = desc->geni_se_rsc_init(wrapper, desc);
+		if (ret)
 			return -EINVAL;
-		}
-
-		ret = devm_clk_bulk_get(dev, wrapper->num_clks, wrapper->clks);
-		if (ret) {
-			dev_err(dev, "Err getting clks %d\n", ret);
-			return ret;
-		}
 	}
 
+out:
 	dev_set_drvdata(dev, wrapper);
 	dev_dbg(dev, "GENI SE Driver probed\n");
 	return devm_of_platform_populate(dev);
@@ -951,6 +964,13 @@ static const char * const qup_clks[] = {
 static const struct geni_se_desc qup_desc = {
 	.clks = qup_clks,
 	.num_clks = ARRAY_SIZE(qup_clks),
+	.geni_se_rsc_init = geni_se_resource_init,
+};
+
+static const struct geni_se_desc sa8255p_qup_desc = {
+	.clks = NULL,
+	.num_clks = 0,
+	.geni_se_rsc_init = NULL,
 };
 
 static const char * const i2c_master_hub_clks[] = {
@@ -960,11 +980,13 @@ static const char * const i2c_master_hub_clks[] = {
 static const struct geni_se_desc i2c_master_hub_desc = {
 	.clks = i2c_master_hub_clks,
 	.num_clks = ARRAY_SIZE(i2c_master_hub_clks),
+	.geni_se_rsc_init = geni_se_resource_init,
 };
 
 static const struct of_device_id geni_se_dt_match[] = {
 	{ .compatible = "qcom,geni-se-qup", .data = &qup_desc },
 	{ .compatible = "qcom,geni-se-i2c-master-hub", .data = &i2c_master_hub_desc },
+	{ .compatible = "qcom,sa8255p-geni-se-qup", .data = &sa8255p_qup_desc },
 	{}
 };
 MODULE_DEVICE_TABLE(of, geni_se_dt_match);
-- 
2.17.1



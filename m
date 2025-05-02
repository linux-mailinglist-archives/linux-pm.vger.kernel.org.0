Return-Path: <linux-pm+bounces-26534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1251AA6917
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8924661CA
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34E1AAE08;
	Fri,  2 May 2025 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B2dSfHys"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564319E992;
	Fri,  2 May 2025 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155485; cv=none; b=tz1E2giGd0kG0EoqosVbYnn7fLy9pyQKX5kY1gleE95HvQPTMSQYfSG3dcKqoGBh4ngAtv89L9TuMI7oPbwn9d8oNeiz4d139ar8TFjG2P+jYo/RJUNsI1ZxuZkGSvfpKNhX1r0aufUkEUL9H3SGTkRR+GYgkWUiuH4aK8BAf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155485; c=relaxed/simple;
	bh=GP5Dc3P/OcDRwYIk6e6VkYoWGaN6ntMAwC0QkKOcdJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHH9bUiC4EAxpcvKLbrfnD87s6FWLVuGv44qFMWn4KuAqOMLVbQxXvY+OFNL1t/jfKZujDQwMT3xbdKvANwwM36CRDW0bGTfbPUPU2llbqRvpSHSIv8yBo2r9AzIlqbDuaCjmnHyeY9wTb1ArnkGz/cWp4W4d67BaAb6q8jIBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B2dSfHys; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421N27Y009452;
	Fri, 2 May 2025 03:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vVw3dvZ/YhMx9uo/bo7T5hkv
	UJVZMtDQpdlx0inPnnU=; b=B2dSfHyshEnHuX2rn4UZHGOuIeHdDQwA0HMMXHih
	iNheNNI/gKmXccy7oYv5tDvM7fK2/GO7Qawpvs4qcj6yTnBuCpElnQUYpUmycE0k
	6MLvUPnJv1Sbsx82q3LQ9WA1GqNjoGcV9cpF8VsQybCYH65LGgMOrhvgpI1voXVq
	MvpUHMlOWnaVlOWDTHwK0kEbX9baCV/naqeVgH98mHAmbmLYDngrrbEpE7Kyp6AM
	HCwrDeuBoHuH+AzLZuZBlfG7ETHNunDVq2w6Y4ExXsDYpOM9ynZ3UEDpBBWbUMea
	qtXNTupoDBAwcCMIMcCFOcprqENvIpo+6egTTZosQ9+eGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ubq4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423BHtm013804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:17 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:11:10 -0700
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
Subject: [PATCH v3 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
Date: Fri, 2 May 2025 08:40:13 +0530
Message-ID: <20250502031018.1292-5-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250502031018.1292-1-quic_ptalari@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: cPVnZo1xoH9mulNSp6jRrUJi0STSMckE
X-Authority-Analysis: v=2.4 cv=bsxMBFai c=1 sm=1 tr=0 ts=681437d6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=-8ewQQW4l5uToJikuzQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfXwfcOrCI32a35 8lQjhKXrBZtdQXM5g/koZ8Snsa2a5eKaLEBmTE0o5wBKXsB+OKTRJwKRP2ZLxyX3BoJ44u7bAgn f4DPomKaKoInmM1739Xoqg2AgEFVXdyIkPcOLExVrosgu9NItcfLEZ0PBv8Uo9pKjnY8IO+NzqG
 pSi5NftNChVoodChVPr8xXoAqxjePZODbSvHNKxPd6lLsfKgIBqogjBfi36lIFVc2uXusO7H7bh VKrHQx7Y2ikz03biwi7y180hxMi8Z0eE8jdNM2aUWebKaMCRYiiutgKmSMaSH9og+zPhuKXfuIi ybSHldBeyvoRt68KN//4X0P2xEgCcOblomGfQHbb0mKfWqy5//gmFzEqwc04I3hMDxU79rPh4sE
 xN7kW4igo9TX5Kb30Nju2aWxZmdQwaDvRfG3JaDxCg/JLvKdj46aPKl5BttLsFOSIQPtFsQe
X-Proofpoint-ORIG-GUID: cPVnZo1xoH9mulNSp6jRrUJi0STSMckE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

On the sa8255p platform, resources such as clocks,interconnects
and TLMM (GPIO) configurations are managed by firmware.

Introduce a platform data function callback to distinguish whether
resource control is performed by firmware or directly by the driver
in linux.

The refactor ensures clear differentiation of resource
management mechanisms, improving maintainability and flexibility
in handling platform-specific configurations.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

v1 -> v2
- changed datatype of i from int to unsigned int as per comment.
---
 drivers/soc/qcom/qcom-geni-se.c | 77 +++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 4cb959106efa..0e3658b09603 100644
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
+	unsigned int i;
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
@@ -906,36 +942,12 @@ static int geni_se_probe(struct platform_device *pdev)
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
 
 	dev_set_drvdata(dev, wrapper);
@@ -951,6 +963,13 @@ static const char * const qup_clks[] = {
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
@@ -960,11 +979,13 @@ static const char * const i2c_master_hub_clks[] = {
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



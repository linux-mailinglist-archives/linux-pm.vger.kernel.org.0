Return-Path: <linux-pm+bounces-8795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C388D900B67
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342241F242DB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BD19D087;
	Fri,  7 Jun 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDq1TV74"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFF19D076;
	Fri,  7 Jun 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782038; cv=none; b=BLlF/Vt1ycKoOxB2iy+Ixb9h86fsr4Z0sQlny6gHsHdnd0BzF8JUWhpwYeuZzcFMq9zTbufKGOJjZmLqpTV7LnvgyzPuZDe64YeoC7FbFWGpMJT/IaEYiwBt+Rty3DgS1BhQWABSoeu1ruuVPTubYTjK4JioMtH8jg6zmsx15FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782038; c=relaxed/simple;
	bh=epSMVVuXNACAijVWTrM3ArHfYRBpQLqBQbzPpdgO3Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjpXSrvxgLcxPHB/RnmYNh6dIwX7hi0QYWQGUyNmdGfT+ULic5E00tsFqXBoExNgT5L2lm8VqJmpUjB0epaJMUYYY7AILEr2DOkkGp83tsmHjxqkyz+bAYWeU8cJIez2U1jzB+rpHn2dY5DlbCP227e5LQMBvQMthfBhGxjHbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WDq1TV74; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HeUSj019778;
	Fri, 7 Jun 2024 17:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6UlsSXBZh5pTvYqrBUJWqJhX
	gnYP7hCHxrTA0qyIk6c=; b=WDq1TV748rWohgTXNEeAPBc/PWNEDCo/cGIBFHLq
	/zQKzOc6vu1HxFwuTV+30S5GmT6zhb5D5mOCjI0sQW1I0P5Zeb0cOESTdjlz6Tq0
	/PglW5TwH5gfVv87mu2qF8WzXJwUjPid9TO/YMjOP7YuqZhQllbmQ0NsPANV9iw6
	JFCOp3xaSTD5ojSS1rqzE4Egy+os0/P30upZQCUMsimP++W9LdxTijmvQ/i2oevX
	/RRx//H8jG5sJO2M6YmabAxxqYHfFvkfIQ/x02wEf/u44S0EHxt83Wz46NibATYz
	DR7IoLcLgW0A7B6igVVkG9t4Zwv1jWALh4lOsapKKLW4wQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ykg2qk69y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:40:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457HeXsw020629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 17:40:33 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 10:40:28 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS configuration
Date: Fri, 7 Jun 2024 23:09:27 +0530
Message-ID: <20240607173927.26321-5-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240607173927.26321-1-quic_okukatla@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CAg6-UoE0tYABgQQBV5YwsX3GS1BHrbN
X-Proofpoint-ORIG-GUID: CAg6-UoE0tYABgQQBV5YwsX3GS1BHrbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070130

Add clocks which need to be enbaled for configuring
QoS on sc7280.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ba43fba2c551..a3c640d394e9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2130,6 +2130,8 @@
 			reg = <0 0x016e0000 0 0x1c080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -2137,6 +2139,7 @@
 			compatible = "qcom,sc7280-aggre2-noc";
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		mmss_noc: interconnect@1740000 {
-- 
2.17.1



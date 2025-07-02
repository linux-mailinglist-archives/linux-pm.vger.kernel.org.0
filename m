Return-Path: <linux-pm+bounces-29971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60703AF0F63
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 11:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553C31C26DB2
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69855245008;
	Wed,  2 Jul 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I5EujZ8N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB447244677;
	Wed,  2 Jul 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447624; cv=none; b=j8iX1LIDfIoXGn803l9IyV0Pkbi3Ea8HWg/yHuSenGQdppHwAo5fF8ipWHSCPHJq08kmjJJMmcULj5c5fL3UxhuVVy/d0cQKfNcqUyNXbkA1gAfa3IRe+GV5QEG3K3lnqg6i9JlwCjvbB3O1qDCtewmPuAP5pA7r3UC/cWkIcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447624; c=relaxed/simple;
	bh=F9aw+M2A0XOl2cvlq+Dj0zzzF9TuStc3hA0w/gK6pLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eNCe+ouf8Sr2EscsKBkBeqzfO1LxvytvFthxENB7Qz+86FQgUrD+KZClROcHzDr2cYucLMiIkxOnXFnJmy7HGtKqCrZ5kaFUqn80SEFQL5v1zYD2VZ3FNqPcrylboTcy6JiwrmfxtMxoMQ9s2eGFFseF1a7Z8A8YlW3H3r8NthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I5EujZ8N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5622sKuw022911;
	Wed, 2 Jul 2025 09:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfAY1xYh35AyzP143dg0JapGVaCvTDRwPasaJr2uRl8=; b=I5EujZ8NNn675vDN
	c1Mi0PLMmyzsnRaSUVCJZkIYTjEtkmYS8KPygCAxNKE87ErNMO1FdVkO9wWe0Ce0
	aV1dXOP8hOL/4e8fX7LmlSaGaw9tD2WTIqDJun0S6pz+yc7J57/erOXkhya1P5t6
	rXGADROiZQr/4ZkpAGwzpLZy9kM1RhX4sxzPCyRQVPDltbE+/MJpp+jR2CUJZcq9
	HysqMdLTWtRONeW1WOVN1drQL9hEURaMRHdn4Hpb3LBZJjmFFCebHsGpX3kM2plo
	BbNtVxPdKqfs1Yfv32j1/q96qQtuiMjCN6l9FjOfm01e19zzSYo+mXaZh7EIYzWj
	XUEXzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn2n9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 09:13:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5629DbCd025866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 09:13:37 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 02:13:32 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Wed, 2 Jul 2025 14:43:10 +0530
Subject: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NCBTYWx0ZWRfX6QjEFwGmv77Q
 K0zWOUiaBapMDWK0V2Zlz/X5udHF8XnU1Y8y//tYOkkSsk5M3Gt2mdyAaW/8fVOa7InNLnNLP7f
 LeAKgOyzXg3CYNAtVtlSX6OB9hkdt914evIBWvakBRVKct258uDOfFdDj4JoljcwRFSdQY816KY
 H/f+oK/EOH600BvERH2LDvjycpt5u5m5mYAN/f3j/L524lx2ndqnQIaJxLXCVTjprWF4hQXPpGd
 LepdPoPTb8B28ogMwqGyEuixSUdaQ1tRPqfhv1GbTS/AMEiFfXy0L5QPc/Ie5I0laRLGOdIdTig
 H5+cx9b1k4TzBKKj5WLhmtB3W0HCxR7TAvz1oY4yZIGBPX5ceECUqGh0tK5D0+6FhzQB/8ADMEt
 iTGM4BHYxQfPGsQ4ZMU6QjtynCScQS6tH2MTZSW1phZ7LMaupbH9KzkqYixVMdxDERgmgBbX
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=6864f842 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=eX7r7zjc-4eniw70hzgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sdsId31KfSQxs9ir6hZ05bmrLtFQY9kG
X-Proofpoint-GUID: sdsId31KfSQxs9ir6hZ05bmrLtFQY9kG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020074

Add support for video, camera, display and gpu clock controller nodes
for QCS615 platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index bfbb210354922766a03fe05e6d117ea21d118081..5adf409d7ce7226042c759cc83ceca331097ae37 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -3,7 +3,11 @@
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,qcs615-camcc.h>
+#include <dt-bindings/clock/qcom,qcs615-dispcc.h>
 #include <dt-bindings/clock/qcom,qcs615-gcc.h>
+#include <dt-bindings/clock/qcom,qcs615-gpucc.h>
+#include <dt-bindings/clock/qcom,qcs615-videocc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -1506,6 +1510,18 @@ data-pins {
 			};
 		};
 
+		gpucc: clock-controller@5090000 {
+			compatible = "qcom,qcs615-gpucc";
+			reg = <0 0x05090000 0 0x9000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GPLL0>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x06002000 0x0 0x1000>,
@@ -3317,6 +3333,41 @@ gem_noc: interconnect@9680000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,qcs615-videocc";
+			reg = <0 0x0ab00000 0 0x10000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,qcs615-camcc";
+			reg = <0 0x0ad00000 0 0x10000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,qcs615-dispcc";
+			reg = <0 0x0af00000 0 0x20000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,qcs615-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,

-- 
2.34.1



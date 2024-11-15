Return-Path: <linux-pm+bounces-17619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1A9CDCEE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B4E28158E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481721B85E2;
	Fri, 15 Nov 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MWB+gdDk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FF1B4F29;
	Fri, 15 Nov 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667310; cv=none; b=Afpu8Xh0ynr20YAUvxjYQx2x4UxBhI2kKEhUMOHFapOtLyVUAR9183nx9/uLdyoAC4NYu6cupGmY2SqsGBAWKy80NEppTLU+DNq73jmo6dtoLDCoDhEf+Gy3lm6fZxw1YkQl6+S1FsHbTVETm2oZUQcZZ7+auaPssZONtz9cQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667310; c=relaxed/simple;
	bh=QKg4PT+s8IQwqqQLP8q1iBIn0GOIq+jvvv3m4ZqRhCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvpUvVgndNTjlFRvoKUqpxG4jFnXShdIrnd7L1tpmDWWUAE+afZPcxVBqVKbp5jZ/prkP2aZaiFpgetpX/qBOeGPuT3GU6xMFa4pC9OobgxVdjCFTBAEP9MQSZKaKdTvddsb8iUPhRuRrKdIu5AJXxdGChR99NNMGei515XWxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MWB+gdDk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF1itlW018929;
	Fri, 15 Nov 2024 10:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7x5w6Pqh9Lu1uenB2yfz9itGLGikySXBg+qN2n2UdwY=; b=MWB+gdDkfwO7QgBn
	OPRRGq9s7mR1DuBR97HqYOemTYVKKDSbZ76yCf5NPK/cpQ4Y3mEKTz11Di0Vhhen
	+81mP0iNPT0xEmZjdsWh44qgOJLaNkoRMU+SBstqBT9LjmPoq43dNQYPkIg8cjVg
	WSFPQntkZrBffy8fkliIG8qjrFY6vG2NOnxspYGNlkToVumxeMgHfaR5tpT9vBDP
	3Cj3+/CoyVPr+3F/wPdZq56oxOGsojoLwo090dn4tHrCDIKBW65uDvktbwlRxrij
	Y/IFqH9BfozCSByzcUeyFK+Zf3v6zYVIzStRF9SlezT2IFgy+nZNh6DDLVWUEqOU
	DdwzYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wvw2hdmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAf7ZC031308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:07 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:41:02 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 5/7] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Date: Fri, 15 Nov 2024 16:09:55 +0530
Message-ID: <20241115103957.1157495-6-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4eYR_8h4WraZUVk6WWFCsZ--_yAPNuaH
X-Proofpoint-GUID: 4eYR_8h4WraZUVk6WWFCsZ--_yAPNuaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150091

From: Praveenkumar I <quic_ipkumar@quicinc.com>

This patch adds thermal zone nodes for sensors present in
IPQ5332.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V8:
	- Add polling-delay-passive and configure with 100 for passive
	  trip points.

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d643dafe5846..4f37781de86a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -554,4 +554,73 @@ timer {
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	thermal-zones {
+		rfa-0-thermal {
+			thermal-sensors = <&tsens 11>;
+
+			trips {
+				rfa-0-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		rfa-1-thermal {
+			thermal-sensors = <&tsens 12>;
+
+			trips {
+				rfa-1-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		misc-thermal {
+			thermal-sensors = <&tsens 13>;
+
+			trips {
+				misc-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-top-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&tsens 14>;
+
+			trips {
+				cpu-top-critical {
+					temperature = <115000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <105000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			thermal-sensors = <&tsens 15>;
+
+			trips {
+				top-glue-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1



Return-Path: <linux-pm+bounces-19484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FD9F74BE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA01892282
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38AB217735;
	Thu, 19 Dec 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pN3TI9yD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24068217722;
	Thu, 19 Dec 2024 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589776; cv=none; b=dX7D2Qz1SIVKjgevMYE2llSfflItAnjvH1ncEHKmw6YnCHH9flf7Ugw54Vr+jsb36HD/AjMHbO+J/clyKCerBPmCogPd66u1vGGe0HqYzhPjUqFytFxnZfDEVJ8n9CJLRHcdsUw0H98PsUvwjTZJ3b9w0fNrEjJUvoA/ITuGLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589776; c=relaxed/simple;
	bh=TNDN3rYZDhhyfWPmDhp7UZoryPYbeWvHPPfbnOgU2DI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqoM1FkbJbd5d4iPw7PMq7obfw6vw8B8HwemrZ6pRK/R7DDFNGQwWN0FBmdS5OKW9dVdgZ0gh0m6JOows3zdskEkCOxq7c7mCwo05psmgSogmW/gismKhcrJXgsmhrz8Ns4vL94GA0zSNwVEi94UaPflydka162fHPv+w63TZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pN3TI9yD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ27nIb016171;
	Thu, 19 Dec 2024 06:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+7vFpyo33SXPJk6/QBsNxtg4/SWPLEQmxMjWfkYOXk=; b=pN3TI9yDSvrM0nsn
	IwQZga2oIcGNattWps461wJC+AxtDNp4B/n8LYcXOZHqGFSelEL9BgYrGx6VpWgV
	Tkmsgluo7ZFWR7KQfoRGP6i3N5EW7z1BGd6ZGRI3WSNjSO6lN9o3gabBr1/VcDV5
	uh676zQs0WiVNQ3byu3XoAauu4waUz9T0K6HNCXtVaxGXuPW/9T6mc8OrexwayNU
	ixNda4w7rHvgXN8KUaRgcQ1VhkbS6DEHpAwlWHBcnx5xyn99EDQPH7nRFvd7dfzb
	3KxjQiowtltMS4hEjOEhZYy6HPjCTmPOBRjTzZ1uikej8Lz3hMt4ab3nMidzWhcR
	ZhVHWg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43maeagg7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ6TRDb014497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:27 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 22:29:21 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v10 5/7] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Date: Thu, 19 Dec 2024 11:58:37 +0530
Message-ID: <20241219062839.747986-6-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
References: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Oq3jf0ge4c-2Di3PB1E8w1NoKAznXoy0
X-Proofpoint-GUID: Oq3jf0ge4c-2Di3PB1E8w1NoKAznXoy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190050

From: Praveenkumar I <quic_ipkumar@quicinc.com>

This patch adds thermal zone nodes for sensors present in
IPQ5332.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V10:
	- No change

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 4e1668f27d89..3615f2332e3c 100644
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



Return-Path: <linux-pm+bounces-16948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B59BB503
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F831F24CF3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26A1C2DA1;
	Mon,  4 Nov 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fodEZQ99"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB461C232D;
	Mon,  4 Nov 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724325; cv=none; b=KBRCMvZRAkFe/gSnCmwoOZy6DwndrlACZwXrTq3q28xRGaEmwW3hEJMfseqjAjzP01pb2OUhUjFRepm1rSJF74BvLqo8ymGn06KTLav97FPCbDUdWhd9A98sggN8tIOCQrPtCOJnEgz43tMrDEOsW7GH/OWE8Wp9pQEqOwYcYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724325; c=relaxed/simple;
	bh=c8zpg1kvqdmWmALVXHRSpRZnFZDJaWmhLzjmPbasf/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMzIGEhRqfgg3cZq4C1udDdqu+NWrZZwM79cr8heCxvQP2Iyp2UYk1JmZ4aBOge2pwgGD7GNGy/jRpvy32XtI7k+ru8KUW+wHrnFZueg5OC24kq9IIbFfKqDBZEvXRcbqxK44loQFzrvQEGuHWe4xov4wnrqk326Q+eWKyOMxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fodEZQ99; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bu5Iw016904;
	Mon, 4 Nov 2024 12:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOI1XaTXmkjV5JwadZWI39C57wWcIZV+HrrtwRS8nlU=; b=fodEZQ990rNPhpTe
	+T3fjYNFx9NMC2z91tWLbm1KaZDSBnzxHo3L6JfOEY1Px9By1h0L+WyBflwwvwq9
	QSvgI8LzXpzEMGHrpc1wLbKZBdd2z/WVo8W7vbow8Ng2d/swcnjaa8+VbfcILCm/
	0wbMMsxLv16+6y2pkacG3/OJ0vdqS4Jf4mOHK1d7sHwAWRieks5hNix6Q4CvQgV9
	QGzp3OsDSRRosJX3CBAGU1Os6rL3T3tYLqn9lYifnOQ6CM7xgdhTg9GfsbPw1yTA
	ZOe7TKkCTpy6hNWf19ceLE+SJg9XnbQWkkl/CHbeardyrextlqtMoYkThLquXaWK
	/CNn0g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc6v85f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:45:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4CjGxF009510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 12:45:16 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 04:45:11 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
Date: Mon, 4 Nov 2024 18:14:13 +0530
Message-ID: <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fHhLMPi_4YIa6Dl3jH8KOcyoiq1RqguB
X-Proofpoint-GUID: fHhLMPi_4YIa6Dl3jH8KOcyoiq1RqguB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040111

Add thermal zone nodes for sensors present in IPQ5424.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 124 ++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index e97cf6529dd7..568f61c33fb5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -375,4 +375,128 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 14>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <9000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 12>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <9000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 11>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <9000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 13>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <9000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wcss-tile2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				wcss_tile2-critical {
+					temperature = <125000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+			};
+		};
+
+		wcss-tile3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				wcss_tile3-critical {
+					temperature = <125000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 15>;
+
+			trips {
+				top-glue-critical {
+					temperature = <125000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1



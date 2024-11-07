Return-Path: <linux-pm+bounces-17116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043999C0886
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632D5B219D9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FB215003;
	Thu,  7 Nov 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KoSjVZuk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF6212F00;
	Thu,  7 Nov 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988521; cv=none; b=tkmPemeCy8Pz/S9x+TvYNi96VvE+/vOiuzYtP1PYVuT2TQWTnbTObwxOXgigyT7mnvVjiYAUUHoe7kRXlcjSr0G28h/AG+GNt2eNaMTnaiROvOaWvufHcmom4lxIyvK6rR4KYX1Kp2B0ykQT4LS1lnVeL6GqyGIydXK95yqjSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988521; c=relaxed/simple;
	bh=MrT9LUjdURT8Mv9pPmmYRAY9XMyEB3ai/u5G6CsC6Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ7zBOabCwcBXhE2xQvnREUl2xoRdiIf0g3iiAjaL9tgpLkUcE7J2lkDRVjTDBKaHBMFF7KFbzZm76NTJrgEg4nUUm/yPkggPz7Q59Ebmz3m5HdOScBoR3GMt0eXIfftbDmkHHf8L4yMLSxbddXPXsWmwr8g+GbUSgc7UzqdgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KoSjVZuk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7A5Maq015673;
	Thu, 7 Nov 2024 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rtVEbXibB/FVVK3hAyuBQlJuVFFCzLmpxGMvud4FANU=; b=KoSjVZukwwymNpSF
	3WjCxMI1IJhw9bLUFkLLh0eJwavCXZuiAaBA/RSWZZqfOnaLP895cSurnGZUCqvZ
	Ry/WnHX42s/j7v2zjOdF3o4oIwL0IVKkLm13T669BIRAOHkPFdjhmG+eHazu7FwK
	PbpxTralSf30fHFqh98MSX20ITmBVdlQeyKioguQJLQKtDeQjwmpCrFiBMg12Vgc
	l4EueiEz/Hf/tF8Vm7jAgwXtOM2lUyPM0nmXQgBuYLr+zp0c7EE9KTeyTN91vzft
	VFuUZgBQiLHyizh3kJitZpPBynRE/ryArA0Miif/52CN58L3KfP8LuwyQ1tyYNYb
	XuGc7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42q5n8s6fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:06:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7E6kxf011684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 14:06:46 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 06:06:41 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v7 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
Date: Thu, 7 Nov 2024 19:35:50 +0530
Message-ID: <20241107140550.3260859-8-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: nCryNExlKQIaXDRJKzku6gv3za_aBO45
X-Proofpoint-ORIG-GUID: nCryNExlKQIaXDRJKzku6gv3za_aBO45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=959 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070109

Add thermal zone nodes for sensors present in IPQ5424.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V7:
	- Remove polling-delay-passive/polling-delay because the default
	  value is 0. No need to configure explicitly.
	- Remove underscore from node names.

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 110 ++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index e97cf6529dd7..258fccb7badd 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -375,4 +375,114 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
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
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				wcss-tile2-critical {
+					temperature = <125000>;
+					hysteresis = <9000>;
+					type = "critical";
+				};
+			};
+		};
+
+		wcss-tile3-thermal {
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				wcss-tile3-critical {
+					temperature = <125000>;
+					hysteresis = <9000>;
+					type = "critical";
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
+					hysteresis = <9000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1



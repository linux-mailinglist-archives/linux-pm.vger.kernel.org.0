Return-Path: <linux-pm+bounces-11609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A8940199
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8501F22D74
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4E18FC9D;
	Mon, 29 Jul 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oE7zO5Zj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE018FC60;
	Mon, 29 Jul 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294850; cv=none; b=VGJbaoOBMY9Y0KZxs+TN4ORJoJF3F1DW4IWorIexG9102ozgxSlkKHQFHYRxxQneAWCtaZg+1AvEtAswAzekhGmDdNFTaLNfse1Oj4/rRS5WXKg4f9zk/HDQioB63x+rvLq2XsVusXusySocth8W4HyWnSKbl/epHYwrmlhoheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294850; c=relaxed/simple;
	bh=12e1xjcegx5f4OMREZsQegcYLYZQBh9BPuDaphJ7XKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaibSVpqpwFpx8ePWSTyyxhOeQWYp4Rj3117NdIdo3tPjqS/JdalZjYh0O3CochnPkh3Y0dQqYs8gPSjtFT1v1h7BXhsEpUQ8v82aLGERGkWWA9ZyDE2yDddLg8HtaiZg6SHTUsPzpLIWws3cU8ycvVPD4uzLmONfSQJzxQJXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oE7zO5Zj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TN9DJn019227;
	Mon, 29 Jul 2024 23:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/SRNT4lp8eQyk/ak6FoWPPUKEenclu/3WakC6SoWv/4=; b=oE7zO5Zj0c7vxUg/
	Ufknw/1BCBqkAwFk8IY3IrVnIBaB7FFWroiQHyQeIDP6swkSifJJ2+aS2/PkOBaz
	e6zR6ixkatdlyVjju3bZKbtRmT6SBsDTj8TUQKFz0kkYXpH8Lx8QNDC2cB6kdfQb
	BjTWcbdFRtxdA22gWpyvBVL92fhsEyeoub9lSZPgLcLxc2Lzc4Q4R6oZwZBRiFBU
	rOmCETh9F28UcLGqV7xT2jPbUgnjz7BbPn6ShEF4XxEDLEQL7e0YbTiCqtSsbQrR
	tsi9G27yBh6//KD54rIMJIw7v0pKBFKL4GbbCOVn+cl4scVB3IQbg4SDvMAGCR8C
	nvnvUw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40msne5fqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNDfGp003970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:41 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 16:13:41 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>
CC: <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 2/5] dt-bindings: qcom,spmi-temp-alarm: Add compatible for lite temp alarm
Date: Mon, 29 Jul 2024 16:12:56 -0700
Message-ID: <20240729231259.2122976-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729231259.2122976-1-quic_amelende@quicinc.com>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BAiW26roXMI8esIsz8IFHBKQYfVwO8QA
X-Proofpoint-ORIG-GUID: BAiW26roXMI8esIsz8IFHBKQYfVwO8QA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290159

Add compatible "qcom,spmi-temp-alarm-lite" for Temp alarm lite
peripherals. Temp alarm lite peripherals have two stages: warning and
shutdown, and use a pair of registers to configure warning interrupt
threshold temperature and an automatic hardware shutdown threshold
temperature.

When defining thermal zone trips for a temp alarm lite device the first
thermal zone trip is for warning alarm IRQ in HW, the second thermal
zone trip is purely for software to perform a controlled shutdown (no HW
support) and the third thermal zone trip is for automatic hardware
shutdown.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../thermal/qcom,spmi-temp-alarm.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
index f9af88d51c2d..bbf201cad16b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - qcom,spmi-temp-alarm
       - qcom,spmi-temp-alarm-gen2-rev2
+      - qcom,spmi-temp-alarm-lite
 
   reg:
     maxItems: 1
@@ -84,3 +85,46 @@ examples:
             };
         };
     };
+
+  - |
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pm8550b_lite_tz: pm8550b-temp-alarm-lite@c00 {
+            compatible = "qcom,spmi-temp-alarm-lite";
+            reg = <0xc00>;
+            interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
+
+    thermal-zones {
+        pm8550b_lite_temp_alarm: pm8550blite-thermal {
+            polling-delay-passive = <100>;
+            polling-delay = <0>;
+            thermal-sensors = <&pm8550b_lite_tz>;
+
+            trips {
+                pm8550b_lite_trip0: trip0 {
+                    temperature = <125000>;
+                    hysteresis = <0>;
+                    type = "passive";
+                };
+
+                pm8550b_lite_trip1: trip1 {
+                    temperature = <135000>;
+                    hysteresis = <0>;
+                    type = "passive";
+                };
+
+                trip2 {
+                    temperature = <145000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+
+            };
+        };
+    };
-- 
2.34.1



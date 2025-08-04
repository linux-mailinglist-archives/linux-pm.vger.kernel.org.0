Return-Path: <linux-pm+bounces-31871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2BAB1A070
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106523BE583
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CDD255F39;
	Mon,  4 Aug 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XC6NgO1b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BD238C36;
	Mon,  4 Aug 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306474; cv=none; b=SvgwvoyeTxbliVATGWmHUe/PX6TNzyTZK6ZoCA8577fww1Gt5OeUswyHNaQKg9ymW6hVQ5GecjPBYFQdo9ayklbJSMOX/Xtg+Cms76wbA2qVcQYSZJlUZadCYksmoK0+6c73S2pW1ny+45vl3L7Uq84hZEbnAgCw+NMcgLG+dWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306474; c=relaxed/simple;
	bh=1Ti4cpFCGaCudctRyETdxp6JqKR/Ni70Px+xwzBnpH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thQ3/ycnLIiWeNXZqxEU66y7LP5SWaWAb6q/4zhcJutFwFZ36mZAq1Kal6GQKoBcreOC42Tu34342gFYhbpf+obGtooOJmdUvUjC7WRTziwP6Ck75JsCdThoEU322mSrYotkOL0p+nEQkplrJ+Ecw+70Jj2dB2YFarjXf44VtD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XC6NgO1b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748k0ME017513;
	Mon, 4 Aug 2025 11:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zFZ95oETVKwP0lTkzVLburbiiYMFjn8NSKmFLmEWAdA=; b=XC6NgO1bj8iBfJSU
	D2joqZVEdsZ55lx5AbAAhTnX+y8J8woBIXmy/rvVii6RHpFnUkZVyacB6hdd1nHx
	c176obpQu1jkHNC1nN3hUk1lWF6RwyAs1Ds3qAYncPa+YQRRz3D7sk201rFJxPX5
	GuuWZ7M2hOsBDNodlxeuC7NupqQJ6fgNVZeqZ/muWoIXVRBUOqie0ETDlZ4s0lZw
	dvjxROkWRqkmhI+kUj2jX4LaHj6BJWP/DmSlTKhu+3vpWHghRF0fTxb2fTzszrPg
	3SSOlTFGsKkL5ZEt3L00nvBsTwqk4HB0HCiQ0g9cxWUrS4naUMC6b5gQH2K8e3pj
	FNL3ug==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc4nw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:21:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574BL7tZ019710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 11:21:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 4 Aug 2025 04:21:01 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam
	<quic_mdalam@quicinc.com>
Subject: [PATCH v5 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock controller
Date: Mon, 4 Aug 2025 16:50:38 +0530
Message-ID: <20250804112041.845135-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112041.845135-1-quic_varada@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FuPHT7dg3CIENM2clhT04IEYHrL-FW7V
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=689097a3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8
 a=uz76iGCsBMoyf62TQt8A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FuPHT7dg3CIENM2clhT04IEYHrL-FW7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MiBTYWx0ZWRfX1acZSEMOie9+
 30g6Nzfh28ZaYM7VJ5Nkr2ao4iChJaK58LHaGEL/tY+aoVHwkkHGHLBXwXLF9Xi8Jpfrwb4dhdu
 RsxrZ9OyvW2AmF99lMRslMdt0Xoj753ds8n3vzLZLqo0QNmdwIlV7iHIcQXoL5uX1SOuYYJra+n
 azW6GyQ+nEPbgi+7vhPvisxlPajo81Mmtstw3kHWBSCkLIFKDDV87OXgSozoNxYRp7TLnRYpK0f
 W2kLX3+/lGd//un1g8oMxuVDb9URGXcxW+NkGXnNOQNWDowzRZNaXoiTfligRtXmS0n+jLeHrTw
 3H2ffC9SDf94WZUBHqGRQMNtHpfKaGWl776DwXuztZE6r2m9xTI6uOv9eOm5uZeKnG1ZEZX1a/y
 itPT52OPDkDhEcgrvMqbpgEO1SCbJtR1lWS7rGrikavfjyZGsxMKlhL/0SaF8vyaj+Fa7Rwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040062

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
The RCG and PLL have a separate register space from the GCC.
Also the L3 cache has a separate pll and needs to be scaled along
with the CPU.

Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related changes ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Remove previous maintainers
    Change clock@fa80000 to clock-controller@fa80000 in example
    Have one item per line for clocks and clock-names in example

v4: Add self to 'maintainers'
    s/gpll0/clk_ref/ in clock-names
    s/apss-clock/clock/ in example's node name

v2: Add #interconnect-cells to help enable L3 pll as ICC clock
    Add master/slave ids
---
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 63 +++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
 .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
 3 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
new file mode 100644
index 000000000000..0154016075de
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APSS IPQ5424 Clock Controller
+
+maintainers:
+  - Varadarajan Narayanan <quic_varada@quicinc.com>
+
+description:
+  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
+  The RCG and PLL have a separate register space from the GCC.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5424-apss-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the XO clock.
+      - description: Reference to the GPLL0 clock.
+
+  clock-names:
+    items:
+      - const: xo
+      - const: clk_ref
+
+  '#clock-cells':
+    const: 1
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+
+    apss_clk: clock-controller@fa80000 {
+      compatible = "qcom,ipq5424-apss-clk";
+      reg = <0x0fa80000 0x20000>;
+      clocks = <&xo_board>,
+               <&gcc GPLL0>;
+      clock-names = "xo",
+                    "clk_ref";
+      #clock-cells = <1>;
+      #interconnect-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/qcom,apss-ipq.h b/include/dt-bindings/clock/qcom,apss-ipq.h
index 77b6e05492e2..0bb41e5efdef 100644
--- a/include/dt-bindings/clock/qcom,apss-ipq.h
+++ b/include/dt-bindings/clock/qcom,apss-ipq.h
@@ -8,5 +8,11 @@
 
 #define APCS_ALIAS0_CLK_SRC			0
 #define APCS_ALIAS0_CORE_CLK			1
+#define APSS_PLL_EARLY				2
+#define APSS_SILVER_CLK_SRC			3
+#define APSS_SILVER_CORE_CLK			4
+#define L3_PLL					5
+#define L3_CLK_SRC				6
+#define L3_CORE_CLK				7
 
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index a770356112ee..afd7e0683a24 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -21,4 +21,7 @@
 #define MASTER_CNOC_USB			16
 #define SLAVE_CNOC_USB			17
 
+#define MASTER_CPU			0
+#define SLAVE_L3			1
+
 #endif /* INTERCONNECT_QCOM_IPQ5424_H */
-- 
2.34.1



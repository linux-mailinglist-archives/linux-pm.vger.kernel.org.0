Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88562519A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 04:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiKKDZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 22:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiKKDZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 22:25:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F25985A;
        Thu, 10 Nov 2022 19:25:37 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2suI1026558;
        Fri, 11 Nov 2022 03:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xnPkl0UT3Sv6l3LkuZ1/D4ybnzKZVruHKUKBxCpS5ME=;
 b=RzNhS5/BA8m9XSMVQ1ksta8LZNypxW/QgNWWi98Qf5A/Bq7hKL5zoxVfcPHeKEN/ci1a
 notrTNbAJcci6sl35nP3Lf44BEHe4XnnZeXCBq5sLje3jPRAlNNhuyaQAOA37nZTFtrl
 ZvX3DXhtSwXYvyZZ20WQpu85C8fL+sksJzLwD4xZisz9Sep3+A6CnFhvnT2Mw75WkGgg
 xiLceE62/hXrlvUMd99L1s2wg5FVgMcbMx24uxWTKjVftyQSqnwMc0Apy2wO+gJbE6M2
 4IHNj74PNre/j1TrDvw78d1sj2v3s5hRzZkcTVir5UT9Qv/nzD+r4iDUDIcMw9NZ+4GO uQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksa89rg6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PPkU018978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:25 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:24 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/10] arm64: dts: qcom: sc8280xp: Set up L3 scaling
Date:   Thu, 10 Nov 2022 19:25:13 -0800
Message-ID: <20221111032515.3460-9-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tec-_x8BQLDg0C9nM402BpBzZ3NpIG5d
X-Proofpoint-GUID: tec-_x8BQLDg0C9nM402BpBzZ3NpIG5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the L3 interconnect path to all CPUs and define the bandwidth
requirements for all opp entries across sc8280xp and sa8540p.

The values are based on the tables reported by the hardware, distributed
such that each value is the largest value, lower than the cluster
frequency.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/sa8540p.dtsi  | 39 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 51 ++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 8ea2886fbab2..fd36800a7578 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -14,59 +14,81 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(300000 * 32)>;
+		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
+			opp-peak-kBps = <(384000 * 32)>;
 		};
 		opp-499200000 {
 			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(480000 * 32)>;
 		};
 		opp-595200000 {
 			opp-hz = /bits/ 64 <595200000>;
+			opp-peak-kBps = <(576000 * 32)>;
 		};
 		opp-710400000 {
 			opp-hz = /bits/ 64 <710400000>;
+			opp-peak-kBps = <(672000 * 32)>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <(768000 * 32)>;
 		};
 		opp-902400000 {
 			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(864000 * 32)>;
 		};
 		opp-1017600000 {
 			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(960000 * 32)>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(1075200 * 32)>;
 		};
 		opp-1209600000 {
 			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(1171200 * 32)>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1286400 * 32)>;
 		};
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
+			opp-peak-kBps = <(1382400 * 32)>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(1497600 * 32)>;
 		};
 		opp-1670400000 {
 			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(1593600 * 32)>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-1881600000 {
 			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2016000000 {
 			opp-hz = /bits/ 64 <2016000000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2131200000 {
 			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2246400000 {
 			opp-hz = /bits/ 64 <2246400000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 	};
 
@@ -76,54 +98,71 @@
 
 		opp-825600000 {
 			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <(300000 * 32)>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(864000 * 32)>;
 		};
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <(960000 * 32)>;
 		};
 		opp-1171200000 {
 			opp-hz = /bits/ 64 <1171200000>;
+			opp-peak-kBps = <(1171200 * 32)>;
 		};
 		opp-1286400000 {
 			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(1286400 * 32)>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(1382400 * 32)>;
 		};
 		opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <(1593600 * 32)>;
 		};
 		opp-1747200000 {
 			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <(1593600 * 32)>;
 		};
 		opp-1862400000 {
 			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-1977600000 {
 			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2169600000 {
 			opp-hz = /bits/ 64 <2169600000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2284800000 {
 			opp-hz = /bits/ 64 <2284800000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2380800000 {
 			opp-hz = /bits/ 64 <2380800000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2496000000 {
 			opp-hz = /bits/ 64 <2496000000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 		opp-2592000000 {
 			opp-hz = /bits/ 64 <2592000000>;
+			opp-peak-kBps = <(1708800 * 32)>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0e80cdcf6bcf..2ac8f5204905 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -38,66 +39,87 @@
 
 		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(300000 * 32)>;
 		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
+			opp-peak-kBps = <(384000 * 32)>;
 		};
 		opp-499200000 {
 			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(480000 * 32)>;
 		};
 		opp-595200000 {
 			opp-hz = /bits/ 64 <595200000>;
+			opp-peak-kBps = <(576000 * 32)>;
 		};
 		opp-691200000 {
 			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(672000 * 32)>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <(768000 * 32)>;
 		};
 		opp-902400000 {
 			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(864000 * 32)>;
 		};
 		opp-1017600000 {
 			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(960000 * 32)>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(1075200 * 32)>;
 		};
 		opp-1209600000 {
 			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(1171200 * 32)>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1267200 * 32)>;
 		};
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
+			opp-peak-kBps = <(1363200 * 32)>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(1536000 * 32)>;
 		};
 		opp-1670400000 {
 			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(1612800 * 32)>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-1881600000 {
 			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2227200000 {
 			opp-hz = /bits/ 64 <2227200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2342400000 {
 			opp-hz = /bits/ 64 <2342400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2438400000 {
 			opp-hz = /bits/ 64 <2438400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 	};
 
@@ -107,66 +129,87 @@
 
 		opp-825600000 {
 			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <(768000 * 32)>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(864000 * 32)>;
 		};
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <(960000 * 32)>;
 		};
 		opp-1171200000 {
 			opp-hz = /bits/ 64 <1171200000>;
+			opp-peak-kBps = <(1171200 * 32)>;
 		};
 		opp-1286400000 {
 			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(1267200 * 32)>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(1363200 * 32)>;
 		};
 		opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1459200 * 32)>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <(1612800 * 32)>;
 		};
 		opp-1747200000 {
 			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-1862400000 {
 			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-1977600000 {
 			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2169600000 {
 			opp-hz = /bits/ 64 <2169600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2284800000 {
 			opp-hz = /bits/ 64 <2284800000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2496000000 {
 			opp-hz = /bits/ 64 <2496000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2592000000 {
 			opp-hz = /bits/ 64 <2592000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2688000000 {
 			opp-hz = /bits/ 64 <2688000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2803200000 {
 			opp-hz = /bits/ 64 <2803200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2899200000 {
 			opp-hz = /bits/ 64 <2899200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 		opp-2995200000 {
 			opp-hz = /bits/ 64 <2995200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
 		};
 	};
 
@@ -185,6 +228,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -206,6 +250,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -224,6 +269,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -242,6 +288,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -260,6 +307,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -278,6 +326,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -296,6 +345,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -314,6 +364,7 @@
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
-- 
2.17.1


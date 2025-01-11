Return-Path: <linux-pm+bounces-20276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A3A0A4AD
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC16B16B758
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7571B86DC;
	Sat, 11 Jan 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J64ztOrB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772D1AF0C4;
	Sat, 11 Jan 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612119; cv=none; b=dXGEsSznqm2/Tk5GF4ABlrUMk/pOQXHT0pAJbRYT5KlMb4LYZqnW542bCSaqMkNDkdGp9qAWlLCwFZw4iT7VQnRja+XRY4VjiY1a7jXetEcO2GJ1OckCsjN+5fpaEW1AoOoCROx53GJam6RP7SmVUTlf1ln2DJj0anSCyoIfL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612119; c=relaxed/simple;
	bh=m58ZUu+U5WoOnc2WhNOfgkrycbBwdSg3+lcKmWxSiJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US2QkVFCbLzuMwgU+FndFSxoYnCI+bAu7RqWv1DxVdlCs0R98W8FB4iUVbIWjKU920iS4hl8BLBN24V3StoQv74yAUfwMFIwhrneXMS5FftikpVBcofksIUJUV0b+xMcwQkyuANOX30bdv942z1wXw0kKzF7SIyrCIByhqJ/CfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J64ztOrB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50BFKYYB014799;
	Sat, 11 Jan 2025 16:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEU8ccAFRoOn9oGJyphWK0yNLySYV5Zg1SywAKNpopM=; b=J64ztOrBmakFmdw/
	skHVV9GWj62a9c9YMxREy9eO24YMaG9xDQsbtoymlZYHkmDJVTtSvQkVYxzP+vpt
	GtDkDokEbraGwcEmSSfPaz6Ar9+/9BhD1CS+5WbIAkK1vkD3CvtWaeIscHFeh6t6
	Jd1QNSvhm3T2Uyj7B11DXML+Un0Ct6sepSDDn8cypUnr3fHqG9wP8AuyqfrRrXdd
	qnDLwZ1/FhcVSy/3AbymMa22QmGrhGJ9CfFGnYFlSvZvchbbsZrD1RGSivYTnmTw
	egLiqIXWqSj0YdqVaoUm3rM0JStu9ROb4sBCPRNiRVtA5vXJbRBc655aslblR/YQ
	NA0kqg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hx70rft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:15:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50BGFCAf015251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:15:12 GMT
Received: from 4206f847eb12.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 08:15:08 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdptipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: [PATCH V7 5/5] arm64: dts: qcom: sa8775p: Add CPU OPP tables to scale DDR/L3
Date: Sat, 11 Jan 2025 16:14:29 +0000
Message-ID: <20250111161429.51-6-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gNG2wkyMQFomrz_UZBN_3YaO8rWBwYzK
X-Proofpoint-ORIG-GUID: gNG2wkyMQFomrz_UZBN_3YaO8rWBwYzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110138

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Add OPP tables required to scale DDR and L3 per freq-domain
on SA8775P platform.

If a single OPP table is used for both CPU domains, then
_allocate_opp_table() won't be invoked for CPU4 but instead
CPU4 will be added as device under the CPU0 OPP table. Due
to this, dev_pm_opp_of_find_icc_paths() won't be invoked for
CPU4 device and hence CPU4 won't be able to independently scale
it's interconnects. Both CPU0 and CPU4 devices will scale the
same ICC path which can lead to one device overwriting the BW
vote placed by other device. Hence CPU0 and CPU4 require separate
OPP tables to allow independent scaling of DDR and L3 frequencies
for each CPU domain, with the final DDR and L3 frequencies being
an aggregate of both.

Co-developed-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 210 ++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index c6a889d4ddaf..7c52bca958fe 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -49,6 +49,11 @@ cpu0: cpu@0 {
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -71,6 +76,11 @@ cpu1: cpu@100 {
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -88,6 +98,11 @@ cpu2: cpu@200 {
 			next-level-cache = <&l2_2>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 			l2_2: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -105,6 +120,11 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 			l2_3: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -122,6 +142,11 @@ cpu4: cpu@10000 {
 			next-level-cache = <&l2_4>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 			l2_4: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -145,6 +170,11 @@ cpu5: cpu@10100 {
 			next-level-cache = <&l2_5>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 			l2_5: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -162,6 +192,11 @@ cpu6: cpu@10200 {
 			next-level-cache = <&l2_6>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 			l2_6: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -179,6 +214,11 @@ cpu7: cpu@10300 {
 			next-level-cache = <&l2_7>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 			l2_7: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -268,6 +308,176 @@ cluster_sleep_apss_rsc_pc: cluster-sleep-1 {
 		};
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp_1267mhz: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu0_opp_1363mhz: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu0_opp_1459mhz: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu0_opp_1536mhz: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu0_opp_1632mhz: opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_1708mhz: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_1785mhz: opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_1862mhz: opp-1862400000 {
+			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_1939mhz: opp-1939200000 {
+			opp-hz = /bits/ 64 <1939200000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_2016mhz: opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu0_opp_2112mhz: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu0_opp_2188mhz: opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu0_opp_2265mhz: opp-2265600000 {
+			opp-hz = /bits/ 64 <2265600000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu0_opp_2361mhz: opp-2361600000 {
+			opp-hz = /bits/ 64 <2361600000>;
+			opp-peak-kBps = <12787200 51609600>;
+		};
+
+		cpu0_opp_2457mhz: opp-2457600000 {
+			opp-hz = /bits/ 64 <2457600000>;
+			opp-peak-kBps = <12787200 51609600>;
+		};
+
+		cpu0_opp_2553mhz: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			opp-peak-kBps = <12787200 54681600>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp_1267mhz: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu4_opp_1363mhz: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu4_opp_1459mhz: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu4_opp_1536mhz: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <6220800 29491200>;
+		};
+
+		cpu4_opp_1632mhz: opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_1708mhz: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_1785mhz: opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_1862mhz: opp-1862400000 {
+			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_1939mhz: opp-1939200000 {
+			opp-hz = /bits/ 64 <1939200000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_2016mhz: opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-peak-kBps = <6835200 39321600>;
+		};
+
+		cpu4_opp_2112mhz: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu4_opp_2188mhz: opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu4_opp_2265mhz: opp-2265600000 {
+			opp-hz = /bits/ 64 <2265600000>;
+			opp-peak-kBps = <8371200 49766400>;
+		};
+
+		cpu4_opp_2361mhz: opp-2361600000 {
+			opp-hz = /bits/ 64 <2361600000>;
+			opp-peak-kBps = <12787200 51609600>;
+		};
+
+		cpu4_opp_2457mhz: opp-2457600000 {
+			opp-hz = /bits/ 64 <2457600000>;
+			opp-peak-kBps = <12787200 51609600>;
+		};
+
+		cpu4_opp_2553mhz: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			opp-peak-kBps = <12787200 54681600>;
+		};
+	};
+
 	dummy-sink {
 		compatible = "arm,coresight-dummy-sink";
 
-- 
2.39.2



Return-Path: <linux-pm+bounces-9312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261890A996
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DBA1C237C3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0B192B95;
	Mon, 17 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ATOquYO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11D192B89;
	Mon, 17 Jun 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616630; cv=none; b=I+flLY5sty3R0yG13UpUVRwWQnvfqfs6e9Ucen1EV/8Q36+kGfYbucX7XMT6sIKm8UjAZWH6RZhRvqDa8jTEpQlYAVsV3PLiI4J4CW1j6j84ffSRsLceOmGQ5MUWFVzpJi20dBVDJVRg8VJTfcr6WEhNM1nFn+/9tW77Eo1I1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616630; c=relaxed/simple;
	bh=iUCBdlDmmb+nqxTj4dotDfey/IiKx/n1xfkM7M9qntU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmnVtSvVgYCnPAeB9f/5+DHHt/2hnc+i4eAo1HxchCGgVLSanMwWf5DJWtOCpjAcQ/JVgag+jMpTwS+nYBkh6MrBnYVvtqsxBxGMD9IRMR9W4jdMRDDIaht4vCJjEx+i/M8L5cfHWcbrJiRdRjlPmxBF8nJZk2riSxA5lfpE6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ATOquYO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNdmIq010949;
	Mon, 17 Jun 2024 09:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KKp2Tcgz4byEiMIaGTwhjSTwZLE9rDd6TB5GY0oAGiQ=; b=ATOquYO59oVFxAz/
	gn2BYRTpdMc2zQUhc/8seESvatrJfg+A5Z7vJ5AoDvHlA5hFR8wRQUiDbDQqf8/L
	wVzWKHo6kYDeNuBHxnqbsBGo88fsifzTZV7/OMtZbBn9YPq9e57wPU5DRAEzvMna
	drq7j+qc7jceo+G50JZ4x21R/Z+VYWHUXC8DghC9mqV1JbnR0DCFCEhxsm+/BYT+
	IMeHeA4mf/lOd0uKPIxUA0zb2Rj/ZvSzJ73gSPKSuOYIznNHjzvTbFpGy2ITMIaM
	v2vhaa48uzrWm/KXZnOVydEMEbK5r6qGdAMJT+lHb1Pyr/LQFoltl13qYCkISntQ
	ocddfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr38hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:30:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H9U8rJ013883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:30:08 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 02:30:02 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <krzysztof.kozlowski@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [RFC PATCH 2/2] arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
Date: Mon, 17 Jun 2024 17:29:40 +0800
Message-ID: <20240617092940.1724962-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617092940.1724962-1-quic_tengfan@quicinc.com>
References: <20240617092940.1724962-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-GUID: ekKIriM3Su_5dhI88FyXeQJzAWSoxnSV
X-Proofpoint-ORIG-GUID: ekKIriM3Su_5dhI88FyXeQJzAWSoxnSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=810 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170073

Add CPU and LLCC BWMON nodes and their corresponding opp tables for
SA8775p SoC.
SA8775p has two cpu clusters, with each cluster having a set of
CPU-to-LLCC BWMON registers. Consequently, there are two sets of
CPU-to-LLCC registers.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 115 ++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 3808fafd6bec..32dd9fc7c532 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2885,6 +2885,121 @@ serdes1: phy@8902000 {
 			status = "disabled";
 		};
 
+		pmu@9091000 {
+			compatible = "qcom,sa8775p-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x9091000 0x0 0x1000>;
+			interrupts = <GIC_SPI 620 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <762000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <1720000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <2086000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <2601000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <2929000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <5931000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <6515000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <7984000>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <10437000>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <12195000>;
+				};
+			};
+		};
+
+		pmu@90b5400 {
+			compatible = "qcom,sa8775p-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x90b5400 0x0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_cluster0_bwmon_opp_table>;
+
+			cpu_cluster0_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <9155000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <12298000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <14236000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <16265000>;
+				};
+			};
+
+		};
+
+		pmu@90b6400 {
+			compatible = "qcom,sa8775p-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x90b6400 0x0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_cluster1_bwmon_opp_table>;
+
+			cpu_cluster1_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <9155000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <12298000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <14236000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <16265000>;
+				};
+			};
+		};
+
 		llcc: system-cache-controller@9200000 {
 			compatible = "qcom,sa8775p-llcc";
 			reg = <0x0 0x09200000 0x0 0x80000>,
-- 
2.25.1



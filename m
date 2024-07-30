Return-Path: <linux-pm+bounces-11639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10AE94095B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108191C22859
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22B19069B;
	Tue, 30 Jul 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3KxWj+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E319066B;
	Tue, 30 Jul 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323821; cv=none; b=oLCsBs+QoN93zCpCEbnbdV/Q9hOGUw60Nq4/muVxm/2JC0F5/IiW8WUodykh2vtYJWoYIVBtOMk2YyaBXT4A4Tk0pe3apUimm4LkvMLHcVS+ZmEfDwbzWzfNTS/uhYeSMW9pXQITHNpivbdAhDljIvi9yTWcQUESXfOOMBDjf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323821; c=relaxed/simple;
	bh=ckY0KI++QliPAKLF+wAXau6ne+Kz2bpWYz2xGxtLuPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MJ4E6VGw61k/eB1jgaMJdMSv4APqhexrEJoQpg6E6CetIb4XPQGn7zDgWn3tKw6xAvqUJyRou9iieFdjgpZXIHH+dEl5O6fVBFgdC7bwO4/J/wSPBYtazCcNJXQZ9QXHmgySpYg8SEGArTtXQO/oCLhx82llBT6FjFd7NYSrgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3KxWj+6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TNYQLn030809;
	Tue, 30 Jul 2024 07:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aTkSF2hm6dFUAVQJvoYPXgp4YuJ62OWuLA1EJE884NQ=; b=a3KxWj+6wMGrVu3k
	zltMkrCDP6dLuJS9N5+++nvu6ODF75WN00DKG08FKeLQwD7dj3VCjh7F4zV/WX24
	U0MOGH7lE6MGH9qnbSEqt+mPvt8aHKhkOmEkfDua1rGdcMQn2NqpCGzMcMii8EF6
	juH7EKZHjCRc5zIMSV33quqKKxu11ZWDdwWqFHpSPNek1Szqril3dmbqmIIBVqiU
	YdM+QuE9Kx+EucfQ9KIMF3AAyDB1XBMghJcXaVDWSxFE1wWcTvvk+I78mXyzZkpD
	DtL0aplGRZnEKaLcLUY4nYLMkjDPyFyEweNO6YsnwPiqRJCCsRsG0qK4e2PBwbjh
	dDA4Hg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrfxpgcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U7GtjY022028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:55 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 00:16:49 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 30 Jul 2024 15:16:11 +0800
Subject: [PATCH 2/2] arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-add_sa8775p_bwmon-v1-2-f4f878da29ae@quicinc.com>
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
In-Reply-To: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323802; l=2997;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=ckY0KI++QliPAKLF+wAXau6ne+Kz2bpWYz2xGxtLuPU=;
 b=aX4FRYunyydDSMghpRuCETzTAYJChlk8IxaVn7o5j+g9M4MSGWgEhnX/THn9FFJIkAsiixcAz
 v79LuSuRB7OA7wKD31TS73lMYWTfAJAZ+FCyHkgMO5Nf4AB0sJmmIuh
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p1L8RvC8TtR1tslujgODqiALXUuUr_sw
X-Proofpoint-ORIG-GUID: p1L8RvC8TtR1tslujgODqiALXUuUr_sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=851 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300053

Add CPU and LLCC BWMON nodes and their corresponding opp tables for
SA8775p SoC.
SA8775p has two cpu clusters, with each cluster having a set of
CPU-to-LLCC BWMON registers. Consequently, there are two sets of
CPU-to-LLCC registers.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 23f1b2e5e624..de88894a7a0d 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2892,6 +2892,101 @@ serdes1: phy@8902000 {
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
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
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
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
 		llcc: system-cache-controller@9200000 {
 			compatible = "qcom,sa8775p-llcc";
 			reg = <0x0 0x09200000 0x0 0x80000>,

-- 
2.25.1



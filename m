Return-Path: <linux-pm+bounces-29972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C43AF0F6D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B611217A7B8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1529246791;
	Wed,  2 Jul 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h8nAaYmZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271824676D;
	Wed,  2 Jul 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447627; cv=none; b=oLjKQaq4qBhsoMqgzlwMQCbgP8ykRSqCv1Hbjo5v49qfuLnjljg4507uXkco259tO006yzsGdg3W1c8SJpSTdA49vuPvLO0r7D9UN7qC1kjnrHE7Sqm9IUXzzBnHTqYuIKw8PS9FzsiyPSiZV5gqEGeNGfrkNIa0buefTX6OXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447627; c=relaxed/simple;
	bh=3AwoxwJiU9EyGszIQ10pnOCKHNdEHKc8Wtx+KAnYTEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GzLfsnItuiIvx1M6KtfGMKgTSK6J3y2NmJIJq6O3+Ccnuo5ppxHRdyjoaswXeQ1ZTSAUE+D6ET9wEsAXSd5oD6FcRc5zis8FAluTDNCepdtphikQqLWBJXOeyCQLxdtHM31Eg/72irbbhBRXwWW9qmIaB96cLrcwrowJezlAp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h8nAaYmZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5625dk4D018581;
	Wed, 2 Jul 2025 09:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RuDaSPT4WfvGzFOu+WoJ/f0z/7OBazhEeAmX0F1+6nA=; b=h8nAaYmZOL5+ZThn
	hpsWzH8k+cnGG8fRr5Up2hmWBgjbKXnRkacDU2SYiT235nFofKOcozexUzc8WVLD
	795FAJQobNhmIWL4VZCz6WT5u+KzR3yKImGT07cTpHavU7zYAyI240P+3RNvaboj
	XDS5KprShk2fjFMW2lscKcwhpigaaBUFx8AhZSaGV9hQb89WFCXu4rtSAVdkH4gX
	oDdqiUbqMXSnFe2rLpKZr7TMh7bAXX6Ii2o0HMEoYELz4m3DbeNLgUDwW4cFrZB/
	ZxwzLhKxPks5vMhbfzoMPVdyW3fl/zy+UlgJH3eo5nfATjG+fhsHIX0AXuTxoLtW
	4bWTmQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxm1v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 09:13:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5629Dfjg026227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 09:13:41 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 02:13:37 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Wed, 2 Jul 2025 14:43:11 +0530
Subject: [PATCH v5 3/3] arm64: dts: qcom: qcs615: Add CPU scaling clock
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NCBTYWx0ZWRfX61JM86lsVHmW
 sS+fCL8ucm3fGjoEbgsxNpM2q/IeS2zfC3c4J56UclOw05t5lnXG//05SF4Nc8OPIQMqGRhMD48
 NniPQygh1p1k4Lx4NHcoPr/4TcaDQ+MurChGB/v2aKjnEC45jBnHAIYA6fRgU0T27NvHnFNYJq+
 HKkkPYu6T0Vlm6MeNeRKL7SiXeqADtDar064K0k9I+muZ4II9xsE/RR+sTpVzD6gXw0l9K9nHNP
 /lC0pp80fYadqrwCVdjUqgpAF6j+qIRlvPtjdZYPoO/5IRa8OlJwcm08rN9jAIjPevfkQ/ojznD
 cgvQy0lvgV+a3DNH3kw0IcTwqbKN7TSd0WrTYgN7NfubW2TmqvpiUN1tVelz4Yoe49Z3UnurPIx
 zpHHgA0Y56289c2soFs9l04CmveKXsJ+4kHhIyAdeCjahIaJ9GpVoP3WAo4NXz64Cd3faL7O
X-Proofpoint-GUID: b9WIbcxBpW7t0n0RAv8Wkat0xvZVrJLJ
X-Proofpoint-ORIG-GUID: b9WIbcxBpW7t0n0RAv8Wkat0xvZVrJLJ
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6864f846 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=glh6sAxJXOJWtZD9WfkA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020074

Add cpufreq-hw node to support CPU frequency scaling.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index 5adf409d7ce7226042c759cc83ceca331097ae37..142338069a74cc6c263e17d84efa22ccd0c26813 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -36,6 +36,8 @@ cpu0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_0>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			l2_0: l2-cache {
@@ -56,6 +58,8 @@ cpu1: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_100: l2-cache {
 			      compatible = "cache";
@@ -75,6 +79,8 @@ cpu2: cpu@200 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_200>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_200: l2-cache {
 			      compatible = "cache";
@@ -94,6 +100,8 @@ cpu3: cpu@300 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_300>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_300: l2-cache {
 			      compatible = "cache";
@@ -113,6 +121,8 @@ cpu4: cpu@400 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_400>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_400: l2-cache {
 			      compatible = "cache";
@@ -132,6 +142,8 @@ cpu5: cpu@500 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_500>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_500: l2-cache {
 			      compatible = "cache";
@@ -151,6 +163,8 @@ cpu6: cpu@600 {
 			capacity-dmips-mhz = <1740>;
 			dynamic-power-coefficient = <404>;
 			next-level-cache = <&l2_600>;
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 
 			l2_600: l2-cache {
@@ -171,6 +185,8 @@ cpu7: cpu@700 {
 			capacity-dmips-mhz = <1740>;
 			dynamic-power-coefficient = <404>;
 			next-level-cache = <&l2_700>;
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 
 			l2_700: l2-cache {
 			      compatible = "cache";
@@ -3891,6 +3907,19 @@ glink_edge: glink-edge {
 				qcom,remote-pid = <2>;
 			};
 		};
+
+		cpufreq_hw: cpufreq@18323000 {
+			compatible = "qcom,qcs615-cpufreq-hw", "qcom,cpufreq-hw";
+			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
+
 	};
 
 	arch_timer: timer {

-- 
2.34.1



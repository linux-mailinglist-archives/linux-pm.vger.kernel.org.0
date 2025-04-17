Return-Path: <linux-pm+bounces-25653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE655A9237B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2495D8A3822
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833A2550DE;
	Thu, 17 Apr 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ll90lX7t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B22550DA;
	Thu, 17 Apr 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909700; cv=none; b=paflypCcBsN1+zNg+IhJI7wlnJjnjOjFoxmCQX3Ww1/MnYaccK8lrm9i/vYqVdiljx3WBPrh/CLjM87ebzVNP1EUIdNWwfV/FJC5u5qXhVySmy6sbSCRxF6D5RIDn7gZgoDuOprg6y0hkLqfh3W7DZ/Qx/CLg93ToFaJJVr6JM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909700; c=relaxed/simple;
	bh=m3aPf9fEZvWgieEvC2AE8MNhaBWCaX85XrEYnaNqaqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M8E46/iuL0aokaPG5UrRODX6pH5VsCMnHntdvIG+nUBjdsL8a3CLGx1GbZOWdZoJy2ncdscT/IDGxT3g77nKeEiUNb4XCK69xIJtIpvKo96n+MkTPyjFWVO5xHGXC9indwY3YPvDPqv5WAqFUIRxaTSdfeQ7bBEg3202bAv8SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ll90lX7t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HCm4YM030108;
	Thu, 17 Apr 2025 17:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9Wb3BerGiFvqVbiTQ2J4pKV0SFqt/reDrOeADQQ13E=; b=Ll90lX7tVWCAycAJ
	qPO5ow8nKWjE8OvKkBUSKrtAFvvxxMX1ZGtKYETEaRjPbr13r/cRMLRkQkQp4LV3
	fhhVi85Bh433MDOdm1l9SbXjL1YPucp/7TPMvDJszraa2FyD5H00aMA/4apUgOI4
	8mb00y8jRYQE5okrXXGau5MqFWnZDKRU0HdWmcrz6IbTDBFzw/vCKNUWiWoAiI5a
	GpZM5to7M8CNLdfgv1fZb0reTMMpzynNlEMOm7FeYsPU9EMmg7Ga+bzV5kjGYrvR
	YJKl+IUCxj1Q6OyPp2p5KkwJbrXqurZSk0SZWbAbhUHZfmBNh0l3ukobKLI43kLr
	Avb9KQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9fn3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:08:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HH8BRc019457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:08:11 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 10:08:07 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
Date: Thu, 17 Apr 2025 22:37:41 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm4450: Add RPMh power domains
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-sm4450_rpmhpd-v1-3-361846750d3a@quicinc.com>
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
In-Reply-To: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _r5eBLgmYSoKCdr_vdJP8-Co2CF6ETwI
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=6801357c cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=oB8RqyVHaUcM_b3HlZAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _r5eBLgmYSoKCdr_vdJP8-Co2CF6ETwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 mlxscore=0 mlxlogscore=519
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170125

Add device node for RPMh power domains on Qualcomm SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 27453771aa68a1c4dbd2a986af6785fa05db147d..d217d922811e84420f0f31008e939337b07bc38b 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -10,6 +10,8 @@
 #include <dt-bindings/clock/qcom,sm4450-gpucc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -591,6 +593,72 @@ rpmhcc: clock-controller {
 				clocks = <&xo_board>;
 				clock-names = "xo";
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sm4450-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp-16 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp-48 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs_d1: opp-56 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					};
+
+					rpmhpd_opp_low_svs: opp-64 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_low_svs_l1: opp-80 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					};
+
+					rpmhpd_opp_low_svs_l2: opp-96 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L2>;
+					};
+
+					rpmhpd_opp_svs: opp-128 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-192 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_svs_l2: opp-224 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					};
+
+					rpmhpd_opp_nom: opp-256 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp-320 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp-336 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp-384 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp-416 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
 		};
 
 		cpufreq_hw: cpufreq@17d91000 {

-- 
2.25.1



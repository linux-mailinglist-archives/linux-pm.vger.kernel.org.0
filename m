Return-Path: <linux-pm+bounces-15991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6C9A4721
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1531F21E1E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3621205131;
	Fri, 18 Oct 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="btnrocol"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15139757F3;
	Fri, 18 Oct 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280425; cv=none; b=lbK02ordfCO0ifXQRGp0GeTLehVsVHaX9d6pZsN4+8b7BmE+lGZ9CeSLMxAB5iE6SazskQuWtLx2qP2U+tler1Z6QujYDMLACTp/2qv71MCElDOjOQCROc5cs4nNDLlspnnwEymheg8MWqJJ9xINmZCCCM/pZ1uwDVkYe2xRcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280425; c=relaxed/simple;
	bh=h8PQnh8F9i6MkcgRlZaaJYKo+Vsg5LT/gUf2VKZtXdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ShuxkM7z/W94M0VEcIYkMRDPM5kZ7uE3I58Ahpj5PZvj9pspUdSL30oPSXdLbwuFrt9VjgWNgJxIyBjMiqPuD5Um7qERUdhuuah/SRA1RWPRX3HzpvAqwG7ehcg33e4i3SUOL2RHsSbHbe04HmfGwgnhGiiCET3JE7u6R4G6Dx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=btnrocol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFEQSa010053;
	Fri, 18 Oct 2024 19:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sFFmDDAWd1KAkhfjqJBVFcxEijY65eQyMZIWz5ge9lc=; b=btnrocolBL+XoUhH
	J3ZHrZVAVqwgV6BbCSo+qstyXC4ne1WKS8lhElyqrJRjchRFoWgR2Xv+K/yorstB
	YaF/eHO22w/1BhB0yImW/QdNMSmizHdrg9NDP0GVVYufuY3/7A1ACNd5KsCqz7ds
	0eMNXNYRn0s6wYApmN+Zhj6XI8C9GGQKUhQz4KizkhbkrBEaGaI2zhHCcQsH0tq0
	VakjV7dypr82QYZoh9A3GxdqDoy/xDKcbCYYiJ8qhFTWWOq0FMWctav+VAL8Q69O
	wFsDmJBbn8R6Pim+YT1fo/WWRCryoKIL5SFu8z0bYN3p4aQeDx7KM9uBxE1tiEZ0
	r/jsgQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bt540nen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:40:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IJe6ge031171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:40:06 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Oct 2024 12:40:06 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 18 Oct 2024 12:39:49 -0700
Subject: [PATCH v6 4/5] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for
 qcm6490-idp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241018-arm-psci-system_reset2-vendor-reboots-v6-4-50cbe88b0a24@quicinc.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
In-Reply-To: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann
	<arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sVRcoYP55LpI8Bjqso45tluYb4M4ocPx
X-Proofpoint-GUID: sVRcoYP55LpI8Bjqso45tluYb4M4ocPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=786 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180125

Add nodes for the vendor-defined system resets. "bootloader" will cause
device to reboot and stop in the bootloader's fastboot mode. "edl" will
cause device to reboot into "emergency download mode", which permits
loading images via the Firehose protocol.

Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index a0668f767e4b..9c141244a7b2 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -617,6 +617,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reset-types {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3d8410683402..5360d0e51a65 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -850,7 +850,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1



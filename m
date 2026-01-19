Return-Path: <linux-pm+bounces-41134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8348D3B41B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 815B43139BE1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB277363C45;
	Mon, 19 Jan 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lnFO6278";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OmEEjqoA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D632ED2F
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842498; cv=none; b=odUgqcZoi0ryuBV2q6QhA/2ivBnOfZUSZOzTrQhpWfuBAKnfQiJYOzD56JmyBbJnuGpk718VW7ACavlJ1vrB0fecYlrDNcgWlaoUffhLpkvWnUfE1DbF/NYcJN4MwFux05N6ngUi02KWZ7GI0Px8jXgw+mRFMf2AhI/Jg/+OfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842498; c=relaxed/simple;
	bh=eaRJ4q8VTN/kzt6zPUYHhxqL68VERoYaklcKsQPQfl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxJaMdQEqpjboKXdHu7zszR38IKVARyZE0Tz9fHAL+SPUrISLIU3xoFGX0mckmQ1WU54bcWbH9ywfjleqh8njtuHEXw/kSOB3ubvjUN+aIOPUeY9KSNQ+bmjwYUVvLrqjtYs3xwW2qmEN12R2JERogb5+c0YRGcmO/HSOIKqXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lnFO6278; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OmEEjqoA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JH5Pad774045
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=; b=lnFO6278K1RkOmGM
	Nkxef4OxEe2XuXF6buQMK5mxpHnxqQ2ajNOQS3qqCCuHbnXz8PS3pfK0kJZu+X/R
	AC2WJ7odQBgsbfCrOspzUto5kI+c7sHUSXFiYeMTUo8mVSHHXlOMmmfh5PbmZsj6
	Du41NJ1/zAWzbPzZRHxbzFJyr5YD5p4A77MD21ljsM3atu0A3T1SaRGissDV4ZNa
	Fa1KRREVdAIOAUo2gNntBaV2ahDqZ6tq6Jnn1Ai6p/2DPOCboTHQYAEF5GNr5ptV
	r+4P3+pHblD+y5+l5+5qq3+zms0zuSCM5b9ewyO2l1smloVFL3RcFDEaHTJu01SM
	drcdoA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9a9a74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c5e166fb75so1121360285a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842494; x=1769447294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=;
        b=OmEEjqoAP5oYYfVJY4jN41k1csVqLP9OwYCfpPgyUVQRBK77OWwFzAAK71HlAqwQTp
         XAed2RAgJbRE6s+7F3GCtOhsz1Y5/m64i81oJJ+jtmMdmlV+8UZovc4f7EcbMfOc5EGP
         MkgY3YFc53D68iY1ry02LjT4ZIK2Kuh/2i9NY5oD2DE+GaIVNvjegzWiMXKArEIHtGN5
         suWc/5CnfuvIvkFfkcLqoP8lIFUKLb77cKTWhGqgBcCxYDkq9zCJt51/IHgBEZYyi1KA
         yj061lm7bhaYMJ7l8vhY73SYaXn64izJa+cm0R/gKxSsXq196GtuQjF6SvAPmYe/tzoY
         ghEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842494; x=1769447294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=;
        b=OvuSobw0s8W13yhFealNtJ9mYkfAufaiU0MR+YFJb8w9+UVjkCKAJv8J0tfrnEu0/7
         Exe1oyQ54kE/oxdfdiX7DWsLxSz1lxufzCmZzBzl+XQh/4l2prMzxnixeOXJcFsUxvr6
         Gakm9tHzjcXziZQkpvAS0XvPwIzDnbbvHwPMKO5S2NmqIIaRprs3Et46kjkgDWTBBn5u
         vjNiovfxsY3Qo1sMFyBg7stKVznNaSZzJaM7GQc3SIp6DuXkEO0TvjizZ3IGNVspUBva
         DPxLDNgSK2hHNxKa2x64CIk1BbYeJod4UOYLt6EHA5AMr3rHY6eXbjfTg7PwYqsHYoM/
         vMUA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+fbx8ZHaCgbBeqkVeZkIsjnN9uoFf9Fj0jaxZ0el8RCC8JRsT2auyOwiBkibCCmdMNxTWfnoYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4M7Fc8tE6Gz6hV9z7qQIp2GCgJG9R4KS8k2fkeJudTPsWtrx
	xpYOtC1f5+SKqPyER4xJMqKtIKLk6VSuxnsoM3kwwLH2FI5ZEReLxmNRYTgP3fKJg3msAiG8h+X
	nGech2GgRKdVK3hTWJvvZkED9zBDn/V4uDIl0gVEwDhjJsjUfPDheRuSJtL+5hg==
X-Gm-Gg: AY/fxX5CtArGwKEV13cHf6Y++yBJv9cf7Lj+sZnKfaKR23439Ms7Phx1OjU1mlY69Ha
	2+ag9X5IE3mVyuHkq2qVowVWUe5rmc048JZSS+mM5ma7ILkMFMx6QKduS1W8LuEV8gK71hJ8QAO
	YRduhcNYme3XLuJznpsmxXEmJjx2ixeHt+qy/tsIusekAdEbqEadx8oqIY3JFkN6/su8X+uJoyh
	fJiEHgmGmhDuoeZzq0TMgLrU5b5k+zECET/8gk+niKFS9ovC0YPcXdsT9/enfyEtMEnzEF+tWd7
	mLiGWwTIkm2iJUFD9betO197Wk0KXECqy2fBkicqskSFcbtb9eWewyJ7Bw/cM2Qs+xz5EuwNdX9
	SKL/s0ayh85pVSJmxwRFZvF/JEbPAzf45gKFP7FDPocqk77hZ32tU8l9oW2PZtGA+02d0SMc5I/
	RY3YcYvkRQ3dyZDmgYDN8e80k=
X-Received: by 2002:a05:620a:a82:b0:8c6:a706:d1f5 with SMTP id af79cd13be357-8c6a706d216mr1173847685a.9.1768842494258;
        Mon, 19 Jan 2026 09:08:14 -0800 (PST)
X-Received: by 2002:a05:620a:a82:b0:8c6:a706:d1f5 with SMTP id af79cd13be357-8c6a706d216mr1173841685a.9.1768842493637;
        Mon, 19 Jan 2026 09:08:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:08:00 +0200
Subject: [PATCH v3 6/8] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-6-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eaRJ4q8VTN/kzt6zPUYHhxqL68VERoYaklcKsQPQfl4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTu6ERQN/n3s6ZyXfy2h1PRCYgIRstbR/tfH
 I83hjezuYGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7gAKCRCLPIo+Aiko
 1ZCLB/9Uqvx73fSQsnp64ViiGIrTEjmQp5plbPcUl38bJ5ZnfVPbSYr1gDzOGBkSrqMbSX05kLJ
 zJ1nxmGXy6yMw6ap9u0weWRdCyrDv65je/5mmJ0zpLMIP0n50PlvGET6NKe9w0PhqdHISnxVX9z
 N0rMvM/wcCqh4ChDSEjso/x9YxjBifyUUIqya/ymHN9l3SikHu/FBkkkT7f5zdUdJexIMg/f+Ms
 dcf3ZzUVEFWBPoiFb6rMmynrFcoJdqQ3st5nDaaqzEG+EUFIMqNPpDWqCYPe0VE6d6wvq/t0hME
 AQVF4lm+ciXF+gFGwcXFGhrSQxQ4oCTPQ6/ZEyaQp4AK2ryI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 8UVYInLD70dxn1nJ493QKO2ERu6tHqVo
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696e64ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=P7DiqjX0Ympmi5YR3GMA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX0R+zl1phmGzI
 PUp5J+0bPB7A0CS9UCojRvLTj5mXvuWhH+3KshU3z6ldF6hmo6PjEh20hubIZCSLK3FGJB+snA6
 KGscb21FUTdTkzL+w2ZHrOd46Rud/lyMFP1a/ZVGOzwlLkZvecKf11mWEjb0ImSndHYVdoTmNUv
 gQ5NeQHQJH/fm/7OhVQnr0fcT32DYURmaoxBnjBIb2P4ScMyAciEkq66eVYTWfE6tdAp6EJh7kB
 7LkLoZfTXlzlwBb1jSEyC2XFYmZftSz7+3nXObOnIcVwYM1TZYkxwuLAHRCQfEQX4USV75is+Bl
 68MudhJJBdvPfpoEKOBOnol4SK+vZtA+uTo8o1Y5quq/P7xTZCpXE1NwjvoIaXDIwybSy/r0bqn
 WlO3MeNBQq0OCt/uK9lLM5xH8wj+vQ7QxhSCkIwMTiI6acQP5WlzD34+YJA+WmT7W4ENzYMNdjW
 rLbchnKXtUP3OTvXKQg==
X-Proofpoint-GUID: 8UVYInLD70dxn1nJ493QKO2ERu6tHqVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 66 +++++++++++++++++++---
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 74cb29cb7f1a..9e14f53b552e 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -108,6 +108,43 @@ vreg_l10a_1p8: vreg-l10a-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3990-pmu {
+		compatible = "qcom,wcn3990-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l13a_1p8>;
+		vddxo-supply = <&vreg_l9a_1p8>;
+		vddrf-supply = <&vreg_l6a_1p3>;
+		vddch0-supply = <&vreg_l19a_3p3>;
+		vddch1-supply = <&vreg_l8b_3p3>;
+
+		swctrl-gpios = <&pm660_gpios 5 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &adreno_gpu {
@@ -197,10 +234,10 @@ &blsp2_uart1 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_l13a_1p8>;
-		vddxo-supply = <&vreg_l9a_1p8>;
-		vddrf-supply = <&vreg_l6a_1p3>;
-		vddch0-supply = <&vreg_l19a_3p3>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -238,6 +275,16 @@ &pon_resin {
 	linux,code = <KEY_VOLUMEUP>;
 };
 
+&pm660_gpios {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio5";
+		function = "normal";
+
+		input-enable;
+		bias-pull-down;
+	};
+};
+
 &qusb2phy0 {
 	status = "okay";
 
@@ -503,11 +550,14 @@ &usb3_qmpphy {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l9a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l6a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l19a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l8b_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,calibration-variant = "Inforce_IFC6560";
 

-- 
2.47.3



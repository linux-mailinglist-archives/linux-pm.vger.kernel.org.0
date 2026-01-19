Return-Path: <linux-pm+bounces-41132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE10D3B42B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89132309D7CB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3049B32E130;
	Mon, 19 Jan 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nx/2obPU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gGuG3T77"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766732AAA3
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842494; cv=none; b=j5f9V8IWz/FP0BvEymVpoA44PUxNxNpxrf/oGnD3oSwPwSd0Xdd0qc0ZQAkrtzGIPlfw7rFTMT8aB3KywipjpDrs3BylFhHZw5xrBzQT9hKhnyzNjVuqmeQ4p2T+VQbjI1E15aq/Lj9lTAIiuveAsqoPJEeuQ38hWzd9O7bJgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842494; c=relaxed/simple;
	bh=enCKpNdnBrXZA+wiHIdAIv2kSpfxxx9vISm1ccZ1t9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nj72HU/ap0s9qjLHwNWV5U/E5Z3ceew2Y6uLJd7lTgDoY+rOWIVT146VU7RxS1JVZzvl1vA3u+65/djqB+JqlO3emFv7zfTxQKXTF4+m2TlrIAvhE+FHLjZuDL+ysNit3PBtnzmBGjEOSpPNDst7twD5yde4C0vGDris6S3J7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nx/2obPU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gGuG3T77; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDMmi1440845
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=; b=nx/2obPUu9tYKqHU
	+rbwAW2aeKNeBerwL67DGNZoRSyjrI+dmna7UByzpWob6bR79enVJrKrAKfOwYBo
	r1nh4mw+lF3N27XKjUdtWz0iXQAIV7kYLQBmYE1Xc2tyDxXn7uN1TKikK5kppePb
	FA24QR54L5STksjkaDAC84qK9awpp24kYFK7ssPHiE3n4p4eSTxFyzz1xMuYmPyl
	Pv1ZUOx+v6bnYSB+aljz4DnC/v6DEovQRlTLiqJehLlnljhCsnhJoMxwr+WR4KC1
	vddu+RJktX+a0nHeJdynb69o/HQZDGE2jwv1vQrrPGKgD2jJSfYH9BE/7rjel8/w
	Foo7cw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3h0y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52c67f65cso260278285a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842490; x=1769447290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=;
        b=gGuG3T77WlyCz+T5Xm45MvA6yzXMJTZuma0ortE8ujZ1K9mzobEl1ncKzvovlo5yCy
         sRGh0So8NkJG6xFFEsSrgicMSeKfCnilAlrpd9bPBD/dIqbyq+30cVvpB5riiFXydPAa
         PNvkDnPsrxdqa/INQRr3JunJxjEAw0JE5qjjMaKsxPtZSh54IFR8bbSrKLKYuI2EKQ4w
         /SIIUo7vIFdDJ3gOvUxNyVQ9n8pYDu78o1Nlr67Hn4l3sFxAkNVwGA4yhg7xbmI8RVy+
         BYz9NUiufLfJhFmCp7WK4lGXF8X5zUgYSzRYANM45j6AWChdbKQPhGHR9v3LYrf9bFwq
         YAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842490; x=1769447290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=;
        b=Bt1RGgvwZI1jeXMKaLkmyCupZcl9Qb237FWFiR9xiZEAQEFk9iYW+OrAvetJZ7XCBL
         gMnii7jumrLbHTKJp4ZeYRDxXMQNjiuqI0jKtchM6SMx1DcL0JKHw0H2+egGPUxURcZn
         to0mhXkFWYoU3l2ZS9lEFMtrwnVqsg6FyqbxzjLCeEr5gxdFplMhzqQ8M5uaHkBTNcJ1
         7iPyw9knCbE1BUF/IjlxKLChvgx+yav1nLYcL2UD737+WWCHqbpF3dfrLg8vFdl+mosa
         WU+i1nlwxoxYxeCt/JvcYCFLrqNz+i2MDEzEnbwtiYeNHo/jdirNE0yvo16ExncFH3p4
         YMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpT7HJLQg7jFSG1K9AiHlU1jrNtrkohc11/4uMuYT6gCBRFg2WUgVXgtJMdXzonODcev6xtcFlcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+oRzbQjLothy40jBDlgrUObN6PtXaDGYe/O9ZA357w3bmM+K
	/9bDxgq+9xZ6JW8D3t8QuvUsaTiAuO9lJuQ4eo39INH6HF6Q2racTRe1P9GCJ07a1QL8xCKNrwc
	svhe67S6pos8PZqEO47JRd0C9Ui1EWkY/7AnySeBGNjs+O6w96iIOZDz63WsCDg==
X-Gm-Gg: AY/fxX7sIw6ya+Gx1SQHM7tWg8gokwAAi057uyho9aPlWQrII8sjfRq9mvRbp67StCt
	zOaHYH7rCZhax+lx6s3yeNX3lMwtLmhDf5xo5nnD7ruGERsdhRMERxYPr9YDA1jnc3KbMdsH/+j
	6+Una+sp5OHQmfW7ifAS4m2zbHVzS7/8UUDgCW6bkSenc3Ip+oYSnF119gJLwOPcWxw7xj/Dmg+
	5kRChFZJ0YY+2mTPEYBTYGhu7wzFBZagpxHOPO39CujhuL615jB+VpyqLhMMaVVDmUokxG6SVDt
	rlw+oDnHlDOCzuaht+m93x/1wr5Tm5n07SmqxrQNgUqH9Nt1+Ed4op2VUq7rt/ergW2c4JIxxkv
	NSuocMacMymGR58Lsm5gWLOaLzwzHLVSJRjpvPVQ7pD6oT2H3+jCfA4Hdo6daOd9NtAiw2VdycW
	r5/gCmlVJxZhxqoOgFOjrL/YY=
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1569142485a.84.1768842490316;
        Mon, 19 Jan 2026 09:08:10 -0800 (PST)
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1569135785a.84.1768842489685;
        Mon, 19 Jan 2026 09:08:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:58 +0200
Subject: [PATCH v3 4/8] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-4-948df19f5ec2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=enCKpNdnBrXZA+wiHIdAIv2kSpfxxx9vISm1ccZ1t9M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtilwkBClWXXgiyKcWtWRAEl+wOgQ9AElnr
 wN2H+oTvD+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1clcB/0bYfdqHWhPo5vtWeP35++T2K3Q9BRc7oVbgJJPq7w6Q2p4XxDPRwsC1AeWVNb0qyN+eg/
 Q/8e7v89lH3+HAgOS/ujgI2BCddyoFflPbtxvmDrXIUCMcV8tPl/1L1DzpMIdE7mURoIC3hsWsZ
 zsQidYoW/JEicp0mAfr4yQI3vEDiQA7VluDs87xUDOJLmvVtFIDN8Ayzy8T+F9klHdxVnSDPk+X
 WFb5MeuUgA7qVR5CANAJu42J4Lg2WeMs8KPpY6BuWn5imcCd/T63SgntdkGu3qZ43/g7eEgwVw9
 wQ9/2gDn7ksi/y4EjkSYhxVCn/1dPRKtbklYlWzu0IKLGJf8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696e64fb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GWXae9BK5adipm9ZVUoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX09Av1nofRkVN
 zHSSr3hsSm1u9SS7tphAlMju4kYCjvyZ318/BTpVnA3o19kLk/XZVCLspTMO0ivoDGr/01yJ+wV
 PZKQXpjV1ZXG7tOD9ae2xzmOLUWASiUt5Ho+FrTMxazevzyS8UrnWSWLENdTXIgSDqcT0jf5obd
 nE7EyK+OXPvj/fXTdkooXkP91aQM33ijancVmHTY0rt4OaDlSsjGdCLsxAqXBI0S8vJijo9eumS
 Q9VRZyrlpzIZcWfC7Z/xDACqIzfgHLoJRs9Cr+znnmwD8/0AuvTivEX1632ttTV2IBE6wtkdC2i
 zh3PkJ1C1kZOdHx52xcT39lInoVMWw1rrbnqhIX0NAODZTxjbF1+JlI9YSaPBNNM7VCMrPgCVUp
 xJpoiblawe7+Osc25xYAJrFd/pedUUrU/k8BhFzxPCqB/w64bkGl/zXhzQKI6D6n6Fc9ticQQSx
 bqmDYvbXGx1PcV0Ueyg==
X-Proofpoint-ORIG-GUID: DC75ACSI8C7fmQY27Sf4XSvAOyZvTjUe
X-Proofpoint-GUID: DC75ACSI8C7fmQY27Sf4XSvAOyZvTjUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 9814ac4896c5..737794cb8b1c 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -235,6 +235,42 @@ platform {
 			};
 		};
 	};
+
+	wcn3950-pmu {
+		compatible = "qcom,wcn3950-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
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
 
 &cpu_pd0 {
@@ -754,6 +790,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -789,11 +831,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3950-bt";
 
-		vddio-supply = <&pm4125_l15>;
-		vddxo-supply = <&pm4125_l13>;
-		vddrf-supply = <&pm4125_l10>;
-		vddch0-supply = <&pm4125_l22>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -834,10 +875,13 @@ &venus {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
-	vdd-1.8-xo-supply = <&pm4125_l13>;
-	vdd-1.3-rfa-supply = <&pm4125_l10>;
-	vdd-3.3-ch0-supply = <&pm4125_l22>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB1";
 	firmware-name = "qcm2290";
 	status = "okay";

-- 
2.47.3



Return-Path: <linux-pm+bounces-40248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8ABCF6486
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FB7E30131DC
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D803242AD;
	Tue,  6 Jan 2026 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SW/P6xSJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jyy9UDJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDF26CE0A
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661308; cv=none; b=GluMMNDSwDFuYQFWvF8i0ZghM2cwhxHjmls91iSytJT+Ogi/Iz5TaSZHidkWD4BoTd3yFSfYTwMSs500kR4lMzCQ7xPz/3t2OB1Q/6f99IHLwrBjMRxLXLMmLBRE1Qiz6/rFggoPLhfgJCf3zEXbjD05Un/IYkdB+WnFqobxbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661308; c=relaxed/simple;
	bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBOHt05xzSzky4MfO0U3usNUjAUAK1r7JGrhg2alVKg8iQi1s54x6am3P8mdPxfS5tsjay/p4i3DNOEdLCKzqpjsX8NaGm4IJZUkegJVgMplr217tIq4o/foUx3+kByHUv1prGVjYh8BqZhHMBQwGaCSWj7nWSLfbCdMPI/2iFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SW/P6xSJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jyy9UDJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nQrL2528144
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=; b=SW/P6xSJUlMO/1NO
	ZraLhfiNhv4Yx6uqte310eETYjc5RwwEwXrmyl/+/JbwdG8K4VDnTsrkDJ+Ns4Ap
	msBVtI33aOP2jVgapEWGBxM1sKh7ipsuKUwwhKp5B0q+4Tw/TAs+vkavge4kNibM
	GEgidc9Sr1A38p4y/P4IDbNdqcTvlP0G2Gvqb08JwyUHMalXPAP6h1L3YulOMUoJ
	mpLz6ltavU6QR/dQhi8ZRignujAFdEt9wu/GzpZvmv9d2lVjxHZsVok54pREtKJF
	Td6wuAfcOC5WfL1lAV6LwJ8ucF6/XGFTurEk7a/IIwOqmuiOpILTiu+uDsfagosS
	Ia6WhQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus2bfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:45 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9412e67d171so9283095241.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661304; x=1768266104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=Jyy9UDJn2zur+Vwe2sqbFlzs7BbEBNWJrjYM8waI7YQ1nqdVAbeB+bgM9zwMsDE1e0
         uSRq7pKYVEMl8nQSqWbJc4DBzffnroEgTXrkTp1bQ4IZjZI3ua6eSqCAKt18Daqs++6x
         es/u+STjYQxePvrdwDZ4UzKK+mvuUQ4tp/1btTCfxlp4lzaXw7AE1zck/N5eiqDzDHaI
         CeBWfJxxq9Azg8V4IlCi3RF6+J+XNvqUjBfcjVbuWgYWglTtUjYs+tqU7FLd3JYcAv9e
         Y4qxEs6C8k3dNhlStBupZr3eBs4K9MR0y9CuiBfFQdw/CoTjXAN0sJVzrnxxuuGxyJvQ
         2Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661304; x=1768266104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=kdkHVtS6T8DUdxqQOG7euyLrk8QTEOb8FNQm7VcOJm/kgUnrD5S+THx0PtwF9B24XH
         GRIuifQDJV3h9hBlu0LbOQ5sMgiio7E2LQx9Eb90wVBhiDSLvBLitgbxFeppDWJ69Tny
         +iU6dFs9apxmwsUgKqUmfJMew+ji9WvoqiT9Un7spH4835orzyxcflPWwrOSkTfggdOC
         Pa9R+9LL4qHjh4fy2U57NfPkGWT5Mz6awrcxBdN55USbTWAsPrzH66tiW3dQ0sCjlX0m
         4fcprywzuLwi6lJJHWz6NB7sbO8ZKjgLxTKqFgvJnU0FNAeVDXi1Ez/CtYwTM5nCPnLJ
         5rUA==
X-Forwarded-Encrypted: i=1; AJvYcCVLjIS0Camh4TAAtd72hsqSbwiArCaHtfJ/yCq/H7TCSic5t3kRIbYxHhtfJdiaQHXTekTfOuWBQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJLHesYWsrw1+oJWqKA/LOBeF1MOBes3jkMm/NQ4hBaRXTJAo
	u85hBaFM7S/mxrNLqoLefmrU2goeCtvpPEYuG8/1YebWlnfJu7xLmGOwIIDyJi9PdUVZe1yb7Sf
	hOJ72rl6Dm9zWwshc2yWzCghUGIXa1j77zSBcrXwMZAHiOvfqiKvtv3QPQq/Kgw==
X-Gm-Gg: AY/fxX7Uc8Kp6/K9SxuE7UXd/R85GRf6O/rzYEUaZF8K3ZfSZRtfgsqrz/uFA1yeFC8
	p6jT2S9Hd4B5DOKqp8vG0Cc1Dh9ROqhJYbF7hPY7VzAyptnMX5jhiRbne6ib7UTIW0ceJ99X7/g
	IazFWgy6Pr9I4ZSng2eIZf62X2YIdE6+kbJ8jh+drRlv5i/2g7hlM5KDQy+bceadC2WH3n8qaLQ
	Sd0xp8lcUnBoXsJoZGP99ya7lFoMeRkXpKVqvvps5XCIkco8Ww0QxUaUL7FzdMbFIhaGcXmfkeL
	JBsl3tmSkh/a9dUWyn/iAVnRdq+HwhefNyVW6W/OXjwTTRARQfahcq0Ks3ptKFgY3Mnx4AG8+K2
	RFVJXsy4ocBa8OnuRFsQb/RzTPwC7KyvDZdXIaiLNCAruMLGc5tCHUlELysJUw6XPLLYpc4ZNLu
	DYZfhlOYwheTTtqfYRYvdeOfA=
X-Received: by 2002:a05:6102:4a88:b0:5db:e32d:a3ff with SMTP id ada2fe7eead31-5ec75766a1bmr430110137.19.1767661303919;
        Mon, 05 Jan 2026 17:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfv4LR1s42S8DaPU2KbOxpQJdk3q7QsoDukGpuciqtoi4cKuPME3x1EvsMr6Q/jfWAk66FHQ==
X-Received: by 2002:a05:6102:4a88:b0:5db:e32d:a3ff with SMTP id ada2fe7eead31-5ec75766a1bmr430082137.19.1767661303481;
        Mon, 05 Jan 2026 17:01:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:21 +0200
Subject: [PATCH v2 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-11-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7aKvZwOZUhotbdnZ0pAuTyDcOntsWVWsF/p
 InOqexTSXWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1exdCACJMbsoAcCbACN2UqM2AdeEb9CSwAiQD0TbYdLHwQJSWOPJ1UR+RMPcIvsZsOrUFE+bVgq
 I/YMEZUtFCXMwh5g94/WO1C2MOUz0117I7aEYMVltV0WInGaJk2sZZXtQ2fE/cwrf9xHzN90Ecw
 T9zuxT+MsdY5sUrt9fs4NfQU1+e2TR9TXQ6/Kp/Khta6hWAO6DV3bt+ivvaWt8dvIvr69Boe37h
 C9oOupEUCP+oAB+hqOCa8wnWPXdQiEkXQoQrjfBGDQwvA69CRGczeHeN6lQIEt1F9OY8OmuyLwL
 pm7KYr3Uw3zF/N4XpVIkGbw+Wze7EDpv/MKgyIVfxlmHD9qI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: n2MCj1rUj7cTOk8hh1ltuQtpvwUT57sX
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695c5ef9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ib3hs3rZ3KeRbPluJGkA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: n2MCj1rUj7cTOk8hh1ltuQtpvwUT57sX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX3zmSrazecz1q
 Qs5KNuRmykiZkwayIdCw1XpuTx3h22svSHVADNXce7B/tXr+O/7ftrMkQ3+koJse57sxMDPWPD4
 /eoeSaTE7x/HGk4zDgwNOgXPGRtbkHZv869pc8CFP+aBZTQz3JnUPNaQG7spGJp6avJPBsubj0+
 e3lVw8Z5W8bkfzrl3XVNGJeP7MmOS4UZqbm925gHVtsd2UmPn92en/9OPQJw0nq1IChW6b377em
 o7uWMkK+oiSsguQFG+9cbRskNA7hcpIlSsRpbCpwEGAsT2UIkYTPgEiZwwEeSRxXaa95VUWVa1f
 U2J/kUE8GfDe7bMKHmvzjKor7ERW4raZWYFfZAkKIrHgTtgQC6HjWn2k35u70fajXAIm23lp049
 I9u365i5OPSHQIzTs47mmOQFW8M/TorqlBXdSl0u14cJKFK138gdoVHzCqX+vpo68qHpQN2jjvb
 WSi9w7kPHyiVjDHI40w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5f8613150bdd..5ddf448bed8a 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -237,6 +237,42 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l9a_1p8>;
+		vddxo-supply = <&vreg_l16a_1p3>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l23a_3p3>;
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
 
 &gpi_dma0 {
@@ -684,6 +720,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -703,11 +745,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3988-bt";
 
-		vddio-supply = <&vreg_l9a_1p8>;
-		vddxo-supply = <&vreg_l16a_1p3>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l23a_3p3>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -744,10 +785,13 @@ &usb_qmpphy_out {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l8a_0p664>;
-	vdd-1.8-xo-supply = <&vreg_l16a_1p3>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l23a_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB2";
 	firmware-name = "qrb4210";
 

-- 
2.47.3



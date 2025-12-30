Return-Path: <linux-pm+bounces-40074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A7CEAEB5
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C848630CDCD2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A53093AD;
	Tue, 30 Dec 2025 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+ZrkBbE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEHujBj9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E61A9F83
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137790; cv=none; b=JIWvX6kQqqO9QHDgnrliuitqw4GIh2wv15r0wPl9WcdINucoT0Ze7v2ndjMgv1LkGM3nIBlX3epi74bnP4p1rTSy6kawcXDRpSKnad74YhtVC+q8u+J94q077dh0XKcyVY9m2xLzCjTnKtCe0OA79VviSOXIezwvYfaENLqlf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137790; c=relaxed/simple;
	bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTTXAxLrOBy0O6kfLcB4gAfwJf/hZ+/HSS5E6TLyXo6BdUIT90J4wDY47H1uM0Dfdl/jd2dFz+nXZT7iEXcppPmbPJxOs31p1ugzyIx/fmSGnCtBDQDQO1179EP6Qh4MGznrHaDhJzce35RTXBr90mnvno0xUex6Kpem3pKGUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+ZrkBbE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEHujBj9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUB8uoV3971615
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=; b=N+ZrkBbEP+N+sIq3
	WGZOMdQwbh7LAwEZbSKmbkplz3RIKgws0FYwb6W3bAI2+yato/I2yLzxB4V97pfM
	A3UhYZtlUW8Hz3iFJvFlf1SnEc96fuTx7EooWbkNDrdffjof0RcIHjOBtAJ/MhjD
	bhG5S+FaIJOiIf7+4fIyxkFbJIF7SW3UYOpGoZckvgJhbljGEw2r40M/3Oyw9Ot6
	hYPb8NHeBenQpJK59vFyAEo7V1aHA5ltSw323jIm6iXaYisRf9BvIVSDcjC0p8HX
	iYfEoUjBka9+AxQJZrBGHomGeAiKL+DhKbimOZK8oqWs1e3ux4SgmygGlSW0jTUV
	ZW0G+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky1dgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed74ab4172so244242251cf.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137782; x=1767742582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=AEHujBj9lfMaLIxOw8NTnlEsNSgGBGYPS6N6uK741lRR8b+eZRdS3gGfaWl+BiEEqz
         PGYFYCua090nV381gDunp2550zlqKsbUSskxW31/YwgugsV9oA43umszkDtQvli03VTs
         b+gpM3RnzJ3HWTog/LZn+4/Ab9G68nnKy/pvjgmHhGbp1ecfH4Iwqf/ap9iG8YwUg9vR
         6XDjO24oD3Zf8egyFDzGV/Cl/KnoKTgrQN+1nzbXwm7dKzJV2cDPxYfJYa4Vo9YNoNgU
         UctZrmwtxvJlanALPmydGOMcnTgH5CR+L2ixeTpNEoXc4HkDGRIJW6bm7kb8ixpGb4TD
         WRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137782; x=1767742582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=rFKQhUXtnPPZCifPUGj+uBsCTNQsEXvj1CCqr1oVYW77AR6ALVmBr1NqJ/dN1Jf+KB
         FBuhZXEirOwbkppDW+8hbQ84GDGfwRtD7/pL9k4PgCubdZILKf4biJZ2PhhzmTr4OGfS
         QxAvSPSP5QDTZqgnv9+UQPcwIH9pKFjF84i0QrmK0iJVhIz0U9M+QEWvYyf2jIu/Zp6B
         uqvBUAEhvX5zwBpufpaIG8wsRkQGUCRflpq7+TNTcp4DW/f1eqqLRYpwx6alTexh6jd0
         aeK+URiS9DWNDPyCwvaGLIC7JSraNw294u6BtdlTx50nuOHiB5F4y6WtQP5HnX0/M0av
         VsJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTdvOm8btfObsKV0IrkHtTYr9eT4hE1Z6d5WbvQP+glnQW6f+OtdMeFcrUSrjXWOtJHVlyOogfNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4n176tG0yQQVZwR5bw54nPi6De/Ax/K6NTL46B1qjzNLkty8
	RlW/iYoIYgdyyUd1BbSURflzi8J7T6+XzJvKp41K7EjNN4MZMrzyXaCgW98r+aG4z7oOsn9J6Gq
	dCW3c9ZOu1niqhSx+4817rDsZE9iOw2jlyH5kwbSnWgCQQ5b+vzGkJ0m2m3eS/g==
X-Gm-Gg: AY/fxX50zhbBxsSCyd03gW+JvWyRcwmW4H9id+MmxIQ7oapCrn1usc2sYMeofVr53Qy
	0TFCMn1Rv3YQwMSJTybGHZHZOEApPT7Pv+FInRzm9SWZXoY5/ZiCnpSUKv8GzWuMibF9wGx1ph5
	JfpWaemOyhouZ/qBjSIaV00t0sZr89u/ZGtmjjsNX/rVoHgiekjaEl/37U0Tyet0/UGgMVvoUrR
	oibRChSGkCc3iKk6hlbn8Zvn7Bsdc0HgjCDrG9BLJksQdvZz8YT9dksTMA9AWJOOjqQ6UxVzpTS
	u3PbHzqBdfcegwZF84Gnav5Arkgwb0TBDngwNLRnN4J/CZAyCMw75tMe+h4QTQVuaj8kzgdwq/0
	XOPCE923vYY0xvU652xBRcxFYAA+l8S+cNealOOOPaVEyfeSAxblnAaNcSXdZaEYZ0fxG0DTWVN
	duOIoffyLkLWktYhxSdPDrr9E=
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095871cf.56.1767137782328;
        Tue, 30 Dec 2025 15:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkPqMdqJk/XCzk1e8ZyvUBpUaurMVX1soNXULfyOp66jtSt+yb9md0PSgAOZm8YQ0qjDZn3g==
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095691cf.56.1767137781889;
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:02 +0200
Subject: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlCjUGMHlkqkJafwLhwLJykGktOCOjkpAY9
 wWwhzlyFAqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1ZqOB/9GU2/Bf/2GNGunBAoAKZe+gB1ID8NoQrA09/9ZRauuaoMy+dCCtYIDBM3vRl2CFb28OcA
 pgDJEoOPyMzCEfV1gSMyuD7P7rD/eHJ2v5lclrEGHrFBeR0ki/EalU6nNTUWWN5ygcKYM//UJXd
 v8QqOiqJ8Ztktem3BId5LhT4sVp6BsXNVwpJmGyqjjRbqL23k5ccCrYi27el/uzDpcWDkUscilk
 vt2LS8i70uf65bXCvZdd8rCTUojWi/nIwwpAxYRYUcDUb6bRbNO5co2pu3jppvt0AQtvI3mzjsR
 bNWBuTR3ETPU/KTXh3R5hBqGJsBQnFzb/Jz3Mspfy7Z6S74E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX1tFNaQXFAdxf
 +LOyH92iBUJGGCNzx1AckO0syIxLWRMOOtEOnG1wW0LDn+5dBzmXdfYq1eBNDiKtPdODahny6t7
 V8SlVFR7O00b9jxSMrAUloy56A7lxSeFi9TehgODhmhxNZiev7K76++yAfbtCiqgZFBimSyaU5q
 POy3pFw6iU8osy4cQHh1T0atPnrTxrdVsQBocbdc1M8cM8NR/oG35n67hCD2IgegiUa85gm7kBi
 y8A/pnf7aK6UgbqlEDMQMd5b7PVpF0Mtx5LUvBuItE5+Yi2cOMZxQ9QlpJfH6ePvs6XDz1DvHAt
 MrvN2Ei9LEwLRNs54sTHMJIvJ8MwwivUS7pE2nxyXhhMHVdQvR1/08GGuiF96rIYY3bZ4PnxMwF
 P8g92H1EMlkYcoywwJaTVP64JqhFCwa5rKKM20KCrHaYfCLKh/GFH0SknOBOe+w1u0b8G8OH63T
 psp9uTO3UefVaPK7ehQ==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=695461f7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AhE6NyMZFPWiW_N_LacA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: GtwOsaZvk3LLb97pX-Ur8uayj_vyzkRr
X-Proofpoint-ORIG-GUID: GtwOsaZvk3LLb97pX-Ur8uayj_vyzkRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 66 +++++++++++++++++++---
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 74cb29cb7f1a..b4ea79cbcb3f 100644
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
+		vddrfa1p3-supply = <&vreg_l6a_1p3>;
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



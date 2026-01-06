Return-Path: <linux-pm+bounces-40247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24714CF6402
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707EE304AE69
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1B31B81B;
	Tue,  6 Jan 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsQ90LZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgQC/slc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1027F756
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661305; cv=none; b=Uw2hGkI/E1wxEvxL1Wgys8ObDqhDhFZJI0hPTSEQE4nTfjxUEilQfU2E0lICoOXx/2V2qiqxdSdMXzGyoV8OvfnY3vbZZzyA+Xa1aiDTAhJZ7Kd193rSZisJfmKQl0TdQQEpqi60gngyVFlXibBiw5nkz+eBSRWWw+pI7rDxJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661305; c=relaxed/simple;
	bh=OJr4yv9vJmkaC7saidnllHnC/2Dn/uant8yGpklrbes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rG3gzSoz6GWFuFx8+mwFzhes6lFr9zvCjhu9CnexbbPG1FXrIKe2IUqio0QLYWqRjnwBWtQsPx4+ffzpNBpbXvXdzhsqL5YTv+FxL5jOoRPFHZu8pGVOU6Q2pgXyo1+8yMlgaIj5aKgn47fDwLn8NeRas9eh/YmdX80Q8zbnOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsQ90LZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgQC/slc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nFxi2745455
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=; b=NsQ90LZWElNYoObw
	wyUFxyuvLOYFFv37MI27GJcR8wHbhww4Z0SaUMjwzeUKVcQW7MPiAi6mbjuikA2+
	kkurrsp83Cgcgln8Bi08M8sNRpDhX0K5ygbhikAaonTdVRwiubgNG+T2JDzRm1nm
	ks8KnPm/BN0wh3kSpERGi29QwHCHFz4cPJiPe+BYEtF/rTA17HyjyjPoce4PKJ1/
	mK94ijHaV4Ct9pfhNChNGaXTzXnqauqQjnWAAHBDb/eK1ML1CpSfMipP7rLw5S2U
	/B67lkAxn+Cd+fHlPhm4jpoyWQic+aiGTJVPeLpJFgy5d5iBvi3rv2gi5DVSMwxm
	OoIJWA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgg9yscgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so8952301cf.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661301; x=1768266101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=;
        b=SgQC/slc90GS1NPzUw4WP2WFfMF5/TLruwhiggoqgN4hA745YofLuwfv+LCqlgocVI
         lSCsBBm9uMiNHUkqilV0/iSs5X07sBi3VtHltyriv5b8GlwraKEaHHdO2zYo+IXsUErC
         7Mz32YaYCTmkeKY9rSygEh8NSdmD1Eh2bUnWXjsc5+7eQfODGv+qWPIjMwfF/S0Rbx+y
         YH7jB/VAjUpO4rfKRxEIncnEHt3QbxVJ4pWnFtCG3zo/RLv8306+EZ921sJHeIlq5/je
         G9MwwB9cn40hi2Zr3+9QQes5f/184gmocSicaM1lO5mMwbVq7KsKTuj93rHapMNgd1vO
         3LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661301; x=1768266101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=;
        b=vQiIXz9VRR5cFfjUOBWZor/k8JmepUJJezZvVp/ip5QhwA7uPlnKhYWPFH9c8sBWFN
         5aJtwv7KUqZKfSXMTqDeGX3GQaGG547ARedoZ9oFjIfrpahrGLQRFgx+UsLxydK3FHGn
         uNbBFqPA6yYlVYtbZBYwpdiOQkN4RzZi6H8YqDGKBtpmu3DRGZh4yqOfbQoYpcjjVoc9
         /yo/VXLwFK9wiH1IQCHqT8syHCdof+gqvZZTJqIb01xxgXS3K3ZK4g0bUxNXfCng4StK
         lq9m3CXPZzQezeuF3mZYBOLBACSSl5nugfAzM+HpJwo8uOQTK1YT4gWnfvERT4jMDRrS
         hLqA==
X-Forwarded-Encrypted: i=1; AJvYcCVzxcbDQEs86bupzc42pKGUd8wrhbEUnOJbsu6NwF2/hD36hoRQ5WPqSceEuM/V1u3NrU8BCktiVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Sh7/nYe/wpE8ofUX0K6iLTRb+RwYXbo+K3XS5IaWV2oX8KvN
	zhqzfni01RjT5vA/OerTaKK3GeNg6WmWhRSvJNjaZIjEkJKbZm/IX1fRPChpBgs7MEMbfYq3Td5
	gHYQAAtlBJJN/cABOwRnV0LUVPpk14w4+huIaUNRB7W0zs71V2H/3fLCOQjOFng==
X-Gm-Gg: AY/fxX7jljTeNPuY/dhftD3GBx/NCO2nVvw6Ja28mBU5nHwwUbikN5K7763SUklgPfw
	M2zBcn30bw+ELLRWQyGEOkhUhnpfV7eiYXwADxr2RoiSPbzyHCRdr85TAzWdpEfkmx7rO/aJReE
	MDQcZd/rLGvYQMqzy5P/aEcIeUdnXpCzLnLXMi3He9ryRoduo1oAs8rXAbxO2DJgG3lndCggKaM
	f88tfOQTTuaNhI4YrsFRd6YuR/un7h8cjzFeUPXbw8GdaJ/fC3qlyxMT+XpP/+nj5lkmy8WsCkv
	eoJCILUlSEXpXBOLgeucl8ILMZqWouLGaazgeYwf2BeFb6HEJDCnhZfFkUMrste6moDMnLv+lUp
	PJF+PDVb3PSh/p+1QOaIaPAroiiCB/K8Ia4pljVQufg6OOO8JRaNPgSzhIBBN6IEuljZaJE8zdA
	hT0a3HsSrnQsC2gUH3JN2f4+o=
X-Received: by 2002:a05:622a:4209:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4ffa77ba644mr18752211cf.40.1767661300714;
        Mon, 05 Jan 2026 17:01:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoefOZDx2zHfaoSVi9LoeU8tZQ/pUprtXoEP2cNM6nYtY1N/LLfnxX03xQAdXCwp2mIo1UCg==
X-Received: by 2002:a05:622a:4209:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4ffa77ba644mr18751491cf.40.1767661300149;
        Mon, 05 Jan 2026 17:01:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:20 +0200
Subject: [PATCH v2 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-10-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=OJr4yv9vJmkaC7saidnllHnC/2Dn/uant8yGpklrbes=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7a+AuXommsi+raf46ccQEIGL4H6RNRglLRB
 hETuM60QFyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1fbbB/wIur9WgLQAj85cFpCSRdmxky4RhlzO8L0F8FRtkGWU7Hfoh8M0yUWaC7FWbxm19Mc/Xha
 evzPI7A185XhJyAoZrKnTv2BVHxvrCn7i934dNXuexINmWVreXQE0enMQcEfPxex7E3BBFTSKGm
 g6oAxG6XLrRgvrP0Q+nnnyzqYvLkWElaiNzJLWT9kRKoLQUrHC89MCvYcoImPXE4Wg7xYTCpDQx
 37sVCDRuqsh659+tl0mhcrs2b3ckKwBruy1InqhrDRXnKNUZqueFSDQAZHDaKvlcSiSI/9Ju4vE
 Gev0U3ks6+2HxWLpww5yPid4KWZouTSfKxNGvuYjdzgnTBD5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=M89A6iws c=1 sm=1 tr=0 ts=695c5ef5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wL7gHOWyGnUXpuUc2qQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfXyT1wGGdDoxXL
 F41e8GhRlQmttAUH5zI7LLzLT5/HKtzm0hMJsiQ96lzGlQb6vJ+KnXfLz8w03TyJ94jkW2P/6UW
 VVmOIDmO9KB3nmm2OcNc5KbzuB352+YHFaqUOGorter3krJd+pyaq/ITiyy0YG40flWcKXZyDFC
 fHtcJP8SeZY40G/EKkrdr0ToiDcU2WdTkkkJN/LqrLxUU7ewv2aBCfDo1p6PL7hrp/OuMrq0otr
 pMv4UJIrk+94Tq4H3JS6ILj6QH5PcF0AkiFfD+H50xIHPh8jI3jzUnyAJT2zHp2EiDPcaaIe2d6
 l9dRSB2LOioteQWgKTQFPqzpGhxmPgSCFMdAjCQRE86lFP6QDprE7zkDeI0J5RzuejPDjpj4D9q
 c0kjJnW/B1khna8/c/VrCvMKkbEl/5SSAxW3A2X61E5CMH+7lqILbmErYXlxPwD8NOPRdw/FOiL
 V6RNaVLZIqvc2k064OA==
X-Proofpoint-ORIG-GUID: P9IFLVEjvFqnrMwn-StU_toABIxV-6A-
X-Proofpoint-GUID: P9IFLVEjvFqnrMwn-StU_toABIxV-6A-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 1b9ca957a94b..6fa2288b709c 100644
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
@@ -679,6 +715,12 @@ lt9611_irq_pin: lt9611-irq-state {
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
@@ -714,11 +756,10 @@ &uart3 {
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
@@ -759,10 +800,13 @@ &venus {
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



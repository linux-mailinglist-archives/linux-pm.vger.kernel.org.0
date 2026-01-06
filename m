Return-Path: <linux-pm+bounces-40249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EDCF6347
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58AC2300EBA1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5513254B0;
	Tue,  6 Jan 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pit6LujA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VK945KUf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C27322B67
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661310; cv=none; b=myva3JcbeFpJdYc4x+dqdcVoEcAqNxx+59+4k9ZCgUc5MxtF5YJnPxaeynAlEAQoMoAXg6KvFyyU4p1lrWopUnvd6cbJ2DxRCyxaoxP5+rwkaATL4y9ySV27zFRKhbg4n6uRQjpuKd562PVpwRCzDIZLHrlwnTZTPibVNV8xntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661310; c=relaxed/simple;
	bh=eaRJ4q8VTN/kzt6zPUYHhxqL68VERoYaklcKsQPQfl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJjx5dHbhZr9uwFzBoj5TrB+Wn0P7Xaj4VluWSu/PRbSCjUlnCQWKyBMO9YGbfzTkjuGyEHxTkEN9oX2FHRUgXe0TIzMh5Ir/f4Ez6oF3XiuyBwqOEBNy+deKdCBUjPIuVb2KKEThMk1Y2nsTlfG8L+zL9N/SHpgYenDV89V0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pit6LujA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VK945KUf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nD513114790
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=; b=pit6LujAer/2ESuy
	Zimq/qezG5k/2oy/c2vSCk5BYMvSBqT1+mKtdKXx1YQ0qGavnhL3Lzqu9a5gqBWH
	xRxtZl/aWaWwEXer8iyVaeVvAIsVlo+xNZ2YmVNOEZ0pQrP4uWWJ3KRHsAIapzfl
	VOpYtO48EErtPjhn3Vq4JYM/Elhouxn9dq+pD0m5Yo+xJA57jMzq2H27UvzjoCXq
	yFGjlv9kuwK7FpYWt+nwDLbcNb26PpMoXJOTxLL5npSbmR3qg0s6NTOZHcMEPx7k
	TkljoJIGfl2qfuFHf2MmXtC7RtplW8hViiC3S2L6UH5WFZ22EcVl92lrHwkcZV/G
	6zk0/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh8gyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed7591799eso10198281cf.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661306; x=1768266106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=;
        b=VK945KUfjkmmtQSXP6WUfR0iBOT+Dv3ekOB3cucZmC8a//PSa8RN+2y1NB2kcTfF/h
         y+ce+30rQYP/OYbv0FI3x4K+hjjfOTZMgURbOah27oKm6lPgeIB+wozkE6bGd79KiamN
         UZWrhMyr/NUs8WAMXdu6jrrsPJpI/4g0OBaIPtCwhNLM/PDL3smrZucw5YpV5m262ulU
         /5EP4iLjvirzC4JfK+OD8Hq171lqZ73n5ei0k2plbvRZEIE97P9uXB59+hEPjaoCmwmO
         gsRVjDtyWYva7co9JucA8Rsbn4ZHS7FoHHOWIPviljUbEGopg39aBBDNRAgAc1uVWAZM
         dZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661306; x=1768266106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNtdH/g1thI0zFb36R8TFQlQFWMJol5ad0xi+noohvM=;
        b=rm3kNFgkxYWu33LDbKSUJzrArezO2UHiQ9zQ4voJjE6udDJ2/U0iDwVMqXsa17mzsF
         KbMZ18X66AIURg+YdyWYUvyHmjr/II0aGfizgRwKXi4BqX5jEydwuvNRAIAEwjvh8gtL
         ZX0/AQQ+FSNluLio7fMLeWsKK1d1xng+xeWhzTPhkiAJX4lNM0YURVq9P1MExeb8RyrO
         67+x4hTpXzsCYKcQQ7o92Q5lu/F2eyVJ8koMUAaA1fTm+B3cbUkt5lOFqAEQt0y7ELFo
         bFeT3GAhkrvQud9Mh0JHDtHSebeXuG+6IF+WfbjCZYNvI8gs2Ht4gbm/L8z3ds9ndZ5K
         jVXg==
X-Forwarded-Encrypted: i=1; AJvYcCUSYt8Cnpz/78Z9BdVeeED8PNq+ZcfdxVwmk+PXnrh8bMxhpg93extwStL7QKId7cl53VzrM6Y3uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3z592PLuws8SymRt48afb7WsMohXppBOQnWJ3xap6huQPr24
	RNpl1QHZhbQMN3G+iymPiVA6Pkud9WhaIdsUbiC2zAwcpKAZRxYZjM6XDm2U+bferkmYl8FwNKa
	iUaaw8IGuRyq46N/IZLOhz0O4AJtj8Kf38oS74liHKDi6VDyyQiIfmNimFq2QQA==
X-Gm-Gg: AY/fxX7vN5xJG/ytvn2h5vx3bxrMNQMsJ7TEWL4k3KaZ7yHDblvV2lxY7r5nJ1bO3o/
	h0AXV+yIG92HxnieXQaMyVEI0lg5t2NdlWveCmxyD3Pai+ea/VdqFZ8vab+Y2ftm3eb7HCJJ6AY
	8zrNYEUB199SXxwzL9PjreylljayrCWXbdTfczPqsvBOi+PdNWFfqMnQczNkXDbqJG58tbtpv16
	3AlSnL99dJ8nBjQ/hlVCW5Rixy9nAq4QinVNboeZWdVNvzKSB+WMmKHjO49M29X+l2gDliejYbS
	Mu9PdCdgqQLAdldmN+nZhafZLyMytBh8su6+aB1JHFkLDOCT4Co50mb8Y3tD/ffKE0fCeY9OoNB
	aBhwWd9MhQ9cDUPOlVf0lVgeNVtsFAhfr5PwM1I4PnFJe5E38eFfUyt3mYQhMcFzk78UKzJJ2+S
	vaxZjMggt1kFRI9OOwxY+oLIQ=
X-Received: by 2002:ac8:6909:0:b0:4e8:838d:1992 with SMTP id d75a77b69052e-4ffa77f6357mr18671791cf.63.1767661306315;
        Mon, 05 Jan 2026 17:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiJ9YV7hLVUzOsZzbREsApzq5gkYftRNiosFkV9YRWQP5LVzLU8YVPsodno6kDXyTy61UaKw==
X-Received: by 2002:ac8:6909:0:b0:4e8:838d:1992 with SMTP id d75a77b69052e-4ffa77f6357mr18671321cf.63.1767661305866;
        Mon, 05 Jan 2026 17:01:45 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:22 +0200
Subject: [PATCH v2 12/14] arm64: dts: qcom: sda660-ifc6560: describe
 WiFi/BT properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-12-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eaRJ4q8VTN/kzt6zPUYHhxqL68VERoYaklcKsQPQfl4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2ZM3K0MiyyWZQoyrySdVlyoFD21l23p3v8HbONupM9O2
 byYcfb9TkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMxL6P/X/17wWbfdJWzRC9
 krjia+byE8LWm5wfaISwldw55BeXEcQWFq4e+sgrdZLg0zzB5+KMZq/XClpm59t5VogKLbhX4D4
 rzdhE1N2B55rpLpspSiXcbcv/+fRMdnggY3O2v3dtyewZ7Uf3J3dLVZ1++oij5IGPFmtD6sKgcz
 tXiLx9uTCSLeXB9JzSnkRP7ZpqlmZ+/hmPTSbcZnu67ZyxxUXj0/lqAfJLHUJ7ZM8y3++8+i7Gs
 EnPQ+Bib35eaNcEkem+zhvlLPo/m8w58SGwvdP/zlLWn/+Vfp4/8FA8LikgyGlVe6iZt8mND7mC
 fMyLTZXWLO9+8OruR5dlEb4tDqVLQuPO1tSI2u2o3HwJAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: hsdkoqJyDC1Aghj_TA3867vv8Pvtl-PT
X-Proofpoint-ORIG-GUID: hsdkoqJyDC1Aghj_TA3867vv8Pvtl-PT
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695c5efb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=P7DiqjX0Ympmi5YR3GMA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX8kNpMF2ZEdkP
 EuyGsRW8gXGjz77SkweC0873VHR8IAW7jIB580ugnOYMHX253WeOxql0eS9yW01Ru0InVrRnk7n
 YuWBQqHxXH7v9mbankZo0JHU0qglEEPmQ9dQzGBp8Y3ZF5gFbvQUK91TQsJcWJ75/4vH+gDqyWB
 t5lax8EB2mMfmS55PRtQ8U/HFRcgp/ollshC4ArBhbnmRPy9TrPYAhTVBL3XBNPNZBtmPVKwJD6
 TDkxV2pocVuL+EG8E5lsqz+t+l9wFULjt21Ekn+zQfcc0r0R219v7QBR/2yS3sxKN5qBybncqlf
 MnEuYHFkyr4yeUUDCMzKCaZ5uiglTyoJnxU9GJjkFASdxLCx15kdFjozbQy/n0R3T8iAwt5eZGJ
 5K3LvGoZp0r7jfRjfR2aSdAwvlaUKB0lupxxP0vamwCHyxOcA0fcnSgKBTBruFQz7mJY3buHpiH
 r7/0CCIt6y/7grrtw8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

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



Return-Path: <linux-pm+bounces-40072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FACEAEA9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E6D730305BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928BF325702;
	Tue, 30 Dec 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhUesqf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FmUsyB+/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B53090FD
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137788; cv=none; b=E6992XP3BTfMbBuEO/WnsLFqrpjugXQNe+UmghqxQr5zy08XwKHBBblfV+uEpVj9CSDS8HDpNzpXHTgq4tPrv+1Yi5Zax3eEQnw4nMS7QjQogTe+Y7aADHjoJQcAjk4XdUFLTjZshVf9ojQ8fFDLDuhtz56LgUOQY3hpZQfBsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137788; c=relaxed/simple;
	bh=Xfiwra//zLSvKDun2ZbDRx+n9EwUzSsdsyZ+5gdIsp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DbwkFJjRcIIpbGlmDsV/Awy3/5XQAyIvaD693LFayCW73LtIL4Dmj+B6NgEZgP6MW1CFAimKKkLMkzijku+u9g46VUpNMOo/HMhwouVvrg/BqTOXWIC7WnCOBRUDSSQ9Kl5o4vSOLDSzX4g539TXEQ5JtDB+26CBFx6riME2V2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhUesqf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FmUsyB+/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNPUMb1319052
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=; b=ZhUesqf18kpP6RJX
	FKWWrYwjgZYsqsoYdnLQwUFgjDnjQIN7uMyAEoS0bVugV8KrAlpGoz5pGP19m351
	UEesBZvChNm+2qvoASvon+BEtahJPPfGN3m2S80u4W6d+f4ix+F+yz8V9hV7Holh
	3pvVw8XASEifxXEsCq3Vkjbv0UT09pFuIDM/aDF1jzRfYlB4bi/uH5wW51Olk2mx
	MGp/Bph5N1nF1ikWJexqsVfcQLFT4aIARJicf9UWWtU90i1Z9PnZ1851h6/J3BTw
	YkS5QKYyHtVWxFBVVRg7lYvSeu7qTKDhbNrZoXY3NzneMiNNr0c/nVoQhAFUVz3x
	NVdEDg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk1cd0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74e6c468so149237601cf.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137781; x=1767742581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=;
        b=FmUsyB+/NY78L3UlaTOGBti0LyncPBrHMM9o64yIvG2WyPGTdhBjkumhFfnbFniqLJ
         wCNFGFsxiAZ5uCBHUsiPKxmMRfWyy0GP2ePbW6ADkDvD/Br2UtvOFwp7uUwkpZrylvx/
         foI5mlY4uLGV/ls47udrvYxE/wlnejSlymk+P58w94+jYlojkddLtf6IqhNGsamRecXD
         QcsQATnzfAtBv+wwVSxasmib6jetTZgTl5PAExRS/JCRrwym12OQVLldobzMEwFx6i1n
         f1cncbA7pBuswQpO/l2OS33JMoir4LCGJeLeu3Kw3wUat4cM3D8aLoXJAJGLtAazD8Zi
         Ry2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137781; x=1767742581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=;
        b=CgUSWW1QdPgAQp3rXSx7Vfj6CBNFmifXjORjsUEHKa7ZPVTomaZZ9PijQIJMRRaVNZ
         y1HIeF0AjeScJEBy5LYqZYWW02+SrdA7bcnKG8LVIbhDFuaM5XhiqmTvtrrNnHrQIMsw
         rxh3tAStwv3tkxrwqJMW71kKM0JFfl9ZCn84mTphLotRcZ0ypfov/RV+PoLpw0wo6owB
         D8vTtklYiLfrzSP4YMLKeXQFvJNIjGl8iZ0OWuUwrgwOdo/res4zIEiaD8qOj7Am17bM
         6Ex8W3xXMtfRaxHD4/tdunhbKyGmCQYgesKVhEN5FmVU684e3HKy7bN2jEKo+5flZdYs
         BbCw==
X-Forwarded-Encrypted: i=1; AJvYcCX6sxLY1e9AlX9DNmLQzU0oYMgyHqKqXf8uLPbvUbACU8L+hz7lnel/H6JECgDfaHzlRUtPbLrsTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzceENMw+kNNOjHU4ST+JsSRnF2GqMjioHTFP4Agmgky9ACaAqL
	xgMEneX4mQYevykgJZlL4PnfZTeeFFA4kk/Lv0xMhijNkA6PwiU7HZ54sA7iAZf3INLkl2WMTHC
	lhe3XSFLPDljbYzo7v3r25VzevADvR8n83rzA/uLI3UaFUNOg8GUVl/ycMOaWFA==
X-Gm-Gg: AY/fxX4iP5eRvkzZ5kwOfzVtBaHe5qY2zJTDTsuJiKAcB5oPAOj0EHqLk3blJGBDAga
	CAT0eegK/zIwDiYSsBp4qAnvwh+0aEA2UtIda8W4KzcfK8f/pOWYpzUee8hcammpFd4Qi795SV3
	YJf9/zR4kNhyIEo4DdVmanVM1t4Q2l9BrmHBP4Hzf98WnoRZS6vj9p8/PZRB3g2rqUZowmx0Qo7
	tWa8LjXZFZxvzMwMUnw82v04uG1JF7AgETZBOi0hWyM3noTC2Qd/1c25tzMC4GmD60C3SRnP9mg
	IBMv4bf/exrQaJI5CePXOOJjGRVbLUS1x6PhnKWyr8qkt/Bov3v7cU1uYEWT2XBmI7x/zD0hmQ8
	yd8VVCWiqHTXG4G1qwWVIH4b8jBXqB4tBkOR46OLXA12Vv16Wc5Qn+xX4h0DZTFbzhLHoOBj89Q
	VDYFE6LEuvs1164y4gR2l5EuA=
X-Received: by 2002:a05:622a:1b92:b0:4ee:2423:d532 with SMTP id d75a77b69052e-4f4abce0824mr471951651cf.28.1767137781171;
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx/SYKuZWVg57DqMXeIylTkSzC4dXks9ZscJcuTRysFCAH78JLjOMFVgFClApXqQcqLSoAjQ==
X-Received: by 2002:a05:622a:1b92:b0:4ee:2423:d532 with SMTP id d75a77b69052e-4f4abce0824mr471951381cf.28.1767137780699;
        Tue, 30 Dec 2025 15:36:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:01 +0200
Subject: [PATCH 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xfiwra//zLSvKDun2ZbDRx+n9EwUzSsdsyZ+5gdIsp4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlGtsBv/9u+UkjlXRjLdVpGDSUR9SL9e9SH
 TaganuTQ7+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1XQWB/0XGu4TFjAPBxjm8May0y5wOWD4HhP5IIrTPX8z3aPGnm6dR+Hk2JqDPX/llzbukU2zTMV
 ho3//Ab4h+brBn78kjakUfsTrbAuxWSVZd1YJSlEBIkuGim6mtlWo9nXGQk4QHw/f+fr2PWX3zH
 xj3kPBL25JL/xT1Y0+ZjBkbdJ7bBP5ggnhL2ZkbdZK0hnakyAQ6N/8/6K5EkTyw0zNd43EsUCHT
 sI4aFpAvNaHo/fKFq4yGdkusN/Tw16gpvqyMQf7FksQFDemRgh45OfSCdjzgRG9bebGDHfNxnjn
 9z1v2JIY48eB1zv2IJm+3bzIdmAeC/D29seb3xbnPcfxLHMm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: LVsRu_wEPMCNKlg4jwFqoRVazdm_WdEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfXyZxgZjPZEQYz
 QN3TmuSoHalq8wqnGFrLRMhAQcbiqj0lmaorauuSE/VDJnUpNVoxdTXKrO7btbRJ+U0iN8M3A0C
 0RGgRCt6oGdV/d4rwydqkbrvi6itJ7aP7bL16BqgdZf1GlbbEASGlmwxoUAADaPyFz7LSmJHfcb
 mAFkpKXBTVuc9ZTv2TfQSr3qanoSgcytoFJ6+4g5kAvvro18pY0AA8r3D0E4qSlsAuU3eBg9pCQ
 YqIYq0Bjj1dMA0MKJomnt9BbsI5y7FfqOiW3qno8J7pRFyf9NG20hiW5zhM0loXyDMlVwdKn3I3
 L13H7zOHM61oN6otN3AVKpRNEE5j4qYUf3K8BdTTmhEE9mfANgfzKvQQtbypUqN0V019owRmqb/
 lcyDh4xQF+8l6sltmMYOcoRmz27tK5qMcxNc5B9q7H7nvPdtl+ksg2UwN2cHqhqXfRdlLDZgXD4
 5GBP1Fi9ScFSMJZ0qyw==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=695461f6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xd9rXx9432pcEdfSjoQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: LVsRu_wEPMCNKlg4jwFqoRVazdm_WdEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5f8613150bdd..4e1b189dc9d7 100644
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
+		vddrfa1p3-supply = <&vreg_l17a_1p3>;
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



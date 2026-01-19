Return-Path: <linux-pm+bounces-41135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D37D3B48B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D2A63040832
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD03876D7;
	Mon, 19 Jan 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJAWDcSP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O4xb5tQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433635CBDA
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842500; cv=none; b=IIiv2QoOQlPeObVItdFlB2M/bof/JZZHkTyQueGOJK45fTuTmxRRJRCRqhUy4iO4vhjA/7BZAXDj8ObOwNHRHDywivAReUlEAzgsQxvsMF1PYYh4Lq52SVRWtXx5hSqlgflv87Jaax9ndzODuqHAsh59pKZVQ6JFVyRXfNpOc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842500; c=relaxed/simple;
	bh=/u1tgrZtHEkSxPcf5pHX7xHPoerlKHblqpNDjU74XrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzBQEYje1KAi0boaNaHUf1TJIXJBdPhe37nrKIo8QPJ8eBWYudPxs8imi/RarpWb1Brev+2jtzNxGu1Uur9zXQGFajxPNgGY+VpatrRAx9429N5eTzCe2c+MNpCZRyYj3J6KI0uj6KnhEWFxhrVhEydPJcj7PPuLJlwJfuaIrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJAWDcSP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O4xb5tQu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JAJs4c1531404
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=; b=mJAWDcSPVvMbswGt
	9C3qxlm63ZGT2CtB4oFWcYLadgbi4fd+6QFeUJF8za0RK5ALE7JTXZsZPLTlbmWy
	7R/ZcOzfzLS2X+I6GKBhB99rbFwyAHDzrGrrL8QUbltblGh0QBrl8ON5sltNPRbm
	MAiGBB75fG8j+6RPyzQpfEXWrJL8AnJ7rjYj0urxK43RqzGnzg23Dgceux2KWuR8
	X3bHqDnPyAnQVqyb/aBIcKaczJ3FY6ulu0BNADjGPldIPiDfXAKzBqfHmYX9bJR6
	PbGTVYMXfdulVX19gWLmmegxpYXrPsQ3yJZOSfX6bUEYmn8liBh0wY19Q3ldh1Bp
	XfcvmA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjrxs5fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5311864d9so959468385a.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842496; x=1769447296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=;
        b=O4xb5tQurSeZWvCPP9PP/xVYO2yF5jaXq1Cz6WPwukcgJbcwraK4Dobav1KJ1vdTeb
         p0DwOasmIMZV9SQfHWq1iavhQ1uqWs9AYdmFyU78q64o2S95pjN+stATs8PGwg+20JKd
         tYPMf0mTQiEAi/SGtjiL4hdH1HaaaRLW/peG3shuopIKGRVUv7X4aLaavLi7RRfroCTu
         YzjBbllBQjZOEAYWRUxGla/oyIoRe6AnrYtJnsDCinJac73a8FMMEESICdGBY5biYSDc
         IEJg+B7d1Hc/WrPzRfyBBu4pDhN7VKo2BJdD4kNvaEApQJ9nOAnOOcs6CSXfUNt9JPsH
         haMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842496; x=1769447296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=;
        b=eXqi9dOzrTBqHHRVx6zB980Te5YYKII7Bvpu/Uoug4FWAHqzQc6EVtcTw/Mf6n6UnI
         WlWw3/CdHT0Ubw53B+TSa7rZvFlYWq4SvcfggDPl6USflT37J2amIyVNUNoiwr9ZudPp
         9Q/5s0w75dIrXCiRrN0tNZed7P/e/jFPUn0OuXCnDvGxu/dTeC2z3n4W9xDZvOs9lG2T
         IIBq2/RIY/w11HynFmiVgbAZpYdBRjspedztxYdzoUuCsqH4trSHyOpnkw91npQme6mP
         ymA6991u5tQvMD7wWjRsH+JzDUvcdc7o4WwIjzi9MpMTMZ65ujlP5d7jWObVNfDRC1e/
         /vyw==
X-Forwarded-Encrypted: i=1; AJvYcCVZhzkJbX+xpeo+oxKFhqoEiRLcFzDgGmNRMZZxxWRPDiSGl/P8zMw1KE1O2GN66uYQkV27Gw3nnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzshsS6NCpwDkepd8z6rcLgqyMWfj42uE7fqQYSSA5TK5pS2kCI
	4pkjKWGxMncSsswaRAaDI6HqHqxxxKSfkBC5sfE/3zBQ/DOTH/hTlVURa3iljL3iTZ3vC/v1KQ2
	WEM8VAx8S4eL3sDdoPkU2C4PB0WdJTFJS4Whk6g9S4WKHR6JFPan9vonqOeEpQg==
X-Gm-Gg: AY/fxX42bGPKnqaSOl8W30gxtsGEJbpYoj+9Sk6DKYHZJKynmi/xWe1F8+jECZjG5HL
	DYkJRY2XGTwWVgoDCpQsKn05u2WzLomMfVrzq3YltZG2/owS8SJpt2VbHniy0VTtwNB0QxeUwOW
	Pk/tY7xCHCrZ/YdVWixQZgYIevDvZlvUEs68TY2FSBFEp9tp1KhPcfSte7SwfPujTx5nBZJH0tr
	BP5ViwZJmosSfFxGSjmJfdTRBRZYTSjy0MrldfbYgeeC8Ml1J/62qVbPdj7QnO8kU3Lh3GQxwM0
	+ZMuXSGffLCqdjISDPPFEI38aQsBcch0jG9Ur5AjMwQDQsfP6AuuSnRFxLFyGfMQKg2/13M16gT
	xE+h7S/acErnz8brmkEI+MR1aHIG5Wu7Dq9mDGoWwL+8W3eawa3hjm7XupkA64FfVFkODywpvpe
	YNdiNW2dXKKXtrj9EMfju7GVU=
X-Received: by 2002:a05:620a:1911:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8c6a6770665mr1565236085a.53.1768842495708;
        Mon, 19 Jan 2026 09:08:15 -0800 (PST)
X-Received: by 2002:a05:620a:1911:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8c6a6770665mr1565230585a.53.1768842495144;
        Mon, 19 Jan 2026 09:08:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:08:01 +0200
Subject: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/u1tgrZtHEkSxPcf5pHX7xHPoerlKHblqpNDjU74XrE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2Zeyrvai64H5MzO2b+cn7kmzHZCmFXannyuk74fDY1N5
 f7Z7RfoZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEjH6z/69LY9Ht26i7Wa22
 j0ns3lmu2L6+lCplXq0Yo2+dnkJXhAST3t/P+Ztl7B8p+vyIZ+H7/yyXu0Wi4vvTrt0vzUnrdai
 trv+gV3IvR9FUQeDAhqVSjhw6fVJLSw3/K2vc/HEo8w3js5OsP25MCviRdkJz0dmtLS2BZ6163L
 7kbp7GYJUfHXlx9RInl8zPDHHSEi1LT7AalSVwLdk7dUe2JrPsbqWjSTnZJzbu2mS7dMqLdXarG
 nT7/+tsVayRCWb4+zqiqIOd8bm3udNpW8sra+zzOA4x381kjrIoDzc8fV9OcXJh0HW+J1klaz97
 3GtT9D7aM3/3eWEL0RW+gt1rSnpzrU+e+nrtX79kjhgA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfXw9Ar1Mdx3wzd
 PlgFa4Ol/ryQLFYAlSoCCJjgDuh8CP7J5RmaMwHBUzlmyAIogKMlqQyNTvtbznk/JREAKDEaVgk
 gh0bBxyABNICdGNpLD7u/RGcJr5a9d1gGQ7DFIvLFH6A6ZsxzJ5Lf1T55GliUHIfcXUSry5HwIM
 GYFDPGpxlXiYjvQicRXtrrOTZ/xT6XJaGXiilK6o+Q+Mb9kg/IpyCU0gyddAiea3jlwHXxbEsju
 Fc2PLP5mOGfDW/ex8SWSRkioP7wkewRfxBeOyRNZ2Fl5EJBdeuJpfKosGrpXGTsGsqlh4jvBP66
 wTHxkAUsgRZ4l9aMBAXFx/omIK9hpU8rj2ZQR3Qty+/yCNI/tqP396MmErvLx/8AxTIIOqcvCQY
 96k8HIjX8cBNb/XcT2SvkcDb0sYt2B2p2l8CDbhxmaJKDldn4cmjJQoeT0NJcaGE22aze4lVVNu
 zXFHYJBQXOHod3TER+Q==
X-Proofpoint-GUID: W6H57m4hHWuBLl6Zj-CBPmfw7S3I8oct
X-Authority-Analysis: v=2.4 cv=PPUCOPqC c=1 sm=1 tr=0 ts=696e6501 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=urIVL_JefrS1cr2SfK8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: W6H57m4hHWuBLl6Zj-CBPmfw7S3I8oct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190143

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 69 +++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 5118b776a9bb..02416812b6a7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -276,6 +276,43 @@ vph_pwr: vph-pwr-regulator {
 
 		vin-supply = <&vbat_som>;
 	};
+
+	wcn3990-pmu {
+		compatible = "qcom,wcn3990-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		vddch1-supply = <&vreg_l23a_3p3>;
+
+		swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
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
 
 &adsp_pas {
@@ -659,6 +696,14 @@ cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio3";
+		function = "normal";
+
+		input-enable;
+		bias-pull-down;
+	};
+
 	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
@@ -1038,10 +1083,11 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+
 		max-speed = <3200000>;
 	};
 };
@@ -1155,16 +1201,19 @@ right_spkr: speaker@0,2 {
 };
 
 &wifi {
-	status = "okay";
-
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 	qcom,calibration-variant = "Thundercomm_DB845C";
+
+	status = "okay";
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */

-- 
2.47.3



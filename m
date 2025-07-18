Return-Path: <linux-pm+bounces-31067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DAB0A850
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BC0188EB94
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569942DCF66;
	Fri, 18 Jul 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dna9LmBx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DA2951CE
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855618; cv=none; b=LW1ZoINoaKr6i0tt7fwySmKUP/mrR5cUnKAccMrBFMk1ScEPPQae0OMnXn+RnthpCCI4yipwUfkhCWCFBc5rAMyA/c8Ls4CyXMgb+gAwRBw5gqSLN7+qjHKfbTfUbJE9+D0QAYoZq+dTpmgmwta6Ew626IVyGclxi/6hEGKVCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855618; c=relaxed/simple;
	bh=J9J5s3ZT8qppRfzTVRn+3+0mDOD8laySW8Eg2GginiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtL9XomjumvuVsu9BvX6w3mIMS6DrDXcOv1mha2cIFstg5+fo68dcA0QkjG6q9VIMoHaeZHlF29U6eZWBpKBTF6XpB8GsDKopEQIxz5c1Mq/I7DgT6dpn29/IWQhOzEPKh0wqwE3TzOM/RfKjKKS2sufBdQayg3lhLSGVwWkOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dna9LmBx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAWI8U015953
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZCzwxr7iMtuP14zekGihLh8lesU3QR6bkF8d5rNiDCg=; b=Dna9LmBx27bFYz+Q
	W2UG31YR5KVjHRho8ThR5+3r/6QAim7RNsNUk7LeXxmLJK0IShB/bnuWYgbiryLc
	AGSxvMNI62d8IxbRKIQQqcsD1QDfNY+yx0ooiRBiMKSp1lXDOXpBa+O0Gr3g4N4y
	45OYvUYONv5oKa6kv+9/z5PM60y8NXTAlv7m1IVBCN8KKuS4va0K0DSMMdNYTyFV
	XP2A7kG63VY6cBHluZm4VGWcePrYRXKQvcPVk873Pk6cDVHSIwLnuZ4QrKiXa96w
	JTYM4D8rr54IwfpTqvzjJuV34G38hLUv5Kq+Gi2L4OSPh7J7SeBhlBoTOStA3UsY
	0yHRMg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc44cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:15 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-41b916dca69so1031387b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855614; x=1753460414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCzwxr7iMtuP14zekGihLh8lesU3QR6bkF8d5rNiDCg=;
        b=UVIA3lKCqMv1HPLA9prjPA24QS5M0bfIgGtvjtsxLOFeURxhUN4WNlHMWN1SxYuJ3x
         NHtIdn5qEkozAJHkpAu2TvRrluP6K+XRA1MmkagJk9HmGJjkdN8Ssp6HafxsCTFZq2oi
         bIqEFsdVzIjyD6V2ZljqLtt3XvcmusL+RRAQx6Ui13KX158W9rwAhkQohuDQ/y9w65OS
         9xw6Wc7Q0zOAG9mHKc5pWhobDEMIOGdfF5ew+VJxgBAokhX1NRcxklViahEdK/jEkhtT
         Eml7bTK3rZI1EjUs5vwDoQX3sVH7lqFFEcdyBPWh9mNwqfDXCMbDRzeZRwRE3qH7mQDj
         FcSw==
X-Forwarded-Encrypted: i=1; AJvYcCU+MckSTXceluCexePnA7FJdiNyPTxfpUeaFR+E8dmuQRTeP129fVqTtYntgOtN04ohCflNLtwu1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0lpBkvXL4O99AHgJgjaQXOicn2ODAhuDBaql1eokRFgZhJan
	p4A15Mq7vj4n2MU3ZVDL3kwIAp2ilevFggml8wbx/qDhq7VWFZlG2nReWVLUnNW7cjy1gP2hF7M
	LCfRM3UhyJgp+Qex5SP3JMsPVoujihl33gvbsy0EUCq6cRBQxGRJE0kwzscihbRuw4tSLTA==
X-Gm-Gg: ASbGncvXS8VGB/ACnq5k6m6zRfFn0JPtbSTAbJJGSN5iCk7AY8M8lOu+pjU8DMQbIBq
	AvH9ZoKvDsSECkXUTyRN4LLdjYh3P7f2HXUYMwwfnv8DS2mzOc22zGu9H/ubiN85PZtyn6SYqFX
	KxtmDTJcjZUx9/GUbAfqmjDr3WlWP9clfyudUizNDdGo9YZ19zSRqa2dBC7iKfl4qtP6toB37UQ
	R5sbrKsa1X+Sjsl/X1qsSTIwag2Hmbk67PO8q7hqNsXoZvIChJzHUyC3WeJ9b1sLylIwmY6W992
	klJOvpBEmsf2I7bh9TGcBJNFjBveEhINqBvNvahj4i7LHcoCDFDauAtR1yy62GPPWzx9XHM/dhu
	Eh0n424nzT8CZ8AQMYC7ZjG4MoQFgxHhcg7nZtj4XYvmOkc68w2+6
X-Received: by 2002:a05:620a:2619:b0:7d5:2332:2830 with SMTP id af79cd13be357-7e342b36709mr1514336485a.33.1752855234142;
        Fri, 18 Jul 2025 09:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJqhbUfsJcgskPt5gFSsEFmUoM869N3h4c6DWZdwSQ7WM+DzUs0Eyz4ta6GT222TI9nBDg8g==
X-Received: by 2002:a05:620a:2619:b0:7d5:2332:2830 with SMTP id af79cd13be357-7e342b36709mr1514330285a.33.1752855233571;
        Fri, 18 Jul 2025 09:13:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:43 +0300
Subject: [PATCH 5/8] arm64: dts: qcom: dts: switch to RPMPD_* indices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-5-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10548;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=J9J5s3ZT8qppRfzTVRn+3+0mDOD8laySW8Eg2GginiY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3KYawurHCbAYIJ0Q4CQdzPRjR8zEj37Kyy
 IF02mgP0yeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1WFXB/9ORH804iejkaKkwkJyKdgcA2PvTgOCFm9rVIEV9Tex05dxpfDyqTkADXOZ9Hxk9OJN1gM
 gpacrzEOlW2/YuuXI4eD+NPU1ArxXw3ETfF2LIC3yNpAXLgnzcYr7iS2D16nHHP033q37/lMRnC
 U5aHkgg6L5FtmXhagFD03m8Wwe7AUCCiXAcGRwRI3rcMFuq5BRLtHoa/2A3P/ythyyRr3qHoI31
 iD3+rf3rX5ruMaNuupHA/YbDY5Yp/veJe+I4aCmO2HvEsnyERAyMXR+xcUtXX+MkbeU2z+kc4CM
 HBd02eBtMBiio5t9lYHE7RydXk7dbrh+/mIIqrX+xA7ofLwt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a743f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Y3wYzle4tNZGDD-pgqsA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: ApO40ylRknaD48AH0WaFmlGycVKDT6ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOCBTYWx0ZWRfX0F7wWBV7ftPu
 oycAH9yU6l+68iguLqf8qAmLPV00BVy3XHY0zTpq0Ch8fj6RsTdm+utN9yUdIZ4dMmDMPVSsIEM
 ENwiqRoM55ViW4p1+fjw1WVbhetLgARwHwePaIkwKK9ZJMDF5PuckXDheV/h2TMZnSxljoOtIPC
 4fbCHlY7gk6XOa7ZVt0THxLb7wh7GI75m3VRs/derIgmf+CKfAGsmJ0rpUrzbxmjysi4VcSQVSL
 jDe/Fp7HpTtSWjQ3E7UNaYpaByG50goHfBA+UjSv5gQaTdBZtP/fWj63x0X5T9wZnJLKZYu2PvL
 L54NKwApyDg/RM1pkTcOiHdCr6mFLB717EVS6f0UASdyyPn2D+rYSbbWt//qksYWsbkX5Xa1RIN
 6MK59ZmfEeG6SmGi3ndx5UFBja8r1UMMN1V9Xb0Ah060QSIOQEa5WIzgZw6EO7sy90Bidfpf
X-Proofpoint-GUID: ApO40ylRknaD48AH0WaFmlGycVKDT6ks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=739 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180128

Use generic RPMPD_* defines for power domain instead of using
platform-specific defines.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8917.dtsi | 10 +++++-----
 arch/arm64/boot/dts/qcom/msm8976.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 12 ++++++------
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b50c7e6e0bfcd35ab4f8b84aeabe214fd60e8d7c..ca184ee3af065df0dfb3c7106d29360a860b8b36 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1943,8 +1943,8 @@ mpss: remoteproc@4080000 {
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8916_VDDCX>,
-					<&rpmpd MSM8916_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
@@ -2445,8 +2445,8 @@ wcnss: remoteproc@a204000 {
 					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8916_VDDCX>,
-					<&rpmpd MSM8916_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
index 8a642fce2e40d6d252a1cfbdfed602e6789ef09a..87dfc1e7e131cd4192ffbdd4913f934af17c5c88 100644
--- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
@@ -1070,7 +1070,7 @@ mdss_dsi0: dsi@1a94000 {
 				phys = <&mdss_dsi0_phy>;
 
 				operating-points-v2 = <&mdss_dsi0_opp_table>;
-				power-domains = <&rpmpd MSM8917_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1288,7 +1288,7 @@ sdhc_1: mmc@7824900 {
 			pinctrl-0 = <&sdc1_default>;
 			pinctrl-1 = <&sdc1_sleep>;
 			pinctrl-names = "default", "sleep";
-			power-domains = <&rpmpd MSM8917_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
 			mmc-ddr-1_8v;
@@ -1313,7 +1313,7 @@ sdhc_2: mmc@7864900 {
 			pinctrl-0 = <&sdc2_default>;
 			pinctrl-1 = <&sdc2_sleep>;
 			pinctrl-names = "default", "sleep";
-			power-domains = <&rpmpd MSM8917_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			bus-width = <4>;
 			status = "disabled";
 		};
@@ -1517,8 +1517,8 @@ wcnss: remoteproc@a204000 {
 					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8917_VDDCX>,
-					<&rpmpd MSM8917_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index f9962512f243d6c1af4931787f4602554c63bb39..80a0a09e055d79c5e56f89e5d67baf9971d87069 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1558,8 +1558,8 @@ wcnss: remoteproc@a204000 {
 					  "handover",
 					  "stop-ack";
 
-			power-domains = <&rpmpd MSM8976_VDDCX>,
-					<&rpmpd MSM8976_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0b0a9379cb05b01ebb17cef9fe7d22d56790efd3..2d7c45fec94e868b41a2b8d7acf8175a7b02c0b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1497,8 +1497,8 @@ remoteproc_mss: remoteproc@4080000 {
 
 			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
-			power-domains = <&rpmpd MSM8998_VDDCX>,
-					<&rpmpd MSM8998_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			status = "disabled";
@@ -1544,7 +1544,7 @@ adreno_gpu: gpu@5000000 {
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
 			iommus = <&adreno_smmu 0>;
 			operating-points-v2 = <&gpu_opp_table>;
-			power-domains = <&rpmpd MSM8998_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDMX>;
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
@@ -1680,7 +1680,7 @@ remoteproc_slpi: remoteproc@5800000 {
 			qcom,smem-states = <&slpi_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8998_SSCCX>;
+			power-domains = <&rpmpd RPMPD_SSCCX>;
 			power-domain-names = "ssc_cx";
 
 			status = "disabled";
@@ -2871,7 +2871,7 @@ mdss_mdp: display-controller@c901000 {
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmpd MSM8998_VDDMX>;
+				power-domains = <&rpmpd RPMPD_VDDMX>;
 
 				mdp_opp_table: opp-table {
 					compatible = "operating-points-v2";
@@ -2953,7 +2953,7 @@ mdss_dsi0: dsi@c994000 {
 							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd MSM8998_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
@@ -3029,7 +3029,7 @@ mdss_dsi1: dsi@c996000 {
 							 <&mdss_dsi1_phy DSI_PIXEL_PLL_CLK>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd MSM8998_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
@@ -3277,7 +3277,7 @@ remoteproc_adsp: remoteproc@17300000 {
 			qcom,smem-states = <&adsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8998_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8b1a45a4e56ed1ae02e5bb6e78ca6255d87add1c..412d7f7d6de67008c1f406ac5a73a51ff7f4f98d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1058,8 +1058,8 @@ remoteproc_mss: remoteproc@4080000 {
 
 			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
-			power-domains = <&rpmpd SDM660_VDDCX>,
-					<&rpmpd SDM660_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			memory-region = <&mba_region>, <&mpss_region>, <&mdata_mem>;
@@ -1096,7 +1096,7 @@ adreno_gpu: gpu@5000000 {
 				"rbcpr",
 				"core";
 
-			power-domains = <&rpmpd SDM660_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDMX>;
 			iommus = <&kgsl_smmu 0>;
 
 			nvmem-cells = <&gpu_speed_bin>;
@@ -1396,7 +1396,7 @@ sdhc_2: mmc@c084000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc2_state_on>;
 			pinctrl-1 = <&sdc2_state_off>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			status = "disabled";
 
@@ -1450,7 +1450,7 @@ sdhc_1: mmc@c0c4000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
 			pinctrl-1 = <&sdc1_state_off>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			bus-width = <8>;
 			non-removable;
@@ -1612,7 +1612,7 @@ mdp: display-controller@c901000 {
 						     "rotator-mem";
 				iommus = <&mmss_smmu 0>;
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmpd SDM660_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				ports {
 					#address-cells = <1>;
@@ -1664,7 +1664,7 @@ mdss_dsi0: dsi@c994000 {
 				reg-names = "dsi_ctrl";
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd SDM660_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <4>;
@@ -2280,7 +2280,7 @@ adsp_pil: remoteproc@15700000 {
 			clock-names = "xo";
 
 			memory-region = <&adsp_region>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			qcom,smem-states = <&adsp_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 8f2d65543373e70b48b4015478e21e8e74fd23c9..80c42dff5399b7c60576c2b6cf79afdbd8b9b1d4 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -724,7 +724,7 @@ sdhc_1: mmc@4744000 {
 			clock-names = "iface", "core", "xo";
 			iommus = <&apps_smmu 0x160 0x0>;
 
-			power-domains = <&rpmpd SM6125_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040873>;
@@ -755,7 +755,7 @@ sdhc_2: mmc@4784000 {
 			pinctrl-1 = <&sdc2_off_state>;
 			pinctrl-names = "default", "sleep";
 
-			power-domains = <&rpmpd SM6125_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040873>;
@@ -1275,7 +1275,7 @@ mdss_mdp: display-controller@5e01000 {
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmpd SM6125_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				ports {
 					#address-cells = <1>;
@@ -1345,7 +1345,7 @@ mdss_dsi0: dsi@5e94000 {
 							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd SM6125_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
@@ -1406,7 +1406,7 @@ mdss_dsi0_phy: phy@5e94400 {
 					      "ref";
 
 				required-opps = <&rpmpd_opp_nom>;
-				power-domains = <&rpmpd SM6125_VDDMX>;
+				power-domains = <&rpmpd RPMPD_VDDMX>;
 
 				status = "disabled";
 			};
@@ -1434,7 +1434,7 @@ dispcc: clock-controller@5f00000 {
 				      "gcc_disp_gpll0_div_clk_src";
 
 			required-opps = <&rpmpd_opp_ret>;
-			power-domains = <&rpmpd SM6125_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.39.5



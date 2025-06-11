Return-Path: <linux-pm+bounces-28479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B072AD539F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5EF3AD8BC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A9273D93;
	Wed, 11 Jun 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4cGoBcU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E325BF1C
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640587; cv=none; b=IvLUzWEAHhH199MbgqErSv0K2YsMj/uzW11KnCwCKhqStFwZLf0McDUmu0vnmPuZDP5MR5JDcwGk8A0bEkqUHm70slnxWPsVS5MqpPvzeEbV7285xMV3MdyYGpCTIamFZsMjUgw8Xdzc47Z9cBkrp3syZuieRR1bD7q9uKB483c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640587; c=relaxed/simple;
	bh=xuCoARRIycvnlpjtSpht+VThiMR7a/SohDoKqRPbgOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0lW5BRgJ5G1b4Hz7/bpCruT+5FrjzwXvud/IOrwTnJnpVaFZwnMWCDXTqmqdwDNUEvBk4ptfSdKmcL2p4R9C3LLaCVPF0DnyYZ3bxER9jxEkUdjrIbf2UmeDwmQz3CJKxP0cqI8ASfOvQKRfpeACVTm0xKoyxIPlh1zS7BCAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4cGoBcU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DoaZ026638
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1mTuadu9vEQPY2JNEOp+7iIzW/OVfrDJfnLsNvR6oY=; b=l4cGoBcUMc2w+k6q
	94oXsKe6H0ofaMQeEwNmCUKxs0JTRWy7MgtWtNC7LQMOQzLoP35OlOEddwLNVNua
	LLXq0QRdv9x6hOkwIhada6La6YsS97qZv8zssezKF8tODi5FFbpo7SdRb+NdEmhj
	dAEh5o3LyevWqcYYP28317LtDkiCv98FRkZSmaAmSyxJVOWGCBfwiiEurJr1GddD
	SmlUr1DOJtatEA+eGnbzE4IBfqqrGWV1qpCO2novmlEvscRnCOz8gE9OHyNOMRWc
	24mL1wTpu0zocFK17ZUPJ2LuHoH5iw6R7BX1cFVFf9d/HgZBEWieeeIBAUAmPjeW
	H3dJWQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2y7jpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7370e73f690so7711141b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 04:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640584; x=1750245384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1mTuadu9vEQPY2JNEOp+7iIzW/OVfrDJfnLsNvR6oY=;
        b=H+lpQpJ4EU/tOhZ2M3zXpxGgNr04bRgOTEB2NVAvqrrmnM26RGWVr8V32GIH9SzIge
         0s5Sjkk6RxU20A94+PBBHpbbpKevHR+tR+WXVwkvWdThUDiZ85mJj3qLJXEXgBNMBtTn
         G9MvxA9SWoUGjvuhs9y4Zh5nfP0TmO9KvSbXLjF7DAp0ooz1xug8KrBs9dpQ11/iRjb0
         Ww327Zt+ogbQBQBUd0P4xcRrAOJ9Yhq2I6/xQH8hZJ67MWkVCZaTAIEdPotuYDA7Q6HY
         8blaXH2M8jos8K1Wz3ZFQGYETiH3HyzAVSO/4D+5mSmgUp13vy0gp9g/KyRCq27WXzKz
         RGNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqW42jHhQRUKCBQtXh5hsUR2PG6aFPIgEqIAAQVTtvmL5TGFo5yAqWml9HjECaVr0SYORsKSwk7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9Sp9eHlBD0BpHRchBzITu+mNgYfQMbBVMy7DURm690znSHgE
	fdBxe7kTVtLW2NYulJ5cs4hta59ax9/d2nXKtwmv6MlVQ2BOZtZtgrh4M3n7ncGpVzAPM2uDFhb
	cqgingG9UTi1jjgnsrC4MHxlEiTRM5EeO2bfOyhfLQp86BCsF8Isbytdtqo9lgA==
X-Gm-Gg: ASbGncvEHnnq7eCQtCnjyILmuldFqjN39+H33+pO4rO+T9gmAMSOaExOYMDC4vM4x7O
	kG+wip4WQZNn9tggDRnXemx0zR8z+0ye4RcrCzdFEmGXsOnu/nK6d1SM/1za7WL1LbfmM+/e7sP
	p0t6Fm6vAgWjBhQ7R8bIsbsBe/sotO1IzrnGeZhQ3LF1PCDoWzlNS7Sl3OGiu7+rwcgjiJtwhom
	mxRkIBnuRuCVjF4+InCD1wIeUF7fYb0pE00HZy/1yCfrlG33oGp47t5/Vp+PjVlNbl/PZtDBahp
	uFuxtW4nNupBYNYoG6elobKITWJHyM9m
X-Received: by 2002:a05:6a00:cd0:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-7486ce18619mr4023740b3a.20.1749640583389;
        Wed, 11 Jun 2025 04:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGP76o/U3R36AYVd5ja9f6V1AiXn/VNLDR7vVtnNsh1JLfgCInvw13ZQN98n1A+o2dtgplzQ==
X-Received: by 2002:a05:6a00:cd0:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-7486ce18619mr4023697b3a.20.1749640582924;
        Wed, 11 Jun 2025 04:16:22 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d57sm8820772b3a.160.2025.06.11.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:16:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 16:45:34 +0530
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add GPU support to X1P42100 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-x1p-adreno-v2-4-5074907bebbd@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
In-Reply-To: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749640547; l=5718;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xuCoARRIycvnlpjtSpht+VThiMR7a/SohDoKqRPbgOY=;
 b=UMTfzq8FiqNsPn2/SX0+89dDo+MECO6N05n12Ur/ZdlD2OlNCN88i9nw4gHUDWVY+y5CRFIh/
 K21qmVooZJrD6Tk143u/2uGvqfiiSM8aryPHgPK6TiPCs3ul9Okz08W
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NiBTYWx0ZWRfX/sK1inLRUecu
 4H4H5tLoPsFKKKSeTJWO0D2DAgqNENB2DHoPuPYAMQ8kVsScJc4IXp3ZGuxnADYVkQ4yBLs8eWP
 PxNOIFfBWpXC9iP8+9bbCv5NKHaghiF+PcvZsexL9X1BAIuI1ZBFvHGyeOaut5ohjUVXd4olkcc
 u9Q4j8/z/gIGV7XOlunqC+XxTxim1LezGBDKEC+gn0HHPY7TjAdsTo6nVCJP5zNjiLmJoo852FT
 pdPo7IW1Y3SLWMkMTzupf1F70FDIQFulyJW1/bd7iZFPiMvpWMbg6izNVfq2hH6Dprad0V7fmbd
 p/ltBWRNcAJmmxzvALQyCEBAyyPnhu2FUJT+/XuFNJX1fVjnoHgG26OX5r+qUT9xEpB2sfG0wtn
 i6HSLWsD3KtNpJ/cAPk0AvC5PR2SIfcZa168uRH7EgVu8SHY4GwVWVgd136mY2sahRM28HRB
X-Proofpoint-GUID: 62MFNKP7cDHDhkxxpRXW6kZtzATpNmmX
X-Proofpoint-ORIG-GUID: 62MFNKP7cDHDhkxxpRXW6kZtzATpNmmX
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=68496588 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=VoI47dy04w1U0DMRdPAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=831 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110096

X1P42100 SoC has a new GPU called Adreno X1-45 which is a smaller
version of Adreno X1-85 GPU. Describe this new GPU and also add
the secure gpu firmware path that should used for X1P42100 CRD.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    |   7 ++
 arch/arm64/boot/dts/qcom/x1p42100-crd.dts |   4 +
 arch/arm64/boot/dts/qcom/x1p42100.dtsi    | 120 +++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a8eb4c5fe99fe6dd49af200a738b6476d87279b2..558d7d387d7710770244fcc901f461384dd9b0d4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -8245,6 +8245,13 @@ sbsa_watchdog: watchdog@1c840000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,x1e80100-qfprom", "qcom,qfprom";
+			reg = <0 0x221c8000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		pmu@24091000 {
 			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
 			reg = <0 0x24091000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts b/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
index cf07860a63e97c388909fb5721ae7b9729b6c586..cf999c2cf8d4e0af83078253fd39ece3a0c26a49 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
@@ -15,3 +15,7 @@ / {
 	model = "Qualcomm Technologies, Inc. X1P42100 CRD";
 	compatible = "qcom,x1p42100-crd", "qcom,x1p42100";
 };
+
+&gpu_zap_shader {
+	firmware-name = "qcom/x1p42100/gen71500_zap.mbn";
+};
diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
index 27f479010bc330eb6445269a1c46bf78ec6f1bd4..807db5a079394442596939847e0e6aef4b0525a1 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
@@ -17,15 +17,124 @@
 /delete-node/ &cpu_pd9;
 /delete-node/ &cpu_pd10;
 /delete-node/ &cpu_pd11;
+/delete-node/ &gpu_opp_table;
 /delete-node/ &pcie3_phy;
 
 &gcc {
 	compatible = "qcom,x1p42100-gcc", "qcom,x1e80100-gcc";
 };
 
-/* The GPU is physically different and will be brought up later */
+&gmu {
+	compatible = "qcom,adreno-gmu-x145.0", "qcom,adreno-gmu";
+};
+
 &gpu {
-	/delete-property/ compatible;
+	compatible = "qcom,adreno-43030c00", "qcom,adreno";
+
+	nvmem-cells = <&gpu_speed_bin>;
+	nvmem-cell-names = "speed_bin";
+
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2-adreno", "operating-points-v2";
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+			opp-peak-kBps = <16500000>;
+			qcom,opp-acd-level = <0xa8295ffd>;
+			opp-supported-hw = <0x3>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+			opp-peak-kBps = <16500000>;
+			qcom,opp-acd-level = <0x882a5ffd>;
+			opp-supported-hw = <0x7>;
+		};
+
+		opp-1107000000 {
+			opp-hz = /bits/ 64 <1107000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+			opp-peak-kBps = <16500000>;
+			qcom,opp-acd-level = <0x882a5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		opp-1014000000 {
+			opp-hz = /bits/ 64 <1014000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+			opp-peak-kBps = <14398438>;
+			qcom,opp-acd-level = <0xa82a5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		opp-940000000 {
+			opp-hz = /bits/ 64 <940000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+			opp-peak-kBps = <14398438>;
+			qcom,opp-acd-level = <0xa82a5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		opp-825000000 {
+			opp-hz = /bits/ 64 <825000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+			opp-peak-kBps = <12449219>;
+			qcom,opp-acd-level = <0x882b5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+			opp-peak-kBps = <10687500>;
+			qcom,opp-acd-level = <0xa82c5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		opp-666000000-0 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+			opp-peak-kBps = <8171875>;
+			qcom,opp-acd-level = <0xa82d5ffd>;
+			opp-supported-hw = <0xf>;
+		};
+
+		/* Only applicable for SKUs which has 666Mhz as Fmax */
+		opp-666000000-1 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+			opp-peak-kBps = <16500000>;
+			qcom,opp-acd-level = <0xa82d5ffd>;
+			opp-supported-hw = <0x10>;
+		};
+
+		opp-550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+			opp-peak-kBps = <6074219>;
+			qcom,opp-acd-level = <0x882e5ffd>;
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-380000000 {
+			opp-hz = /bits/ 64 <380000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+			opp-peak-kBps = <3000000>;
+			qcom,opp-acd-level = <0xc82f5ffd>;
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-280000000 {
+			opp-hz = /bits/ 64 <280000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+			opp-peak-kBps = <2136719>;
+			qcom,opp-acd-level = <0xc82f5ffd>;
+			opp-supported-hw = <0x1f>;
+		};
+	};
+
 };
 
 &gpucc {
@@ -41,6 +150,13 @@ &pcie6a_phy {
 	compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy";
 };
 
+&qfprom {
+	gpu_speed_bin: gpu_speed_bin@119 {
+		reg = <0x119 0x2>;
+		bits = <7 9>;
+	};
+};
+
 &soc {
 	/* The PCIe3 PHY on X1P42100 uses a different IP block */
 	pcie3_phy: phy@1bd4000 {

-- 
2.48.1


